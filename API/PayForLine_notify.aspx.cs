using BaseClass.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaseClass;

public partial class API_PayForLine_notify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string postStr = "";
        TXT_Help th = new TXT_Help();

        if (Request.HttpMethod.ToLower() == "post")
        {
            Stream s = System.Web.HttpContext.Current.Request.InputStream;
            byte[] b = new byte[s.Length];
            s.Read(b, 0, (int)s.Length);
            postStr = Encoding.UTF8.GetString(b);

            XmlHelp xh = new XmlHelp();
            SortedDictionary<string, string> sParams = xh.GetInfoFromXml(postStr);
            try
            {
                if (sParams["return_code"].ToString() == "SUCCESS")
                {
                    BaseClass.Dal.ChongzhiLog sl = new BaseClass.Dal.ChongzhiLog();
                    bool isOrderValid = sl.CZisok(sParams["out_trade_no"].ToString(), sParams["openid"].ToString());
                    BaseClass.Common.LoggerUtil.printLog("订单:" + sParams["out_trade_no"].ToString() + "处理状态：" + isOrderValid);
                    if (isOrderValid)
                    {
                        string mid = sParams["openid"].ToString();
                        decimal money = decimal.Parse(sParams["cash_fee"].ToString()) / 100;
                        LVWEIBA.DAL.order_list oodd = new LVWEIBA.DAL.order_list();
                        LVWEIBA.Model.order_list oom = oodd.GetModel(sParams["out_trade_no"].ToString());
                        //正式状态
                        oom.order_zt = "DCX";
                        oodd.Update(oom);
                        //发送短信通知用户和商户
                        var orderMx = new LVWEIBA.DAL.order_Mx().GetModel(sParams["out_trade_no"].ToString());
                        var member = new LVWEIBA.BLL.MemberInfo().GetModel(mid);
                        //发送短信通知用户和商户(判断是门票还是尾单)
                        if (orderMx.ProType != null && (orderMx.ProType.Equals("DZP") || orderMx.ProType.Equals("ZZP")))
                        {
                            var bll = new LVWEIBA.DAL.ProviderSpot();
                            LVWEIBA.Model.ProviderSpot providerSpot = bll.GetModel(int.Parse(orderMx.productNum));
                            LVWEIBA.MessageService.NotifyUsersTicket(member.Tel, providerSpot.MasterTel,orderMx);
                            providerSpot.Num = providerSpot.Num - orderMx.ProCount;
                            bll.Update(providerSpot);
                            BaseClass.Common.LoggerUtil.printLog("修改余量： productNum is:" + orderMx.productNum + "TicketCount is:" + providerSpot.Num);

                        }
                        else
                        {
                            LVWEIBA.Model.LvULines lvModel = new LVWEIBA.DAL.LvULines().GetModel(orderMx.productNum);
                            LVWEIBA.MessageService.NotifyUsers(member.Tel, lvModel.LineMasterMoble,orderMx);
                            //修改线路余量
                            LVWEIBA.BLL.LvULines lvubLL = new LVWEIBA.BLL.LvULines();
                            if (lvModel != null)
                            {
                                lvModel.adultTicketCount = lvModel.adultTicketCount - orderMx.adultCount;
                                lvModel.puppyTicketCount = lvModel.puppyTicketCount - orderMx.puppyCount;
                                lvubLL.Update(lvModel);
                                BaseClass.Common.LoggerUtil.printLog("修改余量： productNum is:" + orderMx.productNum + "adultTicketCount is:" + lvModel.adultTicketCount + "puppyTicketCount is:" + lvModel.puppyTicketCount);
                            }
                        }
                        //返回成功
                        Response.Write(returnOKMessage());

                    }
                    else
                    {

                        th.ReFreshTXT(postStr, "D:\\msg\\zhifuErr\\", "错误CZ" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");
                        Response.Write(returnFailMessage());
                    }
                }
                else
                {
                    //一系列还原操作
                    moneyUnFreeze(sParams["out_trade_no"].ToString(), sParams["openid"].ToString());
                    couponUnUse(sParams["out_trade_no"].ToString());
                    Response.Write(returnFailMessage());
                }
            }
            catch (Exception ex)
            {
                BaseClass.Common.LoggerUtil.printLog("订单"+ sParams["out_trade_no"].ToString()+"处理错误，"+"ex:"+ex.Message+ex.StackTrace);
                //一系列还原操作
                moneyUnFreeze(sParams["out_trade_no"].ToString(), sParams["openid"].ToString());
                couponUnUse(sParams["out_trade_no"].ToString());
                Response.Write(returnFailMessage());
            }
        }
    }
    public string returnOKMessage()
    {
        string xml = @"<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
        return xml;
    }
    public string returnFailMessage()
    {
        string xml = @"<xml><return_code><![CDATA[FAIL]]></return_code><return_msg></return_msg></xml>";
        return xml;
    }
    public void couponUnUse(string orderId) {
        LVWEIBA.DAL.MemberCoupon DalCoupon = new LVWEIBA.DAL.MemberCoupon();
        LVWEIBA.Model.MemberCoupon couponModel = DalCoupon.GetModel(" Order_Id='" + orderId + "'");
        //是否使用了优惠券
        if (couponModel != null) {
            couponModel.Order_Id = "";
            couponModel.ZT = "0";
            DalCoupon.Update(couponModel);
        }
    }
    public void moneyUnFreeze(string orderId, string openId)
    {
        LVWEIBA.DAL.MemberMoney DalMoney = new LVWEIBA.DAL.MemberMoney();
        LVWEIBA.Model.MemberMoney moneyModel = DalMoney.GetModel(" Bz='" + orderId + "'");
        //是否使用了余额
        if (moneyModel != null)
        {
            LVWEIBA.Model.MemberList model = new LVWEIBA.Model.MemberList();
            LVWEIBA.BLL.MemberList bll = new LVWEIBA.BLL.MemberList();
            bool isOK = false;

            if (bll.Exists(openId))
            {
                model = bll.GetModel(openId);
                model.Money = model.Money - moneyModel.Money;
                isOK = bll.Update(model);
                //删除MemberMoney
                DalMoney.Delete(moneyModel.Id);
            }
        }
    }
    private void WriteContent(string str)
    {
        Response.Output.Write(str);
    }
}
using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
using System.Collections.Generic;
using Com.Alipay;
using System.IO;

/// <summary>
/// 功能：页面跳转同步通知页面
/// 版本：3.3
/// 日期：2012-07-10
/// 说明：
/// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
/// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
/// 
/// ///////////////////////页面功能说明///////////////////////
/// 该页面可在本机电脑测试
/// 可放入HTML等美化页面的代码、商户业务逻辑程序代码
/// 该页面可以使用ASP.NET开发工具调试，也可以使用写文本函数LogResult进行调试
/// </summary>
public partial class return_url : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SortedDictionary<string, string> sPara = GetRequestGet();

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            // bool verifyResult = aliNotify.Verify(sPara, Request.QueryString["notify_id"], Request.QueryString["sign"]);
            bool verifyResult = true;
            if (verifyResult)//验证成功
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码
               

                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表

                //商户订单号

                string out_trade_no = Request.QueryString["out_trade_no"];

                //支付宝交易号

                string trade_no = Request.QueryString["trade_no"];

                //交易状态
                string trade_status = Request.QueryString["trade_status"];
                string openId = Request.QueryString["body"];
                //总额
                string total_fee = Request.QueryString["total_fee"];
                if (Request.QueryString["trade_status"] == "TRADE_FINISHED" || Request.QueryString["trade_status"] == "TRADE_SUCCESS")
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序
                    try
                    {
                        BaseClass.Dal.ChongzhiLog sl = new BaseClass.Dal.ChongzhiLog();
                        bool isOrderValid = sl.CZisok(out_trade_no, openId);
                        log4netHelper.WriteDebugLog(typeof(return_url), "订单notify", "订单号:" + out_trade_no + "处理状态：" + isOrderValid);
                        LVWEIBA.DAL.order_list oodd = new LVWEIBA.DAL.order_list();
                        LVWEIBA.Model.order_list order = oodd.GetModel(out_trade_no);

                        var isOrder = order != null && order.user_id == openId;
                        if (isOrderValid|| isOrder)
                        {
                            string mid = openId;
                            decimal money = decimal.Parse(total_fee) / 100;
                           
                            LVWEIBA.Model.order_list oom = oodd.GetModel(out_trade_no);
                            //正式状态
                            oom.order_zt = "DCX";
                            oodd.Update(oom);
                            //发送短信通知用户和商户
                            var orderMx = new LVWEIBA.DAL.order_Mx().GetModel(out_trade_no);
                            var member = new LVWEIBA.BLL.MemberInfo().GetModel(mid);
                            //发送短信通知用户和商户(判断是门票还是尾单)
                            if (orderMx.ProType != null && (orderMx.ProType.Equals("DZP") || orderMx.ProType.Equals("ZZP")))
                            {
                                var bll = new LVWEIBA.DAL.ProviderSpot();
                                LVWEIBA.Model.ProviderSpot providerSpot = bll.GetModel(int.Parse(orderMx.productNum));
                                LVWEIBA.MessageService.NotifyUsersTicket(member.Tel, providerSpot.MasterTel, orderMx);
                                providerSpot.Num = providerSpot.Num - orderMx.ProCount;
                                bll.Update(providerSpot);
                                log4netHelper.WriteDebugLog(typeof(return_url), "订单return", "修改余量： productNum is:" + orderMx.productNum + "TicketCount is:" + providerSpot.Num);

                            }
                            else
                            {
                                LVWEIBA.Model.LvULines lvModel = new LVWEIBA.DAL.LvULines().GetModel(orderMx.productNum);
                                LVWEIBA.MessageService.NotifyUsers(member.Tel, lvModel.LineMasterMoble, orderMx);
                                //修改线路余量
                                LVWEIBA.BLL.LvULines lvubLL = new LVWEIBA.BLL.LvULines();
                                if (lvModel != null)
                                {
                                    lvModel.adultTicketCount = lvModel.adultTicketCount - orderMx.adultCount;
                                    lvModel.puppyTicketCount = lvModel.puppyTicketCount - orderMx.puppyCount;
                                    lvubLL.Update(lvModel);
                                    log4netHelper.WriteDebugLog(typeof(return_url), "订单return", "修改余量： productNum is:" + orderMx.productNum);
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                        moneyUnFreeze(out_trade_no, openId);
                        couponUnUse(out_trade_no);
                    }

                    Response.Redirect("http://wx.lvwei8.com/index/indent_show.aspx?order_id=" + out_trade_no);
                }
                else
                {
                    Response.Write("trade_status=" + Request.QueryString["trade_status"]);
                }
                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else//验证失败
            {
                Response.Write("验证失败");
            }
        }
        else
        {
            Response.Write("无返回参数");
        }
    }

    /// <summary>
    /// 优惠券回滚
    /// </summary>
    /// <param name="orderId"></param>
    public void couponUnUse(string orderId)
    {
        LVWEIBA.DAL.MemberCoupon DalCoupon = new LVWEIBA.DAL.MemberCoupon();
        LVWEIBA.Model.MemberCoupon couponModel = DalCoupon.GetModel(" Order_Id='" + orderId + "'");
        //是否使用了优惠券
        if (couponModel != null)
        {
            couponModel.Order_Id = "";
            couponModel.ZT = "0";
            DalCoupon.Update(couponModel);
        }
    }
    /// <summary>
    /// 余额回滚
    /// </summary>
    /// <param name="orderId"></param>
    /// <param name="openId"></param>
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

    /// <summary>
    /// 获取支付宝GET过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public SortedDictionary<string, string> GetRequestGet()
    {
        int i = 0;
        SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = Request.QueryString;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], Request.QueryString[requestItem[i]]);
        }

        return sArray;
    }
}


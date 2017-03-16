<%@ WebHandler Language="C#" Class="direct_pay" %>

using System;
using System.Web;
using System.IO;


public class direct_pay : IHttpHandler
{

    protected int rep = 0;

    public void ProcessRequest(HttpContext context)
    {
        string openid = context.Request.Form["openid"].Trim();
        string HostAddress = context.Request.Form["HostAddress"].Trim();
        string jinbi = context.Request.Form["jinbi"].Trim();
        string fee = context.Request.Form["feee"].Trim();
        string orderId = context.Request.Form["orderid"].Trim();
        printLog("orderid is:" + orderId);
        //new added
        string couponId = context.Request.Form["couponid"].Trim();
        string useMoneyLeft = context.Request.Form["usemoneyleft"].Trim();

        //string OrderID = "Pay" + DateTime.Now.ToString("yyMMddHHmmssffff") + GenerateCheckCode(3);

        BaseClass.Model.ChongzhiLog ll = new BaseClass.Model.ChongzhiLog();
        ll.isok = 0;
        ll.jinbi = int.Parse(jinbi);
        ll.jine = int.Parse(fee);
        ll.optime = DateTime.Now;
        ll.openid = openid;
        ll.orderid = orderId;
        ll.oktime = DateTime.Now;
        int s = new BaseClass.Dal.ChongzhiLog().Add(ll);

        //使用优惠券(加入订单号)
        if (couponId != "0")
        {
            LVWEIBA.BLL.MemberCoupon coupon = new LVWEIBA.BLL.MemberCoupon();
            int id = int.Parse(couponId);
            LVWEIBA.Model.MemberCoupon couponModel = coupon.GetModel(id);
            couponModel.Order_Id = orderId;
            couponModel.ZT = "1";//变为已使用
            coupon.Update(couponModel);
        }
        //冻结
        moneyFreeze(useMoneyLeft, orderId, openid);

        //返回结果
        string res = "{";
        //走到这一步，送积分
        BaseClass.Dal.ChongzhiLog sl = new BaseClass.Dal.ChongzhiLog();
        try
        {
            if (sl.CZisok(orderId, openid))
            {
                LVWEIBA.DAL.order_list oodd = new LVWEIBA.DAL.order_list();
                LVWEIBA.Model.order_list oom = oodd.GetModel(orderId);
                oom.order_zt = "DCX";
                oodd.Update(oom);
                res += "\"code\":\"" + 0 + "\",";
                res += "\"data\":\"" + "支付成功" + "\"}";
                var orderMx = new LVWEIBA.DAL.order_Mx().GetModel(orderId);
                var member = new LVWEIBA.BLL.MemberInfo().GetModel(openid);
                //发送短信通知用户和商户(判断是门票还是尾单)
                if (!String.IsNullOrEmpty(orderMx.ProType) && (orderMx.ProType.Equals("DZP")|| orderMx.ProType.Equals("ZZP")))
                {
                    var bll = new LVWEIBA.DAL.ProviderSpot();
                    LVWEIBA.Model.ProviderSpot providerSpot = bll.GetModel(int.Parse(orderMx.productNum));
                    LVWEIBA.MessageService.NotifyUsers(member.Tel, providerSpot.MasterTel,orderMx);
                    providerSpot.Num = providerSpot.Num - orderMx.ProCount;
                    bll.Update(providerSpot);
                    printLog("修改余量： productNum is:" + orderMx.productNum + "TicketCount is:" + providerSpot.Num);

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
                        printLog("修改余量： productNum is:" + orderMx.productNum + "adultTicketCount is:" + lvModel.adultTicketCount + "puppyTicketCount is:" + lvModel.puppyTicketCount);
                    }
                }
            }
            else
            {
                //一系列还原操作
                moneyUnFreeze(orderId, openid);
                couponUnUse(orderId);
                res += "\"code\":\"" + -1 + "\",";
                res += "\"data\":\"" + "支付失败" + "\"}";
            }
        }
        catch (Exception ex)
        {
            res = "";
            //一系列还原操作
            moneyUnFreeze(orderId, openid);
            couponUnUse(orderId);
            printLog(ex.Message + ex.StackTrace);
            res += "\"code\":\"" + -1 + "\",";
            res += "\"data\":\"" + "支付失败" + "\"}";
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write(res);
    }


    public void printLog(string content) {

        string FilePath = HttpRuntime.BinDirectory.ToString();
        string FileName = FilePath + "日志" + "\\" + System.DateTime.Now.ToString("yyyyMMdd") + ".txt";
        //判断有无当天txt文档，没有则创建
        if (!File.Exists(FileName))
        {
            //创建日志文件夹
            Directory.CreateDirectory(FilePath + "日志");
            StreamWriter sw = File.CreateText(FileName);
            sw.Close();
        }
        File.AppendAllText(FileName, content + "\r\n");
    }
    public void moneyFreeze(string useMoneyLeft, string orderId, string openId)
    {
        //使用了余额
        if (useMoneyLeft != null && useMoneyLeft != "")
        {
            decimal money = decimal.Parse(useMoneyLeft);
            LVWEIBA.Model.MemberMoney modelMoney = new LVWEIBA.Model.MemberMoney();
            LVWEIBA.BLL.MemberMoney bllMoney = new LVWEIBA.BLL.MemberMoney();
            modelMoney.MemberID = openId;
            modelMoney.Money = -money;
            modelMoney.Method = "3";//微信充值
            modelMoney.Bz = orderId;
            modelMoney.Sj = DateTime.Now;
            bool isOKM = false;
            isOKM = bllMoney.Add(modelMoney);

            bool isOK = false;
            LVWEIBA.Model.MemberList model = new LVWEIBA.Model.MemberList();
            LVWEIBA.BLL.MemberList bll = new LVWEIBA.BLL.MemberList();
            if (bll.Exists(openId))
            {
                model = bll.GetModel(openId);
                model.Money = model.Money - money;
                isOK = bll.Update(model);
            }
            else
            {
                model.MemberId = openId;
                model.Money = money;
                isOK = bll.Add(model);
            }
        }
    }

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

    /// 
    /// 生成随机字母字符串(数字字母混和)
    /// 待生成的位数
    /// 生成的字母字符串
    private string GenerateCheckCode(int codeCount)
    {
        string str = string.Empty;
        long num2 = DateTime.Now.Ticks + rep;
        rep++;
        Random random = new Random(((int)(((ulong)num2) & 0xffffffffL)) | ((int)(num2 >> this.rep)));
        for (int i = 0; i < codeCount; i++)
        {
            char ch;
            int num = random.Next();
            if ((num % 2) == 0)
            {
                ch = (char)(0x30 + ((ushort)(num % 10)));
            }
            else
            {
                ch = (char)(0x41 + ((ushort)(num % 0x1a)));
            }
            str = str + ch.ToString();
        }
        return str;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
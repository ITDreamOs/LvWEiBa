<%@ WebHandler Language="C#" Class="indent_pay" %>

using System;
using System.Web;
using tenpay;
using System.Configuration;
using System.IO;

public class indent_pay : IHttpHandler
{
    protected int rep = 0;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            printLog("进入indent_pay.ashx");
            string appId = WeixinApiClass.GetWeiXinInf.appid;
            string timeStamp = "";
            string nonceStr = "";
            string prepay_id = "";
            string paySign = "";
            string openid = context.Request.Form["openid"].Trim();
            string HostAddress = context.Request.Form["HostAddress"].Trim();
            string fee = context.Request.Form["feee"].Trim();
            string jinbi = context.Request.Form["jinbi"].Trim();
            string orderId = context.Request.Form["orderid"].Trim();
            printLog("orderid is:" + orderId);
            //new added
            string couponId = context.Request.Form["couponid"].Trim();
            string useMoneyLeft = context.Request.Form["usemoneyleft"].Trim();

            //string openid = "oOJI2s5NCHFzmyh_tciljaK4VTqw";
            //string HostAddress = "183.202.114.120";
            //string fee = "10";

            //string res = openid + "," + HostAddress + "," + fee;
            //准备支付请求信息
            TenpayUtil tenpay = new TenpayUtil();
            string paySignKey = ConfigurationManager.AppSettings["paySignKey"].ToString();
            string AppSecret = ConfigurationManager.AppSettings["AppSecret"].ToString();
            string mch_id = ConfigurationManager.AppSettings["mch_id"].ToString();
            appId = ConfigurationManager.AppSettings["AppId"].ToString();


            //paySign = paySignKey;
            timeStamp = TenpayUtil.getTimestamp();
            nonceStr = TenpayUtil.getNoncestr();
            //OrderID = "Pay" + DateTime.Now.ToString("yyMMddHHmmssffff") + GenerateCheckCode(3);

            UnifiedOrder order = new UnifiedOrder();
            order.appid = appId;
            order.attach = "vinson";
            order.body = "订单支付！";
            order.device_info = "";
            order.mch_id = mch_id;
            order.nonce_str = TenpayUtil.getNoncestr();
            order.notify_url = "http://wx.lvwei8.com/api/PayForLine_notify.aspx";
            order.openid = openid;
            order.out_trade_no = orderId;//订单号不可以为空，一定要合理
            order.trade_type = "JSAPI";
            order.spbill_create_ip = HostAddress;
            order.total_fee = int.Parse(fee);
            prepay_id = tenpay.getPrepay_id(order, paySignKey);


            System.Collections.Generic.SortedDictionary<string, string> sParams = new System.Collections.Generic.SortedDictionary<string, string>();
            sParams.Add("appId", appId);
            sParams.Add("timeStamp", timeStamp);
            sParams.Add("nonceStr", nonceStr);
            sParams.Add("package", "prepay_id=" + prepay_id);
            sParams.Add("signType", "MD5");
            paySign = tenpay.getsign(sParams, paySignKey);
            string res = "{";
            res += "\"appId\":\"" + appId + "\",";
            res += "\"timeStamp\":\"" + timeStamp + "\",";
            res += "\"nonceStr\":\"" + nonceStr + "\",";
            res += "\"prepay_id\":\"" + prepay_id + "\",";
            res += "\"paySign\":\"" + paySign + "\",";
            res += "\"OrderID\":\"" + orderId + "\"";
            res += "}";

            BaseClass.Model.ChongzhiLog ll = new BaseClass.Model.ChongzhiLog();
            ll.isok = 0;
            ll.jinbi = int.Parse(jinbi);
            ll.jine = order.total_fee;
            ll.optime = DateTime.Now;
            ll.openid = openid;
            ll.orderid = orderId;
            ll.oktime = DateTime.Now;
            int s = new BaseClass.Dal.ChongzhiLog().Add(ll);

            //冻结余额
            moneyFreeze(useMoneyLeft, orderId, openid);

          
            //使用优惠券(加入订单号)
            if (couponId != "0") {
                LVWEIBA.BLL.MemberCoupon coupon = new LVWEIBA.BLL.MemberCoupon();
                int id = int.Parse(couponId);
                LVWEIBA.Model.MemberCoupon couponModel= coupon.GetModel(id);
                couponModel.Order_Id = orderId;
                couponModel.ZT = "1";//变为已使用
                coupon.Update(couponModel);
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(res);
        }
        catch (Exception ex)
        {
            printLog("indent_pay.ashx error,error is:"+ex.Message+ex.StackTrace);
            throw;
        }

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

    public void moneyFreeze(string useMoneyLeft,string orderId,string openId) {
        //使用了余额
        if (useMoneyLeft != null&&useMoneyLeft!="")
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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    /// 
    /// 生成随机字母字符串(数字字母混和)
    /// 
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
}
<%@ WebHandler Language="C#" Class="chongzhi" %>

using System;
using System.Web;
using tenpay;
using System.Configuration;

public class chongzhi : IHttpHandler
{
    protected int rep = 0;

    public void ProcessRequest(HttpContext context)
    {

        string appId = WeixinApiClass.GetWeiXinInf.appid;
        string timeStamp = "";
        string nonceStr = "";
        string prepay_id = "";
        string paySign = "";
        string OrderID = "";
        string openid = context.Request.Form["openid"].Trim();
        string HostAddress = context.Request.Form["HostAddress"].Trim();
        string fee = context.Request.Form["feee"].Trim();
        string jinbi = context.Request.Form["jinbi"].Trim();

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
        OrderID = "Cz" + DateTime.Now.ToString("yyMMddHHmmssffff") + GenerateCheckCode(3);

        UnifiedOrder order = new UnifiedOrder();
        order.appid = appId;
        order.attach = "vinson";
        order.body = "会员充值！";
        order.device_info = "";
        order.mch_id = mch_id;
        order.nonce_str = TenpayUtil.getNoncestr();
        order.notify_url = "http://wx.lvwei8.com/api/Chongzhi_notify.aspx";
        order.openid = openid;
        order.out_trade_no = OrderID;//订单号不可以为空，一定要合理
        order.trade_type = "JSAPI";
        order.spbill_create_ip = HostAddress;
        order.total_fee = int.Parse(fee)*100;
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
        res += "\"OrderID\":\"" + OrderID + "\"";
        res += "}";

        BaseClass.Model.ChongzhiLog ll = new BaseClass.Model.ChongzhiLog();
        ll.isok = 0;
        ll.jinbi = int.Parse(jinbi);
        ll.jine = order.total_fee;
        ll.optime = DateTime.Now;
        ll.openid = openid;
        ll.orderid = OrderID;
        ll.oktime = DateTime.Now;
        int s = new BaseClass.Dal.ChongzhiLog().Add(ll);

        context.Response.ContentType = "text/plain";

        context.Response.Write(res);
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
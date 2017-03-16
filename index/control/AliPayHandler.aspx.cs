using Com.Alipay;
using LVWEIBA.Model;
using System;
using System.Collections.Generic;
public partial class index_control_AliPayHandler : System.Web.UI.Page
{
    string openId;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        if (userInfo.openId == null || userInfo.openId == "")
        {
            openId = userInfo.mobile;
        }
        else
        {
            openId = userInfo.openId;
        }
        //商户订单号，商户网站订单系统中唯一订单号，必填
        string out_trade_no = Request.QueryString["orderid"].Trim();

        //付款金额，必填
        string total_fee = Request.QueryString["feee"].Trim();

        //收银台页面上，商品展示的超链接，必填
        string show_url = "http://lvwei8.com/index/showline.aspx?code=160928113527452356B&lineid=656";

        //商品描述，可空
        string jinbi = Request.QueryString["jinbi"].Trim();
        string couponId = Request.QueryString["couponid"].Trim();
        string useMoneyLeft = Request.QueryString["usemoneyleft"].Trim();


        Response.ContentType = "text/html;charset=utf-8";
        moneyFreeze(useMoneyLeft, out_trade_no, openId);
        //使用优惠券(加入订单号)
        if (couponId != "0")
        {
            LVWEIBA.BLL.MemberCoupon coupon = new LVWEIBA.BLL.MemberCoupon();
            int id = int.Parse(couponId);
            LVWEIBA.Model.MemberCoupon couponModel = coupon.GetModel(id);
            couponModel.Order_Id = out_trade_no;
            couponModel.ZT = "1";//变为已使用
            coupon.Update(couponModel);
        }
        try
        {
            //把请求参数打包成数组
            SortedDictionary<string, string> sParaTemp = new SortedDictionary<string, string>();
            sParaTemp.Add("partner", Config.partner);
            sParaTemp.Add("seller_id", Config.seller_id);
            sParaTemp.Add("_input_charset", Config.input_charset.ToLower());
            sParaTemp.Add("service", Config.service);
            sParaTemp.Add("payment_type", Config.payment_type);
            sParaTemp.Add("notify_url", Config.notify_url);
            sParaTemp.Add("return_url", Config.return_url);
            sParaTemp.Add("out_trade_no", out_trade_no);
            sParaTemp.Add("subject", "驴尾巴商品");
            sParaTemp.Add("total_fee", total_fee);
            sParaTemp.Add("show_url", show_url);
            //sParaTemp.Add("app_pay","Y");//启用此参数可唤起钱包APP支付。
            sParaTemp.Add("body", openId);
            //其他业务参数根据在线开发文档，添加参数.文档地址:https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.2Z6TSk&treeId=60&articleId=103693&docType=1
            //如sParaTemp.Add("参数名","参数值");
            //建立请求
            log4netHelper.WriteDebugLog(typeof(index_control_AliPayHandler), "index_control_AliPayHandler", "orderid is:" + out_trade_no + "total_fee:" + total_fee + "paramters: " + sParaTemp.ToString());
            submitLit.Text = Submit.BuildRequest(sParaTemp, "get", "确认");
        }
        catch (Exception ex)
        {
            log4netHelper.WriteExceptionLog(typeof(index_control_AliPayHandler), "index_control_AliPayHandler Error", ex);
        }
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
}
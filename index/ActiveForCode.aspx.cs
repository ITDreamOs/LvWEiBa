using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_ActiveForCode : System.Web.UI.Page
{
    protected string openid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string actionStr = Request.QueryString["act"];
        if (Session["openid"] == null)
        {

            if (string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/ActiveForCode?act=" + actionStr);

            }

            else
            {
                string code = Request.QueryString["code"];
                openid = new WEIxinUserApi().GetUserOpenid(code);

                if (openid.Length < 10)
                {
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/ActiveForCode?act=" + actionStr);
                }
            }

            Session["openid"] = openid;
        }
        else
        {
            openid = Session["openid"].ToString();
        }

        if (actionStr == "A1" || actionStr == "B1" || actionStr == "C1") {
            Response.Redirect("http://wx.lvwei8.com/index/CouponForNinety.aspx");
        }
        if (actionStr == "A2" || actionStr == "B2" || actionStr == "C2") {
            Response.Redirect("http://wx.lvwei8.com/index/CouponForTwoHundred.aspx");
        }
        if (actionStr == "A3" || actionStr == "B3" || actionStr == "C3")
        {
            Response.Redirect("http://wx.lvwei8.com/index/CouponForSixHundred.aspx");
        }
        if (actionStr == "A4" || actionStr == "B4" || actionStr == "C4")
        {
            Response.Redirect("http://wx.lvwei8.com/index/CouponForOneThousand.aspx");
        }

    }
}
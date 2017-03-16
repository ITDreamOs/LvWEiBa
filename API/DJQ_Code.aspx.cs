using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class API_DJQ_Code : System.Web.UI.Page
{
    protected string openid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["openid"] == null)
        {
            if (string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/api/DJQ_Code.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");

            }

            else
            {
                string code = Request.QueryString["code"];
                openid = new WEIxinUserApi().GetUserOpenid(code);
                Session["openid"] = openid;

                if (openid.Length < 10)
                {
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/api/DJQ_Code.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
                }
                else
                {
                }

            }


            Session["openid"] = openid;
        }
        else
        {
            openid = Session["openid"].ToString();
        }
    }
}
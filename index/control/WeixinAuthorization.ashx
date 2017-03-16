<%@ WebHandler Language="C#" Class="WeixinAuthorization" %>

using System;
using System.Web;
using WeixinApiClass;

public class WeixinAuthorization : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/Default.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
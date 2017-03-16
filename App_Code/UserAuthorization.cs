using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using WeixinApiClass;
using LVWEIBA.Model;
using LVWEIBA.BLL;
using System.Web.UI;
using BaseClass.Model;

/// <summary>
/// UserAuthorization 的摘要说明
/// </summary>
public class UserAuthorization : System.Web.UI.Page
{
    public UserAuthorization()
    {

    }

    public static UserAuthorizationModel userLogin(Page page)
    {
        UserAuthorizationModel userInfo = BaseClass.Common.Common.GetCookieUserData<UserAuthorizationModel>(page);
        if (userInfo == null)
        {
            if (!UserAuthorization.userAuthorize(page.Request, page))
            {
                page.Response.Redirect("~/index/Login.aspx");
            }
        }
        else
        {
            log4netHelper.WriteDebugLog(typeof(UserAuthorization), "userLogin", "取出用户登录信息,OpenId: "+userInfo.openId+" naeme: "+userInfo.name);
            return userInfo;
        }

        return null;
    }

    /// <summary>
    /// 对微信登陆操作进行验证
    /// </summary>
    /// <param name="request"></param>
    /// <param name="page"></param>
    /// <returns></returns>
    public static bool userAuthorize(HttpRequest request, Page page)
    {
        try
        {
            string code = request.QueryString["code"];
            if (code == null || code == "") {
                return false;
            }
            string openid = new WEIxinUserApi().GetUserOpenid(code);
            DBCLASSFORWEIXIN.DAL.LocalWeixinUser ld = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser();
            if (ld.Exists(openid))
            {
                //DBCLASSFORWEIXIN.Model.LocalWeixinUser localUser = new WeixinApiClass.WEIxinUserApi().GetSingleUserInf(openid);
                DBCLASSFORWEIXIN.Model.LocalWeixinUser user = ld.GetModel(openid);
                UserAuthorizationModel userInfo = new UserAuthorizationModel();
                userInfo.mobile = user.Tel;
                userInfo.name = user.nickname;
                userInfo.openId = user.openid;
                BaseClass.Common.Common.UserLoginSetCookie(userInfo.name, page, DateTime.Now.AddDays(30), userInfo);
                return true;
            }
            else
            {
                HttpContext.Current.Session["weixincode"] = code;
                page.Response.Redirect("~/index/bindCode.aspx");
                return false;
            }
        }
        catch (Exception ex)
        {
            // BaseClass.Common.LoggerUtil.printLog("userAuthorize error:"+ex.Message);
            log4netHelper.WriteExceptionLog(typeof(UserAuthorization), "userAuthorize", ex);
            return false;
        }
    }
}
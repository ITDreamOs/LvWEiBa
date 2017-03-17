using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BaseClass.Common;
using LVWEIBA.Model;

public partial class index_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //{
        //    try
        //    {
        //        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        //        if (userInfo != null)
        //        {
        //            Response.Redirect("Default.aspx");
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        ////不做处理
        //    }
        //}
        if (IsPostBack)
        {

            string tel = Request.Form["tel"];
            string pass = Request.Form["pass"];
            string code = Request.Form["code"];

            object codeCache = HttpContext.Current.Cache.Get("code" + tel);
            if (codeCache == null)
            {
                Response.Write("<script>alert('验证码失效');window.location='Login.aspx';</script>");
                return;
            }

            if (code != codeCache.ToString())
            {
                Response.Write("<script>alert('验证码不正确');window.location='Login.aspx';</script>");
                return;
            }

            var bll = new LVWEIBA.BLL.MemberInfo();
            var blllist = new LVWEIBA.BLL.MemberList();
            DataSet ds = bll.GetList(" tel='" + tel + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                string openid = ds.Tables[0].Rows[0]["openid"].ToString();

                UserAuthorizationModel userInfoNow = new UserAuthorizationModel();
                userInfoNow.mobile = tel;
                userInfoNow.openId = openid;
                userInfoNow.name = tel;
                BaseClass.Common.Common.UserLoginSetCookie(userInfoNow.name, this.Page, DateTime.Now.AddDays(30), userInfoNow);
                log4netHelper.WriteDebugLog(typeof(Login), "login", "用户登录成功：" + userInfoNow.mobile + " " + openid);
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                string openid = BaseClass.Common.Common.getSuijiString(30);

                DBCLASSFORWEIXIN.Model.LocalWeixinUser SingleUserInf = new DBCLASSFORWEIXIN.Model.LocalWeixinUser();
                DBCLASSFORWEIXIN.DAL.LocalWeixinUser ld = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser();

                SingleUserInf.country = "";
                SingleUserInf.province = "";
                SingleUserInf.city = "";
                SingleUserInf.remark = "";
                SingleUserInf.openid = openid;
                SingleUserInf.regtime = DateTime.Now;
                SingleUserInf.Tel = tel;
                SingleUserInf.Jifen = 0;
                SingleUserInf.money = 0;
                SingleUserInf.vips = 0;
                SingleUserInf.pid = 0;
                SingleUserInf.refresh_token = "";
                SingleUserInf.nickname = "";
                SingleUserInf.headimgurl = "";
                SingleUserInf.subscribe = 1;
                SingleUserInf.subscribe_time = "";
                SingleUserInf.unionid = "";
                SingleUserInf.groupid = 0;
                SingleUserInf.sex = 1;

                LVWEIBA.BLL.MemberList bllMember = new LVWEIBA.BLL.MemberList();
                LVWEIBA.Model.MemberList model = new LVWEIBA.Model.MemberList();


                model.MemberId = openid;
                model.UserPwd = pass;
                model.Tel = tel;
                if (bllMember.Add(model) && ld.Add(SingleUserInf) > 0)
                {
                    UserAuthorizationModel userInfoNow = new UserAuthorizationModel();
                    userInfoNow.mobile = tel;
                    userInfoNow.openId = openid;
                    userInfoNow.name = tel;
                    BaseClass.Common.Common.UserLoginSetCookie(userInfoNow.name, this.Page, DateTime.Now.AddDays(30), userInfoNow);
                    log4netHelper.WriteDebugLog(typeof(Login), "login", "用户注册成功：" + userInfoNow.mobile + " " + openid);
                    Response.Redirect("~/Default.aspx");
                }
            }


        }
    }
}
using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_bindCode : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            try
            {
                string tel = Request.Form["tel"];
                string code = Request.Form["code"];
                object codeCache = HttpContext.Current.Cache.Get("code" + tel);
                if (codeCache == null)
                {
                    Response.Write("<script>alert('验证码失效');window.location='Login.aspx';</script>");
                }
                else
                {
                    if (code != codeCache.ToString())
                    {
                        Response.Write("<script>alert('验证码不正确');window.location='Login.aspx';</script>");
                    }
                    else
                    {
                        string weixinCode = Session["weixincode"].ToString();
                        string openid = new WEIxinUserApi().GetUserOpenid(code);
                        DBCLASSFORWEIXIN.DAL.LocalWeixinUser ld = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser();
                        DBCLASSFORWEIXIN.Model.LocalWeixinUser SingleUserInf = new WeixinApiClass.WEIxinUserApi().GetSingleUserInf(openid);
                        SingleUserInf.Tel = tel;
                        ld.Add(SingleUserInf);
                        LVWEIBA.BLL.MemberList bllMember = new LVWEIBA.BLL.MemberList();
                        LVWEIBA.Model.MemberList model = new LVWEIBA.Model.MemberList();
                        LVWEIBA.Model.MemberList existModel= bllMember.GetModel(openid, tel);
                        if (existModel == null)
                        {
                            model.Tel = tel;
                            model.MemberId = openid;
                            bllMember.Add(model);
                        }
                        else {
                            existModel.MemberId = openid;
                            bllMember.Update(model);
                        }

                        UserAuthorizationModel userInfoNow = new UserAuthorizationModel();
                        userInfoNow.mobile = tel;
                        userInfoNow.openId = openid;
                        userInfoNow.name = SingleUserInf.nickname;
                        BaseClass.Common.Common.UserLoginSetCookie(userInfoNow.name, this.Page, DateTime.Now.AddMinutes(30), userInfoNow);
                        log4netHelper.WriteDebugLog(typeof(Login), "bindCode", "用户绑定微信并且登陆成功：" + userInfoNow.mobile + " " + openid);

                        Response.Redirect("Default.aspx");
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}
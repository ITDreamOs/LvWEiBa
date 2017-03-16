using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BaseClass.Common;
using System.Data;

public partial class index_registration : System.Web.UI.Page
{
    protected string openid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            string tel = Request.Form["tel"];
            string code = Request.Form["code"];
            string pass = Request.Form["pass"];

            object codeCache = HttpContext.Current.Cache.Get("code" + tel);
            if (codeCache == null)
            {
                Jscript.NorefLocation(this.Page, "验证码失效请重新获取！手机号为:" + tel + "验证码为:" + code, "registration.aspx");
            }
            else
            {
                if (code != codeCache.ToString())
                {
                    Jscript.NorefLocation(this.Page, "验证码不正确！", "registration.aspx");
                }
                else
                {
                    try
                    {

                        var bll = new LVWEIBA.BLL.MemberInfo();
                        DataSet ds = bll.GetList(" tel='" + tel + "'");
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            Jscript.NorefLocation(this.Page, "该手机号已注册！", "registration.aspx");
                        }
                        else
                        {
                            openid = BaseClass.Common.Common.getSuijiString(30);

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
                                Session["openid"] = openid;
                                Response.Redirect("Default.aspx");
                            }
                        }

                    }
                    catch (Exception EX)
                    {

                        throw;
                    }
                }
            }
        }
    }
}
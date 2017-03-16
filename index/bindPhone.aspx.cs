using BaseClass.Common;
using BaseClass.Dal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_bindPhone : System.Web.UI.Page
{
    protected string openid = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["openid"] == null)
        {
            if (string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/bindPhone.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");

            }

            else
            {
                string code = Request.QueryString["code"];
                openid = new WEIxinUserApi().GetUserOpenid(code);

                if (openid.Length < 10)
                {
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/bindPhone.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
                }


            }
            Session["openid"] = openid;
        }
        else
        {
            openid = Session["openid"].ToString();
        }

        if (IsPostBack)
        {
            string mobile = Request.Form["tel"];
            string code = Request.Form["code"];

            object codeCache = HttpContext.Current.Cache.Get("code" + mobile);
            if (codeCache == null)
            {
                Jscript.NorefLocation(this.Page, "验证码失效请重新获取！手机号为:"+mobile+"code is:"+code, "bindPhone.aspx");
            }
            else {
                if (code != codeCache.ToString())
                {
                    Jscript.NorefLocation(this.Page, "验证码不正确！", "bindPhone.aspx");
                }
                else
                {
                    var member = new LVWEIBA.BLL.MemberInfo().GetModel(openid);
                    if (member != null)
                    {
                        if (member.Tel == "" || member.Tel == null)
                        {
                            //更新用户信息
                            var bll = new LVWEIBA.BLL.MemberInfo();
                            member.Tel = mobile.Trim();
                            bll.Update(member);

                            //发放礼券
                            //0020160508000001D5KI
                            List<LVWEIBA.Model.MemberCoupon> list = new List<LVWEIBA.Model.MemberCoupon>();
                            LVWEIBA.BLL.MemberCoupon bllCoupon = new LVWEIBA.BLL.MemberCoupon();
                            LVWEIBA.BLL.Coupon_Info bllCou = new LVWEIBA.BLL.Coupon_Info();
                            LVWEIBA.Model.Coupon_Info cou = bllCou.GetModel("0020160604000001KBW1");
                            LVWEIBA.Model.MemberCoupon mdl = new LVWEIBA.Model.MemberCoupon();
                            mdl.CouponID = "0020160604000001KBW1";
                            mdl.Userid = openid;
                            mdl.ZT = "0";
                            mdl.Count = 1;
                            mdl.Sj = DateTime.Now;
                            mdl.Order_Id = "";
                            list.Add(mdl);
                            //删除缓存
                            HttpContext.Current.Cache.Remove("code" + mobile);
                            if (bllCoupon.SendCouton(list, "0020160604000001KBW1", 1))
                            {
                                Jscript.NorefLocation(this.Page, "手机验证成功！", "Coupon.aspx");
                            }
                            else
                            {
                                Jscript.NorefLocation(this.Page, "手机验证失败！", "Coupon.aspx");
                            }

                        }
                        else {
                            //删除缓存
                            HttpContext.Current.Cache.Remove("code" + mobile);
                            Jscript.NorefLocation(this.Page, "该手机已经验证过！", "bindPhone.aspx");
                        }
                    }
                   
                }
            }
        }


    }
}
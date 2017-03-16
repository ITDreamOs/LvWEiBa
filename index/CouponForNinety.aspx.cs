using BaseClass.Common;
using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_CouponForNinety : System.Web.UI.Page
{
    protected string openid_db = "";
    protected string openid_wx = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        if (userInfo.openId == null || userInfo.openId == "")
        {
            openid_db = userInfo.mobile;
        }
        else
        {
            openid_db = userInfo.openId;
        }
        //Session["openid"] = openid;

        if (string.IsNullOrEmpty(Request.QueryString["code"]))
        {
            Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/CouponForNinety.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");

        }

        else
        {
            string code = Request.QueryString["code"];
            openid_wx = new WEIxinUserApi().GetUserOpenid(code);
            //Session["openid"] = openid;

            if (openid_wx.Length < 10)
            {
                Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/CouponForNinety.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
            }
            else
            {
            }

        }

        if (IsPostBack)
        {
            string mobile = Request.Form["tel"];
            string code = Request.Form["code"];

            object codeCache = HttpContext.Current.Cache.Get("code" + mobile);
            if (codeCache == null)
            {
                Jscript.NorefLocation(this.Page, "验证码失效请重新获取！手机号为:" + mobile + "code is:" + code, "CouponForNinety.aspx");
            }
            else
            {
                if (code != codeCache.ToString())
                {
                    Jscript.NorefLocation(this.Page, "验证码不正确！", "CouponForNinety.aspx");
                }
                else
                {
                    var member = new LVWEIBA.BLL.MemberInfo().GetModel(openid_db);
                    if (member != null)
                    {
                        if (member.Tel == "" || member.Tel == null || openid_db != openid_wx)
                        {
                            //更新用户信息
                            var bll = new LVWEIBA.BLL.MemberInfo();
                            member.Tel = mobile.Trim();
                            member.openid = openid_wx;
                            bll.Update(member);
                            //发放礼券（50元一张，20元俩张）
                            LVWEIBA.BLL.MemberCoupon bllCoupon = new LVWEIBA.BLL.MemberCoupon();
                            for (int i = 0; i < 2; i++)
                            {
                                List<LVWEIBA.Model.MemberCoupon> list = new List<LVWEIBA.Model.MemberCoupon>();
                                LVWEIBA.Model.MemberCoupon mdl = new LVWEIBA.Model.MemberCoupon();
                                mdl.CouponID = "0020160604000001KBW1";
                                mdl.Userid = openid_wx;
                                mdl.ZT = "0";
                                mdl.Count = 2;
                                mdl.Sj = DateTime.Now;
                                mdl.Order_Id = "";
                                list.Add(mdl);
                                bllCoupon.SendCouton(list, "0020160604000001KBW1", 1);
                            }
                            //50元
                            List<LVWEIBA.Model.MemberCoupon> listForFifty = new List<LVWEIBA.Model.MemberCoupon>();
                            LVWEIBA.Model.MemberCoupon mdlForFifty = new LVWEIBA.Model.MemberCoupon();
                            mdlForFifty.CouponID = "0020160604000001L511";
                            mdlForFifty.Userid = openid_wx;
                            mdlForFifty.ZT = "0";
                            mdlForFifty.Count = 1;
                            mdlForFifty.Sj = DateTime.Now;
                            mdlForFifty.Order_Id = "";
                            listForFifty.Add(mdlForFifty);
                            bllCoupon.SendCouton(listForFifty, "0020160604000001L511", 1);
                            //删除缓存
                            HttpContext.Current.Cache.Remove("code" + mobile);
                            Jscript.NorefLocation(this.Page, "领取成功！", "Coupon.aspx");

                        }
                        else
                        {
                            //删除缓存
                            HttpContext.Current.Cache.Remove("code" + mobile);
                            Jscript.NorefLocation(this.Page, "该手机号已经验证过！", "CouponForNinety.aspx");
                        }
                    }

                }
            }
        }


    }
}
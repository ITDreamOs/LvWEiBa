using BaseClass.Common;
using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_CouponForSixHundred : System.Web.UI.Page
{
    protected string openid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        if (userInfo.openId == null || userInfo.openId == "")
        {
            openid = userInfo.mobile;
        }
        else
        {
            openid = userInfo.openId;
        }
        Session["openid"] = openid;

        if (IsPostBack)
        {
            string mobile = Request.Form["tel"];
            string code = Request.Form["code"];

            object codeCache = HttpContext.Current.Cache.Get("code" + mobile);
            if (codeCache == null)
            {
                Jscript.NorefLocation(this.Page, "验证码失效请重新获取！手机号为:" + mobile + "code is:" + code, "bindPhone.aspx");
            }
            else
            {
                if (code != codeCache.ToString())
                {
                    Jscript.NorefLocation(this.Page, "验证码不正确！", "CouponForSixHundred.aspx");
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
                            //发放礼券（300元一张，50元四张，20元五张）
                            LVWEIBA.BLL.MemberCoupon bllCoupon = new LVWEIBA.BLL.MemberCoupon();
                            //20元
                            for (int i = 0; i < 5; i++)
                            {
                                List<LVWEIBA.Model.MemberCoupon> list = new List<LVWEIBA.Model.MemberCoupon>();
                                LVWEIBA.Model.MemberCoupon mdl = new LVWEIBA.Model.MemberCoupon();
                                mdl.CouponID = "0020160604000001KBW1";
                                mdl.Userid = openid;
                                mdl.ZT = "0";
                                mdl.Count = 5;
                                mdl.Sj = DateTime.Now;
                                mdl.Order_Id = "";
                                list.Add(mdl);
                                bllCoupon.SendCouton(list, "0020160604000001KBW1", 1);
                            }
                            //50元
                            for (int i = 0; i < 4; i++)
                            {
                                List<LVWEIBA.Model.MemberCoupon> listForFifty = new List<LVWEIBA.Model.MemberCoupon>();
                                LVWEIBA.Model.MemberCoupon mdlForFifty = new LVWEIBA.Model.MemberCoupon();
                                mdlForFifty.CouponID = "0020160604000001L511";
                                mdlForFifty.Userid = openid;
                                mdlForFifty.ZT = "0";
                                mdlForFifty.Count = 4;
                                mdlForFifty.Sj = DateTime.Now;
                                mdlForFifty.Order_Id = "";
                                listForFifty.Add(mdlForFifty);
                                bllCoupon.SendCouton(listForFifty, "0020160604000001L511", 1);
                            }
                            //300元
                            List<LVWEIBA.Model.MemberCoupon> listForThreeHundred = new List<LVWEIBA.Model.MemberCoupon>();
                            LVWEIBA.Model.MemberCoupon mdlForThreeHundred = new LVWEIBA.Model.MemberCoupon();
                            mdlForThreeHundred.CouponID = "002016060400000164Q5";
                            mdlForThreeHundred.Userid = openid;
                            mdlForThreeHundred.ZT = "0";
                            mdlForThreeHundred.Count = 1;
                            mdlForThreeHundred.Sj = DateTime.Now;
                            mdlForThreeHundred.Order_Id = "";
                            listForThreeHundred.Add(mdlForThreeHundred);
                            bllCoupon.SendCouton(listForThreeHundred, "002016060400000164Q5", 1);

                            //删除缓存
                            HttpContext.Current.Cache.Remove("code" + mobile);
                            Jscript.NorefLocation(this.Page, "领取成功！", "Coupon.aspx");

                        }
                        else
                        {
                            //删除缓存
                            HttpContext.Current.Cache.Remove("code" + mobile);
                            Jscript.NorefLocation(this.Page, "请先验证手机！", "bindPhone.aspx");
                        }
                    }

                }
            }
        }
    }
}
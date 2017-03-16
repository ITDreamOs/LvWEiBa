using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_chongzhi : System.Web.UI.Page
{
    protected string openid = "";
    protected string yue = "0.00";
    protected string HUserHostAddress = "";

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
        DBCLASSFORWEIXIN.Model.LocalWeixinUser SingleUserInf = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser().GetModel(openid);
        this.Title = SingleUserInf.nickname + " 现金账户";
        LVWEIBA.Model.MemberList mmm = new LVWEIBA.Model.MemberList();
        mmm = new LVWEIBA.DAL.MemberList().GetModel(openid);
        if (mmm == null)
        { yue = "0.00"; }
        else
        {
            yue = mmm.Money.ToString();
        }
        HUserHostAddress = Page.Request.UserHostAddress;

    }
}
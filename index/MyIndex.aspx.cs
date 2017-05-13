using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_Myindex : System.Web.UI.Page
{
    protected string openid;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        HttpCookie myCookie = new HttpCookie("UserMobel");
        if (myCookie!=null)
        {
            openid = userInfo.openId;
        }
      
        DBCLASSFORWEIXIN.Model.LocalWeixinUser SingleUserInf = new CheckUserAndUpdate().CheckUserAndInsert(userInfo.openId, "");
        Image1.ImageUrl = SingleUserInf.headimgurl;
        Label1.Text = SingleUserInf.nickname;
    }
}
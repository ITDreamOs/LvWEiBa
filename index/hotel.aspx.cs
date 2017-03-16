using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_hotel : System.Web.UI.Page
{
    string member = "";
    protected void Page_Load(object sender, EventArgs e)
    {

        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        if (userInfo.openId == null || userInfo.openId == "")
        {
            member = userInfo.mobile;
        }
        else
        {
            member = userInfo.openId;
        }
        Session["openid"] = member;
        //加载常用旅客信息
        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        List<LVWEIBA.Model.MemberHotel> lsthotel = bllhotel.GetModelList(" member='" + member + "'");
        Literal1.Text = "";
        string strhotel = "";
        foreach (MemberHotel item in lsthotel)
        {
            strhotel += string.Format("<li id='{0}'>{1}<span>{2}</span><i class='iconfont' id='{3}'>&#xe63d;</i></li>", item.Id,item.Name, item.Card, item.Id);
        }
        Literal1.Text = strhotel;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
        MemberHotel m = new MemberHotel();
        m.Member = member;
        m.Mobile = nc.GetValues("Mobile")[0].ToString();
        m.Name = nc.GetValues("hotelname")[0].ToString();
        m.Card = nc.GetValues("card")[0].ToString();
        m.Type = nc.GetValues("type")[0].ToString();
        m.Sj = DateTime.Now;
        int id = bllhotel.GetMaxId();
        if (bllhotel.Add(m) > 0)
        {
            string strhotel = string.Format("<li id='{0}'>{1}<span>{2}</span><i class='iconfont' id='{3}'>&#xe63d;</i></li>",m.Id, m.Name, m.Card, m.Id);
            Literal1.Text += strhotel;
        }
    }
}
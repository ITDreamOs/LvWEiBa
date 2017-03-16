using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_choose : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {

           // string openid = Request.QueryString["openid"];
            //string openid = new WEIxinUserApi().GetUserOpenid(code);
        if (!string.IsNullOrEmpty(Request.QueryString["code"]))
        {
            string code = Request.QueryString["code"];
            string openid = new WEIxinUserApi().GetUserOpenid(code);
            ChooseHaibao cc = new ChooseHaibao();
            Image1.ImageUrl = cc.GetMyChoosehaibao(openid);
        }
        else if(!string.IsNullOrEmpty(Request.QueryString["openid"]))
        {
            string openid = Request.QueryString["openid"];
            ChooseHaibao cc = new ChooseHaibao();
            Image1.ImageUrl = cc.GetMyChoosehaibao(openid);

        }
        else
        {
            Image1.ImageUrl = "http://wx.lvwei8.com/media/index.png";

        }
    }
}
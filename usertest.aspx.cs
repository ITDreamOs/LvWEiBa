using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class usertest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        WeixinApiClass.WEIxinUserApi wwd = new WeixinApiClass.WEIxinUserApi();
       // wwd.GetTop10000UserList();
        DBCLASSFORWEIXIN.Model.LocalWeixinUser GetSingleUserInf = wwd.GetSingleUserInf("oZMY8tw4qxXjO9VQR1EAY_1B845k");
    }
}
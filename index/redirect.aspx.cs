using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_redirect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = Request.Url.ToString();
        url = url.Replace("+","&");
        url = url.Replace("redirect", "indent_fill");
        Response.Redirect(url);
    }
}
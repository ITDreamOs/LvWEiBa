<%@ WebHandler Language="C#" Class="LogOut" %>
using System;
using System.Web;
using System.Web.Security;

public class LogOut : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        FormsAuthentication.SignOut();
        context.Response.Redirect("Default.aspx");
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}
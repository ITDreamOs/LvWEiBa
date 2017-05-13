<%@ WebHandler Language="C#" Class="GetUser" %>

using System;
using System.Web;
using Newtonsoft.Json;

public class GetUser : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        var usertel = HttpContext.Current.Request.Cookies["UserMobel"];
        if (usertel == null)
        {
            context.Response.Write("0");
            return;
        }
        var tel = usertel.Values["Mobel"];
        context.Response.Write(tel);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
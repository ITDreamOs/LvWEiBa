<%@ WebHandler Language="C#" Class="GetUserOpenId" %>

using System;
using System.Web;

public class GetUserOpenId : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        context.Response.Write("Hello World");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
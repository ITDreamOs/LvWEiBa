<%@ WebHandler Language="C#" Class="HotelHandler" %>

using System;
using System.Web;

public class HotelHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        int hotelId = int.Parse(context.Request.Form["id"].Trim());
        string result = "{";
        if (bllhotel.Delete(hotelId))
        {
            result = result + "\"state\":\"" +1+"\"}";
        }
        else
        {
            result = result + "\"state\":\"" +-1+"\"}";
        }
        context.Response.Write(result);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
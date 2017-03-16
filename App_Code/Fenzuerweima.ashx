<%@ WebHandler Language="C#" Class="Fenzuerweima" %>

using System;
using System.Web;

public class Fenzuerweima : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        string fenzu = context.Request.Form["fenzu"];
        string spath = "D://LVWEIBA//WeixinSys//Media//CodeFordaijinquan//" + fenzu.Replace("分组", "") + ".jpg";
        string res = "http://wx.lvwei8.com/media/CodeFordaijinquan/" + fenzu.Replace("分组", "") + ".jpg";
        BaseClass.Common.TXT_Help th = new BaseClass.Common.TXT_Help();
        if (System.IO.File.Exists(spath))
        {
        }
        else
        {
            string URL = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + WeixinApiClass.GetWeiXinInf.Getaccess_token();
            string json = "{\"action_name\":\"QR_LIMIT_STR_SCENE\", \"action_info\": {\"scene\": {\"scene_str\": \"jumptodaijinquan_" + fenzu.Replace("分组", "") + "\"}}}";
            string rjson = WeixinApiClass.PostDataToUrl.PostXmlToUrl(URL, json);
            //th.ReFreshTXT(rjson, "D:\\msg_err\\","c" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");
            // th.ReFreshTXT(rjson, "D:\\msg_json\\", "Code" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");
            //th.ReFreshTXT(rjson, "D:\\msg_json\\", "Code" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");
            if (rjson.Contains("errcode"))
            {
                res = "~/media/Codefordaijinquan/0.png";
            }
            else
            {
                Newtonsoft.Json.Linq.JObject jo = Newtonsoft.Json.Linq.JObject.Parse(rjson);
                string url2 = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + jo["ticket"].ToString();
                // string url = jo["url"].ToString();
                // th.ReFreshTXT(url2, "D:\\msg_json\\", "url" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");

                WeixinApiClass.DownFile d = new WeixinApiClass.DownFile();
                spath = "D://LVWEIBA//WeixinSys//Media//CodeFordaijinquan//" + fenzu.Replace("分组", "") + ".jpg";
                d.DownloadFile(url2, spath, 300000);//下载二维码
                res = "http://wx.lvwei8.com/media/CodeFordaijinquan/" + fenzu.Replace("分组", "") + ".jpg";
            }
        }
        th.ReFreshTXT(res, "D:\\msg_json\\", "res" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");
        context.Response.Write(res);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
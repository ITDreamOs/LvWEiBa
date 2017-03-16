using BaseClass.Common;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using WeixinApiClass;

/// <summary>
/// ChooseHaibao 的摘要说明
/// </summary>
public class ChooseHaibao
{
	public ChooseHaibao()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
        
	}
    public string GetMyChoosehaibao(string openid)
    {
        if(string.IsNullOrEmpty(openid))
        {
            return "http://wx.lvwei8.com/media/index.png";

        }
        if (!File.Exists("D://LVWEIBA//WeixinSys//Media//haibao//" + openid + ".jpg"))
        {
            return CreatHaibaowithCode(openid, new DBCLASSFORWEIXIN.DAL.LocalWeixinUser().GetModel(openid).headimgurl);
        }
        else
        {
            return "http://wx.lvwei8.com/media/haibao/" + openid + ".jpg";
        }

    }

    public string CreatHaibaowithCode(string openid, string hpic)
    {
        string URL = "https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + WeixinApiClass.GetWeiXinInf.Getaccess_token();
        string json = "{\"action_name\":\"QR_LIMIT_STR_SCENE\", \"action_info\": {\"scene\": {\"scene_str\": \"" + openid + "\"}}}";
        string rjson = WeixinApiClass.PostDataToUrl.PostXmlToUrl(URL, json);
        TXT_Help th = new TXT_Help();
        //th.ReFreshTXT(rjson, "D:\\msg_err\\","c" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");
        if (rjson.Contains("errcode"))
        {
            return "~/CodeWithOpenid/0.png";
        }
        else
        {
            JObject jo = JObject.Parse(rjson);
            string[] values = jo.Properties().Select(item => item.Value.ToString()).ToArray();
            string ticket = values[0].ToString();
            string url = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=" + ticket.Trim();
            DownFile d = new DownFile();
            string spath = "D://LVWEIBA//WeixinSys//Media//code//" + openid + ".jpg";
            string npath = "D://LVWEIBA//WeixinSys//Media//haibao//" + openid + ".jpg";
            string hpath = "D://LVWEIBA//WeixinSys//Media//headimg//" + openid + ".jpg";
            if (File.Exists(npath))
            {
                return "http://wx.lvwei8.com/media/haibao/" + openid + ".jpg";
            }
            else
            {
                d.DownloadFile(url, spath, 300000);//下载二维码
                if (hpic == "")//如果没有头像
                {
                    d.DownloadFile(url, hpath, 300000);//下载头像

                }
                else
                {
                    d.DownloadFile(hpic, hpath, 300000);//下载头像
                }

                CodeMaker cm = new CodeMaker();
                //cm.MakeCodeWithZhiwen(spath, npath);
                cm.MakeHaibaoWithOpenid(openid);

                return "http://wx.lvwei8.com/media/haibao/" + openid + ".jpg";
            }

        }
    }
}
using BaseClass.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using WeixinApiClass;

/// <summary>
/// MessageCreater 的摘要说明
/// </summary>
public class MessageCreater
{
    public MessageCreater()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }
    public string CreatScanMsg(string openid, string ToUserName, string Content)
    {
        string strresponse = "<xml>";
        strresponse += "<ToUserName><![CDATA[" + openid + "]]></ToUserName>";
        strresponse += "<FromUserName><![CDATA[" + ToUserName + "]]></FromUserName>";
        strresponse += "<CreateTime>" + DateTime.Now.Ticks.ToString() + "</CreateTime>";
        if (Content.StartsWith("jumptodaijinquan"))
        {
            strresponse = strresponse + "<MsgType><![CDATA[news]]></MsgType>";
            strresponse = strresponse + "<ArticleCount>1</ArticleCount>";
            strresponse = strresponse + "<Articles>";
            strresponse = strresponse + "<item>";
            strresponse = strresponse + "<Title><![CDATA[驴尾巴欢迎您！]]></Title> ";
            strresponse = strresponse + "<Description><![CDATA[点击领取代金券！]]></Description>";
            strresponse = strresponse + "<PicUrl><![CDATA[http://wx.lvwei8.com/index/images/3.png]]></PicUrl>";
            strresponse = strresponse + "<Url><![CDATA[http://wx.lvweiba.com/index/ActiveForCode.aspx?act=" + Content.Replace("jumptodaijinquan_", "") + "]]></Url>";
            strresponse = strresponse + "</item>";
            strresponse = strresponse + "</Articles>";
        }
        else
        {
               strresponse = strresponse + " <MsgType><![CDATA[text]]></MsgType>";
               strresponse = strresponse + " <Content><![CDATA[" + Content + "]]></Content>";
       

        }
        strresponse += "</xml>";
        return strresponse;
    }
    public string CreatTxtMsg(string openid, string ToUserName, string Content)
    {
        string strresponse = "<xml>";
        strresponse += "<ToUserName><![CDATA[" + openid + "]]></ToUserName>";
        strresponse += "<FromUserName><![CDATA[" + ToUserName + "]]></FromUserName>";
        strresponse += "<CreateTime>" + DateTime.Now.Ticks.ToString() + "</CreateTime>";
                    TXT_Help th = new TXT_Help();
            string mid = "";

        if (Content.Contains("二维码"))
        {
            Erweima er = new Erweima();
            if (!File.Exists("D://LVWEIBA//WeixinSys//media//Code//" + openid + ".jpg"))
            {
                try
                {
                    er.CreatHaibaowithCode(openid, new DBCLASSFORWEIXIN.DAL.LocalWeixinUser().GetModel(openid).headimgurl);
                }
                catch (Exception ee)
                {
                    th.ReFreshTXT(ee.ToString(), "D:\\msgweixin\\Code" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");
                }
            }
            mid = new MeaidWxUpLoad().WxUpLoad("D://LVWEIBA//WeixinSys//media//Code//" + openid + ".jpg", "image");
            strresponse = strresponse + "<MsgType><![CDATA[image]]></MsgType>";
            strresponse = strresponse + "<Image>";
            strresponse = strresponse + "<MediaId><![CDATA[" + mid + "]]></MediaId>";
            strresponse = strresponse + "</Image>";
            strresponse += "</xml>";
            SendCustomerMsg ss = new SendCustomerMsg();


            string posdata1 = "{    \"touser\":\"" + openid + "\",    \"msgtype\":\"text\",    \"text\":    {         \"content\":\"稍等····,正在生成二维码。http://wx.lvwei8.com/media/code/"+openid+".jpg\"    }}";
            string posdata2 = "{    \"touser\":\"" + openid + "\",    \"msgtype\":\"image\",    \"image\":    {         \"media_id\":\"" + mid + "\"    }}";
            th.ReFreshTXT(posdata2, "D:\\msgweixin\\VVV" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");
            try
            {
                ss.SendMsg(openid, posdata1);
               // ss.SendMsg(openid, posdata2);
            }
            catch (Exception vv)
            {
                th.ReFreshTXT(vv.ToString(), "D:\\msgweixin\\Code" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");
            }

        }
        else
        {
            strresponse = DefaultTxtMsg(openid, ToUserName);
        }


        return strresponse;
    }
    public string DefaultTxtMsg(string openid, string ToUserName)
    {
        string strresponse = "<xml>";
        strresponse += "<ToUserName><![CDATA[" + openid + "]]></ToUserName>";
        strresponse += "<FromUserName><![CDATA[" + ToUserName + "]]></FromUserName>";
        strresponse += "<CreateTime>" + DateTime.Now.Ticks.ToString() + "</CreateTime>";

        strresponse = strresponse + "<MsgType><![CDATA[news]]></MsgType>";
        strresponse = strresponse + "<ArticleCount>4</ArticleCount>";
        strresponse = strresponse + "<Articles>";
        strresponse = strresponse + "<item>";
        strresponse = strresponse + "<Title><![CDATA[驴尾巴欢迎您！]]></Title> ";
        strresponse = strresponse + "<Description><![CDATA[驴尾巴欢迎您！]]></Description>";
        strresponse = strresponse + "<PicUrl><![CDATA[http://weixin.lvwei8.com/index/images/3.png]]></PicUrl>";
        strresponse = strresponse + "<Url><![CDATA[http://weixin.zhengzaisong.com/index/bianli.aspx]]></Url>";
        strresponse = strresponse + "</item>";

        strresponse = strresponse + "<item>";
        strresponse = strresponse + "<Title><![CDATA[驴尾巴欢迎您]]></Title> ";
        strresponse = strresponse + "<Description><![CDATA[驴尾巴欢迎您！]]></Description>";
        strresponse = strresponse + "<PicUrl><![CDATA[http://weixin.lvwei8.com/media/images/5.png]]></PicUrl>";
        strresponse = strresponse + "<Url><![CDATA[http://weixin.zhengzaisong.com/index/bianli.aspx]]></Url>";
        strresponse = strresponse + "</item>";
        strresponse = strresponse + "<item>";
        strresponse = strresponse + "<Title><![CDATA[驴尾巴欢迎您]]></Title> ";
        strresponse = strresponse + "<Description><![CDATA[驴尾巴欢迎您！]]></Description>";
        strresponse = strresponse + "<PicUrl><![CDATA[http://weixin.lvwei8.com/media/images/6.png]]></PicUrl>";
        strresponse = strresponse + "<Url><![CDATA[http://weixin.zhengzaisong.com/index/bianli.aspx]]></Url>";
        strresponse = strresponse + "</item>";
        strresponse = strresponse + "<item>";
        strresponse = strresponse + "<Title><![CDATA[驴尾巴欢迎您]]></Title> ";
        strresponse = strresponse + "<Description><![CDATA[驴尾巴欢迎您！]]></Description>";
        strresponse = strresponse + "<PicUrl><![CDATA[http://weixin.lvwei8.com/media/images/7.png]]></PicUrl>";
        strresponse = strresponse + "<Url><![CDATA[http://weixin.zhengzaisong.com/index/bianli.aspx]]></Url>";
        strresponse = strresponse + "</item>";

        strresponse = strresponse + "</Articles>";

        strresponse += "</xml>";
        return strresponse;
    }
    public string CreatCliskMsg(string openid, string ToUserName, string EventKey)
    {
        string strresponse = "<xml>";
        strresponse += "<ToUserName><![CDATA[" + openid + "]]></ToUserName>";
        strresponse += "<FromUserName><![CDATA[" + ToUserName + "]]></FromUserName>";
        strresponse += "<CreateTime>" + DateTime.Now.Ticks.ToString() + "</CreateTime>";

        if (EventKey.ToLower() == "pinpaigushi")
        {
            strresponse = strresponse + "<MsgType><![CDATA[news]]></MsgType>";
            strresponse = strresponse + "<ArticleCount>1</ArticleCount>";
            strresponse = strresponse + "<Articles>";
            strresponse = strresponse + "<item>";
            strresponse = strresponse + "<Title><![CDATA[远方的渴望－我们的故事！]]></Title> ";
            strresponse = strresponse + "<Description><![CDATA[在那里我度过了童年和少年时期，无忧无虑是主旋律，一碗热腾的羊肉泡馍也能让我想念一个月。镇上有很多人去外地做生意，我做喜欢的事情就是听他们在昏暗的灯光下讲外面的故事，这些故事激起我了对远方的渴望。那时候我就想一定要到山的那边看看外面的世界！]]></Description>";
            strresponse = strresponse + "<PicUrl><![CDATA[http://mmbiz.qpic.cn/mmbiz/UlVELicS5uOCeLQRLTGD3flqctQDHu8r63D59xicq0Q6nEMZicvNcbEWLJDmEHNgia2wPGLhB8r3Os68OG0Nxp923w/640?wx_fmt=jpeg&tp=webp&wxfrom=5&wx_lazy=1]]></PicUrl>";
            strresponse = strresponse + "<Url><![CDATA[https://mp.weixin.qq.com/s?__biz=MzA3NDIxMzQ3Ng==&mid=504458596&idx=1&sn=ae70fa1a772cd87f91375bf777676705&scene=1&srcid=04215PCf7d1fugOBEvFl5xW8]]></Url>";
            strresponse = strresponse + "</item>";

            strresponse = strresponse + "</Articles>";
        }
        else if (EventKey.ToLower() == "haibao" || EventKey.ToLower() == "hiabao")
        {
            Erweima er = new Erweima();

            if (!File.Exists("D://WeiXinSystem//media//haibao//" + openid + ".jpg"))
            {
                try
                {
                    er.CreatHaibaowithCode(openid, new DBCLASSFORWEIXIN.DAL.LocalWeixinUser().GetModel(openid).headimgurl);
                }
                catch (Exception ee)
                {
                    TXT_Help th = new TXT_Help();
                    th.ReFreshTXT(openid + ee.ToString(), "D:\\msgweixin\\Code" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");

                }
            }
            string mid = "";
            mid = new MeaidWxUpLoad().WxUpLoad("D://WeiXinSystem//media//haibao//" + openid + ".jpg", "image");
            strresponse = strresponse + "<MsgType><![CDATA[image]]></MsgType>";
            strresponse = strresponse + "<Image>";
            strresponse = strresponse + "<MediaId><![CDATA[" + mid + "]]></MediaId>";
            strresponse = strresponse + "</Image>";
        }

        strresponse += "</xml>";
        return strresponse;
    }
}
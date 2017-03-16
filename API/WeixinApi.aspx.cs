using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;
using BaseClass.Common;
using System.IO;
using System.Text;
using LVWEIBA.Model;

public partial class API_WeixinApi : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TXT_Help th = new TXT_Help();

        string postStr = "";

        if (Request.HttpMethod.ToLower() == "post")
        {
            try
            {
                Stream s = System.Web.HttpContext.Current.Request.InputStream;
                byte[] b = new byte[s.Length];
                s.Read(b, 0, (int)s.Length);
                postStr = Encoding.UTF8.GetString(b);
                th.ReFreshTXT(postStr, "D:\\msgweixin\\CCPost" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");


                XmlHelp xh = new XmlHelp();
                SortedDictionary<string, string> sParams = xh.GetInfoFromXml(postStr);
                string openid = sParams["FromUserName"].ToString();
                string ToUserName = sParams["ToUserName"].ToString();
                string mesgtype = sParams["MsgType"].ToString().Trim();
                string strresponse = "";
                MessageCreater mc = new MessageCreater();

                if (mesgtype == "text")
                {
                    strresponse = mc.CreatTxtMsg(openid, ToUserName, sParams["Content"].ToString().Trim());
                }
                else if (sParams["MsgType"].ToString().Trim() == "event")
                {
                    if (sParams["Event"].ToString().Trim() == "subscribe")//会员关注
                    {
                        string parentopenid = "";
                        if (sParams["EventKey"].ToString() != "")
                        {
                            parentopenid = sParams["EventKey"].ToString().Replace("qrscene_", "");
                        }

                        DBCLASSFORWEIXIN.Model.LocalWeixinUser SingleUserInf = new CheckUserAndUpdate().CheckUserAndInsert(openid, parentopenid);
                        UserAuthorizationModel userInfo = new UserAuthorizationModel();
                        userInfo.mobile = SingleUserInf.Tel;
                        userInfo.name = SingleUserInf.nickname;
                        userInfo.openId = SingleUserInf.openid;
                        BaseClass.Common.Common.UserLoginSetCookie(userInfo.name, this, DateTime.Now.AddMinutes(30), userInfo);

                    }
                    else if (sParams["Event"].ToString().Trim() == "unsubscribe")//会员取消关注
                    {

                    }
                    else if (sParams["Event"].ToString().Trim() == "VIEW")//访问code跳转链接
                    {

                    }
                    else if (sParams["Event"].ToString().Trim() == "CLICK")//点击事件
                    {
                        strresponse = mc.CreatCliskMsg(openid, ToUserName, sParams["EventKey"].ToString().Trim());

                    }
                    else if (sParams["Event"].ToString().Trim() == "SCAN")//扫描事件
                    {
                        //strresponse = mc.DefaultTxtMsg(openid, ToUserName);jumptodaijinquan_C3
                        strresponse = mc.CreatScanMsg(openid, ToUserName, sParams["EventKey"].ToString().Trim());

                    }
                    else
                    {

                    }

                }
                else if (sParams["MsgType"].ToString().Trim().ToLower() == "voice")
                {

                }

                else if (sParams["MsgType"].ToString().Trim().ToLower() == "image")
                {

                }

                else
                {

                }

                WriteContent(strresponse);
            }
            catch (Exception mee)
            {
                th.ReFreshTXT(mee.ToString(), "D:\\msgweixin\\" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");
            }
        }
        else if (Request.HttpMethod.ToLower() == "get")
        {
            string Token = "m9zUU0V4v10M920s024r4ubu1bJ9bUJ5";//与微信公众账号后台的Token设置保持一致，区分大小写。
                                                              //获取微信服务器验证apiUrl参数
            string signature = Request["signature"];
            string timestamp = Request["timestamp"];
            string nonce = Request["nonce"];
            string echostr = Request["echostr"];
            string requestUrl = Request.QueryString["url"];
            string lineId = Request.QueryString["lineid"];
            requestUrl = requestUrl + "&lineid=" + lineId;
            try
            {
                JS_SDK_Class jssdk = new JS_SDK_Class();
                timestamp = jssdk.getTimestamp();
                nonce = jssdk.getNoncestr().ToLower();
                signature = jssdk.Creat_signature(requestUrl).ToLower();
                string jsapi_ticket = jssdk.Getjsapi_ticket();

                CheckSignature cc = new CheckSignature();
                //get method - 仅在微信后台填写URL验证时触发
                string result = "{\"signature\":\"" + signature + "\",\"timestamp\":\"" + timestamp + "\",\"nonce\":\"" + nonce + "\",\"jsapi_ticket\":\"" + jsapi_ticket + "\"}";
                log4netHelper.WriteDebugLog(typeof(API_WeixinApi), "jssdk授权返回", result + "requestUrl:" + requestUrl);
                WriteContent(result);
            }
            catch (Exception ex)
            {
                log4netHelper.WriteExceptionLog(typeof(API_WeixinApi), "WeixinApi", ex);
                WriteContent(echostr);
            }
        }
        else
        {

        }

    }
    private void WriteContent(string str)
    {
        Response.Write(str);
        Response.Flush();
    }
}
<%@ WebHandler Language="C#" Class="SendPhoneCode" %>

using System;
using System.Web;
using System.IO;
using Newtonsoft.Json;

public class SendPhoneCode : IHttpHandler
{

    public class SendPhoneCodeViewModel
    {

        public int code { get; set; }

        public string data { get; set; }


    }
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "applaction/json";
        var result = new SendPhoneCodeViewModel();
        try
        {
            string phoneNumber = context.Request["mobile"];
            string code = generateCode(6);
            LVWEIBA.MessageService.SendMessage(phoneNumber, "手机验证码：" + code + "，我们只做旅游尾单，让您说走就走还省钱！", "1291");
            //存入session
            HttpContext.Current.Cache.Insert("code" + phoneNumber, code);
            //log4netHelper.WriteDebugLog(typeof(SendPhoneCode), "sendPhoneMsg", phoneNumber + "发送短信成功，验证码为:" + code);
            result = new SendPhoneCodeViewModel() { code = 0, data = "验证码发送成功" };

        }
        catch (Exception ex)
        {
            result = new SendPhoneCodeViewModel() { code = -1, data = "验证码发送失败，稍后再试" };
            //     printLog(ex.Message + ex.StackTrace);
            //res = res + "\"code\":\"-1\",\"data\":\"验证码发送失败，稍后再试\"}";
        }

        context.Response.Write(JsonConvert.SerializeObject(result));
    }

    public void printLog(string content)
    {

        string FilePath = HttpRuntime.BinDirectory.ToString();
        string FileName = FilePath + "日志" + "\\" + System.DateTime.Now.ToString("yyyyMMdd") + ".txt";
        //判断有无当天txt文档，没有则创建
        if (!File.Exists(FileName))
        {
            //创建日志文件夹
            Directory.CreateDirectory(FilePath + "日志");
            StreamWriter sw = File.CreateText(FileName);
            sw.Close();
        }
        File.AppendAllText(FileName, content + "\r\n");
    }

    /// <summary>
    /// 生成6位验证码
    /// </summary>
    /// <returns></returns>
    public static string generateCode(int VcodeNum)
    {
        string Vchar = "0,1,2,3,4,5,6,7,8,9";
        string[] VcArray = Vchar.Split(',');
        string VNum = ""; //由于字符串很短，就不用StringBuilder了 
        int temp = -1; //记录上次随机数值，尽量避免生产几个一样的随机数 
                       //采用一个简单的算法以保证生成随机数的不同 
        Random rand = new Random();
        for (int i = 1; i < VcodeNum + 1; i++)
        {
            if (temp != -1)
            {
                rand = new Random(i * temp * unchecked((int)DateTime.Now.Ticks));
            }
            int t = rand.Next(VcArray.Length);
            if (temp != -1 && temp == t)
            {
                return generateCode(VcodeNum);
            }
            temp = t;
            VNum += VcArray[t];
        }
        return VNum;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
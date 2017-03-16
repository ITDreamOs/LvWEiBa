using System.Web;
using System.Text;
using System.IO;
using System.Net;
using System;
using System.Collections.Generic;

namespace Com.Alipay
{
    /// <summary>
    /// 类名：Config
    /// 功能：基础配置类
    /// 详细：设置帐户有关信息及返回路径
    /// 版本：3.4
    /// 修改日期：2016-03-08
    /// 说明：
    /// 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
    /// 该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
    /// </summary>
    public class Config
    {

        //↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

        // 合作身份者ID，签约账号，以2088开头由16位纯数字组成的字符串，查看地址：https://b.alipay.com/order/pidAndKey.htm
        public static string partner = "2088911090664480";

        // 收款支付宝账号，以2088开头由16位纯数字组成的字符串，一般情况下收款账号就是签约账号
        public static string seller_id = partner;

        //商户的私钥,原始格式，RSA公私钥生成：https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.nBDxfy&treeId=58&articleId=103242&docType=1
        public static string private_key = @"MIICXAIBAAKBgQD1FXabuGV1AqVviwjgsZ+RyafeZ50yHxzyja2CaXMyp0GiZrE9
ZmuSQKJepkIWb9xV811t/7kKno9rZi9OhGW2CKPWFyIXiAgLIVKVVmRL7xvnYOOA
VT43JICWBVOk5Zhxm00H04eoYmBhpZm6BpF5v7SiVNrqbrdJJd2RavuFkQIDAQAB
AoGAbdccvVW7QuHYu1EYvXteBLzYG3lcnmYLVzngFZ6lHoKPi/VyYg5RD88f9kOV
QvEHUw4rRW1ixTujE4NMmGgGHNrgoL2BoFuqGtJjetyBA2HksHUIekDchDzOTejg
a+sbc7YhTFyHMmFVWOBZWFzoJFT/PwRHo40t3fM25EPlmkECQQD9bRu3UTrMmcZS
npji76lbfP8KrsR6Wft9vlbvUNd6PH58CwBgjEPm+TmURF2WvGNcoNMIgX590kR5
HZ+/nPPFAkEA95KqWn78wpdQ3aOox5TZfuBlGM3KCF0g+DY2YJkFTyAiha1Q7LpY
8A6wgdou9KgRfwqSJwXJVQtFTTerJt+LXQJAGBJSDKKRlDeTB+v6l6uuCXug+hHJ
pdmAMtxug4LJRNoUJZIh8gnAtWK83mF0BkpUocrA4ND0A92CFYMD1n6BBQJBALom
KDrlMq4p0l7kmJqAfEze8oUE7vz88TZQpPBa/lfxZKO4nplwwEC3+tWYNSg2Wvl3
/E6lFi4AzHnz+pe/C+0CQHdFnvjkX1a7wAN2Ppy9V2ns7Tk1TldQSy0TJVMRj6F0
WfTsTcKHht5cGnhd8BEuS9TfN8/tIWpb8GrdZnexhhc=";

        //支付宝的公钥，查看地址：https://b.alipay.com/order/pidAndKey.htm 
        public static string alipay_public_key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";

        // 服务器异步通知页面路径，需http://格式的完整路径，不能加?id=123这类自定义参数,必须外网可以正常访问
        public static string notify_url = "http://lvwei8.com/API/AliNotifyUrl.aspx";

        // 页面跳转同步通知页面路径，需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
        public static string return_url = "http://lvwei8.com/API/AliReturnUrl.aspx";

        // 签名方式
        public static string sign_type = "RSA";

        // 调试用，创建TXT日志文件夹路径，见AlipayCore.cs类中的LogResult(string sWord)打印方法。
        public static string log_path = HttpRuntime.AppDomainAppPath.ToString() + "log/";

        // 字符编码格式 目前支持utf-8
        public static string input_charset = "utf-8";

        // 支付类型 ，无需修改
        public static string payment_type = "1";

        // 调用的接口名，无需修改
        public static string service = "alipay.wap.create.direct.pay.by.user";

        //↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    }
}
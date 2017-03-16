using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// log4netHelper 的摘要说明
/// </summary>
[assembly: log4net.Config.XmlConfigurator(Watch = true, ConfigFile = "log4net.config")]
public class log4netHelper
{
    /// <summary>  
    /// 输出日志到Log4Net Error  
    /// </summary>  
    /// <param name="t">表示类型声明：类类型、接口类型、数组类型、值类型、枚举类型、类型参数、泛型类型定义、以及开放或封闭构造的泛型类型</param>  
    /// <param name="ex">异常对象</param>  
    #region static void WriteLog(Type t, Exception ex)  

    public static void WriteExceptionLog(Type t,string methodName, Exception ex)
    {
        log4net.ILog log = log4net.LogManager.GetLogger(t);
        log.Error(methodName+"_异常：", ex);
    }

    #endregion

    /// <summary>  
    /// 输出日志到Log4Net Debug  
    /// </summary>  
    /// <param name="t">表示类型声明：类类型、接口类型、数组类型、值类型、枚举类型、类型参数、泛型类型定义、以及开放或封闭构造的泛型类型</param>  
    /// <param name="msg">要记录的内容</param>  
    #region static void WriteLog(Type t, string msg)  
    public static void WriteDebugLog(Type t,string methodName, string msg)
    {
        log4net.ILog log = log4net.LogManager.GetLogger(t);
        log.Debug(methodName+"操作记录:" + msg);
    }
    #endregion
}
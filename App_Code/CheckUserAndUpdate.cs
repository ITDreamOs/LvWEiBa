using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// CheckUserAndUpdate 的摘要说明
/// </summary>
public class CheckUserAndUpdate
{
    public DBCLASSFORWEIXIN.Model.LocalWeixinUser CheckUserAndInsert(string openid, string popenid)
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
        DBCLASSFORWEIXIN.Model.LocalWeixinUser SingleUserInf = new WeixinApiClass.WEIxinUserApi().GetSingleUserInf(openid);
        DBCLASSFORWEIXIN.DAL.LocalWeixinUser ld = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser();
        if (!ld.Exists(openid)&&SingleUserInf!=null)
        {
            SingleUserInf.regtime = DateTime.Now;
            SingleUserInf.Tel = "";
            if (popenid.Trim() == "")
            {
                SingleUserInf.pid = 0;
            }
            else
            {
                SingleUserInf.pid = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser().GetModel(popenid).id;

            }
            ld.Add(SingleUserInf);
        } 
        else
        {
            SingleUserInf = ld.GetModel(openid);
        }
      
        return SingleUserInf;

    }

}
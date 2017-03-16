using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;
using System.IO;
using LVWEIBA.Model;

public partial class aboutme : System.Web.UI.Page
{
    string openid = "";
    protected string nickname = "";
    protected string Tel = "";
    protected string MemberName = "";
    protected string Card = "";
    protected string Mail = "";
    protected string Pwd = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
            if (userInfo.openId == null || userInfo.openId == "")
            {
                openid = userInfo.mobile;
            }
            else
            {
                openid = userInfo.openId;
            }
            Session["openid"] = openid;

            DBCLASSFORWEIXIN.Model.LocalWeixinUser wxmdl = new CheckUserAndUpdate().CheckUserAndInsert(openid, "");

            LVWEIBA.Model.MemberList mmm = new LVWEIBA.Model.MemberList();
            mmm = new LVWEIBA.DAL.MemberList().GetModel(openid);
            if (mmm == null)
            {
                nickname = wxmdl.nickname;
                Tel = wxmdl.Tel;
                ddl_sex.SelectedValue = wxmdl.sex.ToString();

            }
            else
            {
                nickname = wxmdl.nickname;
                Tel = wxmdl.Tel;
                MemberName = mmm.MemberName;
                ddl_sex.SelectedValue = wxmdl.sex.ToString();
                Card = mmm.Card;
                Mail = mmm.Mail;
                Pwd = mmm.UserPwd;
            }
        }
    }
    protected void btn_Tj_Click(object sender, EventArgs e)
    {
        openid = Session["openid"].ToString();
        DBCLASSFORWEIXIN.DAL.LocalWeixinUser ld = new DBCLASSFORWEIXIN.DAL.LocalWeixinUser();
        DBCLASSFORWEIXIN.Model.LocalWeixinUser wxmdl = ld.GetModel(openid);

        LVWEIBA.BLL.MemberList mbll = new LVWEIBA.BLL.MemberList();
        LVWEIBA.Model.MemberList mmm = new LVWEIBA.Model.MemberList();

        System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
        string txt_user = nc.GetValues("txt_user")[0].ToString();
        string txt_tel = nc.GetValues("txt_tel")[0].ToString();
        string txt_xm = nc.GetValues("txt_xm")[0].ToString();
        string txt_card = nc.GetValues("txt_card")[0].ToString();
        string txt_mail = nc.GetValues("txt_mail")[0].ToString();
        string txt_pwd = nc.GetValues("txt_pwd")[0].ToString();
        string txt_pwd2 = nc.GetValues("txt_pwd2")[0].ToString();

        bool isexists = false;
        if (mbll.Exists(openid))
        {
            mmm = mbll.GetModel(openid);
            isexists = true;
        }
        wxmdl.nickname = txt_user;
        wxmdl.Tel = txt_tel;
        mmm.MemberName = txt_xm;
        wxmdl.sex = int.Parse(ddl_sex.SelectedValue);
        mmm.Card = txt_card;
        mmm.Mail = txt_mail;
        mmm.UserPwd = txt_pwd;
        mmm.UserPwd = txt_pwd2;
        mmm.MemberId = openid;
        bool isok = false;
        try
        {


            isok = ld.Update(wxmdl);
            if (isexists)
            {
                isok = mbll.Update(mmm);
            }
            else
            {
                isok = mbll.Add(mmm);
            }
            Response.Write(String.Format("<script>alert('个人信息修改成功');window.location='myindex.aspx';</script>"));
        }
        catch (Exception ex)
        {
            log4netHelper.WriteExceptionLog(typeof(aboutme),"aboutme异常",ex);
        }

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
}
using DBCLASSFORWEIXIN.DAL;
using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_Default : System.Web.UI.Page
{
    //protected string openid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["code"] != null)
        {
            //微信渠道登陆
          UserAuthorizationModel userInfo=UserAuthorization.userLogin(this.Page);
        }
        string s = "select top 10 * ,(1000*adultzkPrice/adultTicketPrice) as zk from View_LvLines where enddate >getdate()  order by zk  ";
        DataSet ds = DBCLASSFORWEIXIN.DAL.DbHelperSQL.Query(s, null);
        Repeater1.DataSource = ds.Tables[0];
        Repeater1.DataBind();

        //最新通知
        BaseClass.Model.App_Notices am = new BaseClass.Dal.App_Notices().GetLastModel();
        LabelNotice.Text = am.Title;

        //绑定广告幻灯片
        //DataSet dss = new BaseClass.Dal.App_Ad().GetList("");
        
        //Repeater2.DataSource = dss.Tables[0];
        //Repeater2.DataBind();

    }
    protected string subttl(string tet)
    {
        return BaseClass.Common.Common.titleSubstring(tet, 17);
    }
    protected string typeget(string tycode)
    {
        string tpname = "";
        switch (tycode)
        {
            case "chujing":
                tpname = "出境游";
                break;
            case "guonei":
                tpname = "国内游";
                break;
            case "ziyouxing":
                tpname = "自由行";
                break;
            case "taiwan":
                tpname = "台湾游";
                break;
            case "zhoubian":
                tpname = "周边游";
                break;
            default:
                tpname = "国内游";
                break;
        }
        return tpname;
    }
    protected string Diffdatebynow(string datestr)
    {
        return new BaseClass.Common.DateTimePlus().DateDiff(Convert.ToDateTime(datestr), DateTime.Now, "hour");
    }
    protected string zhekou(string sellp, string mp)
    {
        decimal res = 10 * decimal.Parse(sellp) / decimal.Parse(mp);
        //  return Math.Round(res, 2).ToString();
        return res.ToString("0.0");
    }
}
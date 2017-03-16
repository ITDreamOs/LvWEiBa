using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_LineList : System.Web.UI.Page
{
    protected string tpname = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string chanle = Request.QueryString["tp"].Trim();
            HiddenFieldchanle.Value = chanle;
            tpname= typeget(chanle);
            this.Title = tpname + "列表";
            string filterType = Request.QueryString["filter_type"];
            // string s = "select top 5 * from View_LvLines where kindof='" + Request.QueryString["tp"] + "' order by id desc";
            string s = "";
            if (filterType == "" || filterType == null)
            {
                s = "select top 15 * from View_LvLines where kindof='" + chanle + "' and  enddate >getdate() order by id desc";
            }
            else
            {
                s = "select top 15 * from View_LvLines where kindof='" + chanle + "' and  enddate >getdate() order by " + filterType + " desc";
            }
            DataSet ds = DBCLASSFORWEIXIN.DAL.DbHelperSQL.Query(s, null);
            Repeater1.DataSource = ds.Tables[0];

            Repeater1.DataBind();

            //绑定广告幻灯片
            DataSet dss = new BaseClass.Dal.App_Ad().GetList("");
            Repeater2.DataSource = dss.Tables[0];
            Repeater2.DataBind();

            //最新通知
            BaseClass.Model.App_Notices am = new BaseClass.Dal.App_Notices().GetLastModel();
            LabelNotice.Text = am.Title;
        }

    }
    protected string subttl(string tet)
    {
        return BaseClass.Common.Common.titleSubstring(tet, 17);
    }
    protected string typeget(string tycode)
    {
        string tpname = "";
        if (tycode == "chujing" || tycode == "出境游")
            tpname = "出境游";
        if (tycode == "guonei" || tycode == "国内游")
            tpname = "国内游";
        if (tycode == "ziyouxing" || tycode == "ziyouxing")
            tpname = "自由行";
        if (tycode == "taiwan" || tycode == "台湾游")
            tpname = "台湾游";
        if (tycode == "zhoubian" || tycode == "周边游")
            tpname = "周边游";
       
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



    protected void PriceFilter_Click(object sender, EventArgs e)
    {

        Response.Redirect("LineList.aspx?tp=" + HiddenFieldchanle.Value + "&filter_type=adultSellPrice");

    }

    protected void ZKFilter_Click(object sender, EventArgs e)
    {
        Response.Redirect("LineList.aspx?tp=" + HiddenFieldchanle.Value + "&filter_type=adultzkPrice");
    }

    protected void DateFilter_Click(object sender, EventArgs e)
    {
        Response.Redirect("LineList.aspx?tp=" + HiddenFieldchanle.Value + "&filter_type=sdate");
    }

    protected void DaysFilter_Click(object sender, EventArgs e)
    {
        Response.Redirect("LineList.aspx?tp=" + HiddenFieldchanle.Value + "&filter_type=Dayscount");
    }

    
}
using BaseClass.Bll;
using BaseClass.Common;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_control_loadlineData : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindRpt();
    }
    //绑定列表数据
    protected void BindRpt()
    {
        int totalRecord = 0;//总记录条数
        int pageIndex = Request["pageindex"] == null ? 1 : Convert.ToInt32(Request["pageindex"]);//当前页码
        int pageSize = 3;//每页条数
        string parms = "";//传递给下一页的条件
        string sql = GetSql(out parms);//传递给SQL的查询条件
        FenYe fy = new FenYe();
        DataTable list = fy.GetList("View_LvLines", "*", "id desc", pageIndex, pageSize, sql, out totalRecord);

        NetPage pa = new NetPage(pageIndex, pageSize, totalRecord, "loadlineData.aspx", parms, 10);
        //pagetext = pa.CreatePageHtml();//生成分页html
        if (list != null)
        {
            this.rptList.DataSource = list;
            this.rptList.DataBind();
        }
    }


    //获取查询条件
    protected string GetSql(out string parms)
    {
        StringBuilder sql = new StringBuilder();//传递给SQL的查询条件
        StringBuilder url = new StringBuilder();//传递给下一页的条件
        string className = Request.QueryString["kindof"];
        sql.Append("  and  IsDel=0 ");
        if (!string.IsNullOrEmpty(className))
        {
            sql.AppendFormat("  and  Kindof= '{0}' ", className);
            url.Append("&Kindof=" + className);
        }



        parms = url.ToString();
        return sql.ToString();
    }


    //设置查询条件
    //protected void SetSql()
    //{
    //    string userName = Request.Form["userName"];//用户名
    //    if (!string.IsNullOrEmpty(userName))
    //        this.txtUserName.Text = userName;
    //}


    protected string subttl(string tet)
    {
        return BaseClass.Common.Common.titleSubstring(tet, 17);
    }
    protected string typeget(string tycode)
    {
        string tpname = "";
        switch (tycode)
        {
            case "chujing": tpname = "出境游";
                break;
            case "guonei": tpname = "国内游";
                break;
            case "ziyouxing": tpname = "自由行";
                break;
            case "taiwan": tpname = "台湾游";
                break;
            case "zhoubian": tpname = "周边游";
                break;
            default: tpname = "国内游";
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
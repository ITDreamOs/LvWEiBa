using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_showline : System.Web.UI.Page
{
    protected string ttl = "";
    protected string sdate = "";
    protected string azhe = "";
    protected string pzhe = "";
    protected int lineid = 0;
    protected string adult = "";
    protected string puppy = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string baseUrl = "http://wx.lvwei8.com/index/showline.aspx";
        if (!string.IsNullOrEmpty(Request.QueryString["code"]))
        {
            string ProNumCode = BaseClass.Common.Common.InputText(Request.QueryString["code"], 50);
            LVWEIBA.DAL.LvULinesContPics pl = new LVWEIBA.DAL.LvULinesContPics();
            DataSet dspl = pl.GetList(" ProNumCode='" + ProNumCode.Trim() + "'");
            Repeater1.DataSource = dspl.Tables[0];
            Repeater1.DataBind();
            if(!string.IsNullOrEmpty(Request.QueryString["lineid"]))
            {
                lineid = int.Parse(Request.QueryString["lineid"].Trim());
                HiddenFieldid.Value = lineid.ToString();
                LVWEIBA.Model.LvULines lm = new LVWEIBA.DAL.LvULines().GetModel(lineid);
                adult = lm.adultTicketCount.ToString();
                puppy = lm.puppyTicketCount.ToString();
                this.Title = lm.TTl;
                //分享
                hidTitle.Value = lm.TTl;
                hidImgUrl.Value = lm.Spic;
                hidLink.Value = baseUrl + "?code=" + ProNumCode + "&lineid=" + lineid;

                ttl = BaseClass.Common.Common.titleSubstring(lm.TTl, 15);
                sdate = Convert.ToDateTime(lm.Sdate.ToString()).ToString("yyyy年MM月dd号");
                Label3.Text = lm.Splace;
                Label1.Text = "余"+lm.adultTicketCount.ToString()+"位";
                Label4.Text = lm.Provider;
                Label5.Text ="剩"+ new BaseClass.Common.DateTimePlus().DateDiff(DateTime.Now, Convert.ToDateTime(lm.Sdate.ToString()), "hour");
                Label6.Text = lm.adultTicketPrice.ToString();
                Label7.Text = lm.adultzkPrice.ToString();
                Label8.Text = lm.puppyTicketPrice.ToString();
                Label9.Text = lm.puppyzkCount.ToString();

                LVWEIBA.Model.LvUTextCont contm = new LVWEIBA.Model.LvUTextCont();
                contm = new LVWEIBA.DAL.LvUTextCont().GetModel(ProNumCode);
                Label10.Text = contm.TourDetial;
                Label11.Text = contm.Others;
                azhe = zhekou(lm.adultzkPrice.ToString(), lm.adultTicketPrice.ToString());
                pzhe = zhekou(lm.puppyzkCount.ToString(), lm.puppyTicketPrice.ToString());

            }
        }
        else
        {

        }
    }
    protected string zhekou(string sellp, string mp)
    {
        if(mp=="0")
        {
            return "0.0";
        }
        decimal res = 10 * decimal.Parse(sellp) / decimal.Parse(mp);
        //  return Math.Round(res, 2).ToString();
        return res.ToString("0.0");
    }
}
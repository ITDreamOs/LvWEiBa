using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_showTicket : System.Web.UI.Page
{
    protected int ticketCount = 0;
    protected int tickeId = 0;
    protected string ticketDetailTitle = "";
    protected int ticketLeftCount = 0;
    protected string zhekou = "";
    protected string ticketConpics = "";
    protected string startDate = "";
    protected string endDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        string ticketId = BaseClass.Common.Common.InputText(Request.QueryString["ticketId"], 50);
        var bll = new LVWEIBA.DAL.ProviderSpot();
        if (ticketId != "" && ticketId != null)
        {
            LVWEIBA.Model.ProviderSpot providerSpot = bll.GetModel(int.Parse(ticketId.Trim()));
            ticketConpics = providerSpot.ConPic;
            this.Title = providerSpot.SpotName;
            ticketDetailTitle = BaseClass.Common.Common.titleSubstring(providerSpot.SpotName, 15);
            startDate= Convert.ToDateTime(providerSpot.BeginTime.ToString()).ToString("yyyy年MM月dd号");
            endDate= Convert.ToDateTime(providerSpot.EndTime).ToString("yyyy年MM月dd号");
            ticketLeftCount = (int)providerSpot.Num;
            this.marketPriceLbl.Text = providerSpot.TicketPrice.ToString();
            this.transactionPriceLbl.Text = providerSpot.ZkPrice.ToString();
            this.zhekou = CalculateRate(providerSpot.ZkPrice.ToString(), providerSpot.TicketPrice.ToString());
            this.HiddenFieldid.Value = providerSpot.ID.ToString();

        }
    }

    protected string CalculateRate(string sellp, string mp)
    {
        if (mp == "0")
        {
            return "0.0";
        }
        decimal res = 10 * decimal.Parse(sellp) / decimal.Parse(mp);
        //  return Math.Round(res, 2).ToString();
        return res.ToString("0.0");
    }
}
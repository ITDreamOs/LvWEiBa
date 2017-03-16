using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class index_ticket : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            var bll = new LVWEIBA.DAL.ProviderSpot();
            string sql = " and num>0 and endtime>=getdate()-1";
            DataTable list = bll.GetList(" 1=1 " + sql).Tables[0];
            StringBuilder sb = new StringBuilder();
            string str = "";
            foreach (DataRow item in list.Rows)
            {
                string spotname = item["SpotName"].ToString();
                string src = item["TitlePic"].ToString();
                string num = item["num"].ToString();
                int TicketPrice = int.Parse(item["TicketPrice"].ToString());
                int ZkPrice = int.Parse(item["ZkPrice"].ToString());
                int shen = TicketPrice - ZkPrice;
                DateTime now = DateTime.Now;
                DateTime EndTime =DateTime.Parse( item["EndTime"].ToString()).AddDays(1);
                System.TimeSpan span = EndTime - now;
                int day = span.Days;
                int hours = span.Hours;

                 str = string.Format(@" <a href='showTicket.aspx?ticketId={0}' class='picks external'> <li class='item'>
                        <div class='box'>
                            <div class='pic'>
                                <img src='{1}' alt=''></div>
                            <div class='name'>
                                {2}</div>
                            <div class='amount'>
                                余<em>{3}</em>张<span>省{4}元</span></div>
                            <div class='time'>
                                剩<span>{5}天{6}小时</span><em>￥{7}.00</em></div>
                        </div>
                    </li></a>", item["id"].ToString(),src, spotname, num, shen, day, hours, ZkPrice);
                 sb.Append(str);
            }
            this.Literal1.Text = sb.ToString();
        }
    }
}
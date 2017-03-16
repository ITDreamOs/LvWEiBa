using BaseClass.Common;
using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_indent_ticket_fill : System.Web.UI.Page
{
    protected string member = "";
    protected string ticketTitle = "";
    protected int ticketId = 0;
    protected string startDate = "";
    protected string endDate = "";
    protected int reserverCount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        if (userInfo.openId == null || userInfo.openId == "")
        {
            member = userInfo.mobile;
        }
        else
        {
            member = userInfo.openId;
        }
        ticketId = (string.IsNullOrEmpty(Request.QueryString["ticketId"]) ? 0 : int.Parse(Request.QueryString["ticketId"]));
        //预定数量
        reserverCount = (string.IsNullOrEmpty(Request.QueryString["reserverCount"]) ? 0 : int.Parse(Request.QueryString["reserverCount"]));
        if (!IsPostBack)
        {
            var bll = new LVWEIBA.DAL.ProviderSpot();
            ViewState["ticketId"] = ticketId;
            if (ticketId == 0 || reserverCount == 0)
            {
                Jscript.AlertAndRedirect("请选择合适的票数", "ticket.aspx");
            }
            else
            {
                LVWEIBA.Model.ProviderSpot providerSpot = bll.GetModel(ticketId);
                ticketTitle = providerSpot.SpotName;
                ticketId = providerSpot.ID;
                startDate = Convert.ToDateTime(providerSpot.BeginTime).ToString("yyyy年MM月dd号");
                endDate= Convert.ToDateTime(providerSpot.EndTime).ToString("yyyy年MM月dd号");
                orderPriceLbl.Text = "￥" + providerSpot.ZkPrice;
                string priceDetailStr = reserverCount+"张";
                int maketPrice = (int)providerSpot.TicketPrice*reserverCount;
                int zkPrice = (int)providerSpot.ZkPrice*reserverCount;
                string str = string.Format(@"<p>市场价：￥{0}（{1}）</p>
                       <p>优惠价：￥{2}（{3}）</p>", maketPrice, priceDetailStr, zkPrice, priceDetailStr);
                this.priceDetailLbl.Text = str;
                this.hid_count.Value = reserverCount.ToString();
                this.hid_price_sc.Value = maketPrice.ToString();
                this.hid_price_yh.Value = zkPrice.ToString();
                this.hid_ticket_id.Value = ticketId.ToString();
                this.hid_price_jj.Value = providerSpot.SellPrice.ToString();
                HiddenFieldBZ.Value = str.Replace("<p>", "").Replace("</p>", "");

                LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
                List<LVWEIBA.Model.MemberHotel> lsthotel = bllhotel.GetModelList(" member='" + userInfo.mobile + "' or member='" + userInfo.openId + "'");
                string strhotel = "";
                foreach (MemberHotel item in lsthotel)
                {
                    strhotel += string.Format(" <input id='Checkbox1' name='hotel' class='hotel' type='checkbox' value='{0}' />{1}", item.Id, item.Name);
                }
                contactPersonsLiteral.Text = strhotel;
            }
        }

    }

    protected void addContactPerson_Click(object sender, EventArgs e)
    {
        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
        MemberHotel m = new MemberHotel();
        m.Member = member;
        m.Mobile = nc.GetValues("mobile")[0].ToString();
        m.Name = nc.GetValues("userName")[0].ToString();
        m.Card = nc.GetValues("identityCard")[0].ToString();
        m.Sj = DateTime.Now;
        m.Type = "0";
        int id = bllhotel.GetMaxId();
        if (bllhotel.Add(m) > 0)
        {
            string strhotel = string.Format(" <input id='Checkbox1' name='hotel' checked class='hotel' type='checkbox' value='{0}' />{1}", id, m.Name);
            contactPersonsLiteral.Text += strhotel;
        }
    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {
        decimal order_Price = int.Parse(hid_price_yh.Value);
        string order_id = DateTime.Now.ToString("yyyyMMdd") + "0000" + "MP" + BaseClass.Common.Common.getSuijiString(2);
        //明细
        LVWEIBA.Model.order_Mx modelMx = null;

        LVWEIBA.BLL.order_Mx bllMx = new LVWEIBA.BLL.order_Mx();
        modelMx = new LVWEIBA.Model.order_Mx();
        modelMx.order_id = order_id;
        modelMx.productNum = hid_ticket_id.Value;
        modelMx.market_price = int.Parse(hid_price_sc.Value);//市场价
        modelMx.Transaction_price = int.Parse(hid_price_yh.Value);//优惠价
        modelMx.Transfer_price = int.Parse(hid_price_jj.Value);//交接价
        modelMx.ProCount = int.Parse(this.hid_count.Value);
        //商品类型（电子票）
        modelMx.ProType = "DZP";
        //成人和小孩数量(门票默认为0)
        modelMx.adultCount = 0;
        modelMx.puppyCount = 0;

        bllMx.Add(modelMx);

        //订单
        LVWEIBA.Model.order_list model = new LVWEIBA.Model.order_list();
        model.order_id = order_id;
        model.user_id = member;
        model.order_sj = DateTime.Now;
        model.order_zt = "DZF";//待支付
        model.order_Price = order_Price;
        model.bz = HiddenFieldBZ.Value;

        LVWEIBA.BLL.order_list bll = new LVWEIBA.BLL.order_list();
        if (bll.Add(model))
        {        //给订单添加旅客信息
            System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
            string[] arrhotel = nc.GetValues("hotel");
            LVWEIBA.BLL.MemberHotelMx bllhotel = new LVWEIBA.BLL.MemberHotelMx();
            if (arrhotel != null && arrhotel.Length > 0)
            {
                for (int i = 0; i < arrhotel.Length; i++)
                {
                    if (arrhotel[i] == "")
                        break;
                    MemberHotelMx m = new MemberHotelMx();
                    m.Member = member;
                    m.OrderID = order_id;
                    m.Hotel = int.Parse(arrhotel[i]);
                    m.Sj = DateTime.Now;
                    bllhotel.Add(m);
                }
            }
            else
            {
                Jscript.NorefLocation(this.Page, "请选择联系用户！", "showTicket.aspx");
            }
            //1代表门票0代表尾单
            Response.Redirect("indent_pay.aspx?ddbm=" + order_id + "&lineid=" + ViewState["ticketId"]+"&type='mp'");
        }
    }
}
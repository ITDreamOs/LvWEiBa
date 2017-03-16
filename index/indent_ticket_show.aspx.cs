using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_intendent_ticket_show : System.Web.UI.Page
{
    protected string openid = "";
    //状态
    protected string orderStateDB = "";
    protected string orderState = "";
    //orderId
    protected string orderId = "";
    //商品编号
    protected string goodId = "";
    //有效日期
    protected string startDate = "";
    protected string endDate = "";
    //票务负责人
    protected string ticketMaster = "";
    //票数
    protected string ticketCount = "";
    //市场价 
    protected string marketPrice = "";
    //优惠价
    protected string transferPrice = "";
    //联系人
    protected string contactPersonName = "";
    protected string contactPersonMobile = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["openid"] == null)
        {
            if (string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/indent_type.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");

            }

            else
            {
                string code = Request.QueryString["code"];
                openid = new WEIxinUserApi().GetUserOpenid(code);
                Session["openid"] = openid;

                if (openid.Length < 10)
                {
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/indent_type.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
                }
                else
                {
                }

            }


            Session["openid"] = openid;
        }
        else
        {
            openid = Session["openid"].ToString();
        }

        if (!IsPostBack)
        {
            orderId = Request.QueryString["order_id"];
            //赋值
            showDetailInfo(orderId);
            GetNumbers(orderId);
        }
    }

    public void showDetailInfo(string orderId)
    {
        var orderBLL = new LVWEIBA.BLL.order_list();
        var order = orderBLL.GetModel(orderId);
        string sql = "";
        if (!string.IsNullOrEmpty(orderId))
        {
            sql += " and order_id='" + orderId + "'";
        }
        var bll = new LVWEIBA.DAL.order_Mx();
        DataTable list = bll.GetDataMixedWithSpot(" 1=1 " + sql).Tables[0];
        foreach (DataRow dr in list.Rows)
        {
            //状态
            orderStateDB = order.order_zt;
            orderState = DealState(order.order_zt);
            //商品Id
            if (dr["productNum"] != null)
            {
                goodId = dr["productNum"].ToString();
            }
            //sDate
            if (dr["BeginTime"] != null)
            {
                startDate = Convert.ToDateTime(dr["BeginTime"]).ToString("yyyy年MM月dd号");
            }
            else
            {
                endDate = Convert.ToDateTime(dr["EndTime"]).ToString("yyyy年MM月dd号");
            }

            if (orderStateDB != "DZF")
            {                
                //线路负责人
                if (dr["Master"] != null)
                {
                    ticketMaster = dr["Master"].ToString() + " " + dr["MasterTel"].ToString();
                }          
            }
            //票数
            ticketCount = dr["ProCount"].ToString();
            marketPrice = dr["market_price"].ToString();
            transferPrice = dr["Transaction_price"].ToString();
        }
    }

    protected void GetNumbers(string order_id)
    {
        string sql = "select * from View_OrderListNumber list where OrderID='" + order_id + "' ";
        DataTable list = BaseClass.Dal.DbHelperSQL.Query(sql, null).Tables[0];
        contactPersonName = list.Rows[0]["Name"].ToString();
        contactPersonMobile = list.Rows[0]["Mobile"].ToString();
    }
    protected string DealState(string flag)
    {
        if (flag == "DZF")
            return "待支付";
        if (flag == "DCX")
            return "待出行";
        if (flag == "DPJ")
            return "待评价";
        if (flag == "YWC")
            return "已完成";
        return "";
    }
}
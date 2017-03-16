using LVWEIBA.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_indent_show : System.Web.UI.Page
{
    protected string openid = "";
    //状态
    protected string orderStateDB = "";
    protected string orderState = "";
    //orderId
    protected string orderId = "";
    //商品编号
    protected string goodId = "";
    //出发日期
    protected string startDate = "";
    //供应商
    protected string provider = "";
    //线路负责人
    protected string lineMaster = "";
    //导游接站人
    protected string leader = "";
    //集合时间
    protected string jeHeTime = "";
    //集合地点
    protected string jeHePlace = "";
    //人数
    protected string member = "";
    //市场价 
    protected string marketPrice = "";
    //优惠价
    protected string transferPrice = "";
    //联系人
    protected string contactPersonName = "";
    protected string contactPersonMobile = "";
    //travellers
    protected DataTable travellers = null;

    protected void Page_Load(object sender, EventArgs e)
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
        DataTable list = bll.GetList(" 1=1 " + sql).Tables[0];
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
            if (dr["Sdate"] != null)
            {
                startDate = dr["Sdate"].ToString();
            }

            if (orderStateDB != "DZF")
            {
                //供应商
                if (dr["Provider"] != null)
                {
                    provider = dr["Provider"].ToString();
                }
                //线路负责人
                if (dr["LineMaster"] != null)
                {
                    lineMaster = dr["LineMaster"].ToString() + " " + dr["LineMasterMoble"].ToString();
                }
                //导游
                if (dr["Leader"] != null)
                {
                    leader = dr["Leader"].ToString() + " " + dr["LeaderMobil"].ToString();
                }
                //集合时间
                if (dr["JIheTime"] != null)
                {
                    jeHeTime = dr["JIheTime"].ToString();
                }
                if (dr["JiHePlace"] != null)
                {
                    jeHePlace = dr["JiHePlace"].ToString();
                }
            }
            //人数
            member = dr["adultCount"].ToString() + "成人" + dr["puppyCount"] + "儿童";
            marketPrice = dr["market_price"].ToString();
            transferPrice = dr["Transaction_price"].ToString();
        }
    }

    protected void GetNumbers(string order_id)
    {
        string sql = "select * from View_OrderListNumber list where OrderID='" + order_id + "' ";
        DataTable list = BaseClass.Dal.DbHelperSQL.Query(sql, null).Tables[0];
        travellers = list;
        if (list.Rows.Count > 0)
        {
            for (int i = 0; i < list.Rows.Count; i++)
            {
                if (i == 0)
                {
                    contactPersonName = list.Rows[i]["Name"].ToString();
                    contactPersonMobile = list.Rows[i]["Mobile"].ToString();
                    return;
                }
            }
        }
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using WeixinApiClass;
using LVWEIBA.Model;
using BaseClass.Dal;

public partial class index_indent_type : System.Web.UI.Page
{
    protected string openid = "";
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
            OnQuery();
        }
    }

    private void OnQuery()
    {
        string order = "";
        var bll = new LVWEIBA.DAL.order_list();
        var sb = string.Format(@" select b.*,LvULinesSpic.Spic from (select order_Mx.productNum, LocalWeixinUser.nickname, order_list.order_sj, order_list.order_zt, order_list.order_Price, order_Mx.ProCount, order_list.order_id, LocalWeixinUser.openid as user_id
 from order_list
left join LocalWeixinUser on order_list.user_id = LocalWeixinUser.openid
left
 join order_Mx on order_Mx.order_id = order_list.order_id
where user_id = '{0}') b left join LvULinesSpic ON b.productNum = LvULinesSpic.ProNumCode;", openid);
        var list = SQLHelper.GetDataTable(CommandType.Text, sb.ToString(), null);
           
        //string sql = " and user_id='" + openid + "'";
        //DataTable list = bll.GetList(" 1=1 " + sql).Tables[0];
        StringBuilder strWzf = new StringBuilder();
        StringBuilder strDcx = new StringBuilder();
        StringBuilder strYwc = new StringBuilder();
        StringBuilder strDpj = new StringBuilder();
        foreach (DataRow dr in list.Rows)
        {
            order = string.Format(@" <li>
              <div class='pic'><img alt=' ' src='{4}' /></div>
              <div class='wz'>
                <div class='name'>{0}</div>
                <div class='jg'>￥{1} <em>数量：{2}</em></div>
                <div class='time'>{3}</div>
#btn#
              </div>
            </li>",

             dr["order_id"],
             dr["order_Price"],
             dr["ProCount"],
             DateTime.Parse(dr["order_sj"].ToString()).ToString("yyyy-MM-dd"),
                         dr["Spic"]);
            switch (dr["order_zt"].ToString())
            {

                case "DZF":
                    order = order.Replace("#btn#", " <div class='state'><a class='portal external' href='indent_pay.aspx?ddbm=" + dr["order_id"] + "'>去支付</a></div>" +
                       "<div class='detail'><a href='indent_show.aspx?order_id="+dr["order_id"]+"'>看详情</a></div> ");
                    strWzf.Append(order);
                    break;
                case "DCX":
                    order = order.Replace("#btn#", "<div class='state'><a href='indent_show.aspx?order_id=" + dr["order_id"] + "'>看详情</a></div>");
                    strDcx.Append(order);
                    break;
                case "YWC":
                    order = order.Replace("#btn#", "<div class='state'><a href='indent_show.aspx?order_id=" + dr["order_id"] + "'>看详情</a></div>");
                    strYwc.Append(order);
                    break;
                case "DPJ":
                    order = order.Replace("#btn#", " <div class='state'><a href=''>去评价</a></div>"+
                        "<div class='detail'><a href='indent_show.aspx?order_id=" + dr["order_id"] + "'>看详情</a></div>"
                        );
                    strDpj.Append(order);
                    break;
            }
        }
        this.lit_wzf.Text = strWzf.ToString();
        this.lit_dcx.Text = strDcx.ToString();
        this.lit_ywc.Text = strYwc.ToString();
        this.lit_dpj.Text = strDpj.ToString();
    }
}
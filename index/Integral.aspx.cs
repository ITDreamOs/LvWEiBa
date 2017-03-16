using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class index_Integral : System.Web.UI.Page
{
    string userId = "oZMY8t07V1LpLYqJCsyHgPZ3KtS4";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            OnQuery();

        }
    }

    private void OnQuery()
    {
        LVWEIBA.BLL.MemberList bll = new LVWEIBA.BLL.MemberList();
        LVWEIBA.Model.MemberList model = bll.GetModel(userId);
        this.lbl_Points.Text = model.Points.ToString();//积分总数
        var bllPoints = new LVWEIBA.DAL.MemberPoints();
        DataTable list = bllPoints.GetMxList(" memberid='" + userId + "'").Tables[0];
        StringBuilder strMx = new StringBuilder();
        foreach (DataRow dr in list.Rows)
        {
            strMx.AppendFormat(@"<li class='list'>
                <div class='name'>{0}（订单号:{1}）</div>
                <div class='time'>{2}</div>
                <div class='number'>{3}</div>
                </li>",
            dr["sourcemc"],
            dr["OrderId"],
            DateTime.Parse(dr["Sj"].ToString()).ToString("yyyy年MM月dd日 HH时mm分"),
            int.Parse(dr["Points"].ToString()) > 0 ? "+" + dr["Points"] : dr["Points"]);
        }
        this.Literal1.Text = strMx.ToString();
    }
}
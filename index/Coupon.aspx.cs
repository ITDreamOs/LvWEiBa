using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.IO;
using WeixinApiClass;
using LVWEIBA.Model;

public partial class index_Coupon : System.Web.UI.Page
{
    string openid = "oZMY8t07V1LpLYqJCsyHgPZ3KtS4";
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

        OnQuery();
    }

    private void OnQuery()
    {
        var bllCoupon = new LVWEIBA.DAL.MemberCoupon();
        printLog("openid is" + openid);
        DataTable list = bllCoupon.GetMemberCouponList(" openid='" + openid + "'").Tables[0];
        StringBuilder strYsy = new StringBuilder();
        StringBuilder strWsy = new StringBuilder();
        string yhq = "";
        printLog(list.Rows.Count.ToString());
        foreach (DataRow dr in list.Rows)
        {
            printLog(DateTime.Parse(dr["Timeout"].ToString()).ToString("yyyy - MM - dd") + "  " + dr["OrderCount"].ToString() + " " + dr["Price"].ToString() + " " + dr["zt"].ToString());
            yhq = string.Format(@"   <div class='stamp'>
                <div class='divLeft'>
                    <span class='divYhq'>优惠券</span><br />
                    <span class='divYxq'>有效期至{0}</span>
                    <table class='tabMj'>
                        <tr>
                            <td>
                                满{1}元使用
                            </td>
                        </tr>
                        <tr>
                            <td>
                                单次消费使用一张
                            </td>
                        </tr>
                    </table>
                </div>
                <div class='divRight'>
                    ￥<font class='divMoney'>{2}</font></div>
            </div>", DateTime.Parse(dr["Timeout"].ToString()).ToString("yyyy-MM-dd"), dr["OrderCount"], dr["Price"]);
            if (dr["zt"].ToString().Equals("0"))
            {
                strWsy.Append(yhq);
            }
            else
            {
                strYsy.Append(yhq);
            }

        }
        this.lit_wsy.Text = strWsy.ToString();
        this.lit_ysy.Text = strYsy.ToString();
    }

    public void printLog(string content)
    {

        string FilePath = HttpRuntime.BinDirectory.ToString();
        string FileName = FilePath + "日志" + "\\" + System.DateTime.Now.ToString("yyyyMMdd") + ".txt";
        //判断有无当天txt文档，没有则创建
        if (!File.Exists(FileName))
        {
            //创建日志文件夹
            Directory.CreateDirectory(FilePath + "日志");
            StreamWriter sw = File.CreateText(FileName);
            sw.Close();
        }
        File.AppendAllText(FileName, content + "\r\n");
    }
}
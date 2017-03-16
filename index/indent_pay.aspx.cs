using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;
using System.IO;
using LVWEIBA.Model;

public partial class index_indent_pay : System.Web.UI.Page
{
    protected string openid = "";
    protected string shichangjia = "";
    protected string youhuijia = "";
    protected string HUserHostAddress = "";
    //NewAdded
    //余额
    protected string moneyLeft = "";
    protected string type = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        int lineid = (string.IsNullOrEmpty(Request.QueryString["lineid"]) ? 0 : int.Parse(Request.QueryString["lineid"]));
        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        if (userInfo.openId == null || userInfo.openId == "")
        {
            openid = userInfo.mobile;
        }
        else
        {
            openid = userInfo.openId;
        }

        string oid = Request.QueryString["ddbm"];
        log4netHelper.WriteDebugLog(typeof(index_indent_pay),"indent_pay","进入支付 orderid is:" + oid+"用户Id:"+openid);
        LVWEIBA.Model.order_list oom = new LVWEIBA.Model.order_list();
        oom = new LVWEIBA.DAL.order_list().GetModel(oid);
        LVWEIBA.Model.order_Mx omm = new LVWEIBA.DAL.order_Mx().GetModel(oid);
        string typeObject = omm.ProType;
        if (!String.IsNullOrEmpty(typeObject))
        {
            if (typeObject.Equals("DZP"))
            {
                type = "mp";
            }
            else
            {
                type = "wd";
            }
        }
        //BaseClass.Common.LoggerUtil.printLog("type is:" + type);
        shichangjia = omm.market_price.ToString();
        youhuijia = omm.Transaction_price.ToString();
        LVWEIBA.Model.MemberList mmm = new LVWEIBA.Model.MemberList();
        mmm = new LVWEIBA.DAL.MemberList().GetModel(openid);
        if (mmm == null)
        {
            moneyLeft = "0.00";
        }
        else
        {
            moneyLeft = mmm.Money.ToString();
        }
        LVWEIBA.DAL.LvULines dallines = new LVWEIBA.DAL.LvULines();
        LVWEIBA.Model.LvULines mlines = dallines.GetModel(omm.productNum);//根据订单明细的线路编号获取线路的类别
        if ((mlines!=null&&mlines.Kindof.Equals("jianhang"))||type.Equals("mp"))//建行分期或门票
        {
            HiddenFieldchctt.Value = omm.Transaction_price.ToString().Replace(".", "");
            Label1.Text = omm.Transaction_price.ToString();//优惠价
            lbl_scsm.Text = "";
            lbl_yhsm.Text = "（支付时直接按优惠价价支付）";
            type = "jh";
        }
        else
        {
            lbl_scsm.Text = "（支付时按市场价支付）";
            lbl_yhsm.Text = "（返还差价之后的实际成交价）";
            lbl_zyts.Text = @"          重要提示：该产品按市场价支付，旅行结束后48小时内
驴尾巴网将差价返还至会员现金账户，会员可自由选择提现
或二次消费。";
            HiddenFieldchctt.Value = omm.market_price.ToString().Replace(".", "");
            Label1.Text = omm.market_price.ToString();//市场价
        }
        if (type == null) {
            type = "default";
        }
        HUserHostAddress = Page.Request.UserHostAddress;
        //HiddenFieldchctt.Value = omm.Transaction_price.ToString().Replace(".", "");
        //Label1.Text = omm.Transaction_price.ToString();
        this.hid_order_id.Value = oid;
        this.hid_order_type.Value = type;
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
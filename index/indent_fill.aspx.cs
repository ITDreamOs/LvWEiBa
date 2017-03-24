using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using LVWEIBA.Model;
using WeixinApiClass;

public partial class index_indent_fill : System.Web.UI.Page
{
    string member = "";
    int adultCount = 0;
    int puppyCount = 0;
    int lineid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        UserAuthorizationModel userInfo = UserAuthorization.userLogin(this.Page);
        //if (userInfo.openId == null || userInfo.openId == "")
        //{
        //    member = userInfo.mobile;
        //}
        //else
        //{
        //    member = userInfo.openId;
        //}
        //int adult = (string.IsNullOrEmpty(Request.QueryString["adult"]) ? 0 : int.Parse(Request.QueryString["adult"]));
        //int children = (string.IsNullOrEmpty(Request.QueryString["children"]) ? 0 : int.Parse(Request.QueryString["children"]));
        //lineid = (string.IsNullOrEmpty(Request.QueryString["lineid"]) ? 0 : int.Parse(Request.QueryString["lineid"]));
        //adultCount = adult;
        //puppyCount = children;
        //if (!IsPostBack)
        //{
        //    LVWEIBA.BLL.LvULines bll = new LVWEIBA.BLL.LvULines();
        //    LVWEIBA.Model.LvULines model = bll.GetModel(lineid);
        //    ViewState["lineid"] = lineid;
        //    if (model != null)
        //    {
        //        // DataTable dtlb = LVWEIBA.DAL.Common.GetCplb();
        //        //DataRow[] drlb= dtlb.Select("bm='" + model.Kindof + "'");
        //        //hid_lb.Value = drlb[0]["value"].ToString();
        //        hid_pronum.Value = model.ProNumCode;
        //        this.lbl_ProName.Text = model.TTl;
        //        this.lbl_ProNum.Text = model.ProNumCode;
        //        string ydrs = "";
        //        string scine = "";
        //        string yhine = "";
        //        int scPrice = 0;
        //        int yhPrice = 0;
        //        int jjPrice = 0;
        //        if (adult > 0)
        //        {
        //            scine += "成人￥" + model.adultTicketPrice + "x" + adult + ";";
        //            yhine += "成人￥" + model.adultzkPrice + "x" + adult + ";";
        //            ydrs += " 成人*" + adult;
        //            scPrice += Convert.ToInt32(model.adultTicketPrice) * adult;
        //            yhPrice += Convert.ToInt32(model.adultzkPrice) * adult;
        //            jjPrice += Convert.ToInt32(model.adultSellPrice) * adult;
        //        }
        //        if (children > 0)
        //        {
        //            scine += "儿童￥" + model.puppyTicketPrice + "x" + children + ";";
        //            yhine += "儿童￥" + model.puppyzkCount + "x" + children + ";";
        //            ydrs += " 儿童*" + children;
        //            scPrice += Convert.ToInt32(model.puppyTicketPrice) * children;
        //            yhPrice += Convert.ToInt32(model.puppyzkCount) * children;
        //            jjPrice += Convert.ToInt32(model.puppySellPrice) * adult;
        //        }
        //        this.lbl_Ydrs.Text = ydrs;
        //        this.lbl_Cfcity.Text = model.Splace;
        //        this.lbl_Cfdate.Text = Convert.ToDateTime(model.Sdate).ToString("yyyy-MM-dd");
        //        string str = string.Format(@"<p>市场价：￥{0}（{1}）</p>
        //               <p>优惠价：￥{2}（{3}）</p>", scPrice, scine, yhPrice, yhine);

        //        this.hid_price_sc.Value = scPrice.ToString();
        //        this.hid_price_yh.Value = yhPrice.ToString();
        //        this.hid_price_jj.Value = jjPrice.ToString();
        //        this.hid_count.Value = (adult + children).ToString();
        //        this.li_jine.Text = str;
        //        lbl_DDjE.Text = "￥" + yhPrice;
        //        HiddenFieldBZ.Value = str.Replace("<p>", "").Replace("</p>", "");
        //        LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
        //        List<LVWEIBA.Model.MemberHotel> lsthotel = bllhotel.GetModelList(" member='" + member + "'");
        //        string strhotel = "";
        //        foreach (MemberHotel item in lsthotel)
        //        {
        //            strhotel += string.Format(" <input id='Checkbox1' name='hotel' class='hotel' type='checkbox' value='{0}' />{1}", item.Id, item.Name);
        //        }
        //       // Literal1.Text = strhotel;

        //    }

        //}
        //Label1.Text = "";
        //Label1.Text = Request.ServerVariables["HTTP_HOST"] + Request.ServerVariables["SCRIPT_NAME"];

    }
    //protected void btn_submit_Click(object sender, EventArgs e)
    //{
    //    decimal order_Price = int.Parse(hid_price_yh.Value);
    //    string order_id = DateTime.Now.ToString("yyyyMMdd") + "0000" + hid_lb.Value + BaseClass.Common.Common.getSuijiString(4);
    //    //明细
    //    LVWEIBA.Model.order_Mx modelMx = null;
    //    LVWEIBA.BLL.order_Mx bllMx = new LVWEIBA.BLL.order_Mx();
    //    LVWEIBA.BLL.MemberHotelMx bllhotel = new LVWEIBA.BLL.MemberHotelMx();


    //    modelMx = new LVWEIBA.Model.order_Mx();
    //    modelMx.order_id = order_id;
    //    modelMx.productNum = hid_pronum.Value;
    //    modelMx.market_price = int.Parse(hid_price_sc.Value);//市场价
    //    modelMx.Transaction_price = int.Parse(hid_price_yh.Value);//优惠价
    //    modelMx.Transfer_price = int.Parse(hid_price_jj.Value);//交接价
    //    modelMx.ProCount = int.Parse(this.hid_count.Value);
    //    modelMx.ProType = hid_lb.Value;
    //    //成人和小孩数量
    //    modelMx.adultCount = adultCount;
    //    modelMx.puppyCount = puppyCount;

    //    bllMx.Add(modelMx);

    //    //订单
    //    LVWEIBA.Model.order_list model = new LVWEIBA.Model.order_list();
    //    model.order_id = order_id;
    //    model.user_id = member;
    //    model.order_sj = DateTime.Now;
    //    model.order_zt = "DZF";//待支付
    //    model.order_Price = order_Price;
    //    model.bz = HiddenFieldBZ.Value;

    //    System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
    //    string[] arrhotel = nc.GetValues("hotel");

    //    LVWEIBA.BLL.order_list bll = new LVWEIBA.BLL.order_list();
    //    if (bll.Add(model))
    //    {

    //        try
    //        {
    //            //给订单添加旅客信息
    //            if (arrhotel == null || arrhotel.Length != adultCount)
    //            {
    //                Response.Write(String.Format("<script>alert('请选择正确的旅客数量');window.location='indent_fill.aspx?adult={0}&children={1}&lineid={2}';</script>", adultCount, puppyCount, lineid));
    //            }
    //            else
    //            {
    //                for (int i = 0; i < arrhotel.Length; i++)
    //                {
    //                    if (arrhotel[i] == "")
    //                        break;
    //                    MemberHotelMx m = new MemberHotelMx();
    //                    m.Member = member;
    //                    m.OrderID = order_id;
    //                    m.Hotel = int.Parse(arrhotel[i]);
    //                    m.Sj = DateTime.Now;
    //                    bllhotel.Add(m);
    //                }
    //                Response.Redirect("indent_pay.aspx?ddbm=" + order_id + "&lineid=" + ViewState["lineid"]);
    //            }
    //        }
    //        catch (Exception)
    //        {
    //            Response.Write(String.Format("<script>alert('请选择正确的旅客数量');window.location='indent_fill.aspx?adult={0}&children={1}&lineid={2}';</script>", adultCount, puppyCount, lineid));
    //        }

    //    }
    //}
    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    LVWEIBA.BLL.MemberHotel bllhotel = new LVWEIBA.BLL.MemberHotel();
    //    System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
    //    MemberHotel m = new MemberHotel();
    //    m.Member = member;
    //    m.Mobile = nc.GetValues("Mobile")[0].ToString();
    //    m.Name = nc.GetValues("hotelname")[0].ToString();
    //    m.Card = nc.GetValues("card")[0].ToString();
    //    m.Sj = DateTime.Now;
    //    m.Type = "0";
    //    int id = bllhotel.GetMaxId();
    //    if (bllhotel.Add(m) > 0)
    //    {
    //        string strhotel = string.Format(" <input id='Checkbox1' name='hotel' checked class='hotel' type='checkbox' value='{0}' />{1}", id, m.Name);
    //       // Literal1.Text += strhotel;
    //    }
    //}

    //protected void redirect(string message, string toUrl)
    //{
    //    string js = "<script type='text/javascript'>alert('{0}');window.location.replace('{1}')</script>";
    //    Response.Write(string.Format(js, message, toUrl));
    //}
}
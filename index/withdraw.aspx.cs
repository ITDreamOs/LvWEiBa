using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WeixinApiClass;

public partial class index_withdraw : System.Web.UI.Page
{
    string openid = "oZMY8t07V1LpLYqJCsyHgPZ3KtS4";
    protected string yue = "0.00";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["openid"] == null)
        {
            if (string.IsNullOrEmpty(Request.QueryString["code"]))
            {
                Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/withdraw.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");

            }

            else
            {
                string code = Request.QueryString["code"];
                openid = new WEIxinUserApi().GetUserOpenid(code);

                if (openid.Length < 10)
                {
                    Response.Redirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/withdraw.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect");
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
            LVWEIBA.Model.MemberList mmm = new LVWEIBA.Model.MemberList();
            mmm = new LVWEIBA.DAL.MemberList().GetModel(openid);
            if (mmm == null)
            { yue = "0.00"; }
            else
            {
                yue = mmm.Money.ToString();
            }
            LVWEIBA.BLL.MemberBankCard bll = new LVWEIBA.BLL.MemberBankCard();
            List<LVWEIBA.Model.MemberBankCard> lst = bll.GetModelList(" MemberID ='" + openid + "'");
            string str = "";
            int i = 0;
            string card = "";
            foreach (LVWEIBA.Model.MemberBankCard item in lst)
            {
                card = item.Card.Length > 4 ? item.Card.Substring(item.Card.Length - 4, 4) : item.Card;
                i++;
                str += string.Format(@"   
               <li class='item-content'>
               <div class='item-inner'>
               <div class='item-title'>   <input id='{0}' name='rbank' type='radio' value= '{1}' {3} /><label for='{0}'>{2}</label>
               </div>
               </div>
               </li>
             ", "radio" + i, item.ID, "尾号" + card + "的" + item.Bank + "卡", i == 1 ? "checked" : "");
            }
            this.Literal1.Text = str;
        }
    }

    protected void btn_Tj_Click(object sender, EventArgs e)
    {

        string name = Request.Form["name"];
        string card = Request.Form["card"];
        string bank = ddl_bank.SelectedValue;
        LVWEIBA.Model.MemberBankCard mdl = new LVWEIBA.Model.MemberBankCard();
        LVWEIBA.BLL.MemberBankCard bll = new LVWEIBA.BLL.MemberBankCard();
        mdl.MemberID = openid;
        mdl.Name = name;
        mdl.Card = card;
        mdl.Bank = bank;

        mdl.Bz = "";
        mdl.Lrsj = DateTime.Now;
        bll.Add(mdl);
        Response.Redirect("withdraw.aspx");
    }
    protected void btnMoney_Click(object sender, EventArgs e)
    {

        LVWEIBA.BLL.MemberBankCard bllbank = new LVWEIBA.BLL.MemberBankCard();

        int rbank = int.Parse(Request.Form["rbank"]);
        LVWEIBA.Model.MemberBankCard mdl = bllbank.GetModel(rbank);
        LVWEIBA.BLL.MemberMoney bll = new LVWEIBA.BLL.MemberMoney();
        LVWEIBA.Model.MemberMoney model = new LVWEIBA.Model.MemberMoney();
        string money = Request.Form["money"];
        decimal Money = decimal.Parse(money);
        model.MemberID = openid;
        model.Money = -Money;
        model.Method = "4";//提现
        model.Bz = mdl.Name + "   " + mdl.Bank + "   " + mdl.Card;
        model.Sj = DateTime.Now;
        model.Type = "1";//会员
        model.CheckTime = DateTime.Now;
        model.IsCheck = "0";
        //新增提现记录
        bll.Add(model);

        //修改会员帐号余额
        LVWEIBA.BLL.MemberList bllMem = new LVWEIBA.BLL.MemberList();
        LVWEIBA.Model.MemberList mmem = bllMem.GetModel(openid);
        mmem.Money = mmem.Money - Money;
        bllMem.Update(mmem);

        BaseClass.Common.Jscript.AlertAndRedirect("提现成功，将从现金帐户扣减，需要24小时到提现的银行卡，请耐心等待！", "Myindex.aspx");
        
    }
}
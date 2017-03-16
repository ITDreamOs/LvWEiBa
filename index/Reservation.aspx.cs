using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Services;
using WeixinApiClass;
using LVWEIBA.Model;

public partial class index_Reservation : System.Web.UI.Page
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
        uid.Value = openid;
        if (!IsPostBack)
        {
            ShowInfo(openid);
        }
    }
    [WebMethod]
    public static string Del(string id, string num)
    {
        LVWEIBA.BLL.Reservation bll = new LVWEIBA.BLL.Reservation();
        LVWEIBA.Model.Reservation model = bll.GetModel(id);
        bool isDel = false;
        switch (num)
        {
            case "1":
                if (string.IsNullOrEmpty(model.Place2) && string.IsNullOrEmpty(model.Place3))//如果其它两个目的地为空，则删除
                {
                    isDel = true;
                }
                model.Place1 = "";
                break;
            case "2":

                if (string.IsNullOrEmpty(model.Place1) && string.IsNullOrEmpty(model.Place3))
                {
                    isDel = true;
                }
                model.Place2 = "";
                break;
            case "3":
                if (string.IsNullOrEmpty(model.Place2) && string.IsNullOrEmpty(model.Place1))
                {
                    isDel = true;
                }
                model.Place3 = "";
                break;
        }
        if (isDel)
        {
            bll.Delete(id);
        }
        else
        {
            bll.Update(model);
        }
        return "";
    }
    private void ShowInfo(string Member)
    {
        LVWEIBA.BLL.Reservation bll = new LVWEIBA.BLL.Reservation();
        LVWEIBA.Model.Reservation model = bll.GetModel(Member);

        StringBuilder str = new StringBuilder();
        if (model != null)
        {
            //  onclick="del('4','1')"
            string begin = model.BeginTime.ToString("yyyy.MM.dd");
            string end = model.EndTime.ToString("yyyy.MM.dd");
            str.Append("<ul class=\"rereserved\">");
            if (!string.IsNullOrEmpty(model.Place1))
            {
                str.AppendFormat(" <li>{0}<span>{1}-{2}</span><i onclick=\"del('{3}','1')\" class=\"iconfont\">&#xe63d;</i></li>", model.Place1, begin, end, model.Member);
            }
            if (!string.IsNullOrEmpty(model.Place2))
            {
                str.AppendFormat(" <li>{0}<span>{1}-{2}</span><i onclick=\"del('{3}','2')\" class=\"iconfont\">&#xe63d;</i></li>", model.Place2, begin, end, model.Member);
            }
            if (!string.IsNullOrEmpty(model.Place3))
            {
                str.AppendFormat(" <li>{0}<span>{1}-{2}</span><i onclick=\"del('{3}','3')\" class=\"iconfont\">&#xe63d;</i></li>", model.Place3, begin, end, model.Member);
            }
            str.Append("</ul>");
            txt_Place1.Value = model.Place1;
            txt_Place2.Value = model.Place2;
            txt_Place3.Value = model.Place3;
            txt_Mobile.Value = model.Mobile;
            hid_id.Value = model.Id.ToString();
        }
        else
        {
            str.Append(@"  <div class='not_reservation'>
                            <i class='iconfont'>&#xe640;</i>
                            <p>您目前还没有预约的尾单</p>
                            </div>");
        }
        Literal1.Text = str.ToString();
    }

    protected void btn_Tj_Click(object sender, EventArgs e)
    {
        System.Collections.Specialized.NameValueCollection nc = new System.Collections.Specialized.NameValueCollection(Request.Form);
        string txt_Begin = nc.GetValues("txt_Begin")[0].ToString();
        string txt_End = nc.GetValues("txt_End")[0].ToString();

        LVWEIBA.Model.Reservation model = new LVWEIBA.Model.Reservation();
        model.Place1 = txt_Place1.Value;
        model.Place2 = txt_Place2.Value;
        model.Place3 = txt_Place3.Value;
        openid = Request.Form["uid"];
        if (!string.IsNullOrEmpty(txt_Begin))
        {
            model.BeginTime = Convert.ToDateTime(txt_Begin);
        }
        else
        {
            model.BeginTime = DateTime.Now;
        }
        if (!string.IsNullOrEmpty(txt_End))
        {
            model.EndTime = Convert.ToDateTime(txt_End);
        }
        else
        {
            model.EndTime = DateTime.Now;
        }
        model.Mobile = txt_Mobile.Value;
        model.Member = openid;

        LVWEIBA.BLL.Reservation bll = new LVWEIBA.BLL.Reservation();
        bool isOK = false;
        isOK = bll.Add(model) > 0 ? true : false;

        //if (bll.Exists(userId))
        //{
        //    model.Id = int.Parse(hid_id.Value);
        //    isOK = bll.Update(model);
        //}
        //else
        //{
        //    isOK = bll.Add(model) > 0 ? true : false;
        //}
        if (isOK)
        {
            string rdd = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + GetWeiXinInf.appid + "&redirect_uri=http://wx.lvwei8.com/index/myindex.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect";

            BaseClass.Common.Jscript.AlertAndRedirect("提交成功！谢谢您的参与！", rdd);
        }
    }
}
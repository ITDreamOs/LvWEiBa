using BaseClass.Common;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class weixin_Vip_Chongzhi_notify : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string postStr = "";
        TXT_Help th = new TXT_Help();

        if (Request.HttpMethod.ToLower() == "post")
        {
            Stream s = System.Web.HttpContext.Current.Request.InputStream;
            byte[] b = new byte[s.Length];
            s.Read(b, 0, (int)s.Length);
            postStr = Encoding.UTF8.GetString(b);
            th.ReFreshTXT(postStr, "D:\\msgweixin\\Post" + DateTime.Now.ToString("mddhhmmssffff") + ".txt");

            XmlHelp xh = new XmlHelp();
            SortedDictionary<string, string> sParams = xh.GetInfoFromXml(postStr);
            if (sParams["return_code"].ToString() == "SUCCESS")
            {
                BaseClass.Dal.ChongzhiLog sl = new BaseClass.Dal.ChongzhiLog();
                if (sl.CZisok(sParams["out_trade_no"].ToString(), sParams["openid"].ToString()))
                {
                    string mid = sParams["openid"].ToString();

                    decimal money = decimal.Parse(sParams["cash_fee"].ToString()) / 100;
                    LVWEIBA.Model.MemberMoney modelMoney = new LVWEIBA.Model.MemberMoney();
                    LVWEIBA.BLL.MemberMoney bllMoney = new LVWEIBA.BLL.MemberMoney();
                    modelMoney.MemberID = mid;
                    modelMoney.Money = money;
                    modelMoney.Method = "3";//微信充值
                    modelMoney.Bz = "客户微信充值";
                    modelMoney.Sj = DateTime.Now;
                    bool isOKM = false;
                    isOKM = bllMoney.Add(modelMoney);

                    bool isOK = false;
                    LVWEIBA.Model.MemberList model = new LVWEIBA.Model.MemberList();
                    LVWEIBA.BLL.MemberList bll = new LVWEIBA.BLL.MemberList();

                    if (bll.Exists(mid))
                    {
                        model = bll.GetModel(mid);
                        model.Money = model.Money + money;
                        isOK = bll.Update(model);
                    }
                    else
                    {
                        model.MemberId = mid;
                        model.Money = money;
                        isOK = bll.Add(model);
                    }




                }
                else
                {
                    th.ReFreshTXT(postStr, "D:\\msg\\zhifuErr\\", "错误CZ" + DateTime.Now.ToString("yyMMddHHmmssff") + ".txt");

                }


            }
            Response.End();

        }

    }
    private void WriteContent(string str)
    {
        Response.Output.Write(str);
    }
}
<%@ WebHandler Language="C#" Class="CouponList" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;
using BaseClass.Common;
using System.IO;

public class CouponList : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            context.Response.ContentType = "text/plain";
            var userId = Common.InputText(context.Request.Form["openid"], 40);
            decimal orderMoney = Convert.ToDecimal((context.Request.Form["orderMoney"]));
            var bllCoupon = new LVWEIBA.DAL.MemberCoupon();
            DataTable coupons = bllCoupon.GetMemberCouponList(" userid='" + userId + "'").Tables[0];
            List<couponModel> results = new List<couponModel>();
            //printLog("UserID is:" + userId);
            //printLog("Rows is" + coupons.Rows.Count);
            foreach (DataRow dr in coupons.Rows)
            {
                if ((DateTime.Parse(dr["Timeout"].ToString())) < DateTime.Now)
                {
                    //printLog(dr["Timeout"].ToString());
                    continue;
                }
                if (dr["zt"].ToString().Equals("1"))
                {
                   // printLog(dr["zt"].ToString());
                    continue;
                }
                if (Convert.ToDecimal(dr["OrderCount"].ToString()) >orderMoney)
                {
                    //printLog(Convert.ToDecimal(dr["OrderCount"].ToString()) + "订单价格:" + orderMoney);
                    continue;
                }
                //result=result+"{\"couponid\":"+dr["couponid"]+
                couponModel model = new couponModel();
                model.count = int.Parse(dr["count"].ToString());
                model.price = dr["Price"].ToString().Replace(".00","");
                model.name = dr["CouponName"].ToString();
                model.couponid = dr["couponid"].ToString();
                model.id = dr["memberCouponId"].ToString();
                //printLog("Model is:" + model.name + "price is:" + model.price + "count is:" + model.count);
                results.Add(model);
            }
            string jsonStr = JsonHelper.JsonSerializer<List<couponModel>>(results);

            //日志
            //printLog(jsonStr);

            context.Response.ContentType = "text/plain";

            context.Response.Write(jsonStr);
        }
        catch (Exception ex)
        {
            printLog(ex.Message+ex.StackTrace);
            throw;
        }

    }

    public void printLog(string content) {

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

    public class couponModel
    {
        public string id { get; set; }
        public string couponid { get; set; }
        public string name { get; set; }
        public string price { get; set; }
        public int count { get; set; }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
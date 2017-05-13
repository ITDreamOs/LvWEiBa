using BaseClass.Bll;
using BaseClass.Dal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index_Search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var code = Request["AreaCode"];
        ViewState.Add("AreaCode", code);
        var keywords = "";
        if (!IsPostBack)
        {
            var results = new List<LvULinesViewModel>();
            var sql = new StringBuilder();
            sql.Append("  and  IsDel=0 ");
            sql.Append(string.Format("  and  Enddate >='{0}' ", DateTime.Now));
            if (!string.IsNullOrEmpty(code))
            {
                var area = DbHelperSQL.Query(string.Format("select * from area where Code='{0}'", code));
                if (area != null && area.Tables[0] != null && area.Tables[0].Rows.Count > 0)
                {
                    var areaName = area.Tables[0].Rows[0]["Name"].ToString();
                    if (!string.IsNullOrEmpty(areaName))
                    {
                        areaName = areaName.Replace("市", "").Replace("区", "");
                        sql.Append(string.Format(" and Splace like '%{0}' ", areaName));
                    }
                }
            }

            if (!string.IsNullOrEmpty(keywords))
            {
                sql.Append(string.Format(" and Splace like '%{0}%' or TTl like '%{0}%' ", keywords));
            }
            var totalRecord = 0;
            FenYe fy = new FenYe();
            DataTable listdb = fy.GetList("LvULines", "id,Kindof,TTl,Dayscount,Sdate,Enddate,Splace,MainPoint,ProNumCode,adultTicketCount,adultTicketPrice,adultSellPrice,adultzkPrice,puppyTicketCount,puppyTicketPrice,puppySellPrice,puppyzkCount,PuppyLine,Spic,IsTuijian,Isdel,Provider,Providerid,LineMaster,LineMasterTel,LineMasterMoble,Leader,LeaderMobil,JIheTime,JiHePlace,Bianhao", "id desc", 1, 1000, sql.ToString(), out totalRecord);

            if (listdb == null)
            {
                return;
            }
            for (int i = 0; i < listdb.Rows.Count; i++)
            {
                var model = listdb.Rows[i];
                var result = new LvULinesViewModel();
                result.id = (int)model["id"];
                result.Kindof = (string)model["Kindof"];
                result.TTl = (string)model["TTl"];
                result.Dayscount = (Byte?)model["Dayscount"];
                result.Sdate = (DateTime?)model["Sdate"];
                result.Enddate = (DateTime?)model["Enddate"];
                result.Splace = (string)model["Splace"];
                result.MainPoint = (string)model["MainPoint"];
                result.ProNumCode = (string)model["ProNumCode"];

                result.adultTicketCount = (int?)model["adultTicketCount"];
                result.adultTicketPrice = (int?)model["adultTicketPrice"];
                result.adultSellPrice = (int?)model["adultTicketPrice"];
                result.adultzkPrice = (int?)model["adultzkPrice"];
                result.puppyTicketCount = (int?)model["puppyTicketCount"];
                result.puppyTicketPrice = (int?)model["puppyTicketPrice"];
                result.puppySellPrice = (int?)model["puppySellPrice"];
                result.puppyzkCount = (int?)model["puppyzkCount"];
                result.PuppyLine = (string)model["PuppyLine"];

                result.Spic = (string)model["Spic"];

                result.IsTuijian = model["IsTuijian"] == null ? 0 : (int.Parse(model["IsTuijian"].ToString()));
                result.Isdel = model["Isdel"] == null ? 0 : (int.Parse(model["Isdel"].ToString()));
                result.Provider = (string)model["Provider"];
                result.Providerid = (int?)model["Providerid"];
                result.LineMaster = (string)model["LineMaster"];
                result.LineMasterTel = (string)model["LineMasterTel"];
                result.LineMasterMoble = (string)model["LineMasterMoble"];
                result.Leader = (string)model["Leader"];
                result.LeaderMobil = (string)model["LeaderMobil"];
                result.JIheTime = (string)model["JIheTime"];
                result.JiHePlace = (string)model["JiHePlace"];
                result.Bianhao = (string)model["Bianhao"];
                var propic = GetViewList(string.Format(" ProNumCode = '{0}'", result.ProNumCode));
                if (propic.Tables[0] != null && propic.Tables[0].Rows.Count > 0)
                {
                    var picstr = propic.Tables[0].Rows[0]["Spicc"];
                    if (picstr != null && !string.IsNullOrEmpty(picstr.ToString()))
                    {
                        result.LinePic = picstr.ToString();
                    }
                }
                results.Add(result);

                ViewState["List"] = results;
                ViewState["IsFirst"] =true;

            }



        }
        else {
            IsFirst.Value = "2";
            ViewState["List"] = new List<LvULinesViewModel>();
            ViewState["IsFirst"] = false;

        }

    }
    private DataSet GetViewList(string strWhere)
    {
        StringBuilder strSql = new StringBuilder();
        strSql.Append("SELECT [Spicc],[id],[Kindof],[TTl],[Dayscount],[Sdate],[Enddate],[Splace],[MainPoint],[ProNumCode],[adultTicketCount],[adultTicketPrice],[adultSellPrice],[adultzkPrice],[puppyTicketCount],[puppyTicketPrice],[puppySellPrice],[puppyzkCount],[PuppyLine],[Spic],[IsTuijian],[Isdel],[Provider],[Providerid],[LineMaster],[LineMasterTel],[LineMasterMoble],[Leader],[LeaderMobil],[JIheTime],[JiHePlace],[Bianhao],[KindofName] ");
        strSql.Append(" FROM [View_LvLines]");
        if (strWhere.Trim() != "")
        {
            strSql.Append(" where " + strWhere);
        }
        return DbHelperSQL.Query(strSql.ToString());
    }

    protected string typeget(string tycode)
    {
        string tpname = "";
        switch (tycode)
        {
            case "chujing":
                tpname = "出境游";
                break;
            case "guonei":
                tpname = "国内游";
                break;
            case "ziyouxing":
                tpname = "自由行";
                break;
            case "taiwan":
                tpname = "台湾游";
                break;
            case "zhoubian":
                tpname = "周边游";
                break;
            default:
                tpname = "国内游";
                break;
        }
        return tpname;
    }
    protected string Diffdatebynow(string datestr)
    {
        return new BaseClass.Common.DateTimePlus().DateDiff(Convert.ToDateTime(datestr), DateTime.Now, "hour");
    }
    protected string zhekou(string sellp, string mp)
    {
        decimal res = 10 * decimal.Parse(sellp) / decimal.Parse(mp);
        //  return Math.Round(res, 2).ToString();
        return res.ToString("0.0");
    }
    public class LvULinesViewModel
    {

        /// <summary>
        /// 主键
        /// </summary>
        public int id { get; set; }

        /// <summary>
        /// 种类
        /// </summary>
        public string Kindof { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string TTl { get; set; }
        /// <summary>
        /// 天数
        /// </summary>
        public int? Dayscount { get; set; }
        /// <summary>
        /// 开始时间
        /// </summary>
        public DateTime? Sdate { get; set; }
        /// <summary>
        /// 结束时间
        /// </summary>
        public DateTime? Enddate { get; set; }
        /// <summary>
        /// 地点
        /// </summary>
        public string Splace { get; set; }
        /// <summary>
        /// 主要 景点
        /// </summary>
        public string MainPoint { get; set; }
        /// <summary>
        /// 商品编号
        /// </summary>
        public string ProNumCode { get; set; }
        /// <summary>
        /// 成人票数(库存)
        /// </summary>
        public int? adultTicketCount { get; set; }
        /// <summary>
        /// 成人票市场价
        /// </summary>
        public int? adultTicketPrice { get; set; }
        /// <summary>
        /// 成人票售价
        /// </summary>
        public int? adultSellPrice { get; set; }
        /// <summary>
        /// 成人票折扣价
        /// </summary>
        public int? adultzkPrice { get; set; }
        /// <summary>
        /// 儿童票数（库存）
        /// </summary>
        public int? puppyTicketCount { get; set; }
        /// <summary>
        /// 儿童票市场价
        /// </summary>
        public int? puppyTicketPrice { get; set; }
        /// <summary>
        /// 儿童票成交价
        /// </summary>
        public int? puppySellPrice { get; set; }
        /// <summary>
        /// 儿童折扣价
        /// </summary>
        public int? puppyzkCount { get; set; }
        /// <summary>
        /// 儿童标准
        /// </summary>
        public string PuppyLine { get; set; }
        /// <summary>
        /// 线路图片
        /// </summary>
        public string Spic { get; set; }
        /// <summary>
        /// 是否推荐
        /// </summary>
        public int? IsTuijian { get; set; }
        /// <summary>
        /// 删除1，保留 0
        /// </summary>
        public int? Isdel { get; set; }
        /// <summary>
        /// 供应商
        /// </summary>
        public string Provider { get; set; }
        /// <summary>
        /// 线路供应商id
        /// </summary>
        public int? Providerid { get; set; }
        /// <summary>
        /// 线路负责人
        /// </summary>
        public string LineMaster { get; set; }
        /// <summary>
        /// 负责人固话
        /// </summary>
        public string LineMasterTel { get; set; }
        /// <summary>
        /// 负责人手机号
        /// </summary>
        public string LineMasterMoble { get; set; }
        /// <summary>
        /// 导游
        /// </summary>
        public string Leader { get; set; }
        /// <summary>
        /// 导游手机号
        /// </summary>
        public string LeaderMobil { get; set; }
        /// <summary>
        /// 集合时间
        /// </summary>
        public string JIheTime { get; set; }
        /// <summary>
        /// 集合地点
        /// </summary>
        public string JiHePlace { get; set; }
        /// <summary>
        /// 线路编号
        /// </summary>
        public string Bianhao { get; set; }
        /// <summary>
        /// 线路图片
        /// </summary>
        public string LinePic { get; set; }
    }
}
using DataMigrate.DbModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataMigrate
{
    class Program
    {
        public static void Main(string[] args)
        {
            var listWeiXinUser = GetAllWeixinUsers();
            var listUsers = GetAllMembers();
            var listgroup = listUsers.GroupBy(e => e.MemberName).Select(e=> new { key=e.Key, Count=e.Count() }).Where(e=>e.Count>1).ToList();
            var list = new List<LocalWeixinUser>();
            for (int i = 0; i < listUsers.Count; i++)
            {
                var member = listUsers[i];
                var user = listWeiXinUser.Where(e => e.openid == member.MemberId).FirstOrDefault();
                if (user != null)
                {
                    list.Add(user);
                }
            }
            Console.ReadKey();
        }


        #region 用户表整合

        public static List<MemberList> GetAllMembers()
        {

            var result = new List<MemberList>();
            var dt = SQLHelper.ExcuteTable("select * from MemberList  ");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = dt.Rows[i];
                var view = new MemberList();
                view.id = model["id"].AsOrDefault<int>();
                view.MemberId = model["MemberId"].AsOrDefault<string>();
                view.Points = model["Points"].AsOrDefault<decimal>();
                view.Rank = model["Rank"].AsOrDefault<string>();
                view.Money = model["Money"].AsOrDefault<decimal?>();
                view.Shield = model["Shield"].AsOrDefault<string>();
                view.Consume = model["Consume"].AsOrDefault<decimal?>();
                view.MemberName = model["MemberName"].AsOrDefault<string>();
                view.Card = model["Card"].AsOrDefault<string>();
                view.Mail = model["Mail"].AsOrDefault<string>();
                view.UserPwd = model["UserPwd"].AsOrDefault<string>();
                view.Bz = model["Bz"].AsOrDefault<string>();
                view.Tel = model["Tel"].AsOrDefault<string>();
                result.Add(view);

            }
            return result;
        }


        public static List<LocalWeixinUser> GetAllWeixinUsers()
        {
            var result = new List<LocalWeixinUser>();
            //  SQLHelper.ExcuteTable("select * from LocalWeixinUser  ");

            var dt = SQLHelper.ExcuteTable("select * from LocalWeixinUser  ");

            for (int i = 0; i < dt.Rows.Count; i++)
            {

                var model = dt.Rows[i];
                var view = new LocalWeixinUser();
                view.id = model["id"].AsOrDefault<int>();
                view.openid = model["openid"].AsOrDefault<string>();
                view.regtime = model["regtime"].AsOrDefault<DateTime>();
                view.pid = model["pid"].AsOrDefault<int>();
                view.Tel = model["Tel"].AsOrDefault<string>();
                view.nickname = model["nickname"].AsOrDefault<string>();
                view.headimgurl = model["headimgurl"].AsOrDefault<string>();
                view.Jifen = model["Jifen"].AsOrDefault<int>();
                view.money = model["money"].AsOrDefault<decimal>();
                view.refresh_token = model["refresh_token"].AsOrDefault<string>();
                view.vips = model["vips"].AsOrDefault<int>();
                result.Add(view);

            }

            return result;

        }
        #endregion
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataMigrate.DbModel
{
    [Serializable]
    public partial class LocalWeixinUser
    {
        public LocalWeixinUser()
        { }
        #region Model
        private int _id;
        private string _openid;
        private DateTime _regtime;
        private int _pid;
        private string _tel;
        private string _nickname;
        private string _headimgurl;
        private int _jifen = 0;
        private decimal _money = 0M;
        private string _refresh_token;
        private int _vips;

        /// <summary>
        /// 
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string openid
        {
            set { _openid = value; }
            get { return _openid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public DateTime regtime
        {
            set { _regtime = value; }
            get { return _regtime; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int pid
        {
            set { _pid = value; }
            get { return _pid; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string Tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        public string nickname
        {
            set { _nickname = value; }
            get { return _nickname; }
        }
        public string headimgurl
        {
            set { _headimgurl = value; }
            get { return _headimgurl; }
        }
        /// <summary>
        /// 
        /// </summary>
        public int Jifen
        {
            set { _jifen = value; }
            get { return _jifen; }
        }
        /// <summary>
        /// 
        /// </summary>
        public decimal money
        {
            set { _money = value; }
            get { return _money; }
        }
        /// <summary>
        /// 
        /// </summary>
        public string refresh_token
        {
            set { _refresh_token = value; }
            get { return _refresh_token; }
        }
        public int vips
        {
            set { _vips = value; }
            get { return _vips; }
        }

        #endregion Model

    }
}

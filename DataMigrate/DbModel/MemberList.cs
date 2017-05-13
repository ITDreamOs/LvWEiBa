using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataMigrate.DbModel
{ /// <summary>
  /// MemberList:实体类(属性说明自动提取数据库字段的描述信息)
  /// </summary>
    [Serializable]
    public partial class MemberList
    {
        public MemberList()
        { }
        #region Model
        private int _id;
        private string _memberid;
        private decimal _points;
        private string _rank;
        private decimal? _money;
        private string _shield;
        private decimal? _consume;
        private string _membername;
        private string _card;
        private string _mail;
        private string _userpwd;
        private string _bz;
        private string _tel;
        /// <summary>
        /// 
        /// </summary>
        /// 
        public string Tel
        {
            set { _tel = value; }
            get { return _tel; }
        }
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 会员
        /// </summary>
        public string MemberId
        {
            set { _memberid = value; }
            get { return _memberid; }
        }
        /// <summary>
        /// 积分
        /// </summary>
        public decimal Points
        {
            set { _points = value; }
            get { return _points; }
        }
        /// <summary>
        /// 等级
        /// </summary>
        public string Rank
        {
            set { _rank = value; }
            get { return _rank; }
        }
        /// <summary>
        /// 金额
        /// </summary>
        public decimal? Money
        {
            set { _money = value; }
            get { return _money; }
        }
        /// <summary>
        /// 屏蔽
        /// </summary>
        public string Shield
        {
            set { _shield = value; }
            get { return _shield; }
        }
        /// <summary>
        /// 消费
        /// </summary>
        public decimal? Consume
        {
            set { _consume = value; }
            get { return _consume; }
        }
        /// <summary>
        /// 姓名
        /// </summary>
        public string MemberName
        {
            set { _membername = value; }
            get { return _membername; }
        }
        /// <summary>
        /// 身份证
        /// </summary>
        public string Card
        {
            set { _card = value; }
            get { return _card; }
        }
        /// <summary>
        /// 邮箱
        /// </summary>
        public string Mail
        {
            set { _mail = value; }
            get { return _mail; }
        }
        /// <summary>
        /// 密码
        /// </summary>
        public string UserPwd
        {
            set { _userpwd = value; }
            get { return _userpwd; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string Bz
        {
            set { _bz = value; }
            get { return _bz; }
        }
        #endregion Model


    }
}

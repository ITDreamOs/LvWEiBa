using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataMigrate
{
    public class SQLHelper
    {
        private static readonly string conn =  ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        public static SqlConnection creatconnection()
        {
            SqlConnection con = new SqlConnection(conn);
            con.Open();
            return con;
        }
        public static int ExecuteNoQuery(string sql, params SqlParameter[] paramaters)
        {
            using (SqlConnection conne = creatconnection())
            {
                using (SqlCommand cmd = conne.CreateCommand())
                {
                    cmd.Parameters.AddRange(paramaters);
                    cmd.CommandText = sql;
                    return cmd.ExecuteNonQuery();
                }
            }
        }
        public static int ExecuteNoQuery(string sql, List<SqlParameter> paramaters)
        {
            using (SqlConnection conne = creatconnection())
            {
                using (SqlCommand cmd = conne.CreateCommand())
                {
                    foreach (SqlParameter item in paramaters)
                    {
                        cmd.Parameters.Add(item);
                    }
                    cmd.CommandText = sql;
                    return cmd.ExecuteNonQuery();
                }

            }
        }
        public static object ExcuteScalar(string sql, params SqlParameter[] paraters)
        {
            using (SqlConnection conne = creatconnection())
            {
                using (SqlCommand cmd = conne.CreateCommand())
                {
                    cmd.Parameters.AddRange(paraters);
                    cmd.CommandText = sql;
                    return cmd.ExecuteScalar();
                }
            }

        }
        public static DataTable ExcuteTable(string sql, params SqlParameter[] paraters)
        {
            using (SqlConnection conne = creatconnection())
            {
                using (SqlCommand cmd = conne.CreateCommand())
                {
                    cmd.Parameters.AddRange(paraters);
                    cmd.CommandText = sql;
                    DataTable dt = new DataTable();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        dt.Load(dr);
                    }
                    return dt;
                }
            }

        }
        public static DataTable ExcuteTable(string sql)
        {
            using (SqlConnection conne = creatconnection())
            {
                using (SqlCommand cmd = conne.CreateCommand())
                {
                    cmd.CommandText = sql;
                    DataTable dt = new DataTable();
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        dt.Load(dr);
                    }
                    return dt;
                }
            }

        }
        public static SqlDataReader ExcuteReader(SqlConnection conne, string sql)
        {
            using (SqlCommand cmd = conne.CreateCommand())
            {
                cmd.CommandText = sql;
                DataTable dt = new DataTable();
                using (SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    return dr;
                }
            }
        }
    }
}

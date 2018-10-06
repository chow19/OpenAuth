using Infrastructure;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QCTestWarningClisent.Common
{
    public class DB 
    {
        public DB()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }

        private static string conStr = "";//数据连接串

        //获取SQL连接
        public static SqlConnection getSqlConnection()
        {
            if (conStr == "")
            {
                string server = ConfigurationSettings.AppSettings["server"];
                string database = ConfigurationSettings.AppSettings["database"];
                string uid = ConfigurationSettings.AppSettings["uid"];
               
                string password = Encryption.Decrypt( ConfigurationSettings.AppSettings["pwd"]);
                conStr = String.Format(@"server={0};database={1};uid={2};pwd={3}", server, database, uid, password);
            }

            return new SqlConnection(conStr);
        }

        /// <summary>
        /// 获取SQL执行分页结果
        /// </summary>
        public DataSet getPageDataSet(string[] sql, int curPage, int pageSize, out int pageCount, out int recCount)
        {
            return getPageDataSet(sql, getCountSQL(sql), curPage, pageSize, out pageCount, out recCount);
        }

        /// <summary>
        /// 获取SQL执行分页结果(自定义Count语句)
        /// </summary>
        public DataSet getPageDataSet(string[] sql, string sql_count, int curPage, int pageSize, out int pageCount, out int recCount)
        {
            DataSet ds = new DataSet();
            pageCount = 0;
            recCount = 0;
            SqlConnection con = getSqlConnection();
            SqlCommand cmd = new SqlCommand(getPageSQL(sql, pageSize, curPage) + ";" + sql_count, con);
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
                recCount = Convert.ToInt32(ds.Tables[1].Rows[0][0]);
                pageCount = recCount / pageSize;
                if (recCount % pageSize != 0)
                {
                    pageCount++;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            return ds;
        }

        /// <summary>
        /// 获取分页SQL
        /// </summary>
        /// <param name="selectSQL"></param>
        /// <param name="orderStr"></param>
        /// <param name="pageSize"></param>
        /// <param name="curPage"></param>
        /// <returns></returns>
        private string getPageSQL(string[] selectSQL, int pageSize, int curPage)
        {
            string ret = String.Format(@"select * from (select row_number() over (order by {3}) as Row,{0} 
         from {1} where {2}) as tt where tt.Row between {4} and {5}", selectSQL[0], selectSQL[1], selectSQL[2], selectSQL[3], Convert.ToString(pageSize * (curPage - 1) + 1), Convert.ToString(pageSize * curPage));
            return ret;
        }

        /// <summary>
        /// 获取Count的SQL
        /// </summary>
        /// <param name="selectSQL"></param>
        /// <returns></returns>
        private string getCountSQL(string[] selectSQL)
        {
            return String.Format("select count(1) from {0} where {1}", selectSQL[1], selectSQL[2]);
        }
         
        public static DataTable GetOverModule() {
            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.CommandText = "getWarnMoludaName";
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable result = new DataTable();
                        adapter.Fill(result);
                        cmd.Parameters.Clear();
                        conn.Close();
                        return result;
                    }
                }

            }
            catch
            {
                return null;
                throw;

            }
        }
    }
}

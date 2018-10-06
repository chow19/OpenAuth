using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionTest.Common
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
                string password = ConfigurationSettings.AppSettings["pwd"];
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

        public static bool InsertHeadData(string Sql,HeaderData dh) {
            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    { 
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = Sql;
                        cmd.Parameters.AddWithValue("@C_QCTestScanId", dh.Id );
                        cmd.Parameters.AddWithValue("@MOName", dh.MOName);
                        cmd.Parameters.AddWithValue("@ModuleName", dh.ModuleName);
                        cmd.Parameters.AddWithValue("@TestDateTime", dh.TestDataTime);
                        cmd.Parameters.AddWithValue("@WorkStept", dh.WorkStept);
                        cmd.Parameters.AddWithValue("@CheckType", dh.CheckType);
                        cmd.Parameters.AddWithValue("@Timestamp", dh.Timestamp);
                        cmd.Parameters.AddWithValue("@FileName", dh.FileName); 
                        cmd.Parameters.AddWithValue("@FilePath", dh.FilePath);  
                        cmd.ExecuteNonQuery(); 
                        cmd.Parameters.Clear();
                        conn.Close();
                        return true;
                    }
                }

            }
            catch(Exception ex)
            {
                return false;

            }
        }
        public static bool InsertRowData(string Sql, RowData rd)
        {
            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = Sql;
                        cmd.Parameters.AddWithValue("@C_QCTestScanId", rd.HeadId);
                        cmd.Parameters.AddWithValue("@TestName", rd.TestName);
                        cmd.Parameters.AddWithValue("@TestResultValue", rd.TestResultValue);
                        cmd.Parameters.AddWithValue("@TestStdValue", rd.TestStdValue);
                        cmd.Parameters.AddWithValue("@UpLimit", rd.UpLimit);
                        cmd.Parameters.AddWithValue("@DownLimit", rd.DownLimit);
                        cmd.Parameters.AddWithValue("@Deviation", rd.Deviation);
                        cmd.Parameters.AddWithValue("@TestResult", rd.TestResult);
                        cmd.Parameters.AddWithValue("@OverValue", rd.OverValue); 
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        conn.Close();
                        return true;
                    }
                }

            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 更新提示次数
        /// </summary>
        /// <param name="Sql"></param>
        /// <param name="rd"></param>
        /// <returns></returns>
        public static bool UpdateNotifyRecord(string Sql, string NotifyContent,string C_NotifyRecordId)
        {
            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = Sql;
                        cmd.Parameters.AddWithValue("@NotifyContent", NotifyContent);
                        cmd.Parameters.AddWithValue("@C_NotifyRecordId", C_NotifyRecordId);
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        conn.Close();
                        return true;
                    }
                }

            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 更新提示次数
        /// </summary>
        /// <param name="Sql"></param>
        /// <param name="rd"></param>
        /// <returns></returns>
        public static bool CreateNotifyRecord(string Sql, string NotifyContent)
        {
            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = Sql;
                        cmd.Parameters.AddWithValue("@NotifyContent", NotifyContent); 
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                        conn.Close();
                        return true;
                    }
                }

            }
            catch
            {
                return false;
            }
        }

        public static bool IsExists(string Sql) {

            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = Sql;
                        object  res=cmd.ExecuteScalar(); 
                        conn.Close();
                        if (res==null)
                        {
                            return false;
                        }
                        return Convert.ToInt32(res)>0;  
                    }
                }

            }
            catch
            {
                return false;
            }
        }

        public static string GetSingle(string Sql)
        {

            try
            {
                using (SqlConnection conn = getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = Sql;
                        object res = cmd.ExecuteScalar();
                        conn.Close();
                        if (res == null)
                        {
                            return "";
                        }
                        return Convert.ToString(res) ;
                    }
                }

            }
            catch
            {
                return "";
            }
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
            catch(Exception EX)
            {
                return null;
                throw;

            }
        }
         
     
    }
}

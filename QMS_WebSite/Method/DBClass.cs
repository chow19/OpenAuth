using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace QMS_WebSite
{
    public class DBClass
    {
        public DBClass()
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

        public DataTable GetProductCode(string productCode)
        {
            DataTable ds = new DataTable();
            string sqlStr = string.Format(@"SELECT A.ProductDescription,B.ProductName,B.ProductShortName FROM Product A  LEFT JOIN  ProductRoot B on A.ProductRootId=B.ProductRootId WHERE ProductName='{0}' OR ProductShortName='{0}'", productCode);

            SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(sqlStr, con);
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
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

        public DataTable GetMouldCode(string Mould)
        {
            DataTable ds = new DataTable();
            string sqlStr = string.Format(@"SELECT * FROM Mould A WHERE MouldId={0} OR MouldName={0}", Mould);

            SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(sqlStr, con);
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
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
         
        public void Dispose(SqlConnection Conn)
        {
            if (Conn != null)
            {
                Conn.Close();
                Conn.Dispose();
            }
            GC.Collect();
        }
         
        /// 运行SQL语句 
        public void RunProc(string SQL)
        {
            SqlConnection Conn = getSqlConnection();
            Conn.Open();
            SqlCommand Cmd;
            Cmd = CreateCmd(SQL, Conn);
            try
            {
                Cmd.ExecuteNonQuery();
            }
            catch
            {
                throw new Exception(SQL);
            }
            finally { Dispose(Conn); }
       
            return;
        }

        /// 运行SQL语句返回DataReader 
        /// SqlDataReader对象.
        public SqlDataReader RunProcGetReader(string SQL)
        {
            SqlConnection Conn = getSqlConnection();
            Conn.Open();
            SqlCommand Cmd;
            Cmd = CreateCmd(SQL, Conn);
            SqlDataReader Dr;
            try
            {
                Dr = Cmd.ExecuteReader(CommandBehavior.Default);
            }
            catch
            {
                throw new Exception(SQL);
            }
            finally { Dispose(Conn); }
            return Dr;
        }
         
        public DataSet RunProc(string SQL, DataSet Ds, string tablename)
        {
            SqlConnection Conn = getSqlConnection();
            Conn.Open();
            SqlDataAdapter Da;
            Da = CreateDa(SQL,Conn);
            try
            {
                Da.Fill(Ds, tablename);
            }
            catch (Exception Ex)
            {
                throw Ex;
            }
            Dispose(Conn);
            return Ds;
        }

        /// 运行SQL语句,返回DataSet对象
        /// 
        /// SQL语句
        /// DataSet对象
        /// 表名
        public DataSet RunProc(string SQL, DataSet Ds, int StartIndex, int PageSize, string tablename)
        {
            SqlConnection Conn = getSqlConnection();
            Conn.Open();
            SqlDataAdapter Da;
            Da = CreateDa(SQL,Conn);
            try
            {
                Da.Fill(Ds, StartIndex, PageSize, tablename);
            }
            catch (Exception Ex)
            {
                throw Ex;
            }
            Dispose(Conn);
            return Ds;
        }

        /// 检验是否存在数据
        /// 
        /// 
        public bool ExistDate(string SQL)
        {
            SqlConnection Conn = getSqlConnection();
            Conn.Open();
            SqlDataReader Dr;
            Dr = CreateCmd(SQL, Conn).ExecuteReader();
            if (Dr.Read())
            {
                Dispose(Conn);
                return true;
            }
            else
            {
                Dispose(Conn);
                return false;
            }
        }

        /// 返回SQL语句执行结果的第一行第一列
        /// 
        /// 字符串
        public string ReturnValue(string SQL)
        {
            SqlConnection   Conn = getSqlConnection();
            Conn.Open();
            string result;
            SqlDataReader Dr;
            try
            {
                Dr = CreateCmd(SQL, Conn).ExecuteReader();
                if (Dr.Read())
                {
                    result = Dr[0].ToString();
                    Dr.Close();
                }
                else
                {
                    result = "";
                    Dr.Close();
                }
            }
            catch
            {
                throw new Exception(SQL);
            }
            Dispose(Conn);
            return result;
        }

        /// 返回SQL语句第一列,第ColumnI列,
        /// 
        /// 字符串
        public string ReturnValue(string SQL, int ColumnI)
        {
            SqlConnection  Conn = getSqlConnection();
            Conn.Open();
            string result;
            SqlDataReader Dr;
            try
            {
                Dr = CreateCmd(SQL, Conn).ExecuteReader();
            }
            catch
            {
                throw new Exception(SQL);
            }
            if (Dr.Read())
            {
                result = Dr[ColumnI].ToString();
            }
            else
            {
                result = "";
            }
            Dr.Close();
            Dispose(Conn);
            return result;
        }

        public DataSet RunProc(string procName,SqlConnection Conn, SqlParameter[] prams, DataSet Ds)
        {
            SqlCommand Cmd = CreateCmd(procName, Conn, prams);
            Cmd.CommandTimeout = 190000;        //120*1000 2分钟
            SqlDataAdapter Da = new SqlDataAdapter(Cmd);
            try
            {
                Da.Fill(Ds);
            }
            catch (Exception Ex)
            {
                throw Ex;
            }
            return Ds;
        }

        /// 生成一个存储过程使用的sqlcommand.
        /// 
        /// 存储过程名.
        /// 存储过程入参数组.
        /// sqlcommand对象.
        private SqlCommand CreateCmd(string procName, SqlConnection Conn, SqlParameter[] prams)
        { 
            SqlCommand Cmd = new SqlCommand(procName, Conn);
            Cmd.CommandType = CommandType.StoredProcedure;
            if (prams != null)
            {
                foreach (SqlParameter parameter in prams)
                {
                    if (parameter != null)
                    {
                        Cmd.Parameters.Add(parameter);
                    }
                }
            }
            return Cmd;
        }
        
        /// 生成Command对象 
        private SqlCommand CreateCmd(string SQL, SqlConnection Conn)
        {
            SqlCommand Cmd;
            Cmd = new SqlCommand(SQL, Conn);
            return Cmd;
        }

        /// 返回adapter对象 
        private SqlDataAdapter CreateDa(string SQL, SqlConnection Conn)
        { 
            SqlDataAdapter Da;
            Da = new SqlDataAdapter(SQL, Conn);
            return Da;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Method
{
    public class ExtDBClass
    {
        public ExtDBClass()
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
                string server = ConfigurationSettings.AppSettings["serverKindee"];
                string database = ConfigurationSettings.AppSettings["databaseKindee"];
                string uid = ConfigurationSettings.AppSettings["uidKindee"];
                string password = ConfigurationSettings.AppSettings["pwdKindee"];
                conStr = String.Format(@"server={0};database={1};uid={2};pwd={3}", server, database, uid, password);
            }

            return new SqlConnection(conStr);
        }
  
        
        /// 运行存储过程,返回dataset. 
        public DataSet RunProc(string procName, SqlParameter[] prams, DataSet Ds)
        {
            SqlCommand Cmd = CreateCmd(procName, prams);
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
         
        private SqlCommand CreateCmd(string procName, SqlParameter[] prams)
        {
            SqlConnection Conn = getSqlConnection(); 
            Conn.Open();
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

        private void Dispose(SqlConnection Conn)
        {
            if (Conn != null)
            {
                Conn.Close();
                Conn.Dispose();
            }
            GC.Collect();
        }
        /// 生成Command对象 
        private SqlCommand CreateCmd(string SQL, SqlConnection Conn)
        {
            SqlCommand Cmd;
            Cmd = new SqlCommand(SQL, Conn);
            return Cmd;
        }
    }
}
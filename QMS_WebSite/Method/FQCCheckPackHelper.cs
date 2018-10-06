using QMS_WebSite.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Method
{
    public class FQCCheckPackHelper
    {
        #region 获取数据
        //获取包装首检巡检可操作数据
        public string GetFQCPakeData(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();
            try
            {
                #region SQL语句条件
                string whereStr = " 1=1";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (MOName LIKE '%" + keyword + "%')";
                }
                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetFQCPackCheck", 
                /* where */ whereStr,
                /* order by */ strSort
            };
                outDataSet = dbc.getPageDataSet(sql, curPage, pageSize, out pageCount, out recCount);
                result = "0|获取成功";
            }
            catch (Exception e)
            {
                result = "1|" + e.Message;
            }
            return result;
        }
         
        //获取已检数据
        public string GetFQCDoneData(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();
            try
            {
                #region SQL语句条件
                string whereStr = " (ISNULL(QCResult, - 1)>0)";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (MOName='"+ keyword + "' OR BillNo='"+keyword+ "' OR ProductName='"+keyword+ "' OR CustomerName='"+keyword+"')";
                }
                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetFQCPackDoneCheck", 
                /* where */ whereStr,
                /* order by */ strSort
            };
                outDataSet = dbc.getPageDataSet(sql, curPage, pageSize, out pageCount, out recCount);
                result = "0|获取成功";
            }
            catch (Exception e)
            {
                result = "1|" + e.Message;
            }
            return result;
        }

        /// <summary>
        /// 根据扫描标签项获取检验Id
        /// </summary>
        /// <param name="ScanSn"></param>
        /// <returns></returns>
        public string GetFQCCheclIdByScanSn(string ScanSn)
        {

            SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(string.Format("SELECT FQCCheckPackId FROM FQCCheckPack WHERE YBBQ = '{0}'", ScanSn), con);
            try
            {
                con.Open();
                Object o = cmd.ExecuteScalar();
                if (o != null)
                {
                    return o.ToString();
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
            return "";
        }

        //获取详细数据
        public DataTable getFQCCheckDataByFQCCheckId(string FQCCheckPackId)
        {
            DataTable ds = new DataTable();
            string sqlStr = string.Format(@"SELECT * FROM V_GetFQCPackDoneCheck WHERE FQCCheckPackId='{0}'", FQCCheckPackId);

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



        //获取投料单相关项
        public DataSet GetFeedSheet(string BillNo, string LineNo)
        {
            SqlParameter[] prams = new SqlParameter[2];
            prams[0] = new SqlParameter("@订单号集", SqlDbType.VarChar, 1000);
            prams[0].Direction = ParameterDirection.Input;
            prams[0].Value = BillNo;
            prams[1] = new SqlParameter("@行号", SqlDbType.VarChar, 10);
            prams[1].Direction = ParameterDirection.Input;
            prams[1].Value = LineNo;

            ExtDBClass db = new ExtDBClass();
            DataSet ds = new DataSet();
            ds = db.RunProc("wx生产投料单_查询单据链条150319计算_打印", prams, ds);
            return ds;
        }

        #endregion

        #region 业务操作
        //包装首检巡检打印标签
        public bool PackPrintLabel(string MFPlansId, int PackCheckType,   out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.CommandText = "P_PrintFQCCheckLabel_Pack_Submit";
                        cmd.Parameters.AddWithValue("@MFPlansEntryId", MFPlansId);
                        cmd.Parameters.AddWithValue("@PackCheckType", PackCheckType); 
                        cmd.Parameters.AddWithValue("@UserId", "");
                        cmd.Parameters.AddWithValue("@ResourceId", System.Configuration.ConfigurationManager.AppSettings["DefaultResourceId"]);
                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        int ret_Value = Convert.ToInt32(cmd.Parameters["@Return"].Value);
                        returnMsg = (cmd.Parameters["@Result_Msg"].Value).ToString();
                        cmd.Parameters.Clear();
                        conn.Close();
                        if (ret_Value >= 0)
                            return true;
                        else
                            return false;
                    }
                }
            }
            catch(Exception ex)
            {
                throw;
            }
        }
          
        //保存质检临时数据
        public bool SaveTempData(string FQCCheckPackId ,string Describe,string XMLData, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.CommandText = "P_FQCPackResult_TempSave";
                        cmd.Parameters.AddWithValue("@FQCCheckPackId", FQCCheckPackId);
                        cmd.Parameters.AddWithValue("@Describe", Describe);
                        cmd.Parameters.AddWithValue("@XMLData", XMLData);

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        int ret_Value = Convert.ToInt32(cmd.Parameters["@Return"].Value);
                        returnMsg = (cmd.Parameters["@Result_Msg"].Value).ToString();
                        cmd.Parameters.Clear();
                        conn.Close();
                        if (ret_Value >= 0)
                            return true;
                        else
                            return false;
                    }
                }
            }
            catch(Exception ex)
            {
                throw;
            }
        }

        //质检质检结果数据提交 
        public bool CheckResultSubmit(string FQCCheckPackId, string Describe, string XMLData,int QCResult, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.CommandText = "P_FQCPackResult_Submit";
                        cmd.Parameters.AddWithValue("@FQCCheckPackId", FQCCheckPackId);
                        cmd.Parameters.AddWithValue("@Describe", Describe);
                        cmd.Parameters.AddWithValue("@XMLData", XMLData);
                        cmd.Parameters.AddWithValue("@QCResult", QCResult);
                        cmd.Parameters.AddWithValue("@ResourceId", System.Configuration.ConfigurationManager.AppSettings["DefaultResourceId"]);

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        int ret_Value = Convert.ToInt32(cmd.Parameters["@Return"].Value);
                        returnMsg = (cmd.Parameters["@Result_Msg"].Value).ToString();
                        cmd.Parameters.Clear();
                        conn.Close();
                        if (ret_Value >= 0)
                            return true;
                        else
                            return false;
                    }
                }
            }
            catch (Exception EX)
            {
                throw;
            }
        }
        #endregion
    }
}
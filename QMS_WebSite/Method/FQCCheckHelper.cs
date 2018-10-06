using QMS_WebSite.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

namespace QMS_WebSite.Method
{
    public class FQCCheckHelper
    {
        #region 获取数据
      
        //获取FQC抽检数据
        public string GetFQCSpementData(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();
            try
            {
                #region SQL语句条件
                string whereStr = "  (ISNULL(dbo.FQCCheck.QCResult, - 1) <= 0)";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (MOName LIKE '%" + keyword + "%')  ";
                }
                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetFQCCheck", 
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
                string whereStr = " (ISNULL(dbo.FQCCheck.QCResult, - 1)>0)";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (MOName LIKE '%" + keyword + "%')  ";
                }
                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetFQCDoneCheck", 
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

        //获取抽样数据头数据
        public DataTable getFQCCheckDataByFQCCheckId(string FQCCheckId)
        {
            DataTable ds = new DataTable();
            string sqlStr = string.Format(@"SELECT * FROM V_GetFQCDoneCheck WHERE FQCCheckId='{0}'", FQCCheckId);

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
 
        /// <summary>
        /// 根据扫描项获取检验Id
        /// </summary>
        /// <param name="ScanSn"></param>
        /// <returns></returns>
        public string GetFQCCheclIdByScanSn(string ScanSn)
        {
            
            SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(string.Format("SELECT FQCCheckId FROM FQCCheck WHERE YBBQ = '{0}'", ScanSn), con);
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

      
        #endregion

        #region 业务操作
      
        //FQC抽检打印标签
        public bool FQCSpecimentPrintLabel(string SpecimentId, string CYFS, string Describe, string ScanSN, out string returnMsg)
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
                        cmd.CommandText = "P_FQCSpeciment_Print_Submit";
                        cmd.Parameters.AddWithValue("@SpecimentId", SpecimentId);
                        cmd.Parameters.AddWithValue("@CYFS", CYFS);
                        cmd.Parameters.AddWithValue("@Describe", Describe);
                        cmd.Parameters.AddWithValue("@ScanSN", ScanSN);
                        cmd.Parameters.AddWithValue("@UserId", "");

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
            catch
            {
                throw;
            }
        }

        //保存质检临时数据
        public bool SaveTempData(FQCCheckModel Model, out string returnMsg)
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
                        cmd.CommandText = "P_FQCResult_TempSave";
                        cmd.Parameters.AddWithValue("@FQCCheckId", Model.FQCCheckId);
                        cmd.Parameters.AddWithValue("@Describe", Model.Describe);
                        cmd.Parameters.AddWithValue("@XMLData", Model.XMLData);

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
            catch
            {
                throw;
            }
        }

        //质检质检结果数据提交 
        public bool CheckResultSubmit(FQCCheckModel Model, out string returnMsg)
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
                        cmd.CommandText = "P_FQCResult_Submit";
                        cmd.Parameters.AddWithValue("@FQCCheckId", Model.FQCCheckId);
                        cmd.Parameters.AddWithValue("@Describe", Model.Describe);
                        cmd.Parameters.AddWithValue("@QCResult", Model.QCResult);
                        cmd.Parameters.AddWithValue("@XMLData", Model.XMLData);
                        cmd.Parameters.AddWithValue("@ResourceId", System.Configuration.ConfigurationManager.AppSettings["DefaultResourceId"]);
                        cmd.Parameters.AddWithValue("@AcceptQty", Model.AcceptQty);
                        cmd.Parameters.AddWithValue("@NGQty", Model.NGQty);
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
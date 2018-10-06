using QMS_WebSite.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Method
{
    public class OQCCheckHelper
    {

        #region 获取数据
        public string GetOQCCheckTodo(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " QCResult=0";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (SourceBillNo LIKE '%" + keyword + "%' OR YBBQ LIKE '%" + keyword + "%' OR ProductShortName LIKE '%" + keyword + "%')";
                }

                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetOQCCheck", 
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

        public string GetOQCCheckDone(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " QCResult>0";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (SourceBillNo LIKE '%" + keyword + "%' OR YBBQ LIKE '%" + keyword + "%' OR ProductShortName LIKE '%" + keyword + "%')";
                }

                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetOQCCheck", 
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

        public DataTable GetCheckInfo(string OQCCheckId)
        {
            DataTable ds = new DataTable();
            string sqlStr = @"SELECT * FROM V_GetOQCCheck WHERE OQCCheckId='" + OQCCheckId + "'";

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
        #endregion 

        #region 业务相关 提交数据 
        public bool PrintLabel(string SEOutStockEntryId, out string returnMsg)
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
                        cmd.CommandText = "P_PrintOQCCheckLabel_Submit";
                        cmd.Parameters.AddWithValue("@SEOutStockEntryId", SEOutStockEntryId);
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

        public bool CheckResultSubmit(OQCCheckModel Model, out string returnMsg)
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
                        cmd.CommandText = "P_OQCCheckResult_Submit";
                        cmd.Parameters.AddWithValue("@OQCCheckId", Model.OQCCheckId);
                        cmd.Parameters.AddWithValue("@Describe", Model.Describe);
                        cmd.Parameters.AddWithValue("@QCResult", Model.QCResult);
                        cmd.Parameters.AddWithValue("@XMLData", Model.XMLData);
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

        public bool SaveTempData(OQCCheckModel Model, out string returnMsg)
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
                        cmd.CommandText = "P_OQCCheckResult_TempSave";
                        cmd.Parameters.AddWithValue("@OQCCheckId", Model.OQCCheckId);
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
        #endregion

    }
}
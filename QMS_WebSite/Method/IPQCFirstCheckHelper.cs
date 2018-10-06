using QMS_WebSite.Model;
using System;
using System.Data;
using System.Data.SqlClient;

namespace QMS_WebSite.Method
{
    public class IPQCFirstCheckHelper
    {

        public string GetIPQCFirstCheckTodo(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " IsDone IN(-1,0) ";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (MOName LIKE '%" + keyword + "%' OR BillNo LIKE '%" + keyword + "%' OR SpecificationName LIKE '%" + keyword + "%')";
                }

                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetIPQCFirstCheck", 
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

        public string GetIPQCFirstCheckDone(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " IsDone='1' ";
                if (!string.IsNullOrEmpty(keyword))
                {
                    whereStr += " AND (MOName LIKE '%" + keyword + "%' OR BillNo LIKE '%" + keyword + "%' OR SpecificationName LIKE '%" + keyword + "%')";
                }
                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_GetIPQCFirstCheck", 
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

        public DataTable GetSteptInfo(string wSteptId)
        {
            DataTable ds = new DataTable();
            string sqlStr = @"SELECT * FROM V_GetIPQCFirstCheck WHERE WFSteptID='" + wSteptId + "'";

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

    
        #region 业务相关 创建质检行，打印标签,保存检验结果

        public bool PrintLabel(string MFPlansId, out string returnMsg)
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
                        cmd.CommandText = "P_PrintIPQCFirstCheckLabel_Submit";
                        cmd.Parameters.AddWithValue("@MFPlansEntryId", MFPlansId);
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

        public bool CheckResultSubmit(IPQCFirstCheckModel Model, out string returnMsg) {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.CommandText = "P_IPQCCheckResult_Submit";
                        cmd.Parameters.AddWithValue("@MFPlansEntryId", Model.MFPlansId); 
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
            catch(Exception EX)
            {
                throw;
            }
        }

        public bool SaveTempData(IPQCFirstCheckModel Model, out string returnMsg) {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 120;
                        cmd.CommandText = "P_IPQCCheckResult_TempSave";
                        cmd.Parameters.AddWithValue("@MFPlansEntryId", Model.MFPlansId);
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
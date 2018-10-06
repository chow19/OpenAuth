using QMS_WebSite.Model;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace QMS_WebSite
{
    public class SendQCReport
    {
        public SendQCReport()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        /// <summary>
        /// 获取送检单列表
        /// </summary>
        /// <param name="keyword"></param>
        /// <param name="strSort"></param>
        /// <param name="pageSize">页面数据大小</param>
        /// <param name="curPage">当前页</param>
        /// <param name="pageCount">页数</param>
        /// <param name="recCount"></param>
        /// <param name="outDataSet">输出数据集</param>
        /// <returns></returns>
        public string getSendQCReportList(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " dbo.SendQCReport.SendQCReportStates = 10 ";

                ////支持多级关键字查询（如需定义多关键字，请取消以下注释，并修改程序）
                //if (keyword != "")
                //{
                //    foreach (string s in keyword.Split(" ,　".ToCharArray()))
                //    {
                //        if (s.Trim() != "")
                //            whereStr = whereStr + " and ([UserId] like '%" + s + "%' or [Descript] like '%" + s + "%' or [Descript] like '%" + s + "%' or [IP] like '%" + s + "%')  ";
                //    }
                //}

                if (strSort == "")
                {
                    strSort = "SendQCReportId desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_SendQCReport", 
                /* where */ @"QCResult=0",
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
        /// 获取送检单列表
        /// </summary>
        /// <param name="keyword"></param>
        /// <param name="strSort"></param>
        /// <param name="pageSize">页面数据大小</param>
        /// <param name="curPage">当前页</param>
        /// <param name="pageCount">页数</param>
        /// <param name="recCount"></param>
        /// <param name="outDataSet">输出数据集</param>
        /// <returns></returns>
        public string getSendQCDoneReportList(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " 1=1 ";

                ////支持多级关键字查询（如需定义多关键字，请取消以下注释，并修改程序）
                //if (keyword != "")
                //{
                //    foreach (string s in keyword.Split(" ,　".ToCharArray()))
                //    {
                //        if (s.Trim() != "")
                //            whereStr = whereStr + " and ([UserId] like '%" + s + "%' or [Descript] like '%" + s + "%' or [Descript] like '%" + s + "%' or [IP] like '%" + s + "%')  ";
                //    }
                //}

                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"*",
                /* from */ @"V_SendQCDoneReport", 
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
        /// 获取检验报告列表
        /// </summary>
        /// <param name="keyword"></param>
        /// <param name="strSort"></param>
        /// <param name="pageSize">页面数据大小</param>
        /// <param name="curPage">当前页</param>
        /// <param name="pageCount">页数</param>
        /// <param name="recCount"></param>
        /// <param name="outDataSet">输出数据集</param>
        /// <returns></returns>
        public string getSendQCReportDoneList(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                string whereStr = " 1=1 ";

                ////支持多级关键字查询（如需定义多关键字，请取消以下注释，并修改程序）
                //if (keyword != "")
                //{
                //    foreach (string s in keyword.Split(" ,　".ToCharArray()))
                //    {
                //        if (s.Trim() != "")
                //            whereStr = whereStr + " and ([UserId] like '%" + s + "%' or [Descript] like '%" + s + "%' or [Descript] like '%" + s + "%' or [IP] like '%" + s + "%')  ";
                //    }
                //}

                if (strSort == "")
                {
                    strSort = "CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"SendQCReportId, CreateDate, VendorName, REVERSE(substring(REVERSE(ProductName),1,(charindex('.',REVERSE(ProductName))-1))) AS ProductName, ProductDescription, POName, CONVERT(DECIMAL(18,1),DeliveryQty) AS DeliveryQty, IQCStatus, QCResult",
                /* from */ @"V_GetSendQCReportWithLot", 
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
        /// 根据送检单ID获取送检单详细
        /// </summary>
        /// <param name="id"></param>
        /// <param name="outDataSet"></param>
        /// <returns></returns>
        public string getSendQCReportInfo(string id, out DataSet outDataSet)
        {
            string result = "";
            outDataSet = new DataSet();
            SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(@"SELECT * FROM V_SendQCReport WHERE SendQCReportId=@Id", con);
            cmd.Parameters.Add(new SqlParameter("@Id", id));
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(outDataSet);
                result = "0|获取成功";
            }
            catch (Exception e)
            {
                result = "1|" + e.Message;
            }
            finally
            {
                con.Close();
            }
            return result;
        }
 
        /// <summary>
        /// 获取AQL参数
        /// </summary>
        /// <param name="cyfs">抽样方式</param>
        /// <param name="jcsp">检查水平</param>
        /// <param name="jybz">AQL值</param>
        /// <returns></returns>
        public DataTable getAQLInfo(string SQCId, string cyfs, string jcsp, string jybz)
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
                        cmd.CommandText = "GetAQLDataBySQCReportId";
                        //cmd.Parameters.AddWithValue("@AJDPgm", cyfs);           ///抽样方式
                        //cmd.Parameters.AddWithValue("@CKlevel", jcsp);    ///检查水平
                        //cmd.Parameters.AddWithValue("@aql", jybz);       ///AQL值 AQL
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);       ///SQCId  
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable result = new DataTable();
                        adapter.Fill(result);
                        cmd.Parameters.Clear();
                        conn.Close();
                        return result;
                    }
                }

            }
            catch (Exception ex)
            {
                return null;
                throw;

            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="cyfs"></param>
        /// <param name="jcsp"></param>
        /// <param name="jybz"></param>
        /// <returns></returns>
        public DataTable selectAQLInfo(string SQCId, string cyfs, string jcsp, string jybz)
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
                        cmd.CommandText = "P_SelAQLData";
                        cmd.Parameters.AddWithValue("@AJDPgm", cyfs);           ///抽样方式
                        cmd.Parameters.AddWithValue("@CKlevel", jcsp);    ///检查水平
                        cmd.Parameters.AddWithValue("@aql", jybz);       ///AQL
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);       ///AQL值  
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

        /// <summary>
        /// 样本抽样页面加载
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public DataTable SpecPageLoad(string SQCId)
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
                        cmd.CommandText = "P_GetSQCData_New";
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);       ///AQL值  
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
         
        /// <summary>
        /// 样本抽样页面加载
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public DataTable SpecCheckPageLoad(string SQCId)
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
                        cmd.CommandText = "P_GetSQIQCCheckData";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SQCId);
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

        /// <summary>
        /// 获取样本扫描列表
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public DataTable getScanList(string SQCId)
        {
            string sqlStr = @"SELECT LotId,LotSN, CYFS,CYSP,CYBZ ,cast( SpecQty as int) as SpecQty  FROM SpecimentItem LEFT JOIN dbo.Speciment ON Speciment.SpecimentId = SpecimentItem.SpecimentId
                        WHERE SendQCReportId = '" + SQCId + "'";
            DataTable result = new DataTable();
            using (SqlConnection conn = DBClass.getSqlConnection())
            {
                conn.Open();
                using (SqlDataAdapter sqlAda = new SqlDataAdapter(sqlStr, conn))
                {
                    sqlAda.SelectCommand.CommandTimeout = 500;
                    sqlAda.Fill(result);
                    conn.Close();
                }
            }
            return result;
        }
         
        /// <summary>
        /// 抽样数据提交
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="CYFS"></param>
        /// <param name="JCSP"></param>
        /// <param name="JYBZ"></param>
        /// <param name="ScanSN"></param>
        /// <param name="CQ_Qty"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool SPec_ScanSubmit(string SQCId, string CYFS, string JCSP, string JYBZ, string ScanSN, string CQ_Qty, out string returnMsg)
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
                        cmd.CommandText = "P_Speciment_Submit";
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);
                        cmd.Parameters.AddWithValue("@CYFS", CYFS);
                        cmd.Parameters.AddWithValue("@JCSP", JCSP);
                        cmd.Parameters.AddWithValue("@JYBZ", JYBZ);
                        cmd.Parameters.AddWithValue("@ScanSN", ScanSN);
                        cmd.Parameters.AddWithValue("@CQ_Qty", CQ_Qty);
                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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

        /// <summary>
        /// 抽样检验结果提交
        /// </summary> 
        /// <returns></returns>
        public bool SPec_SQCheckResultSubmit(SOCheckResultModel model, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "P_SQIQCCheckResult_Submit";
                        cmd.Parameters.AddWithValue("@CheckResult", model.CheckResult);
                        cmd.Parameters.AddWithValue("@DefaultPath", model.DefaultPath);
                        cmd.Parameters.AddWithValue("@ResourceId", System.Configuration.ConfigurationManager.AppSettings["DefaultResourceId"]);
                        cmd.Parameters.AddWithValue("@SendQCReportId", model.SendQCReportId);
                        cmd.Parameters.AddWithValue("@UserId", model.UserId);
                        cmd.Parameters.AddWithValue("@CheckType", model.CheckType);
                        cmd.Parameters.AddWithValue("@XMLData", model.XMLData);

                        cmd.Parameters.AddWithValue("@AcceptQty", model.AcceptQty);
                        cmd.Parameters.AddWithValue("@NGQty", model.NGQty);
                        cmd.Parameters.AddWithValue("@Describe", model.Describe);

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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
         
        /// <summary>
        /// 删除扫描记录
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public bool delScanList(string SQCId, string lotSN, out string returnMsg)
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
                        cmd.CommandText = "P_DelSQCData";
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);
                        cmd.Parameters.AddWithValue("@LotSN", lotSN);
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

        /// <summary>
        /// 打印样本标签
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool PrintSQCLabels(string SQCId,string  Describe, out string returnMsg)
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
                        cmd.CommandText = "P_PrintSQCLabels_New";
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);
                        cmd.Parameters.AddWithValue("@Describe", Describe); 
                        cmd.Parameters.AddWithValue("@UserId",  "");
                       
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


        /// <summary>
        /// 重新打印样本标签
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool RePrintSQCLabels(string SQCId, string Describe, out string returnMsg)
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
                        cmd.CommandText = "P_RePrintSQCLabels";
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);
                        cmd.Parameters.AddWithValue("@Describe", Describe);
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


        /// <summary>
        /// 第一次抽样
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool FirstSpeciment(string SQCId, string CYFS, string JCSP, string JYBZ,string JYBZ2 ,string ScanSN, decimal Qty, out string returnMsg)
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
                        cmd.CommandText = "P_FirstSpeciment";
                        cmd.Parameters.AddWithValue("@SQCId", SQCId);
                        cmd.Parameters.AddWithValue("@CYFS", CYFS);
                        cmd.Parameters.AddWithValue("@JCSP", JCSP);
                        cmd.Parameters.AddWithValue("@JYBZ", JYBZ);
                        cmd.Parameters.AddWithValue("@JYBZ2", JYBZ2);
                        
                        cmd.Parameters.AddWithValue("@ScanSN", ScanSN);
                        cmd.Parameters.AddWithValue("@CQ_Qty", Qty);
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

        /// <summary>
        /// 根据送检单获取 原材料检验列表
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="outDataSet"></param>
        /// <returns></returns>
        public DataTable GetRMIQCCheckInfo(string SQCId)
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
                        cmd.CommandText = "P_GetRawMaterialIQCCheckInfo";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SQCId);
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

        /// <summary>
        /// 原材料检验数据提交
        /// </summary>
        /// <param name="model"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool SPec_SQRMCheckResultSubmit(RawMaterialIQCCheckModel model, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "P_RawMaterialIQCCheckSubmit";
                        cmd.Parameters.AddWithValue("@CheckResult", model.CheckResult);
                        cmd.Parameters.AddWithValue("@DefaultPath", "upload");
                        cmd.Parameters.AddWithValue("@FactoryId", model.FactoryId);
                        cmd.Parameters.AddWithValue("@SendQCReportId", model.SendQCReportId);
                        cmd.Parameters.AddWithValue("@RawMaterialIQCCheckId", model.RawMaterialIQCCheckId);
                        cmd.Parameters.AddWithValue("@XMLData", model.XMLData);


                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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

        /// <summary>
        /// 原材料检验数据记录行添加
        /// </summary>
        /// <param name="model"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool SPec_SQRMCheckResultScanAddSubmit(RawMaterialIQCCheckModel model, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "P_RawMaterialIQCCheckAddSubmit";
                        cmd.Parameters.AddWithValue("@SendQCReportId", model.SendQCReportId);
                        cmd.Parameters.AddWithValue("@ScanSN", model.ScanSN);
                        cmd.Parameters.AddWithValue("@Qty", model.Qty);

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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

        /// <summary>
        /// 获取原材料检验详细
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="RMId"></param>
        /// <returns></returns>
        public DataTable GetSQRMCheckResultDetailData(string SQCId, string RMId)
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
                        cmd.CommandText = "P_GetSQRMCheckResultDetailData";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SQCId);
                        cmd.Parameters.AddWithValue("@RawMaterialIQCCheckId", RMId);
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable result = new DataTable();
                        adapter.Fill(result);
                        cmd.Parameters.Clear();
                        conn.Close();
                        return result;
                    }
                }

            }
            catch (Exception ex)
            {

                throw;

            }
        }

        /// <summary>
        /// 删除原材料检验记录 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool SPec_SQRMCheckResultDel(string RMId, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "P_RawMaterialIQCCheckDelete";
                        cmd.Parameters.AddWithValue("@RawMaterialIQCCheckId", RMId);

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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
            catch (Exception ex)
            {
                throw;

            }
        }

        /// <summary>
        /// 加抽
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="ExtQty"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool SPec_Speciment_ExtRecordSubmit(string SQCId, decimal ExtQty, out string returnMsg)
        { 
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "Speciment_ExtRecordSubmit";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SQCId);
                        cmd.Parameters.AddWithValue("@ExtQty", ExtQty);
                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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
            catch (Exception ex)
            {
                throw;
            }
        }

        /// <summary>
        /// 根据送检单获取加抽数据列表
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns> 
        public DataTable GetRMExtRecordList(string SQCId)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT  Speciment_ExtRecordId  ,SpecimentId ,CheckNo ,CreateDate  ,XMLData  ,SendQCReportId ,ExtQty ,IsDone,Describe ");
            sb.Append("FROM  dbo.Speciment_ExtRecord ");
            sb.Append("WHERE SendQCReportId = '" + SQCId + "' ");
            try
            {
                DataSet ds = new DataSet();
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = sb.ToString();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(ds);
                        conn.Close(); 
                        return ds.Tables[0]; 
                    }
                }

            }
            catch (Exception ex)
            {
                throw;
            }

        }

        /// <summary>
        /// 玻璃加抽提交
        /// </summary>
        /// <param name="SQCId"></param>
        /// <param name="Describe"></param>
        /// <param name="xmlData"></param>
        /// <param name="ExtCheckNo"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public bool SPec_GlassExtSubmit(string SQCId, string Describe , string xmlData, string ExtCheckNo, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "GlassExtSubmit";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SQCId);
                        cmd.Parameters.AddWithValue("@xmlData", xmlData);
                        cmd.Parameters.AddWithValue("@Describe", Describe);
                        cmd.Parameters.AddWithValue("@ExtCheckNo", ExtCheckNo);
                        
                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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
            catch (Exception ex)
            {
                throw;

            }
        }
         
        /// <summary>
        /// 获取玻璃加抽数据
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
         public DataTable getExtImgXmlData(string SQCId)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT  '0' AS RetValue,XMLData  ");
            sb.Append("FROM  dbo.Speciment_ExtRecord ");
            sb.Append("WHERE SendQCReportId = '" + SQCId + "' AND CheckNo=(SELECT MAX(CheckNo) FROM  dbo.Speciment_ExtRecord WHERE SendQCReportId = '" + SQCId + "') and  IsDone=1");
            try
            {
                DataSet ds = new DataSet();
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = sb.ToString();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(ds);
                        conn.Close();
                        return ds.Tables[0];
                    }
                }

            }
            catch (Exception ex)
            {
                throw;
            }
           
        }

        /// <summary>
        /// 根据产品名称获取检验项目
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public DataTable getIQCCheckItemByPID(string PID)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT  '0' AS RetValue,B.IQC_CheckItemName,B.IQC_CheckItemValueType,B.IQC_CheckItemStdValue,B.IQC_CheckItemStdDownLimit,B.IQC_CheckItemStdUpLimit,A.ProductId  ");
            sb.Append("FROM    Product  A ");
            sb.Append("        LEFT JOIN IQC_CheckItem B ON  ISNULL(A.IQC_CheckId,'')=B.IQC_CheckItemRootId ");
            //sb.Append("        LEFT JOIN IQC_CheckItemDetails C ON  C.IQC_CheckDItemId = B.IQC_CheckItemId ");
            sb.Append("WHERE ISNULL(A.IQC_CheckId, '') != '' AND A.ProductId ='"+ PID + "'");

            try
            {
                DataSet ds = new DataSet();
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {

                        cmd.CommandType = CommandType.Text;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = sb.ToString();
                        SqlDataAdapter sda = new SqlDataAdapter(cmd);
                        sda.Fill(ds);
                        conn.Close();
                        return ds.Tables[0];
                    }
                }

            }
            catch (Exception ex)
            {
                throw;
            }

        }
         
        /// <summary>
        /// 保存IQC玻璃项数据临时保存
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public bool SPec_SaveIQCRMCheckResultTempXmlData(string SendQCReportId,string RawMaterialIQCCheckId,string XMLData,out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "SaveIQCRMCheckResultTempXmlData";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SendQCReportId);
                        cmd.Parameters.AddWithValue("@RawMaterialIQCCheckId", RawMaterialIQCCheckId);
                        cmd.Parameters.AddWithValue("@XMLData", XMLData);

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output; 
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

        /// <summary>
        /// 保存IQC数据临时保存
        /// </summary>
        /// <param name="SQCId"></param>
        /// <returns></returns>
        public bool SPec_SaveIQCCheckResultTempXmlData(string SendQCReportId, string XMLData, out string returnMsg)
        {
            try
            {
                using (SqlConnection conn = DBClass.getSqlConnection())
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandTimeout = 520;
                        cmd.CommandText = "SaveIQCCheckResultTempXmlData";
                        cmd.Parameters.AddWithValue("@SendQCReportId", SendQCReportId); 
                        cmd.Parameters.AddWithValue("@XMLData", XMLData); 

                        cmd.Parameters.Add("@Result_Msg", SqlDbType.NVarChar, 300).Direction = ParameterDirection.Output;
                        cmd.Parameters.Add("@Return", SqlDbType.NVarChar, 20).Direction = ParameterDirection.Output;
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
 
        /// <summary>
        /// 删除原材料检验记录 
        /// </summary>
        /// <param name="model"></param>
        /// <param name="returnMsg"></param>
        /// <returns></returns>
        public DataTable SPec_GetPrintData(string SQCId, string YBBQ )
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
                        cmd.CommandText = "P_GetPrintData";
                        cmd.Parameters.AddWithValue("@YBBQ", YBBQ);
                        cmd.Parameters.AddWithValue("@SendQCReportId", SQCId);
                        cmd.Parameters.AddWithValue("@UserId", "");
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable result = new DataTable();
                        adapter.Fill(result);
                        cmd.Parameters.Clear();
                        conn.Close();
                        return result;
                    }
                }

            }
            catch (Exception ex)
            {

                throw;

            }
            
        }

        /// <summary>
        /// 根据扫描项获取检验Id
        /// </summary>
        /// <param name="ScanSn"></param>
        /// <returns></returns>
        public string GetIQCCheclIdByScanSn(string ScanSn)
        {

            SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(string.Format("  SELECT TOP 1 A.SendQCReportId FROM  Speciment A LEFT JOIN Speciment_ExtRecord B ON A.SpecimentId=B.SpecimentId WHERE isnull(a.YBSN,'')= '{0}'", ScanSn), con);
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

    }

}
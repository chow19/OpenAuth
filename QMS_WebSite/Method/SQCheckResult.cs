using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Method
{
    public class SQCheckResult
    {
        public SQCheckResult()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        /// <summary>
        /// 获取检测报告列表
        /// </summary>
        /// <param name="keyword"></param>
        /// <param name="strSort"></param>
        /// <param name="pageSize">页面数据大小</param>
        /// <param name="curPage">当前页</param>
        /// <param name="pageCount">页数</param>
        /// <param name="recCount"></param>
        /// <param name="outDataSet">输出数据集</param>
        /// <returns></returns>
        public string getSQCheckResultList(string keyword, string strSort, int pageSize, int curPage, out int pageCount, out int recCount, out DataSet outDataSet)
        {
            string result = "";
            pageCount = 0;
            recCount = 0;
            outDataSet = new DataSet();
            DBClass dbc = new DBClass();

            try
            {
                #region SQL语句条件
                //string whereStr = " dbo.SendQCReport.SendQCReportStates = 30 ";

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
                    strSort = "SQCheckResult.CreateDate desc";
                }
                #endregion

                //SQL语句数组，组合分页语句
                string[] sql = new string[] { 
                /* select */ @"SQCheckResult.*",
                /* from */ @"SQCheckResult LEFT JOIN dbo.SendQCReport ON SendQCReport.SendQCReportId = SQCheckResult.SendQCReportId", 
                /* where */ @" dbo.SendQCReport.SendQCReportStates = 30",
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
        public string getSQCheckResultInfo(string id, out DataSet outDataSet)
        {
            string result = "";
            outDataSet = new DataSet();
            System.Data.SqlClient.SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(@"SELECT * FROM SQCheckResult WHERE SQCheckResultId=@Id", con);
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
        /// 根据SendQCReportId获取SQCheckResult简介
        /// </summary>
        /// <param name="id"></param>
        /// <param name="outDataSet"></param>
        /// <returns></returns>
        public string getIQCShortStatus(string id, out DataSet outDataSet1, out DataSet outDataSet2)
        {
            string result = "";
            outDataSet1 = new DataSet();
            outDataSet2 = new DataSet();
            System.Data.SqlClient.SqlConnection con = DBClass.getSqlConnection();
            SqlCommand cmd = new SqlCommand(@"SELECT SendQCReportResultId,0 as CheckNo,CONVERT(DECIMAL(18,1),CQty) AS CQty,CheckResult FROM dbo.Speciment LEFT JOIN dbo.SQCheckResult ON SQCheckResult.SendQCReportId = Speciment.SendQCReportId WHERE Speciment.SendQCReportId=@Id", con);
            SqlCommand cmd2 = new SqlCommand(@"SELECT Speciment_ExtRecordId,CheckNo,CONVERT(DECIMAL(18,1),ExtQty) AS ExtQty,CheckResult FROM dbo.Speciment_ExtRecord WHERE Speciment_ExtRecord.SendQCReportId=@Id", con);
            cmd.Parameters.Add(new SqlParameter("@Id", id));
            cmd2.Parameters.Add(new SqlParameter("@Id", id));
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(outDataSet1);
                sda = new SqlDataAdapter(cmd2);
                sda.Fill(outDataSet2);
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

    }
}
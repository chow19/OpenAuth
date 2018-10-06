using QMS_WebSite.Method;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace QMS_WebSite.Handler
{
    /// <summary>
    /// SendQCReportList 的摘要说明
    /// </summary>
    public class SendQCReportList : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            int pageCount, recCount;
            SendQCReport SQ = new SendQCReport();
            SQCheckResult SR = new SQCheckResult();
            StringBuilder sb = new StringBuilder();
            if (CheckResultType == "1")
            {
                result.RetStr = SQ.getSendQCReportList("", "", 20, curPage, out pageCount, out recCount, out outDataSet);
                if (result.Code == 0)
                {

                    sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                    for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                    {
                        DataRow dr = outDataSet.Tables[0].Rows[i]; 
                        int SendQty = Convert.IsDBNull(dr["SendQCQty"]) ? 0 : Convert.ToInt32(dr["SendQCQty"]);
                        string json = "{" + String.Format("\"SendQCReportId\":\"{0}\",\"SendQCReportNumber\":\"{1}\",\"VendorName\":\"{2}\","
                            + "\"ProductShortName\":\"{3}\",\"ProductDescription\":\"{4}\",\"SendQCQty\":\"{5}\",\"SendDate\":\"{6}\",\"QCResult\":\"{7}\",\"POName\":\"{8}\",\"IsCYDone\":\"{9}\",\"pcName\":\"{10}\"",
                            dr["SendQCReportId"], dr["SendQCReportNumber"], dr["VendorName"], dr["ProductShortName"],
                           Convert.ToString(dr["ProductDescription"]).Replace("\"","\\\""), SendQty.ToString(), dr["SendDate"], dr["QCResult"], dr["POName"], Convert.ToString(dr["IsCYDone"]), Convert.ToString(dr["ProductShortName"]).Substring(0,1)) + "}";
                        if (Convert.ToString(dr["QCResult"]) == "0")
                        {
                            sb.Append(json);
                            if (i != outDataSet.Tables[0].Rows.Count - 1)
                            {
                                sb.Append(",");
                            }
                        } 
                    }
                    sb.Append("]}");
                }
                string str = sb.ToString();
                context.Response.Write(sb.ToString());
            }
            else if (CheckResultType == "2")
            {
                result.RetStr = SQ.getSendQCDoneReportList("", "", 20, curPage, out pageCount, out recCount, out outDataSet);
                if (result.Code == 0)
                {
                    sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                    for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                    {
                        DataRow dr = outDataSet.Tables[0].Rows[i];
                        int SendQty = Convert.IsDBNull(dr["SendQCQty"]) ? 0 : Convert.ToInt32(dr["SendQCQty"]);
                        string json = "{" + String.Format("\"SendQCReportId\":\"{0}\",\"SendQCReportNumber\":\"{1}\",\"VendorName\":\"{2}\","

                            + "\"ProductShortName\":\"{3}\",\"ProductDescription\":\"{4}\",\"SendQCQty\":\"{5}\",\"SendDate\":\"{6}\",\"QCResult\":\"{7}\",\"POName\":\"{8}\",\"CreateDate\":\"{9}\",\"IsB\":\"{10}\",\"pcName\":\"{11}\"",
                            dr["SendQCReportId"], dr["SendQCReportNumber"], dr["VendorName"], dr["ProductShortName"],
                            Convert.ToString(dr["ProductDescription"]).Replace("\"", "\\\""), SendQty.ToString(), dr["SendDate"], GetQCResultMsg(Convert.ToString(dr["QCResult"])), dr["POName"], Convert.ToDateTime(dr["CreateDate"]).ToString("yyyy-MM-dd HH:mm:ss"), Convert.ToString(dr["ProductShortName"]).Substring(0, 1) == "B" ? "1" : "2", Convert.ToString(dr["ProductShortName"]).Substring(0, 1)) + "}";
                        sb.Append(json);
                        if (i != outDataSet.Tables[0].Rows.Count - 1)
                        {
                            sb.Append(",");
                        }


                    }
                    sb.Append("]}");
                }
                string str = sb.ToString();
                context.Response.Write(sb.ToString());
            }
            else if (CheckResultType == "3")
            {
                result.RetStr = SQ.getSendQCReportDoneList("", "", 20, curPage, out pageCount, out recCount, out outDataSet);
                if (result.Code == 0)
                {
                    sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                    for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                    {
                        DataRow dr = outDataSet.Tables[0].Rows[i];
                        string ProductDescription = dr["ProductDescription"].ToString().Replace("\"", "\\\"");
                        string SendQCReportId = dr["SendQCReportId"].ToString();
                        SR.getIQCShortStatus(SendQCReportId, out outDataSet2, out outDataSet3);
                        StringBuilder sb2 = new StringBuilder();
                        sb2.Append("[");
                        foreach (DataRow dr2 in outDataSet2.Tables[0].Select())
                        {
                            sb2.Append(",{" + String.Format("\"SendQCReportResultId\":\"{0}\",\"CheckNo\":\"{1}\",\"CQty\":\"{2}\",\"CheckResult\":\"{3}\"",
                                            dr2["SendQCReportResultId"], dr2["CheckNo"], dr2["CQty"], dr2["CheckResult"]) + "}");
                        }
                        if (outDataSet3 != null)
                        {
                            foreach (DataRow dr3 in outDataSet3.Tables[0].Rows)
                            {
                                sb2.Append(",{" + String.Format("\"Speciment_ExtRecordId\":\"{0}\",\"CheckNo\":\"{1}\",\"ExtQty\":\"{2}\",\"CheckResult\":\"{3}\"",
                                                dr3["Speciment_ExtRecordId"], dr3["CheckNo"], dr3["ExtQty"], dr3["CheckResult"]) + "}");
                            }
                        }
                        sb2.Append("]");
                        sb2.Remove(1, 1);
                        string IQCShortStatus = sb2.ToString();
                        string json = "{" + String.Format("\"SendQCReportId\":\"{0}\",\"CreateDate\":\"{1}\",\"VendorName\":\"{2}\","
                                       + "\"ProductName\":\"{3}\",\"ProductDescription\":\"{4}\",\"POName\":\"{5}\",\"DeliveryQty\":\"{6}\",\"IQCShortStatus\":{7},\"QCResult\":\"{8}\"",
                                       dr["SendQCReportId"], dr["CreateDate"], dr["VendorName"], dr["ProductName"],
                                       ProductDescription, dr["POName"], dr["DeliveryQty"], IQCShortStatus, dr["QCResult"]) + "}";
                        sb.Append(json);
                        if (i != outDataSet.Tables[0].Rows.Count - 1)
                        {
                            sb.Append(",");
                        }


                    }
                    sb.Append("]}");
                }
                string str = sb.ToString();
                context.Response.Write(sb.ToString());
            }

            else
            {
                context.Response.Write("{\"result\":1,\"msg\":\"获取失败\"}");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public DataSet outDataSet = new DataSet();
        public DataSet outDataSet2 = new DataSet();
        public DataSet outDataSet3 = new DataSet();
        public funResult result = new funResult();
        //页码
        private int curPage
        {
            get
            {
                if (HttpContext.Current.Request.QueryString["curPage"] != null)
                {

                    return Convert.ToInt32(HttpContext.Current.Request.QueryString["curPage"]);

                }
                else
                {
                    return 1;
                }
            }
        }

        //质检结果类型
        private string CheckResultType
        {
            get
            {
                if (HttpContext.Current.Request.QueryString["ResultType"] != null)
                {
                    return Convert.ToString(HttpContext.Current.Request.QueryString["ResultType"]);
                }
                else
                {
                    return "0";
                }
            }
        }
        private string GetQCResultMsg(string QCResult)
        {
            switch (QCResult)
            {
                //QC检查结果(0-未确认,1-全部接受,2-让步接受(特采),3-挑选接受,4-免检,5-全部拒收)
                case "1":
                    return "全部接受";
                case "2":
                    return "让步接受(特采)";
                case "3":
                    return "挑选接受";
                case "4":
                    return "免检";
                case "5":
                    return "全部拒收";
                default:
                    return "未知错误";
            }
        }
    }
}
using Newtonsoft.Json.Linq;
using QMS_WebSite.Method;
using QMS_WebSite.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace QMS_WebSite.Handler
{
    /// <summary>
    /// OQC 的摘要说明
    /// </summary>
    public class OQC : IHttpHandler
    {

        public DataSet outDataSet = new DataSet();
        public funResult result = new funResult();
        public HttpRequest Request = HttpContext.Current.Request;

        #region 传递参数

        /// <summary>
        /// 操作类型
        /// </summary>
        private string FunType
        {
            get
            {
                if (Request.QueryString["FunType"] != null)
                {
                    return Request.QueryString["FunType"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// OQCCheckId
        /// </summary>
        private string OQCCheckId
        {
            get
            {
                if (Request.QueryString["OQCCheckId"] != null)
                {
                    return Request.QueryString["OQCCheckId"];
                }
                else
                {
                    return "NULL";
                }
            }
        }

        /// <summary>
        /// SEOutStockEntryId
        /// </summary>
        private string SEOutStockEntryId
        {
            get
            {
                if (Request.QueryString["SEOutStockEntryId"] != null)
                {
                    return Request.QueryString["SEOutStockEntryId"];
                }
                else
                {
                    return "";
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
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

        /// <summary>
        /// 扫描条码
        /// </summary>
        private string ScanLotSN
        {
            get
            {
                if (Request.QueryString["ScanLotSN"] != null)
                {
                    return Request.QueryString["ScanLotSN"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 描述
        /// </summary>
        private string Describe
        {
            get
            {
                if (Request.QueryString["Describe"] != null)
                {
                    return Request.QueryString["Describe"];
                }
                else
                {
                    return "";
                }
            }
        }


        private string YBBQ
        {
            get
            {
                if (Request.QueryString["YBBQ"] != null)
                {
                    return Request.QueryString["YBBQ"];
                }
                else
                {
                    return "";
                }
            }
        }

        private string ProductId
        {
            get
            {
                if (Request.QueryString["ProductId"] != null)
                {
                    return Request.QueryString["ProductId"];
                }
                else
                {
                    return "";
                }
            }
        }


        private string keyWork
        {
            get
            {
                if (Request.QueryString["keyWork"] != null)
                {
                    return Request.QueryString["keyWork"];
                }
                else
                {
                    return "";
                }
            }
        }
        #endregion

        public void ProcessRequest(HttpContext context)
        {
            string result = "";
            switch (FunType)
            {
                case "getOQCCheckTodo":
                    result = getOQCCheckTodo(keyWork);
                    break;
                case "getOQCCheckDone":
                    result = getOQCCheckDone(keyWork);
                    break;
                case "getCheckInfo":
                    result = getCheckInfo(OQCCheckId);
                    break;
                case "printLabel":
                    result = printLabel(SEOutStockEntryId);
                    break;
                case "checkResultSubmit":
                    result = checkResultSubmit(OQCCheckId);
                    break;
                case "checkResultTempSubmit":
                    result = checkResultTempSubmit(OQCCheckId);
                    break;
                case "getPrintContentCode":
                    result = getPrintContentCode(OQCCheckId, YBBQ);
                    break;
                case "getProductDetail":
                    result = getProductDetail(ProductId);
                    break;


            }
            context.Response.Write(result);
        }

        #region 提交数据

        /// <summary>
        /// 打印样本标签
        /// </summary>
        /// <param name="OQCCheckId"></param>
        /// <returns></returns>
        private string printLabel(string SEOutStockEntryId)
        {
            OQCCheckHelper oqc = new OQCCheckHelper();
            string msg = "";
            if (oqc.PrintLabel(SEOutStockEntryId, out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"打印样本标签失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 提交数据
        /// </summary>
        /// <param name="OQCCheckId"></param>
        /// <returns></returns>
        private string checkResultSubmit(string OQCCheckId)
        {
            OQCCheckHelper ipqc = new OQCCheckHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["OQCData"])).ToString();
            string Describe = Convert.ToString(Request.Form["Describe"]);
            string QCResult = Convert.ToString(Request.Form["QCResult"]);
            OQCCheckModel model = new OQCCheckModel();
            model.Describe = Describe;
            model.QCResult = int.Parse(QCResult);
            model.OQCCheckId = OQCCheckId;
            model.XMLData = XMLData;
            string msg = "";
            if (ipqc.CheckResultSubmit(model, out msg))
            {
                return "{\"result\":0,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"数据提交失败:" + msg + "\"}";
            }
        }
        /// <summary>
        /// 保存临时数据
        /// </summary>
        /// <param name="OQCCheckId"></param>
        /// <returns></returns>
        private string checkResultTempSubmit(string OQCCheckId)
        {
            OQCCheckHelper ipqc = new OQCCheckHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["OQCData"])).ToString();
            OQCCheckModel model = new OQCCheckModel();
            model.Describe = Describe;
            model.OQCCheckId = OQCCheckId;
            model.XMLData = XMLData;

            string msg = "";
            if (ipqc.SaveTempData(model, out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"保存数据失败:" + msg + "\"}";
            }
        }


        #endregion

        #region 获取信息
        /// <summary>
        /// 根据工序ID获取信息
        /// </summary>
        /// <param name="OQCCheckId"></param>
        /// <returns></returns>
        private string getCheckInfo(string OQCCheckId)
        {
            //if (!string.IsNullOrEmpty(ScanLotSN))
            //    if (OQCCheckId != ScanLotSN) return "{\"result\":-1,\"msg\":\"扫描信息与" + OQCCheckId + "不匹配\"}";
            //根据用户去

            OQCCheckHelper ipqc = new OQCCheckHelper();
            DataTable dt = ipqc.GetCheckInfo(OQCCheckId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];

                string XMLData = Convert.ToString(dr["XMLData"]);
                if (!string.IsNullOrEmpty(XMLData))
                {
                    string jsonData = CommHelper.XMLToJson(XMLData);
                    JObject o = JObject.Parse(jsonData);
                    JToken Token = o["IQCdata"];

                    Token["Describe"].Parent.AddAfterSelf(new JProperty("FBillNo", Convert.ToString(dr["FBillNo"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductId", Convert.ToString(dr["ProductId"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("Qty", Convert.ToString(dr["Qty"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("OQCReportId", Convert.ToString(dr["OQCReportId"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("SourceBillNo", Convert.ToString(dr["SourceBillNo"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductDescription", Convert.ToString(dr["ProductDescription"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductShortName", Convert.ToString(dr["ProductShortName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("CustomerName", Convert.ToString(dr["CustomerName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("OQCCheckId", Convert.ToString(dr["OQCCheckId"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("QCResult", Convert.ToString(dr["QCResult"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("SEOutStockEntryId", Convert.ToString(dr["SEOutStockEntryId"])));

                    sb.Append(CommHelper.JsonTOStr(Token));
                    sb.Append("}");
                    return sb.ToString();
                }
                else
                {
                    string json = "{" + String.Format("\"FBillNo\":\"{0}\",\"ProductId\":\"{1}\",\"Qty\":\"{2}\","
                     + "\"SourceBillNo\":\"{3}\",\"ProductDescription\":\"{4}\",\"ProductShortName\":\"{5}\",\"CustomerName\":\"{6}\",\"OQCCheckId\":\"{7}\",\"QCResult\":\"{8}\",\"SEOutStockEntryId\":\"{9}\"",
                     dr["FBillNo"], dr["ProductId"], dr["Qty"], dr["SourceBillNo"],
                     dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], dr["OQCCheckId"], dr["QCResult"], dr["SEOutStockEntryId"]) + "}";
                    sb.Append(json);
                    sb.Append("}");
                    return sb.ToString();
                }

            }
            else
            {
                return "{\"result\":-1,\"msg\":\"扫描信息不存在\"}";
            }
        }

        /// <summary>
        /// 获取完成首检数据
        /// </summary>
        /// <returns></returns>
        private string getOQCCheckDone(string keyWork)
        {
            int pageCount, recCount;
            OQCCheckHelper ipqc = new OQCCheckHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetOQCCheckDone(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];

                    string json = "{" + String.Format("\"FBillNo\":\"{0}\",\"ProductId\":\"{1}\",\"Qty\":\"{2}\","
                      + "\"SourceBillNo\":\"{3}\",\"ProductDescription\":\"{4}\",\"ProductShortName\":\"{5}\",\"CustomerName\":\"{6}\",\"OQCCheckId\":\"{7}\",\"QCResult\":\"{8}\",\"SEOutStockEntryId\":\"{9}\"",
                      dr["FBillNo"], dr["ProductId"], dr["Qty"], dr["SourceBillNo"],
                      dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], dr["OQCCheckId"], dr["QCResult"],dr["SEOutStockEntryId"]) + "}";
                    if (Convert.ToString(dr["IsDone"]) == "1")
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
            return sb.ToString();
        }

        /// <summary>
        /// 获取待完成首检数据
        /// </summary>
        /// <returns></returns>
        private string getOQCCheckTodo(string keyWork)
        {
            int pageCount, recCount;
            OQCCheckHelper ipqc = new OQCCheckHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetOQCCheckTodo(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    string json = "{" + String.Format("\"FBillNo\":\"{0}\",\"ProductId\":\"{1}\",\"Qty\":\"{2}\","
                      + "\"SourceBillNo\":\"{3}\",\"ProductDescription\":\"{4}\",\"ProductShortName\":\"{5}\",\"CustomerName\":\"{6}\",\"OQCCheckId\":\"{7}\",\"QCResult\":\"{8}\",\"SEOutStockEntryId\":\"{9}\"",
                      dr["FBillNo"], dr["ProductId"], dr["Qty"], dr["SourceBillNo"],
                      dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], dr["OQCCheckId"], dr["QCResult"], dr["SEOutStockEntryId"]) + "}";
                    sb.Append(json);
                    if (i != outDataSet.Tables[0].Rows.Count - 1)
                    {
                        sb.Append(",");
                    }

                }
                sb.Append("]}");
            }
            return sb.ToString();
        }

        private string getPrintContentCode(string OQCCheckId, string YBBQ)
        {
            OQCCheckHelper ipqc = new OQCCheckHelper();
            DataTable dt = ipqc.GetCheckInfo(OQCCheckId);
            if (dt.Rows.Count > 0)
            {


                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];  

                PrintCodeConvert pc = new PrintCodeConvert(); 
                string Msg = pc.GetPrintOQCPackCodeConvertStr(
                    Convert.ToString(dr["BillNo"]),
                     Convert.ToString(dr["CustomerName"]),
                       Convert.ToString(dr["ProductShortName"]),
                        Convert.ToString(dr["ProductDescription"]),
                          Convert.ToString(dr["YBBQ"]),
                            Convert.ToInt32(dr["Qty"])
                        );
                return "{\"result\":1,\"msg\":\"" + Msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }

        }

        /// <summary>
        /// 获取产品信息
        /// </summary>
        /// <param name="productCode"></param>
        /// <returns></returns>
        private string getProductDetail(string productCode)
        {
            if (string.IsNullOrEmpty(productCode))
                return "{\"result\":-1,\"msg\":\"扫描数据不存在\"}";

            DBClass ipqc = new DBClass();

            DataTable dt = ipqc.GetProductCode(productCode);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                string json = "{" + String.Format("\"ProductDescription\":\"{0}\",\"ProductShortName\":\"{1}\"",
                   dr["ProductDescription"], Convert.ToString(dr["ProductShortName"])) + "}";
                sb.Append(json);
                sb.Append("}");
                return sb.ToString();

            }
            else
            {
                return "{\"result\":-1,\"msg\":\"扫描信息不存在\"}";
            }
        }

       
        #endregion
    }
}
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
    /// FQC 的摘要说明
    /// </summary>
    public class FQC : IHttpHandler
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
        /// FQCID
        /// </summary>
        private string FQCCheckId
        {
            get
            {
                if (Request.QueryString["FQCCheckId"] != null)
                {
                    return Request.QueryString["FQCCheckId"];
                }
                else
                {
                    return "NULL";
                }
            }
        }

        /// <summary>
        /// 工单
        /// </summary>
        private string MOName
        {
            get
            {
                if (Request.QueryString["MOName"] != null)
                {
                    return Request.QueryString["MOName"];
                }
                else
                {
                    return "NULL";
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

        private int SpecimentId
        {
            get
            {
                int sid;
                if (int.TryParse(Request.QueryString["SpecimentId"], out sid))
                {
                    return sid;
                }
                else
                {
                    return -1;
                }
            }
        }

        private int PackType
        {
            get
            {
                int packType;
                if (int.TryParse(Request.QueryString["PackType"], out packType))
                {
                    return packType;
                }
                else
                {
                    return -1;
                }
            }
        }

        private string CYFS
        {
            get
            {
                if (Request.QueryString["CYFS"] != null)
                {
                    return Request.QueryString["CYFS"];
                }
                else
                {
                    return "";
                }
            }
        }

        private string BillNo
        {
            get
            {
                if (Request.QueryString["BillNo"] != null)
                {
                    return Request.QueryString["BillNo"];
                }
                else
                {
                    return "";
                }
            }
        }

        private string SOEntry
        {
            get
            {
                if (Request.QueryString["SOEntry"] != null)
                {
                    return Request.QueryString["SOEntry"];
                }
                else
                {
                    return "";
                }
            }
        }

        private string MFPlansEntryId
        {
            get
            {
                if (Request.QueryString["MFPlansEntryId"] != null)
                {
                    return Request.QueryString["MFPlansEntryId"];
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
              
                case "getFQCCheckDone":
                    result = getFQCCheckDone(keyWork);
                    break;
                case "getFQCData":
                    result = getFQCData(keyWork);
                    break;
                case "getCheckData":
                    result = getCheckData(FQCCheckId);
                    break;
                case "getFQCCheckDataByScanSN":
                    result = getFQCCheckDataByScanSN(ScanLotSN);
                    break;
                case "checkResultTempSubmit":
                    result = checkResultTempSubmit(FQCCheckId);
                    break;
                case "checkResultSubmit":
                    result = checkResultSubmit(FQCCheckId);
                    break;
                case "getPrintContentCode":
                    result = getPrintContentCode(FQCCheckId);
                    break;
                case "getProductDetail":
                    result = getProductDetail(ProductId);
                    break; 
                case "specimentPrintLabel":
                    result = specimentPrintLabel(SpecimentId.ToString(), "1.正常抽样", "", ScanLotSN);
                    break;
               
            }
            context.Response.Write(result);
        }

        #region 提交数据

        private string specimentPrintLabel(string SpecimentId, string CYFS, string describe, string ScanSN)
        {
            FQCCheckHelper ipqc = new FQCCheckHelper();
            string msg = "";
            if (ipqc.FQCSpecimentPrintLabel(SpecimentId, CYFS, describe, ScanSN, out msg))
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
        /// <param name="wFSteptId"></param>
        /// <returns></returns>
        private string checkResultSubmit(string FQCCheckId)
        {
            FQCCheckHelper ipqc = new FQCCheckHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["FQCData"])).ToString();
            string Describe = Convert.ToString(Request.Form["Describe"]);
            string QCResult = Convert.ToString(Request.Form["QCResult"]);
            Decimal AcceptQty = Convert.ToDecimal(Request.Form["AcceptQty"]);
            Decimal NGQty = Convert.ToDecimal(Request.Form["NGQty"]);
            FQCCheckModel model = new FQCCheckModel();
            model.Describe = Describe;
            model.QCResult = int.Parse(QCResult);
            model.FQCCheckId = FQCCheckId;
            model.XMLData = XMLData;
            model.AcceptQty = AcceptQty;
            model.NGQty = NGQty;
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
        /// <param name="wFSteptId"></param>
        /// <returns></returns>
        private string checkResultTempSubmit(string FQCCheckId)
        {
            FQCCheckHelper ipqc = new FQCCheckHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["FQCData"])).ToString();

            FQCCheckModel model = new FQCCheckModel();
            model.Describe = Describe;
            model.FQCCheckId = FQCCheckId;
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
        /// 获取FQC已完成检验数据
        /// </summary>
        /// <param name="keyWork"></param>
        /// <returns></returns>
        private string getFQCCheckDone(string keyWork)
        {
            int pageCount, recCount;
            FQCCheckHelper ipqc = new FQCCheckHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetFQCDoneData(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            { 
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    int MOQtyRequired = Convert.IsDBNull(dr["MOQtyRequired"]) ? 0 : Convert.ToInt32(dr["MOQtyRequired"]);
                    string json = "{" + String.Format("\"ProductName\":\"{0}\",\"SpecimentId\":\"{1}\",\"BillNo\":\"{2}\","
                        + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"FQCQCResult\":\"{9}\",\"FQCCheckId\":\"{10}\",\"CheckType\":\"{11}\",\"SOEntry\":\"{12}\"",
                        dr["ProductName"], dr["SpecimentId"], dr["BillNo"], dr["MOName"],
                        dr["ProductId"], MOQtyRequired.ToString(), dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["QCResult"]), dr["FQCCheckId"], dr["CheckType"], dr["SOEntry"]) + "}";
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

        /// <summary>
        /// 获取抽样待检验数据
        /// </summary>
        /// <param name="keyWork"></param>
        /// <returns></returns>
        private string getFQCData(string keyWork)
        {

            int pageCount, recCount;
            FQCCheckHelper ipqc = new FQCCheckHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetFQCSpementData(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    int MOQtyRequired = Convert.IsDBNull(dr["MOQtyRequired"]) ? 0 : Convert.ToInt32(dr["MOQtyRequired"]);
                    string json = "{" + String.Format("\"ProductName\":\"{0}\",\"SpecimentId\":\"{1}\",\"BillNo\":\"{2}\","
                        + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"IsPrint\":\"{9}\",\"MFPlansEntryId\":\"{10}\",\"SOEntry\":\"{11}\",\"YBSN\":\"{12}\"",
                        dr["ProductName"], dr["SpecimentId"], dr["BillNo"], dr["MOName"],
                        dr["ProductId"], MOQtyRequired.ToString(), dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["IsPrint"]), dr["MFPlansEntryId"], dr["SOEntry"],dr["YBSN"]) + "}";
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

        /// <summary>
        /// 获取检验展示数据
        /// </summary>
        /// <param name="scanSN">样本标签</param>
        /// <returns></returns>
        private string getFQCCheckDataByScanSN(string scanSN)
        {
            FQCCheckHelper ipqc = new FQCCheckHelper();
            StringBuilder sb = new StringBuilder();
            string FQCCheckId = ipqc.GetFQCCheclIdByScanSn(scanSN);
            if (string.IsNullOrEmpty(FQCCheckId))
            {
                return "{\"result\":-1,\"msg\":\"扫描信息不存在\"}";
            }
            DataTable dt = ipqc.getFQCCheckDataByFQCCheckId(FQCCheckId);

            if (dt.Rows.Count > 0)
            {
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                string json = "{" + String.Format("\"ProductName\":\"{0}\",\"SpecimentId\":\"{1}\",\"BillNo\":\"{2}\","
                         + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"FQCQCResult\":\"{9}\",\"FQCCheckId\":\"{10}\",\"SOEntry\":\"{11}\"",
                         dr["ProductName"], dr["SpecimentId"], dr["BillNo"], dr["MOName"],
                         dr["ProductId"], dr["MOQtyRequired"], dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["FQCQCResult"]), dr["FQCCheckId"], dr["SOEntry"]) + "}";
                sb.Append(json);
                sb.Append("}");
                return sb.ToString();
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"扫描信息不存在\"}";
            }
        }

        private string getCheckData(string FQCCheckId)
        {
            FQCCheckHelper ipqc = new FQCCheckHelper();
            StringBuilder sb = new StringBuilder();

            if (string.IsNullOrEmpty(FQCCheckId))
            {
                return "{\"result\":-1,\"msg\":\"扫描信息不存在\"}";
            }
            DataTable dt = ipqc.getFQCCheckDataByFQCCheckId(FQCCheckId);

            if (dt.Rows.Count > 0)
            {
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];

                string XMLData = Convert.ToString(dr["XMLData"]);
                if (!string.IsNullOrEmpty(XMLData))
                {
                    string jsonData = CommHelper.XMLToJson(XMLData);
                    JObject o = JObject.Parse(jsonData);
                    JToken Token = o["FQCdata"];
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("CheckType", Convert.ToString(dr["CheckType"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("BillNo", Convert.ToString(dr["BillNo"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("MOName", Convert.ToString(dr["MOName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductId", Convert.ToString(dr["ProductId"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductShortName", Convert.ToString(dr["ProductShortName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductName", Convert.ToString(dr["ProductName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductDescription", Convert.ToString(dr["ProductDescription"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("QCResult", Convert.ToString(dr["QCResult"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("CustomerName", Convert.ToString(dr["CustomerName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("IsDone", Convert.ToString(dr["IsDone"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("MOQtyRequired", Convert.ToString(dr["MOQtyRequired"])));

                    sb.Append(CommHelper.JsonTOStr(Token));
                    sb.Append("}");
                    return sb.ToString();
                }
                else
                {
                    string json = "{" + String.Format("\"ProductName\":\"{0}\",\"SpecimentId\":\"{1}\",\"BillNo\":\"{2}\","
                         + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"FQCQCResult\":\"{9}\",\"FQCCheckId\":\"{10}\"",
                         dr["ProductName"], dr["SpecimentId"], dr["BillNo"], dr["MOName"],
                         dr["ProductId"], dr["MOQtyRequired"], dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["FQCQCResult"]), dr["FQCCheckId"]) + "}";
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

        /// <summary>
        /// 打印
        /// </summary>
        /// <param name="FQCCheckId"></param>
        /// <returns></returns>
        private string getPrintContentCode(string FQCCheckId)
        {
            FQCCheckHelper ipqc = new FQCCheckHelper();
            DataTable dt = ipqc.getFQCCheckDataByFQCCheckId(FQCCheckId);
            if (dt.Rows.Count > 0)
            {


                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];

                PrintCodeConvert pc = new PrintCodeConvert();
                string Msg = pc.GetPrintFQCCodeConvertStr(
                    Convert.ToString(dr["YBBQ"]),
                     Convert.ToString(dr["ProductDescription"]),
                       Convert.ToString(dr["MOName"]),
                        Convert.ToString(dr["ProductShortName"]),
                          Convert.ToString(dr["CQty"]),
                            Convert.ToString(dr["CustomerName"])
                        );
                return "{\"result\":1,\"msg\":\"" + Msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }

        }
        #endregion
    }
}

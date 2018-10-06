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
    /// FQCPack 的摘要说明
    /// </summary>
    public class FQCPack : IHttpHandler
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
        /// FQCCheckPackId
        /// </summary>
        private string FQCCheckPackId
        {
            get
            {
                if (Request.QueryString["FQCCheckPackId"] != null)
                {
                    return Request.QueryString["FQCCheckPackId"];
                }
                else
                {
                    return "";
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
        private string MFPlansId
        {
            get
            {
                if (Request.QueryString["MFPlansId"] != null)
                {
                    return Request.QueryString["MFPlansId"];
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
                case "getFQCPakeData":
                    result = getFQCPakeData(keyWork);
                    break;
                case "getFQCCheckDone":
                    result = getFQCCheckDone(keyWork);
                    break;
                case "getFQCCheckDataByScanSN":
                    result = getFQCCheckDataByScanSN(MFPlansId, ScanLotSN);
                    break;
                case "getFQCCheckDataByFQCCheckId":
                    result = getFQCCheckDataByFQCCheckId(FQCCheckPackId);
                    break;
                case "checkResultTempSubmit":
                    result = checkResultTempSubmit(FQCCheckPackId);
                    break;
                case "checkResultSubmit":
                    result = checkResultSubmit(FQCCheckPackId);
                    break;
                case "getPrintContentCode":
                    result = getPrintContentCode(YBBQ);
                    break;
                case "getProductDetail":
                    result = getProductDetail(ProductId);
                    break;
                case "packPrintLabel":
                    result = packPrintLabel(MFPlansId, PackType);
                    break;
                case "getFeedSheet":
                    result = getFeedSheet(BillNo, SOEntry);
                    break;
            }
            context.Response.Write(result);
        }


        #region 提交数据

        /// <summary>
        /// 打印样本标签
        /// </summary>
        /// <param name="wFSteptId"></param>
        /// <returns></returns>
        private string packPrintLabel(string MFPlansId, int PackType)
        {
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            string msg = "";
            if (ipqc.PackPrintLabel(MFPlansId, PackType, out msg))
            {
                return "{\"result\":0,\"msg\":\"" + msg + "\"}";
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
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["FQCData"])).ToString();
            string Describe = Convert.ToString(Request.Form["Describe"]);
            int QCResult = Convert.ToInt32(Request.Form["QCResult"]);

            string msg = "";
            if (ipqc.CheckResultSubmit(FQCCheckId, Describe, XMLData, QCResult, out msg))
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
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["FQCData"])).ToString();
            string Describe = Convert.ToString(Request.Form["Describe"]);
            string msg = "";
            if (ipqc.SaveTempData(FQCCheckId, Describe, XMLData, out msg))
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
        /// 获取待完成包装待检数据
        /// </summary>
        /// <returns></returns>
        private string getFQCPakeData(string keyWork)
        {
            int pageCount, recCount;
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetFQCPakeData(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    int MOQtyRequired = Convert.IsDBNull(dr["MOQtyRequired"]) ? 0 : Convert.ToInt32(dr["MOQtyRequired"]);//
                    string json = "{" + String.Format("\"ProductName\":\"{0}\",\"MOStatus\":\"{1}\",\"BillNo\":\"{2}\","
                        + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"SOEntry\":\"{9}\",\"MFPlansId\":\"{10}\"",
                        dr["ProductName"], dr["MOStatus"], dr["BillNo"], dr["MOName"],
                        dr["ProductId"], MOQtyRequired.ToString(), dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], dr["SOEntry"], dr["MFPlansEntryId"]) + "}";
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
        /// 获取FQC已完成检验数据
        /// </summary>
        /// <param name="keyWork"></param>
        /// <returns></returns>
        private string getFQCCheckDone(string keyWork)
        {
            int pageCount, recCount;
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetFQCDoneData(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    int MOQtyRequired = Convert.IsDBNull(dr["MOQtyRequired"]) ? 0 : Convert.ToInt32(dr["MOQtyRequired"]);
                    string json = "{" + String.Format("\"ProductName\":\"{0}\",\"YBBQ\":\"{1}\",\"BillNo\":\"{2}\","
                        + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"FQCQCResult\":\"{9}\",\"FQCCheckId\":\"{10}\",\"CheckType\":\"{11}\",\"SOEntry\":\"{12}\"",
                        dr["ProductName"], dr["YBBQ"], dr["BillNo"], dr["MOName"],
                        dr["ProductId"], MOQtyRequired.ToString(), dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["QCResult"]), dr["FQCCheckPackId"], dr["CheckType"], dr["SOEntry"]) + "}";
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


        private string getFQCCheckDataByFQCCheckId(string fQCCheckPackId)
        {
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            StringBuilder sb = new StringBuilder();
            DataTable dt = ipqc.getFQCCheckDataByFQCCheckId(fQCCheckPackId);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");


                string XMLData = Convert.ToString(dr["XMLData"]);
                if (!string.IsNullOrEmpty(XMLData))
                {
                    string jsonData = CommHelper.XMLToJson(XMLData);
                    JObject o = JObject.Parse(jsonData);
                    JToken Token = o["IQCdata"];

                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductName", Convert.ToString(dr["ProductName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("CheckType", Convert.ToString(dr["CheckType"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("BillNo", Convert.ToString(dr["BillNo"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("MOName", Convert.ToString(dr["MOName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductId", Convert.ToString(dr["ProductId"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductShortName", Convert.ToString(dr["ProductShortName"])));
                    //Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductName", Convert.ToString(dr["ProductName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("ProductDescription", Convert.ToString(dr["ProductDescription"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("QCResult", Convert.ToString(dr["QCResult"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("CustomerName", Convert.ToString(dr["CustomerName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("SOEntry", Convert.ToString(dr["SOEntry"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("MOQtyRequired", Convert.ToString(dr["MOQtyRequired"])));
                     
                    sb.Append(CommHelper.JsonTOStr(Token));
                    sb.Append("}");
                    return sb.ToString();
                }
                else
                {
                    string json = "{" + String.Format("\"ProductName\":\"{0}\",\"CheckType\":\"{1}\",\"BillNo\":\"{2}\","
                         + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"FQCQCResult\":\"{9}\",\"FQCCheckId\":\"{10}\",\"SOEntry\":\"{11}\"",
                         dr["ProductName"], dr["CheckType"], dr["BillNo"], dr["MOName"],
                         dr["ProductId"], dr["MOQtyRequired"], dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["QCResult"]), dr["FQCCheckPackId"], dr["SOEntry"]) + "}";
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
        /// 获取检验展示数据
        /// </summary>
        /// <param name="scanSN">样本标签</param>
        /// <returns></returns>
        private string getFQCCheckDataByScanSN(string MFPlansId, string scanSN)
        {
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            StringBuilder sb = new StringBuilder();
            string FQCCheckId = ipqc.GetFQCCheclIdByScanSn(scanSN);
            if (string.IsNullOrEmpty(FQCCheckId))
            {
                return "{\"result\":-1,\"msg\":\"扫描信息不存在\"}";
            }
            DataTable dt = ipqc.getFQCCheckDataByFQCCheckId(FQCCheckId);

            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                if (Convert.ToString(dr["MFPlansEntryId"]) != MFPlansId)
                {
                    return "{\"result\":-1,\"msg\":\"扫描信息不匹配\"}";
                }
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");


                string json = "{" + String.Format("\"ProductName\":\"{0}\",\"CheckType\":\"{1}\",\"BillNo\":\"{2}\","
                         + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"FQCQCResult\":\"{9}\",\"FQCCheckId\":\"{10}\",\"SOEntry\":\"{11}\"",
                         dr["ProductName"], dr["CheckType"], dr["BillNo"], dr["MOName"],
                         dr["ProductId"], dr["MOQtyRequired"], dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["QCResult"]), dr["FQCCheckPackId"], dr["SOEntry"]) + "}";
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

        private string getFeedSheet(string billNo, string sOEntry)
        {

            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();
            StringBuilder sb = new StringBuilder();
            DataSet outDataSet = ipqc.GetFeedSheet(billNo, sOEntry);
            if (outDataSet != null && outDataSet.Tables.Count > 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    string base64 = "";
                    if (!string.IsNullOrEmpty(Convert.ToString(dr["总览图"])))
                    {
                        Byte[] buff = (Byte[])dr["总览图"];

                        base64 = Convert.ToBase64String(buff);
                    }
                    string json = "{" + String.Format("\"BillNo\":\"{0}\",\"LineNo\":\"{1}\","
                        + "\"ProductShortName\":\"{2}\",\"ProductDescribe\":\"{3}\",\"Total\":\"{4}\",\"UOM\":\"{5}\",\"SheetNo\":\"{6}\",\"imageShow\":\"{7}\",\"RowNo\":\"{8}\"",
                        dr["销售订单号"], dr["销售单行号"], dr["子项物料代码"], dr["子项物料名称"],
                       Convert.ToDecimal(dr["计划投料数量"]), dr["单位"], dr["投料单号"], base64, i + 1) + "}";

                    sb.Append(json);
                    if (i != outDataSet.Tables[0].Rows.Count - 1)
                    {
                        sb.Append(",");
                    }

                }
                sb.Append("]}");
            }
            else
            {
                sb.Append("{\"result\":-1,\"msg\":\"数据不存在\"}");
            }
            return sb.ToString();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="MFPlansId"></param>
        /// <param name="YBBQ"></param>
        /// <returns></returns>
        private string getPrintContentCode(string YBBQ)
        {
            FQCCheckPackHelper ipqc = new FQCCheckPackHelper();

            string FQCCheckId = ipqc.GetFQCCheclIdByScanSn(YBBQ);
            if (string.IsNullOrEmpty(FQCCheckId))
            {
                return "{\"result\":-1,\"msg\":\"生成标签失败\"}";
            }
            DataTable dt = ipqc.getFQCCheckDataByFQCCheckId(FQCCheckId);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];

                FQCPackPrintModel model = new FQCPackPrintModel();

                model.ProductDescribe = Convert.ToString(dr["ProductDescription"]);
                model.ProductShortName = Convert.ToString(dr["ProductShortName"]);

                model.BillNo = Convert.ToString(dr["BillNo"]);
                model.LineNo = Convert.ToString(dr["SOEntry"]);
                model.YBBQ = YBBQ;
                model.MOName = Convert.ToString(dr["MOName"]);
                model.SteptName = Convert.ToString(dr["SpecificationName"]);
                model.PackType = Convert.ToString(dr["CheckType"]);
                PrintCodeConvert pc = new PrintCodeConvert();

                string Msg = pc.GetPrintFQCPackCodeConvertStr(model);
                return "{\"result\":0,\"msg\":\"" + Msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }

        }
        #endregion
    }
}
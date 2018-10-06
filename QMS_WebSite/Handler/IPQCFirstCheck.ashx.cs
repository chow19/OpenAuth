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
    /// IPQC首检 一般方法
    /// </summary>
    public class IPQCFirstCheck : IHttpHandler
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
        /// IPQC首检ID
        /// </summary>
        private string IPQCFirstCheckId
        {
            get
            {
                if (Request.QueryString["IPQCFirstCheckId"] != null)
                {
                    return Request.QueryString["IPQCFirstCheckId"];
                }
                else
                {
                    return "NULL";
                }
            }
        }

        /// <summary>
        /// 工序ID
        /// </summary>
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

        private string MouldId
        {
            get
            {
                if (Request.QueryString["MouldId"] != null)
                {
                    return Request.QueryString["MouldId"];
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
                case "getIPQCFirstCheckTodo":
                    result = getIPQCFirstCheckTodo(keyWork);
                    break;
                case "getIPQCFirstCheckDone":
                    result = getIPQCFirstCheckDone(keyWork);
                    break;
                case "getStepInfo":
                    result = getStepInfo(MFPlansId, ScanLotSN);
                    break;
                case "printLabel":
                    result = printLabel(MFPlansId);
                    break;
                case "checkResultSubmit":
                    result = checkResultSubmit(MFPlansId);
                    break;
                case "checkResultTempSubmit":
                    result = checkResultTempSubmit(MFPlansId);
                    break;
                case "getPrintContentCode":
                    result = getPrintContentCode(MFPlansId, YBBQ);
                    break;
                case "getProductDetail":
                    result = getProductDetail(ProductId);
                    break;
                case "getMouldInfo":
                    result = getMouldInfo(MouldId);
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
        private string printLabel(string MFPlansId)
        {
            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();
            string msg = "";
            if (ipqc.PrintLabel(MFPlansId, out msg))
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
        private string checkResultSubmit(string MFPlansId)
        {
            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IPQCData"])).ToString();
            string Describe = Convert.ToString(Request.Form["Describe"]);
            string QCResult = Convert.ToString(Request.Form["QCResult"]);
            IPQCFirstCheckModel model = new IPQCFirstCheckModel();
            model.Describe = Describe;
            model.QCResult = int.Parse(QCResult);
            model.MFPlansId = MFPlansId;
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
        /// <param name="wFSteptId"></param>
        /// <returns></returns>
        private string checkResultTempSubmit(string MFPlansId)
        {
            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();
            string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IPQCData"])).ToString();

            IPQCFirstCheckModel model = new IPQCFirstCheckModel();
            model.Describe = Describe;
            model.MFPlansId = MFPlansId;
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
        /// <param name="wFSteptId"></param>
        /// <returns></returns>
        private string getStepInfo(string wFSteptId, string ScanLotSN)
        {
            if (!string.IsNullOrEmpty(ScanLotSN))
                if (wFSteptId != ScanLotSN) return "{\"result\":-1,\"msg\":\"扫描信息与" + wFSteptId + "不匹配\"}";

            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();

            DataTable dt = ipqc.GetSteptInfo(wFSteptId);
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

                    Token["Describe"].Parent.AddAfterSelf(new JProperty("SpecificationName", Convert.ToString(dr["SpecificationName"])));
                    Token["Describe"].Parent.AddAfterSelf(new JProperty("WFSteptId", Convert.ToString(dr["WFSteptId"])));
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
                    string json = "{" + String.Format("\"SpecificationName\":\"{0}\",\"WFSteptId\":\"{1}\",\"BillNo\":\"{2}\","
                     + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"QCResult\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductName\":\"{7}\",\"CustomerName\":\"{8}\",\"IsDone\":\"{9}\",\"MOQtyRequired\":\"{10}\",\"ProductShortName\":\"{11}\"",
                     dr["SpecificationName"], dr["MFPlansEntryId"], dr["BillNo"], dr["MOName"],
                     dr["ProductId"], dr["QCResult"], dr["ProductDescription"], dr["ProductName"], dr["CustomerName"], Convert.ToString(dr["IsDone"]), Convert.ToString(dr["MOQtyRequired"]), dr["ProductShortName"]) + "}";
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
        private string getIPQCFirstCheckDone(string keyWork)
        {
            int pageCount, recCount;
            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetIPQCFirstCheckDone(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];

                    string json = "{" + String.Format("\"SpecificationName\":\"{0}\",\"WFSteptId\":\"{1}\",\"BillNo\":\"{2}\","
                        + "\"MOStatus\":\"{3}\",\"ProductId\":\"{4}\",\"QCResult\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"IsDone\":\"{9}\",\"SOEntry\":\"{10}\"",
                        dr["SpecificationName"], dr["MFPlansEntryId"], dr["BillNo"], dr["MOStatus"],
                        dr["ProductId"], dr["QCResult"], dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["IsDone"]), dr["SOEntry"]) + "}";
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
        private string getIPQCFirstCheckTodo(string keyWork)
        {
            int pageCount, recCount;
            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();
            StringBuilder sb = new StringBuilder();
            result.RetStr = ipqc.GetIPQCFirstCheckTodo(keyWork, "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {

                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    int MOQtyRequired = Convert.IsDBNull(dr["MOQtyRequired"]) ? 0 : Convert.ToInt32(dr["MOQtyRequired"]);
                    string json = "{" + String.Format("\"SpecificationName\":\"{0}\",\"WFSteptId\":\"{1}\",\"BillNo\":\"{2}\","
                        + "\"MOName\":\"{3}\",\"ProductId\":\"{4}\",\"MOQtyRequired\":\"{5}\",\"ProductDescription\":\"{6}\",\"ProductShortName\":\"{7}\",\"CustomerName\":\"{8}\",\"IsDone\":\"{9}\",\"SOEntry\":\"{10}\"",
                        dr["SpecificationName"], dr["MFPlansEntryId"], dr["BillNo"], dr["MOName"],
                        dr["ProductId"], MOQtyRequired.ToString(), dr["ProductDescription"], dr["ProductShortName"], dr["CustomerName"], Convert.ToString(dr["IsDone"]), dr["SOEntry"]) + "}";
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

        private string getPrintContentCode(string wFSteptId, string YBBQ)
        {
            IPQCFirstCheckHelper ipqc = new IPQCFirstCheckHelper();
            DataTable dt = ipqc.GetSteptInfo(wFSteptId);
            if (dt.Rows.Count > 0)
            {

                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];

                IPQCCheckPrintModel model = new IPQCCheckPrintModel();

                model.ProductDescribe = Convert.ToString(dr["ProductDescription"]);
                model.ProductShortName = Convert.ToString(dr["ProductShortName"]);

                model.POName = Convert.ToString(dr["BillNo"]);
                model.YBBQ = YBBQ;
                model.MOName = Convert.ToString(dr["MOName"]);
                model.SteptName = Convert.ToString(dr["SpecificationName"]);
                PrintCodeConvert pc = new PrintCodeConvert();

                string Msg = pc.GetPrintIPQCCodeConvertStr(model);
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

        //获取模具
        private string getMouldInfo(string MouldId)
        {
            DBClass ipqc = new DBClass();

            DataTable dt = ipqc.GetMouldCode(MouldId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                string json = "{" + String.Format("\"MouldId\":\"{0}\",\"MouldDescription\":\"{1}\",\"MLong\":\"{1}\",\"MWidth\":\"{1}\",\"MInch\":\"{1}\",\"MSize\":\"{1}\"",
                   dr["MouldId"], Convert.ToString(dr["MouldDescription"]), Convert.ToString(dr["MLong"]), Convert.ToString(dr["MWidth"]), Convert.ToString(dr["MInch"]), Convert.ToString(dr["MSize"])) + "}";
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
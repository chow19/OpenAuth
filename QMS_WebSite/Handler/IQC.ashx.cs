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
    /// IQC 的摘要说明
    /// </summary>
    public class IQC : IHttpHandler
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
        /// 检验批ID
        /// </summary>
        private string SendQCReportId
        {
            get
            {
                if (Request.QueryString["SendQCReportId"] != null)
                {
                    return Request.QueryString["SendQCReportId"];
                }
                else
                {
                    return "NULL";
                }
            }
        }

        /// <summary>
        /// 扫描信息
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
        /// 抽样方式  CYFS,JCSP，JYBZ
        /// </summary>
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

        /// <summary>
        /// 检验水平
        /// </summary>
        private string JCSP
        {
            get
            {
                if (Request.QueryString["JCSP"] != null)
                {
                    return Request.QueryString["JCSP"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 检验标准
        /// </summary>
        private string JYBZ
        {
            get
            {
                if (Request.QueryString["JYBZ"] != null)
                {
                    return Request.QueryString["JYBZ"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 检验标准2
        /// </summary>
        private string JYBZ2
        {
            get
            {
                if (Request.QueryString["JYBZ2"] != null)
                {
                    return Request.QueryString["JYBZ2"];
                }
                else
                {
                    return "";
                }
            }
        }


        /// <summary>
        /// 扫描的物料标签
        /// </summary>
        private string ScanSN
        {
            get
            {
                if (Request.QueryString["ScanSN"] != null)
                {
                    return Request.QueryString["ScanSN"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 删除的的物料标签
        /// </summary>
        private string DelSN
        {
            get
            {
                if (Request.QueryString["DelSN"] != null)
                {
                    return Request.QueryString["DelSN"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 抽取数量
        /// </summary>
        private string CQ_Qty
        {
            get
            {
                if (Request.QueryString["CQ_Qty"] != null)
                {
                    return Request.QueryString["CQ_Qty"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 原材料详细Id
        /// </summary>
        private string RawMaterialIQCCheckId
        {
            get
            {
                if (Request.QueryString["RawMaterialIQCCheckId"] != null)
                {
                    return Request.QueryString["RawMaterialIQCCheckId"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 加抽数量
        /// </summary>
        private string ExtQty
        {
            get
            {
                if (Request.QueryString["ExtQty"] != null)
                {
                    return Request.QueryString["ExtQty"];
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
                if (Request.QueryString["PID"] != null)
                {
                    return Request.QueryString["PID"];
                }
                else
                {
                    return "";
                }
            }
        }

        /// <summary>
        /// 样本标签
        /// </summary>
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

        /// <summary>
        /// 样本标签
        /// </summary>
        private string IsQ
        {
            get
            {
                if (Request.QueryString["IsQ"] != null)
                {
                    return Request.QueryString["IsQ"];
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
                case "":
                    result=getScanSNInfo(SendQCReportId, ScanLotSN);
                    break;
                case "getInfoByYBSN":
                    result = getInfoByYBSN(SendQCReportId, ScanLotSN);
                    break; 
                case "getScanInfo":
                    result = getScanInfo(ScanLotSN, IsQ);
                    break; 
                case "getAQL":
                    result=getAQL_Info(SendQCReportId);
                    break;
                case "selAQL":
                    result = selectAQL_Info(SendQCReportId, CYFS, JCSP, JYBZ);
                    break;
                case "PageLoad":
                    result = GetSpecPageLoad(SendQCReportId);
                    break;
                case "ScanSubmit"://扫描提交
                    result = ScanSubmit(SendQCReportId, CYFS, JCSP, JYBZ, ScanSN, CQ_Qty);
                    break;
                case "LoadScanList":
                    //LoadScanList(SendQCReportId);
                    break;
                case "DelScanList":
                    //DelScanList(SendQCReportId, DelSN);
                    break;
                case "PrintLabel"://打印标签
                    result = PrintSQCLabels(SendQCReportId);
                    break;
                case "RePrintLabel"://重新打印标签
                    result = RePrintSQCLabels(SendQCReportId);
                    break; 
                case "CheckResultSubmit"://提交检验结果
                    result = IQCCheckResultSubmit(SendQCReportId);
                    break;
                case "checkPageLoad"://检验页面加载
                    result = GetSpecCheckPageLoad(SendQCReportId);
                    break;
                case "GetRMIQCCheckInfo"://原材料获取行数据
                    result = GetRMIQCCheckList(SendQCReportId);
                    break;
                case "GetRMIQCCheckDetailInfo"://原材料详细行数据
                    result = GetRMIQCCheckDetailInfo(SendQCReportId, RawMaterialIQCCheckId);
                    break;
                case "RMIQCCheckSubmit"://原材料行数据提交
                    result = RMIQCCheckSubmit(SendQCReportId);
                    break;
                case "RMIQCCheckScanSubmit"://原材料扫描提交数据
                    result = RMIQCCheckScanAddSubmit(SendQCReportId);
                    break;
                case "RMResultDel"://删除原材料行
                    result = RMResultDel(RawMaterialIQCCheckId);
                    break;
                case "ScanSubmitExt":
                    result = ScanSubmitExt(SendQCReportId, ExtQty);
                    break;
                case "GetRMExtRecordList":
                    result = GetRMExtRecordList(SendQCReportId);
                    break;
                case "GlassExtSubmit":
                    result = GlassExtSubmit(SendQCReportId);
                    break;

                case "getExtImgXmlData":
                    result = getExtImgXmlData(SendQCReportId);
                    break;

                case "getIQCCheckItemByPID":
                    result = getIQCCheckItemByPID(ProductId);
                    break;
                case "SaveIQCRMCheckResultTempXmlData":
                    result = SaveIQCRMCheckResultTempXmlData(SendQCReportId, RawMaterialIQCCheckId);
                    break;
                case "SaveIQCCheckResultTempXmlData":
                    result = SaveIQCCheckResultTempXmlData(SendQCReportId);
                    break;
                case "GetPrintContentCode":
                    result = GetPrintContentBase64(SendQCReportId, YBBQ);
                    break;
                case "FirstSpeciment"://第一次抽样
                    result = FirstSpeciment(SendQCReportId, CYFS, JCSP, JYBZ, JYBZ2, ScanSN, CQ_Qty);
                    break;
                default:
                    break;
            }
            context.Response.Write(result);
        }
         
        #region 数据提交
        /// <summary>
        /// 打印标签
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string PrintSQCLabels(string sendQCReportId)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            string Describe = Request.Form["Describe"] == null ? "" : Convert.ToString(Request.Form["Describe"]);
            if (sqcr.PrintSQCLabels(sendQCReportId, Describe, out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"打印样本标签失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 重新打印标签
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string RePrintSQCLabels(string sendQCReportId)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            string Describe = Request.Form["Describe"] == null ? "" : Convert.ToString(Request.Form["Describe"]);
            if (sqcr.RePrintSQCLabels(sendQCReportId, Describe, out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"打印样本标签失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 第一次抽样
        /// </summary>
        /// <param name="SQCId"></param>
        private string FirstSpeciment(string SQCId, string CYFS, string JCSP, string JYBZ, string JYBZ2, string ScanSN, string CQ_Qty)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.FirstSpeciment(SQCId, CYFS, JCSP, JYBZ, JYBZ2, ScanSN, decimal.Parse(CQ_Qty), out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"抽样失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 保存质检数据
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string SaveIQCCheckResultTempXmlData(string sendQCReportId)
        {
            try
            {
                string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IQCData"])).ToString();

                SendQCReport sqcr = new SendQCReport();
                // string json = CommHelper.ToJson(model.XMLData);
                string msg = "";
                if (sqcr.SPec_SaveIQCCheckResultTempXmlData(sendQCReportId, XMLData, out msg))
                {
                    return "{\"result\":0,\"msg\":\"提交成功:" + msg + "\"}";
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"提交失败:" + msg + "\"}";
                }
            }
            catch (Exception ex)
            {
                return "{\"result\":1,\"msg\":\"数据异常\"}";
            }
        }

        /// <summary>
        /// 保存玻璃质检数据
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string SaveIQCRMCheckResultTempXmlData(string sendQCReportId, string rawMaterialIQCCheckId)
        {
            try
            {
                string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IQCData"])).ToString();

                SendQCReport sqcr = new SendQCReport();
                string msg = "";
                if (sqcr.SPec_SaveIQCRMCheckResultTempXmlData(sendQCReportId, rawMaterialIQCCheckId, XMLData, out msg))
                {
                    return "{\"result\":0,\"msg\":\"提交成功:" + msg + "\"}";
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"提交失败:" + msg + "\"}";
                }
            }
            catch (Exception ex)
            {
                return "{\"result\":1,\"msg\":\"数据异常\"}";
            }
        }

        /// <summary>
        /// 加抽数据检验提交
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string GlassExtSubmit(string sendQCReportId)
        {
            try
            {
                string XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IQCData"])).ToString();
                string Describe = Convert.ToString(Request.Form["Describe"]);
                string ExtCheckNo = Convert.ToString(Request.Form["ExtCheckNo"]);
                SendQCReport sqcr = new SendQCReport();
                // string json = CommHelper.ToJson(model.XMLData);
                string msg = "";
                if (sqcr.SPec_GlassExtSubmit(sendQCReportId, Describe, XMLData, ExtCheckNo, out msg))
                {
                   return "{\"result\":0,\"msg\":\"提交成功:" + msg + "\"}";
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"提交失败:" + msg + "\"}";
                }
            }
            catch (Exception ex)
            {
                return "{\"result\":1,\"msg\":\"数据异常\"}";
            }

        }

        /// <summary>
        /// 半成品加抽
        /// </summary>
        /// <param name="sendQCReportId"></param>
        /// <param name="extQty"></param>
        private string ScanSubmitExt(string sendQCReportId, string extQty)
        {
            SendQCReport sqcr = new SendQCReport();
            // string json = CommHelper.ToJson(model.XMLData);
            string msg = "";
            if (sqcr.SPec_Speciment_ExtRecordSubmit(sendQCReportId, decimal.Parse(extQty), out msg))
            {
                return "{\"result\":0,\"msg\":\"加抽成功:" + msg + "\"}";
            }
            else
            {
                return "{\"result\":1,\"msg\":\"加抽失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 扫描添加行记录
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string RMIQCCheckScanAddSubmit(string sendQCReportId)
        {
            RawMaterialIQCCheckModel model = new RawMaterialIQCCheckModel();
            model.SendQCReportId = SendQCReportId;
            model.ScanSN = Convert.ToString(Request.Form["ScanSN"]);
            model.Qty = decimal.Parse(Request.Form["ScanQty"]);
            SendQCReport sqcr = new SendQCReport();
            // string json = CommHelper.ToJson(model.XMLData);
            string msg = "";
            if (sqcr.SPec_SQRMCheckResultScanAddSubmit(model, out msg))
            {
                return "{\"result\":0,\"msg\":\"扫描成功:" + msg + "\"}";
            }
            else
            {
                return "{\"result\":1,\"msg\":\"扫描失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 删除原材料行
        /// </summary>
        /// <param name="rawMaterialIQCCheckId"></param>
        private string RMResultDel(string rawMaterialIQCCheckId)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.SPec_SQRMCheckResultDel(rawMaterialIQCCheckId, out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"抽样记录删除失败:" + msg + "\"}";
            }
        }

        /// <summary>
        /// 玻璃检验结果提交
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string RMIQCCheckSubmit(string SendQCReportId)
        {
            try
            {
                RawMaterialIQCCheckModel model = new RawMaterialIQCCheckModel();
                model.CheckResult = Convert.ToInt32(Request.Form["CheckResult"]);
                model.CreateDate = DateTime.Now;
                model.FactoryId = "";
                model.SendQCReportId = SendQCReportId;
                model.XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IQCData"])).ToString();
                model.RawMaterialIQCCheckId = RawMaterialIQCCheckId;
                SendQCReport sqcr = new SendQCReport();
                // string json = CommHelper.ToJson(model.XMLData);
                string msg = "";
                if (sqcr.SPec_SQRMCheckResultSubmit(model, out msg))
                {
                    return "{\"result\":0,\"msg\":\"提交成功:" + msg + "\"}";
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"提交失败:" + msg + "\"}";
                }
            }
            catch (Exception ex)
            {
                return "{\"result\":1,\"msg\":\"数据异常\"}";
            }
        }

        /// <summary>
        /// 检验提交数据
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string IQCCheckResultSubmit(string sendQCReportId)
        {
            try
            {
                SOCheckResultModel model = new SOCheckResultModel();
                model.CheckResult = Convert.ToInt32(Request.Form["CheckResult"]);
                model.CreateDate = DateTime.Now;
                model.DefaultPath = "/upload/";
                model.FactoryId = "";
                model.ResourceId = "";
                model.SendQCReportId = SendQCReportId;
                model.UserId = "";
                model.CheckType = Convert.ToInt32(Request.Form["CheckType"]);
                model.XMLData = CommHelper.ConvertXmlToString(Convert.ToString(Request.Form["IQCData"])).ToString();
                model.AcceptQty = Convert.ToDecimal(Request.Form["AcceptQty"]);
                model.NGQty = Convert.ToDecimal(Request.Form["NGQty"]);
                model.Describe = Convert.ToString(Request.Form["Describe"]);

                SendQCReport sqcr = new SendQCReport();
                // string json = CommHelper.ToJson(model.XMLData);
                string msg = "";
                if (sqcr.SPec_SQCheckResultSubmit(model, out msg))
                {
                    return "{\"result\":0,\"msg\":\"提交成功:" + msg + "\"}";
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"提交失败:" + msg + "\"}";
                }
            }
            catch (Exception ex)
            {
                return "{\"result\":1,\"msg\":\"数据异常\"}";
            }
        }

        /// <summary>
        /// 样本抽取数据提交
        /// </summary>
        /// <param name="SQCId">送检单Id</param>
        /// <param name="CYFS">抽样方式</param>
        /// <param name="JCSP">检查水平</param>
        /// <param name="JYBZ">AQL值</param>
        /// <param name="ScanSN">扫描SN</param>
        /// <param name="CQ_Qty">抽取数量</param>
        private string ScanSubmit(string SQCId, string CYFS, string JCSP, string JYBZ, string ScanSN, string CQ_Qty)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.SPec_ScanSubmit(SQCId, CYFS, JCSP, JYBZ, ScanSN, CQ_Qty, out msg))
            {
                return "{\"result\":1,\"msg\":\"样本抽取成功:" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"样本抽取失败:" + msg + "\"}";
            }


        }

        /// <summary>
        /// 删除扫描记录
        /// </summary>
        /// <param name="SQCId"></param>
        private string DelScanList(string SQCId, string LotSN)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.delScanList(SQCId, LotSN, out msg))
            {
                return "{\"result\":1,\"msg\":\"" + msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"抽样记录删除失败:" + msg + "\"}";
            }

        }
        #endregion

        #region 获取数据
        /// <summary>
        /// 扫一扫获取数据
        /// </summary>
        /// <param name="sendQCReportId"></param>
        /// <param name="isQ"></param>
        /// <returns></returns>
        private string getScanInfo(string ScanLotSN, string isQ)
        {
            bool flag = false;
            if (isQ=="1")
            {
                flag = true;
            }
            IQCScanSubmit submit = new IQCScanSubmit();
            result.RetStr = submit.getScanLotUnknowSQId( ScanLotSN, flag, out outDataSet);
            if (result.Code == 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    //LotId,LotSN,Lot.Qty,ProductShortName, dbo.Product.ProductDescriptionSendQCReportId

                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    string json = "{" + String.Format("\"LotId\":\"{0}\" ,\"Qty\":\"{1}\",\"ProductShortName\":\"{2}\",\"ProductDescription\":\"{3}\",\"SendQCReportId\":\"{4}\"", dr["LotId"], Convert.ToInt32(dr["LotQty"]).ToString(), dr["ProductShortName"], dr["ProductDescription"],dr["SendQCReportId"]) + "}";
                    sb.Append(json);
                    if (i != outDataSet.Tables[0].Rows.Count - 1)
                    {
                        sb.Append(",");
                    }
                }
                sb.Append("]}");
                string str = sb.ToString();
                return sb.ToString();
            }
            else if (result.Code == -1)
            {
                return "{\"result\":1,\"msg\":\"" + result.Msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }
        }

        /// <summary>
        ///  根据产品ID获取检验项目
        /// </summary>
        /// <param name="pID"></param>
        private string getIQCCheckItemByPID(string pID)
        {

            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.getIQCCheckItemByPID(pID);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");

                //      SendQCReportId,   POName,  VendorName,  ProductId,ProductShortName

                string IsHasDone = "0";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    string json = "{" + String.Format("\"ProductId\":\"{0}\" ,\"IQC_CheckItemName\":\"{1}\"," +
                                  "\"IQC_CheckItemValueType\":\"{2}\",\"IQC_CheckItemStdValue\":\"{3}\"," +
                                  "\"IQC_CheckItemStdDownLimit\":\"{4}\",\"IQC_CheckItemStdUpLimit\":\"{5}\"",
                              dr["ProductId"], dr["IQC_CheckItemName"], dr["IQC_CheckItemValueType"], dr["IQC_CheckItemStdValue"],
                             dr["IQC_CheckItemStdDownLimit"], dr["IQC_CheckItemStdUpLimit"]) + "}";

                    sb.Append(json);
                    if (i != dt.Rows.Count - 1)
                    {
                        sb.Append(",");
                    }

                }

                sb.Append("]}");
                return sb.ToString();

            }
            else
            {
                return "{\"result\":0,\"msg\":\"没有数据\"}";
            }
        }

        private string getExtImgXmlData(string sendQCReportId)
        {
            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.getExtImgXmlData(SendQCReportId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                if (Convert.ToInt32(dr["RetValue"]) == 0)
                {
                    string XMLData = Convert.ToString(dr["XMLData"]);
                    if (XMLData != "")
                    {
                        string jsonData = CommHelper.XMLToJson(XMLData);
                        JObject o = JObject.Parse(jsonData);
                        JToken Token = o["IQCdata"];

                        sb.Append(CommHelper.JsonTOStr(Token));
                    }
                    else
                    {
                        return "{\"result\":-1,\"msg\":\"没有数据\"}"; 
                    }

                    sb.Append("}");
                    return sb.ToString();
                }
                else
                {
                    return "{\"result\":-1,\"msg\":\"获取失败\"}";
                }
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }
        }

        /// <summary>
        /// 获取加抽列表
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string GetRMExtRecordList(string sendQCReportId)
        {
            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.GetRMExtRecordList(SendQCReportId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");

                //      SendQCReportId,   POName,  VendorName,  ProductId,ProductShortName

                string IsHasDone = "0";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    string json = "{" + String.Format("\"SendQCReportId\":\"{0}\" ,\"Speciment_ExtRecordId\":\"{1}\"," +
                                  "\"CreateDate\":\"{2}\",\"CheckNo\":\"{3}\"," +
                            "\"ExtQty\":\"{4}\",\"IsDone\":\"{5}\",\"Describe\":\"{6}\"",
                             dr["SendQCReportId"], dr["Speciment_ExtRecordId"], Convert.ToDateTime(dr["CreateDate"]).ToString("yyyy-MM-dd HH:mm:ss"),
                             dr["CheckNo"], dr["ExtQty"], dr["IsDone"], dr["Describe"]) + "}";

                    sb.Append(json);
                    if (i != dt.Rows.Count - 1)
                    {
                        sb.Append(",");
                    }
                    if (Convert.ToString(dr["IsDone"]).ToUpper() == "FALSE")
                    {
                        IsHasDone = "1";
                    }

                }

                sb.Append("],\"IsHasDone\":" + IsHasDone + "}");
                return sb.ToString();
            }
            else
            {
                return "{\"result\":0,\"msg\":\"没有数据\"}";
            }
        }

        /// <summary>
        /// 获取原材料数据详细
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string GetRMIQCCheckDetailInfo(string sendQCReportId, string RawMaterialIQCCheckId)
        {
            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.GetSQRMCheckResultDetailData(SendQCReportId, RawMaterialIQCCheckId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                if (Convert.ToInt32(dr["RetValue"]) == 0)
                {
                    string XMLData = Convert.ToString(dr["XMLData"]);
                    if (!string.IsNullOrEmpty(XMLData))
                    {
                        string jsonData = CommHelper.XMLToJson(XMLData);
                        JObject o = JObject.Parse(jsonData);
                        JToken Token = o["IQCdata"];

                        Token["UV"].Parent.AddAfterSelf(new JProperty("SendQCReportId", Convert.ToString(dr["SendQCReportId"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("POName", Convert.ToString(dr["POName"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("SendQCReportNumber", Convert.ToString(dr["SendQCReportNumber"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("VendorName", Convert.ToString(dr["VendorName"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("ProductId", Convert.ToString(dr["ProductId"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("ProductShortName", Convert.ToString(dr["ProductShortName"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("ProductDescription", Convert.ToString(dr["ProductDescription"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("SendQCQty", Convert.ToString(dr["SendQCQty"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("SendDate", Convert.ToString(dr["SendDate"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("QCResult", Convert.ToString(dr["QCResult"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("SpecimentId", Convert.ToString(dr["SpecimentId"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("CYFS", Convert.ToString(dr["CYFS"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("CYSP", Convert.ToString(dr["CYSP"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("CYBZ", Convert.ToString(dr["CYBZ"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("CQty", Convert.ToString(dr["CQty"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("YBSN", Convert.ToString(dr["YBSN"])));

                        Token["UV"].Parent.AddAfterSelf(new JProperty("ScanSN", Convert.ToString(dr["ScanSN"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("Qty", Convert.ToString(dr["Qty"])));
                        Token["UV"].Parent.AddAfterSelf(new JProperty("IsCheck", Convert.ToString(dr["IsCheck"])));


                        sb.Append(CommHelper.JsonTOStr(Token));

                    }
                    else
                    {

                        string json = "{" + String.Format("\"SendQCReportId\":\"{0}\" ,\"POName\":\"{1}\"," +
                                        "\"SendQCReportNumber\":\"{2}\",\"VendorName\":\"{3}\",\"ProductId\":\"{4}\"," +
                                        "\"ProductShortName\":\"{5}\",\"ProductDescription\":\"{6}\",\"ScanSN\":\"{7}\",\"Qty\":\"{8}\",\"IsCheck\":\"{9}\",\"SpecimentId\":\"\"," +
                                        "\"CYFS\":\"{10}\",\"CYSP\":\"{11}\",\"CYBZ\":\"{12}\",\"CQty\":\"{13}\"",
                                        dr["SendQCReportId"], dr["POName"], dr["SendQCReportNumber"], dr["VendorName"], dr["ProductId"], dr["ProductShortName"], dr["ProductDescription"]
                                        , dr["ScanSN"], dr["Qty"], dr["IsCheck"], dr["CYFS"], dr["CYSP"], dr["CYBZ"], dr["CQty"]) + "}";
                        sb.Append(json);
                    }

                    sb.Append("}");
                    string str = sb.ToString();
                    return sb.ToString();
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"获取失败\"}";
                }
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }
        }

        /// <summary>
        /// 获取玻璃列表数据
        /// </summary>
        /// <param name="sendQCReportId"></param>
        private string GetRMIQCCheckList(string sendQCReportId)
        {
            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.GetRMIQCCheckInfo(SendQCReportId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");

                //      SendQCReportId,   POName,  VendorName,  ProductId,ProductShortName
                //ProductDescription,   SendQCQty,   CYFS ,  JYSP ,  JYBZ ,    JY_QTY,   IsCYDone
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataRow dr = dt.Rows[i];
                    string json = "{" + String.Format("\"SendQCReportId\":\"{0}\" ,\"RawMaterialIQCCheckId\":\"{1}\"," +
                                  "\"CreateDate\":\"{2}\",\"CheckResult\":\"{3}\"," +
                            "\"SQCheckResultId\":\"{4}\",\"CheckNO\":\"{5}\",\"ScanSN\":\"{6}\",\"IsCheck\":\"{7}\",\"Qty\":\"{8}\"",
                             dr["SendQCReportId"], dr["RawMaterialIQCCheckId"], Convert.ToDateTime(dr["CreateDate"]).ToString("yyyy-MM-dd HH:mm:ss"),
                             GetQCResultMsg(Convert.ToString(dr["CheckResult"])), dr["SQCheckResultId"], dr["CheckNO"], dr["ScanSN"], dr["IsCheck"], dr["Qty"]) + "}";

                    sb.Append(json);
                    if (i != dt.Rows.Count - 1)
                    {
                        sb.Append(",");
                    }

                }

                sb.Append("]}");
                return sb.ToString();

            }
            else
            {
                return "{\"result\":0,\"msg\":\"没有数据\"}";
            }
        }

        /// <summary>
        /// 获取数据详细
        /// </summary>
        /// <param name="SendQCReportId"></param>
        private string GetSpecCheckPageLoad(string SendQCReportId)
        {
            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.SpecCheckPageLoad(SendQCReportId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                if (Convert.ToInt32(dr["RetValue"]) == 0)
                {
                    string XMLData = Convert.ToString(dr["XMLData"]);
                    if (!string.IsNullOrEmpty(XMLData))
                    {
                        string jsonData = CommHelper.XMLToJson(XMLData);
                        JObject o = JObject.Parse(jsonData);
                        JToken Token = o["IQCdata"];

                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("SendQCReportId", Convert.ToString(dr["SendQCReportId"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("POName", Convert.ToString(dr["POName"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("SendQCReportNumber", Convert.ToString(dr["SendQCReportNumber"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("VendorName", Convert.ToString(dr["VendorName"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("ProductId", Convert.ToString(dr["ProductId"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("ProductShortName", Convert.ToString(dr["ProductShortName"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("ProductDescription", Convert.ToString(dr["ProductDescription"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("SendQCQty", Convert.ToString(dr["SendQCQty"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("SendDate", Convert.ToString(dr["SendDate"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("QCResult", Convert.ToString(dr["QCResult"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("SpecimentId", Convert.ToString(dr["SpecimentId"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("CYFS", Convert.ToString(dr["CYFS"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("CYSP", Convert.ToString(dr["CYSP"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("CYBZ", Convert.ToString(dr["CYBZ"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("CYBZ2", Convert.ToString(dr["CYBZ2"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("CQty", Convert.ToString(dr["CQty"])));
                        Token["CheckResult"].Parent.AddAfterSelf(new JProperty("YBSN", Convert.ToString(dr["YBSN"])));

                        //Token["CheckResult"].Parent.AddAfterSelf(new JProperty("AcceptQty", Convert.ToString(dr["AcceptQty"])));
                        //Token["CheckResult"].Parent.AddAfterSelf(new JProperty("NGQty", Convert.ToString(dr["NGQty"])));
                        sb.Append(CommHelper.JsonTOStr(Token));

                    }
                    else
                    {
                        return GetSpecPageLoad(SendQCReportId);
                    }

                    sb.Append("}");
                    return sb.ToString();
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"获取失败\"}";
                }
            }
            else
            {
                return GetSpecPageLoad(SendQCReportId);

            }
        }

        /// <summary>
        /// 抽检 页面加载事件
        /// </summary>
        private string GetSpecPageLoad(string SendQCReportId)
        {
            // SendQCReportId = "SQCR000000TL";//测试  

            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.SpecPageLoad(SendQCReportId);
            if (dt.Rows.Count > 0)
            {

                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                if (Convert.ToInt32(dr["RetValue"]) == 0)
                {
                    string json = "{" + String.Format("\"SendQCReportId\":\"{0}\" ,\"POName\":\"{1}\"," +
       "\"VendorName\":\"{2}\",\"ProductId\":\"{3}\",\"ProductDescription\":\"{4}\"," +
       "\"SendQCQty\":\"{5}\",\"CYFS\":\"{6}\",\"CYSP\":\"{7}\",\"CYBZ\":\"{8}\",\"CQty\":\"{9}\",\"IsCYDone\":\"{10}\",\"ProductShortName\":\"{11}\",\"TCQ_Qty\":\"{12}\",\"CYBZ2\":\"{13}\"," +
       "\"ACQty\":\"{14}\",\"ReQty\":\"{15}\",\"ACQty2\":\"{16}\",\"ReQty2\":\"{17}\"",
       dr["SendQCReportId"], dr["POName"], dr["VendorName"], dr["ProductId"], dr["ProductDescription"], dr["SendQCQty"], dr["CYFS"]
       , dr["JYSP"], dr["JYBZ"], dr["JY_QTY"], dr["IsCYDone"], dr["ProductShortName"], dr["TCQ_Qty"], dr["JYBZ2"],
       dr["ACQty"], dr["ReQty"], dr["ACQty2"], dr["ReQty2"]) + "}";
                    sb.Append(json);
                    sb.Append("}");
                    return sb.ToString();
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"获取失败\"}";
                }
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }
        }

        /// <summary>
        /// 获取扫描信息
        /// </summary>
        private string getScanSNInfo(string SendQCReportId,string ScanLotSN)
        {
            IQCScanSubmit submit = new IQCScanSubmit();
            result.RetStr = submit.getScanLot(SendQCReportId, ScanLotSN, out outDataSet);
            if (result.Code == 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    //LotId,LotSN,Lot.Qty,ProductShortName, dbo.Product.ProductDescription

                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    string json = "{" + String.Format("\"LotId\":\"{0}\" ,\"Qty\":\"{1}\",\"ProductShortName\":\"{2}\",\"ProductDescription\":\"{3}\"", dr["LotId"], Convert.ToInt32(dr["LotQty"]).ToString(), dr["ProductShortName"], dr["ProductDescription"]) + "}";
                    sb.Append(json);
                    if (i != outDataSet.Tables[0].Rows.Count - 1)
                    {
                        sb.Append(",");
                    }
                }
                sb.Append("]}");
                string str = sb.ToString();
                return sb.ToString();
            }
            else if (result.Code == -1)
            {
                return "{\"result\":1,\"msg\":\"" + result.Msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }
        }

        private string getInfoByYBSN(string SendQCReportId, string ScanLotSN) {
            SendQCReport sendQCReport = new SendQCReport();
            string sid = sendQCReport.GetIQCCheclIdByScanSn(ScanLotSN);
            if (sid != SendQCReportId)
            {
                return "{\"result\":1,\"msg\":\"信息不匹配\"}";
            }
            result.RetStr = sendQCReport.getSendQCReportInfo(sid, out outDataSet);
            if (result.Code == 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    //LotId,LotSN,Lot.Qty,ProductShortName, dbo.Product.ProductDescription

                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    string json = "{" + String.Format("\"ProductId\":\"{0}\" ,\"Qty\":\"{1}\",\"ProductShortName\":\"{2}\",\"ProductDescription\":\"{3}\"", dr["ProductId"], Convert.ToInt32(dr["SendQCQty"]).ToString(), dr["ProductShortName"], dr["ProductDescription"]) + "}";
                    sb.Append(json);
                    if (i != outDataSet.Tables[0].Rows.Count - 1)
                    {
                        sb.Append(",");
                    }
                }
                sb.Append("]}");
                string str = sb.ToString();
                return sb.ToString();
            }
            else if (result.Code == -1)
            {
                return "{\"result\":1,\"msg\":\"" + result.Msg + "\"}";
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }
        } 
         
        /// <summary>
        /// 获取AQL参数
        /// </summary>
        private string getAQL_Info(string SQCID)
        {
            SendQCReport sqcr = new SendQCReport();
            DataTable dt = sqcr.getAQLInfo(SQCID, "", "", "");
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                string result, RetMsg = "";
                result = dr["RetValue"].ToString();
                RetMsg = dr["RetMsg"].ToString();
                if (result == "0")
                {
                    //AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty 
                    StringBuilder sb = new StringBuilder();
                    sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                    string json = "{" + String.Format("\"SampleQty\":\"{0}\" ,\"ACQty\":\"{1}\",\"ReQty\":\"{2}\",\"ACQty2\":\"{3}\",\"ReQty2\":\"{4}\",\"CheckLevel\":\"{5}\",\"AQL1\":\"{6}\",\"AQL2\":\"{7}\"",
                            dr["AQLSampleSizeQty"].ToString(), Convert.ToInt32(dr["ACQty"]).ToString(), dr["ReQty"], dr["ACQty2"], dr["ReQty2"], dr["CheckLevel"], dr["AQL1"], dr["AQL2"]) + "}]}";
                    sb.Append(json);
                    string str = sb.ToString();
                    return str;
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"" + RetMsg + "\"}";
                }

            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取AQL信息失败\"}";
            }
        }

        /// <summary>
        /// 根据AQL参数获取样本和允收标准
        /// </summary>
        /// <param name="SQCID"></param>
        /// <param name="cyfs"></param>
        /// <param name="jcsp"></param>
        /// <param name="jybz"></param>
        private string selectAQL_Info(string SQCID, string cyfs, string jcsp, string jybz)
        {
            SendQCReport sqcr = new SendQCReport();
            DataTable dt = sqcr.selectAQLInfo(SQCID, cyfs, jcsp, jybz);
            if (dt.Rows.Count > 0)
            {
                DataRow dr = dt.Rows[0];
                string result, RetMsg = "";
                result = dr["RetValue"].ToString();
                RetMsg = dr["RetMsg"].ToString();
                if (result == "0")
                {
                    //AQLSampleSizeQty,@ACQty AS ACQty,@ReQty AS ReQty 
                    StringBuilder sb = new StringBuilder();
                    sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                    string json = "{" + String.Format("\"SampleQty\":\"{0}\" ,\"ACQty\":\"{1}\",\"ReQty\":\"{2}\"",
                            dr["AQLSampleSizeQty"].ToString(), Convert.ToInt32(dr["ACQty"]).ToString(), dr["ReQty"]) + "}]}";
                    sb.Append(json);

                    string str = sb.ToString();
                    return str;
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"" + RetMsg + "\"}";
                }

            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取AQL信息失败\"}";
            }
        }

        /// <summary>
        /// 获取样本扫描列表
        /// </summary>
        /// <param name="SQCId">送检Id</param>
        private string LoadScanList(string SQCId)
        {
            try
            {
                SendQCReport sqcr = new SendQCReport();
                DataTable dt = sqcr.getScanList(SQCId);
                int T_CQty = 0;
                if (dt.Rows.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("{\"result\":0,\"msg\":\"扫描记录获取成功" + SQCId + "\",\"data\":[");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        //LotId,LotSN, CYFS,CYSP,CYBZ ,SpecQty

                        DataRow dr = dt.Rows[i];
                        string json = "{" + String.Format("\"LotId\":\"{0}\",\"LotSN\":\"{1}\",\"CYFS\":\"{2}\",\"CYSP\":\"{3}\",\"CYBZ\":\"{4}\",\"SpecQty\":\"{5}\"",
                                dr["LotId"], dr["LotSN"], dr["CYFS"], dr["CYSP"], dr["CYBZ"], dr["SpecQty"]) + "}";
                        sb.Append(json);
                        if (i != dt.Rows.Count - 1)
                        {
                            sb.Append(",");
                        }
                        T_CQty += Convert.ToInt32(dr["SpecQty"]);
                        /* */
                    }
                    sb.Append("],\"T_Qty\":\"" + T_CQty.ToString() + "\"");
                    sb.Append("}");
                    return sb.ToString();

                }
                else
                {
                    return "{\"result\":0,\"msg\":\"扫描记录获取成功\"}";

                }
            }
            catch (Exception ex)
            {
                return "{\"result\":-1,\"msg\":\"" + ex.Message + "\"}";

            }

        }


        #endregion

        private string GetQCResultMsg(string QCResult)
        {
            switch (QCResult)
            {
                //QC检查结果(0-未确认,1-全部接受,2-让步接受(特采),3-挑选接受,4-免检,5-全部拒收)
                case "0":
                    return "待检验";
                case "1":
                    return "合格";
                case "2":
                    return "不合格";
                //case "4":
                //    return "免检";
                //case "5":
                //    return "全部拒收";
                default:
                    return "未知错误";
            }
        }

        private string GetPrintContentBase64(string SendQCReportId, string YBBQ)
        {
            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.SPec_GetPrintData(SendQCReportId, YBBQ);
            if (dt.Rows.Count > 0)
            {

                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":");

                DataRow dr = dt.Rows[0];
                if (Convert.ToInt32(dr["RetValue"]) == 0)
                {
                    PrintDataModel model = new PrintDataModel();
                    model.AQL1 = Convert.ToString(dr["AQL1"]);
                    model.AQL2 = Convert.ToString(dr["AQL2"]);
                    model.CYFS = Convert.ToString(dr["CYFS"]);
                    model.CYSP = Convert.ToString(dr["CYSP"]);
                    model.ProductDescribe = Convert.ToString(dr["ProductDescribe"]);
                    model.ProductShortName = Convert.ToString(dr["ProductShortName"]);
                    model.SampleSize = Convert.ToString(dr["SampleSize"]);
                    model.POName = Convert.ToString(dr["POName"]);
                    model.YBBQ = Convert.ToString(dr["YBSN"]);
                    model.SendDate = Convert.ToDateTime(dr["SendDate"]);
                    model.Describe = Convert.ToString(dr["Describe"]);
                    PrintCodeConvert pc = new PrintCodeConvert();

                    string Msg = pc.GetPrintCodeConvertStr(model);
                    return "{\"result\":1,\"msg\":\"" + Msg + "\"}";
                }
                else
                {
                    return "{\"result\":1,\"msg\":\"获取失败\"}";
                }
            }
            else
            {
                return "{\"result\":-1,\"msg\":\"获取失败\"}";
            }


        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class RM_IQC : System.Web.UI.Page
    {

        public DataSet outDataSet = new DataSet();
        public funResult result = new funResult();

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
                    return "RG01400000048";
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
         

        protected void Page_Load(object sender, EventArgs e)
        {
            switch (FunType)
            {
                case "":
                    getScanSNInfo();
                    break;
                case "getAQL":
                    getAQL_Info(SendQCReportId, CYFS, JCSP, JYBZ);
                    break;
                case "selAQL":
                    selectAQL_Info(SendQCReportId, CYFS, JCSP, JYBZ);
                    break;
                case "PageLoad":
                    GetSpecPageLoad(SendQCReportId);
                    break;
                case "ScanSubmit":
                    ScanSubmit(SendQCReportId, CYFS, JCSP, JYBZ, ScanSN, CQ_Qty);
                    break;
                case "LoadScanList":
                    LoadScanList(SendQCReportId);
                    break;
                case "DelScanList":
                    DelScanList(SendQCReportId, DelSN);
                    break;
                case "PrintLabel":
                    PrintSQCLabels(SendQCReportId, CYFS, JCSP, JYBZ);
                    break;
                default:
                    break;
            }

        }

        /// <summary>
        /// 抽检 页面加载事件
        /// </summary>
        private void GetSpecPageLoad(string SendQCReportId)
        {


            SendQCReportId = "SQCR000000TL";//测试  


            SendQCReport SQCR = new SendQCReport();
            DataTable dt = SQCR.SpecPageLoad(SendQCReportId);
            if (dt.Rows.Count > 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");

                //      SendQCReportId,   POName,  VendorName,  ProductId,ProductShortName
                //ProductDescription,   SendQCQty,   CYFS ,  JYSP ,  JYBZ ,    JY_QTY,   IsCYDone

                DataRow dr = dt.Rows[0];
                if (Convert.ToInt32(dr["RetValue"]) == 0)
                {
                    string json = "{" + String.Format("\"SendQCReportId\":\"{0}\" ,\"POName\":\"{1}\"," +
                        "\"VendorName\":\"{2}\",\"ProductId\":\"{3}\",\"ProductDescription\":\"{4}\"," +
                        "\"SendQCQty\":\"{5}\",\"CYFS\":\"{6}\",\"JYSP\":\"{7}\",\"JYBZ\":\"{8}\",\"JY_QTY\":\"{9}\",\"IsCYDone\":\"{10}\",\"ProductShortName\":\"{11}\",\"TCQ_Qty\":\"{12}\"",
                        dr["SendQCReportId"], dr["POName"], dr["VendorName"], dr["ProductId"], dr["ProductDescription"], dr["SendQCQty"], dr["CYFS"]
                        , dr["JYSP"], dr["JYBZ"], dr["JY_QTY"], dr["IsCYDone"], dr["ProductShortName"], dr["TCQ_Qty"]) + "}";
                    sb.Append(json);
                    sb.Append("]}");
                    string str = sb.ToString();
                    Response.Write(sb.ToString());
                }
                else
                {
                    Response.Write("{\"result\":1,\"" + dr["RetMsg"].ToString() + "\":\"获取失败\"}");
                }
            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"获取失败\"}");
            }
        }


        /// <summary>
        /// 获取扫描信息
        /// </summary>
        private void getScanSNInfo()
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
                Response.Write(sb.ToString());
            }
            else if (result.Code == -1)
            {
                Response.Write("{\"result\":1,\"msg\":\"" + result.Msg + "\"}");
            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"获取失败\"}");
            }
        }



        /// <summary>
        /// 获取AQL参数
        /// </summary>
        private void getAQL_Info(string SQCID, string cyfs, string jcsp, string jybz)
        {
            SendQCReport sqcr = new SendQCReport();
            DataTable dt = sqcr.getAQLInfo(SQCID, cyfs, jcsp, jybz);
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
                    Response.Write(sb.ToString());
                    return;
                }
                else
                {
                    Response.Write("{\"result\":1,\"msg\":\"" + RetMsg + "\"}");
                }

            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"获取AQL信息失败\"}");
            }
        }


        /// <summary>
        /// 根据AQL参数获取样本和允收标准
        /// </summary>
        /// <param name="SQCID"></param>
        /// <param name="cyfs"></param>
        /// <param name="jcsp"></param>
        /// <param name="jybz"></param>
        private void selectAQL_Info(string SQCID, string cyfs, string jcsp, string jybz)
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
                    Response.Write(sb.ToString());
                    string str = sb.ToString();
                    return;
                }
                else
                {
                    Response.Write("{\"result\":1,\"msg\":\"" + RetMsg + "\"}");
                }

            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"获取AQL信息失败\"}");
            }
        }


        /// <summary>
        /// 获取样本扫描列表
        /// </summary>
        /// <param name="SQCId">送检Id</param>
        private void LoadScanList(string SQCId = "SQCR000000TK")
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
                    Response.Write(sb.ToString());

                }
                else
                {
                    Response.Write("{\"result\":0,\"msg\":\"扫描记录获取成功\"}");

                }
            }
            catch (Exception ex)
            {
                Response.Write("{\"result\":-1,\"msg\":\"" + ex.Message + "\"}");

            }

        }

        /// <summary>
        /// 样本抽取数据提交
        /// </summary>
        /// <param name="SQCId">送检单Id</param>
        /// <param name="CYFS">抽样方式</param>
        /// <param name="JCSP">检查水平</param>
        /// <param name="JYBZ">检验标准</param>
        /// <param name="ScanSN">扫描SN</param>
        /// <param name="CQ_Qty">抽取数量</param>
        private void ScanSubmit(string SQCId, string CYFS, string JCSP, string JYBZ, string ScanSN, string CQ_Qty)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.SPec_ScanSubmit(SQCId, CYFS, JCSP, JYBZ, ScanSN, CQ_Qty, out msg))
            {
                Response.Write("{\"result\":1,\"msg\":\"样本抽取成功:" + msg + "\"}");
            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"样本抽取失败:" + msg + "\"}");
            }


        }

        /// <summary>
        /// 删除扫描记录
        /// </summary>
        /// <param name="SQCId"></param>
        private void DelScanList(string SQCId, string LotSN)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.delScanList(SQCId, LotSN, out msg))
            {
                Response.Write("{\"result\":1,\"msg\":\"" + msg + "\"}");
            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"抽样记录删除失败:" + msg + "\"}");
            }

        }

        /// <summary>
        /// 生产并打印物料标签
        /// </summary>
        /// <param name="SQCId"></param>
        private void PrintSQCLabels(string SQCId, string CYFS, string JCSP, string JYBZ)
        {
            SendQCReport sqcr = new SendQCReport();
            string msg = "";
            if (sqcr.PrintSQCLabel(SQCId, CYFS, JCSP, JYBZ, out msg))
            {
                Response.Write("{\"result\":1,\"msg\":\"" + msg + "\"}");
            }
            else
            {
                Response.Write("{\"result\":-1,\"msg\":\"打印样本标签失败:" + msg + "\"}");
            }
        }





    }



}
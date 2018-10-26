using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class GetSpecimens : System.Web.UI.Page
    {
        public DataSet outDataSet = new DataSet();
        public funResult result = new funResult();



        //页码
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
                    return "SQCR000001JY";
                }
            }
        }
        private string IsDone
        {
            get
            {
                if (Request.QueryString["IsDone"] != null)
                {
                    return Request.QueryString["IsDone"];
                }
                else
                {
                    return "1";
                }
            }
        }

        private string qrcode
        {
            get
            {
                if (Request.QueryString["qrcode"] != null)
                {
                    return Request.QueryString["qrcode"];
                }
                else
                {
                    return "来料送检抽样";
                }
            }
        }



        private string desc
        {
            get
            {
                if (Request.QueryString["ScanProductDesc"] != null)
                {
                    return Request.QueryString["ScanProductDesc"];
                }
                else
                {
                    return "";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SQCID.Value = SendQCReportId;
            IsS.Value = IsDone;
            SN.Value = qrcode;
            //SendQCReport SQ = new SendQCReport();
            //result.RetStr = SQ.getSendQCReportInfo(SendQCReportId,  out outDataSet);
            //if (result.Code == 0)
            //{

            //    if (outDataSet.Tables[0].Rows.Count > 0)
            //    {
            //        SQCID.Value = SendQCReportId;
            //        lb_POName.Text = outDataSet.Tables[0].Rows[0]["POName"].ToString();
            //        lb_Vendor.Text = outDataSet.Tables[0].Rows[0]["VendorName"].ToString();
            //        lb_PrdNo.Text = outDataSet.Tables[0].Rows[0]["ProductShortName"].ToString();
            //        lb_Product.Text = outDataSet.Tables[0].Rows[0]["ProductDescription"].ToString();
            //        lb_SendQty.Text = Convert.ToUInt32(outDataSet.Tables[0].Rows[0]["SendQCQty"]).ToString();
            //    }
            //}
            //else
            //{
            //    Response.Write("{\"result\":1,\"msg\":\"获取失败\"}");
            //}

        }

        protected void dwl_JYSP_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void dl_JYBZ_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
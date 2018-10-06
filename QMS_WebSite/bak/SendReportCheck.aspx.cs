using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class SendReportCheck : System.Web.UI.Page
    { 
        public DataSet outDataSet = new DataSet();
        public funResult result = new funResult();

        //id
        private String SendQCReportId
        {
            get
            {
                if (Request.QueryString["SendQCReportId"] != null)
                {

                    return Request.QueryString["SendQCReportId"].ToString();

                }
                else
                {
                    return "";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            SendQCReport SQ = new SendQCReport();
            result.RetStr = SQ.getSendQCReportInfo(SendQCReportId, out outDataSet);
            if (result.Code == 0)
            {
                if (outDataSet.Tables[0].Rows.Count > 0)
                {
                    // studentId.Value = outDataSet.Tables[0].Rows[0]["SendQCReportId"].ToString();
                    //lblName.Text = outDataSet.Tables[0].Rows[0]["name"].ToString();
                    //lblSex.Text = outDataSet.Tables[0].Rows[0]["sex"].ToString();
                    //lblNo.Text = outDataSet.Tables[0].Rows[0]["no"].ToString();
                    //lblPhone.Text = outDataSet.Tables[0].Rows[0]["phone"].ToString();
                    //lblAddress.Text = outDataSet.Tables[0].Rows[0]["address"].ToString();
                    //score.Text = outDataSet.Tables[0].Rows[0]["score"].ToString();

                }
            }
            else
            {
                Response.Write(result.Msg);
            }
        }

    }
}
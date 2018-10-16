using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.IQC.add
{
    public partial class GlassIQC_Check : System.Web.UI.Page
    { 
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
                    return "SQCR00000164";//SQCR000000TI
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SQCID.Value = SendQCReportId;
        } 
    }
}
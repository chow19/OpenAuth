using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class RawMaterialIQC_Check : System.Web.UI.Page
    {
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

        protected void Page_Load(object sender, EventArgs e)
        {
            SQCID.Value = SendQCReportId;
        }
    }
}
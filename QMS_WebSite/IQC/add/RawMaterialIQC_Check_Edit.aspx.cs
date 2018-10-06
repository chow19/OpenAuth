using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.IQC.add
{
    public partial class RawMaterialIQC_Check_Edit : System.Web.UI.Page
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
                    return "SQCR0000011V";//
                }
            }
        }
        private String RawMaterialIQCCheckId
        {
            get
            {
                if (Request.QueryString["RawMaterialIQCCheckId"] != null)
                {
                    return Request.QueryString["RawMaterialIQCCheckId"].ToString();
                }
                else
                {
                    return "CFC0974E-4E3";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SQCID.Value = SendQCReportId;
            RMIID.Value = RawMaterialIQCCheckId;

        }

    }
}
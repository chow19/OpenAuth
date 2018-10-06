using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class GetSQDetails : System.Web.UI.Page
    {
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
            SQCID.Value = SendQCReportId;
        }
    }
}
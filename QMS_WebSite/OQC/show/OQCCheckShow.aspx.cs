using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.OQC.show
{
    public partial class OQCCheckShow : System.Web.UI.Page
    {
        private String OQCCheckId
        {
            get
            {
                if (Request.QueryString["OQCCheckId"] != null)
                {
                    return Request.QueryString["OQCCheckId"].ToString();
                }
                else
                {
                    return "";// 
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            OID.Value = OQCCheckId;
        }
    }
}
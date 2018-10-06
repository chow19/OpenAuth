using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.OQC.add
{
    public partial class OQCCheckAdd : System.Web.UI.Page
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
                    return "5F9AEC6A-A51";// 
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            OID.Value = OQCCheckId;
        }
    }
}
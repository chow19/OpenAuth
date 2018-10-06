using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.FQC.add
{
    public partial class FQCSpecimentCheckAdd : System.Web.UI.Page
    {
        private String FQCCheckId
        {
            get
            {
                if (Request.QueryString["FQCCheckId"] != null)
                {
                    return Request.QueryString["FQCCheckId"].ToString();
                }
                else
                {
                    return "";// 
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        { 
           FID.Value = FQCCheckId;
        }
    }
}
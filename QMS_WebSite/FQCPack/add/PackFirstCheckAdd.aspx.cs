using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.FQCPack.add
{
    public partial class PackFirstCheckAdd : System.Web.UI.Page
    {
        private String FQCCheckPackId
        {
            get
            {
                if (Request.QueryString["FQCCheckPackId"] != null)
                {
                    return Request.QueryString["FQCCheckPackId"].ToString();
                }
                else
                {
                    return "44056936-5E5";// 
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            FID.Value = FQCCheckPackId;
        }
    }
}
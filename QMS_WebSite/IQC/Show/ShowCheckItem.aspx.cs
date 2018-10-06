using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.IQC.Show
{
    public partial class ShowCheckItem : System.Web.UI.Page
    {
        private String ProductId
        {
            get
            {
                if (Request.QueryString["PID"] != null)
                {

                    return Request.QueryString["PID"].ToString();

                }
                else
                {
                    return "";
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            PID.Value = ProductId;
        }
    }
}
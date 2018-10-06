using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.IPQC.add
{
    public partial class Examination_Check : System.Web.UI.Page
    {
        private String WFSteptId
        {
            get
            {
                if (Request.QueryString["WFSteptId"] != null)
                {
                    return Request.QueryString["WFSteptId"].ToString();
                }
                else
                {
                    return "";// 
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            SteptID.Value = WFSteptId;
        }
    }
}
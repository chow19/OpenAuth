using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite.IPQCRoute.show
{
    public partial class Examination_Show : System.Web.UI.Page
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

        private String _RouteId
        {
            get
            {
                if (Request.QueryString["RouteId"] != null)
                {
                    return Request.QueryString["RouteId"].ToString();
                }
                else
                {
                    return "F3AB2A2F-B2C";// 
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            SteptID.Value = WFSteptId;
            RouteId.Value = _RouteId;
        }
    }
}
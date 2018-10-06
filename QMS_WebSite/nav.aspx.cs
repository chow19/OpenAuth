using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class nav : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");

            string url1 = "{" + String.Format("\"url\":\"{0}\",\"displayName\":\"{1}\"", "~/Default.aspx", "应用") + "}";
            sb.Append(url1 + ",");

            string url2 = "{" + String.Format("\"url\":\"{0}\",\"displayName\":\"{1}\"", "~/Message.aspx", "消息") + "}";
            sb.Append(url2 + ",");
            string url3 = "{" + String.Format("\"url\":\"{0}\",\"displayName\":\"{1}\"", "~/Setting.aspx", "设置") + "}";
            sb.Append(url3 );
            sb.Append("]}");
            Response.Write( sb.ToString());

        }
    }
}
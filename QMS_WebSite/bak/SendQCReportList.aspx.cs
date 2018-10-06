using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
   
    public partial class SendQCReportList : System.Web.UI.Page
    {
        public DataSet outDataSet = new DataSet();
        public funResult result = new funResult();
        //页码
        private int curPage
        {
            get
            {
                if (Request.QueryString["curPage"] != null)
                {

                    return Convert.ToInt32(Request.QueryString["curPage"]);

                }
                else
                {
                    return 1;
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            int pageCount, recCount;
            SendQCReport SQ = new SendQCReport();
            result.RetStr = SQ.getSendQCReportList("", "", 20, curPage, out pageCount, out recCount, out outDataSet);
            if (result.Code == 0)
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("{\"result\":0,\"msg\":\"获取成功\",\"data\":[");
                for (int i = 0; i < outDataSet.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = outDataSet.Tables[0].Rows[i];
                    int SendQty = Convert.IsDBNull(dr["SendQCQty"]) ? 0 : Convert.ToInt32(dr["SendQCQty"]);
                    string json = "{" + String.Format("\"SendQCReportId\":\"{0}\",\"SendQCReportNumber\":\"{1}\",\"VendorName\":\"{2}\","

                        + "\"ProductShortName\":\"{3}\",\"ProductDescription\":\"{4}\",\"SendQCQty\":\"{5}\",\"SendDate\":\"{6}\",\"QCResult\":\"{7}\",\"POName\":\"{8}\"",
                        dr["SendQCReportId"], dr["SendQCReportNumber"], dr["VendorName"], dr["ProductShortName"],
                        dr["ProductDescription"], SendQty.ToString(), dr["SendDate"], dr["QCResult"], dr["POName"]) + "}";
                    sb.Append(json);
                    if (i != outDataSet.Tables[0].Rows.Count - 1)
                    {
                        sb.Append(",");
                    }
                }
                sb.Append("]}");
                string str = sb.ToString();
                Response.Write(sb.ToString());
            }
            else
            {
                Response.Write("{\"result\":1,\"msg\":\"获取失败\"}");
            }

        }
    }
}
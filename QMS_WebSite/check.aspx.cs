using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class check : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           string a= Check(Request["signature"], Request["timestamp"], Request["nonce"], Request["echostr"]);
            Response.Write(a);
            Response.End();
        }

        public string Check(string signature, string timestamp, string nonce, string echostr)
        {
 
            string Token = "aoaoao552255221a1222sz";
            //token = (token ?? );
            string[] value = (from z in new string[]
            {
                Token,
                timestamp,
                nonce
            }
                              orderby z
                              select z).ToArray<string>();
            string tmpStr = string.Join("", value);
            tmpStr = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
            tmpStr = tmpStr.ToLower();
            if (tmpStr == signature)
            {
                if (!string.IsNullOrEmpty(echostr))
                { 
                    return echostr;//推送 
                }
            } 
            return "";

        }
    }
}
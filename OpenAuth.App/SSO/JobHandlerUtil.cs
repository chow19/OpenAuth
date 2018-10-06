using Infrastructure;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace OpenAuth.App.SSO
{
   
    public class JobHandlerUtil
    {
        static HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);

        public static bool Job(string url,out string msg)
        { 
            var requestUri = String.Format(url);
            msg = "";
            try
            {
                var value = _helper.Get(null, requestUri);
                var result = JsonHelper.Instance.Deserialize<Response<bool>>(value);
                if (result.Code == 200)
                {
                    return true;
                }
                else {
                    msg = result.Message;
                    return false;
                }
             
            }
            catch (Exception ex)
            {
                msg= ex.Message;
                return false;
            }
        }
        
    }
}

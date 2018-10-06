using Infrastructure;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.SSO
{
    public  class DDDeptSync
    {
        static HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);

        public static Response<string> SyncDDDept()
        { 
            var requestUri = "/api/Sync/SyncOrgAuto"; 
            try
            {
                var value = _helper.Post(new
                { 
                }, requestUri);
                var result = JsonHelper.Instance.Deserialize<Response<string>>(value);
                return result;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}

using Infrastructure;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.SSO
{
    public class DDUserSync
    {
        static HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);

        public static Response<string> SyncDDUser(string id)
        {
            var requestUri =string.Format( "/api/Sync/InsertSyncDataToUserByOid?OID={0}",id);
            try
            {
                var value = _helper.Post(new
                {
                    OID = id
                }, requestUri);
                var result = JsonHelper.Instance.Deserialize<Response<string>>(value);
                return result;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public static Response<string> SyncDDUserFromOtherUser()
        {
            var requestUri = "/api/Sync/SyncUserAuto";
            try
            {
                var value  = _helper.Post(new { }, requestUri);
                var result = JsonHelper.Instance.Deserialize<Response<string>>(value);
                return result;
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}

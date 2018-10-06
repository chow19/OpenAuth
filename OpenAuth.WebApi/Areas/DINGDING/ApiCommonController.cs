using OpenAuth.App.DingDing; 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace OpenAuth.WebApi.Areas.DINGDING
{

    public class ApiCommonController: ApiController
    {
        public string _CorpId;
        public string _CorpSecret;
        public string _AgentId;
        public string _accessToken;

        public ApiCommonController() {
            _CorpId = DDHelper.GetCorpId();
            _CorpSecret = DDHelper.CorpSecret();
            _AgentId = DDHelper.GetAgentId();
            _accessToken = DDHelper.GetToken( ); 
        }

    }
}
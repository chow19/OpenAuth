using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenAuth.WebApi.Areas.WEIXIN.Models
{
    public class TokenResultModel
    {
        public string access_token { get; set; }
        public int expires_in { get; set; }
        public string errmsg { get; set; }
        public string errcode { get; set; }
    }
}
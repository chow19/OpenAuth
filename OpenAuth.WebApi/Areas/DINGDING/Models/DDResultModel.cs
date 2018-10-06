using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenAuth.WebApi.Areas.DINGDING.Models
{
    public class TokenResultModel
    {
        public int errcode { get; set; }
        public string errmsg { get; set; }
        public string access_token { get; set; }
        public int expires_in { get; set; }
    }

    public class JSticketModel
    {
        public int errcode { get; set; }
        public string errmsg { get; set; }
        public string ticket { get; set; }
        public int expires_in { get; set; }
    }
}
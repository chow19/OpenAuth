using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Model
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
    public class UserIdModel
    { 
        public int errcode { get; set; }
        public string errmsg { get; set; }
        public string userid { get; set; }
        public string deviceId { get; set; }
        public bool is_sys { get; set; }
        public string sys_level { get; set; }

    }
}

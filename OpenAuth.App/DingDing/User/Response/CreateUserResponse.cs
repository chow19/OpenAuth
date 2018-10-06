using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.User.Response
{
    public class CreateUserResponse
    {
        /// <summary>
        /// errcode
        /// </summary> 
        public long Errcode { get; set; }

        /// <summary>
        /// errmsg
        /// </summary> 
        public string Errmsg { get; set; }

        /// <summary>
        /// id
        /// </summary> 
        public string Userid { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Dept.Respon
{
    /// <summary>
    /// OapiDepartmentCreateResponse.
    /// </summary>
    public class CreateDeptRespon
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
        public long Id { get; set; }

    }
}

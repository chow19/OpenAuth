using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Dept.Respon
{
    public class GetDeptListRespon
    {
        /// <summary>
        /// department
        /// </summary> 
        public List<DepartmentDomain> Department { get; set; }

        /// <summary>
        /// errcode
        /// </summary> 
        public long Errcode { get; set; }

        /// <summary>
        /// errmsg
        /// </summary> 
        public string Errmsg { get; set; }

        /// <summary>
        /// DepartmentDomain Data Structure.
        /// </summary>
        [Serializable] 
        public class DepartmentDomain  
        {
            /// <summary>
            /// autoAddUser
            /// </summary> 
            public bool AutoAddUser { get; set; }

            /// <summary>
            /// createDeptGroup
            /// </summary> 
            public bool CreateDeptGroup { get; set; }

            /// <summary>
            /// id
            /// </summary> 
            public long Id { get; set; }

            /// <summary>
            /// name
            /// </summary> 
            public string Name { get; set; }

            /// <summary>
            /// parentid
            /// </summary> 
            public long Parentid { get; set; }

            /// <summary>
            /// sourceIdentifier
            /// </summary> 
            public string SourceIdentifier { get; set; }
        }

    }
}

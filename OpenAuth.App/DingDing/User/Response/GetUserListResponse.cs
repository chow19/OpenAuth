using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.User.Response
{
   public class GetUserListResponse
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
        /// hasMore
        /// </summary> 
        public bool HasMore { get; set; }

        /// <summary>
        /// userlist
        /// </summary> 
        public List<UserlistDomain> Userlist { get; set; }

        /// <summary>
        /// UserlistDomain Data Structure.
        /// </summary>
        [Serializable] 
        public class UserlistDomain  
        {
            /// <summary>
            /// active
            /// </summary> 
            public bool Active { get; set; }

            /// <summary>
            /// avatar
            /// </summary> 
            public string Avatar { get; set; }

            /// <summary>
            /// department
            /// </summary> 
            public List< string> Department { get; set; }

            /// <summary>
            /// dingId
            /// </summary> 
           // public string DingId { get; set; }

            /// <summary>
            /// email
            /// </summary> 
            public string Email { get; set; }

            /// <summary>
            /// extattr
            /// </summary> 
            public string Extattr { get; set; }

            /// <summary>
            /// hiredDate
            /// </summary> 
            public string HiredDate { get; set; }

            /// <summary>
            /// isAdmin
            /// </summary> 
            public bool IsAdmin { get; set; }

            /// <summary>
            /// isBoss
            /// </summary> 
            public bool IsBoss { get; set; }

            /// <summary>
            /// isHide
            /// </summary> 
            public bool IsHide { get; set; }

            /// <summary>
            /// isLeader
            /// </summary> 
            public bool IsLeader { get; set; }

            /// <summary>
            /// jobnumber
            /// </summary> 
            public string Jobnumber { get; set; }

            /// <summary>
            /// mobile
            /// </summary> 
            public string Mobile { get; set; }

            /// <summary>
            /// name
            /// </summary> 
            public string Name { get; set; }

            /// <summary>
            /// order
            /// </summary> 
            public long Order { get; set; }

            /// <summary>
            /// orgEmail
            /// </summary> 
            public string OrgEmail { get; set; }

            /// <summary>
            /// position
            /// </summary> 
            public string Position { get; set; }

            /// <summary>
            /// remark
            /// </summary> 
            public string Remark { get; set; }

            /// <summary>
            /// tel
            /// </summary> 
            public string Tel { get; set; }

            /// <summary>
            /// unionid
            /// </summary> 
            public string Unionid { get; set; }

            /// <summary>
            /// userid
            /// </summary> 
            public string Userid { get; set; }

            /// <summary>
            /// workPlace
            /// </summary> 
            public string WorkPlace { get; set; }
        }

    }
}

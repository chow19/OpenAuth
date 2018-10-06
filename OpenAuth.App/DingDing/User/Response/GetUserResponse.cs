using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.User.Response
{
   public class GetUserResponse
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
        public List<long> Department { get; set; }

        /// <summary>
        /// dingId
        /// </summary> 
       // public string DingId { get; set; }

        /// <summary>
        /// email
        /// </summary> 
        public string Email { get; set; }

        /// <summary>
        /// errcode
        /// </summary> 
        public long Errcode { get; set; }

        /// <summary>
        /// errmsg
        /// </summary> 
        public string Errmsg { get; set; }

        /// <summary>
        /// extattr
        /// </summary> 
        public string Extattr { get; set; }

        /// <summary>
        /// hiredDate
        /// </summary> 
        public string HiredDate { get; set; }

        /// <summary>
        /// inviteMobile
        /// </summary> 
        public string InviteMobile { get; set; }

        /// <summary>
        /// isAdmin
        /// </summary> 
        public bool IsAdmin { get; set; }

        /// <summary>
        /// isBoss
        /// </summary> 
        public bool IsBoss { get; set; }

        /// <summary>
        /// isCustomizedPortal
        /// </summary> 
        public bool IsCustomizedPortal { get; set; }

        /// <summary>
        /// isHide
        /// </summary> 
        public bool IsHide { get; set; }

        /// <summary>
        /// isLeaderInDepts
        /// </summary> 
        public string IsLeaderInDepts { get; set; }

        /// <summary>
        /// isLimited
        /// </summary> 
        public bool IsLimited { get; set; }

        /// <summary>
        /// isSenior
        /// </summary> 
        public bool IsSenior { get; set; }

        /// <summary>
        /// jobnumber
        /// </summary> 
        public string Jobnumber { get; set; }

        /// <summary>
        /// managerUserId
        /// </summary> 
        public string ManagerUserId { get; set; }

        /// <summary>
        /// memberView
        /// </summary> 
        public bool MemberView { get; set; }

        /// <summary>
        /// mobile
        /// </summary> 
        public string Mobile { get; set; }

        /// <summary>
        /// mobileHash
        /// </summary> 
        public string MobileHash { get; set; }

        /// <summary>
        /// name
        /// </summary> 
        public string Name { get; set; }

        /// <summary>
        /// nickname
        /// </summary> 
        public string Nickname { get; set; }

        /// <summary>
        /// openId
        /// </summary> 
        public string OpenId { get; set; }

        /// <summary>
        /// orderInDepts
        /// </summary> 
        public string OrderInDepts { get; set; }

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
        /// roles
        /// </summary> 
        public List<RolesDomain> Roles { get; set; }

        /// <summary>
        /// stateCode
        /// </summary> 
        public string StateCode { get; set; }

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

        /// <summary>
        /// RolesDomain Data Structure.
        /// </summary>
        [Serializable]

        public class RolesDomain  
        {
            /// <summary>
            /// groupName
            /// </summary> 
            public string GroupName { get; set; }

            /// <summary>
            /// id
            /// </summary> 
            public long Id { get; set; }

            /// <summary>
            /// name
            /// </summary> 
            public string Name { get; set; }

            /// <summary>
            /// type
            /// </summary> 
            public long Type { get; set; }
        }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Model
{
   public class UserDetailInfo
    {
        public int errcode { get; set; }
        public string errmsg { get; set; }
        public string userid { get; set; }


        public string name { get; set; }
        public string tel { get; set; } 
        public string workPlace { get; set; }
        public string remark { get; set; }


        public string mobile { get; set; }
        public string email { get; set; }
        public bool active { get; set; }
       // public string orderInDepts { get; set; } 
        public bool isAdmin { get; set; }
        public bool isBoss { get; set; }
        public string dingId { get; set; }
        public string unionid { get; set; } 
        //public bool isLeaderInDepts { get; set; }
        public bool isHide { get; set; }
       // public string department { get; set; }
        public string position { get; set; }
        public string avatar { get; set; }
        public string jobnumber { get; set; }
        public string extattr { get; set; }
       
    }
}

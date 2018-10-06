using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain
{
    public class Other_User : Entity
    {
        public Other_User()
        {
            this.UserID = string.Empty;
            this.O_UserID = string.Empty;
            this.O_Name = string.Empty;
            this.Mobile = string.Empty;
            this.Gender = string.Empty;
            this.Email = string.Empty;
            this.O_Key1 = string.Empty;
            this.O_Key2 = string.Empty;
            this.Extattr = string.Empty;
            this.SyncMethod = string.Empty;
            this.SyncMsg = string.Empty;
            this.CreateTime =DateTime.MinValue;
            this.CrateId = string.Empty;
            this.TypeName = string.Empty;
        }

        public string UserID { get; set; }
        public string O_UserID { get; set; }
        public string O_Name { get; set; }
        public string Mobile { get; set; }
        public string Gender { get; set; }
        public string Email { get; set; }
        public string O_Key1 { get; set; }
        public string O_Key2 { get; set; }
        public string Extattr { get; set; }
        public string SyncMethod { get; set; }
        public string SyncMsg { get; set; }
        public DateTime CreateTime { get; set; }
        public string CrateId { get; set; }
        public string TypeName { get; set; }
    }
}

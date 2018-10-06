using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain
{
    public class Task : Entity
    {
        public Task() { 

        } 
        public DateTime CreateDate { get; set; }
        public string CreateUserId { get; set; }
        public string CreateUserName { get; set; }
        public string TaskName { get; set; }
        public string Remark { get; set; }
        public int TaskType { get; set; }
        public string DllName { get; set; }
        public string ClassName { get; set; }
        public string StoreName { get; set; }
        public string StoreParams { get; set; }
        //public string Expression { get; set; }
        public int Interval { get; set; }
        public string ReturnMsg { get; set; }
        public DateTime LastTaskTime { get; set; }
        public DateTime NextTaskTime { get; set; }
        public int TiggerType { get; set; }
        public int DataType { get; set; }
        public DateTime StartDateTime { get; set; }
        public DateTime? EndDateTime { get; set; }
        public int SuccessCount { get; set; }
        public int FailCount { get; set; }
        public decimal LastUseTime { get; set; }
        public  bool IsUse { get; set; }

    }
}

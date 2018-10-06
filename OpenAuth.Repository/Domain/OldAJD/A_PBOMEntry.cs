using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.OldAJD
{
    public class A_PBOMEntry : Entity
    {
        public A_PBOMEntry() { }

        public string PBOMId { get; set; } 
        public string  CrateId { get; set; }
        public string CreateName { get; set; }         //创建人 
        public DateTime CreateTime { get; set; }
        public decimal Qty { get; set; }
        public string SonItemNumberNo { get; set; }
        public string SonItemName { get; set; }
        public decimal PlanUsage { get; set; }
        public string BaseUnit { get; set; }
        public string Remark { get; set; }
        public bool IsOk { get; set; }
        public string A_PBOMId { get; set; }
        public string RecordId { get; set; }
        public decimal? ReveicedQty { get; set; }
    }
}

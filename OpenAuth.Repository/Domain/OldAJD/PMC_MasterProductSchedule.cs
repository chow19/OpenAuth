using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.OldAJD
{
    public class PMC_MasterProductSchedule : Entity
    {
        public PMC_MasterProductSchedule()
        {

        }   

        public string CrateId { get; set; }
        public DateTime CreateTime { get; set; }
        public int SEOrderEntry { get; set; }
        public string SEOrder { get; set; }
        public string FNumber { get; set; }
        public string FName { get; set; }
        public string CustomerName { get; set; }
        public string Saler { get; set; }
        public decimal AuxQty { get; set; }
        public DateTime? DealLine { get; set; }
        public bool IsOK { get; set; } 
        public DateTime? LastModifyTime { get; set; } //上次更新时间
        public int PetAuxQty { get; set; }
        public int GlassAuxQty { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.Kindee
{
    /// <summary>
    /// 工单信息
    /// </summary>
    public class ICMOInfo :Entity
    {
        public ICMOInfo() { }

        public int FInterID { get; set; }
        public string FBillNo { get; set; }
        public string CustomerName { get; set; }
        public string EmpName { get; set; }
        public decimal FAuxQty { get; set; }
        public string FNumber { get; set; }
        public string FName { get; set; }
        public DateTime? FAdviceConsignDate { get; set; }
        public int PetFAuxQty { get; set; }
        public int GlassFAuxQty { get; set; }
        public int FBomInterID { get; set; }
        public int MOFInterID { get; set; }
        public Int16 FStatus { get; set; }
        public int FEntryID { get; set; }
      
    }
}

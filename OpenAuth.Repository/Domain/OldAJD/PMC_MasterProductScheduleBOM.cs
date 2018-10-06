using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.OldAJD
{
    public class PMC_MasterProductScheduleBOM : Entity
    {
        public PMC_MasterProductScheduleBOM()
        {
            FId = string.Empty;
            CrateId = string.Empty;
            CreateTime = DateTime.Now;
        }
        public string FId { get; set; }
        public string CrateId { get; set; }
        public DateTime CreateTime { get; set; }
        public int FeedId { get; set; }
        public int FeedEntryId { get; set; }
        public int BOMId { get; set; }
        public string FNumber { get; set; }
        public string FName { get; set; }
        public decimal OweQty { get; set; }
        public string Remark { get; set; }
        public bool IsOK { get; set; }
        public DateTime? OKDate { get; set; }
        public decimal ReqQty { get; set; } //需求数量
        public decimal ReceivedQty { get; set; } //已领数量
        public int StockQty { get; set; } //及时库存
        public DateTime? LastModifyTime { get; set; }
        
    }

}

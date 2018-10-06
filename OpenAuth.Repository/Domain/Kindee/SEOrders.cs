using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.Kindee
{
    /// <summary>
    /// 销售订单列表
    /// </summary>
    public class SEOrders : Entity
    {
        public SEOrders() { }

        public string FBillNo { get; set; }
        public int FEntryID { get; set; }
        public string FNumber { get; set; }
        public string FName { get; set; }
        public string FModel { get; set; }
        public string CreatorName { get; set; }
        public DateTime FDate { get; set; }
        public string MakerName { get; set; }
        public DateTime? FCheckDate { get; set; }
        public string FVersionNo { get; set; }
        public string IsReview { get; set; }
    }

}

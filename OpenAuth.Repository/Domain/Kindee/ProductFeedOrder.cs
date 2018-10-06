using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.Kindee
{
    public  class ProductFeedOrder : Entity
    {
        public ProductFeedOrder() {

        } 
        public int SortNo { get; set; }
        public string FBillNo { get; set; }
        public int FEntryID { get; set; }
        public int FItemID { get; set; }
        public string FNumber { get; set; }
        public string FName { get; set; }
        public string pro_OutSourceOrder { get; set; }
        public string productFeed { get; set; }
        public DateTime FHeadSelfS0150 { get; set; }//整单交期
        public int FHeadSelfS0151 { get; set; }//整单数量
        //public decimal FQty { get; set; }
        public string FHeadSelfS0155 { get; set; }//合同编号
        public string FNote { get; set; }
        public string FatherItemNumberNo { get; set; }
        public string FatherItemName { get; set; }

        public string SonItemNumberNo { get; set; }
        public string SonItemName { get; set; }
        public string direction { get; set; }
        public int PlanUsage { get; set; }
        public string BaseUnit { get; set; }
        public decimal Usage { get; set; }

        public decimal BaseUnitUsage { get; set; }
        public decimal FScrap { get; set; }
        public string BOMOrderNo { get; set; }
        public string BOMIsReview { get; set; }
        public string BOMUsed { get; set; }
        public decimal FYield { get; set; }
        public int LevelNo { get; set; }
        public string LevelStr { get; set; }
        public string EndItemNumberNo { get; set; }
        public string ClientName { get; set; }
        public decimal RecordId { get; set; }
        public string Quality_Class { get; set; }
        public string Quality_Pet { get; set; }
        public string IsCheckOnPlace { get; set; }
	 
    }
}

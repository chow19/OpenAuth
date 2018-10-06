using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.Kindee
{
    public class ICMOBomInfo : Entity
    {
        public ICMOBomInfo()
        {
            Id = "";
        } 
        public int FInterID { get; set; }
        public decimal ReqQty { get; set; }
        public string FNumber { get; set; }
        public string FName { get; set; }
        public int BOMId { get; set; } 
        public decimal OweQty { get; set; }  
        public decimal ReceivedQty { get; set; }
        public int  StockQty { get; set; }
        public int  FeedId { get; set; }
        public int FeedEntryId { get; set; }
    }
}

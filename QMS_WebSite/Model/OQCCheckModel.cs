using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Model
{
    public class OQCCheckModel
    {
      public string OQCCheckId { get; set; }
        public DateTime CreateDate { get; set; }
        public string ResourceId { get; set; }
        public string UserId { get; set; }
        public string FactoryId { get; set; }
        public int QCResult { get; set; }
        public string XMLData { get; set; }
        public string InputSN { get; set; }
        public string Describe { get; set; }
        public string IsDone { get; set; }
        public string YBBQ { get; set; }
        public DateTime CheckDatetime { get; set; }
        public string IsPrint { get; set; }
        public string SEOutStockEntryId { get; set; }
    }
}
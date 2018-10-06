using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Model
{
    public class FQCCheckModel
    {
        public string FQCCheckId { get; set; }
        public string MOName { get; set; }
        public string ResourceId { get; set; }
        public string UserId { get; set; }
        public string FactoryId { get; set; }
        public DateTime CreateDate { get; set; }
        public string DefaultPath { get; set; }
        public string InputSN { get; set; }
        public string CheckLevel { get; set; }

        public string CheckStd { get; set; }

        public decimal DeliveryQty { get; set; } 
        public decimal NGQty { get; set; }
        public decimal AcceptQty { get; set; } 
        public string SpecimentId { get; set; }
        //检验类型1包装首检2包装巡检3FQC抽检 
        public int CheckType { get; set; }
        //1通过0不通过
        public int QCResult { get; set; }

        public string XMLData { get; set; }
        public string Describe { get; set; } 
 
    }
}
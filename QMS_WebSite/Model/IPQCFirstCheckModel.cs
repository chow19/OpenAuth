using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Model
{
    public class IPQCFirstCheckModel
    {
        public string IPQCFirstCheckId { get; set; }
        public string MFPlansId { get; set; } 
        public string SpecificationName { get; set; }
        public DateTime CreateDate { get; set; }
        public string ResourceId { get; set; }
        public string UserId { get; set; }
        public string FactoryId { get; set; }
        public int QCResult { get; set; }
        public string CheckType { get; set; } 
        public string XMLData { get; set; }
        public string InputSN { get; set; }
        public string Describe { get; set; }
        public int IsDone { get; set; }  
    }
}
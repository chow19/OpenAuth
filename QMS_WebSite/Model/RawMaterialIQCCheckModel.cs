using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Model
{
    public class RawMaterialIQCCheckModel
    {
        public string RawMaterialIQCCheckId { get; set; }
        public DateTime CreateDate { get; set; }
        public string FactoryId { get; set; }
        public string XMLData { get; set; }
        public int CheckResult { get; set; }
        public string SQCheckResultId { get; set; }
        public string SendQCReportId { get; set; }
        public int CheckNO { get; set; }
        public string ScanSN { get; set; }
        public decimal Qty { get; set; }
        public bool IsCheck { get; set; }

    }
}
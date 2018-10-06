using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite
{
    public class SOCheckResultModel
    {
        public string SendQCReportResultId { get; set; }
        public string SendQCReportId { get; set; }
        public string ResourceId { get; set; }
        public string UserId { get; set; }
        public string FactoryId { get; set; }
        public DateTime CreateDate { get; set; }
        public string DefaultPath { get; set; }


        //检验类型1玻璃2原材料3辅料
        public int CheckType { get; set; }
        //1通过0不通过
        public int CheckResult { get; set; }

        public string XMLData { get; set; }
        public string Describe { get; set; }
        public decimal NGQty { get; set; }
        public decimal AcceptQty { get; set; }
    }
}
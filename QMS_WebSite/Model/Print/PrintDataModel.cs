using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Model
{
    public class PrintDataModel
    {
        public string POName { get; set; }
        public string ProductShortName { get; set; }
        public string ProductDescribe { get; set; }
        public string CYFS { get; set; }
        public string CYSP { get; set; }
        public string AQL1 { get; set; }
        public string AQL2 { get; set; }
        public string SampleSize { get; set; }
        public string FSampleSize { get; set; }
        public string YBBQ { get; set; }
        public string Describe { get; set; }
        public DateTime SendDate { get; set; }
        public string ProductionDateCode { get; internal set; }
        public string SpecimentDescription { get; internal set; }
    }
}
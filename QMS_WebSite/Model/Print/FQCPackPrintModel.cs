using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMS_WebSite.Model
{
    public class FQCPackPrintModel
    {
        public string BillNo { get; set; }
        public string LineNo { get; set; }
        public string MOName { get; set; }
        public string ProductShortName { get; set; }
        public string ProductDescribe { get; set; }
        public string SteptName { get; set; }
        public string YBBQ { get; set; }
        public string PackType { get; set; }
    }
}
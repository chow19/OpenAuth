using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FunctionTest
{
    public class RowData
    {
        public string HeadId { get; set; }
        public string TestName { get; set; }
        public string TestResultValue { get; set; }
        public string TestStdValue { get; set; }
        public decimal UpLimit { get; set; }
        public decimal DownLimit { get; set; }
        public decimal Deviation { get; set; }
        public string TestResult { get; set; }
        public decimal OverValue { get; set; } 
    }

    public class HeaderData
    {
        public string Id { get; set; }
        public string ModuleName { get; set; }
        public DateTime TestDataTime { get; set; }
        public string MOName { get; set; }
        public string WorkStept { get; set; }
        public string CheckType { get; set; } 
        public string Timestamp { get; set; }
        public string FileName { get; set; }
        public string FilePath { get; set; }
    }
}

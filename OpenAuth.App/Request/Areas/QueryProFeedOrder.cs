using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.Request.Areas
{
    public class QueryProFeedOrder:PageReq
    {
        /// <summary>
        /// 销售订单
        /// </summary>
        public string BillNo { get; set; }

        /// <summary>
        /// 行号
        /// </summary>
        public string EntryID { get; set; }


    }
}

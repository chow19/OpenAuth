using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Message.Response
{
   public class MessageCorpconversationAsyncsendV2Response
    {
        /// <summary>
        /// errcode
        /// </summary> 
        public long Errcode { get; set; }

        /// <summary>
        /// errmsg
        /// </summary> 
        public string Errmsg { get; set; }

        /// <summary>
        /// 异步发送任务的id
        /// </summary> 
        public long TaskId { get; set; }
    }
}

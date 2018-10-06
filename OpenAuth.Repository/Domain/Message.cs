using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain
{
    /// <summary>
    /// 消息管理
    /// </summary>
    public class Message:Entity
    {
        public Message() {
            this.MsgType =-1;
            this.MsgTitle = string.Empty;
            this.MsgContent = string.Empty;
            this.FromId = string.Empty;
            this.IsRecieve = false;
            this.RecieveUsers = string.Empty; 
            this.IsAttach =false;
            this.AttachPath = string.Empty;
            this.FromName = string.Empty;
            this.ReturnMsg = string.Empty; 
        }
         
        public int MsgType { get; set; }
        public string MsgTitle { get; set; }
        public string MsgContent { get; set; }
        public string FromId { get; set; }
        public bool IsRecieve { get; set; }
        public string RecieveUsers { get; set; }
        public DateTime CreateTime { get; set; }
        public bool IsAttach { get; set; }
        public string AttachPath { get; set; }
        public string FromName { get; set; } 
        public String ReturnMsg { get; set; }

    }
}

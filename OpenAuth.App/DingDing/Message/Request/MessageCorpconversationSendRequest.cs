using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Message.Request
{
    //发送普通企业信息
    public class MessageCorpconversationSendRequest : DDBase<MessageCorpconversationSendRequest>
    {
        /// <summary>
        /// 消息体
        /// </summary>
        public TextDomain textMessage { get; set; }

        /// <summary>
        /// 消息体
        /// </summary>
        public ImageDomain imageMessage { get; set; }
         
        /// <summary>
        /// 消息体
        /// </summary>
        public LinkDomain linkMessage { get; set; }

        /// <summary>
        /// 消息体
        /// </summary>
        public ActionCardDomain actionMessage { get; set; }
        
        /// <summary>
        /// 消息类型
        /// </summary>
        public string MessageType { get; set; }
     
        /// <summary>
        /// 微应用agentId
        /// </summary>
        public Nullable<long> AgentId { get; set; }

        /// <summary>
        /// 消息接收者部门列表
        /// </summary>
        public string ToParty { get; set; }

        /// <summary>
        /// 消息接收者userid列表
        /// </summary>
        public string ToUser { get; set; }

        public override string GetParametersToJosn()
        {
            MyDictionary parameters = new MyDictionary();
            parameters.Add("touser", this.ToUser);
            parameters.Add("toparty", this.ToParty);
            parameters.Add("agentid", this.AgentId);
            parameters.Add("msgtype", this.MessageType.ToLower());
            parameters.Add("text", Newtonsoft.Json.JsonConvert.SerializeObject(this.textMessage) );
            parameters.Add("image", Newtonsoft.Json.JsonConvert.SerializeObject(this.imageMessage));
            parameters.Add("link", Newtonsoft.Json.JsonConvert.SerializeObject(this.linkMessage));
            parameters.Add("action_card", Newtonsoft.Json.JsonConvert.SerializeObject(this.actionMessage)); 
            return Newtonsoft.Json.JsonConvert.SerializeObject(parameters);
        }

        public override void Validate()
        {

        }
         
        /// <summary>
        /// TextDomain Data Structure.
        /// </summary>
        [Serializable]
        public class TextDomain
        {
            /// <summary>
            /// 文本消息
            /// </summary> 
            public string content { get; set; }
        }

        /// <summary>
        /// ImageDomain Data Structure.
        /// </summary>
        [Serializable]

        public class ImageDomain
        {
            /// <summary>
            /// 图片消息
            /// </summary> 
            public string MediaId { get; set; }
        }

        /// <summary>
        /// LinkDomain Data Structure.
        /// </summary>
        [Serializable]

        public class LinkDomain
        {
            /// <summary>
            /// messageUrl
            /// </summary> 
            public string MessageUrl { get; set; }

            /// <summary>
            /// picUrl
            /// </summary> 
            public string PicUrl { get; set; }

            /// <summary>
            /// text
            /// </summary> 
            public string Text { get; set; }

            /// <summary>
            /// title
            /// </summary> 
            public string Title { get; set; }
        }

        /// <summary>
        /// FileDomain Data Structure.
        /// </summary>
        [Serializable]
        public class FileDomain
        {
            /// <summary>
            /// media_id
            /// </summary> 
            public string MediaId { get; set; }
        }

        /// <summary>
        /// VoiceDomain Data Structure.
        /// </summary>
        [Serializable]

        public class VoiceDomain
        {
            /// <summary>
            /// duration
            /// </summary> 
            public string Duration { get; set; }

            /// <summary>
            /// media_id
            /// </summary> 
            public string MediaId { get; set; }
        }

        /// <summary>
        /// RichDomain Data Structure.
        /// </summary>
        [Serializable]

        public class RichDomain
        {
            /// <summary>
            /// num
            /// </summary> 
            public string Num { get; set; }

            /// <summary>
            /// unit
            /// </summary> 
            public string Unit { get; set; }
        }

        /// <summary>
        /// FormDomain Data Structure.
        /// </summary>
        [Serializable]

        public class FormDomain
        {
            /// <summary>
            /// key
            /// </summary> 
            public string Key { get; set; }

            /// <summary>
            /// value
            /// </summary> 
            public string Value { get; set; }
        }

        /// <summary>
        /// BodyDomain Data Structure.
        /// </summary>
        [Serializable]
        public class BodyDomain
        {
            /// <summary>
            /// author
            /// </summary> 
            public string Author { get; set; }

            /// <summary>
            /// content
            /// </summary> 
            public string Content { get; set; }

            /// <summary>
            /// file_count
            /// </summary> 
            public string FileCount { get; set; }

            /// <summary>
            /// form
            /// </summary> 
            public List<FormDomain> Form { get; set; }

            /// <summary>
            /// image
            /// </summary> 
            public string Image { get; set; }

            /// <summary>
            /// rich
            /// </summary> 
            public RichDomain Rich { get; set; }

            /// <summary>
            /// title
            /// </summary> 
            public string Title { get; set; }
        }

        /// <summary>
        /// HeadDomain Data Structure.
        /// </summary>
        [Serializable]

        public class HeadDomain
        {
            /// <summary>
            /// bgcolor
            /// </summary> 
            public string Bgcolor { get; set; }

            /// <summary>
            /// text
            /// </summary> 
            public string Text { get; set; }
        }

        /// <summary>
        /// OADomain Data Structure.
        /// </summary>
        [Serializable]

        public class OADomain
        {
            /// <summary>
            /// body
            /// </summary> 
            public BodyDomain Body { get; set; }

            /// <summary>
            /// head
            /// </summary> 
            public HeadDomain Head { get; set; }

            /// <summary>
            /// message_url
            /// </summary> 
            public string MessageUrl { get; set; }

            /// <summary>
            /// pc_message_url
            /// </summary> 
            public string PcMessageUrl { get; set; }
        }

        /// <summary>
        /// MarkdownDomain Data Structure.
        /// </summary>
        [Serializable]

        public class MarkdownDomain
        {
            /// <summary>
            /// text
            /// </summary> 
            public string Text { get; set; }

            /// <summary>
            /// title
            /// </summary> 
            public string Title { get; set; }
        }

        /// <summary>
        /// BtnJsonListDomain Data Structure.
        /// </summary>
        [Serializable]

        public class BtnJsonListDomain
        {
            /// <summary>
            /// action_url
            /// </summary> 
            public string ActionUrl { get; set; }

            /// <summary>
            /// title
            /// </summary> 
            public string Title { get; set; }
        }

        /// <summary>
        /// ActionCardDomain Data Structure.
        /// </summary>
        [Serializable]

        public class ActionCardDomain
        {
            /// <summary>
            /// btn_json_list
            /// </summary> 
            public List<BtnJsonListDomain> BtnJsonList { get; set; }

            /// <summary>
            /// btn_orientation
            /// </summary> 
            public string BtnOrientation { get; set; }

            /// <summary>
            /// markdown
            /// </summary> 
            public string Markdown { get; set; }

            /// <summary>
            /// single_title
            /// </summary> 
            public string SingleTitle { get; set; }

            /// <summary>
            /// single_url
            /// </summary> 
            public string SingleUrl { get; set; }

            /// <summary>
            /// title
            /// </summary> 
            public string Title { get; set; }
        }

        /// <summary>
        /// MsgDomain Data Structure.
        /// </summary>

        public enum MessageTypeDomain
        {
            ActionCard=1,
            File=2,
            Image=3,

            /// <summary>
            /// 链接消息
            /// </summary> 
            Link=4,

            /// <summary>
            /// markdown
            /// </summary> 
            Markdown=5,


            /// <summary>
            /// oa
            /// </summary> 
            Oa=6,

            /// <summary>
            /// 文本消息
            /// </summary> 
            Text=7,

            /// <summary>
            /// 语音消息
            /// </summary> 
            Voice=8,

        }

 
    }
}

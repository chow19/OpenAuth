using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Message.Request
{
    public class MessageCorpconversationAsyncsendV2Request : DDBase<MessageCorpconversationAsyncsendV2Request>
    {
        /// <summary>
        /// 微应用的id
        /// </summary>
        public Nullable<long> AgentId { get; set; }

        /// <summary>
        /// 接收者的部门id列表
        /// </summary>
        public string DeptIdList { get; set; }

        /// <summary>
        /// 消息体，具体见文档
        /// </summary>
        public MsgDomain Msg { get; set; }
         
        /// <summary>
        /// 是否发送给企业全部用户
        /// </summary>
        public Nullable<bool> ToAllUser { get; set; }

        /// <summary>
        /// 接收者的用户userid列表
        /// </summary>
        public string UseridList { get; set; }

        public override string GetParametersToJosn()
        {
            MyDictionary parameters = new MyDictionary();
            parameters.Add("agent_id", this.AgentId);
            parameters.Add("dept_id_list", this.DeptIdList);
          
            parameters.Add("to_all_user", this.ToAllUser);
            parameters.Add("userid_list", this.UseridList);
            parameters.Add("msg", Newtonsoft.Json.JsonConvert.SerializeObject(this.Msg));
            return Newtonsoft.Json.JsonConvert.SerializeObject(parameters).Replace("\"msg\":\"{", "\"msg\":{").Replace("}\"}","}}").Replace("\\\"","\"");
        }

        public override void Validate()
        {
            throw new NotImplementedException();
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

        public class ImageDomain { 
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

        public class VoiceDomain { 
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

        public class FormDomain { 
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
        [Serializable] 
        public class MsgDomain  
        {
            /// <summary>
            /// action_card
            /// </summary> 
            public ActionCardDomain ActionCard { get; set; }

            /// <summary>
            /// file
            /// </summary> 
            public FileDomain File { get; set; }

            /// <summary>
            /// 图片消息
            /// </summary> 
            public ImageDomain Image { get; set; }

            /// <summary>
            /// 链接消息
            /// </summary> 
            public LinkDomain Link { get; set; }

            /// <summary>
            /// markdown
            /// </summary> 
            public MarkdownDomain Markdown { get; set; }

            /// <summary>
            /// 消息类型
            /// </summary> 
            public string msgtype { get; set; }

            /// <summary>
            /// oa
            /// </summary> 
            public OADomain Oa { get; set; }

            /// <summary>
            /// 文本消息
            /// </summary> 
            public TextDomain text { get; set; }

            /// <summary>
            /// 语音消息
            /// </summary> 
            public VoiceDomain Voice { get; set; }

 }

    }
}

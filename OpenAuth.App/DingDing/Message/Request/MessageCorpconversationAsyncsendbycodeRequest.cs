using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks; 

namespace OpenAuth.App.DingDing.Message.Request
{
    public class MessageCorpconversationAsyncsendbycodeRequest : DDBase<MessageCorpconversationAsyncsendbycodeRequest>
    {
        /// <summary>
        /// 微应用的id
        /// </summary>
        public Nullable<long> AgentId { get; set; }

        /// <summary>
        /// 用户操作产生的授权码
        /// </summary>
        public string Code { get; set; }

        /// <summary>
        /// 接收者的部门id列表
        /// </summary>
        public string DeptIdList { get; set; }

        /// <summary>
        /// 与msgtype对应的消息体，具体见文档
        /// </summary>
        public string Msgcontent { get; set; }

        /// <summary>
        /// 消息类型,如text、file、oa等，具体见文档
        /// </summary>
        public string Msgtype { get; set; }

        /// <summary>
        /// 是否发送给企业全部用户
        /// </summary>
        public Nullable<bool> ToAllUser { get; set; }

        /// <summary>
        /// 接收者的用户userid列表
        /// </summary>
        public string UserIdList { get; set; } 

        public override string GetParametersToJosn()
        {
            MyDictionary parameters = new MyDictionary();
            parameters.Add("agent_id", this.AgentId);
            parameters.Add("code", this.Code);
            parameters.Add("dept_id_list", this.DeptIdList);
            parameters.Add("msgcontent", this.Msgcontent);
            parameters.Add("msgtype", this.Msgtype);
            parameters.Add("to_all_user", this.ToAllUser);
            parameters.Add("user_id_list", this.UserIdList);
            return Newtonsoft.Json.JsonConvert.SerializeObject(parameters);
        }

        public override void Validate()
        {
            
        }
    }
}

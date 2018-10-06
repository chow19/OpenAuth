using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App
{
    public class MessageApp : BaseApp<Repository.Domain.Message>
    {
        //创建消息
        public void Create(Repository.Domain.Message Model)
        {
            if (string.IsNullOrEmpty(Model.Id))
            {
                Model.Id = Guid.NewGuid().ToString();
                Model.CreateTime = DateTime.Now;
            }
            Repository.Add(Model);
        }
         
        //更新消息已读
        public void UpdateToRecevice(string[] ids)
        {
            var ms = UnitWork.Find<Repository.Domain.Message>(t => ids.Contains(t.Id));
            foreach (var item in ms)
            {
                if (item.IsRecieve == true) continue;
                if (string.IsNullOrEmpty(item.Id))
                {
                    throw new Exception("数据错误");
                }
                item.IsRecieve = true;
                UnitWork.Update(item);
            }
            UnitWork.Save();
        }
        public void UpdateToReceviceErrMsg(string  id,string errMsg)
        {
            var ms = Repository.FindSingle(t => id.Equals(t.Id));
            if (ms==null)
            {
                throw new Exception("数据错误");
            }
            if (ms.IsRecieve == true)
            {
                throw new Exception("数据错误");
            }
            ms.ReturnMsg = errMsg;
            Repository.Update(ms);
        }

        /// <summary>
        /// 根据用户Id获取消息列表
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        public Response.TableData GetMessageByUserId(Request.PageReq PageReq, string UserId)
        { 
            var Messages = Repository.Find(t => t.RecieveUsers.Contains(UserId)).OrderByDescending(t => t.CreateTime).Skip((PageReq.page - 1) * PageReq.limit).Take(PageReq.limit);

            return new Response.TableData
            {
                count = Messages.Count(),
                data = Messages
            };
        }

        /// <summary>
        /// 钉钉消息发送数据获取 是否已读
        /// </summary> 
        /// <returns></returns>
        public List<Repository.Domain.Message> GetMessageToSend(bool IsReceive = false)
        {
            return Repository.Find(t => t.IsRecieve == false).ToList();
        }
    }
}

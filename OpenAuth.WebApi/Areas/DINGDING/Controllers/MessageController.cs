using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Infrastructure;

namespace OpenAuth.WebApi.Areas.DINGDING.Controllers
{
    /// <summary>
    /// 钉钉消息
    /// </summary>
    public class MessageController : ApiCommonController
    {
        public App.MessageApp messageApp { get; set; }
        public App.DingDing.DingDingService DingDingService { get; set; }

        [System.Web.Mvc.HttpPost]
        public Response<bool> SendMessage()
        {
            var result = new Response<bool>();
            try
            {
                //获取所有数据未发送成功数据
                var messages = messageApp.GetMessageToSend();
                foreach (var item in messages)
                {
                    DingDingService.SendMsg(item);
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        [System.Web.Mvc.HttpPost]
        public Response<bool> SendAsynMessage()
        {
            var result = new Response<bool>();
            try
            {
                //获取所有数据未发送成功数据
                var messages = messageApp.GetMessageToSend();
                foreach (var item in messages)
                {
                    DingDingService.SendAsynMsg(item);
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }
        
    }
}
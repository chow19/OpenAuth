using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.Message.Controllers
{
    public class MessageController : Mvc.Controllers.BaseController
    {
        public App.MessageApp message { get; set; }
        // GET: Message/Message
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 获取信息列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        public string GetMessageList([System.Web.Http.FromUri]App.Request.PageReq request) { 
            var messages= message.GetMessageByUserId(request, userCurrent.User.Id);
            return Infrastructure.JsonHelper.Instance.Serialize(messages);
        }

        [HttpPost]
        public string UpdateToRecevice(string[]  Ids) {
            try
            {
                message.UpdateToRecevice(Ids);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return Infrastructure.JsonHelper.Instance.Serialize(Result); 
        }

    }
}
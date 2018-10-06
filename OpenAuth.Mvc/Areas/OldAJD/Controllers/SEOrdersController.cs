using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.OldAJD.Controllers
{
    public class SEOrdersController : Controller
    {
        public App.OldAJD.SEOrderApp app { get; set; }
         
        // GET: OldAJD/SEOrders
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
        [OutputCache(Duration = 3)]
        public string GetSeOrderList([System.Web.Http.FromUri]App.Request.PageReq request)
        {  
            var orders = app.GetSEOrders(request);
            return Infrastructure.JsonHelper.Instance.Serialize(orders);
        }
    }
}
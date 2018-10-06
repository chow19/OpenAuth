using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.OldAJD.Controllers
{
    public class ProductFeedOrderController : Mvc.Controllers.BaseController
    {
        public App.OldAJD.ProductFeedOrderApp app { get; set; }
        public App.OldAJD.A_PBOMApp bomapp { get; set; }
        // GET: OldAJD/ProductFeedOrder
        public ActionResult Index()
        {
            return View();
        }
         
        [OutputCache(Duration = 10)]
        public string GetProFeedData([System.Web.Http.FromUri]App.Request.Areas.QueryProFeedOrder req)
        {
            var ProFeedData = app.GetProFeedData(req);
            return Infrastructure.JsonHelper.Instance.Serialize(ProFeedData);
        }


         
    }
}
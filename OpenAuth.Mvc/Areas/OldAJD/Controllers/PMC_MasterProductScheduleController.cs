using OpenAuth.App.OldAJD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.OldAJD.Controllers
{
    public class PMC_MasterProductScheduleController : Mvc.Controllers.BaseController
    {
        public PMC_MasterProductScheduleApp app { get; set; }
        public PMC_MasterProductScheduleBOMApp appBom { get; set; }

        // GET: OldAJD/PMC_MasterProductSchedule
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
        [OutputCache(Duration = 2)]
        public string GetPMC_MasterProductScheduleList([System.Web.Http.FromUri]App.Request.PageReq request,int IsOk=0)
        {
            var orders = app.GetMasterProductScheduleData(request, IsOk==1?false:true);
            return Infrastructure.JsonHelper.Instance.Serialize(orders);
        }

        /// <summary>
        /// 获取信息列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet]
        [OutputCache(Duration = 2)]
        public string GetPMC_MasterProductScheduleBomList(string MId)
        {
            var lines = appBom.GetSEOderBomDataByMId(MId);
            return Infrastructure.JsonHelper.Instance.Serialize(lines);
        }

        /// <summary>
        /// 手工更新数据
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpPost] 
        public string StrongeSync(string Id)
        {
            try
            {
                app.AutoAdd();
                Result.Message = "同步数据成功";
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            
            return Infrastructure.JsonHelper.Instance.Serialize(Result);
        }


        /// <summary>
        /// 获取信息列表
        /// </summary>
        /// <param name="request"></param>
        /// <returns></returns>
        [HttpGet] 
        public string GetPMC_OweTotal(string FNumber)
        {
            var lines = app.GetOweQtyByFNumber(FNumber);
            return Infrastructure.JsonHelper.Instance.Serialize(lines);
        }
        
    }
}
using OpenAuth.App.OldAJD;
using OpenAuth.Mvc.Controllers;
using OpenAuth.Repository.Domain.AJD;
using OpenAuth.Repository.Domain.OLDAJD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.OldAJD.Controllers
{
    public class PBOMController : BaseController
    {
        public A_PBOMApp app { get; set; }
        public A_PBOMEntryApp A_PBOMEntryApp { get; set; }
        // GET: OldAJD/PBOM
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public string GetLeftPBOMData([System.Web.Http.FromUri]App.Request.PageReq req)
        {
            try
            {
                var ProFeedData = app.LeftLoad(req);
                return Infrastructure.JsonHelper.Instance.Serialize(ProFeedData);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = "";
            }
            return Infrastructure.JsonHelper.Instance.Serialize(Result);
        }

        [HttpGet]
        public string GetRightPBOMData(string PBOMId)
        {
            var ProFeedData = A_PBOMEntryApp.GetEntryByHeadId(PBOMId);
            return Infrastructure.JsonHelper.Instance.Serialize(ProFeedData);
        }
        /// <summary>
        /// 下达命令
        /// </summary>
        /// <param name="FBillNo"></param>
        /// <param name="Entry"></param>
        /// <returns></returns>
        [HttpPost]
        public string SendBom(string BillNo, string FEntryID)
        {
            try
            {
                app.Add(BillNo, FEntryID);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return Infrastructure.JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 更新行数据
        /// </summary>
        /// <param name="field"></param>
        /// <param name="Id"></param>
        /// <returns></returns>
        [HttpPost]
        public string UpdateLine(string field,string Id,string value) {
            try
            { 
                if (field == "ReveicedQty")
                {
                    A_PBOMEntryApp.UpdateIsOk(Id,Convert.ToDecimal(value));
                } else if (field == "Remark") {
                    A_PBOMEntryApp.UpdateRemark(Id, value);
                }
              
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return Infrastructure.JsonHelper.Instance.Serialize(Result);
        }

        
        [HttpPost]
        public string Update(A_PBOM pbom) {
            try
            {
                app.Update(pbom);
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
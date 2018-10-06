using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class JobController : BaseController
    {
        public TaskApp TaskApp { get; set; }
        // GET: Job
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public string Add(Task entity ) {
            try
            {
                entity.CreateDate = DateTime.Now;
                entity.CreateUserId = userCurrent.User.Id;
                entity.CreateUserName = userCurrent.User.Name;
                entity.LastTaskTime = DateTime.MinValue;
                
                TaskApp.Add(entity);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        [HttpPost]
        public string Update(Task entity)
        {
            try
            {
                TaskApp.Update(entity);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        [HttpPost]
        public string Delete(string[]  ids) { 
            try
            {
                TaskApp.Delete(ids);
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }
         
        [HttpGet]
        public string GetTaskDataTable(PageReq req) { 
            return JsonHelper.Instance.Serialize(TaskApp.Load(req));
        }

        [HttpGet]
        public string GetTaskData(string id)
        {
            return JsonHelper.Instance.Serialize(TaskApp.Get(id));
        }
    }
}
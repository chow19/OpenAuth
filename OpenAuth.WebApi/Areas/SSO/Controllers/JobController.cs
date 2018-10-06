using Infrastructure;
using Infrastructure.Cache;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace OpenAuth.WebApi.Areas.SSO.Controllers
{
    public class JobController : ApiController
    {
        /// <summary>
        /// Job 执行入口
        /// </summary>
        /// <param name="token">The token.</param> 
        [System.Web.Mvc.HttpGet]
        public Response<bool> Index()
        {
            var result = new Response<bool>();
            try
            {
  
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
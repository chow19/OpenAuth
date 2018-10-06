using System;
using System.Net;
using System.Text;
using System.Web.Mvc;

namespace OpenAuth.WebApi.App_Start.Atrribute
{
    /// <summary>
    /// 
    /// </summary>
    public class ResponActionAttribute : ActionFilterAttribute
    {
        /// <summary>
        /// 执行Action之后操作
        /// </summary>
        /// <param name="filterContext"></param>
        //public override void OnActionExecuted(ActionExecutedContext filterContext)
        //{
        //    //3.返回文本执行
        //    var contentResult = new ContentResult
        //    {

        //    };
        //    contentResult.ContentType = "text/html";

        //    filterContext.Result = contentResult;
        //    base.OnActionExecuted(filterContext);
        //}
    }
}
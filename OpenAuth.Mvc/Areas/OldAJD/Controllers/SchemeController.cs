using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.OldAJD.Controllers
{
    public class SchemeController : Mvc.Controllers.BaseController
    {
        public App.OldAJD.SchemeApp app {get;set;}
        // GET: OldAJD/Scheme
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [OutputCache(Duration = 2)]
        public string GetScheme(string schemeid)
        {
            var ProFeedData = app.GetSchemeByScheme(schemeid); 
            return Infrastructure.JsonHelper.Instance.Serialize(ProFeedData);
        }
        [HttpPost]
        public string Add(Repository.Domain.Kindee.Scheme Scheme) {
            return Infrastructure.JsonHelper.Instance.Serialize(Result);
        }

        [HttpPost]
        public string Update(Repository.Domain.Kindee.Scheme Scheme) {
            return Infrastructure.JsonHelper.Instance.Serialize(Result);
        }
        [HttpPost]
        public string uploadFile()
        {
            try
            {
                var FiledataList = System.Web.HttpContext.Current.Request.Files;
                if (FiledataList.Count <= 0)
                {
                    Result.Code = 500;
                    Result.Message = "参数错误";
                    return Infrastructure.JsonHelper.Instance.Serialize(Result);
                }
                var Filedata = FiledataList[0];
                //没有文件上传，直接返回
                if (Filedata == null || string.IsNullOrEmpty(Filedata.FileName) || Filedata.ContentLength == 0)
                {
                    Result.Code = 500;
                    Result.Message = "参数错误";
                    return Infrastructure.JsonHelper.Instance.Serialize(Result);
                }


                long filesize = Filedata.ContentLength;
                if (filesize>1024*1024*20)
                {
                    Result.Code = 500;
                    Result.Message = "文件最大只能为10M";
                    return Infrastructure.JsonHelper.Instance.Serialize(Result);
                }
                
                string FileEextension = Filedata.FileName.Substring(Filedata.FileName.IndexOf("."), Filedata.FileName.Length- Filedata.FileName.IndexOf("."));
                if (FileEextension.ToUpper()!=".JPG"&& FileEextension.ToUpper() != ".PNG"&& FileEextension.ToUpper() != ".GIF")
                {
                    Result.Code = 500;
                    Result.Message = "文件类型只能为JPG,PNG,GIF";
                    return Infrastructure.JsonHelper.Instance.Serialize(Result);
                }
                string fileName = DateTime.Now.ToString("yyyMMddHHmmss") + DateTime.Now.Millisecond;
                string virtualPath = string.Format("~/uploadfiles/oldajdimgs/{0}{1}", fileName, FileEextension);
                string fullFileName = this.Server.MapPath(virtualPath);
                Filedata.SaveAs(fullFileName);

                Result.Code = 200;
                Result.Message = fileName+FileEextension;
  
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
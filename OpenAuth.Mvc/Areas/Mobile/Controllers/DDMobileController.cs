using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.DingDing;
using OpenAuth.App.SSO;
using OpenAuth.Mvc.Controllers;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.Mobile.Controllers
{
    public class DDMobileController : BaseController
    {
        private string _appKey = ConfigurationManager.AppSettings["SSOAppKey"];
        public DingDingService DingDingService { get; set; }
        public UserManagerApp userManage { get; set; }
        public Other_UserManageApp ouserManage { get; set; }
        //
        // GET: /DD/
        //public ActionResult GetUserInfo(string accessToken, string code, bool setCurrentUser = true)
        //{
        //    try
        //    {
        //        string userId = DingDingService.Instance.GetUserId(accessToken, code);
        //        string jsonString = DingDingService.Instance.GetUserDetailJson(accessToken, userId);
        //        UserDetailInfo userInfo = DingDingService.Instance.GetUserDetailFromJson(jsonString);
        //        if (setCurrentUser)
        //        {
        //            Session["AccessToken"] = accessToken;
        //            Session["CurrentUser"] = userInfo;
        //        }
        //        return Content(jsonString);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Content(string.Format("{{'errcode': -1, 'errmsg':'{0}'}}", ex.Message));
        //    }
        //}


        // GET: /UserManager/
        public ActionResult Index()
        {
            ViewBag.userName = userCurrent.User.Name; 
            return View();
        }

    }
}
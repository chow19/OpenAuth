using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.DingDing;
using OpenAuth.App.DingDing.Model;
using OpenAuth.App.SSO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class DingDingController : Controller
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
            string nonceStr = "HELLOWORK";//todo:随机
            ViewBag.NonceStr = nonceStr;
            string accessToken = DingDingService.GetAccessToken();
            ViewBag.AccessToken = accessToken;
            string ticket = DingDingService.GetJsApiTicket(accessToken);
            long timeStamp = DDHelper.GetTimeStamp();
            string url = Request.Url.ToString();
            string signature = DingDingService.GetSign(ticket, nonceStr, timeStamp, url);

            ViewBag.JsApiTicket = ticket;
            ViewBag.Signature = signature;
            ViewBag.NonceStr = nonceStr;
            ViewBag.TimeStamp = timeStamp;
            ViewBag.CorpId = DDHelper.GetCorpId();
            ViewBag.CorpSecret = DDHelper.CorpSecret();
            ViewBag.AgentId = DDHelper.GetAgentId();
            return View();
        }

        public string GetSpecToken(string uid)
        {
            var response = new Response();
            try
            {
              
                var ouser = ouserManage.Repository.Find(t => t.O_UserID.Equals(uid)).FirstOrDefault();
                if (ouser == null)
                {
                    response.Code = 500;
                    response.Message = "钉钉用户不存在";
                    return Infrastructure.Json.ToJson(response);
                }
                var user = userManage.Get(ouser.UserID);

                var result = AuthUtil.Login(_appKey, user.Name,user.Password);
                if (result.Code == 200)
                {
                    var cookie = new HttpCookie("Token", result.Token)
                    {
                        Expires = DateTime.Now.AddDays(10)
                    };
                    Response.Cookies.Add(cookie);
                }
                else
                {
                    response.Code = 500;
                    response.Message = result.Message;
                }
            }
            catch (Exception ex)
            {
                response.Code = 500;
                response.Message = "错误："+ex.Message;
                return Infrastructure.Json.ToJson(response);
            }
            return Infrastructure.Json.ToJson(response);
        }
    }
}
using System;
using System.Collections.Generic;
using System.Web.Http;
using System.Web.Mvc;
using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Mvc.Models;
using OpenAuth.App.SSO;

namespace OpenAuth.Mvc.Controllers
{
    public class UserManagerController : BaseController
    {
        public UserManagerApp App { get; set; }
        public Other_UserManageApp OApp { get; set; }
        //
        // GET: /UserManager/
        [Authenticate]
        public ActionResult Index()
        {
            return View();
        }

        //添加或修改组织
        [System.Web.Mvc.HttpPost]
        public string AddOrUpdate(UserView view)
        {
            try
            {
                App.AddOrUpdate(view);

            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 加载组织下面的所有用户
        /// </summary>
        public string Load([FromUri]QueryUserListReq request)
        {
            return JsonHelper.Instance.Serialize(App.Load(request));
        }

        [System.Web.Mvc.HttpPost]
        public string Delete(string[] ids)
        {
            try
            {
                App.Delete(ids);
                foreach (var item in ids)
                {
                    OApp.SetDelStatus(item);
                }
               
            }
            catch (Exception e)
            {
                Result.Code = 500;
                Result.Message = e.Message;
            }

            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 根据部门ID获取用户数据
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public string SyncToDDUser(string id) {
            var response = new Response();
            try
            {
                response= DDUserSync.SyncDDUser(id);
                if (response.Code == 200)
                {
                    Result.Code = 200;
                    Result.Message = response.Message;
                }
                else {
                    Result.Code = 500;
                    Result.Message = response.Message;
                }
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
            return JsonHelper.Instance.Serialize(Result);
        }

        /// <summary>
        /// 将Otheruser数据同步到钉钉
        /// </summary>
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public string OtherUserSyncToDDUser() {
            var response = new Response();
            try
            {
                response = DDUserSync.SyncDDUserFromOtherUser(); 
                if (response.Code == 200)
                {
                    Result.Code = 200;
                    Result.Message = response.Message;
                }
                else
                {
                    Result.Code = 500;
                    Result.Message = response.Message;
                }
            }
            catch (Exception ex)
            {
                Result.Code = 500;
                Result.Message = ex.Message;
            }
          return  JsonHelper.Instance.Serialize(Result);
        }

        #region 获取权限数据

        /// <summary>
        /// 获取用户可访问的账号 
        /// </summary>
        public string GetAccessedUsers()
        {
            IEnumerable<UserView> users = App.Load(new QueryUserListReq()).data;
            var result = new Dictionary<string, object>();
            foreach (var user in users)
            {
                var item = new
                {
                    Account = user.Account,
                    RealName = user.Name,
                    id = user.Id,
                    text = user.Name,
                    value = user.Account,
                    parentId = "0",
                    showcheck = true,
                    img = "fa fa-user",
                };
                result.Add(user.Id, item);
            }

            return JsonHelper.Instance.Serialize(result);
        }
        #endregion
    }
}
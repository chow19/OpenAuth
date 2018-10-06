using Infrastructure;
using OpenAuth.App;
using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenAuth.WebApi.Areas.Kindee.Controllers
{
    public class KindeeSyncController : System.Web.Http.ApiController
    {
        public OpenAuth.App.Kindee.UserApp kindeeapp { get; set; }
        public Other_UserManageApp Other_Userapp { get; set; }
        //用户 同步
        public Response<bool> SyncKindeeUser()
        {
            var response = new Response<bool>();
            //查询所有Other_User没有在金蝶的用户
            var userList = kindeeapp.GetAllUserFromKindee();
            var ouserList = Other_Userapp.GetUserListByType("1");
            var users = from a in userList
                        where ouserList.Select(t => t.O_Name).Contains(a.FDescription)
                        select a;
            int scount = 0;
            int failcount = 0;
            //直接插入  ouser
            foreach (var item in users)
            {
                try
                {
                    var ouer = new Other_User();
                    ouer.CreateTime = DateTime.Now;
                    ouer.O_UserID = item.FUserID.ToString();
                    ouer.O_Name = item.FDescription;
                    ouer.TypeName = "2";
                    ouer.UserID= ouserList.Where(t => t.O_Name.Equals(item.FDescription) && t.TypeName == "1").FirstOrDefault().UserID;
                    //if (Other_Userapp.Repository.Find(t => t.O_Name.Equals(item.FDescription) && t.TypeName == "1").Count() > 0)
                    //{

                    //}
                    Other_Userapp.Add(ouer);
                    scount++;
                }
                catch (Exception)
                {
                    failcount++;
                }
              
            }
            response.Message = "成功次数"+scount+";失败次数"+failcount;
            return response;
        }


    }
}
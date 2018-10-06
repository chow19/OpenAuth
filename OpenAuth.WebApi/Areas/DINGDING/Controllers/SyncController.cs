using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.DingDing;
using OpenAuth.App.DingDing.Dept.Request;
using OpenAuth.App.DingDing.Dept.Respon;
using OpenAuth.App.DingDing.User.Request;
using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace OpenAuth.WebApi.Areas.DINGDING.Controllers
{

    /// <summary>
    /// 数据同步入口
    /// </summary>
    public class SyncController : ApiController
    {
        public OrgManagerApp OrgApp { get; set; }
        public UserManagerApp UserApp { get; set; }
        public Other_UserManageApp OtherUserApp { get; set; }
        public DingDingService DingDingService { get; set; }

        /// <summary>
        /// 初始化数据 ，第一次使用后停用
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Response<bool> SyncUserIni()
        {
            return null;
            var response = new Response<bool>();
            //1、循环组织
            var orgs = OrgApp.Repository.Find(t => t.IsDeleted == false);
            foreach (var item in orgs)
            {
                //2、获取组织下用户信息
                var res = new GetUserListRequest();
                res.DepartmentId = Ext.ToLong(item.DD_Id);
                var resuser = DingDingService.GetUserList(res);
                foreach (var itemuser in resuser.Userlist)
                {

                    OtherUserApp.update(itemuser.Mobile, itemuser.Email, itemuser.Name, itemuser.Userid);
                }
            }


            return response;
        }

        /// <summary>
        /// 同步所有用户数据
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Response<bool> SyncUserAuto()
        {
            var response = new Response<bool>();
            var ouserList = OtherUserApp.GetUserListByType("1").Where(t => t.SyncMethod.IsEmpty() == false);
            int SuccessCount = 0;
            int FailCount = 0;

            foreach (var item in ouserList)
            {
                try
                {
                    var deptid = OrgApp.GetOrgByUserId(item.UserID).DD_Id;
                    long[] deptidids = { Ext.ToLong(deptid) };
                    if (item.SyncMethod == "add")
                    {
                        CreateUserRequest model = new CreateUserRequest();
                        model.Department = deptidids.ToJson();
                        model.Email = item.Email;
                        model.Mobile = item.Mobile;
                        model.Name = item.O_Name;
                        model.Remark = "-";
                        model.Userid = item.UserID;
                        DingDingService.CreateUser(model);
                    }
                    else if (item.SyncMethod == "update")
                    {
                        //获取实体通过uid
                        var user = DingDingService.GetUser(new GetUserRequest { Userid = item.O_UserID });
                        UpdateUserRequest model = new UpdateUserRequest();
                        Int64 d = Ext.ToLong(deptid);
                        List<long> DepartmentIds = new List<long>();
                        DepartmentIds.Add(d);

                        model.Department = DepartmentIds;
                        model.Email = user.Email;
                        model.Extattr = user.Extattr;
                        model.IsHide = user.IsHide;
                        model.IsSenior = user.IsSenior;
                        model.Jobnumber = user.Jobnumber;
                        model.ManagerUserid = user.ManagerUserId;
                        model.Mobile = user.Mobile;
                        model.Name = user.Name;
                        model.OrderInDepts = user.OrderInDepts;
                        model.OrgEmail = user.OrgEmail;
                        model.Position = user.Position;
                        model.Remark = user.Remark;
                        model.Tel = user.Tel;
                        model.Userid = user.Userid;
                        model.WorkPlace = user.WorkPlace;
                        DingDingService.UpdateUser(model);
                    }
                    else if (item.SyncMethod == "del")
                    {
                        DingDingService.DelUser(new UserDeleteRequest { Userid = item.O_UserID });
                    }
                    SuccessCount++;
                }
                catch (Exception)
                {
                    FailCount++;
                }

            }
            response.Message = "成功" + SuccessCount + "条;失败" + FailCount + "条; ";
            return response;
        }

        /// <summary>
        /// 根据组织Id以及下级组织写入同步数据到O_UserId
        /// </summary>
        /// <param name="OID">平台Id</param>
        /// <returns></returns>
        [HttpPost]
        public Response<bool> InsertSyncDataToUserByOid(string OID)
        {
            var response = new Response<bool>();

            //var org = OrgApp.Get(OID);
            //if (org == null)
            //{
            //    response.Code = -1;
            //    response.Message = "方法InsertSyncDataToUserByOid：找不到组织";
            //}
            int CountSuccess = 0;
            int CountFail = 0;
            var orgs = OrgApp.GetOrgAndChilds(OID);
            if (orgs == null)
            {
                response.Code = 200;
                response.Message = "成功0条;失败0条";
                return response;
            }
            foreach (var item in orgs)
            {
                //1、检验该组织是否有同步需要，如果有则先同步 
                if (item.DD_SyncEnabled == true)
                {
                    if (SyncOrgHandler(item) == false) continue;
                }
                //2.1 获取组织ID下面所有员工
                var users = UserApp.GetUserListByOrgId(item.Id);
                var otheruser = OtherUserApp.GetUserListByType("1").Select(t => t.UserID).ToArray();
                //2.2 获取otheruser没有的数据
                var extusers = from u in users
                               where !otheruser.Contains(u.Id)
                               select u;
                foreach (var itemuser in extusers)
                {
                    //3、创建准备同步钉钉数据
                    Other_User ouser = new Other_User();
                    ouser.Email = itemuser.Email;
                    ouser.Gender = itemuser.Sex.ToString();
                    ouser.Mobile = itemuser.Mobile;
                    ouser.O_Name = itemuser.Name;
                    ouser.SyncMethod = "add";
                    ouser.TypeName = "1";
                    ouser.UserID = itemuser.Id;
                    OtherUserApp.Add(ouser);
                    CountSuccess++;
                }

            }
            response.Code = 200;
            response.Message = "成功" + CountSuccess + "条;失败0条";
            return response;
        }

        /// <summary>
        /// 同步组织数据，为防止堵塞每次最多只更新5条
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Response<bool> SyncOrgAuto()
        {
            var response = new Response<bool>();
            //1、查询组织表中需要同步的数据
            var orglist = OrgApp.LoadForNeedUpdate(5);
            if (orglist == null)
            {
                response.Code = 200;
                response.Message = "成功0条;失败0条";
                return response;
            }
            //2、根据不同类型访问执行
            int CountSuccess = 0;
            int CountFail = 0;
            foreach (var item in orglist)
            {
                if (SyncOrgHandler(item))
                {
                    CountSuccess++;
                }
                else
                {
                    CountFail++;
                }
            }
            response.Code = 200;
            response.Message = "成功" + CountSuccess + "条;失败" + CountFail + "条";
            return response;
        }

        /// <summary>
        /// 第一次同步使用，同步后销毁方法
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Response<bool> SyncOrgIni()
        {
            return null;
            var response = new Response<bool>();
            GetDeptListRespon Respon = DingDingService.DDGetAllDept();
            foreach (var item in Respon.Department)
            {
                var ddorg = OrgApp.Repository.Find(t => t.Name.Equals(item.Name)).FirstOrDefault();
                if (ddorg != null)
                {
                    ddorg.DD_Id = item.Id.ToString();
                    OrgApp.Update(ddorg);
                }
            }
            return response;
        }

        /// <summary>
        /// 执行同步组织
        /// </summary>
        /// <param name="item"></param>
        /// <returns></returns>
        private bool SyncOrgHandler(Org item)
        {
            var response = new Response<bool>();
            bool IsParent = false;
            if (string.IsNullOrEmpty(item.ParentId)) IsParent = true;
            string Parentid = "1";
            if (IsParent)
            {
                Parentid = "1";
            }
            else
            {//获取父部门的sourceId
                var o = OrgApp.Get(item.ParentId);
                Parentid = o.DD_Id;
                if (string.IsNullOrEmpty(Parentid)) return false;
            }
            if (item.DD_SyncMethod == "add")
            {
                CreateDeptRequest model = new CreateDeptRequest();
                model.DeptHiding = false;
                model.Name = item.Name;
                model.Order = item.SortNo.ToString();
                model.OuterDept = false;
                model.Parentid = Parentid;
                model.SourceIdentifier = item.Id;

                DingDingService.DDCreateDept(model);
            }
            else if (item.DD_SyncMethod == "update")
            {
                //更新只更新名称 父节点
                DelDeptRequest d = new DelDeptRequest();
                d.Id = item.DD_Id;
                var resOrg = DingDingService.DDGetDept(d);
                if (resOrg == null)
                {
                    return false;
                }
                UpdateDeptRequest model = new UpdateDeptRequest();
                model.Id = Ext.ToLong(item.DD_Id);
                model.Name = item.Name;
                model.Parentid = Parentid;
                // model.SourceIdentifier = item.Id;
                model.Order = resOrg.Order.ToString();
                model.AutoAddUser = resOrg.AutoAddUser;
                model.CreateDeptGroup = resOrg.CreateDeptGroup;
                model.DeptHiding = resOrg.DeptHiding;
                model.DeptManagerUseridList = resOrg.DeptManagerUseridList;
                model.DeptPerimits = resOrg.DeptPerimits;
                model.OrgDeptOwner = resOrg.OrgDeptOwner;
                model.OuterDept = resOrg.OuterDept;
                model.OuterPermitDepts = resOrg.OuterPermitDepts;
                model.OuterPermitUsers = resOrg.OuterPermitUsers;
                model.SourceIdentifier = item.Id;
                model.UserPerimits = resOrg.UserPerimits;

                DingDingService.DDUpdateDept(model);
            }
            else if (item.DD_SyncMethod == "del")
            {
                DelDeptRequest model = new DelDeptRequest();
                model.Id = item.DD_Id;
                DingDingService.DDDelDept(model);
            }
            else
            {
                return false;
            }

            return true;
        }


    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.App.SSO;
using OpenAuth.Repository.Domain;


namespace OpenAuth.App
{
    public class UserManagerApp : BaseApp<User>
    {
        public RevelanceManagerApp ReleManagerApp { get; set; }
        public OrgManagerApp OrgManagerApp { get; set; }
        public Other_UserManageApp OtherUserApp { get; set; }
        public User Get(string account)
        {
            return Repository.FindSingle(u => u.Account == account);
        }

        public List<User> GetUserListByOrgId(string OrgId)
        {
            var OrgIds = OrgManagerApp.GetOrgAndChilds(OrgId).Select(t => t.Id).ToArray();
            var userIds = ReleManagerApp.Get(Define.USERORG, false, OrgIds);
            return Repository.Find(t => userIds.Contains(t.Id)).ToList();
        }
        /// <summary>
        /// 加载当前登录用户可访问的一个部门及子部门全部用户
        /// </summary>
        public TableData Load(QueryUserListReq request)
        {
            var loginUser = AuthUtil.GetCurrentUser();

            string cascadeId = ".0.";
            if (!string.IsNullOrEmpty(request.orgId))
            {
                var org = loginUser.Orgs.SingleOrDefault(u => u.Id == request.orgId);
                cascadeId = org.CascadeId;
            }

            var ids = loginUser.Orgs.Where(u => u.CascadeId.Contains(cascadeId)).Select(u => u.Id).ToArray();
            var userIds = ReleManagerApp.Get(Define.USERORG, false, ids);

            var users = UnitWork.Find<User>(u => userIds.Contains(u.Id))
                   .OrderBy(u => u.Name)
                   .Skip((request.page - 1) * request.limit)
                   .Take(request.limit);

            var records = Repository.GetCount(u => userIds.Contains(u.Id));


            var userviews = new List<UserView>();
            foreach (var user in users)
            {
                UserView uv = user;
                var orgs = LoadByUser(user.Id);
                uv.Organizations = string.Join(",", orgs.Select(u => u.Name).ToList());
                uv.OrganizationIds = string.Join(",", orgs.Select(u => u.Id).ToList());
                userviews.Add(uv);
            }

            return new TableData
            {
                count = records,
                data = userviews,
            };
        }

        public void AddOrUpdate(UserView view)
        {
            if (string.IsNullOrEmpty(view.OrganizationIds))
                throw new Exception("请为用户分配机构");
            User user = view;
            if (string.IsNullOrEmpty(view.Id))
            {
                if (UnitWork.IsExist<User>(u => u.Account == view.Account))
                {
                    throw new Exception("用户账号已存在");
                }
                user.CreateTime = DateTime.Now;
                user.Password =Infrastructure.Md5.Encrypt("123456"); //默认123456
                Repository.Add(user);
                view.Id = user.Id;   //要把保存后的ID存入view
            }
            else
            {
                UnitWork.Update<User>(u => u.Id == view.Id, u => new User
                {
                    Account = user.Account,
                    BizCode = user.BizCode,
                    Mobile= user.Mobile,
                    Email=user.Email,
                    Name = user.Name,
                    Sex = user.Sex,
                    Status = user.Status
                });
                //更新完毕后将Other_user 同步功能开启,暂时只有钉钉
                OtherUserApp.UpdateSyncMethodOnly(view.Id,"", user.Email, user.Mobile);
            }
            string[] orgIds = view.OrganizationIds.Split(',').ToArray();

            ReleManagerApp.DeleteBy(Define.USERORG, user.Id);
            ReleManagerApp.AddRelevance(Define.USERORG, orgIds.ToLookup(u => user.Id));
        }

        /// <summary>
        /// 加载用户的所有机构
        /// </summary>
        public IEnumerable<Org> LoadByUser(string userId)
        {
            var result = from userorg in UnitWork.Find<Relevance>(null)
                         join org in UnitWork.Find<Org>(null) on userorg.SecondId equals org.Id
                         where userorg.FirstId == userId && userorg.Key == Define.USERORG
                         select org;
            return result;
        }

    }
}
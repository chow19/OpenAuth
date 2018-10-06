using System;
using System.Collections.Generic;
using System.Linq;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public class OrgManagerApp : BaseApp<Org>
    {
        #region 提交数据
        /// <summary>
        /// 添加部门
        /// </summary>
        /// <param name="org">The org.</param>
        /// <returns>System.Int32.</returns>
        /// <exception cref="System.Exception">未能找到该组织的父节点信息</exception>
        public string Add(Org org)
        {

            ChangeModuleCascade(org);
            org.DD_SyncEnabled = true;
            org.DD_SyncMethod = "add";
            org.DD_SyncMsg = "";
            org.DD_SyncStatus = 0;
            Repository.Add(org);
            return org.Id;
        }

        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="org"></param>
        /// <returns></returns>
        public string Update(Org org)
        {
            ChangeModuleCascade(org);

            //获取旧的的CascadeId
            var cascadeId = Repository.FindSingle(o => o.Id == org.Id).CascadeId;
            //根据CascadeId查询子部门
            var orgs = Repository.Find(u => u.CascadeId.Contains(cascadeId)&& u.CascadeId!= cascadeId && u.Id != org.Id)
            .OrderBy(u => u.CascadeId).ToList();

            //更新操作
           var  natualorg= Repository.FindSingle(t => t.Id.Equals(org.Id));
            org.DD_Id= natualorg.DD_Id;
            if (org.DD_SyncEnabled == false)
            {
                org.DD_SyncEnabled = true;
                org.DD_SyncMethod = "update";
                org.DD_SyncMsg = "";
                org.DD_SyncStatus = 0;
            }
            else {
                //org.DD_SyncEnabled = natualorg.DD_SyncEnabled;
                //org.DD_SyncMethod = natualorg.DD_SyncMethod;
                //org.DD_SyncMsg = natualorg.DD_SyncMsg;
                //org.DD_SyncStatus = natualorg.DD_SyncStatus;
            }
            //Repository.Update(u => u.Id == org.Id, u => new Org
            //{
            //    CascadeId = org.CascadeId,
            //    Name = org.Name,
            //    ParentName = org.Name,
            //    ParentId=org.Id
            //});
            Repository.Update(org);

            //更新子部门的CascadeId
            foreach (var a in orgs)
            {
                ChangeModuleCascade(a);
                Repository.Update(a);
            }
            return org.Id;
        }

        /// <summary>
        /// 删除指定ID的部门及其所有子部门
        /// </summary>
        public void DelOrg(string[] ids)
        {
            var delOrg = Repository.Find(u => ids.Contains(u.Id)).ToList();
            foreach (var org in delOrg)
            {
                org.DD_SyncEnabled = true;
                org.DD_SyncMethod = "del";
                org.DD_SyncMsg = "";
                org.DD_SyncStatus = 0;
                org.IsDeleted = true;
                Repository.Update(org);
            }
        }

        /// <summary>
        /// 更新状态
        /// </summary>
        public void SetStatus(string OrgId, int SyncStatus, string SyncMsg, bool IsSuccess)
        { 
            var Org = Repository.Find(u => u.Id.Equals(OrgId)).FirstOrDefault();
            if (Org == null) throw new Exception("组织数据错误");
            if (Org.DD_SyncEnabled == false) throw new Exception("数据错误-》SyncEnabled");
            if (IsSuccess)
            {
                Org.DD_SyncEnabled = false;
                Org.DD_SyncStatus = SyncStatus;
                Org.DD_SyncMsg = SyncMsg;
                Org.DD_Id = SyncMsg;
            }
            else
            {
                Org.DD_SyncStatus = SyncStatus;
                Org.DD_SyncMsg = SyncMsg;
            }
            Repository.Update(Org);
        }

        #endregion

        #region 获取数据
       
        /// <summary>
        /// 加载特定用户的角色
        /// TODO:这里会加载用户及用户角色的所有角色，“为用户分配角色”功能会给人一种混乱的感觉，但可以接受
        /// </summary>
        /// <param name="userId">The user unique identifier.</param>
        public List<Org> LoadForUser(string userId)
        {
            //用户角色
            var userRoleIds =
                UnitWork.Find<Relevance>(u => u.FirstId == userId && u.Key == Define.USERROLE).Select(u => u.SecondId).ToList();

            //用户角色与自己分配到的角色ID
            var moduleIds =
                UnitWork.Find<Relevance>(
                    u =>
                        (u.FirstId == userId && u.Key == Define.USERORG) ||
                        (u.Key == Define.ROLEORG && userRoleIds.Contains(u.FirstId))).Select(u => u.SecondId).ToList();

            if (!moduleIds.Any()) return new List<Org>();
            return UnitWork.Find<Org>(u => moduleIds.Contains(u.Id) && u.IsDeleted == false).ToList();
        }

        /// <summary>
        /// 加载特定角色的角色
        /// </summary>
        /// <param name="roleId">The role unique identifier.</param>
        public List<Org> LoadForRole(string roleId)
        {
            var moduleIds =
                UnitWork.Find<Relevance>(u => u.FirstId == roleId && u.Key == Define.ROLEORG)
                    .Select(u => u.SecondId)
                    .ToList();
            if (!moduleIds.Any()) return new List<Org>();
            return UnitWork.Find<Org>(u => moduleIds.Contains(u.Id) && u.IsDeleted == false).ToList();
        }

        /// <summary>
        /// 获取部门以及其下子部门
        /// </summary>
        /// <param name="orgId"></param>
        /// <returns></returns>
        public List<Org> GetOrgAndChilds(string orgId)
        {
            if (string.IsNullOrEmpty(orgId))
            {
                return Repository.Find(u =>u.IsDeleted == false)
                                 .OrderBy(u => u.CascadeId).ToList();
            }
            //获取旧的的CascadeId
            var cascadeId = Repository.FindSingle(o => o.Id == orgId).CascadeId;
            //根据CascadeId查询子部门
            var orgs = Repository.Find(u => u.CascadeId.Contains(cascadeId) && u.IsDeleted == false)
                                 .OrderBy(u => u.CascadeId).ToList();
            return orgs;
        }

        /// <summary>
        /// 加载前N条需要更新的数据
        /// </summary> 
        public List<Org> LoadForNeedUpdate(int Num)
        { 
            return UnitWork.Find<Org>(u => u.IsDeleted == false && u.DD_SyncEnabled == true).Take(Num).OrderBy(u => u.CascadeId).ToList();
        }

        /// <summary>
        /// 根据用户ID获取部门
        /// </summary>
        /// <param name="UserId"></param>
        /// <returns></returns>
        public Org GetOrgByUserId(string UserId) {
           var o= UnitWork.Find<Relevance>(u => u.FirstId == UserId && u.Key == Define.USERORG).Select(u=>u.SecondId).FirstOrDefault();
            if(!o.Any()) return null;
            return Repository.FindSingle(t=> o.Contains(t.Id));
        }
        #endregion


    }
}
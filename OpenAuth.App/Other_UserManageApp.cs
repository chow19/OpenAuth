using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App
{
    public class Other_UserManageApp : BaseApp<Other_User>
    {
        //根据Uid获取对应数据
        public Other_User Get(string UerId, string Type)
        {
            if (string.IsNullOrEmpty(Type))
            {
                return Repository.FindSingle(t => t.UserID.Equals(UerId) );
            }
            return Repository.FindSingle(t => t.UserID.Equals(UerId) && t.TypeName.Equals(Type));
        }
        //根据Uid获取对应数据
        public List<Other_User> GetUserListByType( string Type)
        {
            return Repository.Find(t => t.TypeName.Equals(Type)).ToList();
        }
          
        public void  Add(Other_User Ouser)
        {
            if (UnitWork.IsExist<Other_User>(u => u.UserID == Ouser.UserID && u.TypeName.Equals(Ouser.TypeName)))
            {
                throw new Exception("用户账号已存在");
            }
            Ouser.CreateTime = DateTime.Now;
            UnitWork.Add(Ouser);
            UnitWork.Save();
        }

        public void update(string Mobile,string Email,string Name,string duserid) {

            UnitWork.Update<Other_User>(u => u.O_Name == Name, u => new Other_User
            { 
                Mobile =Mobile,
                Email = Email,
                O_UserID=duserid
            });
        }
        public void UpdateSyncMethodOnly(string UerId, string Type,string Email,string Moblie)
        {
            var ouser = Get(UerId, Type);
            if (ouser==null)
            {
                throw new Exception("数据错误");
            }
            if (!string.IsNullOrEmpty(ouser.SyncMethod))
            {
                return;
            }
            UnitWork.Update<Other_User>(u => u.Id == ouser.Id, u => new Other_User
            {
                SyncMethod = "Update",
                Email=u.Email,
                Mobile=u.Mobile,
                SyncMsg = ""
            });

        }

        /// <summary>
        /// 更新状态
        /// </summary>
        public void SetStatus(string OuserId,  string SyncMsg, bool IsSuccess)
        {
            
            var Ouser = Repository.FindSingle(u => u.UserID.Equals(OuserId)||u.O_UserID.Equals(OuserId));
            if (Ouser == null) throw new Exception("用户数据错误");
            if (string.IsNullOrEmpty( Ouser.SyncMethod)) throw new Exception("数据错误-》SyncMethod"); 
            if (IsSuccess)
            {
                if (Ouser.SyncMethod=="del")
                {
                    UnitWork.Delete(Ouser);
                    return;
                }
                Ouser.SyncMethod = "";
                Ouser.SyncMsg = SyncMsg;
                Ouser.O_UserID = SyncMsg;
            }
            else
            { 
                Ouser.SyncMsg = SyncMsg; 
            }
            Repository.Update(Ouser);
        }

        //命令删除
        public void SetDelStatus(string OuserId)
        {

            var Ouser = Repository.FindSingle(u => u.UserID.Equals(OuserId) || u.O_UserID.Equals(OuserId));
            if (Ouser == null) throw new Exception("用户数据错误");
           // if (string.IsNullOrEmpty(Ouser.SyncMethod)) throw new Exception("数据错误-》SyncMethod");
            Ouser.SyncMethod = "del";
            Repository.Update(Ouser);
        }
    }
}

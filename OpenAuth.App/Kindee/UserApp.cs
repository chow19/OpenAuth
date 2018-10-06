
using OpenAuth.Repository.Domain.Kindee;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.Kindee
{
    public class UserApp:KindeeBaseApp<User>
    {
        public List<User> GetAllUserFromKindee() {
            
            return Repository.FindBySQL("select FUserID,FName,FDescription from t_Base_User WHERE FDescription IS NOT NULL", null ).ToList();
            
        }
    }
}

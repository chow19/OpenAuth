using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Linq.Expressions;

namespace OpenAuth.Repository.Interface.Kindee
{
    public interface IRepository<T> where T : class
    {
        T FindSingle(Expression<Func<T, bool>> exp = null);
        
        bool IsExist(Expression<Func<T, bool>> exp);

        IQueryable<T> Find(Expression<Func<T, bool>> exp = null);
 
        int GetCount(Expression<Func<T, bool>> exp = null);
          
        int ExecuteSql(string sql);

        List<T> FindBySQL(string SQL, System.Data.SqlClient.SqlParameter paras);

        List<T> FindByProc(string SQL, params System.Data.SqlClient.SqlParameter[] parameters);
    }
}

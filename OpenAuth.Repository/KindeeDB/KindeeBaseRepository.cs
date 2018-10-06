using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository
{
    public class KindeeBaseRepository<T>: Interface.Kindee.IRepository<T> where T:class,new ()
    {
        //KindeeDBContext Context = new KindeeDBContext();
       // protected KindeeDBContext Context = new KindeeDBContext();
        public int ExecuteSql(string sql)
        {
            using (var context = new KindeeDBContext())
            {
                return context.Database.ExecuteSqlCommand(sql);
            } 
        }

        public IQueryable<T> Filter(System.Linq.Expressions.Expression<Func<T, bool>> exp)
        {
            using (var context = new KindeeDBContext()) { 
                var dbSet = context.Set<T>().AsQueryable();
            if (exp != null)
                dbSet = dbSet.Where(exp);
            return dbSet;
            }
        }

        /// <summary>
        /// 根据过滤条件，获取记录
        /// </summary>
        /// <param name="exp">The exp.</param>
        public IQueryable<T> Find(System.Linq.Expressions.Expression<Func<T, bool>> exp = null)
        {
            return Filter(exp);
        }

        public bool IsExist(System.Linq.Expressions.Expression<Func<T, bool>> exp)
        {
            using (var context = new KindeeDBContext()) {
                return context.Set<T>().Any(exp);
            }
        }

        /// <summary>
        /// 查找单个
        /// </summary>
        public T FindSingle(System.Linq.Expressions.Expression<Func<T, bool>> exp)
        {
            using (var context = new KindeeDBContext())
            {
                return context.Set<T>().AsNoTracking().FirstOrDefault(exp);
            }
        }
 
        public int GetCount(Expression<Func<T, bool>> exp = null)
        {
            return Filter(exp).Count();
        }

        public List<T> FindBySQL(string SQL, SqlParameter paras)
        {
            using (var context=new KindeeDBContext())
            {
                return context.Database.SqlQuery<T>(SQL, paras).ToList();
            }
           
        }

        public List<T> FindByProc(string SQL, params SqlParameter[] parameters)
        {

            using (var context = new KindeeDBContext())
            {
                return context.Database.SqlQuery<T>(SQL, parameters).ToList();
            }
        }
    }
}

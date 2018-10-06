using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.Kindee
{
    public class KindeeBaseApp<T> where T : Repository.Domain.Entity
    {
        /// <summary>
        /// 用于普通的数据库操作
        /// </summary>
        /// <value>The repository.</value>
        public Repository.Interface.Kindee.IRepository<T> Repository { get; set; }
         
    }
}

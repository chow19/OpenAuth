using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
   public class OldBaseApp<T> where T: Repository.Domain.Entity
    {
        /// <summary>
        /// 用于普通的数据库操作
        /// </summary>
        /// <value>The repository.</value>
        public Repository.Interface.Kindee.IRepository<T> Repository { get; set; }
         
        public T Get(string id)
        {
            return Repository.FindSingle(u => u.Id == id);
        }
    }
}

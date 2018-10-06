using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Entity;

namespace OpenAuth.Repository
{
    public class KindeeDBContext : DbContext
    {
        static KindeeDBContext()
        {
            Database.SetInitializer<KindeeDBContext>(null);
        }

        public KindeeDBContext()
            : base("Name=KindeeDBContext")
        { }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {

        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Mapping
{
  public  class A_PBOMEntryMap : System.Data.Entity.ModelConfiguration.EntityTypeConfiguration<OpenAuth.Repository.Domain.OldAJD.A_PBOMEntry>
    {
        public A_PBOMEntryMap()
        {
            // table
            ToTable("A_PBOMEntry", "dbo"); 
            // keys
            HasKey(t => t.Id);
 
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Mapping
{
   public class PMC_MasterProductScheduleBOMMap : System.Data.Entity.ModelConfiguration.EntityTypeConfiguration<Domain.OldAJD.PMC_MasterProductScheduleBOM>
    {
        public PMC_MasterProductScheduleBOMMap()
        {
            this.ToTable("PMC_MasterProductScheduleBOM", "dbo");
            this.HasKey(t => t.Id);
        }
    }
}

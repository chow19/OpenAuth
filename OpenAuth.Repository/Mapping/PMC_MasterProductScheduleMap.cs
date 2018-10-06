using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Mapping
{
    public class PMC_MasterProductScheduleMap : System.Data.Entity.ModelConfiguration.EntityTypeConfiguration<Domain.OldAJD.PMC_MasterProductSchedule>
    {
        public PMC_MasterProductScheduleMap()
        {
            this.ToTable("PMC_MasterProductSchedule", "dbo");
            this.HasKey(t => t.Id);
        }
    }
}

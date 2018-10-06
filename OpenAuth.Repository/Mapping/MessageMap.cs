using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Mapping
{
    public class MessageMap : System.Data.Entity.ModelConfiguration.EntityTypeConfiguration<OpenAuth.Repository.Domain.Message>
    {
        public MessageMap()
        {
            this.ToTable("Message", "dbo");
            // keys
            HasKey(t => t.Id); 

            // Properties
            Property(t => t.Id)
                .HasColumnName("Id")
                .HasMaxLength(50)
                .IsRequired();
        }
    }
}

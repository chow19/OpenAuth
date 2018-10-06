using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Mapping
{
    public partial class A_PBOMMap
        : System.Data.Entity.ModelConfiguration.EntityTypeConfiguration<OpenAuth.Repository.Domain.OLDAJD.A_PBOM>
    {
        public A_PBOMMap()
        {
            // table
            ToTable("A_PBOM", "dbo");

            // keys
            HasKey(t => t.Id);
             
            //Property(t => t.Id)
            //    .HasColumnName("Id")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.CrateId)
            //    .HasColumnName("CrateId")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.ContactNo)
            //    .HasColumnName("ContactNo")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.CustomName)
            //    .HasColumnName("CustomName")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.BillNo)
            //    .HasColumnName("BillNo")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.MO)
            //    .HasColumnName("MO")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.FeedOrder)
            //    .HasColumnName("FeedOrder")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.ProNumber)
            //    .HasColumnName("ProNumber")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.ProName)
            //    .HasColumnName("ProName")
            //    .HasMaxLength(200)
            //    .IsRequired();
            //Property(t => t.DeadLine)
            //    .HasColumnName("DeadLine")
            //    .IsRequired();
            //Property(t => t.Qty)
            //    .HasColumnName("Qty")
            //    .IsRequired();
            //Property(t => t.Remark)
            //    .HasColumnName("Remark")
            //    .HasMaxLength(400)
            //    .IsRequired();
            //Property(t => t.SonItemName)
            //    .HasColumnName("SonItemName")
            //    .HasMaxLength(200)
            //    .IsRequired();
            //Property(t => t.SonItemNumberNo)
            //    .HasColumnName("SonItemNumberNo")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.PlanUsage)
            //    .HasColumnName("PlanUsage")
            //    .IsRequired();
            //Property(t => t.BaseUnit)
            //    .HasColumnName("BaseUnit")
            //    .HasMaxLength(50)
            //    .IsRequired();
            //Property(t => t.PBOMStates)
            //    .HasColumnName("PBOMStates")
            //    .IsRequired();
        }
    }
}

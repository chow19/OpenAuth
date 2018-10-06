using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.Kindee
{
    public class Scheme : Entity
    {
        public Scheme() { }

        public Decimal RecordId { get; set; } 
        public string MakeRequest { get; set; }
        public Byte[] images { get; set; }
        public string SchemeRemark { get; set; }
        public string SchemeName { get; set; }
        public string SchemeMaker { get; set; }
        public DateTime SchemeTime { get; set; } 
        public string imagesNew { get; set; }
    }
}

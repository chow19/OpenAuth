using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.Kindee
{
    public class User : Entity
    {
        public User() { }

        public int FUserID { get; set; }
        public string FName { get; set; }
        public string FDescription { get; set; } 
    }
}

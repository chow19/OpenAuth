using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Exception
{
    public class SystemException : System.Exception
    {
        public SystemException(string message) : base(message)
        { 

        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Exception
{
   public class ValidateException:System.Exception 
    {
        public ValidateException(string message) :base(message)  {

        }
    }
}

using Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Dept.Request
{
    public class DelDeptRequest:DDBase<DelDeptRequest>
    {
        /// <summary>
        /// 部门id
        /// </summary>
        public string Id { get; set; }
 
        public override void Validate()
        {
        }
         
      
        public override string GetParametersToJosn()
        {
            MyDictionary parameters = new MyDictionary();
            parameters.Add("id", this.Id); 
            return parameters.ToJson();
        }
    }
}

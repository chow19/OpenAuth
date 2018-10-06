using Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.User.Request
{
   public class GetUserRequest :DDBase<GetUserRequest>
    {
        /// <summary>
        /// 员工唯一标识ID（不可修改）
        /// </summary>
        public string Userid { get; set; }

        public override string GetParametersToJosn()
        {
            MyDictionary parameters = new MyDictionary();
            parameters.Add("userid", this.Userid);
            if (this.otherParams != null)
            {
                parameters.AddAll(this.otherParams);
            }
            return parameters.ToJson();
        }

        public override void Validate()
        {
        }
    }
}

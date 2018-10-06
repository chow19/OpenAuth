using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.Dept.Request
{
   public class CreateDeptRequest: DDBase<CreateDeptRequest>
    {
        /// <summary>
        /// 是否创建一个关联此部门的企业群，默认为false
        /// </summary>
        public Nullable<bool> CreateDeptGroup { get; set; }

        /// <summary>
        /// 是否隐藏部门, true表示隐藏, false表示显示
        /// </summary>
        public Nullable<bool> DeptHiding { get; set; }

        /// <summary>
        /// 可以查看指定隐藏部门的其他部门列表，如果部门隐藏，则此值生效，取值为其他的部门id组成的的字符串，使用 | 符号进行分割。总数不能超过200。
        /// </summary>
        public string DeptPerimits { get; set; }

        /// <summary>
        /// 部门名称。长度限制为1~64个字符。不允许包含字符‘-’‘，’以及‘,’
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 在父部门中的次序值。order值小的排序靠前
        /// </summary>
        public string Order { get; set; }

        /// <summary>
        /// 是否本部门的员工仅可见员工自己, 为true时，本部门员工默认只能看到员工自己
        /// </summary>
        public Nullable<bool> OuterDept { get; set; }

        /// <summary>
        /// 本部门的员工仅可见员工自己为true时，可以配置额外可见部门，值为部门id组成的的字符串，使用|符号进行分割。总数不能超过200。
        /// </summary>
        public string OuterPermitDepts { get; set; }

        /// <summary>
        /// 本部门的员工仅可见员工自己为true时，可以配置额外可见人员，值为userid组成的的字符串，使用|符号进行分割。总数不能超过200。
        /// </summary>
        public string OuterPermitUsers { get; set; }

        /// <summary>
        /// 是否优先使用父部门的预算
        /// </summary>
        public Nullable<bool> ParentBalanceFirst { get; set; }

        /// <summary>
        /// 父部门id。根部门id为1
        /// </summary>
        public string Parentid { get; set; }

        /// <summary>
        /// 是否共享预算
        /// </summary>
        public Nullable<bool> ShareBalance { get; set; }

        /// <summary>
        /// 部门标识字段，开发者可用该字段来唯一标识一个部门，并与钉钉外部通讯录里的部门做映射
        /// </summary>
        public string SourceIdentifier { get; set; }

        /// <summary>
        /// 可以查看指定隐藏部门的其他人员列表，如果部门隐藏，则此值生效，取值为其他的人员userid组成的的字符串，使用| 符号进行分割。总数不能超过200。
        /// </summary>
        public string UserPerimits { get; set; }
          
        public override string   GetParametersToJosn()
        {
            MyDictionary parameters =new MyDictionary();
            parameters.Add("createDeptGroup", this.CreateDeptGroup);
            parameters.Add("deptHiding", this.DeptHiding);
            parameters.Add("deptPerimits", this.DeptPerimits);
            parameters.Add("name", this.Name);
            parameters.Add("order", this.Order);
            parameters.Add("outerDept", this.OuterDept);
            parameters.Add("outerPermitDepts", this.OuterPermitDepts);
            parameters.Add("outerPermitUsers", this.OuterPermitUsers);
            parameters.Add("parentBalanceFirst", this.ParentBalanceFirst);
            parameters.Add("parentid", this.Parentid);
            parameters.Add("shareBalance", this.ShareBalance);
            parameters.Add("sourceIdentifier", this.SourceIdentifier);
            parameters.Add("userPerimits", this.UserPerimits); 
            return JsonConvert.SerializeObject(parameters);
        }

     
        public override void Validate()
        {
         
        }
    }
}

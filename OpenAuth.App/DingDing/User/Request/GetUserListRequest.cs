using Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing.User.Request
{
    public class GetUserListRequest:DDBase<GetUserListRequest>
    {
        /// <summary>
        /// 获取的部门id
        /// </summary>
        public Nullable<long> DepartmentId { get; set; }

        /// <summary>
        /// 通讯录语言(默认zh_CN另外支持en_US)
        /// </summary>
        public string Lang { get; set; }

        /// <summary>
        /// 支持分页查询，与size参数同时设置时才生效，此参数代表偏移量
        /// </summary>
        public Nullable<long> Offset { get; set; }

        /// <summary>
        /// 支持分页查询，部门成员的排序规则，默认不传是按自定义排序；entry_asc代表按照进入部门的时间升序，entry_desc代表按照进入部门的时间降序，modify_asc代表按照部门信息修改时间升序，modify_desc代表按照部门信息修改时间降序，custom代表用户定义(未定义时按照拼音)排序
        /// </summary>
        public string Order { get; set; }

        /// <summary>
        /// 支持分页查询，与offset参数同时设置时才生效，此参数代表分页大小，最大100
        /// </summary>
        public Nullable<long> Size { get; set; }

     

        public override string GetParametersToJosn()
        {
            MyDictionary parameters = new MyDictionary();
            parameters.Add("department_id", this.DepartmentId);
            parameters.Add("lang", this.Lang);
            parameters.Add("offset", this.Offset);
            parameters.Add("order", this.Order);
            parameters.Add("size", this.Size); 
            return parameters.ToJson();
        }

        public override void Validate()
        {
        }
    }
}

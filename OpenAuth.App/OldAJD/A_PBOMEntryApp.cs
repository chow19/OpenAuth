using OpenAuth.App.Kindee;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain.OldAJD;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
    public class A_PBOMEntryApp : BaseApp<A_PBOMEntry>
    {

        /// <summary>
        /// 根据头Id获取分录数据
        /// </summary>
        /// <returns></returns>
        public TableData GetEntryByHeadId(string Id)
        {
            var List = Repository.Find(t => t.A_PBOMId.Equals(Id));
            return new TableData
            {
                count = List.Count(),
                data = List.ToList(),
            };
        }

        /// <summary>
        /// 添加行
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public void Add(A_PBOMEntry Entity)
        {
            Repository.Add(Entity);
        }


        public void UpdateIsOk(string Id,decimal ReveicedQty) {
            var Entry = Repository.Find(t => t.Id.Equals(Id));
            if (Entry == null) throw new Exception("数据异常");
            bool IsOk = false;
            if (Entry.FirstOrDefault().PlanUsage<= ReveicedQty)
            {
                IsOk = true;
            }
            Repository.Update(u => u.Id == Id, u => new A_PBOMEntry
            {
                ReveicedQty = ReveicedQty,
                IsOk = IsOk
            });
        }

        public void UpdateRemark(string Id, string Remark)
        {
            var Entry = Repository.Find(t => t.Id.Equals(Id));
            if (Entry == null) throw new Exception("数据异常");
          
            Repository.Update(u => u.Id == Id, u => new A_PBOMEntry
            {
                Remark = Remark 
            });
        }
    }
}

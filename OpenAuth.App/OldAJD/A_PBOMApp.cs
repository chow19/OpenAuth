using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain.OldAJD;
using OpenAuth.Repository.Domain.OLDAJD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
    /// <summary>
    /// 头数据处理
    /// </summary>
    public class A_PBOMApp : BaseApp<A_PBOM>
    {
        public ProductFeedOrderApp ProductFeedOrderApp { get; set; }

        public A_PBOMEntryApp A_PBOMEntryApp { get; set; }
          
        /// <summary>
        ///  加载左边销售订单数据, 默认加载当日前天数据
        /// </summary>
        public TableData LeftLoad(PageReq request)
        {
            DateTime now = DateTime.Now.Date.AddDays(-1);
            request.key = string.IsNullOrEmpty(request.key) ? "" : request.key;

            List<A_PBOM> PBom = Repository.Find( t => t.CreateTime> now ).ToList() ;
            if (request.key!="")
            {
                PBom = PBom.Where(t => t.BillNo.Equals(request.key)||t.FeedOrder.Equals(request.key)).ToList();
            }   
            return new TableData
            {
                count = PBom.Count(),
                data = PBom.OrderBy(t=>t.CreateTime).Skip((request.page - 1) * request.limit).Take(request.limit)
            };
        }
  
        /// <summary>
        /// 创建数据-点击发送
        /// </summary>
        /// <param name="Id">FEntryID</param>
        public void Add(string FBillNo, string FEntryID)
        {
            //验证 A_PBOM是否存在
            if (Repository.Find(t => t.FEntryID.Equals(FEntryID) && t.BillNo.Equals(FBillNo)).Count()<=0)
            {
                var list = ProductFeedOrderApp.GetProFeedDataByBillNo(FBillNo, FEntryID);
                if (list.Count <= 0)
                {
                    throw new Exception("找不到数据");
                }
                var temp = list.FirstOrDefault();

                UserWithAccessedCtrls userCurrent = new Infrastructure.Cache.ObjCacheProvider<UserWithAccessedCtrls>().GetCache("userCard");
                if (userCurrent == null)
                {
                    throw new Exception("用户已过期");
                }

                //创建头
                A_PBOM head = new A_PBOM(); 
                head.BillNo = FBillNo;
                head.ContactNo = temp.FHeadSelfS0155;
                head.CrateId = userCurrent.User.Id;
                head.CreateName = userCurrent.User.Name;
                head.CreateTime = DateTime.Now;
                head.CustomName = temp.ClientName;
                head.DeadLine = temp.FHeadSelfS0150;
                head.FeedOrder = temp.productFeed;
                head.FEntryID = FEntryID;
                head.IsAttach = false;
                head.MO = temp.pro_OutSourceOrder;
                head.PBOMStates = 0;
                head.ProName = temp.FName;
                head.ProNumber = temp.FNumber;
                head.Remark = "";
                head.AuxQty = temp.PlanUsage;
                Repository.Add(head);
                //创建行  
                int successcount = 0;
                int failcount = 0;
                foreach (var item in list)
                {
                    var entry = new A_PBOMEntry();
                    entry.BaseUnit = item.BaseUnit;
                    entry.CrateId = userCurrent.User.Id;
                    entry.CreateName = userCurrent.User.Name;
                    entry.CreateTime = DateTime.Now;
                    entry.IsOk = false;
                    entry.PBOMId = item.BOMOrderNo;
                    entry.A_PBOMId =head.Id; 
                    entry.PlanUsage = item.PlanUsage;
                    entry.Qty = item.FHeadSelfS0151;
                    entry.Remark = "";
                    entry.SonItemName = item.SonItemName;
                    entry.SonItemNumberNo = item.SonItemNumberNo;
                    entry.RecordId =Convert.ToString( item.RecordId);
                    try
                    {
                        A_PBOMEntryApp.Add(entry);
                        successcount++;
                    }
                    catch (Exception)
                    {
                        failcount++;
                    }
                }
            }
            else
            {
                throw new Exception("数据已存在");
            }
        }
         
        //修改数据
        public void Update(A_PBOM entry)
        { 
            //验证 -todo
            int IsCloseFlag = 0;
            if (entry.PBOMStates == 1)
            {
                IsCloseFlag = 1;
            }
            var Entry = Repository.FindSingle(t => t.Id.Equals(entry.Id));
            if (Entry == null) throw new Exception("数据异常"); 
            //if (Entry.PBOMStates==1) throw new Exception("数据已经提交不能修改");

            Repository.Update(u => u.Id == entry.Id, u => new A_PBOM
            {
                Remark = entry.Remark,
                AttachUrl = entry.AttachUrl,
                IsAttach = string.IsNullOrEmpty(entry.AttachUrl),
                PBOMStates=IsCloseFlag
            });
        }

        //关闭后不能再修改
        public void Submit(A_PBOM obj)
        { 
            var pbom = Repository.FindSingle(t => t.Id.Equals(obj.Id));

            if (pbom == null) throw new Exception("数据异常");
            if (pbom.PBOMStates != 0) throw new Exception("数据已经提交或失效");

            Repository.Update(u => u.Id == obj.Id, u => new A_PBOM
            { 
                PBOMStates =1
            });
        }

    }
}

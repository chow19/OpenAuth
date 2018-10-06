using OpenAuth.App.Kindee;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain.Kindee;
using OpenAuth.Repository.Domain.OldAJD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
    public class PMC_MasterProductScheduleApp : BaseApp<PMC_MasterProductSchedule>
    {
        public ICMOInfoApp ICMOapp { get; set; }
        public PMC_MasterProductScheduleBOMApp mpcBomapp { get; set; }

        /// <summary>
        /// 获取销售数据
        /// </summary>
        public TableData GetMasterProductScheduleData(PageReq req, bool IsOK = true)
        {
            try
            {
                List<PMC_MasterProductSchedule> list = new List<PMC_MasterProductSchedule>();
                req.key = string.IsNullOrEmpty(req.key) ? "" : req.key;
                if (IsOK)
                {
                    list = Repository.Find(t => (t.SEOrder.Equals(req.key) || t.Saler.Equals(req.key) || req.key == "") && t.IsOK == false).ToList();
                }
                else
                {
                    list = Repository.Find(t => t.SEOrder.Equals(req.key) || t.Saler.Equals(req.key) || req.key == "").ToList();
                }
                return new TableData
                {
                    count = list.Count(),
                    data = list.OrderByDescending(t => t.DealLine)
                                .Skip((req.page - 1) * req.limit)
                                .Take(req.limit)

                };
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        /// <summary>
        /// 添加数据
        /// </summary>
        /// <param name="Entity"></param>
        public void Add(ICMOInfo info)
        {
            //UserWithAccessedCtrls userCurrent = new Infrastructure.Cache.ObjCacheProvider<UserWithAccessedCtrls>().GetCache("userCard");
            //if (userCurrent == null)
            //{
            //    throw new Exception("用户已过期");
            //}
            //更新前我就是要验证
            var data = Repository.Find(t => t.SEOrder.Equals(info.FBillNo) && t.SEOrderEntry.Equals(info.FEntryID)).ToList().FirstOrDefault();
            if (data != null)
            {
                try
                {
                    mpcBomapp.Update(info.FBillNo, info.FEntryID);
                }
                catch (Exception ex)
                {
                    throw;
                }
                ChangeToOK(data.Id);
                return;
            }

            PMC_MasterProductSchedule head = new PMC_MasterProductSchedule();
            head.AuxQty = info.FAuxQty;
            head.CrateId = "";
            head.CreateTime = DateTime.Now;
            head.CustomerName = info.CustomerName;
            head.DealLine = info.FAdviceConsignDate;
            head.FName = info.FName;
            head.FNumber = info.FNumber;
            head.GlassAuxQty = info.GlassFAuxQty;
            head.IsOK = false;
            head.LastModifyTime = DateTime.Now;
            head.PetAuxQty = info.PetFAuxQty;
            head.Saler = info.EmpName;
            head.SEOrder = info.FBillNo;
            head.SEOrderEntry = info.FEntryID;
            Repository.Add(head);
            mpcBomapp.Add(head.Id, info.FBillNo, info.FEntryID);
        }

        /// <summary>
        /// 自动执行添加程序
        /// </summary>
        public void AutoAdd()
        {
            //获取所有没有关闭的销售订单
            var selist = Repository.Find(t => 1 == 1).Select(t => new { key = (t.SEOrder + t.SEOrderEntry).ToString() }).Select(t => t.key).ToList();
            var icmolist = ICMOapp.GetICMOInfoData();
            var flterlist = from a in icmolist
                            where selist.Contains((a.FInterID + a.FEntryID).ToString()) == false
                            select a;

            foreach (var item in flterlist)
            {
                Add(item);
            }
        }

        /// <summary>
        /// 状态变更-如果所有行都OK那么单据头就OK吧
        /// </summary>
        public void ChangeToOK(string FId)
        {
            var data = UnitWork.FindSingle<PMC_MasterProductSchedule>(t => t.Id.Equals(FId));
            if (data == null)
            {
                throw new Exception("数据不存在");
            }

            if (mpcBomapp.UnitWork.Find<PMC_MasterProductScheduleBOM>(t => t.FId.Equals(FId) && t.IsOK == false).ToList().Count() <= 0)
            {
                UnitWork.Update<PMC_MasterProductSchedule>(t => t.Id == FId, t => new PMC_MasterProductSchedule
                {
                    IsOK = true
                });
                UnitWork.Save();
            }
        }

        /// <summary>
        /// 获取欠领数据
        /// </summary>
        /// <param name="FNumber">bom项 料号</param>
        /// <returns></returns>
        public TableData GetOweQtyByFNumber(string FNumber)
        {
            try
            {
                var list = mpcBomapp.GetOweQtyByFNumber(FNumber).Select(t => new
                {
                    SEOrder = GetSEOrderById(t.FId),
                    t.OweQty,
                    t.ReceivedQty,
                    t.ReqQty,
                    t.StockQty
                }).ToList();

                return new TableData
                {
                    msg = "欠领总数：" + list.Sum(t => t.OweQty) + ",已领数：" + list.Sum(t => t.ReceivedQty) + ",需求数：" + list.Sum(t => t.ReqQty)+",即时库存："+ list[0].StockQty,
                    data = list.ToList(),
                    count = list.ToList().Count
                };
            }
            catch (Exception ex)
            { 
                throw;
            }

        }

        private object GetSEOrderById(string fId)
        {
            var data = Repository.FindSingle(t => t.Id.Equals(fId));
            return data.SEOrder+"_"+ data.SEOrderEntry;
        }
    }
}

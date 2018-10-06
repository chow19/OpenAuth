using OpenAuth.App.Kindee;
using OpenAuth.App.Request;
using OpenAuth.App.Response;
using OpenAuth.Repository.Domain.OldAJD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
    public class PMC_MasterProductScheduleBOMApp : BaseApp<PMC_MasterProductScheduleBOM>
    {
        public ICMOBomInfoApp iCMOBomInfoApp { get; set; }

        /// <summary>
        /// 根据头数据获取销售数据
        /// </summary>
        public TableData GetSEOderBomDataByMId(string MId)
        {
            var list= Repository.Find(t => t.FId.Equals(MId)).ToList();
            return new TableData {
                data = list,
                count = list.Count
            };
        }

        /// <summary>
        /// 添加数据
        /// </summary>
        /// <param name="Entity"></param>
        public void Add(string FId, string FBillNo, int FEntryID)
        {
            //UserWithAccessedCtrls userCurrent = new Infrastructure.Cache.ObjCacheProvider<UserWithAccessedCtrls>().GetCache("userCard");
            //if (userCurrent == null)
            //{
            //    throw new Exception("用户已过期");
            //}
            //获取数据
            var bomList = iCMOBomInfoApp.GetICMOBomDataBySEOrder(FBillNo, FEntryID);
            //写入数据
            foreach (var item in bomList)
            {
                if (Repository.FindSingle(t => t.FeedId.Equals(item.FeedId) && t.FeedEntryId.Equals(item.FeedEntryId)) == null)
                {
                    PMC_MasterProductScheduleBOM bom = new PMC_MasterProductScheduleBOM();
                    bom.BOMId = Convert.ToInt32(item.BOMId);
                    bom.CrateId = "";
                    bom.CreateTime = DateTime.Now;
                    bom.FeedEntryId = Convert.ToInt32(item.FeedEntryId);
                    bom.FeedId = item.FeedId;
                    bom.FName = item.FName;
                    bom.FNumber = item.FNumber;
                    bom.IsOK = false;
                    bom.OweQty = item.OweQty;
                    bom.ReceivedQty = item.ReceivedQty;
                    bom.Remark = string.Empty;
                    bom.ReqQty = item.ReqQty;
                    bom.StockQty = Convert.ToInt32(item.StockQty);
                    bom.FId = FId;
                    Repository.Add(bom);
                }
                else
                {
                    //throw new Exception("数据重复");
                }
            }
        }

        /// <summary>
        /// 更新欠领等数量
        /// </summary>
        /// <param name="Entity"></param>
        public void Update(string FBillNo, int FEntryID)
        {
            //获取数据
            var bomList = iCMOBomInfoApp.GetICMOBomDataBySEOrder(FBillNo, FEntryID).ToList();
            //写入数据
            foreach (var item in bomList)
            {

                var data = UnitWork.FindSingle<PMC_MasterProductScheduleBOM>(t => t.FeedId == item.FeedId && t.FeedEntryId == item.FeedEntryId && t.IsOK == false);
                if (data != null)
                {

                    bool IsOK = false;
                    if (data.OweQty <= 0 || data.ReceivedQty >= data.ReqQty)
                    {
                        IsOK = true;
                    }
                    UnitWork.Update<PMC_MasterProductScheduleBOM>(t => t.FeedId == item.FeedId && t.FeedEntryId == item.FeedEntryId && t.IsOK == false
                                                                       , t => new PMC_MasterProductScheduleBOM
                                                                       {
                                                                           OweQty = item.OweQty,
                                                                           ReceivedQty = item.ReceivedQty,
                                                                           ReqQty = item.ReqQty,
                                                                           StockQty = Convert.ToInt32(item.StockQty),
                                                                           IsOK = IsOK,
                                                                           OKDate = DateTime.Now,
                                                                           LastModifyTime = DateTime.Now

                                                                       });
                }
            }
            UnitWork.Save();
        }

        /// <summary>
        /// 更新备注
        /// </summary>
        /// <param name="Id"></param>
        /// <param name="Remark"></param>
        public void UpdateRemark(string Id, string Remark)
        {
            var data = Repository.FindSingle(t => t.Id.Equals(Id));
            Repository.Update(u => u.Id == Id, u => new PMC_MasterProductScheduleBOM
            {
                Remark = u.Remark
            });
        }

        /// <summary>
        /// 获取欠领数据
        /// </summary>
        /// <param name="FNumber"></param>
        /// <returns></returns>
        public List<PMC_MasterProductScheduleBOM> GetOweQtyByFNumber(string FNumber) {

          return Repository.Find(t => t.FNumber.Equals(FNumber) && t.IsOK == false) .ToList();  
        }
    }
}

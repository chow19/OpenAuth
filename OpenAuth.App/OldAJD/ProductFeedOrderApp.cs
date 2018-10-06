using OpenAuth.Repository.Domain.Kindee;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
    public class ProductFeedOrderApp : OldBaseApp<Repository.Domain.Kindee.ProductFeedOrder>
    {
        public Response.TableData GetProFeedData(Request.Areas.QueryProFeedOrder req)
        {
            try
            {
                var paras = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "BillNo",
                    Value = req.BillNo == null ? "" : req.BillNo
                };
                var paras2 = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "EntryID",
                    Value = req.EntryID == null ? "" : req.EntryID
                };
                var seorders = Repository.FindByProc("wxProFeed_QueryData_New @BillNo,@EntryID", paras, paras2);
                return new Response.TableData
                {
                    count = seorders.Count(),
                    data = seorders,
                };
            }
            catch (Exception ex)
            {
                throw new Exception("数据异常:" + ex.Message);
            }
        }

        public List<ProductFeedOrder> GetProFeedDataByBillNo(string BillNo ,string EntryId)
        {
            try
            {
                var paras = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "BillNo",
                    Value = BillNo
                };
                var paras2 = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "EntryID",
                    Value = EntryId
                };
                return Repository.FindByProc("wxProFeed_QueryData_New @BillNo,@EntryID", paras, paras2).ToList(); 
            }
            catch (Exception ex)
            {
                throw new Exception("数据异常:" + ex.Message);
            }
        }
        
    }
}

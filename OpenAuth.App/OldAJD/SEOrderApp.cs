using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.OldAJD
{
   public class SEOrderApp : OldBaseApp<Repository.Domain.Kindee.SEOrders>
    {
        /// <summary>
        /// 加载该用户或销售订单的所有销售订单
        /// </summary>
        public Response.TableData GetSEOrders(Request.PageReq request)
        {
            try
            {
                var paras = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "SearchKey",
                    Value = request.key == null ? "" : request.key
                };
                var seorders = Repository.FindBySQL("wxProFeed_GetSEOrderByCreator @SearchKey", paras);
                return new Response.TableData
                {
                    count = seorders.Count(),
                    data = seorders,
                };
            }
            catch (Exception ex)
            {
                throw new Exception("数据异常:"+ex.Message);
            } 
        }

    }
}

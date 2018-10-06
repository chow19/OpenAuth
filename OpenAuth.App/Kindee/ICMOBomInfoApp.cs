using OpenAuth.Repository.Domain.Kindee;
using OpenAuth.Repository.Domain.OldAJD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.Kindee
{
    //
    public class ICMOBomInfoApp : KindeeBaseApp<ICMOBomInfo>
    {
        public List<ICMOBomInfo> GetICMOBomDataBySEOrder(string FBillno, int Entry)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("SELECT SEOrderEntry.FInterID , p2.FAuxQtyPick AS ReqQty,t_Item.FNumber,t_Item.FName ");
                sb.Append("       ,ICMO.FBomInterID AS BOMId,Convert(int,ISNULL(dbo.wx库存总数ajd(t_Item.FNumber),0)) as  StockQty");
                sb.Append("       ,p2.FEntrySelfY0267 AS OweQty,p2.FAuxStockQty AS ReceivedQty,p2.FInterId AS FeedId,Convert(int, p2.FEntryId) AS FeedEntryId ");
                sb.Append(" FROM SEOrder ");
                sb.Append("  LEFT JOIN SEOrderEntry on SEOrder.FInterID = SEOrderEntry.FInterID ");
                sb.Append("  LEFT JOIN t_Organization on SEOrder.FCustID = t_Organization.FItemID ");
                sb.Append("  LEFT JOIN t_Emp on SEOrder.FEmpID = t_Emp.FItemID ");
                sb.Append("  LEFT JOIN ICMO on SEOrderEntry.FInterID = ICMO.FOrderInterID and SEOrderEntry.FEntryID = ICMO.FSourceEntryID ");

                sb.Append("  LEFT JOIN PPBOM p1 on p1.FICMOInterID = ICMO.FInterID ");
                sb.Append("  LEFT join PPBOMEntry p2 on p2.FInterID = p1.FInterID ");
                sb.Append("   INNER JOIN t_Item on p2.FItemID = t_Item.FItemID  ");
                sb.Append(" WHERE SEOrder.FBillNo=@FBillno AND SEOrderEntry.FEntryID=" + Entry);

                var paras = new System.Data.SqlClient.SqlParameter()
                {
                    ParameterName = "FBillno",
                    Value = FBillno
                };
                return Repository.FindBySQL(sb.ToString(), paras).ToList();
            }
            catch (Exception ex)
            {

                throw;
            } 
        }
    }
}

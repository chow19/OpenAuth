using OpenAuth.Repository.Domain.Kindee;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.Kindee
{
    public class ICMOInfoApp : KindeeBaseApp<ICMOInfo>
    {
        public List<ICMOInfo> GetICMOInfoData()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("SELECT SEOrder.FInterID,SEOrder.FBillNo,t_Organization.FName as CustomerName,t_Emp.FName as EmpName ,SEOrderEntry.FAuxQty,t_Item.FNumber,t_Item.FName,SEOrderEntry.FAdviceConsignDate ");
            sb.Append("       ,SEOrderEntry.FEntrySelfS0169 as PetFAuxQty,SEOrderEntry.FEntrySelfS0170 AS ClassFAuxQty,ICMO.FBomInterID,ICMO.FInterID AS MOFInterID, ICMO.FStatus,SEOrderEntry.FEntryID");
       
            sb.Append(" FROM SEOrder ");

            sb.Append(" LEFT JOIN SEOrderEntry on SEOrder.FInterID = SEOrderEntry.FInterID ");
            sb.Append(" LEFT JOIN t_Organization on SEOrder.FCustID = t_Organization.FItemID ");
            sb.Append(" LEFT JOIN t_Emp on SEOrder.FEmpID = t_Emp.FItemID ");
            sb.Append(" LEFT JOIN ICMO on SEOrderEntry.FInterID = ICMO.FOrderInterID and SEOrderEntry.FEntryID = ICMO.FSourceEntryID ");
            sb.Append(" LEFT JOIN t_Item on ICMO.FItemID = t_Item.FItemID ");
            sb.Append(" WHERE SEOrder.FClosed = 0  AND SEOrder.FStatus IN(1, 2, 3) AND ICMO.FStatus != 3 AND ICMO.FClosed = 0 ");//销售订单未关闭并且状态是123，任务单不是任务不是结案状态和关闭状态
            sb.Append(" AND SEOrder.FDate > CONVERT(date, '2018-01-03') ");//第一次 2018-03-03 了效率以后都是取当天

            return Repository.FindBySQL(sb.ToString(), null).ToList();
        }
        
      
    }
}

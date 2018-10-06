using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.Repository.Domain.OLDAJD
{
    public class A_PBOM : Entity
    {
        public A_PBOM()
        {

        }
        public string FEntryID { get; set; }              //流水号
        public string CrateId { get; set; }         //创建人
        public string CreateName { get; set; }         //创建人 
        public string ContactNo { get; set; }       //合同编号
        public string CustomName { get; set; }       //供应商
        public string BillNo { get; set; }          //销售单号
        public string MO { get; set; }              //生产单号
        public string FeedOrder { get; set; }        //投料单号
        public string ProNumber { get; set; }       //物料代码
        public string ProName { get; set; }         //物料名称
        public DateTime? DeadLine { get; set; }      //整单交期 
        public string Remark { get; set; }          //备注 
        public int PBOMStates { get; set; }         //状态
        public DateTime CreateTime { get; set; }	//创建时间
        public bool IsAttach { get; set; }   //是否存在附件
        public string AttachUrl { get; set; }          //附件路径
     
        public decimal AuxQty { get; set; }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace QMS_WebSite
{
    /// <summary>
    /// IQCScanSubmit 的摘要说明
    /// </summary>
    public class IQCScanSubmit
    {


        public IQCScanSubmit()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
        }

        private static string conStr = "";
        private static SqlConnection getSqlConnection()
        {
            if (conStr == "")
            {
                string server = ConfigurationSettings.AppSettings["server"];
                string database = ConfigurationSettings.AppSettings["database"];
                string uid = ConfigurationSettings.AppSettings["uid"];
                string password = ConfigurationSettings.AppSettings["pwd"];
                conStr = String.Format(@"server={0};database={1};uid={2};pwd={3}", server, database, uid, password);
            }

            return new SqlConnection(conStr);
        }

        private DataSet getScanInfos( string SendQCReportId, string LotSN)
        {
            DataSet ds = new DataSet();
            DBClass dbc = new DBClass();

            //string sqlStr = @"SELECT LotId,LotSN,Lot.Qty,ProductShortName, dbo.Product.ProductDescription 
            //         FROM dbo.Lot LEFT JOIN dbo.Product ON lot.ProductId = dbo.Product.ProductId
            //    LEFT JOIN dbo.ProductRoot ON ProductRoot.ProductRootId = Product.ProductRootId
            //    WHERE LotSN = '"+ LotSN + "'";--RB1150000000G
            string sqlStr = @"SELECT  Lot.LotId,VendorDeliveryItemLot.LotSN,LotQty,ProductShortName, dbo.Product.ProductDescription ,SendQCReportId
                 FROM dbo.VendorDeliveryItemLot LEFT JOIN dbo.Product ON VendorDeliveryItemLot.ProductId = dbo.Product.ProductId
            LEFT JOIN dbo.ProductRoot ON ProductRoot.ProductRootId = Product.ProductRootId
            LEFT JOIN dbo.Lot ON Lot.LotSN = VendorDeliveryItemLot.LotSN
            WHERE VendorDeliveryItemLot.LotSN = '" + LotSN + "' AND SendQCReportId='"+ SendQCReportId + "'";
            SqlConnection con = getSqlConnection();
            SqlCommand cmd = new SqlCommand(sqlStr, con);
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex)
            {

                throw ex;

            }
            finally
            {
                con.Close();
            }


            return ds;
        }

        private DataSet getScanInfosUnknowSQId( string LotSN,bool  IsQ)
        {
            DataSet ds = new DataSet();
            DBClass dbc = new DBClass();

            //string sqlStr = @"SELECT LotId,LotSN,Lot.Qty,ProductShortName, dbo.Product.ProductDescription 
            //         FROM dbo.Lot LEFT JOIN dbo.Product ON lot.ProductId = dbo.Product.ProductId
            //    LEFT JOIN dbo.ProductRoot ON ProductRoot.ProductRootId = Product.ProductRootId
            //    WHERE LotSN = '"+ LotSN + "'";--RB1150000000G
            string sqlStr =string.Format(@"SELECT  Lot.LotId,VendorDeliveryItemLot.LotSN,LotQty,ProductShortName, dbo.Product.ProductDescription ,VendorDeliveryItemLot.SendQCReportId,SendQCReport.QCResult
                                             FROM dbo.VendorDeliveryItemLot LEFT JOIN dbo.Product ON VendorDeliveryItemLot.ProductId = dbo.Product.ProductId
                                                  LEFT JOIN dbo.ProductRoot ON ProductRoot.ProductRootId = Product.ProductRootId
                                                  LEFT JOIN dbo.Lot ON Lot.LotSN = VendorDeliveryItemLot.LotSN
                                                  LEFT JOIN dbo.SendQCReport ON SendQCReport.SendQCReportId=VendorDeliveryItemLot.SendQCReportId
                                            WHERE VendorDeliveryItemLot.LotSN = '{0}' AND SendQCReport.QCResult{1}", LotSN,IsQ?"!=0":"=0");
            SqlConnection con = getSqlConnection();
            SqlCommand cmd = new SqlCommand(sqlStr, con);
            try
            {
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
            }
            catch (Exception ex)
            {

                throw ex;

            }
            finally
            {
                con.Close();
            }


            return ds;
        }

        public string getScanLot(string SendQCReportId, string LotSN, out DataSet outDataSet)
        {
            DataSet ds = new DataSet();
            string result = "";
            try
            {
                ds = getScanInfos(SendQCReportId,LotSN);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    result = "0|获取成功";
                }
                else
                {
                    result = "-1|扫描信息不存在或与送货单"+ SendQCReportId + "不匹配";
                }

            }
            catch (Exception ex)
            {
                result = "1|" + ex.Message;
            }
            outDataSet = ds;
            return result;
        }

        public string getScanLotUnknowSQId(string LotSN, bool IsQ,out DataSet outDataSet)
        {
            DataSet ds = new DataSet();
            string result = "";
            try
            {
                ds = getScanInfosUnknowSQId(LotSN, IsQ);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    result = "0|获取成功";
                }
                else
                {
                    result = "-1|扫描信息不存在或与送货单不存在";
                } 
            }
            catch (Exception ex)
            {
                result = "1|" + ex.Message;
            }
            outDataSet = ds;
            return result;
        }

    }
}
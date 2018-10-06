using QMS_WebSite.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace QMS_WebSite.Method
{
    public class PrintCodeConvert
    {

        //打印IQC
        public string GetPrintCodeConvertStr(PrintDataModel PrintData)
        {
            try
            {

                byte[] result = new byte[] { };
                result = new byte[] { 0x1B, 0x40 };       //打印机复位
                result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 

                result = result.Concat(Encoding.Default.GetBytes("来料抽样")).ToArray();
                result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

                result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray();  //设置02条码内容打印在条码下方 00不打印
                result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray();  //设置条码宽度 1 2 3 4
                result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
                result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

                result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D }).ToArray();

                result = result.Concat(Encoding.Default.GetBytes(PrintData.YBBQ)).ToArray();
                string ProductDescribe = CutByteString(PrintData.ProductDescribe, 34);
                string Describe = CutByteString(PrintData.Describe, 38);

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();  //左对齐
                result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
                result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
                result = result.Concat(Encoding.Default.GetBytes("┏━━━━┳━━━━━━┳━━┳━━━━━━━┓\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃采购单号┃" + PrintData.POName.PadRight(12) + "┃物料┃" + GetProductLastShortName(PrintData.ProductShortName).PadRight(14) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┻━━┻━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + ProductDescribe + "┃\n")).ToArray(); 
                result = result.Concat(Encoding.Default.GetBytes("┣━━┳━┻━┳━━┳━━━┳━━━━┳━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃AQL1┃" + PrintData.AQL1.PadRight(6) + "┃AQL2┃" + PrintData.AQL2.PadRight(6) + "┃抽样方式┃" + PrintData.CYFS.PadRight(4) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━╋━━━┻━━┻━━━┻━━━━┻━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃备注┃" + Describe + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┗━━┻━━━━━━━━━━━━━━━━━━━┛\n")).ToArray();

                 result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                //result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
                result = result.Concat(Encoding.Default.GetBytes("打印日期：" + PrintData.SendDate.ToString("yyyy-MM-dd") + " \n\n\n\n\n\n\n")).ToArray();
                
                return Convert.ToBase64String(result);
            }
            catch (Exception)
            {
                byte[] result = new byte[] { };
                result = result.Concat(Encoding.Default.GetBytes("打印发生意外，请联系管理员")).ToArray();
                return Convert.ToBase64String(result);
            }
            //byte[] result = new byte[] { };
            //result = new byte[] { 0x1B, 0x40 };       //打印机复位
            //result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

            //result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray(); 	//设置居中
            //result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 
            //result = result.Concat(Encoding.Default.GetBytes("抽样物料")).ToArray();
            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            //result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray(); 	//设置02条码内容打印在条码下方 00不打印
            //result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray(); 	//设置条码宽度 1 2 3 4
            //result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
            //result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

            //result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0C }).ToArray();      ////打印code128条码 

            //result = result.Concat(Encoding.Default.GetBytes(PrintData.YBBQ.Trim())).ToArray();  
            //result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();	//左对齐
            //result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
            //result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray(); 	//设置不倍高
            //result = result.Concat(Encoding.Default.GetBytes("┏━━━━┳━━━━━━┳━━━━┳━━━━━┓\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┃送检单号┃"+ PrintData.SendQCReportId.PadRight(12) + "┃物料代码┃"+ PrintData.ProductShortName.PadRight(10) + "┃\n")).ToArray(); //.PadRight()
            //result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┻━━━━┻━━━━━┫\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + PrintData.ProductDescribe.PadRight(30) + "┃\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┳━━━━┳━━━━━┫\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┃抽样方式┃"+ PrintData.CYFS.PadRight(12) + "┃检查水平┃"+PrintData.CYSP.PadRight(10) + "┃\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┣━━┳━┻━┳━━┳━┻━┳━━┻┳━━━━┫\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┃AQL1┃" + PrintData.AQL1.PadRight(6) + "┃AQL2┃" + PrintData.AQL2.PadRight(6) + "┃样本量┃" + PrintData.SampleSize.PadRight(6) + "┃\n")).ToArray(); 
            //result = result.Concat(Encoding.Default.GetBytes("┗━━┻━━━┻━━┻━━━┻━━━┻━━━━┛\n")).ToArray();

            //result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray(); 	//设置居中
            //result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
            //result = result.Concat(Encoding.Default.GetBytes("送检日期：2011-05-17\n\n\n")).ToArray();
             
        }
        //打印IPQC首捡
        public string GetPrintIPQCCodeConvertStr(IPQCCheckPrintModel PrintData)
        {
            try
            {

                byte[] result = new byte[] { };
                result = new byte[] { 0x1B, 0x40 };       //打印机复位
                result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 

                result = result.Concat(Encoding.Default.GetBytes("IPQC首检")).ToArray();
                result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

                result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray();  //设置02条码内容打印在条码下方 00不打印
                result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray();  //设置条码宽度 1 2 3 4
                result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
                result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

                result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D }).ToArray();

                result = result.Concat(Encoding.Default.GetBytes(PrintData.YBBQ)).ToArray();
                string ProductDescribe = CutByteString(PrintData.ProductDescribe, 34);
                
                result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();  //左对齐
                result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
                result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
                result = result.Concat(Encoding.Default.GetBytes("┏━━━━┳━━━━━━┳━━┳━━━━━━━┓\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃采购单号┃" + CutByteString(PrintData.POName,12) + "┃物料┃" + CutByteString(PrintData.ProductShortName,14) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┻━━┻━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + ProductDescribe + " ┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━┳━┻━━━━┳━━┳━━━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃工单┃" + CutByteString(PrintData.MOName,12) + "┃工序┃" + CutByteString(PrintData.SteptName,18) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┗━━┻━━━━━━┻━━┻━━━━━━━━━┛\n")).ToArray(); 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
                result = result.Concat(Encoding.Default.GetBytes("打印日期：" + DateTime.Now.ToString("yyyy-MM-dd") + " \n\n\n")).ToArray();
                return Convert.ToBase64String(result);
            }
            catch (Exception)
            {
                byte[] result = new byte[] { };
                result = result.Concat(Encoding.Default.GetBytes("打印发生意外，请联系管理员")).ToArray();
                return Convert.ToBase64String(result);
            }
           

        }
        //打印IPQC巡检
        public string GetPrintIPQCRouteCodeConvertStr(IPQCCheckPrintModel PrintData)
        {
            try
            {

                byte[] result = new byte[] { };
                result = new byte[] { 0x1B, 0x40 };       //打印机复位
                result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 

                result = result.Concat(Encoding.Default.GetBytes("IPQC巡检")).ToArray();
                result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

                result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray();  //设置02条码内容打印在条码下方 00不打印
                result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray();  //设置条码宽度 1 2 3 4
                result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
                result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

                result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D }).ToArray();

                result = result.Concat(Encoding.Default.GetBytes(PrintData.YBBQ)).ToArray();
                string ProductDescribe = CutByteString(PrintData.ProductDescribe, 34);

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();  //左对齐
                result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
                result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
                result = result.Concat(Encoding.Default.GetBytes("┏━━━━┳━━━━━━┳━━┳━━━━━━━┓\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃采购单号┃" + CutByteString(PrintData.POName, 12) + "┃物料┃" + CutByteString(PrintData.ProductShortName, 14) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┻━━┻━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + ProductDescribe + " ┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━┳━┻━━━━┳━━┳━━━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃工单┃" + CutByteString(PrintData.MOName, 12) + "┃工序┃" + CutByteString(PrintData.SteptName, 18) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┗━━┻━━━━━━┻━━┻━━━━━━━━━┛\n")).ToArray();

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
                result = result.Concat(Encoding.Default.GetBytes("打印日期：" + DateTime.Now.ToString("yyyy-MM-dd") + " \n\n\n")).ToArray();
                return Convert.ToBase64String(result);
            }
            catch (Exception)
            {
                byte[] result = new byte[] { };
                result = result.Concat(Encoding.Default.GetBytes("打印发生意外，请联系管理员")).ToArray();
                return Convert.ToBase64String(result);
            }


        }
        //包装-首捡/巡检
        public string GetPrintFQCPackCodeConvertStr(FQCPackPrintModel PrintData)
        {
            try
            {

                byte[] result = new byte[] { };
                result = new byte[] { 0x1B, 0x40 };       //打印机复位
                result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 
                if (PrintData.PackType == "1")
                {
                    result = result.Concat(Encoding.Default.GetBytes("包装首捡")).ToArray();
                }
                else {
                    result = result.Concat(Encoding.Default.GetBytes("包装巡检")).ToArray();
                }
            
                result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

                result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray();  //设置02条码内容打印在条码下方 00不打印
                result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray();  //设置条码宽度 1 2 3 4
                result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
                result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

                result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D }).ToArray();

                result = result.Concat(Encoding.Default.GetBytes(PrintData.YBBQ)).ToArray();
                string ProductDescribe = CutByteString(PrintData.ProductDescribe, 34);

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();  //左对齐
                result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
                result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
                result = result.Concat(Encoding.Default.GetBytes("┏━━┳━━━━━━┳━━┳━━━━━━━━━┓\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃工单┃" + CutByteString(PrintData.MOName, 12) + "┃物料┃" + CutByteString(PrintData.ProductShortName, 18) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━┻━┳━━━━┻━━┻━━━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + ProductDescribe + " ┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┳━━┳━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃销售订单┃" + CutByteString(PrintData.BillNo, 12) + "┃行号┃" + CutByteString(PrintData.SteptName, 14) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┗━━━━┻━━━━━━┻━━┻━━━━━━━┛\n")).ToArray();

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
                result = result.Concat(Encoding.Default.GetBytes("打印日期：" + DateTime.Now.ToString("yyyy-MM-dd") + " \n\n\n")).ToArray();
                return Convert.ToBase64String(result);
            }
            catch (Exception)
            {
                byte[] result = new byte[] { };
                result = result.Concat(Encoding.Default.GetBytes("打印发生意外，请联系管理员")).ToArray();
                return Convert.ToBase64String(result);
            }


        }

        //打印FQC
        public string GetPrintFQCCodeConvertStr(string YBBQ,string ProductDescribe,string MoName,string ProductShortName,string CQty,string CustomerName)
        {
            try
            {

                byte[] result = new byte[] { };
                result = new byte[] { 0x1B, 0x40 };       //打印机复位
                result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 

                result = result.Concat(Encoding.Default.GetBytes("FQC")).ToArray();
                result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

                result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray();  //设置02条码内容打印在条码下方 00不打印
                result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray();  //设置条码宽度 1 2 3 4
                result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
                result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

                result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D }).ToArray();

                result = result.Concat(Encoding.Default.GetBytes(YBBQ)).ToArray();
                ProductDescribe = CutByteString(ProductDescribe, 34); 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();  //左对齐
                result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
                result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
                result = result.Concat(Encoding.Default.GetBytes("┏━━┳━━━━━━┳━━┳━━━━━━━━━┓\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃工单┃" + MoName.PadRight(12) + "┃物料┃" + GetProductLastShortName(ProductShortName).PadRight(14) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━┻━┳━━━━┻━━┻━━━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + ProductDescribe + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━┳━┻━┳━━┳━━━━━━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃数量┃" + CQty.PadRight(6) + "┃客户┃" + CustomerName.PadRight(22) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┗━━━━━━┻━━┻━━━━━━━━━━━━┛\n")).ToArray(); 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
                result = result.Concat(Encoding.Default.GetBytes("打印日期：" +DateTime.Now  .ToString("yyyy-MM-dd") + " \n\n\n")).ToArray();
                return Convert.ToBase64String(result);
            }
            catch (Exception)
            {
                byte[] result = new byte[] { };
                result = result.Concat(Encoding.Default.GetBytes("打印发生意外，请联系管理员")).ToArray();
                return Convert.ToBase64String(result);
            }
            

        }

        //OQC
        public string GetPrintOQCPackCodeConvertStr(string FBillNo,string CustomerName, string ProductShortName, string ProductDescription,string YBBQ,int QTY)
        {
            try
            {

                byte[] result = new byte[] { };
                result = new byte[] { 0x1B, 0x40 };       //打印机复位
                result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 
                result = result.Concat(Encoding.Default.GetBytes("OQC")).ToArray();

                result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

                result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray();  //设置02条码内容打印在条码下方 00不打印
                result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray();  //设置条码宽度 1 2 3 4
                result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
                result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

                result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D }).ToArray();

                result = result.Concat(Encoding.Default.GetBytes(YBBQ)).ToArray();
                string ProductDescribe = CutByteString(ProductDescription, 34);

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();  //左对齐
                result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
                result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
                result = result.Concat(Encoding.Default.GetBytes("┏━━┳━━━━━━┳━━┳━━━━━━━━━┓\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃单号┃" + CutByteString(FBillNo, 12) + "┃物料┃" + CutByteString(ProductShortName, 18) + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━┻━┳━━━━┻━━┻━━━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃" + ProductDescribe + " ┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┳━━┳━━━━━━━┫\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┃出库数量┃" + QTY + "┃客户┃" + CustomerName + "┃\n")).ToArray();
                result = result.Concat(Encoding.Default.GetBytes("┗━━━━┻━━━━━━┻━━┻━━━━━━━┛\n")).ToArray();

                result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray();  //设置居中
                result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
                result = result.Concat(Encoding.Default.GetBytes("打印日期：" + DateTime.Now.ToString("yyyy-MM-dd") + " \n\n\n")).ToArray();
                return Convert.ToBase64String(result);
            }
            catch (Exception)
            {
                byte[] result = new byte[] { };
                result = result.Concat(Encoding.Default.GetBytes("打印发生意外，请联系管理员")).ToArray();
                return Convert.ToBase64String(result);
            }


        }

        private string StringToHexString(string s, Encoding encode)
        {
            byte[] b = encode.GetBytes(s);//按照指定编码将string编程字节数组
            string result = string.Empty;
            for (int i = 0; i < b.Length; i++)//逐字节变为16进制字符，以%隔开
            {
                result += "0X" + Convert.ToString(b[i], 16);
            }
            return result;
        }

        /// <summary>
        /// 获取中英文混排字符串的实际长度(字节数)
        /// </summary>
        /// <param name="str">要获取长度的字符串</param>
        /// <returns>字符串的实际长度值（字节数）</returns>
        public int getStringLength(string str)
        {
            if (str.Equals(string.Empty))
                return 0;
            int strlen = 0;
            ASCIIEncoding strData = new ASCIIEncoding();
            //将字符串转换为ASCII编码的字节数字
            byte[] strBytes = strData.GetBytes(str);
            for (int i = 0; i <= strBytes.Length - 1; i++)
            {
                if (strBytes[i] == 63)  //中文都将编码为ASCII编码63,即"?"号
                    strlen++;
                strlen++;
            }
            return strlen;
        }

        /// <summary>
        /// 截取指定字节长度的字符串
        /// </summary>
        /// <param name="str">原字符串</param>`
        /// <param name="len">截取字节长度</param>
        /// <returns></returns>
        public  string CutByteString(string str, int len)
        {
            string result = string.Empty;// 最终返回的结果
            if (string.IsNullOrEmpty(str)) { return new string(' ', len); }
            int byteLen = System.Text.Encoding.Default.GetByteCount(str);// 单字节字符长度
            int charLen = str.Length;// 把字符平等对待时的字符串长度
            int byteCount = 0;// 记录读取进度
            int pos = 0;// 记录截取位置
            if (byteLen > len)
            {
                for (int i = 0; i < charLen; i++)
                {
                    if (Convert.ToInt32(str.ToCharArray()[i]) > 255)// 按中文字符计算加2
                    { byteCount += 2; }
                    else// 按英文字符计算加1
                    { byteCount += 1; }
                    if (byteCount > len)// 超出时只记下上一个有效位置
                    {
                        pos = i;
                        break;
                    }
                    else if (byteCount == len)// 记下当前位置
                    {
                        pos = i + 1;
                        break;
                    }
                }
                if (pos >= 0)
                { result = str.Substring(0, pos); }
            }
            else
            {
                int padLen = len - byteLen-1;
                string white = new string(' ', padLen);
                result = str+ white;
            }
            if (getStringLength(result)< len)
            {
                result +=  new string(' ',1);
            } 
            return result;
        }

        private byte[] getLowHighByte(byte[] data)
        {
            byte[] lowHighByte = new byte[2];
            int dataLen = data.Length;
            lowHighByte[0] = (byte)(0xFF & dataLen);
            lowHighByte[1] = (byte)((0xFF00 & dataLen) >> 8);
            return lowHighByte;
        }

        private string GetProductLastShortName(string ProductShortName)
        {
            char[] bbv = { 'a', 'b', 'c', 'd', 'e', 'f', 'A', 'B', 'C', 'D', 'E', 'F', };

            int inx = ProductShortName.LastIndexOfAny(bbv);
            if (inx < 0)
            {
                return "";
            }
            return ProductShortName.Substring(inx, ProductShortName.Length - inx);

        }
    }
}
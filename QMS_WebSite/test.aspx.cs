using QMS_WebSite.Method;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class test : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            byte[] result = new byte[] { };
            result = new byte[] { 0x1B, 0x40 };       //打印机复位
            result = result.Concat(new byte[] { 0x1B, 0x33, 0x00 }).ToArray();   //设置行间距为0 

            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray(); 	//设置居中
            result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高 
            result = result.Concat(Encoding.Default.GetBytes("抽样物料")).ToArray();
            result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            result = result.Concat(new byte[] { 0x1d, 0x48, 0x02 }).ToArray(); 	//设置02条码内容打印在条码下方 00不打印
            result = result.Concat(new byte[] { 0x1D, 0x77, 0x02 }).ToArray(); 	//设置条码宽度 1 2 3 4
            result = result.Concat(new byte[] { 0x1D, 0x68, 0x20 }).ToArray();  //设置条码高度 
            result = result.Concat(new byte[] { 0x1D, 0x66, 0x00 }).ToArray();  //设置条码字体

            result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0C }).ToArray();      ////打印code128条码
                                                                                          // byte[] LowHighByte = getLowHighByte(Encoding.Default.GetBytes("YP1807090001"));

            result = result.Concat(Encoding.Default.GetBytes("YP1807090001")).ToArray();

            //result = result.Concat(new byte[] { 0x1D, 0x6B, 0x45, 0x0D, 0x31, 0x39, 0x41, 0x54, 0x5A, 0x2D, 0x2E, 0x20, 0x24, 0x2F, 0x2B, 0x25, 0x44 }).ToArray();
            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            result = result.Concat(new byte[] { 0x1B, 0x61, 0x00 }).ToArray();	//左对齐
            result = result.Concat(new byte[] { 0x1B, 0x21, 0x00 }).ToArray();  // 还原默认字体大小，取消下划线，取消粗体模式
            result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray(); 	//设置不倍高
            result = result.Concat(Encoding.Default.GetBytes("┏━━━━┳━━━━━━┳━━━━┳━━━━━┓\n")).ToArray();
            // result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印
            //ComWriteCommand(new byte[] { 0x1D, 0x6B, 0x45, 0x0D, 0x31, 0x39, 0x41, 0x54, 0x5A, 0x2D, 0x2E, 0x20, 0x24, 0x2F, 0x2B, 0x25, 0x44 });   //code 39 条码：19ATZ-. $/+%D


            //result = result.Concat(new byte[] { 0x1d, 0x21, 0x01 }).ToArray();  //设置倍高
            result = result.Concat(Encoding.Default.GetBytes("┃送检单号┃SQCR000000TV┃物料代码┃B011412042┃\n")).ToArray();
            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray();  //设置不倍高
            result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┻━━━━┻━━━━━┫\n")).ToArray();
            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            // result = result.Concat(new byte[] { 0x1d, 0x21, 0x01 }).ToArray(); 	//设置倍高
            result = result.Concat(Encoding.Default.GetBytes("┃物料描述┃半成品_普通片_IS01-HC_2042 2042 iP┃\n")).ToArray();
            // result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            // result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray(); 	//设置不倍高
            result = result.Concat(Encoding.Default.GetBytes("┣━━━━╋━━━━━━┳━━━━┳━━━━━┫\n")).ToArray();
            // result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            //result = result.Concat(new byte[] { 0x1d, 0x21, 0x01 }).ToArray();  //设置倍高
            result = result.Concat(Encoding.Default.GetBytes("┃抽样方式┃正常抽样    ┃检查水平┃ S-1      ┃\n")).ToArray();
            // result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            //result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray(); 	//设置不倍高
            result = result.Concat(Encoding.Default.GetBytes("┣━━┳━┻━┳━━┳━┻━┳━━┻┳━━━━┫\n")).ToArray();
            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            // result = result.Concat(new byte[] { 0x1d, 0x21, 0x01 }).ToArray(); 	//设置倍高
            result = result.Concat(Encoding.Default.GetBytes("┃AQL1┃10    ┃AQL2┃12    ┃样本量┃8       ┃\n")).ToArray();
            //result = result.Concat(new byte[] { 0x0D }).ToArray();   //回车并打印

            // result = result.Concat(new byte[] { 0x1d, 0x21, 0x00 }).ToArray(); 	//设置不倍高 
            result = result.Concat(Encoding.Default.GetBytes("┗━━┻━━━┻━━┻━━━┻━━━┻━━━━┛\n")).ToArray();

            result = result.Concat(new byte[] { 0x1B, 0x61, 0x01 }).ToArray(); 	//设置居中
            result = result.Concat(new byte[] { 0x1D, 0x21, 0x01 }).ToArray();  //设置倍高
            result = result.Concat(Encoding.Default.GetBytes("送检日期：2011-05-17\n\n\n")).ToArray();
            // result = result.Concat(new byte[] { 0x0c }).ToArray();   //回车并打印

            // result = result.Concat(new byte[] { 0x1D,0x0C }).ToArray();   //复位

            //string NewData = TextBox1.Text;

            //byte[] commands = { 0x1B, 0x24, 0x1F, 0x09, 0x1B, 0x5A, 0x09, 0x04, 0x03 };
            //byte[] NewDataByte = Encoding.Default.GetBytes(NewData);
            //byte[] checkByte = getLowHighByte(NewDataByte);
            //byte[] resultByte = commands.Concat(checkByte).ToArray();
            //resultByte = resultByte.Concat(NewDataByte).ToArray();

            Response.Write(Convert.ToBase64String(result));

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


        private byte[] getLowHighByte(byte[] data)
        {
            byte[] lowHighByte = new byte[2];
            int dataLen = data.Length;
            lowHighByte[0] = (byte)(0xFF & dataLen);
            lowHighByte[1] = (byte)((0xFF00 & dataLen) >> 8);
            return lowHighByte;
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            System.Text.ASCIIEncoding asciiEncoding = new System.Text.ASCIIEncoding();
            byte[] byteArray = new byte[] { (byte)28 };
            
            Response.Write(asciiEncoding.GetString(byteArray));
            //    char[] bbv = {'a','b','c', 'd', 'e','f', 'A', 'B', 'C', 'D', 'E', 'F', };
            //    string a = TextBox1.Text;
            //PrintCodeConvert A = new PrintCodeConvert();
            //Model.PrintDataModel AV = new Model.PrintDataModel();
            //    AV.AQL1 = "0";
            //    AV.AQL2= "0";
            //    AV.CYFS = "2222";
            //    AV.CYSP = "sssss";
            //    AV.Describe = "";
            //    AV.POName = "sssssazzz1";
            //    AV.ProductDescribe = "sadfsadlslkfkslddfasdasdasdasdasdasdasdsadsaaaaaaa得得得";
            //    AV.ProductShortName = "22xxxxxxxxx";
            //    AV.SampleSize = "2";
            //    AV.SendDate = DateTime.Now;
            //    AV.YBBQ = "2dsxddd";
            //    string a = A.GetPrintCodeConvertStr(AV);
            //Response.Write(a);
            // Response.Write(StringToHexString("YP1807130001", System.Text.Encoding.Default));
        }
        //（密码只能用于英文加数字及标准符号）
        public string get加解密(String str, Int32 ii)
        {
            Int32 strlen = 0;
            Int32 i = 0;
            string s = "";
            string ss = "";
            string sss = "";
            strlen = str.Length;

            for (i = 0; i <= strlen - 1; i = i + 1)
            {
                s = str.Substring(i, 1);
                ss = Chr(Asc(s) - ii);
                sss = sss + ss;
            }
            return sss;
        }

        /// <summary>
        /// convert the character to Asc code
        /// </summary>
        /// <param name="character"></param>
        /// <returns></returns>
        public static int Asc(string character)
        {
            if (character.Length == 1)
            {
                System.Text.ASCIIEncoding asciiEncoding = new System.Text.ASCIIEncoding();
                int intAsciiCode = (int)asciiEncoding.GetBytes(character)[0];
                return (intAsciiCode);
            }
            else
            {
                throw new Exception("Character is not valid.");
            }

        }
        /// <summary>
        /// convert the asc code to character
        /// </summary>
        /// <param name="asciiCode"></param>
        /// <returns></returns>
        public static string Chr(int asciiCode)
        {
            if (asciiCode >= 0 && asciiCode <= 255)
            {
                System.Text.ASCIIEncoding asciiEncoding = new System.Text.ASCIIEncoding();
                byte[] byteArray = new byte[] { (byte)asciiCode };
                string strCharacter = asciiEncoding.GetString(byteArray);
                return (strCharacter);
            }
            else
            {
                throw new Exception("ASCII Code is not valid.");
            }
        }


    }
}
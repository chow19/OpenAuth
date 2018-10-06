using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Infrastructure;
using FunctionTest.Common;
using System.Configuration;
using NFine.Infrastructure;

namespace FunctionTest
{
    public partial class Form1 : Form
    {
        public string ScanMsg = "";
        public Form1()
        {
            InitializeComponent();
        }

        public string getExcelData(string path)
        {
            string ErrMsg = "";
            try
            { 
                if (FileHelper.GetFileName(path).Split('.')[1]!="xls")
                {
                    return "";
                }
                if (FileHelper.IsExistFile(path))
                {
                    NPOIExcel npio = new NPOIExcel();
                    DataTable dt = npio.ExcelToTableToSpe(path, 8);
                    DataHandler(dt, path, out ErrMsg);
                }
                else
                {
                    ErrMsg = "文件不存在";
                }
            }
            catch (Exception ex)
            {
                ErrMsg = path +":"+ ex.Message;
            }

            return ErrMsg;
        }

        private void DataHandler(DataTable dt, string path, out string ErrMsg)
        {
            bool isFirstRow = false;
            List<string> hasInsert = new List<string>();
            string ModuleName = string.Empty;
            DateTime TestDateTime = DateTime.MinValue;
            string Timestamp = string.Empty;
            string Id = string.Empty;
            List<RowData> rdList = new List<RowData>();
            RowData rd;
            HeaderData hd;
            ErrMsg = "";
            int rownum = 0;
            foreach (DataRow item in dt.Rows)
            {
                rownum++;
                try
                {
                    if (Convert.ToString(item["Columns0"]) == "工件名称：")
                    {
                        isFirstRow = true;
                        continue;
                    }
                    else
                    {

                        if (isFirstRow)//如果是第二行则将数据读出
                        {
                            ModuleName = Convert.ToString(item["Columns0"]);
                            TestDateTime = Convert.ToDateTime(Convert.ToDateTime(item["Columns1"]).ToString("yyyy-MM-dd") + " " + Convert.ToDateTime(item["Columns2"]).ToString("hh:mm:ss"));
                            Timestamp = ConvertDateTimeToInt(TestDateTime).ToString();
                            isFirstRow = false;
                            hd = new HeaderData();
                            string fileName = FileHelper.GetFileName(path); //path.Substring(path.LastIndexOf("/")+1, path.Length- path.LastIndexOf("/")-1);
                            string fileDir = path.Replace("\\" + fileName, "");
                            string folderName = fileDir.Substring(fileDir.LastIndexOf("\\") + 1, fileDir.Length - fileDir.LastIndexOf("\\") - 1);

                            string[] fileMsg = fileName.Split('_');
                            if (fileMsg.Length <= 2)
                            {
                                ErrMsg = "错误：文件" + fileName + "格式不正确(格式:模具号_自定义内容_工序(1模切2切合)_(检验方式1首2抽3尾))";
                                return;
                            }
                            else if (fileMsg.Length > 2 && fileMsg[2] == "1")
                            {
                                if (fileMsg.Length != 4)
                                {
                                    ErrMsg = "错误：文件" + fileName + "格式不正确(格式:模具号_自定义内容_工序(1模切2切合)_(检验方式1首2抽3尾))";
                                    return;
                                }
                            }

                            Id = Guid.NewGuid().ToString().Substring(0, 12);
                            hd.Id = Id;
                            hd.ModuleName = ModuleName;
                            hd.TestDataTime = TestDateTime;
                            hd.Timestamp = Timestamp;
                            hd.MOName = folderName;
                            hd.WorkStept = fileMsg[2].Replace(".xls", "").Replace(".xlsx", "");
                            hd.CheckType = "";
                            if (hd.WorkStept == "1")
                            {
                                hd.CheckType = fileMsg[3].Replace(".xls", "").Replace(".xlsx", "");
                            }

                            hd.FileName = fileName;
                            hd.FilePath = path;
                            if (string.IsNullOrEmpty(hd.ModuleName))
                            {
                                return;
                            }
                            //如果该时间戳已经记录则跳过
                            if (!DB.IsExists("SELECT COUNT(1) FROM  C_QCTestScan WHERE Timestamp='" + Timestamp + "'"))
                            {
                                StringBuilder sb = new StringBuilder();
                                sb.Append("INSERT INTO [dbo].C_QCTestScan ");
                                sb.Append("           (C_QCTestScanId,MOName,ModuleName,TestDateTime,WorkStept,CheckType,Timestamp,FileName,FilePath)");
                                sb.Append("      VALUES ");
                                sb.Append("           (@C_QCTestScanId,@MOName,@ModuleName,@TestDateTime,@WorkStept,@CheckType,@Timestamp,@FileName,@FilePath)");
                                DB.InsertHeadData(sb.ToString(), hd);
                            }
                            else
                            {
                                hasInsert.Add(hd.Id);
                            }
                            continue;
                        }
                        if (!hasInsert.Contains(Id) &&   Convert.ToString(item["Columns0"]).Trim()!="名称")
                        {
                            rd = new RowData();
                            rd.HeadId = Id;
                            rd.TestName = Convert.ToString(item["Columns0"]);
                            rd.TestResultValue = Convert.ToString(item["Columns1"]);
                            rd.TestStdValue = Convert.ToString(item["Columns2"]);
                            rd.UpLimit = Convert.ToDecimal(item["Columns3"]);
                            rd.DownLimit = Convert.ToDecimal(item["Columns4"]);
                            rd.Deviation = Convert.ToDecimal(item["Columns5"]);
                            rd.TestResult = Convert.ToString(item["Columns6"]);
                            rd.OverValue = Convert.ToDecimal(item["Columns7"]);
                            StringBuilder sb = new StringBuilder();
                            sb.Append("INSERT INTO dbo.C_QCTestScanRecord ");
                            sb.Append("             (TestName,TestResultValue,TestStdValue,UpLimit,DownLimit,Deviation,TestResult,OverValue ,C_QCTestScanId)");
                            sb.Append("      VALUES ");
                            sb.Append("           (@TestName,@TestResultValue,@TestStdValue,@UpLimit,@DownLimit,@Deviation,@TestResult,@OverValue,@C_QCTestScanId)");
                            DB.InsertRowData(sb.ToString(), rd);
                        }
                    }
                }
                catch (Exception ex)
                {

                    ErrMsg = FileHelper.GetFileName(path) +"行"+ rownum.ToString() + "写入数据错误：" + ex.Message;
                }
            }
        }

        /// <summary>  
        /// 将c# DateTime时间格式转换为Unix时间戳格式  
        /// </summary>  
        /// <param name="time">时间</param>  
        /// <returns>long</returns>  
        public static long ConvertDateTimeToInt(System.DateTime time)
        {
            System.DateTime startTime = TimeZone.CurrentTimeZone.ToLocalTime(new System.DateTime(1970, 1, 1, 0, 0, 0, 0));
            long t = (time.Ticks - startTime.Ticks) / 10000;   //除10000调整为13位      
            return t;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            timer1.Start();
            timer1.Interval = 1000 * 60 * 60 * 4;
            
            ScanData();
            
        }

        //扫描数据
        private void ScanData()
        {
            label3.Text = "正在扫描..请不要打开相关文件";
            try
            {
                if (!backgroundWorker1.IsBusy)
                {
                    backgroundWorker1.RunWorkerAsync();
                }
            }
            catch (Exception ex)
            {
                label3.Text = ex.Message;
            }
           
             
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            timer1.Stop();
            ScanData();
            timer1.Start();

        }

        /// <summary>
        /// 菜单
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            InputScanFloder frm = new InputScanFloder();
            frm.ShowDialog();

        }
        private void StopToolStripMenuItem_Click(object sender, EventArgs e)
        {
            timer1.Stop();
            label3.Text = "程序已暂停";

        }

        private void StartToolStripMenuItem_Click(object sender, EventArgs e)
        {
            timer1.Start();
            ScanData();
        }

        private void backgroundWorker1_DoWork(object sender, DoWorkEventArgs e)
        {
            //bk
            string BaseFilePath =string.Format( ConfigurationSettings.AppSettings["FloderPath"],DateTime.Now.Year,DateTime.Now.Month);
            string[] fileNames = FileHelper.GetFileNames(BaseFilePath, "*", true);
            foreach (string item in fileNames)
            {
                string temp = getExcelData(item);
                if (temp != "")
                {
                    ScanMsg = ScanMsg + "\n\r" + temp;
                }
            }
            //磨具
            BaseFilePath = string.Format(ConfigurationSettings.AppSettings["FloderPathModule"], DateTime.Now.Year, DateTime.Now.Month);
            fileNames = FileHelper.GetFileNames(BaseFilePath, "*", true);
            foreach (string item in fileNames)
            {
                string temp = getExcelData(item);
                if (temp != "")
                {
                    ScanMsg = ScanMsg + "\n\r" + temp;
                }
            }
        }

        private void backgroundWorker1_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            label3.Text = "下一次扫描时间:" + DateTime.Now.AddHours(4).ToString("yyyy-MM-dd HH:mm:ss");

            label1.Text = ScanMsg;

           DataTable DT= DB.GetOverModule();
        }

        private void modulanotify_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (this.WindowState == System.Windows.Forms.FormWindowState.Minimized)
                this.WindowState = System.Windows.Forms.FormWindowState.Normal;
        }

        void showTip()
        {
            //获取需要提醒数据
            //DataTable dt = DB.GetOverModule();
            //List<string> modulaList = new List<string>();
            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    string QCTestScanId = "";
            //    string QCTestScanRecordLId = "";
            //    foreach (DataRow item in dt.Rows)
            //    { 
            //        QCTestScanId = Convert.ToString(item["STRR"]).Split('|')[0];
            //        QCTestScanRecordLId = Convert.ToString(item["STRR"]).Split('|')[1];

            //        if (!modulaList.Contains(temp))
            //        {
            //            modulaList.Add(temp);
            //        } 
            //    }
                
            //    if (modulaList.Count>0)
            //    {
            //        //写入系统
            //        StringBuilder sb = new StringBuilder();
            //        sb.Append("SELECT C_NotifyRecordId FROM C_NotifyRecord WHERE CreateDate= (select MAX(CreateDate) FROM C_NotifyRecord) AND NotifyContent='" + modulaList + "'");
            //        string NotifyRecordId = DB.GetSingle(sb.ToString());
            //        if (NotifyRecordId != "")
            //        {
            //            sb = new StringBuilder();
            //            sb.Append("UPDATE C_NotifyRecord SET NotifyContent=@NotifyContent,LastNotifyDateTime=getdate(),Count=Count+1 WHERE C_NotifyRecordId=@C_NotifyRecordId ");
            //            DB.UpdateNotifyRecord(sb.ToString(), modulaList, NotifyRecordId);
            //        }
            //        else
            //        {

            //            sb = new StringBuilder();
            //            sb.Append("INSERT INTO dbo.C_NotifyRecord ");
            //            sb.Append("                   (NotifyContent,Count,LastNotifyDateTime) ");
            //            sb.Append("    VALUES ");
            //            sb.Append("                   (@NotifyContent,0,GETDATE()) ");
            //            DB.CreateNotifyRecord(sb.ToString(), modulaList);
            //        }

            //        //getWarnMoludaName
            //        //this.modulanotify.ShowBalloonTip(5000, "注意", modulaList + "二次元测试多次异常", ToolTipIcon.Warning);
            //       // label3.Text = modulaList + "二次元测试多次异常,上次扫描时间为:" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            //    }
            //}

        }
        //private void timer2_Tick(object sender, EventArgs e)
        //{
        //    timer2.Stop();
        //    //写入数据
        //    showTip();
        // ;
        //    timer2.Start();  
        //}


         
    }
}

using QCTestWarningClisent.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QCTestWarningClisent
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void modulanotify_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            if (this.WindowState == System.Windows.Forms.FormWindowState.Minimized)
                this.WindowState = System.Windows.Forms.FormWindowState.Normal;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.WindowState = System.Windows.Forms.FormWindowState.Minimized;
            showTip();
        }
        void showTip()
        {
            DataTable dt = DB.GetOverModule();
            if (dt != null && dt.Rows.Count > 0)
            {
                string modulaList = "";
                foreach (DataRow item in dt.Rows)
                {
                    string temp = Convert.ToString(item[0]).Split('|')[0];

                    modulaList += temp + ",";
                }
                modulaList = modulaList.TrimEnd(',');
                if (modulaList != "")
                {
                    //getWarnMoludaName
                    this.modulanotify.ShowBalloonTip(5000, "注意", modulaList + "二次元测试多次异常", ToolTipIcon.Warning);
                    label3.Text = modulaList + "二次元测试多次异常,上次扫描时间为:" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                }

            }

        }
        
        private void timer2_Tick(object sender, EventArgs e)
        {
            timer2.Stop();
            showTip();
            timer2.Start();

        }
    }
}

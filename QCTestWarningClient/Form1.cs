using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace QCTestWarningClient
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
            {

                this.WindowState = System.Windows.Forms.FormWindowState.Normal;
                // 获取当前工作区宽度和高度（工作区不包含状态栏）
                int ScreenWidth = Screen.PrimaryScreen.WorkingArea.Width;
                int ScreenHeight = Screen.PrimaryScreen.WorkingArea.Height;
                //计算窗体显示的坐标值，可以根据需要微调几个像素 
                int x = ScreenWidth - this.Width - 5;
                int y = ScreenHeight - this.Height - 5;
                this.Location = new Point(x, y);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.WindowState = System.Windows.Forms.FormWindowState.Minimized;
            showTip();
        }
        void showTip()
        {
            DataTable dt = DB.GetNotifyMessage();
            if (dt != null && dt.Rows.Count > 0)
            {
                dataGridView1.DataSource = dt;
            }
            dt = DB.GetNotifyMessage2();
            int j = 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                List<string> ModuleNameList = new List<string>();
                foreach (DataRow item in dt.Rows)
                {
                    j++;
                    string temp = Convert.ToString(item["工件"]);
                    if (j%8==0)
                    {
                        temp = temp + "\n\r";
                    }
                    if (!ModuleNameList.Contains(temp))
                    {
                        ModuleNameList.Add(temp);
                    }
                }

                if (ModuleNameList.Count > 0)
                {
                    //getWarnMoludaName
                    this.modulanotify.ShowBalloonTip(5000, "注意", string.Join(",", ModuleNameList) + "二次元测试多次异常", ToolTipIcon.Warning);
                    label3.Text = string.Join(",", ModuleNameList) + "二次元测试多次异常\n\r";
                }

            }
            else
            {
                label3.Text = "暂无信息";
            }
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            timer2.Stop();
            showTip();
            timer2.Start();

        }

        private void dataGridView1_RowStateChanged(object sender, DataGridViewRowStateChangedEventArgs e)
        {
            e.Row.HeaderCell.Value = string.Format("{0}", e.Row.Index + 1);
        }
    }
}
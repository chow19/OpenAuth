using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FunctionTest
{
    public partial class InputScanFloder : Form
    {
        public InputScanFloder()
        {
            InitializeComponent();
        }

        private void InputScanFloder_Load(object sender, EventArgs e)
        {
            string BaseFilePath = ConfigurationSettings.AppSettings["FloderPath"];
            textBox1.Text = BaseFilePath;
            BaseFilePath = ConfigurationSettings.AppSettings["FloderPathModule"];
            textBox2.Text = BaseFilePath;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SetConfigValue("FloderPath", textBox1.Text);
            SetConfigValue("FloderPathModule", textBox2.Text);
            MessageBox.Show("更新成功！");
        }

        /// <summary>
        /// 修改AppSettings中配置
        /// </summary>
        /// <param name="key">key值</param>
        /// <param name="value">相应值</param>
        public bool SetConfigValue(string key, string value)
        {
            try
            {
                Configuration config = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                if (config.AppSettings.Settings[key] != null)
                    config.AppSettings.Settings[key].Value = value;
                else
                    config.AppSettings.Settings.Add(key, value);
                config.Save(ConfigurationSaveMode.Modified);
                ConfigurationManager.RefreshSection("appSettings");
                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}

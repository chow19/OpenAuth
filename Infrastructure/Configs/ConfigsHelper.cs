using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Infrastructure.Configs
{
    public class Configs
    {
        /// <summary>
        /// 根据Key取Value值
        /// </summary>
        /// <param name="key"></param>
        public static string GetValue(string key)
        {
            return ConfigurationManager.AppSettings[key].ToString().Trim();
        }
         
    }
}

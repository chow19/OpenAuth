using NLog.Internal;
using System;
using System.Configuration;

namespace JobSchedule.Service
{

    public class ConstValue
    {
        public static double VoidMinute
        {
            get
            {
                var minuteConfig = System.Configuration.ConfigurationManager.AppSettings["VoidMinute"];
                if (!string.IsNullOrWhiteSpace(minuteConfig))
                {
                    return Convert.ToDouble(minuteConfig);
                }
                return 15;  //如果没有配置，默认返回15分钟
            }
        }

        public static int OffineIntervalInSeconds
        {
            get
            {
                var seconds = System.Configuration.ConfigurationManager.AppSettings["OffineIntervalInSeconds"];
                if (!string.IsNullOrWhiteSpace(seconds))
                {
                    return Convert.ToInt32(seconds);
                }
                return 60; //如果没有配置默认触发器一分钟触发一次
            }
        }

        public static int AutoVoidOrderIntervalInSeconds
        {
            get
            {
                var seconds = System.Configuration.ConfigurationManager.AppSettings["AutoVoidOrderIntervalInSeconds"];
                if (!string.IsNullOrWhiteSpace(seconds))
                {
                    return Convert.ToInt32(seconds);
                }
                return 60; //如果没有配置默认触发器一分钟触发一次
            }
        }

    }
}



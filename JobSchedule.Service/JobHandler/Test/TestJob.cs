using Quartz;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace JobSchedule.Service.JobHandler.Test
{
    public class TestJob : IJob
    {
        NLog.Logger log = NLog.LogManager.GetCurrentClassLogger();
        public void Execute(IJobExecutionContext context)
        {
            log.Info("启动测试一");

            Console.WriteLine(DateTime.Now+ ":启动测试一");
        }
    }
}

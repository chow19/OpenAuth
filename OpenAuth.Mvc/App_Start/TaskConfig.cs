using Quartz;
using Quartz.Impl;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenAuth.Mvc.App_Start
{
    public class TaskConfig
    {
        public TaskConfig() {
            ISchedulerFactory sf = new StdSchedulerFactory();
            IScheduler scheduler = sf.GetScheduler(); 
            IJobDetail job = JobBuilder.Create<OpenAuth.Mvc.Job.Job>().WithIdentity("job1", "mygroup").Build();

            ITrigger trigger = TriggerBuilder.Create().StartAt(DateTime.Now.AddSeconds(5)).WithCronSchedule("0 */1 * * * ?").Build();

            scheduler.ScheduleJob(job, trigger);
            scheduler.Start();
        }
    }
}
using JobSchedule.Service.JobHandler.Test;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quartz;

namespace JobSchedule.Service.Jobs.Test
{
    public class TestService : JobService<TestJob>
    {
        protected override string GroupName
        {
            get
            {
               return "GroupName测试一";
            }
        }

        protected override string JobName
        {
            get
            {
                return "JobName测试一";
            }
        }

        protected override ITrigger GetTrigger()
        {
            //时间配置规则如下：http://blog.csdn.net/lnara/article/details/8636656
            var trigger = TriggerBuilder.Create()
              .WithIdentity("抢购商品到期上下线", "作业触发器")
              .WithSimpleSchedule(x => x
                  .WithIntervalInSeconds(ConstValue.OffineIntervalInSeconds)
                  .RepeatForever())
              .Build();
            return trigger;
        }
    }
}

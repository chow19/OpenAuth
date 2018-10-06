using JobSchedule.Service.Jobs.Test;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;

namespace JobSchedule.Service
{
    public partial class job : ServiceBase
    {
        public job()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            //ScheduleBase.Scheduler.Start();

            //ScheduleBase.AddSchecule(new TestService());
        }

        protected override void OnStop()
        {
            ScheduleBase.Scheduler.Shutdown(true);
        }
    }
}

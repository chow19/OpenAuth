using Infrastructure;
using OpenAuth.App;
using OpenAuth.App.SSO;
using Quartz;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;

namespace OpenAuth.Mvc.Job
{
    public class Job : IJob
    {
        public TaskApp taskApp { get; set; }
        public void Execute(IJobExecutionContext context)
        {
            LogHelper.Debug(DateTime.Now + "开始执行JOB");

            var response = new Response();
            try
            {
                var task = taskApp.GetAllTaskTodo();
                string msg;
                bool flag;
                DateTime ds;
                DateTime de;
                foreach (var item in task)
                {
                    msg = "";
                    flag = false; ds = DateTime.Now;
                    if (item.TiggerType == 3)
                    { 
                        flag = JobHandlerUtil.Job(item.StoreName, out msg); 
                    }
                    else if (item.TiggerType == 2)
                    {

                    }
                    else if (item.TiggerType == 1)
                    {
                        //反射获取 命名空间+类名
                        string className = item.ClassName;
                        string methodName = item.StoreName;
                        //传递参数
                        Object[] paras = new Object[] { };
                        var t = Type.GetType(className);
                        object obj = Activator.CreateInstance(t);

                        try
                        {
                            #region 直接调用 
                            MethodInfo method = t.GetMethod(methodName);
                            object o = method.Invoke(obj, paras);
                            if (o.ToString() == "success")
                            {
                                flag = true;
                                msg = "";
                            }
                            else {
                                flag = false;
                                msg = o.ToString();
                            }

                            #endregion  
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }
                    de = DateTime.Now;
                    taskApp.UpdateResult(item.Id, msg, (de - ds).TotalMilliseconds, flag);
                }

            }
            catch (Exception ex)
            {

            }
        }
    }
}
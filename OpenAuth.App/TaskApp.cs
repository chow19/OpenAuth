using OpenAuth.App.Request;
using OpenAuth.App.Response;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OpenAuth.Repository.Domain;

namespace OpenAuth.App
{
    public class TaskApp : BaseApp<OpenAuth.Repository.Domain.Task>
    {
        /// <summary>
        /// 加载所有数据
        /// </summary>
        public TableData Load(PageReq request)
        {
            var task = UnitWork.Find<OpenAuth.Repository.Domain.Task>(t=>t.Id!="1")
                   .OrderBy(u => u.Id)
                   .Skip((request.page - 1) * request.limit)
                   .Take(request.limit);
            return new TableData
            {
                count = task.Count(),
                data = task,
            };
        }

        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="ids"></param>
        public void Del(string[] ids)
        {
            Repository.Delete(t => ids.Contains(t.Id));
        }

        public void Update(OpenAuth.Repository.Domain.Task entity)
        {
            if (!CheckData(entity))
            {
                return;
            }
            Repository.Update(u => u.Id == entity.Id, u => new OpenAuth.Repository.Domain.Task
            {
                ClassName = entity.ClassName,
                DataType = entity.DataType,
                DllName = entity.DllName,
                EndDateTime = entity.EndDateTime,
                Remark = entity.Remark, 
                StoreName = entity.StoreName,
                StoreParams = entity.StoreParams,
                TaskName = entity.TaskName,
                TaskType = entity.TaskType,
                TiggerType = entity.TiggerType,
                IsUse = entity.IsUse,
                Interval=entity.Interval
            });
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="entity"></param>
        public void Add(OpenAuth.Repository.Domain.Task entity)
        {
            if (!CheckData(entity))
            {
                return;
            }
            //if (entity.TiggerType==2)
            //{
                entity.LastTaskTime = entity.StartDateTime; 
            //}
            if (entity.StartDateTime<DateTime.Now)
            {
                entity.StartDateTime = DateTime.Now;
            }
            entity.NextTaskTime = getMulTime(entity.StartDateTime, entity.TaskType, entity.Interval);
            entity.SuccessCount = 0;
            entity.FailCount = 0;
            Repository.Add(entity);
        }

        private bool CheckData(Repository.Domain.Task entity)
        {
            if (entity.TaskType == 1)
            {
                if (string.IsNullOrEmpty(entity.ClassName)) throw new Exception("类名不能为空");
                if (string.IsNullOrEmpty(entity.DllName)) throw new Exception("DLL名不能为空");
            }
            else if (entity.TaskType == 2)
            {
                if (string.IsNullOrEmpty(entity.StoreName)) throw new Exception("存储过程不能为空");
            }
            else if (entity.TaskType ==3)
            {
                if (string.IsNullOrEmpty(entity.StoreName)) throw new Exception("链接不能为空");
            }
            else
            {
                throw new Exception("数据异常");
            }

            if (entity.StartDateTime > entity.EndDateTime) throw new Exception("开始时间不能大于结束时间");

            if (entity.DataType==6&&DateTime.Now<entity.StartDateTime) throw new Exception("时间周期类型为周，开始时间必须大于现在");

            if (entity.DataType>6||entity.DataType<=0) throw new Exception("数据异常");

            if (entity.DataType == 6 && (entity.DataType > 7 || entity.DataType <= 0)) throw new Exception("时间周期类型为周，只想选1～7");

            if (entity.Interval<0) throw new Exception("间隔必须大于0");
             
            return true;

        }

        /// <summary>
        /// 获取要执行所有任务
        /// </summary>
        /// <returns></returns>
        public List<OpenAuth.Repository.Domain.Task> GetAllTaskTodo()
        {
            return Repository.Find(t => t.NextTaskTime < DateTime.Now
                                        && t.IsUse == true
                                        && t.StartDateTime < DateTime.Now
                                        && t.EndDateTime > DateTime.Now
                                   ).ToList();
        }

        /// <summary>
        /// 更新返回结果,成功则更新下次执行时间
        /// </summary>
        /// <param name="TaskId"></param>
        public void UpdateResult(string TaskId, string Msg,double usedTime,  bool isSuccess = false)
        {
            var task = Repository.FindSingle(t => t.Id.Equals(TaskId));
            if (task == null)
            {
                return;
            }
            DateTime lsDateTime = task.LastTaskTime;
            switch (task.TiggerType)
            {
                case 1://周期触发
                    lsDateTime = getMulTime(lsDateTime, task.TaskType, task.Interval);
                    break;
                case 2://指定触发

                    break;
                default:
                    throw new Exception("触发类型错误");
            }

            Repository.Update(u => u.Id == TaskId, u => new OpenAuth.Repository.Domain.Task
            {
                LastTaskTime = lsDateTime,
                SuccessCount = isSuccess ? task.SuccessCount + 1 : task.SuccessCount,
                FailCount = isSuccess ? task.FailCount + 1 : task.FailCount,
                LastUseTime=Convert.ToDecimal( usedTime),
                ReturnMsg = Msg
            });
        }

        /// <summary>
        /// 获取下次执行时间
        /// </summary>
        /// <param name="lsDatetime"></param>
        /// <param name="DataType"></param>
        /// <returns></returns>
        private DateTime getMulTime(DateTime lsDatetime, int DataType, int interval)
        {

            //1年2月3日4时5分6周
            switch (DataType)
            {
                case 1:
                    lsDatetime = lsDatetime.AddYears(interval);
                    break;
                case 2:
                    lsDatetime = lsDatetime.AddMonths(interval);
                    break;
                case 3:
                    lsDatetime = lsDatetime.AddDays(interval);
                    break;
                case 4:
                    lsDatetime = lsDatetime.AddHours(interval);
                    break;
                case 5:
                    lsDatetime = lsDatetime.AddMinutes(interval);
                    break;
                case 6:
                    lsDatetime = lsDatetime.AddDays(7);
                    break;
            }
            return lsDatetime;
        }

    }
}

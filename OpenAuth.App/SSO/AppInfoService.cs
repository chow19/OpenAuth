using System;
using System.Linq;
using Infrastructure.Cache;

namespace OpenAuth.App.SSO
{
    public class AppInfoService : CacheProvider
    {
        public AppInfo Get(string appKey)
        {
            //可以从数据库读取
            return _applist.SingleOrDefault(u => u.AppKey == appKey);
        }

        private AppInfo[] _applist = new[]
        {
            new AppInfo
            {
                AppKey = "openauth",
                Icon = "/Areas/SSO/Content/images/logo.png",
                IsEnable = true,
                Remark = "基于DDDLite的权限管理系统",
                ReturnUrl = "http://localhost:8089",
                Title = "综合管理系统",
                CreateTime = DateTime.Now,
            } 
            ,new AppInfo {
                 AppKey = "mesqc",
                Icon = "/Areas/SSO/Content/images/logo.png",
                IsEnable = true,
                Remark = "MES质检管理移动端",
                ReturnUrl = "http://localhost:60089",
                Title = "AJD质检管理",
                CreateTime = DateTime.Now,
            }
        };
    }
}
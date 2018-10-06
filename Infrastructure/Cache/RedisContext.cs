using ServiceStack.Redis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Cache
{
    /// <summary>
    /// 
    /// </summary>
    public class RedisContext : ICacheContext
    {
        private static string RedisPath = System.Configuration.ConfigurationSettings.AppSettings["RedisPath"];
     
        static readonly object padlock = new object();

        private static PooledRedisClientManager _redisClient;

        public static IRedisClient getInstance()
        {
            if (_redisClient == null)
            {
                lock (padlock)
                {
                    if (_redisClient == null)
                    {
                        RedisClientInit();
                    }
                }
            }
            return _redisClient.GetClient() ;
        }

        static void RedisClientInit()
        {
            try
            {
                string[] readWriteHosts = new string[] { RedisPath };
                string[] readOnlyHosts = new string[] { RedisPath };
                _redisClient = new PooledRedisClientManager(readWriteHosts, readOnlyHosts,
                    new RedisClientManagerConfig
                {
                    MaxWritePoolSize = 5, // “写”链接池链接数 
                    MaxReadPoolSize = 5, // “读”链接池链接数 
                    AutoStart = true,
                });
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override T Get<T>(string key)
        {
          return getInstance().Get<T>("key");
        }

        public override bool Set<T>(string key, T t, DateTime expire)
        {
            
            return getInstance().Set<T>( key, t, expire);
        }

        public override bool Remove(string key)
        {

            return false;
        }

        public bool Save(IRedisClient client) {
            try
            {
                //保存到硬盘
                client.Save();
                //释放内存
                client.Dispose();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}

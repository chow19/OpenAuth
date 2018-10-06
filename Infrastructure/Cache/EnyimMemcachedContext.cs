// ***********************************************************************
// Assembly         : Infrastructure
// Author           : yubaolee
// Created          : 06-21-2016
//
// Last Modified By : yubaolee
// Last Modified On : 06-21-2016
// Contact : 
// File: EnyimMemcachedContext.cs
// ***********************************************************************


using System;
using Enyim.Caching;
using Enyim.Caching.Memcached;

namespace Infrastructure.Cache
{
    public sealed class EnyimMemcachedContext : ICacheContext
    {
        static readonly object padlock = new object();

        private static  MemcachedClient _memcachedClient ;

        public static MemcachedClient getInstance()
        {
            if (_memcachedClient == null)
            {
                lock (padlock)
                {
                    if (_memcachedClient == null)
                    {
                        MemClientInit();
                    }
                }
            }
            return _memcachedClient;
        }

        static void MemClientInit()
        {
            try
            {
                _memcachedClient = new MemcachedClient();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        } 

        public override T Get<T>(string key)
        {
            _memcachedClient = getInstance();
            return _memcachedClient.Get<T>(key);
        }

        public override bool Set<T>(string key, T t, DateTime expire)
        {
            _memcachedClient = getInstance();
            var data = _memcachedClient.Get(key);

            return _memcachedClient.Store(StoreMode.Set, key, t, expire);
        }

        public override bool Remove(string key)
        {
            _memcachedClient = getInstance();
            return _memcachedClient.Remove(key);
        }
    }
}
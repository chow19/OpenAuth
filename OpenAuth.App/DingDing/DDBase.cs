using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing
{
    public abstract class DDBase<T> where T: class ,new()
    { 
        /// <summary>
        /// HTTP请求URL参数
        /// </summary>
        internal MyDictionary otherParams;
        /// <summary>
        /// HTTP请求头参数
        /// </summary>
        private MyDictionary headerParams;

        private String httpMethod = "POST";
 
        public void AddHeaderParameter(string key, string value)
        {
            GetHeaderParameters().Add(key, value);
        }

        public MyDictionary GetHeaderParameters()
        {
            if (this.headerParams == null)
            {
                this.headerParams = new MyDictionary();
            }
            return this.headerParams;
        }
         
        public abstract void Validate();

        public abstract string GetParametersToJosn();

        public void SetHttpMethod(String httpMethod)
        {
            this.httpMethod = httpMethod;
        }

        public string GetHttpMethod()
        {
            return httpMethod;
        }
    }
}

using Infrastructure;
using OpenAuth.App.DingDing.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace OpenAuth.App.DingDing 
{
    public static class DDHelper
    {
        public static string GetCorpId() {
            return Infrastructure.Configs.Configs.GetValue("DINGDINGCorpId");
        }
        public static string CorpSecret()
        {
            return Infrastructure.Configs.Configs.GetValue("DINGDINGCorpSecret");
        }
        public static string GetAgentId()
        {
            return Infrastructure.Configs.Configs.GetValue("DINGDINGAgentId");
        }
        /// <summary>
        /// 获取Token
        /// </summary>
        /// <returns></returns> 
        public static string GetToken( )
        { 
            if (!string.IsNullOrEmpty( new Infrastructure.Cache.ObjCacheProvider<string>().GetCache("access_token")) )
            {
                return new Infrastructure.Cache.ObjCacheProvider<string>().GetCache("access_token");
            }
            string _CorpId = GetCorpId();
            string _CorpSecret = CorpSecret();
            var result = new Response<bool>();
            try
            {
                string url = string.Format("https://oapi.dingtalk.com/gettoken?corpid={0}&corpsecret={1}", _CorpId, _CorpSecret);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                TokenResultModel resModel = Newtonsoft.Json.JsonConvert.DeserializeObject<TokenResultModel>(response);
                if (resModel != null)
                {
                    if (resModel.errcode == 0)
                    {
                        result.Code = 200;

                        bool falg = new Infrastructure.Cache.ObjCacheProvider<string>().Create("access_token", resModel.access_token, DateTime.Now.AddSeconds(resModel.expires_in));
                        return resModel.access_token;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                return "";
            }

            return null;
        }

        /// <summary>
        /// 获取企业的jsticket
        /// </summary>
        /// <param name="accessToken"></param>
        /// <returns></returns>
        public static string GetJsApiTicket(string accessToken)
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/get_jsapi_ticket?access_token={0}", accessToken);
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                JSticketModel resModel = Newtonsoft.Json.JsonConvert.DeserializeObject<JSticketModel>(response);

                if (resModel != null)
                {
                    if (resModel.errcode == 0)
                    {
                        result.Code = 200;
                       return resModel.ticket;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                return "";
            }
            return null;
        }

        public static long GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return Convert.ToInt64(ts.TotalSeconds);
        }

        //public static string GetUserId(string accessToken, string code)
        //{
        //    string url = string.Format("https://oapi.dingtalk.com/user/getuserinfo?access_token={0}&code={1}", accessToken, code);
        //    try
        //    {
        //        string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
        //        UserIdModel model = Newtonsoft.Json.JsonConvert.DeserializeObject<UserIdModel>(response);

        //        if (model != null)
        //        {
        //            if (model.errcode == 0)
        //            {
        //                return model.userid;
        //            }
        //            else
        //            {
        //                throw new Exception(model.errmsg);
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw;
        //    }
        //    return string.Empty;
        //}

        //public static string GetUserDetailJson(string accessToken, string userId)
        //{
        //    string url = string.Format("https://oapi.dingtalk.com/user/get?access_token={0}&userid={1}", accessToken, userId);
        //    try
        //    {
        //        string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
        //        return response;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw;
        //    }
        //    return null;
        //}

        //public static UserDetailInfo GetUserDetail(string accessToken, string userId)
        //{
        //    string url = string.Format("https://oapi.dingtalk.com/user/get?access_token={0}&userid={1}", accessToken, userId);
        //    try
        //    {
        //        string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
        //        UserDetailInfo model = Newtonsoft.Json.JsonConvert.DeserializeObject<UserDetailInfo>(response);

        //        if (model != null)
        //        {
        //            if (model.errcode == 0)
        //            {
        //                return model;
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw;
        //    }
        //    return null;
        //}

        public static string SignTopRequest(IDictionary<string, string> parameters, string secret, string signMethod)
        {
            // 第一步：把字典按Key的字母顺序排序
            IDictionary<string, string> sortedParams = new SortedDictionary<string, string>(parameters, StringComparer.Ordinal);
            IEnumerator<KeyValuePair<string, string>> dem = sortedParams.GetEnumerator();

            // 第二步：把所有参数名和参数值串在一起
            StringBuilder query = new StringBuilder();
            query.Append(secret);

            while (dem.MoveNext())
            {
                string key = dem.Current.Key;
                string value = dem.Current.Value;
                if (!string.IsNullOrEmpty(key) && !string.IsNullOrEmpty(value))
                {
                    query.Append(key).Append(value);
                }
            }

            // 第三步：使用MD5/HMAC加密
            byte[] bytes;
            query.Append(secret);
            MD5 md5 = MD5.Create();
            bytes = md5.ComputeHash(Encoding.UTF8.GetBytes(query.ToString()));


            // 第四步：把二进制转化为大写的十六进制
            StringBuilder result = new StringBuilder();
            for (int i = 0; i < bytes.Length; i++)
            {
                result.Append(bytes[i].ToString("X2"));
            }

            return result.ToString();
        }
    }
}

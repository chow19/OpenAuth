using Infrastructure;
using OpenAuth.WebApi.App_Start.Atrribute;
using OpenAuth.WebApi.Areas.WEIXIN.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;

namespace OpenAuth.WebApi.Areas.WEIXIN.Controllers
{
    public class TokenController : ApiController
    {
        /// <summary>
        /// 获取Token
        /// </summary>
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetToken()
        {
            var result = new Response<bool>();
            result.Code = 200;
            result.Message =  GetToken("wx600d078fdb97e880", "bea2ad9ed3c7a5da1c45be47d2884f2d");
            return result;
        }
        /// <summary>
        /// 获取Token
        /// </summary>
        /// <returns></returns> 
        private  string GetToken(string _CorpId, string _CorpSecret)
        {
            if (!string.IsNullOrEmpty(new Infrastructure.Cache.ObjCacheProvider<string>().GetCache("access_token")))
            {
                return new Infrastructure.Cache.ObjCacheProvider<string>().GetCache("access_token");
            }
            var result = new Response<bool>();
            try
            {
                string url = string.Format("https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={0}&secret={1}", _CorpId, _CorpSecret);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                TokenResultModel resModel = Newtonsoft.Json.JsonConvert.DeserializeObject<TokenResultModel>(response);
                if (resModel != null)
                {
                    if (resModel.errcode == "0")
                    {
                        result.Code = 200;

                        new Infrastructure.Cache.ObjCacheProvider<string>().Create("access_token", resModel.access_token, DateTime.Now.AddSeconds(resModel.expires_in));
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

        //[HttpGet]
        //public HttpResponseMessage Check(string signature, string timestamp, string nonce, string echostr)
        //{
        //    Infrastructure.LogHelper.Log("测试输出: echostr = " + echostr);
        //    Infrastructure.LogHelper.Log("测试输出: nonce = " + nonce);
        //    Infrastructure.LogHelper.Log("测试输出: timestamp = " + timestamp);
        //    Infrastructure.LogHelper.Log("测试输出: signature = " + signature);

        //    string Token = System.Configuration.ConfigurationManager.AppSettings["wxToken"];
        //    //token = (token ?? );
        //    string[] value = (from z in new string[]
        //    {
        //        Token,
        //        timestamp,
        //        nonce
        //    }
        //                      orderby z
        //                      select z).ToArray<string>();
        //    string tmpStr = string.Join("", value);
        //    tmpStr = System.Web.Security.FormsAuthentication.HashPasswordForStoringInConfigFile(tmpStr, "SHA1");
        //    tmpStr = tmpStr.ToLower();
        //    if (tmpStr == signature)
        //    {
        //        if (!string.IsNullOrEmpty(echostr))
        //        {
        //            Infrastructure.LogHelper.Log("测试结果" + echostr);
        //            var response = Request.CreateResponse(HttpStatusCode.OK);
        //            response.StatusCode = HttpStatusCode.OK;
        //            response.Content = new StringContent(echostr);
        //            return response;
        //        }
        //    }
        //    Infrastructure.LogHelper.Log("测试结果为空");
        //    var response2 = Request.CreateResponse(HttpStatusCode.OK);
        //    response2.StatusCode = HttpStatusCode.OK;
        //    response2.Content = new StringContent(echostr);
            
        //    return response2;
        //}
         
        [System.Web.Mvc.HttpPost]
        public HttpResponseMessage Index() {
           Infrastructure.LogHelper.Log("Index 访问时间： " + DateTime.Now.ToString("yyyy-MM-dd"));
   
            string xml = string.Format(
                  "<xml>" +
                          "<ToUserName>< ![CDATA[touser] ]></ToUserName>" +
                          "<FromUserName><![CDATA[{1}]]></FromUserName>" +
                          "<CreateTime>{2}</CreateTime>" +
                          "<MsgType>< ![CDATA[transfer_customer_service] ]></MsgType>" +
                          "</xml>",
                  "wx600d078fdb97e880", "DuoNeJo", DateTime.Now.Ticks);
            var response2 = Request.CreateResponse(HttpStatusCode.OK);
            response2.StatusCode = HttpStatusCode.OK;
            response2.Content = new StringContent(xml);

            return response2;
        }

         
    }
}
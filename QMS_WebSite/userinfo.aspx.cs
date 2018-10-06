using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class userinfo : System.Web.UI.Page
    {
        Common.HttpHelper _helper = new Common.HttpHelper(System.Configuration.ConfigurationManager.AppSettings["SSOPassport"]);
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "text/json";
           // Response.Write("{\"result\":0,\"msg\":\"获取成功\",\"username\":\"通用帐号\",\"dept\":\"--\"}");
            Response.Write("{\"result\":0,\"msg\":\"获取成功\",\"username\":\"张大明\",\"dept\":\"研发部\"}");
            Response.End();
            return;
            try
            { 
                string token = Convert.ToString(Request.QueryString["sessionStr"]);
                string ApiUri = "/api/Check/GetUserAndDeptName";
                Dictionary<string, string> dic = new Dictionary<string, string>();
                dic.Add("token", token);
                string Value = _helper.Get(dic, ApiUri);
                MyResponse res = Common.JsonHelper.Instance.Deserialize<MyResponse>(Value);
                if (res.Code == 200)
                {
                    Response.ContentType = "text/json";
                    Response.Write("{\"result\":0,\"msg\":\"获取成功\",\"username\":\""+res.Message.Split('|')[0]+"\",\"dept\":\""+ res.Message.Split('|')[1] + "\"}");
                }
                else
                {
                    Response.ContentType = "text/json";
                    Response.Write("{\"result\":500,\"msg\":\""+res.Message+"\",\"username\":\"\",\"dept\":\"\"}");
                } 
            }
            catch (Exception)
            {
                Response.Clear();
                Response.ContentType = "text/json";
                Response.Write("{\"result\":500,\"msg\":\"获取失败\",\"username\":\"\",\"dept\":\"\"}");
            }

        }

        public class MyResponse
        {
            /// <summary>
            /// 操作消息【当Status不为 200时，显示详细的错误信息】
            /// </summary>
            public string Message { get; set; }

            /// <summary>
            /// 操作状态码，200为正常
            /// </summary>
            public int Code { get; set; }

            public MyResponse()
            {
                Code = 200;
                Message = "操作成功";
            }
        }
    }
}
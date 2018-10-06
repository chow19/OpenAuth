using QMS_WebSite.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMS_WebSite
{
    public partial class login : System.Web.UI.Page
    {
       HttpHelper _helper = new HttpHelper(ConfigurationManager.AppSettings["SSOPassport"]);
       
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "text/json";
            Response.Write("{\"result\":0,\"msg\":\"登录成功\",\"sessionStr\":\"COMMON\"}"); 
            Response.End();
            return;
            try
            {
                string Token = "";
                if (CacheHelper.GetCache("Token") == null)
                {
                    string UserId = Convert.ToString(Request.QueryString["UserId"]);
                    string Password = Convert.ToString(Request.QueryString["Password"]);
                    string ApiUri = "/api/Check/Login";
                    string Value = _helper.Post(new { Account = UserId, Password = Password, AppKey = "mesqc" }, ApiUri);
                    LoginResult loginResult = JsonHelper.Instance.Deserialize<LoginResult>(Value);
                    if (loginResult.Code == 200)
                    {
                        CacheHelper.SetCache("Token", loginResult.Token, 7000);
                        Token = loginResult.Token;
                    }
                    else {
                        Response.ContentType = "text/json";
                        Response.Write("{\"result\":500,\"msg\":\"登录失败\",\"sessionStr\":\"123456\"}");
                        Response.End();
                    } 
                }
                else {
                    Token = CacheHelper.GetCache("Token").ToString(); 
                }  
                Response.ContentType = "text/json";
                Response.Write("{\"result\":0,\"msg\":\"登录成功\",\"sessionStr\":\""+Token+"\"}");

            }
            catch (Exception)
            {
                Response.ContentType = "text/json";
                Response.Write("{\"result\":500,\"msg\":\"登录失败\",\"sessionStr\":\"123456\"}");
            } 

        }


        public class LoginResult  
        {
            public string ReturnUrl;
            public string Token;
            public string Message;
            public int Code;
        }
    }
}
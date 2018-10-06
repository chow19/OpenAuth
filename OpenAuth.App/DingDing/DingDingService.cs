
using Infrastructure;
using OpenAuth.App.DingDing.Dept.Request;
using OpenAuth.App.DingDing.Dept.Respon;
using OpenAuth.App.DingDing.Model;
using OpenAuth.App.DingDing.User.Request;
using OpenAuth.App.DingDing.User.Response;
using OpenAuth.Repository.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using OpenAuth.App.DingDing.Message.Response;

namespace OpenAuth.App.DingDing
{
    public class DingDingService
    {
        //public static DingDingService Instance = new DingDingService();


        /// <summary>
        /// 获取AccessToken
        /// 开发者在调用开放平台接口前需要通过CorpID和CorpSecret获取AccessToken。
        /// </summary>
        /// <returns></returns>
        public string GetAccessToken()
        {
            return DDHelper.GetToken();
        }

        public string GetJsApiTicket(string accessToken)
        {
            return DDHelper.GetJsApiTicket(accessToken);
        }

        public string GetSign(string ticket, string nonceStr, long timeStamp, string url)
        {
            String plain = string.Format("jsapi_ticket={0}&noncestr={1}&timestamp={2}&url={3}", ticket, nonceStr, timeStamp, url);

            try
            {
                byte[] bytes = Encoding.UTF8.GetBytes(plain);
                byte[] digest = SHA1.Create().ComputeHash(bytes);
                string digestBytesString = BitConverter.ToString(digest).Replace("-", "");
                return digestBytesString.ToLower();
            }
            catch (Exception e)
            {
                throw;
            }
        }

        #region 用户管理   
        public Other_UserManageApp _OtherUserApp { get; set; }

        public CreateUserResponse CreateUser(CreateUserRequest model)
        {
            try
            {
                string url = string.Format("https://oapi.dingtalk.com/user/create?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, model.GetParametersToJosn());
                CreateUserResponse res = response.ToObject<CreateUserResponse>();
                if (res.Errcode == 0)
                {
                    _OtherUserApp.SetStatus(res.Userid, res.Userid, true);
                }
                else
                {
                    _OtherUserApp.SetStatus(model.Userid, res.Errmsg, false);
                }
                return res;
            }
            catch (Exception ex)
            {
                _OtherUserApp.SetStatus("", ex.Message, false);
                return null;
            }
        }

        public UpdateUserResponse UpdateUser(UpdateUserRequest model)
        {
            try
            {
                string url = string.Format("https://oapi.dingtalk.com/user/update?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, model.GetParametersToJosn());
                UpdateUserResponse res = response.ToObject<UpdateUserResponse>();
                if (res.Errcode == 0)
                {
                    _OtherUserApp.SetStatus(model.Userid, res.Errmsg, true);
                }
                else
                {
                    _OtherUserApp.SetStatus(model.Userid, res.Errmsg, false);
                }
                return res;
            }
            catch (Exception ex)
            {
                _OtherUserApp.SetStatus(model.Userid, ex.Message, false);
                return null;
            }
        }

        public UserDeleteResponse DelUser(UserDeleteRequest model)
        {
            try
            {
                string url = string.Format("https://oapi.dingtalk.com/user/delete?access_token={0}&userid={1}", DDHelper.GetToken(), model.Userid);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                UserDeleteResponse res = response.ToObject<UserDeleteResponse>();
                if (res.Errcode == 0)
                {
                    _OtherUserApp.SetStatus(model.Userid, res.Errmsg, true);
                }
                else
                {
                    _OtherUserApp.SetStatus(model.Userid, res.Errmsg, false);
                }
                return res;
            }
            catch (Exception ex)
            {
                _OtherUserApp.SetStatus(model.Userid, ex.Message, false);
                return null;
            }
        }

        public GetUserResponse GetUser(GetUserRequest model)
        {
            try
            {
                string url = string.Format("https://oapi.dingtalk.com/user/get?access_token={0}&userid={1}", DDHelper.GetToken(), model.Userid);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                GetUserResponse res = response.ToObject<GetUserResponse>();
                return res;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public GetUserListResponse GetUserList(GetUserListRequest model)
        {
            try
            {
                string url = string.Format("https://oapi.dingtalk.com/user/list?access_token={0}&department_id={1}", DDHelper.GetToken(), model.DepartmentId);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);

                GetUserListResponse res = response.ToObject<GetUserListResponse>();
                return res;
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        #endregion
        //public string GetUserId(string accessToken, string code)
        //{
        //    return DDHelper.GetUserId(accessToken, code);
        //}

        //public string GetUserDetailJson(string accessToken, string userId)
        //{
        //    return DDHelper.GetUserDetailJson(accessToken, userId);
        //}

        //public UserDetailInfo GetUserDetailFromJson(string jsonString)
        //{
        //    UserDetailInfo model = Newtonsoft.Json.JsonConvert.DeserializeObject<UserDetailInfo>(jsonString);

        //    if (model != null)
        //    {
        //        if (model.errcode == 0)
        //        {
        //            return model;
        //        }
        //    }
        //    return null;
        //}

        #region 部门相关
        public OrgManagerApp _Orgapp { get; set; }
        public void DDCreateDept(CreateDeptRequest model)
        {
            try
            {
                string Url = string.Format("https://oapi.dingtalk.com/department/create?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(Url, model.GetParametersToJosn());
                CreateDeptRespon res = response.ToObject<CreateDeptRespon>();
                if (res.Errcode == 0)
                {
                    _Orgapp.SetStatus(model.SourceIdentifier, 0, res.Id.ToString(), true);
                }
                else
                {
                    _Orgapp.SetStatus(model.SourceIdentifier, 1, res.Errmsg, false);
                }
            }
            catch (Exception ex)
            {
                _Orgapp.SetStatus(model.SourceIdentifier, 2, ex.Message, false);
            }
        }

        public void DDUpdateDept(UpdateDeptRequest model)
        {
            try
            {
                string Url = string.Format("https://oapi.dingtalk.com/department/update?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(Url, model.GetParametersToJosn());
                CreateDeptRespon res = response.ToObject<CreateDeptRespon>();
                if (res.Errcode == 0)
                {
                    _Orgapp.SetStatus(model.SourceIdentifier, 0, res.Id.ToString(), true);
                }
                else
                {
                    _Orgapp.SetStatus(model.SourceIdentifier, 1, res.Errmsg, false);
                }
            }
            catch (Exception ex)
            {
                _Orgapp.SetStatus(model.SourceIdentifier, 2, ex.Message, false);
            }
        }

        public void DDDelDept(DelDeptRequest model)
        {
            try
            {
                string Url = string.Format("https://oapi.dingtalk.com/department/delete?access_token={0}&id={1}", DDHelper.GetToken(), model.Id);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(Url);
                CreateDeptRespon res = response.ToObject<CreateDeptRespon>();
                if (res.Errcode == 0)
                {
                    _Orgapp.SetStatus(model.Id, 0, res.Id.ToString(), true);
                }
                else
                {
                    _Orgapp.SetStatus(model.Id, 1, res.Errmsg, false);
                }
            }
            catch (Exception ex)
            {
                _Orgapp.SetStatus(model.Id, 2, ex.Message, false);
            }
        }

        public GetDeptRespon DDGetDept(DelDeptRequest model)
        {
            try
            {
                string Url = string.Format("https://oapi.dingtalk.com/department/get?access_token={0}&id={1}", DDHelper.GetToken(), model.Id);
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(Url);
                GetDeptRespon res = response.ToObject<GetDeptRespon>();
                return res;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public GetDeptListRespon DDGetAllDept()
        {
            try
            {
                GetDeptRequest r = new GetDeptRequest();
                r.Id = "1";
                string Url = string.Format("https://oapi.dingtalk.com/department/list?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(Url, r.ToJson(), false);
                GetDeptListRespon res = response.ToObject<GetDeptListRespon>();
                return res;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

        #region 发送消息
        public MessageApp messageApp { get; set; }
        public MessageCorpconversationSendResponse SendMsg(OpenAuth.Repository.Domain.Message message)
        {

            try
            {
                Message.Request.MessageCorpconversationSendRequest req = new Message.Request.MessageCorpconversationSendRequest();
                req.AgentId = Ext.ToLong(DDHelper.GetAgentId());
                req.ToUser = message.RecieveUsers.Replace(",", "|");
                req.MessageType = ((Message.Request.MessageCorpconversationSendRequest.MessageTypeDomain)(message.MsgType)).ToString();

                req.textMessage = new Message.Request.MessageCorpconversationSendRequest.TextDomain
                {
                    content = message.MsgContent
                };
                string Url = string.Format("https://oapi.dingtalk.com/message/send?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(Url, req.GetParametersToJosn());
                MessageCorpconversationSendResponse res = response.ToObject<MessageCorpconversationSendResponse>();
                if (res.Errcode == 0)
                {
                    messageApp.UpdateToRecevice(new string[] { message.Id });
                }
                else
                {
                    messageApp.UpdateToReceviceErrMsg(message.Id, res.Errmsg);
                }
                return res;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public MessageCorpconversationAsyncsendV2Response SendAsynMsg(OpenAuth.Repository.Domain.Message message)
        { 
            try
            {
                Message.Request.MessageCorpconversationAsyncsendV2Request req = new Message.Request.MessageCorpconversationAsyncsendV2Request();
                req.AgentId = Ext.ToLong(DDHelper.GetAgentId());
                req.ToAllUser = false;
                req.UseridList = message.RecieveUsers;
                var msg = new Message.Request.MessageCorpconversationAsyncsendV2Request.MsgDomain();
                msg.text = new Message.Request.MessageCorpconversationAsyncsendV2Request.TextDomain();
                msg.text.content = message.MsgContent;
                msg.msgtype = "text"; 
                req.Msg = msg; 
                string Url = string.Format("https://oapi.dingtalk.com/topapi/message/corpconversation/asyncsend_v2?access_token={0}", DDHelper.GetToken());
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(Url, req.GetParametersToJosn());
                MessageCorpconversationAsyncsendV2Response res = response.ToObject<MessageCorpconversationAsyncsendV2Response>();
                if (res.Errcode == 0)
                {
                    messageApp.UpdateToRecevice(new string[] { message.Id });
                }
                else
                {
                    messageApp.UpdateToReceviceErrMsg(message.Id, res.Errmsg);
                }
                return res;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

    }
}

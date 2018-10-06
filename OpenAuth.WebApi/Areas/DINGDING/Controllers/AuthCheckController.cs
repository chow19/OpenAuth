using Infrastructure;
using OpenAuth.App.DingDing;
using OpenAuth.WebApi.Areas.DINGDING.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Http;

namespace OpenAuth.WebApi.Areas.DINGDING.Controllers
{
    public class AuthCheckController : ApiCommonController
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
            result.Message = DDHelper.GetToken();
            return result;
        }

        /// <summary>
        /// 获取企业的jsticket
        /// </summary>
        /// <param name="accessToken"></param>
        /// <returns></returns>
        public Response<bool> GetJsApiTicket(string accessToken)
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
                        result.Message = resModel.ticket;
                    }
                }
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取Singnature签戳
        /// </summary>
        /// <param name="url"></param>
        /// <param name="nonce"></param>
        /// <param name="timeStamp"></param>
        /// <param name="ticket"></param>
        /// <returns></returns>
        public Response<bool> GetJsApiSingnature(string url, string nonce, Int64 timeStamp, string ticket)
        {
            string plain = string.Format("jsapi_ticket={0}&noncestr={1}&timestamp={2}&url={3}", ticket, nonce, timeStamp, url);
            var result = new Response<bool>();
            try
            {
                byte[] bytes = Encoding.UTF8.GetBytes(plain);
                byte[] digest = SHA1.Create().ComputeHash(bytes);
                string digestBytesString = BitConverter.ToString(digest).Replace("-", "");
                result.Code = 200;
                result.Message = digestBytesString.ToLower();
                return result;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取通讯录权限
        /// </summary>
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetAuthscopes(string userid)
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/auth/scopes?access_token={0}", _accessToken);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        #region 用户管理
        /// <summary>
        /// 根据用户ID获取信息
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetUerInfoByUserid(string userid)
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/user/get?access_token={0}&userid={1}", _accessToken, userid);
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }


            return result;
        }

        /// <summary>
        /// 创建用户
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> CreateUser()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/user/create?access_token={0}", _accessToken);
            int[] dept = { 70169609 };

            var data = new
            {
                name = "张三",
                department = dept,
                mobile = "13980442541"
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 删除用户
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> DeleteUser(string Userid)
        {

            var result = new Response<bool>();
#if !DEBUG
            return result;
#endif

            string url = string.Format("https://oapi.dingtalk.com/user/delete?access_token={0}&userid={1}", _accessToken, Userid);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 根据部门获取用户简单信息
        /// </summary>
        /// <param name="DeptId"></param>
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetSimpleUserlistByDeptId(string DeptId)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/user/simplelist?access_token={0}&department_id={1}", _accessToken, DeptId);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 根据部门获取用户详细信息
        /// </summary>
        /// <param name="DeptId"></param>
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetUserlistByDeptId(string DeptId)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/user/list?access_token={0}&department_id={1}", _accessToken, DeptId);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取管理员列表
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetManageUserlist()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/user/get_admin?access_token={0}", _accessToken);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 查询管理员是否具备管理某个应用的权限
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetManageUserlist(string AppId, string userId)
        {
            AppId = _AgentId;
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/user/can_access_microapp?access_token={0}&appId={1}&userId={2}", _accessToken, AppId, userId);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }
        #endregion

        #region 部门管理 

        /// <summary>
        /// 获取子部门Id列表
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetDeptChildlist()
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/department/list_ids?access_token={0}&id=1", _accessToken);

            var data = new { id = "1" };
            try
            {//
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson().ToString(), false);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;

        }

        /// <summary>
        /// 获取子部门Id列表
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetDeptlist()
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/department/list?access_token={0}", _accessToken);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取子部门Id列表
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetDeptInfo(string DeptId)
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/department/get?access_token={0}&id={1}", _accessToken, DeptId);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 创建部门
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> CreateDept()
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/department/create?access_token={0}", _accessToken);
            var data = new
            {
                name = "测试部门",
                parentid = "1",
                order = "1",
                createDeptGroup = true,
                deptHiding = true,
                userPerimits = "196406073621622504",
                outerDept = true,
                sourceIdentifier = "testsource"
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 创建部门
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> CreateDept(string did)
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/department/list_parent_depts_by_dept?access_token={0}&id={1}", _accessToken, did);
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 查询指定用户的所有上级父部门Id路径
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetUpDeptIdByUserId(string userId)
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/department/list_parent_depts?access_token={0}&userId={1}", _accessToken, userId);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }


        /// <summary>
        /// 获取在线员工数
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> GetOrgUserCount()
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/user/get_org_user_count?access_token={0}&onlyActive=0", _accessToken);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }


        #endregion

        #region 消息

        /// <summary>
        /// 创建群会话
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> CreateChat()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/chat/create?access_token={0}", _accessToken);
            string[] useridlist = { "17655214301730309841", "196406073621622504" };

            var data = new
            {
                name = "接口创建的群",
                owner = "s",
                useridlist = useridlist
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 发送群消息
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> SendChat(string chatid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/chat/send?access_token={0}", _accessToken);
            var card = new
            {
                title = "测试内容。。。",
                markdown = "正文内容-想你所想",
                single_title = "查看详情",
                single_url = "https://www.baidu.com",
                agentid = _AgentId
            };
            var data = new
            {
                chatid = chatid,
                msgtype = "action_card",
                action_card = card
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 查询群消息已读人员列表
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpGet]
        public Response<bool> getReadList(string messageId, string next_cursor = "0")
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/chat/getReadList?access_token={0}&messageId={1}&cursor={2}&size={3}", _accessToken, HttpUtility.UrlEncode(messageId), next_cursor, 100);

            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }


        /// <summary>
        /// 发送普通信息
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> SendConversation(string cid, string uid, string contentMsg)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/message/send_to_conversation?access_token={0}", _accessToken);

            var ct = new { content = HttpUtility.UrlEncode(contentMsg) };
            var data = new
            {
                sender = uid,//"17655214301730309841" 
                cid = HttpUtility.UrlEncode(cid),
                msgtype = "text",
                text = ct
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 企业通知消息
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> corpconversation(string cid, string uid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/message/corpconversation/asyncsend_v2?access_token={0}", _accessToken);
            string[] useridlist = { "17655214301730309841", "196406073621622504" };

            var card = new
            {
                title = "测试内容。。。",
                markdown = "正文内容-该条信息为接口测试内容，如收到请忽略",
                single_title = "查看详情",
                single_url = "https://www.baidu.com",
                agentid = _AgentId
            };
            var remsg = new
            {
                msgtype = "action_card",
                action_card = card
            };
            var data = new
            {
                agent_id = _AgentId,
                userid_list = useridlist,//"17655214301730309841" 
                to_all_user = true,
                msg = remsg
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 企业通知消息结果
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> corpconversationResult(string taskid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/message/corpconversation/getsendresult?access_token={0}", _accessToken);

            var data = new
            {
                agent_id = _AgentId,
                task_id = taskid
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        [System.Web.Mvc.HttpPost]
        public Response<bool> MessageSend()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/message/send?access_token={0}", _accessToken);

            var card = new
            {
                title = "测试内容。。。",
                markdown = "正文内容-该条信息为接口测试内容，如收到请忽略",
                single_title = "查看详情",
                single_url = "https://www.baidu.com"
            };

            var data = new
            {
                touser = "17655214301730309841",
                toparty = "",
                agentid = _AgentId,
                msgtype = "action_card",
                action_card = card
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }


        #endregion

        #region 审批
        /// <summary>
        /// 创建流程示例
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> CreateProcess(string uid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/processinstance/create?access_token={0}", _accessToken);
            int dept = 70169609;

            StringBuilder sb = new StringBuilder();
            sb.Append("[");
            //var formvalues = new { name = HttpUtility.UrlEncode("单行输入框"), value = HttpUtility.UrlEncode("表单内容") };
            //sb.Append(formvalues.ToJson()+",");
            //formvalues = new { name = HttpUtility.UrlEncode("数字输入框"), value = HttpUtility.UrlEncode("100.3") };
            //sb.Append(formvalues.ToJson() + ",");
            //formvalues = new { name = HttpUtility.UrlEncode("单选框"), value = HttpUtility.UrlEncode("xx12") };
            //sb.Append(formvalues.ToJson() + ",");
            var formvalues = new { name = HttpUtility.UrlEncode("测试"), value = HttpUtility.UrlEncode("100.3") };
            sb.Append(formvalues.ToJson());
            sb.Append("]");

            var data = new
            {
                agent_id = _AgentId,
                process_code = "PROC-QIYJHDLV-Z2ZWIW1ZUS5462PB8B3K3-7C5QDSJJ-C1",
                originator_user_id = uid,
                dept_id = dept,
                approvers = "196406073621622504",
                form_component_values = sb.ToString().ToJson()
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取流程示例
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetProcessIntance(string pid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/processinstance/get?access_token={0}", _accessToken);

            var data = new
            {
                process_instance_id = pid
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 用户待签核数据
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetProcessIntancetodonum(string userid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/process/gettodonum?access_token={0}", _accessToken);

            var data = new
            {
                userid = userid
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取流程示例
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetProcessIntanceList(string pid, string start_time,string userid)
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/processinstance/list?access_token={0}", _accessToken);
            string[] userlist = { userid };
            var data = new
            {
                process_code = pid,
                start_time =start_time,
                end_time = (DateTime.Now.ToUniversalTime().Ticks - 621355968000000000) / 10000,
               // userlist = userlist
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        ///获取审批实例列表 
        public Response<bool> GetProcessIntanceList2(string pid, string start_time,string userid)
        {
            var result = new Response<bool>();
             
            string url = "https://eco.taobao.com/router/rest";

             string[] userlist = { userid };
            Dictionary<string, string> diclist = new Dictionary<string, string>();
            diclist.Add("method", "dingtalk.smartwork.bpms.processinstance.list");
            
            diclist.Add("session", _accessToken);
            diclist.Add("app_key", DDHelper.GetAgentId());
            diclist.Add("timestamp", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            diclist.Add("format", "json");
            diclist.Add("v", "2.0");
            diclist.Add("sign_method", "md5");
            diclist.Add("process_code", "pid");
            diclist.Add("userlist", userlist.ToJson());
            diclist.Add("start_time", start_time);
            diclist.Add("end_time",((DateTime.Now.ToUniversalTime().Ticks - 621355968000000000) / 10000).ToString()); 
            //diclist.Add("access_token", _accessToken);
            
            string sign = DDHelper.SignTopRequest(diclist, DDHelper.CorpSecret(), "md5");
            diclist.Add("sign", sign);

            diclist= diclist.OrderBy(o => o.Key).ToDictionary(o => o.Key, p => p.Value.ToString());//对key进行升序
            //遍历元素
            //var data = new
            //{
            //    method = "dingtalk.smartwork.bpms.processinstance.list",
            //    app_key = DDHelper.GetAgentId(),
            //    timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
            //    format = "json",
            //    v = "2.0",
            //    sign_method = "md5",
            //    process_code = pid,
            //    start_time = start_time
            //    //end_time = DateTime.Now.Ticks,
            //    // userlist = userlist//080937632339701427
            //};
            string req = "";
            int count = 0;
            foreach (var item in diclist)
            {
                count++;
                if (count == diclist.Count)
                {
                    req += item.Key + "=" + item.Value ;
                }
                else {
                    req += item.Key + "=" + item.Value + "&";
                }
              
            }
            
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url+"?"+ req, diclist.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        #endregion

        #region 考勤 

        /// <summary>
        /// 企业考勤排班详情
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetListSchedule()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/attendance/listschedule?access_token={0}", _accessToken);

            var data = new
            {
                workDate = DateTime.Now.ToString("yyyy-MM-dd")
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 企业考勤排班详情
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetSimpleGroups()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/topapi/attendance/getsimplegroups?access_token={0}", _accessToken);
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequest(url, "", Encoding.GetEncoding("UTF-8"), true);
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 打卡详细
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetlistRecord()
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/attendance/listRecord?access_token={0}", _accessToken);
            string[] userlist = { "17655214301730309841" };
            var data = new
            {
                userIds = userlist,
                checkDateFrom = DateTime.Now.AddDays(-5).ToString("yyyy-MM-dd hh:mm:ss"),
                checkDateTo = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"),
                isI18n = "false"
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 打卡结果
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetlistRecordResult()
        {
            var result = new Response<bool>();

            string url = string.Format("https://oapi.dingtalk.com/attendance/listRecord?access_token={0}", _accessToken);

            List<string> userlist = new List<string>();
            userlist.Add("17655214301730309841");
            var data = new
            {
                userIdList = userlist.ToJson().ToString(),
                workDateFrom = DateTime.Now.AddDays(-30).ToString("yyyy-MM-dd hh:mm:ss"),
                workDateTo = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss"),
                offset = 0,
                limit = 1
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }

        /// <summary>
        /// 获取考勤组
        /// </summary> 
        /// <returns></returns>
        [System.Web.Mvc.HttpPost]
        public Response<bool> GetUserGroup()
        {
            var result = new Response<bool>();
            string url = string.Format("https://oapi.dingtalk.com/topapi/attendance/getusergroup?access_token={0}", _accessToken);
            var data = new
            {
                userid = "17655214301730309841"
            };
            try
            {
                string response = Infrastructure.Web.WebHelper.HttpWebRequestJson(url, data.ToJson());
                result.Code = 200;
                result.Message = response;
            }
            catch (Exception ex)
            {
                result.Code = 500;
                result.Message = ex.Message;
            }
            return result;
        }


        #endregion
    }
}

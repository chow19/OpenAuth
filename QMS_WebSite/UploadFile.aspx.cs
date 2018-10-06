using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;

namespace QMS_WebSite
{
    public partial class UploadFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                if (Request.Form["images"] == null)
                    return;

                if (Request.Form["filetype"] == null)
                    return;

                string ExtNo = Convert.ToString(Request.Form["ExtNo"]);
                     
                string encodedString = Convert.ToString(Request.Form["images"]).Replace("data:image/jpeg;base64,", "");

                string filetype = Convert.ToString(Request.Form["filetype"]);
                //image/jpg', 'image/jpeg', 'image/png', 'image/gif
                switch (filetype.ToLower())
                {
                    case "image/jpg":
                        filetype = ".jpg";
                        break;
                    case "image/jpeg":
                        filetype = ".jpeg";
                        break;
                    case "image/png":
                        filetype = ".png";
                        break;
                    case "image/gif":
                        filetype = ".gif";
                        break;
                    default:
                        Response.Write("{\"result\":1,\"msg\":\"请上传图片\"}");
                        break;
                }

                byte[] bytes = Convert.FromBase64String(encodedString);

                System.IO.Stream s = new System.IO.MemoryStream(bytes);
                Image image = Image.FromStream(s);
                string AtterFileName = DateTime.Now.ToString("yyyMMddHHmmss") + DateTime.Now.Millisecond + filetype;
                image.Save(Server.MapPath("/upload/" + AtterFileName));

                UploadFtp(Request.PhysicalApplicationPath + "\\upload\\" + AtterFileName);

                Response.Write("{\"result\":0,\"msg\":\"" + AtterFileName + "\"}");
                //string AtterFileName = string.IsNullOrEmpty(ExtNo) ? DateTime.Now.ToString("yyyMMddHHmmss") + DateTime.Now.Millisecond + filetype : ExtNo + "-" + DateTime.Now.ToString("yyyMMddHHmmss") + DateTime.Now.Millisecond + filetype;
                //string FloderPath = "\\upload\\" + DateTime.Now.ToString("yyyyMMdd") + "\\";
                //if (Directory.Exists(Request.PhysicalApplicationPath + FloderPath))
                //{
                //    Directory.CreateDirectory(Request.PhysicalApplicationPath + FloderPath);
                //}
                //image.Save(Server.MapPath(FloderPath.Replace("\\", "/") + AtterFileName));

                //UploadFtp(Request.PhysicalApplicationPath + FloderPath + AtterFileName);

                //Response.Write("{\"result\":0,\"msg\":\"" + AtterFileName + "\",\"DefaultPath\":\"" + FloderPath + AtterFileName + "\"}");
            }
            catch (Exception ex)
            {
                Response.Write("{\"result\":1,\"msg\":\"" + ex.Message + "\"}");
            }


        }

        /// <summary>
        /// 读取byte[]并转化为图片
        /// </summary>
        /// <param name="bytes">byte[]</param>
        /// <returns>Image</returns>
        public static Image GetImageByBytes(byte[] bytes)
        {
            Image photo = null;
            using (MemoryStream ms = new MemoryStream(bytes))
            {
                ms.Write(bytes, 0, bytes.Length);
                photo = Image.FromStream(ms, true);
            }

            return photo;
        }




        //filename 为本地文件的绝对路径
        //serverDir为服务器上的目录
        private void UploadFtp(string filename )
        {
            string ftpServerIP = ConfigurationSettings.AppSettings["ftpServerIP"];//服务器ip
            string ftpUserID = ConfigurationSettings.AppSettings["ftpUserID"];//用户名
            string ftpPassword = ConfigurationSettings.AppSettings["ftpPassword"];//密码
            string serverDir = ConfigurationSettings.AppSettings["MES_FTP"];
            FileInfo fileInf = new FileInfo(filename);
            string uri = string.Format("ftp://{0}/{1}/{2}", ftpServerIP, serverDir, fileInf.Name);
            FtpWebRequest reqFTP;
            // 根据uri创建FtpWebRequest对象 
            reqFTP = (FtpWebRequest)FtpWebRequest.Create(new Uri(uri));
            // ftp用户名和密码
            reqFTP.Credentials = new NetworkCredential(ftpUserID, ftpPassword);
            // 默认为true，连接不会被关闭
            // 在一个命令之后被执行
            reqFTP.KeepAlive = false;
            // 指定执行什么命令
            reqFTP.Method = WebRequestMethods.Ftp.UploadFile;
            // 指定数据传输类型
            reqFTP.UseBinary = true;
            // 上传文件时通知服务器文件的大小
            reqFTP.ContentLength = fileInf.Length;
            // 缓冲大小设置为2kb
            int buffLength = 2048;
            byte[] buff = new byte[buffLength];
            int contentLen;
            // 打开一个文件流 (System.IO.FileStream) 去读上传的文件
            FileStream fs = fileInf.OpenRead();
            try
            {
                // 把上传的文件写入流
                Stream strm = reqFTP.GetRequestStream();
                // 每次读文件流的2kb
                contentLen = fs.Read(buff, 0, buffLength);
                // 流内容没有结束
                while (contentLen != 0)
                {
                    // 把内容从file stream 写入 upload stream
                    strm.Write(buff, 0, contentLen);
                    contentLen = fs.Read(buff, 0, buffLength);
                }
                // 关闭两个流
                strm.Close();
                fs.Close();
            }
            catch (Exception ex)
            {
                // MessageBox.Show(ex.Message, "Upload Error");
                Response.Write("Upload Error：" + ex.Message);
            }
        }
    }
}
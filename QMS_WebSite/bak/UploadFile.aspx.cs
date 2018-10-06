using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
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

                if (Request.Form["filetype"]==null)
                    return;

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
                string AtterFileName = DateTime.Now.ToString("yyyMMddHHmmss")+DateTime.Now.Millisecond + filetype;
                image.Save(Server.MapPath("/upload/" + AtterFileName));

                //Image img = GetImageByBytes(bytes); 
                //string AtterFileName = DateTime.Now.ToString("yyyMMddHHmmss") + ".jpg";
                //img.Save(Server.MapPath("/upload/" + AtterFileName));

                Response.Write("{\"result\":0,\"msg\":\"" + AtterFileName + "\"}");
            }
            catch (Exception ex)
            { 
                Response.Write("{\"result\":1,\"msg\":\""+ ex.Message+ "\"}");
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
    }
}
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Xml;

namespace QMS_WebSite.Method
{
    public static class CommHelper
    {
        public static object StrToJson( string Json)
        {
            return Json == null ? null : JsonConvert.DeserializeObject(Json);
        }


        /// <summary>
        /// 将XmlDocument转化为string
        /// </summary>
        /// <param name="xmlDoc"></param>
        /// <returns></returns>
        public static  string ConvertXmlToString(string sJson)
        {
            MemoryStream stream = new MemoryStream();
            XmlTextWriter writer = new XmlTextWriter(stream, null);
            writer.Formatting = System.Xml.Formatting.Indented;
            XmlDocument xmlDoc =Json2Xml(sJson)  ;
            xmlDoc.Save(writer);
            StreamReader sr = new StreamReader(stream, System.Text.Encoding.UTF8);
            stream.Position = 0;
            string xmlString = sr.ReadToEnd();
            sr.Close();
            stream.Close();
            return xmlString;
        }


        /// <summary>
        /// json字符串转换为Xml对象
        /// </summary>
        /// <param name="sJson"></param>
        /// <returns></returns>
        private static XmlDocument Json2Xml(string sJson)
        {
           
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            Dictionary<string, object> Dic = (Dictionary<string, object>)oSerializer.DeserializeObject(sJson);
            XmlDocument doc = new XmlDocument();
            XmlDeclaration xmlDec;
            xmlDec = doc.CreateXmlDeclaration("1.0", "gb2312", "yes");
            doc.InsertBefore(xmlDec, doc.DocumentElement);
            XmlElement nRoot = doc.CreateElement("IQCdata");
            doc.AppendChild(nRoot);
            foreach (KeyValuePair<string, object> item in Dic)
            {
                XmlElement element = doc.CreateElement(item.Key);
                KeyValue2Xml(element, item);
                nRoot.AppendChild(element);
            }
            return doc;
        }

        private static void KeyValue2Xml(XmlElement node, KeyValuePair<string, object> Source)
        {
            object kValue = Source.Value;
            if (kValue.GetType() == typeof(Dictionary<string, object>))
            {
                foreach (KeyValuePair<string, object> item in kValue as Dictionary<string, object>)
                {
                    XmlElement element = node.OwnerDocument.CreateElement(item.Key);
                    KeyValue2Xml(element, item);
                    node.AppendChild(element);
                }
            }
            else if (kValue.GetType() == typeof(object[]))
            {
                object[] o = kValue as object[];
                for (int i = 0; i < o.Length; i++)
                {
                    XmlElement xitem = node.OwnerDocument.CreateElement("Item");
                    KeyValuePair<string, object> item = new KeyValuePair<string, object>("Item", o[i]);
                    KeyValue2Xml(xitem, item);
                    node.AppendChild(xitem);
                }

            }
            else
            {
                XmlText text = node.OwnerDocument.CreateTextNode(kValue.ToString());
                node.AppendChild(text);
            }
        }

        public static string XMLToJson(string XML) {
            
            XmlDocument doc = new XmlDocument();

            doc.LoadXml(XML);
            
            return Newtonsoft.Json.JsonConvert.SerializeXmlNode(doc);
        }

        public static string JsonTOStr( object obj)
        {
            var timeConverter = new IsoDateTimeConverter { DateTimeFormat = "yyyy-MM-dd HH:mm:ss" };
            return JsonConvert.SerializeObject(obj, timeConverter);
        }

        #region 获取对应XML节点的值
        /// <summary>
        /// 摘要:获取对应XML节点的值
        /// </summary>
        /// <param name="stringRoot">XML节点的标记</param>
        /// <returns>返回获取对应XML节点的值</returns>
        public static string XmlAnalysis(string stringRoot, string xml)
        {
            if (stringRoot.Equals("") == false)
            {
                try
                {
                    XmlDocument XmlLoad = new XmlDocument();
                    XmlLoad.LoadXml(xml);
                    return XmlLoad.DocumentElement.SelectSingleNode(stringRoot).InnerXml.Trim();
                }
                catch(Exception ex)
                {
                    throw new Exception("解析XML失败");
                }
            }
            return "";
        }
        #endregion
    }
}
using System;

namespace QMS_WebSite
{
    public class funResult
    {
        public string RetStr = "";
        public int Code
        {
            get
            {
                if (RetStr.IndexOf("|") >= 0)
                {
                    return Convert.ToInt32(RetStr.Substring(0, RetStr.IndexOf("|")));
                }
                else
                {
                    return -1;
                }
            }
        }
        public string Msg
        {
            get
            {
                if (RetStr.IndexOf("|") >= 0)
                {
                    return RetStr.Substring(RetStr.IndexOf("|") + 1);
                }
                else
                {
                    return "";
                }
            }
        }
    }
}
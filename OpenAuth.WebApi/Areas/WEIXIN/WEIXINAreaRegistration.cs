using System.Web.Mvc;

namespace OpenAuth.WebApi.Areas.WEIXIN
{
    public class WEIXINAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "WEIXIN";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "WEIXIN_default",
                "WEIXIN/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
using System.Web.Mvc;

namespace OpenAuth.WebApi.Areas.DINGDING
{
    public class DINGDINGAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "DINGDING";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "DINGDING_default",
                "DINGDING/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
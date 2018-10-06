using System.Web.Mvc;

namespace OpenAuth.WebApi.Areas.Kindee
{
    public class KindeeAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Kindee";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "Kindee_default",
                "Kindee/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
using System.Web.Mvc;

namespace OpenAuth.Mvc.Areas.OldAJD
{
    public class OldAJDAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "OldAJD";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
            this.AreaName + "_Default",
            this.AreaName + "/{controller}/{action}/{id}",
            new { area = this.AreaName, controller = "Home", action = "Index", id = UrlParameter.Optional },
            new string[] { "OpenAuth.Mvc.Areas." + this.AreaName + ".Controllers" }
          );

            //context.MapRoute(
            //    "OldAJD_default",
            //    "OldAJD/{controller}/{action}/{id}",
            //    new { action = "Index", id = UrlParameter.Optional }
            //);
        }
    }
}
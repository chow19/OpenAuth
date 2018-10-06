using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DuoNe.Mobile.Startup))]
namespace DuoNe.Mobile
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

using OpenAuth.App.Response;
using System.Text;
using System.Web.Mvc;

namespace OpenAuth.Mvc.Controllers
{
    public class HomeController : BaseController
    {

        public ActionResult Index()
        {
            //if (userCurrent==null)
            //{ 
            //    App.Response.UserWithAccessedCtrls user = App.SSO.AuthUtil.GetCurrentUser();
            //    userCurrent = user;
            //}
            ViewBag.UserName = userCurrent.User.Name;
           // ViewBag.DeptName = userCurrent.Orgs[0].Name;
            return View();
        }

        public ActionResult Main()
        {
            return View();
        }
       
       
        
        public ActionResult Git()
        {
            return View();
        }

      
    }
}
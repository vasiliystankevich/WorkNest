using Dal;
using System.Web;
using Project.Kernel.Logger;
using Unity;
using Unity.Injection;

namespace Frontend.Web
{
    public class UnityContainerConfig 
    {
        public static void RegisterTypes(IUnityContainer container)
        {
            var logFileConfigPath = HttpContext.Current.Server.MapPath("~/log4net.config");
            InitLogger.RegisterTypes(container, logFileConfigPath);
            container.RegisterType<IDalContext>(new InjectionFactory(factory => new DalContext()));
        }
    }
}

using Modules.Site.Home;
using Modules.Site.TaskManager;
using Project.Kernel;
using Unity;

namespace Modules.Site
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<IHomeRepository, HomeRepository>();

            container.RegisterType<IHomeController, HomeController>();
            container.RegisterType<ITaskManagerController, TaskManagerController>();
        }
    }
}

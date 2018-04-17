using Libraries.Core.Backend.WebApi.Repositories;
using Modules.WebApi.TaskManager;
using Project.Kernel;
using Unity;


namespace Modules.WebApi
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<IVersionRepository, VersionRepository>();
            container.RegisterType<ITaskManagerApiRepository, TaskManagerApiRepository>();
            container.RegisterType<ITaskManagerApiController, TaskManagerApiController>();
        }
    }
}

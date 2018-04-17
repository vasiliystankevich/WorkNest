using Dal;
using Libraries.Core.Backend.Authorization;
using Libraries.Core.Backend.WebApi.Repositories;
using Logs;
using Modules.Core.Accounts;
using Modules.WebApi.TaskManager;
using Project.Kernel;
using Project.Kernel.Logger;
using Unity;
using Unity.Injection;

namespace DataGenerator
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            InitLogger.RegisterTypes(container, "log4net.config");
            container.RegisterType<ISaContext>(new InjectionFactory(factory => new SaContext()));
            container.RegisterType<IDalContext>(new InjectionFactory(factory => new DalContext()));
            container.RegisterType<ILogsContext>(new InjectionFactory(factory => new LogsContext()));
            container.RegisterType<IIdentityRepository, IdentityRepository>();
            container.RegisterType<ITaskManagerApiRepository, TaskManagerApiRepository>();
            container.RegisterType<IDataLoader, DataLoader>();
        }
    }
}

using Libraries.Core.Backend.Authorization;
using Modules.Core.Accounts;
using Project.Kernel;
using Unity;

namespace Modules.Core
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<IIdentityRepository, IdentityRepository>();
            container.RegisterType<AccountsBundle, AccountsBundle>();
            container.RegisterType<AccountsController, AccountsController>();
        }
    }
}

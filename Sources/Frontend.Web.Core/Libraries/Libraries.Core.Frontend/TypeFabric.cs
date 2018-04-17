using Libraries.Core.Frontend.Components.MultiSelect;
using Libraries.Core.Frontend.Components.Preloader;
using Libraries.Core.Frontend.Components.WebApi;
using Project.Kernel;
using Unity;

namespace Libraries.Core.Frontend
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<CommonBundle, CommonBundle>();
            container.RegisterType<PreloaderBundle, PreloaderBundle>();
            container.RegisterType<WebApiBundle, WebApiBundle>();
            container.RegisterType<MultiSelectBundle, MultiSelectBundle>();
        }
    }
}

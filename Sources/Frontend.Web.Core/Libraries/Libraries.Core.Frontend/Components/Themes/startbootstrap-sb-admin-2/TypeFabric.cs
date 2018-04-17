using Libraries.Core.Frontend.Components.Themes.StartBootStrapSbAdmin2.jQuery;
using Project.Kernel;
using Unity;

namespace Libraries.Core.Frontend.Components.Themes.StartBootStrapSbAdmin2
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<jQueryBundle, jQueryBundle>();
        }
    }
}

﻿using Project.Kernel;
using Unity;

namespace Themes.Core
{
    public class TypeFabric:BaseTypeFabric
    {
        public override void RegisterTypes(IUnityContainer container)
        {
            container.RegisterType<StartBootstrapSbAdmin2, StartBootstrapSbAdmin2>();
            container.RegisterType<ResponsibleTables, ResponsibleTables>();
        }
    }
}

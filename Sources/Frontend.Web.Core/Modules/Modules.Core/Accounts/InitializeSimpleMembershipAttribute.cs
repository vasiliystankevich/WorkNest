using System;
using System.Threading;
using System.Web.Mvc;
using Libraries.Core.Backend.Authorization;
using WebMatrix.WebData;
using Project.Kernel;
using Unity;

namespace Modules.Core.Accounts
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public sealed class InitializeSimpleMembershipAttribute : ActionFilterAttribute
    {
        private static SimpleMembershipInitializer _initializer;
        private static object _initializerLock = new object();
        private static bool _isInitialized;

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            // Ensure ASP.NET Simple Membership is initialized only once per app start
            LazyInitializer.EnsureInitialized(ref _initializer, ref _isInitialized, ref _initializerLock);
        }

        private class SimpleMembershipInitializer
        {
            public SimpleMembershipInitializer()
            {
                try
                {
                    if (WebSecurity.Initialized) return;
                    var container = UnityConfig.GetConfiguredContainer();
                    var identityRepository = container.Resolve<IIdentityRepository>();
                    identityRepository.Initialize();
                }
                catch (Exception ex)
                {
                    throw new InvalidOperationException("The ASP.NET Simple Membership database could not be initialized. For more information, please see http://go.microsoft.com/fwlink/?LinkId=256588", ex);
                }
            }
        }
    }
}

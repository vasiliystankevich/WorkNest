using System.Collections.Generic;
using Project.Kernel.Dal;

namespace Libraries.Core.Backend.Authorization
{
    public interface IIdentityRepository
    {
        void Initialize();
        void CreateUser(AccountModel model, string password);
        void CreateDefaultRoles();
        void CreateDefaultAdministrator();
        List<string> GetAllUsers();
    }
}

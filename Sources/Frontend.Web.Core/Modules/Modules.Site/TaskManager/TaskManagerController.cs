using System.Threading.Tasks;
using System.Web.Mvc;
using Libraries.Core.Backend.Authorization;
using Libraries.Core.Backend.Common;
using Libraries.Core.Backend.WebApi.Repositories;

namespace Modules.Site.TaskManager
{
    public interface ITaskManagerController
    {
        Task<ActionResult> Index();
    }

    [Authorize]
    public class TaskManagerController : BaseController<ITaskManagerApiRepository>, ITaskManagerController
    {
        public TaskManagerController(ITaskManagerApiRepository taskManagerApiRepository, IIdentityRepository identityRepository) :base(taskManagerApiRepository)
        {
            IdentityRepository = identityRepository;
        }

        public async Task<ActionResult> Index()
        {
            var tasks = Repository.GetAllTask();
            var users = IdentityRepository.GetAllUsers();
            var model = new TaskManagerModel(tasks, users);
            return await GeneratorActionResult("~/TaskManager/Index.cshtml", model);
        }

        private IIdentityRepository IdentityRepository { get; set; }
    }
}
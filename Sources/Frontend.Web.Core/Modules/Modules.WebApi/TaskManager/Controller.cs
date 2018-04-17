using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using log4net;
using Libraries.Core.Backend.Authorization;
using Libraries.Core.Backend.WebApi;
using Libraries.Core.Backend.WebApi.Repositories;
using Modules.WebApi.Shared.Requests;
using Project.Kernel;

namespace Modules.WebApi.TaskManager
{
    public interface ITaskManagerApiController
    {
        Task<HttpResponseMessage> SelectTask(SelectTaskRequest request);
        Task<HttpResponseMessage> CreateTask(CreateTaskRequest request);
        Task<HttpResponseMessage> UpdateTask(UpdateTaskRequest request);
        Task<HttpResponseMessage> DeleteTask(DeleteTaskRequest request);
    }

    [RoutePrefix("taskmanager")]
    public class TaskManagerApiController : BaseApiController<ITaskManagerApiRepository>, ITaskManagerApiController
    {

        public TaskManagerApiController(ITaskManagerApiRepository repository, IVersionRepository versionRepository, IWrapper<ILog> logger) : base(repository, versionRepository, logger)
        {
        }

        [Route("selecttask")]
        [HttpPost]
        [Authorize(Roles = ERoles.AdministratorAndUser)]
        public Task<HttpResponseMessage> SelectTask(SelectTaskRequest request)
        {
            return ExecuteAction(request, Repository.SelectTask);
        }

        [Route("createtask")]
        [HttpPost]
        [Authorize(Roles = ERoles.AdministratorAndUser)]
        public Task<HttpResponseMessage> CreateTask(CreateTaskRequest request)
        {
            return ExecuteAction(request, Repository.CreateTask);
        }

        [Route("updatetask")]
        [HttpPost]
        [Authorize(Roles = ERoles.AdministratorAndUser)]
        public Task<HttpResponseMessage> UpdateTask(UpdateTaskRequest request)
        {
            return ExecuteAction(request, Repository.UpdateTask);
        }

        [Route("deletetask")]
        [HttpPost]
        [Authorize(Roles = ERoles.AdministratorAndUser)]
        public Task<HttpResponseMessage> DeleteTask(DeleteTaskRequest request)
        {
            return ExecuteAction(request, Repository.DeleteTask);
        }
    }
}
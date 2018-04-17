using System.Collections.Generic;
using Modules.WebApi.Shared.Requests;
using Modules.WebApi.Shared.Responses;

namespace Libraries.Core.Backend.WebApi.Repositories
{
    public interface ITaskManagerApiRepository
    {
        BaseResponse SelectTask(SelectTaskRequest request);
        BaseResponse CreateTask(CreateTaskRequest request);
        BaseResponse UpdateTask(UpdateTaskRequest request);
        BaseResponse DeleteTask(DeleteTaskRequest request);
        List<TaskElement> GetAllTask();
    }
}

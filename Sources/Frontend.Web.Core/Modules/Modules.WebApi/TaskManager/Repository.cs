using System;
using System.Collections.Generic;
using System.Linq;
using Dal;
using log4net;
using Libraries.Core.Backend.WebApi.Repositories;
using Modules.WebApi.Shared.Responses;
using Project.Kernel;
using Modules.WebApi.Shared.Requests;

namespace Modules.WebApi.TaskManager
{
    public class TaskManagerApiRepository : BaseRepository, ITaskManagerApiRepository
    {
        public TaskManagerApiRepository(IWrapper<ILog> logger, IDalContext context) : base(logger)
        {
            Context = context;
        }

        public BaseResponse SelectTask(SelectTaskRequest request)
        {
            var model = Context.Tasks.First(t => t.Id == request.Task.Id);
            return new SelectTaskResponse(new TaskElement(model));
        }

        public BaseResponse CreateTask(CreateTaskRequest request)
        {
            var task = new TaskModel();
            UpdateTaskModel(task, request.Task);
            Context.Tasks.Add(task);
            Context.SaveChangesAsync().Wait();
            return BaseResponse.Ok();
        }

        public BaseResponse UpdateTask(UpdateTaskRequest request)
        {
            var task = Context.Tasks.First(t => t.Id == request.Task.Id);
            UpdateTaskModel(task, request.Task);
            Context.SaveChangesAsync().Wait();
            return BaseResponse.Ok();
        }

        public BaseResponse DeleteTask(DeleteTaskRequest request)
        {
            var task = Context.Tasks.First(t => t.Id == request.Task.Id);
            Context.Tasks.Remove(task);
            Context.SaveChangesAsync().Wait();
            return BaseResponse.Ok();
        }

        public List<TaskElement> GetAllTask()
        {
            var taskModels = Context.Tasks.ToList();
            var result = taskModels.Select(model => new TaskElement(model)).ToList();
            return result;
        }

        protected void UpdateTaskModel(TaskModel model, TaskElement element)
        {
            var assigneeUser = Context.Accounts.First(u => string.Compare(u.AccountName, element.Assignee, StringComparison.OrdinalIgnoreCase) == 0);
            var reporterUser = Context.Accounts.First(u => string.Compare(u.AccountName, element.Reporter, StringComparison.OrdinalIgnoreCase) == 0);
            model.Update(element.Name, element.Description, element.WhenCreated, element.WhenCompleted, reporterUser, assigneeUser);
        }

        protected IDalContext Context { get; set; }
    }
}

using Modules.WebApi.Shared.Requests;

namespace Modules.WebApi.Shared.Responses
{
    public interface ISelectTaskResponse
    {
        TaskElement Task { get; set; }
    }

    public class SelectTaskResponse : OkResponse, ISelectTaskResponse
    {
        public SelectTaskResponse()
        {
        }

        public SelectTaskResponse(TaskElement task)
        {
            Task = task;
        }

        public TaskElement Task { get; set; }
    }
}

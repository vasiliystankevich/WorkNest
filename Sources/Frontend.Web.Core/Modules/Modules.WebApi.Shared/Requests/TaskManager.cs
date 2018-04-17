using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dal;

namespace Modules.WebApi.Shared.Requests
{

    public interface INameField
    {
        string Name { get; set; }
    }

    public interface IDescriptonField
    {
        string Description { get; set; }
    }

    public interface IIdField
    {
        Guid Id { get; set; }
    }

    public interface IWhenCreatedField
    {
        DateTime WhenCreated { get; set; }
    }
    public interface IJsWhenCreatedField
    {
        string JsWhenCreated { get; set; }
    }

    public interface IWhenCompletedField
    {
        DateTime WhenCompleted { get; set; }
    }

    public interface IJsWhenCompletedField
    {
        string JsWhenCompleted { get; set; }
    }

    public interface IReporterField
    {
        string Reporter { get; set; }
    }

    public interface IAssigneeField
    {
        string Assignee { get; set; }
    }

    public interface ITaskElement : IIdField, INameField, IDescriptonField, IWhenCreatedField, IWhenCompletedField, IJsWhenCreatedField, IJsWhenCompletedField, IReporterField, IAssigneeField {}

    public interface ISelectTaskRequest
    {
        TaskElement Task { get; set; }
    }

    public class TaskElement : ITaskElement
    {
        public TaskElement()
        {
        }

        public TaskElement(Guid id, string name, string description, DateTime whenCreated, DateTime whenCompleted, string reporter, string assignee)
        {
            Id = id;
            Name = name;
            Description = description;
            WhenCreated = whenCreated;
            WhenCompleted = whenCompleted;
            JsWhenCreated = whenCreated.ToString("MM/dd/yyyy").Replace(".","/");
            JsWhenCompleted = whenCompleted.ToString("MM/dd/yyyy").Replace(".","/");
            Reporter = reporter;
            Assignee = assignee;
        }
        public TaskElement(TaskModel model):this(model.Id, model.Name, model.Description, model.WhenCreated, model.WhenCompleted, model.Reporter.AccountName, model.Assignee.AccountName)
        {
        }
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime WhenCreated { get; set; }
        public DateTime WhenCompleted { get; set; }
        public string JsWhenCreated { get; set; }
        public string JsWhenCompleted { get; set; }
        public string Reporter { get; set; }
        public string Assignee { get; set; }
    }

    public class SelectTaskRequest : BaseRequest, ISelectTaskRequest
    {
        public SelectTaskRequest()
        {
        }

        public SelectTaskRequest(TaskElement task)
        {
            Task = task;
        }

        public TaskElement Task { get; set; }
    }

    public class CreateTaskRequest : SelectTaskRequest {
        public CreateTaskRequest()
        {
        }
    }
    public class UpdateTaskRequest : SelectTaskRequest {
        public UpdateTaskRequest()
        {
        }
    }
    public class DeleteTaskRequest : SelectTaskRequest {
        public DeleteTaskRequest()
        {
        }
    }
}

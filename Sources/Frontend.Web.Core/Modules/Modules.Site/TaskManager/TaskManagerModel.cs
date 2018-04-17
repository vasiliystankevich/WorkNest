using System.Collections.Generic;
using Dal;
using Modules.WebApi.Shared.Requests;

namespace Modules.Site.TaskManager
{
    public class TaskManagerModel
    {
        public TaskManagerModel(List<TaskElement> tasks, List<string> users)
        {
            Tasks = tasks;
            Users = users;
        }

        public List<TaskElement> Tasks { get; set; }
        public List<string> Users { get; set; }
    }
}

using System;
using System.ComponentModel.DataAnnotations.Schema;
using Project.Kernel.Dal;

namespace Dal
{
    [Table("Tasks")]
    public class TaskModel : BaseModel
    {
        public void Update(string name, string description, DateTime whenCreated, DateTime whenCompleted, AccountModel reporter, AccountModel assignee)
        {
            Name = name;
            Description = description;
            WhenCreated = whenCreated;
            WhenCompleted = whenCompleted;
            Reporter = reporter;
            Assignee = assignee;
        }

        public string Name { get; set; }
        public string Description { get; set; }

        [Column(TypeName = "datetime2")]
        public DateTime WhenCreated { get; set; }

        [Column(TypeName = "datetime2")]
        public DateTime WhenCompleted { get; set; }
        public virtual AccountModel Reporter { get; set; }
        public virtual AccountModel Assignee { get; set; }
    }
}

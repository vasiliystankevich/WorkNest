using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web.Security;
using Dal;
using log4net;
using Libraries.Core.Backend.Authorization;
using Libraries.Core.Backend.WebApi.Repositories;
using Logs;
using Modules.WebApi.Shared.Requests;
using Project.Kernel;
using Project.Kernel.Dal;

namespace DataGenerator
{
    public interface IDataLoader
    {
        void Seed();
        void ExecuteAction(Action action, string nameAction);
    }

    public class DataLoader:IDataLoader
    {
        public DataLoader(ISaContext saContext, IDalContext dalContext, ILogsContext logsContext, IWrapper<ILog> log, IIdentityRepository identityRepository, ITaskManagerApiRepository taskManagerApiRepository)
        {
            SaContext = saContext;
            DalContext = dalContext;
            LogsContext = logsContext;
            Log = log;
            IdentityRepository = identityRepository;
            TaskManagerApiRepository = taskManagerApiRepository;
        }

        public void RecreateDb()
        {
            var instanceSqlServer = ConfigurationManager.AppSettings["InstanceSqlServer"];
            var folderSqlServer = ConfigurationManager.AppSettings["folderSqlServer"];
            var workSqlDbName = ConfigurationManager.AppSettings["WorkSqlDbName"];
            var logsSqlDbName = ConfigurationManager.AppSettings["LogsSqlDbName"];
            var sqlDbUser = ConfigurationManager.AppSettings["SqlDbUser"];

            ExecuteDeploymentScripts("RecreateDb.sql", instanceSqlServer, folderSqlServer, workSqlDbName, sqlDbUser);
            ExecuteDeploymentScripts("RecreateDb.sql", instanceSqlServer, folderSqlServer, logsSqlDbName, sqlDbUser);
        }

        public void WorkDbMigrations()
        {
            var workSqlDbName = ConfigurationManager.AppSettings["WorkSqlDbName"];
            ExecuteDeploymentScripts("WorkDbMigrations.sql", workSqlDbName);
        }
        public void LogsDbMigrations()
        {
            var logsSqlDbName = ConfigurationManager.AppSettings["LogsSqlDbName"];
            ExecuteDeploymentScripts("LogsMigrations.sql", logsSqlDbName);
        }
        public void ExecuteDeploymentScripts(string templateSqlFileName, params string[] args)
        {
            var pathToFolderSqlScript = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "SqlScripts");
            var pathToTemplateFileScript = Path.Combine(pathToFolderSqlScript, templateSqlFileName);
            var sqlTemplateScript = File.ReadAllText(pathToTemplateFileScript);
            var sqlScript = string.Format(sqlTemplateScript, args);
            SaContext.ExecuteServerScript(sqlScript);
        }

        public void ExecuteDeploymentScripts()
        {
            ExecuteAction(RecreateDb, nameof(RecreateDb));
            ExecuteAction(WorkDbMigrations, nameof(WorkDbMigrations));
            ExecuteAction(LogsDbMigrations, nameof(LogsDbMigrations));
        }

        public void Seed()
        {
            ExecuteAction(ExecuteDeploymentScripts, nameof(ExecuteDeploymentScripts));

            ExecuteAction(InitIdentity, nameof(InitIdentity));
            ExecuteAction(CreateTestUsers, nameof(CreateTestUsers));
            ExecuteAction(CreateTestTasks, nameof(CreateTestTasks));

            ExecuteAction(UpdateSeedDal, nameof(UpdateSeedDal));
            ExecuteAction(UpdateSeedLogs, nameof(UpdateSeedLogs));
        }

        public void UpdateSeedDal()
        {
            DalContext.ExecuteTransaction(() =>
            {
                DalContext.Seeding.Add(new SeedModel { IsSeed = true });
                DalContext.SaveChanges();
            });
        }
        public void UpdateSeedLogs()
        {
            LogsContext.ExecuteTransaction(() =>
            {
                LogsContext.Seeding.Add(new SeedModel { IsSeed = true });
                LogsContext.SaveChanges();
            });
        }
        public void ExecuteAction(Action action, string nameAction)
        {
            Log.Instance.Info($"{nameAction} begin...");
            action();
            Log.Instance.Info($"{nameAction} end...");
        }

        protected void InitIdentity()
        {
            IdentityRepository.Initialize();
            IdentityRepository.CreateDefaultRoles();
            IdentityRepository.CreateDefaultAdministrator();
        }

        private void CreateTestUsers()
        {
            CreateTestUser("TestUser1", ERoles.User);
            CreateTestUser("TestUser2", ERoles.User);
            CreateTestUser("TestUser3", ERoles.User);
        }

        private void CreateTestTasks()
        {
            CreateTestTask("Test Task #1", "This is test task", "TestUser1", "TestUser1");
            CreateTestTask("Test Task #2", "This is test task", "TestUser1", "TestUser2");
            CreateTestTask("Test Task #3", "This is test task", "TestUser1", "TestUser3");
            CreateTestTask("Test Task #4", "This is test task", "TestUser2", "TestUser1");
            CreateTestTask("Test Task #5", "This is test task", "TestUser2", "TestUser2");
            CreateTestTask("Test Task #6", "This is test task", "TestUser2", "TestUser3");
            CreateTestTask("Test Task #7", "This is test task", "TestUser3", "TestUser1");
            CreateTestTask("Test Task #8", "This is test task", "TestUser3", "TestUser2");
            CreateTestTask("Test Task #9", "This is test task", "TestUser3", "TestUser3");
        }

        public void CreateTestUser(string userName, string role)
        {
            var accountModel = new AccountModel
            {
                IsActivate = true,
                AccountName = userName,
                Email = $"{userName}@work.nest.com",
            };
            IdentityRepository.CreateUser(accountModel, "BRMXZnG0kG");
            Roles.AddUserToRole(accountModel.AccountName, role);
        }

        public void CreateTestTask(string name, string description, string reporter, string assignee)
        {
            var task = new TaskElement(Guid.Empty, name, description, DateTime.UtcNow.Date,
                DateTime.UtcNow.AddDays(1).Date, reporter, assignee);
            var createTaskRequest = new CreateTaskRequest {Task = task};
            TaskManagerApiRepository.CreateTask(createTaskRequest);
        }

        protected IDalContext DalContext { get; set; }
        protected ILogsContext LogsContext { get; set; }
        protected ISaContext SaContext { get; set; }
        protected IWrapper<ILog> Log { get; set; }
        protected IIdentityRepository IdentityRepository { get; set; }
        protected ITaskManagerApiRepository TaskManagerApiRepository { get; set; }
    }
}

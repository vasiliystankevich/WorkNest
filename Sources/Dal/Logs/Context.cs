﻿using System;
using System.Data.Entity;
using System.Threading.Tasks;
using Project.Kernel.Dal;


namespace Logs
{

    public interface IDbContext
    {
        int SaveChanges();
        Task<int> SaveChangesAsync();
        void ExecuteTransaction(Action action);
    }

    public interface ILogsContext:IDbContext
    {
        IDbSet<SeedModel> Seeding { get; set; }
        IDbSet<FrontendWebLogsModel> FrontendWebLogs { get; set; }
    }
    public class LogsContext : DbContext, ILogsContext
    {
        public LogsContext()
            : base("LogsConnection")
        {
        }

        public LogsContext(string nameOrConnectionString):base(nameOrConnectionString)
        {
        }

        public void ExecuteTransaction(Action action)
        {
            using (var transaction = Database.BeginTransaction())
            {
                try
                {
                    action();
                    transaction.Commit();
                }
                catch
                {
                    transaction.Rollback();
                    throw;
                }
            }
        }

        public virtual IDbSet<SeedModel> Seeding { get; set; }
        public virtual IDbSet<FrontendWebLogsModel> FrontendWebLogs { get; set; }
    }
}

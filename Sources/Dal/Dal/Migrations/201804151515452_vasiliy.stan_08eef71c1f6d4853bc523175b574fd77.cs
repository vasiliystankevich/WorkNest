namespace Dal.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class vasiliystan_08eef71c1f6d4853bc523175b574fd77 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Tasks",
                c => new
                    {
                        RowId = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Description = c.String(),
                        WhenCreated = c.DateTime(nullable: false, precision: 7, storeType: "datetime2"),
                        WhenCompleted = c.DateTime(nullable: false, precision: 7, storeType: "datetime2"),
                        Id = c.Guid(nullable: false),
                        RowVersion = c.Binary(nullable: false, fixedLength: true, timestamp: true, storeType: "rowversion"),
                        Assignee_Id = c.Long(),
                        Reporter_Id = c.Long(),
                    })
                .PrimaryKey(t => t.RowId)
                .ForeignKey("dbo.Accounts", t => t.Assignee_Id)
                .ForeignKey("dbo.Accounts", t => t.Reporter_Id)
                .Index(t => t.Id, unique: true)
                .Index(t => t.Assignee_Id)
                .Index(t => t.Reporter_Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Tasks", "Reporter_Id", "dbo.Accounts");
            DropForeignKey("dbo.Tasks", "Assignee_Id", "dbo.Accounts");
            DropIndex("dbo.Tasks", new[] { "Reporter_Id" });
            DropIndex("dbo.Tasks", new[] { "Assignee_Id" });
            DropIndex("dbo.Tasks", new[] { "Id" });
            DropTable("dbo.Tasks");
        }
    }
}

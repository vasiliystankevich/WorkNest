﻿USE [{0}]

CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201802140505325_vasiliy.stan_eaff28a0e72042c1b8ee27cde7ef12e5', N'Dal.Migrations.Configuration',  0x1F8B0800000000000400CD554D4FDB4010BD57EA7FB0F64E3609971639209A4085D4900A53EE137B6C56DDAF7AC751FCDB7AE84FEA5FE838B193100A04D4438FBB3BFBE6CD9BB7B3BF7FFE8ACF9646470B2C8372762406BDBE88D0A62E53B618898AF2A30FE2ECF4FDBBF82233CBE8AE8B3B6EE2F8A60D23714FE44FA40CE93D1A083DA3D2D20597532F754642E6E4B0DFFF280703890C21182B8AE29BCA9232B85AF072EC6C8A9E2AD05397A10EED3E9F242BD4E81A0C060F298EC485F1548BE85C2BE0E409EA5C4460AD2320A676F22D6042A5B345E27903F46DED91E372D0015BCA27DBF043D9F7870D7BB9BDD841A55520675E0938386EE590FBD7DF24AAD8C8C5825DB0B054B3A004CA62B9526E2426A09B2D5C9288F67336928D75D90A4565C53AC96D07E4BA055DABE413BD8AA7E03D9B66A777ED4E94AC1B373E4A5E5F9E5963C8343C57E52613B9120ADC3BE5D4CCF452958126403087C609E3CC3C0ADB55695781167E23C15EA9719BF665EF3EE2B10E11D1D7D22D54D67048EA40687A4D402FF9A1C75AA1A56DC014ACCA31D0ADFB8E6C36F6D270EF2DFC3FBE942164FA0073FEA53BCFF8EFB1D8B1DC1D27F104832A187D67B8584C9B2AB6A05DCC95CD1D4BEBB1A43A41DAE5DA8574C72DD9291264CCF3BC2495434A7C9C62086C0711DD81AE56136A8ED9959D55E42B3A0F01CD5CD70F6B7A3EFFEA913DE41CCF7CB30AFFA204A6A9B8049CD94F95D2D986F7E57A46CA03209A967D46DE5FB983072EC315F506E9DAD903815AF926E8D166ECF45B345E335898D90416F8166E3CCEBE600169DDBD99A7415E6EC443D9E38982A204135A8CEDFDE68B94CD1F79FA077D338D7A55070000 , N'6.2.0-61023')
GO

CREATE TABLE [dbo].[Accounts] (
    [Id] [bigint] NOT NULL IDENTITY,
    [UserId] [uniqueidentifier],
    [IsActivate] [bit],
    [AccountName] [nvarchar](max),
    [Description] [nvarchar](max),
    [Email] [nvarchar](max),
    [Role] [nvarchar](max),
    [Note] [nvarchar](max),
    [RowVersion] rowversion NOT NULL,
    CONSTRAINT [PK_dbo.Accounts] PRIMARY KEY ([Id])
)
CREATE TABLE [dbo].[EnumTypes] (
    [RowId] [int] NOT NULL IDENTITY,
    [Type] [nvarchar](max),
    [Id] [uniqueidentifier] NOT NULL,
    [RowVersion] rowversion NOT NULL,
    CONSTRAINT [PK_dbo.EnumTypes] PRIMARY KEY ([RowId])
)
CREATE UNIQUE INDEX [IX_Id] ON [dbo].[EnumTypes]([Id])
CREATE TABLE [dbo].[EnumValues] (
    [RowId] [int] NOT NULL IDENTITY,
    [Name] [nvarchar](max),
    [Value] [int] NOT NULL,
    [Id] [uniqueidentifier] NOT NULL,
    [RowVersion] rowversion NOT NULL,
    [Type_RowId] [int],
    CONSTRAINT [PK_dbo.EnumValues] PRIMARY KEY ([RowId])
)
CREATE UNIQUE INDEX [IX_Id] ON [dbo].[EnumValues]([Id])
CREATE INDEX [IX_Type_RowId] ON [dbo].[EnumValues]([Type_RowId])
CREATE TABLE [dbo].[Seeding] (
    [Id] [int] NOT NULL IDENTITY,
    [IsSeed] [bit] NOT NULL,
    CONSTRAINT [PK_dbo.Seeding] PRIMARY KEY ([Id])
)
CREATE TABLE [dbo].[webpages_Membership] (
    [UserId] [int] NOT NULL,
    [CreateDate] [datetime],
    [ConfirmationToken] [nvarchar](128),
    [IsConfirmed] [bit],
    [LastPasswordFailureDate] [datetime],
    [PasswordFailuresSinceLastSuccess] [int] NOT NULL,
    [Password] [nvarchar](128) NOT NULL,
    [PasswordChangedDate] [datetime],
    [PasswordSalt] [nvarchar](128) NOT NULL,
    [PasswordVerificationToken] [nvarchar](128),
    [PasswordVerificationTokenExpirationDate] [datetime],
    CONSTRAINT [PK_dbo.webpages_Membership] PRIMARY KEY ([UserId])
)
CREATE TABLE [dbo].[webpages_OAuthMembership] (
    [Provider] [nvarchar](30) NOT NULL,
    [ProviderUserId] [nvarchar](100) NOT NULL,
    [UserId] [int] NOT NULL,
    CONSTRAINT [PK_dbo.webpages_OAuthMembership] PRIMARY KEY ([Provider], [ProviderUserId])
)
CREATE TABLE [dbo].[webpages_Roles] (
    [RoleId] [int] NOT NULL IDENTITY,
    [RoleName] [nvarchar](256) NOT NULL,
    CONSTRAINT [PK_dbo.webpages_Roles] PRIMARY KEY ([RoleId])
)
CREATE TABLE [dbo].[webpages_UsersInRoles] (
    [UserId] [int] NOT NULL,
    [RoleId] [int] NOT NULL,
    CONSTRAINT [PK_dbo.webpages_UsersInRoles] PRIMARY KEY ([UserId], [RoleId])
)
CREATE INDEX [IX_RoleId] ON [dbo].[webpages_UsersInRoles]([RoleId])
ALTER TABLE [dbo].[EnumValues] ADD CONSTRAINT [FK_dbo.EnumValues_dbo.EnumTypes_Type_RowId] FOREIGN KEY ([Type_RowId]) REFERENCES [dbo].[EnumTypes] ([RowId])
ALTER TABLE [dbo].[webpages_UsersInRoles] ADD CONSTRAINT [FK_dbo.webpages_UsersInRoles_dbo.webpages_Roles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[webpages_Roles] ([RoleId]) ON DELETE CASCADE
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201804131454585_vasiliy.stan_0af48c61ecf140d5b6533f1c0aef9a35', N'Dal.Migrations.Configuration',  0x1F8B0800000000000400ED5CDB6EE4B619BE2FD0771074D5169B99B1B70D52C393C019DB8191B5BDD8F106BD3368893366ABC344A4BC368A3E592EF2487D85923AF22851A719BB58EC8D4722BF9FFC4F3CE8FFF6BFBFFD7EFAC37318384F30C1288E96EED16CE13A30F2621F45DBA59B92CD37DFB93F7CFFC73F9C5EF8E1B3F34BD9EE3D6B477B4678E93E12B23B99CFB1F70843806721F29218C71B32F3E2700EFC787EBC58FC7D7E74348714C2A5588E73FA298D080A61F683FE5CC59107772405C175ECC30017CFE99B7586EADC8010E21DF0E0D23D0781EB9C050850D16B186C5C0744514C00A1033BF98CE19A2471B45DEFE80310DCBDEC206DB7010186C5804FEAE6B6635F1CB3B1CFEB8E2594976212871D018FDE17CA98CBDD7BA9D4AD9445D57541D54A5ED8AC33952DDD33CF8BA9AE33B5BA8E2CF0641524ACF1D2FD98C4FF841E99FD0C93080633AAE419DFF59DA3367857B903F51AF6EF9DB34A0392267019C19424ACC5C7F42140DECFF0E52EFE178C96511A04FC78E988E93BE1017D4445ED60425E3EC14D318B2BDF75E662BFB9DCB1EAC6F5C9E77615916FFFEA3A375438780860E50E9C1ED6244EE04F30820920D0FF0808A1D364183053A8225D9245DD2EA9E5FD942275BCF2E8F09947D0139556F6FA318E0308A2B68E8555D88FB227F5781AADAE730D9E3FC0684B1E972EFDD3752ED133F4CB27C59C3F47880637ED449214B6C93A87D84BD02E77CD89655D840005934BF944753CB9909B984C2FE453FCA508BFCA81500412EAAA2C99A64942B3F8CB750697C91286F09D7E003D22641587BB9440C9DF4FE775226A4C4F17511AB29F7DF293D0F7C0098A5AA34F8E2ABA5569EAFDF1A4698AC999DC31E53CA8CCE70DFB351DEE0D7842DBACAB34F05F409042EC3A9F6090BDC68F6897EF50324FCD5E67AE7A9F9BE1328943968EF220905EDFDF81640B0955416C6EB38ED3C4830322AF06EC117A75E7AFB167117B7B59B0339BB4CDE96BF8EAC2370FCA7182B70CCCA6E02D03BC57F0AE21F4FBC46DD5EFADEFE7270ED62BCC34A5ECCC1B63C1DA785FE0C30E6C21BEBF86E103D53875B58E66D4201CD8A0E501A8AB51C583537FC3DEC4516B6A5A2590F639E78E5CECEF3B14B6F78CA30D4AC26C04999E1A12F9D1B1218B75DB44E142A6C60B9B7B7E00987C04187F8913FF921EA9A8B5FB4C5982C06B14799061AF53CF83180F5B644AF411F4D853F2EA11445BE80F51CD1A04E47013A0A18D36C8DBA34F1A255F3CEF5092FD6C5767F72C797B9692C7E1A952823970BEA44F9E900F1359E78D8DFB26D95A98D143DE2F26F15569E066075D4C22DF6E7519E69E6C8787FB3A65D6F9E0C7A700F63B3FE5FDF6B52763F25A0E51C77FFB761437321E122AC331CFC25751617CCDA941DBF25EF69AFA1861D35EB914B0EA34E896C030E17EDECE63BCCAFDEAA8F1B1CFADED58B1A895D51E0D7B0E03F978DD29766CC2E00CE3D843D95CB4B765F92580A8A58BC8772C6E04F2D4A5DE2BD03C465D1DEDA873D3012DDDBF2866681650A506510077B72EE22F66B3235919DCB49BB5616555D3E8BB99B89E8E2115D9ABAD5B8AD508D64A3C72E514721B9DC30012E8B02F7CEC9BF00A600FF86A6051EFF3C52734EBC0842D8720A0E73F4C531E8A889AA2E8590CED40D0635E12568784C7C65B4996DF9CC31D8CD83ADEC3C6C38654499654DBA649A3B7E71981F621B4074CCA2FA1190C81CF44B3F8D14916EB1F2E7618B20B32C83524E2275CEA4A75FA297C4DFC5CAFB8B2885306B80E480A7E0BA4F2FB85168A4F542D58ECE62CDB982940DCAD650B86F68A4CC1D3B6B245568E956678A5A9AD8C226198918B06B67862E633C38AED2474CEEF350EC05F72732D1BEEC2E590B45B08AB398ACEA704B8DDAA27A1154121A75B71E6165AB1DBBDA86AEABE3EF65F21B9A95BD9BFFF92A893A47731B3A6CB1D57955FEB4AAF795EEA559684CD0D3561A7D760B7A3F985AB112B9E38EBBC406CF5CDBA7B21559863CC3DACA9A7AA465B49A2DB673A7FE92DBB28F6E1254A303907043C00B6E95EF9A1D28C5B4D0C915F0A92160CD592650A283BB0BFAB254B5C4ED485B6E87449E712B2C53B3B1570666EEEEEB0EA3C108044F3A16615076918993EF634F52E8F4D3C82E9B4D63006AEBC4A180BF7DC1E4DA8B9E2E18417F678425D158F27BCB0C72B6AA778A4E2913D465E19C543E44FEC11F2B2271E217FD2650CF5C7637124F57315ED742EF9B1B24954C244D9878B61671594F542D3352AC5BD59F7B06CE9DFA05D39B0B4A5134D18F9C68087C89F7488CC41D9E1CD7948B1B1E9E322DC9EBB9F8F34014CE9246A9EEC9A208B3A161EA278F4D5D1348E561EB9BA7A597D20EBEE600D7DA7B1485993212EE7F9B3576309DD91B4AB552C302CEC638532ED268C2FB8E091F8E71DD0D4220C01547DDDC5B7B8720BD1C1B817F678C6220C1EDBD8C85E4E7B95062FB0BD7577C97A097D90848A0C1DA8D0A03B7E5EAEA103CEDF7447D49460E8E035CD469025175D5849963BBDBEBC29DFB5F54E9E2D405D32682B94D17855E185601D63ED473B922E3137978734A1764BF387760DD3B599A54368BB7771030340D3815ADD4AEBBF6334A3A8FBE9FAE9EB339370F9D8DB5A4D285D8CD68C33EDFEA79B074C6D37F14ED67052E5AFFF9B4EA445936EA74E76F12CDF5C992FF55505D91E583314C3A935FBE85A42F41B9FF1BBE5C00375E3D0E836D447D927F82BCC0A3BAAA20EBB89CB57F2AA872837F37293CA3FAB1B7AE926FEB4B8156FA7702BD7E47913D72997327ABC7CC1048633D660B6FE355805884644DDE01A44680331C9AB80DCE3C5D1B1440A7F3D04ED39C67EA0F9AAC09559992FDAF7C1A778405BC494DB5AA037A8FC328DD0AF294419D806B1ED4F0D6757122F33A61F10E90AA2614F474F20F11E41F2A7103CFFB92B9E86213D084F60410F42E299CE83807836F3C011C9D4B024FEF2543E6925728D53B7DB7077BE3FB6E124D1562FDA03EDD414B24AEDCB55E4C3E7A5FB6FBA2C7DCE5A9F38775486F39F11988307720FD306E68DFBC768394F20996643ED4D31FDBF71307D38DEAB5635CF8F753B71AEFE715FF77CE7DC2674B373E22CC4E9AA56EAC11CDDFB366312AF16999AD28E606C96660F958D438CEC13652ADDD1A77F938C91D52DE08DF4C7328DA864B3AE5B3B85EDD8636FD7C27CEC3B7B5B26641F1BC93C481B850EA5390ED5034F7B1C7DBC4656E358AED691C468A7ACE1A4C61E99E5A01442AD391889701486A0DED88BEEF05DB3685FFA5FAF7DE218B4BB49D6549969A73547C6B51B5999E6CBDA57CAEAEA93F33506B4D814E6BD4C1BC20EDA1FCE6DE26805FDD9460A2ACF3018C092EAC5A0692BC8B33CE5395D2832AD155EAAD0E67BEDD1993053F1BE8A9AF1C330AC5A6ADFC7609C0D237199BE78ED8FA7F53618596AA9BD6C682DE9AA48232DC4ABFC7B04DDFE3DC4D423F21C5BB3B62C69592651D27B9D2C3389C5C8DC6A92C6373089D33370B4EC2E9328EE9D4E4A450C9B8EFCA5137B309658E36026E794354ADF0BEFAC7104AF88A2A6C4AAA6C8DE9E98A6A7B6E9698F6F8F9126B8800515CC66C5EDCA601B875EA67EACA64B14F7BF92D3B512A36D0DC1BEC047D01316A7AACD55B489CB35521A51D9443A055C43027CBA729D25046D8047E86B769994E5C7CC63D8B7C007E85F45B729D9A5844E99268B40F85F52D85ADB243FE3D089633EBDCDBE55E231A6408789D8FDC86DF4638A02BF1AF7A5E6306280608B78717065B624EC00BB7DA990D4FF8EC20454A8AFDA7BDCC1701750307C1BADC113EC3336EA821FE016782FF5DD8709A4DD10A2DA4FCF11D82620C40546DD9FFEA43EEC87CFDFFF0FC3CA885D9C5F0000 , N'6.2.0-61023')
GO

CREATE TABLE [dbo].[Tasks] (
    [RowId] [int] NOT NULL IDENTITY,
    [Name] [nvarchar](max),
    [Description] [nvarchar](max),
    [WhenCreated] [datetime2](7) NOT NULL,
    [WhenCompleted] [datetime2](7) NOT NULL,
    [Id] [uniqueidentifier] NOT NULL,
    [RowVersion] rowversion NOT NULL,
    [Assignee_Id] [bigint],
    [Reporter_Id] [bigint],
    CONSTRAINT [PK_dbo.Tasks] PRIMARY KEY ([RowId])
)
CREATE UNIQUE INDEX [IX_Id] ON [dbo].[Tasks]([Id])
CREATE INDEX [IX_Assignee_Id] ON [dbo].[Tasks]([Assignee_Id])
CREATE INDEX [IX_Reporter_Id] ON [dbo].[Tasks]([Reporter_Id])
ALTER TABLE [dbo].[Tasks] ADD CONSTRAINT [FK_dbo.Tasks_dbo.Accounts_Assignee_Id] FOREIGN KEY ([Assignee_Id]) REFERENCES [dbo].[Accounts] ([Id])
ALTER TABLE [dbo].[Tasks] ADD CONSTRAINT [FK_dbo.Tasks_dbo.Accounts_Reporter_Id] FOREIGN KEY ([Reporter_Id]) REFERENCES [dbo].[Accounts] ([Id])
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201804151515452_vasiliy.stan_08eef71c1f6d4853bc523175b574fd77', N'Dal.Migrations.Configuration',  0x1F8B0800000000000400ED5D5B53ECB8117E4F55FE83CB4F498A6580B3D96C2866B7D801B6A83DC02986B3C91B256CCDA0AC2FB3B6CC814AE597E5213F297F2192AFBADA922FC390A5CE0B634B5FB75ADDAD96D4EEF3DF7FFFE7E4FBE730709E6092A2389ABB87FB07AE03232FF651B49EBB195E7DF5ADFBFD77BFFFDDC9B91F3E3B3F57ED3ED076A46794CEDD478C37C7B359EA3DC210A4FB21F292388D5778DF8BC319F0E3D9D1C1C15F6787873348205C82E53827B759845108F31FE4E7228E3CB8C11908AE621F0669F99CBC59E6A8CE350861BA011E9CBB6720709DD30001427A098395EB80288A31C084B1E3CF295CE2248ED6CB0D790082BB970D24ED56204861C9F071D3DC94F78323CAFBACE9584179598AE3D012F0F043298C99D8BD9748DD5A58445CE744ACF8858E3A17D9DC3DF5BC98C83A17ABEB88048F1741421BCFDD4F49FC0FE8E1FD9F6012C1609F08799FEDBAE7C80DF66A75205A43FFED398B2CC05902E711CC70425B7CCA1E02E4FD045FEEE25F60348FB22060F9251C9377DC03F28890DAC004BFDCC255398A4BDF75667CBF99D8B1EEC6F429C67619E16FBE769D6B421C3C04B05607460E4B1C27F04718C10460E87F02189361520C980B54A22ED0226A9734F47ECC90CCAFC85D7AEA61F444A855BD7E88E30082A8AB63392BF447D593683CB156D7B902CF1F61B4C68F7397FCE93A17E819FAD59372CC9F23448C9B74C24906BB689DC1D44BD0A650CD89699D8700059353B925329E9CC8758CA727721B7F29CDAF5620148184A82A75A65992102FFE7295C3E5B43816BE5533D0C3421671B8C93014F4FD64D638A256F7741E6521FDD9C73F717D5FD94191D9E8E3A3CA6EB59BFA7034A99BA27426574CD10F4AE379C37A4DD8BD064F689D771518FF1904194C5DE71606F9EBF4116D8A0825D7D4FC75AEAAF7C5345C247148DD516104C2EBFB3B90AC21262288F56D967196787080E535803D4CAFE9FC6E7B06B6B795053B9F93AE31BD9BAFCA7C0BA31CC7782BC36C33DECAC07B19EF1242BF8FDDD6FDDE7A3C3FB1B15EA654525264DE6A0BC6937707D25F3A278FCE56DD70CF79F7A8AFE451B7B905FADB238C160904B851BD33F2E30E852A276880459C6000C740FBAD2E0AA7698AD611542F0CB579DE37CD9A75417E2B2D0B8A26AA55A18DC15BB8891332BA0E069B662A06ABB72D0CD64D062D5B5FE0C306AC617A7F05C307A2108455CB054C81F0CA4B5975F463EB2CF923A3FEDEF23A8E3AEDAF702A67CC6153E3093A7AC6D10A2561CE412EA716277878A43155BBED635AD254ACBFED3D3F82147F0269FA254EFC0B800232DB7D862C40A44B147990622F33CF83693A2CBCAED04790634FCA8B4710ADA13F44344B10E0D71B00316DB442DE1675524BF9FC798392FC67B738EDBDE4CD69861F87BB4A01E695FD2579F2847CBA14CDCC1BF775B20D31AD867C3898445705C6F50A7A30097DB3D565987AD21821EDAB9479E7573F380A60BF7D4ED16F5B1B1D4AAF63B373F4E76F4651236DA0594F1CD5ACF4322A275F11752A5BDE8B5AD3C4A126EDA5E350A34E83CE473503EEA7ED2CC64EC6ABA3DAC73643DBB16C5149ABDB1AB66C06E206CDCA764CCC806C44630FE56351DE1314C79FBC94CE23DF31380B2D5C977CA24AFC185175B421CA4D189ABB7F92A6A19D40ED1A7802CCAD228F7FB0BF7F280A831976BB34147B7E1DAF6D07000DABCC61A0B9185A0E0E18683EF5631221D4E70ADD9CCA870CA309413A9CD886108CEC5BC7BB9DB137A3D12C4AE642B35B6C158495140F5D7131B989CE203D7A7468960BCD8B5A80D403BEEC62891FF2F92764FD81090D8C40B0201E952C7E28C2F2624576E56803821EE312B02C963ECA6F4D597C73063730A2115D8F391EC6524D59106D9724B5DA5EAC0DA40F263D60521D85E730183E634518440659464269196B8A2A48219710F3694C44959A854869B2922AF33895AB570109CB8001527587AF846297AC0E2C7A7B9487E812107373D78141FD9B8A15C6597620288F5B253C652B5364E988420F2F3535A551BA1C3D72D9C0148FF79D7A58BE9D80CE588E4285D8AB62A665CB8DB268D46641553D465E7D25176116410968A559890E9B1FB9815454F724B250BA222BD3D88A194469412DD26809A4189CC6578D288BE64AA64D16EA00CB34C4EA290B299E9A4616663B24593AF69157FFD88B19B9915FE81F6CA928A95D8F5ED2D5AEAE5EB9EB7727B32291BE7C7032D364DC9F5C81CD86AC5C4C067EF9C45916E9F78BAF96F669EA618131F35245B67ACD6D4D896CD1C9F885B7F432CA87172849F119C0E001D08DFDC20FA5664C9CA259112A42422822CF64B534541DE8DF7530C4072A72085776BA2063096958989F3CC8A6A4E9EED06F1F400012C555FC220EB230D2A5D2B4F5AE8E665804DD89500B0F4CF23AC70BF3DC1C8DCB6867E1B817E6785CCA068BC7BD30C72B33D359A4F29139469177CE42144FCC118AA47216A17862C3439385C173D23C97D14E66821E4BDB0FC94CA41D1E6F764646D90420B656C947FDF666D9D1BF45BAA26129D3A8DA308A809185289E5858E620EFF0E634A40C78FBA808B39BEBA7236D00532A89EC276D1D649925CC42948FDE154DA168D566DE56CB9AADBEBD82B5F49D6646AA8C577E392F9EEDCC4C149B18DB79680E4CECE7A1A5EF6EDBF8D84110979BCAE2712F2CF19AFC5409B179F5EE931496A03AB4B3B50B030C030B314299763BC2A637B248EC730B3439E59103955FDB785926B99177B5CC0B733C6DCA238BAD6D644EA73B279225D8DDDA9EB29A421F242EFF5105CA35B0C72F922355C0C51B7B4445C2A30A5ED16C045A628AA31165B1D3EEF94DF136A2B7F3EC00B2F1A09D50DAC9ABD31CB9D9D1665A7623A91C737B32661BAA9D9B7F6DD5D01D201B2A84B2BB8D1A6800DA8E96E480537D57DC8E22479DCDD3DD9B26EE18BEF76CB5A1D84C5A3BCEB4F18F9D064C3D6FFCED84E6CC86BD206D3B9B299BD89DBFD02B18F10C577FED290BC8745B97A368F67679624B05D18F3F6D6EC8C06D672B6B240CF5519EE67499D234CA3A85D26CE0E2E594B586A82E8B35DB79A685F1B65D217AFD1DB0A1E445B1D73023E885FEA27B07D5A265E023EA457371AED38BA6C5387A21DE87F7D48B1A6654BD102FFD77502F5A06DEAD17D29DB6D8A45ECFCA27F5EFFA4EBBBC4FEE2E2D275D30174D5CA70A7DE7EEF225C530DCA70DF697BF068B009115B469700522B482292E72F4DDA383C323A158DDEE148E9BA5A9CF194247F5387EE2B650E7E101AD11156EE7E733833E8ECA22F46B06510EB642D46B3470661FAC8A95DC1E10B6055154758B9E40E23D82E40F2178FEA32D9EA26CC1203CAE3ADB2024B602DB2020B6CADA408EC4EA0449FCE5A97AD2594B609CAFEA5A6E9DB757B363126B6B82FC81F3D466B2523EF265E4C3E7B9FB4FB22E7DCE5B1F3B778486F3AF118A57BC927AE8363C6F5C3F46F3795CF1AB9CD5DE554EFE6F144C6D8EF7F2ACEAC747BB1D3B977FBF6F7AEE39370909768E9D037EB8F22CF5A868B5F5306312ADE62B480911C138D5A3DE9D800268ECC0475193C9273F68F1EA231AF6430F1515B1FF324E89A6B1C07F13BE8C3B70E0F70C06FE8CE96DEED014436677B7D64C30BD27F0AA9D97F3DBAC71D46749962B175506623B4DDA4A46957B90EBC6D8EE03A5C2453D36821D458CFA8EDEB4A8519F39124B1A99087468C5A2A172602B188DCEAFB640D158AA66598FC84C58C3EB13F5F02CFA3BEA2D5403524E07AD07344AB11FF5641FD8C3DB7AD1BE957C7AC5936354D09924A2148BE628A7232F9B33B230F537C13B5AA0A58FCF574CA049B093F7D2C53916D21F5EA684F92E5CFFC57857B9080995FD44BCE5EBF1AE7A0DBD4A20747DF762B81B746C6A1C747E4821136DBF341FBD94C1A0122E7C25026642EDAA8A7098CCE7FB0CA04505945ECAD1F1A9A2C9918A9562B4E5DCCBC43A6ECCB7AA149D256DDE95623B4AD1715DBE05A518A7C44FF911B7AAC2C4F4C5743A3E461FA3B8D0B07A3DBAC43BD360C74A014DB3FE6C886FA9F88EFCEDBB38D1CAFA3AA5FB908A9CF0AF8B3407B2517C88894614D198B6D083484988992452C27B152D7DB511153136925252631BE8C8A94BA5280BF9E84831EF5454EA1A401D24182F2F9160DEA948288B7A8C59064845F4D5EA05B532337975A156EA5BA940D4CAC10E152B929C81E2B37AD991EA3752FABCDF8E643203214C509B48E579E57A1F6D02903C8290BB38E6B0472B43F41686FDDA158738833728F56312C0757E8C602E368BF241724A25897898FFD397845EB9A15410345134821E17EBD46D2EA3555C855C02475513E1F8E90A62E09340E834C168053C4C5ED35B8C7CB9CDFD03CD587B80FE657493E14D86C990C9D2107095B669E8D6463FAF91C4F37C72935F2CA7630C81B089E8C1FC4DF4438602BFE6FB42710AA681A0316179624AE712D393D3F54B8D249734D60195E2AB43D93B186E020296DE444BF004FBF04654F0235C03EFA53974D781744F042FF6933304D60908D312A3E94F7E121DF6C3E7EFFE0748716C17DA7A0000 , N'6.2.0-61023')
GO


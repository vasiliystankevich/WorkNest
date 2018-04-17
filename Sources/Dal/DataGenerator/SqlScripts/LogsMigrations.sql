﻿USE [{0}]
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201802140517394_vasiliy.stan_7c2229cb57c14bf3bfb07099cc32c239', N'Dal.Migrations.Configuration',  0x1F8B0800000000000400CD55CB6EDB3010BC17E83F08BCC7B49D4B1BC809523B2902C47151B9B933D24A21CA57B5AB20FAB61EFA49FD85AE6CC9AF348E13F4D023C9E5ECECEC70F9FBE7AFF8ECD19AE8014AD4DE8DC4A0D71711B8D467DA152351517EF4419C9DBE7F175F64F631BAEDE28E9B38BEE97024EE89C2899498DE8355D8B33A2D3DFA9C7AA9B752655E0EFBFD8F723090C01082B1A228FE5A39D216160B5E8EBD4B2150A5CCD46760B0DDE79364811ADD280B18540A23716103D5223A375A71F2044C2E22E59C27454CEDE41B4242A5774512784399791D80E37265105ACA27EBF043D9F7870D7BB9BED841A51592B7AF041C1CB772C8DDEB6F1255ACE462C12E5858AA595052DA41B9506E24AE7D81CD1E3C92887693369A8D4DD92A4565C542C9750BE4B2075DAFE433CD8AA72A0476CD46F3DA9D2859766E7C94BCBE3EBBC49029EE2B7395897CA90AD839E5D4CCF45297481345EA4E35561867F649D8964C9B12B4F82B0D766A8DDBBC2FBBF70991658888BE94FE41670D89A44602DB6B027AC90F33361A1CAD03A6CAE91C90E6FE3BB0DDD84DC39DD7F0FF38532266E6007BFEA53D7B0CF854EC586E0E947802A80B46DF182F0ED2A68A35681773E572CFD20628A94E8036B97621DD714B760AA432E6795E92CE554A7C9C0222DB4144B7CA548B197507D9959B55142A3A47047B67EAED9AF6E75FBCB26DCEF12C342BFC1725304DCD25C0CC7DAAB4C956BC2F9753521E00D1B4EC33F0FEC21D3C7219AEA8574837DE1D08D4CA3781002E63A7CFC106C3603873897A80B770E379760D854AEBEECD3C0FF27223B6658F275A15A5B2D862ACEF379FA46C7EC9D33F6BF277F357070000 , N'6.2.0-61023')
GO

CREATE TABLE [dbo].[FrontendWebLogs] (
    [Id] [int] NOT NULL IDENTITY,
    [Date] [datetime2](7) NOT NULL,
    [Thread] [nvarchar](255) NOT NULL,
    [Level] [nvarchar](50) NOT NULL,
    [Logger] [nvarchar](255) NOT NULL,
    [Message] [nvarchar](4000) NOT NULL,
    [Exception] [nvarchar](2000) NOT NULL,
    [RowVersion] rowversion NOT NULL,
    CONSTRAINT [PK_dbo.FrontendWebLogs] PRIMARY KEY ([Id])
)
CREATE TABLE [dbo].[Seeding] (
    [Id] [int] NOT NULL IDENTITY,
    [IsSeed] [bit] NOT NULL,
    CONSTRAINT [PK_dbo.Seeding] PRIMARY KEY ([Id])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201804151507127_vasiliy.stan_9949e0cb2e5c4f23b4b4686ebd61837a', N'Logs.Migrations.Configuration',  0x1F8B0800000000000400ED59DB6EDB46107D2FD07F20F8EC88B25CA38941257064BB3062D98629A7CF2B72446FBBDC6577978AF46D79E827F51732CBBB48EAEA0B8AA2F00B3DDC3973D9B952FF7CFFDBFDB488983507A9A8E043FBB8D7B72DE0BE08280F8776A267EFDEDB9F3EFEFC937B19440BEB6B71EEC49C434EAE86F693D6F199E328FF0922A27A11F5A55062A67BBE881C120867D0EF7F708E8F1D40081BB12CCB7D48B8A611A4FFE0BF23C17D887542D85804C0544EC7375E8A6ADD9208544C7C18DA372254B675CE2841D91EB0996D11CE85261A353B7B54E0692978E8C548206CB28C01CFCD0853906B7C561DDF55F9FEC028EF548C05949F282DA23D018F4F726F384DF6837C6A97DE427F5DA25FF5D2589DFA6C685FA13334F0E077981ACFA5FEB5ADA6E0B311938629736FAF8BE9C8328F47650C60A898BF236B94309D48187248B42478EE3E9932EA7F81E544FC097CC813C6EA3AA296F86E8580A47B2962907AF900B35CF3EBC0B69C553EA7C958B2D578323BAEB93E19D8D62D0A2753066508D46CF6B490F01B70904443704FB406C90D06A44E6C496FC8BA40AE429A799E60407708DC0C327992404AA5317431EF6C6B4C1637C043FD34B407A7A7B67545171014941CF791534C5364D232D95FEE0DCC4D1CAC157BDA7F15A9220C41BEBDB563508A84B041F02FFDFEAB587CB930852D4DEDF546BF92EC07F12D4FD642F867CA89C4C036F53691120BFD729CE2A7C257947ADFADD101F93412519C686864B3EB54A56A6301F30082AD550B2DFF037CDDFB821281F52E08EB957C58905A6FFF2F63952C653C554688100C08DF126B9B2F0FA34B138AFA5459AF0C0D16BAE30EB163E7D7A8F2385F5537C3F440773734DBAA54C9E681CEEED5F24213D638214DCC165C2D00BB7C505A5B0D2D4E36B514D38DB366BC71C7248E51666DDCC9299697CD3AA377DEFE2341946138BEEA980C4A6D4B49183D581A1B6F4DD6067045A5D2D8DAC8949808180551EB58FD6ED738B890D47D7DCD04AADC5FF099E72A90BA6FB7815279F20A8D8B3011523BA1D469CD5CD482492750C288EC48D0916049C4D725F926EE6C72A8F36794DD118AB1A18E51D07647C987803A484EDA03236FE92B20396D7794B241D7614AE2EE38B5765B47AA9177C7AAB7CF3A589DDE46739D46E43503DC694578A339341367A7B42ACAD7DEE95455B7FD736803EFEB244ED1AB561072DA1B5F45ABFC378F94D2CB36D028F76E5E7AB7AFBCAD5A9C1DB1CD6033A781A9C3DE5269887AE640CFFB8B8D18457BAB0363C2E90C94CE46199C388F078D1DFADFB3CF3A4A05EC80A5F6CD67336A3CBC75FADA7368AF6F95013E9BCF24037391E0D3ECDBCBAFCF5C32F99C48FF89C8F6E2F59C1DB213D56C91CF5A115F4CD7C606D8899BED80CF5DF0BA553E04BABDBF49F16D5E50B66E5BCF98E03BD7AFFF467EADAE3B53AA5F74D5694FCD7B2D33F99AB1E3469375012C135381F66416B4B6A31DD69E75526BEFBA44951BD3815B51BBFDB94EFDBBB07B018A861584F94ACC718DC7E8AF408B33D77C268A9B46EBEA1A15475A1541132CB0E45C6A3A23BEC6D73E1689D4A2AF842526B7A32904D7FC2ED19852E74A4134652BFBB4EB6C969FAE7EAB3ABB7769B5502F6102AA494D8FB8E39F13CA8252EFAB8E305E03610236CF2ED4CAD326CBC26589742BF88E40B9FB2E20C6E8C3DC9C401433045377DC23733844B747053710127F594C31EB41B65FC4AADBDD0B4A424922956354FCE6B70EC7FCD8F1F107308844551E190000 , N'6.2.0-61023')
GO


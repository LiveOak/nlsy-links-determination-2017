USE [master]
GO
CREATE DATABASE [NlsyLinks97]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'NlsyLinks97', FILENAME = N'D:\database\nlsy-links\nlsy_links_97.mdf' , SIZE = 70656KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'NlsyLinks97_log', FILENAME = N'D:\database\nlsy-links\nlsy_links_97_log.ldf' , SIZE = 120896KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [NlsyLinks97] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NlsyLinks97].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NlsyLinks97] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NlsyLinks97] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NlsyLinks97] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NlsyLinks97] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NlsyLinks97] SET ARITHABORT OFF 
GO
ALTER DATABASE [NlsyLinks97] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [NlsyLinks97] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NlsyLinks97] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NlsyLinks97] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NlsyLinks97] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NlsyLinks97] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NlsyLinks97] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NlsyLinks97] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NlsyLinks97] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NlsyLinks97] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NlsyLinks97] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NlsyLinks97] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NlsyLinks97] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NlsyLinks97] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NlsyLinks97] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NlsyLinks97] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NlsyLinks97] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NlsyLinks97] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [NlsyLinks97] SET  MULTI_USER 
GO
ALTER DATABASE [NlsyLinks97] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NlsyLinks97] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NlsyLinks97] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NlsyLinks97] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NlsyLinks97] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NlsyLinks97] SET QUERY_STORE = OFF
GO
USE [NlsyLinks97]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [NlsyLinks97]
GO
CREATE SCHEMA [Archive]
GO
CREATE SCHEMA [Enum]
GO
CREATE SCHEMA [Extract]
GO
CREATE SCHEMA [Metadata]
GO
CREATE SCHEMA [Outcome]
GO
CREATE SCHEMA [Process]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[tblArchiveDescription](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[AlgorithmVersion] [smallint] NOT NULL,
	[Description] [text] NOT NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_tblArchiveDescription] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[tblRelatedValuesArchive](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AlgorithmVersion] [smallint] NOT NULL,
	[SubjectTag_S1] [int] NOT NULL,
	[SubjectTag_S2] [int] NOT NULL,
	[MultipleBirthIfSameSex] [tinyint] NOT NULL,
	[IsMz] [tinyint] NOT NULL,
	[RosterAssignmentID] [tinyint] NULL,
	[RRoster] [float] NULL,
	[LastSurvey_S1] [smallint] NULL,
	[LastSurvey_S2] [smallint] NULL,
	[RImplicitPass1] [float] NULL,
	[RImplicit] [float] NULL,
	[RImplicitSubject] [float] NULL,
	[RImplicitMother] [float] NULL,
	[RExplicitOldestSibVersion] [float] NULL,
	[RExplicitYoungestSibVersion] [float] NULL,
	[RExplicitPass1] [float] NULL,
	[RExplicit] [float] NULL,
	[RPass1] [float] NULL,
	[R] [float] NULL,
	[RFull] [float] NULL,
	[RPeek] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUExtractSource](
	[ID] [tinyint] NOT NULL,
	[Label] [char](20) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUExtractSource] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUGender](
	[ID] [tinyint] NOT NULL,
	[Label] [char](15) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUGender] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUMarkerEvidence](
	[ID] [tinyint] NOT NULL,
	[Label] [char](20) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUMarkerEvidence] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUMarkerType](
	[ID] [tinyint] NOT NULL,
	[Label] [char](40) NOT NULL,
	[Explicit] [bit] NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUMarkerType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUMultipleBirth](
	[ID] [tinyint] NOT NULL,
	[Label] [char](10) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUMultipleBirth] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLURaceCohort](
	[ID] [tinyint] NOT NULL,
	[Label] [varchar](15) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLURaceCohort] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLURelationshipPath](
	[ID] [tinyint] NOT NULL,
	[Label] [char](20) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLURelationshipPath] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLURoster](
	[ID] [smallint] NOT NULL,
	[Label] [varchar](255) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLURoster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUTristate](
	[ID] [tinyint] NOT NULL,
	[Label] [char](10) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUIsMZ] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Enum].[tblLUYesNo](
	[ID] [smallint] NOT NULL,
	[Label] [char](40) NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_[tblLUYesNoGen1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Extract].[tblLinksExplicit](
	[R0000100] [int] NOT NULL,
	[R0536300] [int] NULL,
	[R0822200] [int] NULL,
	[R0822300] [int] NULL,
	[R0822400] [int] NULL,
	[R0822500] [int] NULL,
	[R0822600] [int] NULL,
	[R0822700] [int] NULL,
	[R0822800] [int] NULL,
	[R0822900] [int] NULL,
	[R0823000] [int] NULL,
	[R0823100] [int] NULL,
	[R0823200] [int] NULL,
	[R0823300] [int] NULL,
	[R0823400] [int] NULL,
	[R0823500] [int] NULL,
	[R0823600] [int] NULL,
	[R0823700] [int] NULL,
	[R0823800] [int] NULL,
	[R0823900] [int] NULL,
	[R0824000] [int] NULL,
	[R0824100] [int] NULL,
	[R0824200] [int] NULL,
	[R0824300] [int] NULL,
	[R0824400] [int] NULL,
	[R0824500] [int] NULL,
	[R0824600] [int] NULL,
	[R0824700] [int] NULL,
	[R0824800] [int] NULL,
	[R0824900] [int] NULL,
	[R0825000] [int] NULL,
	[R0825100] [int] NULL,
	[R0825200] [int] NULL,
	[R0825300] [int] NULL,
	[R0825400] [int] NULL,
 CONSTRAINT [PK_tblLinksExplicit] PRIMARY KEY CLUSTERED 
(
	[R0000100] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Extract].[tblLinksImplicit](
	[R0000100] [int] NOT NULL,
	[R0536300] [int] NULL,
	[R0553800] [int] NULL,
	[R0557300] [int] NULL,
	[R0563400] [int] NULL,
	[R0563500] [int] NULL,
	[R1193300] [int] NULL,
	[R1193500] [int] NULL,
	[R1205400] [int] NULL,
	[R1211100] [int] NULL,
	[R1235800] [int] NULL,
	[R1302400] [int] NULL,
	[R1302500] [int] NULL,
	[R1482600] [int] NULL,
	[S0192900] [int] NULL,
	[S0193100] [int] NULL,
	[S0193500] [int] NULL,
	[S0193600] [int] NULL,
	[S0193800] [int] NULL,
	[S0193900] [int] NULL,
	[S5604900] [int] NULL,
	[S5605100] [int] NULL,
	[T3706800] [int] NULL,
	[T3706900] [int] NULL,
	[T4580500] [int] NULL,
	[T4580600] [int] NULL,
	[T4580700] [int] NULL,
	[T4580900] [int] NULL,
	[T4581100] [int] NULL,
	[Z0490900] [int] NULL,
	[Z0491000] [int] NULL,
	[Z0491100] [int] NULL,
	[Z0491200] [int] NULL,
	[Z0494800] [int] NULL,
	[Z0494900] [int] NULL,
	[Z0495000] [int] NULL,
	[Z0495100] [int] NULL,
	[Z0498500] [int] NULL,
	[Z0498700] [int] NULL,
	[Z0499200] [int] NULL,
	[Z0499400] [int] NULL,
	[Z0499500] [int] NULL,
 CONSTRAINT [PK_tblLinksImplicit] PRIMARY KEY CLUSTERED 
(
	[R0000100] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Extract].[tblRoster](
	[R0000100] [int] NOT NULL,
	[R0536300] [int] NULL,
	[R0536401] [int] NULL,
	[R0536402] [int] NULL,
	[R1097800] [int] NULL,
	[R1097900] [int] NULL,
	[R1098000] [int] NULL,
	[R1098100] [int] NULL,
	[R1098200] [int] NULL,
	[R1098300] [int] NULL,
	[R1098400] [int] NULL,
	[R1098500] [int] NULL,
	[R1098600] [int] NULL,
	[R1098700] [int] NULL,
	[R1098800] [int] NULL,
	[R1098900] [int] NULL,
	[R1099000] [int] NULL,
	[R1099100] [int] NULL,
	[R1099200] [int] NULL,
	[R1099300] [int] NULL,
	[R1101000] [int] NULL,
	[R1101100] [int] NULL,
	[R1101200] [int] NULL,
	[R1101300] [int] NULL,
	[R1101400] [int] NULL,
	[R1101500] [int] NULL,
	[R1101600] [int] NULL,
	[R1101700] [int] NULL,
	[R1101800] [int] NULL,
	[R1101900] [int] NULL,
	[R1102000] [int] NULL,
	[R1102100] [int] NULL,
	[R1102200] [int] NULL,
	[R1102300] [int] NULL,
	[R1102400] [int] NULL,
	[R1102500] [int] NULL,
	[R1102501] [int] NULL,
	[R1102600] [int] NULL,
	[R1102700] [int] NULL,
	[R1102800] [int] NULL,
	[R1102900] [int] NULL,
	[R1103000] [int] NULL,
	[R1103100] [int] NULL,
	[R1103200] [int] NULL,
	[R1103300] [int] NULL,
	[R1103400] [int] NULL,
	[R1103500] [int] NULL,
	[R1103600] [int] NULL,
	[R1103700] [int] NULL,
	[R1103800] [int] NULL,
	[R1103900] [int] NULL,
	[R1104000] [int] NULL,
	[R1104100] [int] NULL,
	[R1117000] [int] NULL,
	[R1117100] [int] NULL,
	[R1117200] [int] NULL,
	[R1117300] [int] NULL,
	[R1117400] [int] NULL,
	[R1117500] [int] NULL,
	[R1117600] [int] NULL,
	[R1117700] [int] NULL,
	[R1117800] [int] NULL,
	[R1117900] [int] NULL,
	[R1118000] [int] NULL,
	[R1118100] [int] NULL,
	[R1118200] [int] NULL,
	[R1118300] [int] NULL,
	[R1118400] [int] NULL,
	[R1118500] [int] NULL,
	[R1118600] [int] NULL,
	[R1118700] [int] NULL,
	[R1118800] [int] NULL,
	[R1118900] [int] NULL,
	[R1119000] [int] NULL,
	[R1119100] [int] NULL,
	[R1119200] [int] NULL,
	[R1119300] [int] NULL,
	[R1119400] [int] NULL,
	[R1119500] [int] NULL,
	[R1119600] [int] NULL,
	[R1119700] [int] NULL,
	[R1119800] [int] NULL,
	[R1119900] [int] NULL,
	[R1120000] [int] NULL,
	[R1120100] [int] NULL,
	[R1120200] [int] NULL,
	[R1120300] [int] NULL,
	[R1120400] [int] NULL,
	[R1120500] [int] NULL,
	[R1120600] [int] NULL,
	[R1120700] [int] NULL,
	[R1120800] [int] NULL,
	[R1120900] [int] NULL,
	[R1121000] [int] NULL,
	[R1121100] [int] NULL,
	[R1121200] [int] NULL,
	[R1121300] [int] NULL,
	[R1121400] [int] NULL,
	[R1121500] [int] NULL,
	[R1121600] [int] NULL,
	[R1121700] [int] NULL,
	[R1121800] [int] NULL,
	[R1121900] [int] NULL,
	[R1122000] [int] NULL,
	[R1122100] [int] NULL,
	[R1122200] [int] NULL,
	[R1122300] [int] NULL,
	[R1122400] [int] NULL,
	[R1122500] [int] NULL,
	[R1122600] [int] NULL,
	[R1122700] [int] NULL,
	[R1122800] [int] NULL,
	[R1122900] [int] NULL,
	[R1123000] [int] NULL,
	[R1123100] [int] NULL,
	[R1123200] [int] NULL,
	[R1123300] [int] NULL,
	[R1123400] [int] NULL,
	[R1123500] [int] NULL,
	[R1123600] [int] NULL,
	[R1123700] [int] NULL,
	[R1123800] [int] NULL,
	[R1123900] [int] NULL,
	[R1124000] [int] NULL,
	[R1124100] [int] NULL,
	[R1124200] [int] NULL,
	[R1124300] [int] NULL,
	[R1124400] [int] NULL,
	[R1124500] [int] NULL,
	[R1124600] [int] NULL,
	[R1124700] [int] NULL,
	[R1124800] [int] NULL,
	[R1124900] [int] NULL,
	[R1125000] [int] NULL,
	[R1125100] [int] NULL,
	[R1125200] [int] NULL,
	[R1125300] [int] NULL,
	[R1125400] [int] NULL,
	[R1125500] [int] NULL,
	[R1125600] [int] NULL,
	[R1125700] [int] NULL,
	[R1125800] [int] NULL,
	[R1125900] [int] NULL,
	[R1126000] [int] NULL,
	[R1126100] [int] NULL,
	[R1126200] [int] NULL,
	[R1126300] [int] NULL,
	[R1126400] [int] NULL,
	[R1126500] [int] NULL,
	[R1126600] [int] NULL,
	[R1126700] [int] NULL,
	[R1126800] [int] NULL,
	[R1126900] [int] NULL,
	[R1127000] [int] NULL,
	[R1127100] [int] NULL,
	[R1127200] [int] NULL,
	[R1127300] [int] NULL,
	[R1127400] [int] NULL,
	[R1127500] [int] NULL,
	[R1127600] [int] NULL,
	[R1127700] [int] NULL,
	[R1127800] [int] NULL,
	[R1127900] [int] NULL,
	[R1128000] [int] NULL,
	[R1128100] [int] NULL,
	[R1128200] [int] NULL,
	[R1128300] [int] NULL,
	[R1128400] [int] NULL,
	[R1128500] [int] NULL,
	[R1128600] [int] NULL,
	[R1128700] [int] NULL,
	[R1128800] [int] NULL,
	[R1128900] [int] NULL,
	[R1129000] [int] NULL,
	[R1129100] [int] NULL,
	[R1129200] [int] NULL,
	[R1129300] [int] NULL,
	[R1129400] [int] NULL,
	[R1129500] [int] NULL,
	[R1129600] [int] NULL,
	[R1129700] [int] NULL,
	[R1131900] [int] NULL,
	[R1132000] [int] NULL,
	[R1132100] [int] NULL,
	[R1132200] [int] NULL,
	[R1132300] [int] NULL,
	[R1132400] [int] NULL,
	[R1132500] [int] NULL,
	[R1132600] [int] NULL,
	[R1132700] [int] NULL,
	[R1132800] [int] NULL,
	[R1132900] [int] NULL,
	[R1133000] [int] NULL,
	[R1133100] [int] NULL,
	[R1133200] [int] NULL,
	[R1133300] [int] NULL,
	[R1133400] [int] NULL,
	[R1134200] [int] NULL,
	[R1134300] [int] NULL,
	[R1134400] [int] NULL,
	[R1134500] [int] NULL,
	[R1134600] [int] NULL,
	[R1134700] [int] NULL,
	[R1134800] [int] NULL,
	[R1134900] [int] NULL,
	[R1135000] [int] NULL,
	[R1135100] [int] NULL,
	[R1135200] [int] NULL,
	[R1135300] [int] NULL,
	[R1135400] [int] NULL,
	[R1135500] [int] NULL,
	[R1135600] [int] NULL,
	[R1135700] [int] NULL,
	[R1135800] [int] NULL,
	[R1135900] [int] NULL,
	[R1136000] [int] NULL,
	[R1136100] [int] NULL,
	[R1136200] [int] NULL,
	[R1136300] [int] NULL,
	[R1136400] [int] NULL,
	[R1136500] [int] NULL,
	[R1136600] [int] NULL,
	[R1136700] [int] NULL,
	[R1136800] [int] NULL,
	[R1136900] [int] NULL,
	[R1137000] [int] NULL,
	[R1137100] [int] NULL,
	[R1137200] [int] NULL,
	[R1137300] [int] NULL,
	[R1137400] [int] NULL,
	[R1137500] [int] NULL,
	[R1137600] [int] NULL,
	[R1137700] [int] NULL,
	[R1137800] [int] NULL,
	[R1137900] [int] NULL,
	[R1138000] [int] NULL,
	[R1138100] [int] NULL,
	[R1138200] [int] NULL,
	[R1138300] [int] NULL,
	[R1138400] [int] NULL,
	[R1138500] [int] NULL,
	[R1138600] [int] NULL,
	[R1138700] [int] NULL,
	[R1138800] [int] NULL,
	[R1138900] [int] NULL,
	[R1139000] [int] NULL,
	[R1139100] [int] NULL,
	[R1139200] [int] NULL,
	[R1139300] [int] NULL,
	[R1139400] [int] NULL,
	[R1139500] [int] NULL,
	[R1139600] [int] NULL,
	[R1139700] [int] NULL,
	[R1139800] [int] NULL,
	[R1139900] [int] NULL,
	[R1140000] [int] NULL,
	[R1140100] [int] NULL,
	[R1140200] [int] NULL,
	[R1140300] [int] NULL,
	[R1162100] [int] NULL,
	[R1162200] [int] NULL,
	[R1162300] [int] NULL,
	[R1162400] [int] NULL,
	[R1162500] [int] NULL,
	[R1162600] [int] NULL,
	[R1162700] [int] NULL,
	[R1162800] [int] NULL,
	[R1162900] [int] NULL,
	[R1163000] [int] NULL,
	[R1163100] [int] NULL,
	[R1163200] [int] NULL,
	[R1163300] [int] NULL,
	[R1163400] [int] NULL,
	[R1163500] [int] NULL,
	[R1163600] [int] NULL,
	[R1163601] [int] NULL,
	[R1163700] [int] NULL,
	[R1163800] [int] NULL,
	[R1163900] [int] NULL,
	[R1164000] [int] NULL,
	[R1164100] [int] NULL,
	[R1164200] [int] NULL,
	[R1164300] [int] NULL,
	[R1164400] [int] NULL,
	[R1164500] [int] NULL,
	[R1164600] [int] NULL,
	[R1164700] [int] NULL,
	[R1164800] [int] NULL,
	[R1164900] [int] NULL,
	[R1165000] [int] NULL,
	[R1165100] [int] NULL,
	[R1165200] [int] NULL,
	[R1165300] [int] NULL,
	[R1165400] [int] NULL,
	[R1165500] [int] NULL,
	[R1190700] [int] NULL,
	[R1190800] [int] NULL,
	[R1190900] [int] NULL,
	[R1191000] [int] NULL,
	[R1191100] [int] NULL,
	[R1191200] [int] NULL,
	[R1191400] [int] NULL,
	[R1191600] [int] NULL,
	[R1191700] [int] NULL,
	[R1191800] [int] NULL,
	[R1191900] [int] NULL,
	[R1192000] [int] NULL,
	[R1192100] [int] NULL,
	[R1192200] [int] NULL,
	[R1192300] [int] NULL,
	[R1192400] [int] NULL,
	[R1192500] [int] NULL,
	[R1192600] [int] NULL,
	[R1192700] [int] NULL,
	[R1192800] [int] NULL,
	[R1192900] [int] NULL,
	[R1192901] [int] NULL,
	[R1192902] [int] NULL,
	[R1193000] [int] NULL,
	[R1193300] [int] NULL,
	[R1235800] [int] NULL,
	[R1315800] [int] NULL,
	[R1315900] [int] NULL,
	[R1316000] [int] NULL,
	[R1316100] [int] NULL,
	[R1316200] [int] NULL,
	[R1316300] [int] NULL,
	[R1316400] [int] NULL,
	[R1316500] [int] NULL,
	[R1316600] [int] NULL,
	[R1316700] [int] NULL,
	[R1316800] [int] NULL,
	[R1316900] [int] NULL,
	[R1317000] [int] NULL,
	[R1317100] [int] NULL,
	[R1317200] [int] NULL,
	[R1317300] [int] NULL,
	[R1317400] [int] NULL,
	[R1482600] [int] NULL,
	[R2409300] [int] NULL,
	[R2409400] [int] NULL,
	[R2409500] [int] NULL,
	[R2409600] [int] NULL,
	[R2409700] [int] NULL,
	[R2409800] [int] NULL,
	[R2409900] [int] NULL,
	[R2410000] [int] NULL,
	[R2410100] [int] NULL,
	[R2410200] [int] NULL,
	[R2410300] [int] NULL,
	[R2410400] [int] NULL,
	[R2410500] [int] NULL,
	[R2410600] [int] NULL,
	[R2416300] [int] NULL,
	[R2416400] [int] NULL,
	[R2416500] [int] NULL,
	[R2416600] [int] NULL,
	[R2416700] [int] NULL,
	[R2416800] [int] NULL,
	[R2416900] [int] NULL,
	[R2417000] [int] NULL,
	[R2417100] [int] NULL,
	[R2417200] [int] NULL,
	[R2417300] [int] NULL,
	[R2417400] [int] NULL,
	[R2417500] [int] NULL,
	[R2417600] [int] NULL,
	[U1258700] [int] NULL,
	[U1258800] [int] NULL,
	[U1258900] [int] NULL,
	[U1259000] [int] NULL,
	[U1259100] [int] NULL,
	[U1259200] [int] NULL,
	[U1259300] [int] NULL,
	[U1259400] [int] NULL,
	[U1259500] [int] NULL,
	[U1259600] [int] NULL,
	[U1259700] [int] NULL,
	[U1259800] [int] NULL,
	[U1259900] [int] NULL,
	[U1260000] [int] NULL,
	[U1260100] [int] NULL,
	[U1260200] [int] NULL,
	[U1260300] [int] NULL,
	[U1261700] [int] NULL,
	[U1261800] [int] NULL,
	[U1261900] [int] NULL,
	[U1262000] [int] NULL,
	[U1262100] [int] NULL,
	[U1262200] [int] NULL,
	[U1262300] [int] NULL,
	[U1262400] [int] NULL,
	[U1262500] [int] NULL,
	[U1262600] [int] NULL,
	[U1262700] [int] NULL,
	[U1262800] [int] NULL,
	[U1262900] [int] NULL,
	[U1263000] [int] NULL,
	[U1263100] [int] NULL,
	[U1263200] [int] NULL,
	[U1263300] [int] NULL,
	[U1266000] [int] NULL,
	[U1266100] [int] NULL,
	[U1266200] [int] NULL,
	[U1266300] [int] NULL,
	[U1266400] [int] NULL,
	[U1266500] [int] NULL,
	[U1266600] [int] NULL,
	[U1266700] [int] NULL,
	[U1266800] [int] NULL,
	[U1266900] [int] NULL,
	[U1267000] [int] NULL,
	[U1267100] [int] NULL,
	[U1267200] [int] NULL,
	[U1267300] [int] NULL,
	[U1267400] [int] NULL,
	[U1267500] [int] NULL,
	[U1267600] [int] NULL,
 CONSTRAINT [PK_tblRoster] PRIMARY KEY CLUSTERED 
(
	[R0000100] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Metadata].[tblItem](
	[ID] [smallint] NOT NULL,
	[Label] [varchar](50) NOT NULL,
	[MinValue] [int] NOT NULL,
	[MinNonnegative] [int] NULL,
	[MaxValue] [int] NOT NULL,
	[Active] [varchar](5) NOT NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblLUItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Metadata].[tblMzManual](
	[ID] [int] NOT NULL,
	[SubjectTag_S1] [int] NOT NULL,
	[SubjectTag_S2] [int] NOT NULL,
	[MultipleBirthIfSameSex] [tinyint] NOT NULL,
	[IsMz] [tinyint] NOT NULL,
	[Undecided] [bit] NOT NULL,
	[Related] [bit] NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_tblMzManual] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Metadata].[tblVariable](
	[VariableCode] [char](8) NOT NULL,
	[Item] [smallint] NOT NULL,
	[ExtractSource] [tinyint] NOT NULL,
	[SurveyYear] [smallint] NOT NULL,
	[LoopIndex] [tinyint] NOT NULL,
	[Translate] [bit] NOT NULL,
	[Active] [bit] NOT NULL,
	[Notes] [varchar](255) NULL,
	[Notes_2] [varchar](255) NULL,
 CONSTRAINT [PK_tblVariable_79] PRIMARY KEY CLUSTERED 
(
	[VariableCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblOutcome](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectTag] [int] NOT NULL,
	[Item] [smallint] NOT NULL,
	[SurveyYear] [smallint] NOT NULL,
	[Value] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblRelatedStructure](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExtendedID] [smallint] NOT NULL,
	[SubjectTag_S1] [int] NOT NULL,
	[SubjectTag_S2] [int] NOT NULL,
	[RelationshipPath] [tinyint] NOT NULL,
	[EverSharedHouse] [bit] NOT NULL,
 CONSTRAINT [PK_tblRelatednessStructure] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblRelatedValues](
	[ID] [int] NOT NULL,
	[MultipleBirthIfSameSex] [tinyint] NOT NULL,
	[IsMz] [tinyint] NOT NULL,
	[LastSurvey_S1] [smallint] NULL,
	[LastSurvey_S2] [smallint] NULL,
	[ImplicitShareBiomomPass1] [tinyint] NULL,
	[ImplicitShareBiodadPass1] [tinyint] NULL,
	[ExplicitShareBiomomPass1] [tinyint] NULL,
	[ExplicitShareBiodadPass1] [tinyint] NULL,
	[ShareBiomomPass1] [tinyint] NULL,
	[ShareBiodadPass1] [tinyint] NULL,
	[RImplicitPass1] [float] NULL,
	[RImplicit] [float] NULL,
	[RImplicitSubject] [float] NULL,
	[RImplicitMother] [float] NULL,
	[RExplicitOlderSibVersion] [float] NULL,
	[RExplicitYoungerSibVersion] [float] NULL,
	[RExplicitPass1] [float] NULL,
	[RExplicit] [float] NULL,
	[RPass1] [float] NULL,
	[R] [float] NULL,
	[RFull] [float] NULL,
	[RPeek] [float] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblResponse](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectTag] [int] NOT NULL,
	[ExtendedID] [smallint] NOT NULL,
	[SurveyYear] [smallint] NOT NULL,
	[Item] [smallint] NOT NULL,
	[Value] [int] NOT NULL,
	[LoopIndex] [tinyint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblRoster](
	[RelatedID] [int] NOT NULL,
	[RosterAssignmentID] [tinyint] NOT NULL,
	[ResponseLower] [smallint] NOT NULL,
	[ResponseUpper] [smallint] NOT NULL,
	[Resolved] [bit] NOT NULL,
	[R] [float] NULL,
	[RBoundLower] [float] NOT NULL,
	[RBoundUpper] [float] NOT NULL,
	[SameGeneration] [tinyint] NOT NULL,
	[ShareBiodad] [tinyint] NOT NULL,
	[ShareBiomom] [tinyint] NOT NULL,
	[ShareBiograndparent] [tinyint] NOT NULL,
	[Inconsistent] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblSubject](
	[SubjectTag] [int] NOT NULL,
	[ExtendedID] [smallint] NOT NULL,
	[SubjectID] [int] NOT NULL,
	[Gender] [tinyint] NOT NULL,
 CONSTRAINT [PK_Process.tblSubject] PRIMARY KEY CLUSTERED 
(
	[SubjectTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblSubjectDetails](
	[SubjectTag] [int] NOT NULL,
	[RaceCohort] [tinyint] NOT NULL,
	[SiblingCountInNls] [tinyint] NOT NULL,
	[BirthOrderInNls] [tinyint] NOT NULL,
	[SimilarAgeCount] [tinyint] NOT NULL,
	[HasMzPossibly] [bit] NOT NULL,
	[KidCountBio] [tinyint] NULL,
	[KidCountInNls] [tinyint] NULL,
	[Mob] [date] NULL,
	[LastSurveyYearCompleted] [smallint] NULL,
	[AgeAtLastSurvey] [float] NULL,
	[IsDead] [bit] NOT NULL,
	[DeathDate] [date] NULL,
	[IsBiodadDead] [bit] NULL,
	[BiodadDeathDate] [date] NULL
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Process].[tblSurveyTime](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectTag] [int] NOT NULL,
	[SurveySource] [tinyint] NOT NULL,
	[SurveyYear] [smallint] NOT NULL,
	[SurveyDate] [date] NULL,
	[AgeSelfReportYears] [float] NULL,
	[AgeCalculateYears] [float] NULL
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblRelatedValuesArchive_Unique] ON [Archive].[tblRelatedValuesArchive]
(
	[AlgorithmVersion] ASC,
	[SubjectTag_S1] ASC,
	[SubjectTag_S2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_tblOutcome_Unique] ON [Process].[tblOutcome]
(
	[Item] ASC,
	[SubjectTag] ASC,
	[SurveyYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblRelatedStructure_Unique] ON [Process].[tblRelatedStructure]
(
	[SubjectTag_S1] ASC,
	[SubjectTag_S2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblRelatedValues] ON [Process].[tblRelatedValues]
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblSubject_Unique] ON [Process].[tblSubject]
(
	[SubjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblSubjectDetails] ON [Process].[tblSubjectDetails]
(
	[SubjectTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblSurveyTime_Unique] ON [Process].[tblSurveyTime]
(
	[SubjectTag] ASC,
	[SurveyYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [ICC_tblRelatedValuesArchive] ON [Archive].[tblRelatedValuesArchive] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [ICC_tblOutcome] ON [Process].[tblOutcome] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [ICC_tblRelatedValues] ON [Process].[tblRelatedValues] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [ICC_tblResponse] ON [Process].[tblResponse] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [ICC_tblSubjectDetails] ON [Process].[tblSubjectDetails] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [ICC_tblSurveyTime] ON [Process].[tblSurveyTime] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]
GO
ALTER TABLE [Metadata].[tblVariable]  WITH CHECK ADD  CONSTRAINT [FK_tblVariable_tblItem] FOREIGN KEY([Item])
REFERENCES [Metadata].[tblItem] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Metadata].[tblVariable] CHECK CONSTRAINT [FK_tblVariable_tblItem]
GO
ALTER TABLE [Metadata].[tblVariable]  WITH CHECK ADD  CONSTRAINT [FK_tblVariable_tblLUExtractSource] FOREIGN KEY([ExtractSource])
REFERENCES [Enum].[tblLUExtractSource] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Metadata].[tblVariable] CHECK CONSTRAINT [FK_tblVariable_tblLUExtractSource]
GO
ALTER TABLE [Process].[tblOutcome]  WITH CHECK ADD  CONSTRAINT [FK_tblOutcome_tblItem] FOREIGN KEY([Item])
REFERENCES [Metadata].[tblItem] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblOutcome] CHECK CONSTRAINT [FK_tblOutcome_tblItem]
GO
ALTER TABLE [Process].[tblOutcome]  WITH CHECK ADD  CONSTRAINT [FK_tblOutcome_tblSubject] FOREIGN KEY([SubjectTag])
REFERENCES [Process].[tblSubject] ([SubjectTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblOutcome] CHECK CONSTRAINT [FK_tblOutcome_tblSubject]
GO
ALTER TABLE [Process].[tblRelatedStructure]  WITH CHECK ADD  CONSTRAINT [FK_tblRelatedStructure_tblLURelationshipPath] FOREIGN KEY([RelationshipPath])
REFERENCES [Enum].[tblLURelationshipPath] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblRelatedStructure] CHECK CONSTRAINT [FK_tblRelatedStructure_tblLURelationshipPath]
GO
ALTER TABLE [Process].[tblRelatedStructure]  WITH NOCHECK ADD  CONSTRAINT [FK_tblRelatedStructure_tblSubject_Subject1] FOREIGN KEY([SubjectTag_S1])
REFERENCES [Process].[tblSubject] ([SubjectTag])
GO
ALTER TABLE [Process].[tblRelatedStructure] NOCHECK CONSTRAINT [FK_tblRelatedStructure_tblSubject_Subject1]
GO
ALTER TABLE [Process].[tblRelatedStructure]  WITH NOCHECK ADD  CONSTRAINT [FK_tblRelatedStructure_tblSubject_Subject2] FOREIGN KEY([SubjectTag_S2])
REFERENCES [Process].[tblSubject] ([SubjectTag])
GO
ALTER TABLE [Process].[tblRelatedStructure] NOCHECK CONSTRAINT [FK_tblRelatedStructure_tblSubject_Subject2]
GO
ALTER TABLE [Process].[tblRelatedValues]  WITH CHECK ADD  CONSTRAINT [FK_tblRelatedValues_tblLUMultipleBirth] FOREIGN KEY([MultipleBirthIfSameSex])
REFERENCES [Enum].[tblLUMultipleBirth] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblRelatedValues] CHECK CONSTRAINT [FK_tblRelatedValues_tblLUMultipleBirth]
GO
ALTER TABLE [Process].[tblRelatedValues]  WITH CHECK ADD  CONSTRAINT [FK_tblRelatedValues_tblLUTristate] FOREIGN KEY([IsMz])
REFERENCES [Enum].[tblLUTristate] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblRelatedValues] CHECK CONSTRAINT [FK_tblRelatedValues_tblLUTristate]
GO
ALTER TABLE [Process].[tblRelatedValues]  WITH CHECK ADD  CONSTRAINT [FK_tblRelatedValues_tblRelatedStructure] FOREIGN KEY([ID])
REFERENCES [Process].[tblRelatedStructure] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblRelatedValues] CHECK CONSTRAINT [FK_tblRelatedValues_tblRelatedStructure]
GO
ALTER TABLE [Process].[tblResponse]  WITH CHECK ADD  CONSTRAINT [FK_tblResponse_tblItem] FOREIGN KEY([Item])
REFERENCES [Metadata].[tblItem] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblResponse] CHECK CONSTRAINT [FK_tblResponse_tblItem]
GO
ALTER TABLE [Process].[tblResponse]  WITH CHECK ADD  CONSTRAINT [FK_tblResponse_tblSubject] FOREIGN KEY([SubjectTag])
REFERENCES [Process].[tblSubject] ([SubjectTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblResponse] CHECK CONSTRAINT [FK_tblResponse_tblSubject]
GO
ALTER TABLE [Process].[tblRoster]  WITH CHECK ADD  CONSTRAINT [FK_tblRoster_tblLUTristate] FOREIGN KEY([SameGeneration])
REFERENCES [Enum].[tblLUTristate] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblRoster] CHECK CONSTRAINT [FK_tblRoster_tblLUTristate]
GO
ALTER TABLE [Process].[tblRoster]  WITH CHECK ADD  CONSTRAINT [FK_tblRoster_tblRelatedStructure] FOREIGN KEY([RelatedID])
REFERENCES [Process].[tblRelatedStructure] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblRoster] CHECK CONSTRAINT [FK_tblRoster_tblRelatedStructure]
GO
ALTER TABLE [Process].[tblSubject]  WITH NOCHECK ADD  CONSTRAINT [FK_tblSubject_tblLUGender] FOREIGN KEY([Gender])
REFERENCES [Enum].[tblLUGender] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [Process].[tblSubject] CHECK CONSTRAINT [FK_tblSubject_tblLUGender]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblSubjectDetails_tblLURaceCohort] FOREIGN KEY([RaceCohort])
REFERENCES [Enum].[tblLURaceCohort] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [FK_tblSubjectDetails_tblLURaceCohort]
GO
ALTER TABLE [Process].[tblSurveyTime]  WITH CHECK ADD  CONSTRAINT [FK_tblSurveyTime_tblSubject] FOREIGN KEY([SubjectTag])
REFERENCES [Process].[tblSubject] ([SubjectTag])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Process].[tblSurveyTime] CHECK CONSTRAINT [FK_tblSurveyTime_tblSubject]
GO
ALTER TABLE [Metadata].[tblMzManual]  WITH CHECK ADD  CONSTRAINT [CK_tblMzManual_Ordered] CHECK  (([SubjectTag_S1]<[SubjectTag_S2]))
GO
ALTER TABLE [Metadata].[tblMzManual] CHECK CONSTRAINT [CK_tblMzManual_Ordered]
GO
ALTER TABLE [Metadata].[tblVariable]  WITH CHECK ADD  CONSTRAINT [CK_tblVariable_SurveyYear] CHECK  (((0)<=[SurveyYear] AND [SurveyYear]<=(2030)))
GO
ALTER TABLE [Metadata].[tblVariable] CHECK CONSTRAINT [CK_tblVariable_SurveyYear]
GO
ALTER TABLE [Metadata].[tblVariable]  WITH CHECK ADD  CONSTRAINT [CK_tblVariable_VariableCodeLength] CHECK  ((len([VariableCode])=(8)))
GO
ALTER TABLE [Metadata].[tblVariable] CHECK CONSTRAINT [CK_tblVariable_VariableCodeLength]
GO
ALTER TABLE [Process].[tblResponse]  WITH CHECK ADD  CONSTRAINT [CK_tblResponse_SurveyYear] CHECK  (((0)<=[SurveyYear] AND [SurveyYear]<=(2016)))
GO
ALTER TABLE [Process].[tblResponse] CHECK CONSTRAINT [CK_tblResponse_SurveyYear]
GO
ALTER TABLE [Process].[tblRoster]  WITH CHECK ADD  CONSTRAINT [CK_tblRoster_R] CHECK  (((0)<=[R] AND [R]<=(1) OR [R] IS NULL))
GO
ALTER TABLE [Process].[tblRoster] CHECK CONSTRAINT [CK_tblRoster_R]
GO
ALTER TABLE [Process].[tblRoster]  WITH CHECK ADD  CONSTRAINT [CK_tblRoster_RBoundLower] CHECK  (((0)<=[RBoundLower] AND [RBoundLower]<=(1)))
GO
ALTER TABLE [Process].[tblRoster] CHECK CONSTRAINT [CK_tblRoster_RBoundLower]
GO
ALTER TABLE [Process].[tblRoster]  WITH CHECK ADD  CONSTRAINT [CK_tblRoster_RBoundUpper] CHECK  (((0)<=[RBoundUpper] AND [RBoundUpper]<=(1)))
GO
ALTER TABLE [Process].[tblRoster] CHECK CONSTRAINT [CK_tblRoster_RBoundUpper]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [CK_tblSubjectDetails_AgeAtLastSurvey] CHECK  (([AgeAtLastSurvey]>=(0)))
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [CK_tblSubjectDetails_AgeAtLastSurvey]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [CK_tblSubjectDetails_BirthOrderInNls] CHECK  (((1)<=[BirthOrderInNls] AND [BirthOrderInNls]<=(14)))
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [CK_tblSubjectDetails_BirthOrderInNls]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [CK_tblSubjectDetails_KidCountBio] CHECK  (((0)<=[KidCountBio] AND [KidCountBio]<=(11)))
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [CK_tblSubjectDetails_KidCountBio]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [CK_tblSubjectDetails_LastSurveyYear] CHECK  (((1979)<=[LastSurveyYearCompleted] AND [LastSurveyYearCompleted]<=(2016)))
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [CK_tblSubjectDetails_LastSurveyYear]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [CK_tblSubjectDetails_Mob] CHECK  (('1/1/1955'<=[Mob]))
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [CK_tblSubjectDetails_Mob]
GO
ALTER TABLE [Process].[tblSubjectDetails]  WITH CHECK ADD  CONSTRAINT [CK_tblSubjectDetails_SiblingCountInNls] CHECK  (((0)<=[SiblingCountInNls] AND [SiblingCountInNls]<=(13)))
GO
ALTER TABLE [Process].[tblSubjectDetails] CHECK CONSTRAINT [CK_tblSubjectDetails_SiblingCountInNls]
GO
ALTER TABLE [Process].[tblSurveyTime]  WITH CHECK ADD  CONSTRAINT [CK_tblSurveyTime_AgeCalculateYears] CHECK  (((0)<=[AgeCalculateYears] AND [AgeCalculateYears]<=(70)))
GO
ALTER TABLE [Process].[tblSurveyTime] CHECK CONSTRAINT [CK_tblSurveyTime_AgeCalculateYears]
GO
ALTER TABLE [Process].[tblSurveyTime]  WITH CHECK ADD  CONSTRAINT [CK_tblSurveyTime_AgeSelfReportYears] CHECK  (((0)<=[AgeSelfReportYears] AND [AgeSelfReportYears]<=(70)))
GO
ALTER TABLE [Process].[tblSurveyTime] CHECK CONSTRAINT [CK_tblSurveyTime_AgeSelfReportYears]
GO
ALTER TABLE [Process].[tblSurveyTime]  WITH CHECK ADD  CONSTRAINT [CK_tblSurveyTime_SurveyYear] CHECK  (((0)<=[SurveyYear] AND [SurveyYear]<=(2016)))
GO
ALTER TABLE [Process].[tblSurveyTime] CHECK CONSTRAINT [CK_tblSurveyTime_SurveyYear]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [Process].[prcArchiveMaxVersion] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT Max([AlgorithmVersion]) as MaxVersion
  FROM Archive.[tblRelatedValuesArchive]

END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [Process].[prcResponseRetrieveSubset]
AS
BEGIN
	SET NOCOUNT ON;-- SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements.
SELECT     ID, SubjectTag, ExtendedID, SurveyYear, Item, Value, LoopIndex
FROM         Process.tblResponse
WHERE Item in (0) --For RelatedValues

OR Item in (13,14,15,16,17,20, 21,22,100)                                                                  --For SurveyTime: Birthday Values, SelfReported Age at Interview, and the SubjectID
OR Item in (1,2)                                                                                         --For Roster
OR Item in (13, 14, 306, 326, 340)                                                                       --For ParentsOfGen1Retro
OR Item in (300, 301, 302, 305, 307, 308,  310, 311, 320, 321, 322, 325, 327, 330, 331, 340)             --For ParentsOfGen1Current 309, 329,
OR Item in ( 49, 81,82,83,84,85,86,87,88,89,90, 91, 92 )                                                 --For BabyDaddy
OR Item in (121, 122, 123, 124, 125)                                                                     --For Gen2CFather
OR Item in (11, 13,14,15, 48, 49, 60, 64, 82, 86, 87, 88, 103)                                           --For SubjectDetails
OR Item in (1,2,4,5,6)                                                                                   --For MarkerGen1
OR Item in (9,10)                                                                                        --For MarkerGen2
OR Item in (                                                                                             --Outcomes
	200,201,203,                                                                                           --Gen1HeightInches, Gen1WeightPounds, Gen1AfqtScaled3Decimals
	500,501,502,503,                                                                                       --Gen2HeightInchesTotal, Gen2HeightFeetOnly, Gen2HeightInchesRemainder, Gen2HeightInchesTotalMotherSupplement
	504,512,513,                                                                                           --Gen2WeightPoundsYA, Gen2PiatMathPercentile, Gen2PiatMathStandard
	122                                                                                                    --Gen2CFatherAlive
  )                

END
GO
USE [master]
GO
ALTER DATABASE [NlsyLinks97] SET  READ_WRITE 
GO

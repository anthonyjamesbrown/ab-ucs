USE [master]
GO
/****** Object:  Database [UCS]    Script Date: 8/4/2014 9:44:28 AM ******/
CREATE DATABASE [UCS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'UCS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\UCS.mdf' , SIZE = 326656KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'UCS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\UCS_log.ldf' , SIZE = 29632KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [UCS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UCS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UCS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [UCS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [UCS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [UCS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [UCS] SET ARITHABORT OFF 
GO
ALTER DATABASE [UCS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [UCS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [UCS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [UCS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [UCS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [UCS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [UCS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [UCS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [UCS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [UCS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [UCS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [UCS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [UCS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [UCS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [UCS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [UCS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [UCS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [UCS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [UCS] SET RECOVERY FULL 
GO
ALTER DATABASE [UCS] SET  MULTI_USER 
GO
ALTER DATABASE [UCS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [UCS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [UCS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [UCS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'UCS', N'ON'
GO
USE [UCS]
GO
/****** Object:  User [UCS_ReadOnly]    Script Date: 8/4/2014 9:44:28 AM ******/
CREATE USER [UCS_ReadOnly] FOR LOGIN [UCS_Readonly] WITH DEFAULT_SCHEMA=[db_datareader]
GO
ALTER ROLE [db_datareader] ADD MEMBER [UCS_ReadOnly]
GO
/****** Object:  StoredProcedure [dbo].[DeleteDataSet]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Anthony Brown
-- Create date: 3/17/2014
-- Description:	Delete all data in the database for a given data collection
-- =============================================
CREATE PROCEDURE [dbo].[DeleteDataSet] 
	-- Add the parameters for the stored procedure here
	@DataSetID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Delete from AdaptorHostFcIf Where DataSetID = @DataSetID
    Delete from AdaptorUnits Where DataSetID = @DataSetID
	Delete from AdaptorVlan Where DataSetID = @DataSetID
    Delete from BiosHyperThreading Where DataSetID = @DataSetID
	Delete from BiosVfSelectMemoryRASConfig Where DataSetID = @DataSetID
    Delete from Blades Where DataSetID = @DataSetID
    Delete from BootPolicy Where DataSetID = @DataSetID
    Delete from CallHome Where DataSetID = @DataSetID
    Delete from CallHomeRecipient Where DataSetID = @DataSetID
    Delete from CallHomeSmtp Where DataSetID = @DataSetID
    Delete from Chassis Where DataSetID = @DataSetID
    Delete from ChassisDiscoveryPolicy Where DataSetID = @DataSetID
    Delete from CimXml Where DataSetID = @DataSetID
    Delete from CollectionData Where DataSetID = @DataSetID
    Delete from DnsServer Where DataSetID = @DataSetID
    Delete from EtherSwitchIntFIos Where DataSetID = @DataSetID
    Delete from FabricFcoeSanPc Where DataSetID = @DataSetID
    Delete from FabricFcoeSanPcEp Where DataSetID = @DataSetID
    Delete from FabricPort Where DataSetID = @DataSetID
    Delete from FabricPort2 Where DataSetID = @DataSetID
	Delete from Fault Where DataSetID = @DataSetID
    Delete from FaultPolicy Where DataSetID = @DataSetID
    Delete from FcUplinkPortChannel Where DataSetID = @DataSetID
    Delete from FiFcPort Where DataSetID = @DataSetID
    Delete from FiModules Where DataSetID = @DataSetID
    Delete from Firmware Where DataSetID = @DataSetID
    Delete from FirmwareComputerHostPack Where DataSetID = @DataSetID
    Delete from IOM Where DataSetID = @DataSetID
    Delete from IpPool Where DataSetID = @DataSetID
    Delete from IpPoolAddr Where DataSetID = @DataSetID
    Delete from IpPoolBlock Where DataSetID = @DataSetID
    Delete from LanCloud Where DataSetID = @DataSetID
    Delete from LdapGroupMap Where DataSetID = @DataSetID
    Delete from LdapProvider Where DataSetID = @DataSetID
    Delete from Licenses Where DataSetID = @DataSetID
    Delete from LocalDiskConfigPolicy Where DataSetID = @DataSetID
	Delete from LocatorLED Where DataSetID = @DataSetID
    Delete from LsbootSanImagePath Where DataSetID = @DataSetID
    Delete from LsVConAssign Where DataSetID = @DataSetID
    Delete from MacMemberBlock Where DataSetID = @DataSetID
    Delete from MacPool Where DataSetID = @DataSetID
    Delete from MaintenancePolicy Where DataSetID = @DataSetID
    Delete from MgmtBackupPolicy Where DataSetID = @DataSetID
    Delete from MgmtCfgExportPolicy Where DataSetID = @DataSetID
    Delete from MgmtInterfaceMonitoringPolicy Where DataSetID = @DataSetID
    Delete from NativeAuth Where DataSetID = @DataSetID
    Delete from NetworkControlPolicy Where DataSetID = @DataSetID
    Delete from NetworkElements Where DataSetID = @DataSetID
    Delete from NtpServer Where DataSetID = @DataSetID
    Delete from Org Where DataSetID = @DataSetID
	Delete from PowerBudget Where DataSetID = @DataSetID
    Delete from PowerChassisMember Where DataSetID = @DataSetID
    Delete from PowerControlPolicy Where DataSetID = @DataSetID
    Delete from PowerGroup Where DataSetID = @DataSetID
    Delete from ProcessorUnit Where DataSetID = @DataSetID
    Delete from QosClass Where DataSetID = @DataSetID
    Delete from QosPolicy Where DataSetID = @DataSetID
    Delete from SanCloud Where DataSetID = @DataSetID
    Delete from ScrubPolicy Where DataSetID = @DataSetID
    Delete from ServerPool Where DataSetID = @DataSetID
    Delete from ServerPoolAssignment Where DataSetID = @DataSetID
    Delete from ServiceProfiles Where DataSetID = @DataSetID
    Delete from SNMP Where DataSetID = @DataSetID
	Delete from Slots Where DataSetID = @DataSetID
    Delete from StorageController Where DataSetID = @DataSetID
    Delete from StorageLocalDisk Where DataSetID = @DataSetID
    Delete from SyslogClient Where DataSetID = @DataSetID
    Delete from SyslogFile Where DataSetID = @DataSetID
    Delete from SyslogSource Where DataSetID = @DataSetID
    Delete from Timezone Where DataSetID = @DataSetID
    Delete from UCSStatus Where DataSetID = @DataSetID
    Delete from UplinkPortChannel Where DataSetID = @DataSetID
    Delete from UplinkPortChannelMember Where DataSetID = @DataSetID
    Delete from UuidpoolAddr Where DataSetID = @DataSetID
    Delete from UuidSuffixBlock Where DataSetID = @DataSetID
    Delete from UuidSuffixPool Where DataSetID = @DataSetID
    Delete from Vhba Where DataSetID = @DataSetID
    Delete from VhbaInterface Where DataSetID = @DataSetID
    Delete from VhbaTemplate Where DataSetID = @DataSetID
    Delete from Vlan Where DataSetID = @DataSetID
    Delete from Vnic Where DataSetID = @DataSetID
    Delete from VnicEgressPolicy Where DataSetID = @DataSetID
    Delete from VnicTemplate Where DataSetID = @DataSetID
    Delete from Vsan Where DataSetID = @DataSetID
    Delete from VsanMemberFcPortChannel Where DataSetID = @DataSetID
    Delete from WwnPool Where DataSetID = @DataSetID

END

GO
/****** Object:  Table [dbo].[AdaptorHostEthIf]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdaptorHostEthIf](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[UCS] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[BootDev] [varchar](50) NULL,
	[Discovery] [varchar](50) NULL,
	[EpDn] [varchar](50) NULL,
	[Id] [varchar](50) NULL,
	[IfRole] [varchar](50) NULL,
	[IfType] [varchar](50) NULL,
	[Lc] [varchar](50) NULL,
	[LinkState] [varchar](50) NULL,
	[Mac] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Mtu] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[OperQualifierReason] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Operability] [varchar](50) NULL,
	[Order] [varchar](50) NULL,
	[OriginalMac] [varchar](50) NULL,
	[PeerDn] [varchar](50) NULL,
	[PeerPortId] [varchar](50) NULL,
	[PeerSlotId] [varchar](50) NULL,
	[PfDn] [varchar](50) NULL,
	[PortId] [varchar](50) NULL,
	[Presence] [varchar](50) NULL,
	[Purpose] [varchar](50) NULL,
	[Revision] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
	[Side] [varchar](50) NULL,
	[SlotId] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
	[Thermal] [varchar](50) NULL,
	[VirtualizationPreference] [varchar](50) NULL,
	[VnicDn] [varchar](100) NULL,
	[Voltage] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdaptorHostFcIf]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdaptorHostFcIf](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[VnicDn] [varchar](100) NULL,
	[Vendor] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[LinkState] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
	[NodeWwn] [varchar](50) NULL,
	[Wwn] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdaptorUnits]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdaptorUnits](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[ChassisId] [int] NULL,
	[BladeId] [int] NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AdaptorVlan]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AdaptorVlan](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Id] [int] NULL,
	[SwitchId] [varchar](50) NULL,
	[Adaptor] [varchar](50) NULL,
	[Port] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BiosHyperThreading]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BiosHyperThreading](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[VpIntelHyperThreadingTech] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BiosVfSelectMemoryRASConfig]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BiosVfSelectMemoryRASConfig](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[VpSelectMemoryRASConfiguration] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Blades]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Blades](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[AssignedToDn] [varchar](100) NULL,
	[AvailableMemory] [int] NULL,
	[ChassisId] [int] NULL,
	[Descr] [varchar](50) NULL,
	[LowVoltageMemory] [varchar](50) NULL,
	[ManagingInst] [varchar](50) NULL,
	[MemorySpeed] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[NumOfAdaptors] [int] NULL,
	[NumOfCores] [int] NULL,
	[NumOfCoresEnabled] [int] NULL,
	[NumOfCpus] [int] NULL,
	[NumOfEthHostIfs] [int] NULL,
	[NumOfFcHostIfs] [int] NULL,
	[NumOfThreads] [int] NULL,
	[OperPower] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Operability] [varchar](50) NULL,
	[PartNumber] [varchar](50) NULL,
	[Presence] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
	[SlotId] [int] NULL,
	[TotalMemory] [int] NULL,
	[UsrLbl] [varchar](50) NULL,
	[Vendor] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BootPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BootPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Descr] [varchar](100) NULL,
	[Purpose] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CallHome]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CallHome](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CallHomeRecipient]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CallHomeRecipient](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CallHomeSmtp]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CallHomeSmtp](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Host] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Chassis]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Chassis](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[AdminState] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[LicState] [varchar](50) NULL,
	[Power] [varchar](50) NULL,
	[Thermal] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
	[ChassisID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ChassisDiscoveryPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChassisDiscoveryPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[LinkAggregationPref] [varchar](50) NULL,
	[Action] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CimXml]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CimXml](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetId] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Descr] [varchar](100) NULL,
	[AdminState] [varchar](50) NULL,
	[OperPort] [varchar](50) NULL,
	[Port] [varchar](50) NULL,
	[Proto] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CollectionData]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CollectionData](
	[DataSetID] [int] IDENTITY(1,1) NOT NULL,
	[RecordStatus] [varchar](50) NULL,
	[DateCollected] [datetime] NULL,
	[Ucs] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DataSetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DnsServer]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DnsServer](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EtherSwitchIntFIos]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EtherSwitchIntFIos](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[ChassisId] [int] NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[PeerDn] [varchar](100) NULL,
	[Discovery] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
	[PeerSlotId] [int] NULL,
	[PeerPortId] [int] NULL,
	[SlotId] [int] NULL,
	[PortId] [int] NULL,
	[XcvrType] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FabricFcoeSanPc]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FabricFcoeSanPc](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[FcoeState] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Transport] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FabricFcoeSanPcEp]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FabricFcoeSanPcEp](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[IfRole] [varchar](50) NULL,
	[LicState] [varchar](50) NULL,
	[Membership] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
	[PortId] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FabricPort]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FabricPort](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[IfRole] [varchar](50) NULL,
	[LicState] [varchar](50) NULL,
	[Mode] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[OperSpeed] [varchar](50) NULL,
	[XcvrType] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FabricPort2]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FabricPort2](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[UCS] [varchar](50) NULL,
	[IfRole] [varchar](50) NULL,
	[EpDn] [varchar](100) NULL,
	[LicState] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[OperSpeed] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Fault]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fault](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Severity] [varchar](50) NULL,
	[Created] [datetime] NULL,
	[Descr] [varchar](250) NULL,
	[dn] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FaultPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FaultPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[AckAction] [varchar](50) NULL,
	[ClearAction] [varchar](50) NULL,
	[ClearInterval] [varchar](50) NULL,
	[FlapInterval] [varchar](50) NULL,
	[RetentionInterval] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FcUplinkPortChannel]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FcUplinkPortChannel](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[OperSpeed] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Transport] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FiFcPort]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FiFcPort](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[EpDn] [varchar](100) NULL,
	[SwitchId] [varchar](50) NULL,
	[SlotId] [int] NULL,
	[PortId] [int] NULL,
	[LicState] [varchar](50) NULL,
	[Mode] [varchar](50) NULL,
	[OperSpeed] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Wwn] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FiModules]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FiModules](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Descr] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Firmware]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Firmware](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Deployment] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Type] [varchar](50) NULL,
	[Version] [varchar](50) NULL,
	[PackageVersion] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FirmwareComputerHostPack]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FirmwareComputerHostPack](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[BladeBundleVersion] [varchar](50) NULL,
	[RackBundleVersion] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IOM]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IOM](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[ChassisId] [int] NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Discovery] [varchar](50) NULL,
	[ConfigState] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Side] [varchar](50) NULL,
	[Thermal] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IpPool]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IpPool](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[AssignmentOrder] [varchar](50) NULL,
	[Size] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IpPoolAddr]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IpPoolAddr](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[AssignedToDn] [varchar](100) NULL,
	[Id] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IpPoolBlock]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IpPoolBlock](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[From] [varchar](50) NULL,
	[To] [varchar](50) NULL,
	[Subnet] [varchar](50) NULL,
	[DefGw] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LanCloud]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LanCloud](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[MacAging] [varchar](50) NULL,
	[Mode] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LdapGroupMap]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LdapGroupMap](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LdapProvider]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LdapProvider](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Rootdn] [varchar](200) NULL,
	[Basedn] [varchar](100) NULL,
	[Attribute] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Licenses]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Licenses](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Sku] [varchar](50) NULL,
	[Scope] [varchar](50) NULL,
	[AbsQuant] [int] NULL,
	[UsedQuant] [int] NULL,
	[PeerStatus] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LocalDiskConfigPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocalDiskConfigPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Mode] [varchar](50) NULL,
	[Descr] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LocatorLED]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LocatorLED](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[DN] [varchar](100) NULL,
	[AdminState] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Color] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LsbootSanImagePath]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LsbootSanImagePath](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Type] [varchar](50) NULL,
	[VnicName] [varchar](50) NULL,
	[Lun] [varchar](50) NULL,
	[Wwn] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LsVConAssign]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LsVConAssign](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[VnicName] [varchar](50) NULL,
	[AdminVcon] [varchar](50) NULL,
	[Order] [varchar](50) NULL,
	[Transport] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MacMemberBlock]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MacMemberBlock](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](200) NULL,
	[From] [varchar](50) NULL,
	[To] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MacPool]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MacPool](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[AssignmentOrder] [varchar](50) NULL,
	[Size] [int] NULL,
	[Assigned] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MaintenancePolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MaintenancePolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[UptimeDisr] [varchar](50) NULL,
	[Descr] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MgmtBackupPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MgmtBackupPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Descr] [varchar](100) NULL,
	[Host] [varchar](100) NULL,
	[LastBackup] [varchar](50) NULL,
	[Proto] [varchar](50) NULL,
	[Schedule] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MgmtCfgExportPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MgmtCfgExportPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Descr] [varchar](100) NULL,
	[Host] [varchar](100) NULL,
	[LastBackup] [varchar](50) NULL,
	[Proto] [varchar](50) NULL,
	[Schedule] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MgmtInterfaceMonitoringPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MgmtInterfaceMonitoringPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[EnableHAFailover] [varchar](50) NULL,
	[MonitorMechanism] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NativeAuth]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NativeAuth](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[DefLogin] [varchar](50) NULL,
	[ConLogin] [varchar](50) NULL,
	[DefRolePolicy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NetworkControlPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NetworkControlPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Cdp] [varchar](50) NULL,
	[UplinkFailAction] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NetworkElements]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NetworkElements](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[OobIfIP] [varchar](50) NULL,
	[OobIfMask] [varchar](50) NULL,
	[OobIfGw] [varchar](50) NULL,
	[Operability] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NtpServer]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NtpServer](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Org]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Org](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[Dn] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PowerBudget]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PowerBudget](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[GroupName] [varchar](50) NULL,
	[DynRealloc] [varchar](50) NULL,
	[CapAction] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Prio] [varchar](50) NULL,
	[PsuState] [varchar](50) NULL,
	[PsuCapacity] [varchar](50) NULL,
	[Style] [varchar](50) NULL,
	[UpdateTime] [varchar](50) NULL,
	[AdminCommitted] [varchar](50) NULL,
	[AdminPeak] [varchar](50) NULL,
	[CatalogPower] [varchar](50) NULL,
	[CurrentPower] [varchar](50) NULL,
	[IdlePower] [varchar](50) NULL,
	[MaxPower] [varchar](50) NULL,
	[MinPower] [varchar](50) NULL,
	[OperCommitted] [varchar](50) NULL,
	[OperMin] [varchar](50) NULL,
	[OperPeak] [varchar](50) NULL,
	[ScaledWt] [varchar](50) NULL,
	[Weight] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PowerChassisMember]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PowerChassisMember](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PowerControlPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PowerControlPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[Redundancy] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PowerGroup]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PowerGroup](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Descr] [varchar](100) NULL,
	[AdminPeak] [varchar](50) NULL,
	[CurReqPower] [varchar](50) NULL,
	[CurrentPower] [varchar](50) NULL,
	[MinReqPower] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Realloc] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PowerReadingBudget]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PowerReadingBudget](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[TimeStamp] [datetime] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[GroupName] [varchar](50) NULL,
	[DynRealloc] [varchar](50) NULL,
	[CapAction] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Prio] [varchar](50) NULL,
	[PsuState] [varchar](50) NULL,
	[PsuCapacity] [varchar](50) NULL,
	[Style] [varchar](50) NULL,
	[UpdateTime] [varchar](50) NULL,
	[AdminCommitted] [varchar](50) NULL,
	[AdminPeak] [varchar](50) NULL,
	[CatalogPower] [varchar](50) NULL,
	[CurrentPower] [varchar](50) NULL,
	[IdlePower] [varchar](50) NULL,
	[MaxPower] [varchar](50) NULL,
	[MinPower] [varchar](50) NULL,
	[OperCommitted] [varchar](50) NULL,
	[OperMin] [varchar](50) NULL,
	[OperPeak] [varchar](50) NULL,
	[ScaledWt] [varchar](50) NULL,
	[Weight] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PowerReadingGroup]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PowerReadingGroup](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[TimeStamp] [datetime] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Descr] [varchar](100) NULL,
	[AdminPeak] [varchar](50) NULL,
	[CurReqPower] [varchar](50) NULL,
	[CurrentPower] [varchar](50) NULL,
	[MinReqPower] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Realloc] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProcessorUnit]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProcessorUnit](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](20) NULL,
	[SocketDesignation] [varchar](20) NULL,
	[Cores] [int] NULL,
	[CoresEnabled] [int] NULL,
	[Threads] [int] NULL,
	[Speed] [float] NULL,
	[OperState] [varchar](50) NULL,
	[Thermal] [varchar](50) NULL,
	[Model] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QosClass]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QosClass](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Priority] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[Cos] [varchar](50) NULL,
	[Weight] [varchar](50) NULL,
	[Drop] [varchar](50) NULL,
	[Mtu] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QosPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QosPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RackUnit]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RackUnit](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[AssignedToDn] [varchar](100) NULL,
	[AvailableMemory] [int] NULL,
	[Id] [int] NULL,
	[Descr] [varchar](50) NULL,
	[LowVoltageMemory] [varchar](50) NULL,
	[ManagingInst] [varchar](50) NULL,
	[MemorySpeed] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[NumOfAdaptors] [int] NULL,
	[NumOfCores] [int] NULL,
	[NumOfCoresEnabled] [int] NULL,
	[NumOfCpus] [int] NULL,
	[NumOfEthHostIfs] [int] NULL,
	[NumOfFcHostIfs] [int] NULL,
	[NumOfThreads] [int] NULL,
	[OperPower] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Operability] [varchar](50) NULL,
	[PartNumber] [varchar](50) NULL,
	[Presence] [varchar](50) NULL,
	[Serial] [varchar](50) NULL,
	[TotalMemory] [int] NULL,
	[UsrLbl] [varchar](50) NULL,
	[Vendor] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SanCloud]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SanCloud](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[Mode] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ScrubPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ScrubPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[BiosSettingsScrub] [varchar](50) NULL,
	[DiskScrub] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServerPool]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServerPool](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Assigned] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServerPoolAssignment]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServerPoolAssignment](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[AssignedToDn] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ServiceProfiles]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServiceProfiles](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[BiosProfileName] [varchar](50) NULL,
	[PnDn] [varchar](100) NULL,
	[BootPolicyName] [varchar](50) NULL,
	[HostFwPolicyName] [varchar](50) NULL,
	[LocalDiskPolicyName] [varchar](50) NULL,
	[MaintPolicyName] [varchar](50) NULL,
	[VconProfileName] [varchar](50) NULL,
	[OperSrcTemplName] [varchar](100) NULL,
	[AssocState] [varchar](50) NULL,
	[IdentPoolName] [varchar](50) NULL,
	[Uuid] [varchar](100) NULL,
	[OperState] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Slots]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Slots](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](100) NULL,
	[ChassisID] [int] NULL,
	[SlotID] [int] NULL,
	[Presence] [varchar](50) NULL,
 CONSTRAINT [PK_Slots] PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SNMP]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SNMP](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[Community] [varchar](50) NULL,
	[SysContact] [varchar](50) NULL,
	[SysLocation] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StorageController]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StorageController](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
	[Vendor] [varchar](50) NULL,
	[Model] [varchar](50) NULL,
	[Ucs] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StorageLocalDisk]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StorageLocalDisk](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Model] [varchar](100) NULL,
	[Size] [varchar](100) NULL,
	[Serial] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SyslogClient]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SyslogClient](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[ForwardingFacility] [varchar](50) NULL,
	[Hostname] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Severity] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Rn] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SyslogFile]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SyslogFile](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[AdminState] [varchar](50) NULL,
	[Severity] [varchar](50) NULL,
	[Size] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SyslogSource]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SyslogSource](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Rn] [varchar](50) NULL,
	[Audits] [varchar](50) NULL,
	[Events] [varchar](50) NULL,
	[Faults] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[test](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[testcol] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Timezone]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Timezone](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Timezone] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UCSInstances]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UCSInstances](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[InstanceName] [varchar](50) NULL,
	[IPAddress] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[Notes] [ntext] NULL,
	[CoreDmz] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[DataCenter] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UCSStatus]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UCSStatus](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Name] [varchar](50) NULL,
	[VirtualIpv4Address] [varchar](50) NULL,
	[HaConfiguration] [varchar](50) NULL,
	[HaReadiness] [varchar](50) NULL,
	[HaReady] [varchar](50) NULL,
	[FiALeadership] [varchar](50) NULL,
	[FiAOobIpv4Address] [varchar](50) NULL,
	[FiAOobIpv4DefaultGateway] [varchar](50) NULL,
	[FiAManagementServicesState] [varchar](50) NULL,
	[FiBLeadership] [varchar](50) NULL,
	[FiBOobIpv4Address] [varchar](50) NULL,
	[FiBOobIpv4DefaultGateway] [varchar](50) NULL,
	[FiBManagementServicesState] [varchar](50) NULL,
	[Ucs] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UplinkPortChannel]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UplinkPortChannel](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[OperSpeed] [varchar](50) NULL,
	[OperState] [varchar](50) NULL,
	[Transport] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UplinkPortChannelMember]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UplinkPortChannelMember](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Membership] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UuidpoolAddr]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UuidpoolAddr](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[AssignedToDn] [varchar](100) NULL,
	[Id] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UuidSuffixBlock]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UuidSuffixBlock](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](200) NULL,
	[From] [varchar](50) NULL,
	[To] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UuidSuffixPool]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UuidSuffixPool](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[AssignmentOrder] [varchar](50) NULL,
	[Prefix] [varchar](50) NULL,
	[Size] [int] NULL,
	[Assigned] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vhba]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vhba](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[IdentPoolName] [varchar](50) NULL,
	[NodeAddr] [varchar](50) NULL,
	[Addr] [varchar](50) NULL,
	[PNDN] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VhbaInterface]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VhbaInterface](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[OperVnetName] [varchar](50) NULL,
	[Initiator] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VhbaTemplate]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VhbaTemplate](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Descr] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
	[TemplType] [varchar](50) NULL,
	[QosPolicyName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vlan]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vlan](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Id] [int] NULL,
	[Dn] [varchar](100) NULL,
	[Cloud] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vnic]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vnic](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[IdentPoolName] [varchar](50) NULL,
	[Addr] [varchar](50) NULL,
	[AdminVcon] [varchar](50) NULL,
	[BootDev] [varchar](50) NULL,
	[DynamicID] [varchar](50) NULL,
	[InstType] [varchar](50) NULL,
	[MTU] [varchar](50) NULL,
	[Name] [varchar](50) NULL,
	[OperAdaptorProfileName] [varchar](100) NULL,
	[OperIdentPoolName] [varchar](50) NULL,
	[OperNwCtrlPolicyName] [varchar](50) NULL,
	[OperOrder] [varchar](50) NULL,
	[OperSpeed] [varchar](50) NULL,
	[OperStatsPolicyName] [varchar](50) NULL,
	[OperVcon] [varchar](50) NULL,
	[Order] [varchar](50) NULL,
	[Owner] [varchar](50) NULL,
	[StatsPolicyName] [varchar](50) NULL,
	[SwitchID] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[VirtualizationPreference] [varchar](50) NULL,
	[RN] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VnicEgressPolicy]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VnicEgressPolicy](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Prio] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VnicTemplate]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VnicTemplate](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[Descr] [varchar](50) NULL,
	[SwitchId] [varchar](50) NULL,
	[TemplType] [varchar](50) NULL,
	[IdentPoolName] [varchar](50) NULL,
	[Mtu] [int] NULL,
	[NwCtrlPolicyName] [varchar](50) NULL,
	[QosPolicyName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vsan]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vsan](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Id] [int] NULL,
	[FcoeVlan] [int] NULL,
	[DefaultZoning] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VsanMemberFcPortChannel]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VsanMemberFcPortChannel](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[EpDn] [varchar](100) NULL,
	[IfType] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WwnPool]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WwnPool](
	[RID] [int] IDENTITY(1,1) NOT NULL,
	[DataSetID] [int] NULL,
	[Ucs] [varchar](50) NULL,
	[Dn] [varchar](100) NULL,
	[Name] [varchar](50) NULL,
	[AssignmentOrder] [varchar](50) NULL,
	[Purpose] [varchar](50) NULL,
	[Size] [int] NULL,
	[Assigned] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[v_ActiveBlades]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveBlades]
AS
SELECT        TOP (100) PERCENT a.RID, a.DataSetID, c.DataCenter, a.Ucs, a.ChassisId, a.SlotId, a.Model, a.Dn, a.Rn, a.AdminState, a.AssignedToDn, a.AvailableMemory, a.Descr, a.LowVoltageMemory, a.ManagingInst, 
                         a.MemorySpeed, a.Name, a.NumOfAdaptors, a.NumOfCores, a.NumOfCoresEnabled, a.NumOfCpus, a.NumOfEthHostIfs, a.NumOfFcHostIfs, a.NumOfThreads, a.OperPower, a.OperState, a.Operability, 
                         a.PartNumber, d.Presence, a.Serial, a.TotalMemory, a.UsrLbl, a.Vendor
FROM            dbo.Blades AS a INNER JOIN
                         dbo.CollectionData AS b ON a.DataSetID = b.DataSetID INNER JOIN
                         dbo.UCSInstances AS c ON a.Ucs = c.InstanceName INNER JOIN
                         dbo.Slots AS d ON a.DataSetID = d.DataSetID AND a.ChassisId = d.ChassisID AND a.SlotId = d.SlotID
WHERE        (b.RecordStatus = 'Active')
ORDER BY c.DataCenter, a.Ucs, a.ChassisId, a.SlotId

GO
/****** Object:  View [dbo].[v_ActiveChassis]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveChassis]
AS
SELECT        a.RID, a.DataSetID, a.Ucs, a.Rn, a.Dn, a.AdminState, a.Model, a.OperState, a.LicState, a.Power, a.Thermal, a.Serial, a.ChassisID
FROM            dbo.Chassis AS a INNER JOIN
                         dbo.CollectionData AS b ON a.DataSetID = b.DataSetID AND b.RecordStatus = 'Active'

GO
/****** Object:  View [dbo].[v_ActiveRackUnits]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveRackUnits]
AS
SELECT        TOP (100) PERCENT a.RID, a.DataSetID, c.DataCenter, a.Ucs, a.Id, a.Model, a.Dn, a.Rn, a.AdminState, a.AssignedToDn, a.AvailableMemory, a.Descr, a.LowVoltageMemory, a.ManagingInst, a.MemorySpeed, 
                         a.Name, a.NumOfAdaptors, a.NumOfCores, a.NumOfCoresEnabled, a.NumOfCpus, a.NumOfEthHostIfs, a.NumOfFcHostIfs, a.NumOfThreads, a.OperPower, a.OperState, a.Operability, a.PartNumber, a.Serial, 
                         a.TotalMemory, a.UsrLbl, a.Vendor
FROM            dbo.RackUnit AS a INNER JOIN
                         dbo.CollectionData AS b ON a.DataSetID = b.DataSetID INNER JOIN
                         dbo.UCSInstances AS c ON a.Ucs = c.InstanceName
WHERE        (b.RecordStatus = 'Active')
ORDER BY c.DataCenter, a.Ucs, a.Id

GO
/****** Object:  View [dbo].[v_ActiveSlots]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveSlots]
AS
SELECT        a.RID, a.DataSetID, a.Ucs, a.ChassisID, a.SlotID, a.Presence
FROM            dbo.Slots AS a INNER JOIN
                         dbo.CollectionData AS b ON a.DataSetID = b.DataSetID AND b.RecordStatus = 'Active'

GO
/****** Object:  View [dbo].[v_ActiveCapacity]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveCapacity]
AS
SELECT        DataCenter, InstanceName,
                             (SELECT        COUNT(*) AS Expr1
                               FROM            dbo.v_ActiveChassis
                               WHERE        (Ucs = dbo.UCSInstances.InstanceName)) AS ChassisCount,
                             (SELECT        COUNT(*) AS Expr1
                               FROM            dbo.v_ActiveSlots
                               WHERE        (Ucs = dbo.UCSInstances.InstanceName) AND (Presence = 'equipped')) AS BladeCount,
                             (SELECT        COUNT(*) AS Expr1
                               FROM            dbo.v_ActiveBlades
                               WHERE        (Ucs = dbo.UCSInstances.InstanceName) AND (OperState = 'unassociated')) AS UnusedBlades,
                             (SELECT        COUNT(*) AS Expr1
                               FROM            dbo.v_ActiveRackUnits
                               WHERE        (Ucs = dbo.UCSInstances.InstanceName)) AS RackUnits,
                             (SELECT        COUNT(*) AS Expr1
                               FROM            dbo.v_ActiveSlots AS v_ActiveSlots_1
                               WHERE        (Ucs = dbo.UCSInstances.InstanceName) AND (Presence = 'empty')) AS EmptySlots
FROM            dbo.UCSInstances

GO
/****** Object:  View [dbo].[v_ActiveCapacity_DC]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveCapacity_DC]
AS
SELECT        DataCenter, SUM(ChassisCount) AS TChassisCount, SUM(BladeCount) AS TBladeCount, SUM(EmptySlots) AS TEmptySlots
FROM            dbo.v_ActiveCapacity
GROUP BY DataCenter

GO
/****** Object:  View [dbo].[v_Blades_ServiceProfile_General]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Blades_ServiceProfile_General]
AS
SELECT        a.DataSetID, a.Ucs, a.ChassisId, a.SlotId, a.Rn,Name=(case when b.Name is Null then 'unassociated' else b.Name end), a.AdminState, a.OperState, a.Operability, a.AvailableMemory, a.TotalMemory, a.ManagingInst, a.Model, a.NumOfAdaptors, a.NumOfCores, a.NumOfCpus, 
                         a.NumOfEthHostIfs, a.NumOfFcHostIfs, a.OperPower, a.Serial, b.BootPolicyName, b.Dn AS SPDN, stuff
                             ((SELECT        ', ' + Addr
                                 FROM            Vhba AS a1
                                 WHERE        a1.PNDN = b.Dn AND a1.DataSetID = b.DataSetID FOR XML PATH('')), 1, 1, '') AS WWNs
FROM            v_ActiveBlades AS a LEFT OUTER JOIN
                         ServiceProfiles AS b ON a.AssignedToDn = b.Dn AND a.DataSetID = b.DataSetID

GO
/****** Object:  View [dbo].[v_UCS_Geninfo]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_UCS_Geninfo]
AS
SELECT        
a.InstanceName, a.IPAddress, a.Location, x.RowRack, a.CoreDmz, a.Status, a.DataCenter, c.Version, d.AdminState AS CallHome, f.ChassisCount, f.BladeCount, f.EmptySlots,
(SELECT Top(1) Name FROM DnsServer WHERE DataSetID = b.DataSetID) AS PrimaryDNS,
(SELECT Top(1) Name FROM  NtpServer WHERE  DataSetID = b.DataSetID) AS PrimaryNTP,
e.AdminState, e.Community, e.SysContact, e.SysLocation, b.DateCollected AS LastScanned
FROM            
UCSInstances AS a LEFT OUTER JOIN CollectionData AS b ON a.InstanceName = b.Ucs AND b.RecordStatus = 'Active'
LEFT OUTER JOIN Firmware AS c ON b.DataSetID = c.DataSetID AND c.Type = 'mgmt-ext' 
LEFT OUTER JOIN CallHome AS d ON b.DataSetID = d.DataSetID 
LEFT OUTER JOIN SNMP AS e ON b.DataSetID = e.DataSetID 
LEFT OUTER JOIN v_ActiveCapacity AS f ON a.InstanceName = f.InstanceName
cross apply (select stuff((select ',' + Name from PowerGroup p where p.DataSetID = b.DataSetID and p.Name <> 'default' for xml path('')),1,1,'') as RowRack )x



GO
/****** Object:  View [dbo].[v_WWN_ServiceProfile]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_WWN_ServiceProfile]
AS
SELECT DISTINCT 
                         c.datasetid, c.Ucs, c.ChassisId, c.SlotId, c.Name, c.AdminState, c.OperState, c.AvailableMemory, c.TotalMemory, c.ManagingInst, c.Model, c.NumOfAdaptors, c.NumOfCores, c.NumOfCpus, c.NumOfEthHostIfs, 
                         c.NumOfFcHostIfs, c.OperPower, c.Serial, c.BootPolicyName, c.SPDN, stuff
                             ((SELECT        ', ' + Addr
                                 FROM            Vhba AS a1
                                 WHERE        a1.PNDN = c.SPDN AND b.RecordStatus = 'Active' AND a1.DataSetID = b.DataSetID FOR XML PATH('')), 1, 1, '') AS WWNs
FROM            Vhba AS a INNER JOIN
                         CollectionData AS b ON a.DataSetID = b.DataSetID AND b.RecordStatus = 'Active' INNER JOIN
                         v_Blades_ServiceProfile_General AS c ON a.PNDN = c.SPDN

GO
/****** Object:  View [dbo].[v_ActiveServiceProfiles]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ActiveServiceProfiles]
AS
SELECT        dbo.ServiceProfiles.RID, dbo.ServiceProfiles.DataSetID, dbo.ServiceProfiles.Ucs, dbo.ServiceProfiles.Type, dbo.ServiceProfiles.Dn, dbo.ServiceProfiles.Name, dbo.ServiceProfiles.BiosProfileName, 
                         dbo.ServiceProfiles.PnDn, dbo.ServiceProfiles.BootPolicyName, dbo.ServiceProfiles.HostFwPolicyName, dbo.ServiceProfiles.LocalDiskPolicyName, dbo.ServiceProfiles.MaintPolicyName, 
                         dbo.ServiceProfiles.VconProfileName, dbo.ServiceProfiles.OperSrcTemplName, dbo.ServiceProfiles.AssocState, dbo.ServiceProfiles.IdentPoolName, dbo.ServiceProfiles.Uuid, dbo.ServiceProfiles.OperState
FROM            dbo.CollectionData INNER JOIN
                         dbo.ServiceProfiles ON dbo.CollectionData.DataSetID = dbo.ServiceProfiles.DataSetID AND dbo.CollectionData.RecordStatus = 'active'

GO
/****** Object:  View [dbo].[v_EmptySlots]    Script Date: 8/4/2014 9:44:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_EmptySlots]
AS
SELECT        TOP (100) PERCENT a.DataCenter, b.Ucs, b.ChassisID, b.SlotID, b.Presence
FROM            dbo.Slots AS b INNER JOIN
                         dbo.UCSInstances AS a ON a.InstanceName = b.Ucs INNER JOIN
                         dbo.CollectionData AS c ON b.DataSetID = c.DataSetID
WHERE        (b.Presence = 'empty')
ORDER BY a.DataCenter, b.Ucs, b.ChassisID, b.SlotID

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 136
               Right = 447
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 485
               Bottom = 136
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 693
               Bottom = 136
               Right = 863
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveBlades'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveBlades'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -1632
         Left = 0
      End
      Begin Tables = 
         Begin Table = "UCSInstances"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveCapacity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "v_ActiveCapacity"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveCapacity_DC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveCapacity_DC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveChassis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveChassis'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 136
               Right = 447
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 485
               Bottom = 136
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveRackUnits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveRackUnits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CollectionData"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ServiceProfiles"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 449
            End
            DisplayFlags = 280
            TopColumn = 14
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveServiceProfiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveServiceProfiles'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveSlots'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_ActiveSlots'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Blades_ServiceProfile_General'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Blades_ServiceProfile_General'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 136
               Right = 447
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 485
               Bottom = 136
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EmptySlots'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_EmptySlots'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -864
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 664
               Bottom = 136
               Right = 834
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 872
               Bottom = 136
               Right = 1042
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 424
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
       ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_UCS_Geninfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_UCS_Geninfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_UCS_Geninfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -288
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_WWN_ServiceProfile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_WWN_ServiceProfile'
GO
USE [master]
GO
ALTER DATABASE [UCS] SET  READ_WRITE 
GO

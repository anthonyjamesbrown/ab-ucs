Use UCS 
GO

Create Table UCSInstances
(
	RID				int Primary Key Not Null Identity(1,1),
	InstanceName	varchar(50),
	IPAddress		varchar(50),
	Location		varchar(50),
	Notes			ntext
)

Create Table CollectionData
(
	DataSetID		int Primary Key Not Null Identity(1,1),
	RecordStatus	varchar(50),
	DateCollected	datetime,
	Ucs				varchar(50)
)

Create Table NetworkElements
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Rn				varchar(50),
	Dn				varchar(100),
	OobIfIP			varchar(50),
	OobIfMask		varchar(50),
	OobIfGw			varchar(50),
	Operability		varchar(50),
	Model			varchar(50),
	Serial			varchar(50)
)

Create Table FiModules
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Rn				varchar(50),
	Model			varchar(50),
	Descr			varchar(50),
	OperState		varchar(50),
	[State]			varchar(50),
	Serial			varchar(50),
)

Create Table Licenses
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Sku				varchar(50),
	Scope			varchar(50),
	AbsQuant		int,
	UsedQuant		int,
	PeerStatus		varchar(50),
	OperState		varchar(50)
)

Create Table Chassis(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Rn				varchar(50),
	Dn				varchar(100),
	AdminState		varchar(50),
	Model			varchar(50),
	OperState		varchar(50),
	LicState		varchar(50),
	[Power]			varchar(50),
	Thermal			varchar(50),
	Serial			varchar(50)
)

Create Table IOM
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	ChassisId		int,
	Dn				varchar(100),
	Rn				varchar(50),
	Model			varchar(50),
	Discovery		varchar(50),
	ConfigState		varchar(50),
	OperState		varchar(50),
	Side			varchar(50),
	Thermal			varchar(50),
	Serial			varchar(50),
	SwitchId		varchar(50)
)

Create Table EtherSwitchIntFIos
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	ChassisId		int,
	Dn				varchar(100),
	Rn				varchar(50),
	PeerDn			varchar(100),
	Discovery		varchar(50),
	Model			varchar(50),
	OperState		varchar(50),
	SwitchId		varchar(50),
	PeerSlotId		int,
	PeerPortId		int,
	SlotId			int,
	PortId			int,
	XcvrType		varchar(50)
)

Create Table Blades
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Rn					varchar(50),
	AdminState			varchar(50),
	AssignedToDn		varchar(100),
	AvailableMemory		int,
	ChassisId			int,
	Descr				varchar(50),
	LowVoltageMemory	varchar(50),
	ManagingInst		varchar(50),
	MemorySpeed			varchar(50),
	Model				varchar(50),
	Name				varchar(50),
	NumOfAdaptors		int,
	NumOfCores			int,
	NumOfCoresEnabled	int,
	NumOfCpus			int,
	NumOfEthHostIfs		int,
	NumOfFcHostIfs		int,
	NumOfThreads		int,
	OperPower			varchar(50),
	OperState			varchar(50),
	Operability			varchar(50),
	PartNumber			varchar(50),
	Presence			varchar(50),
	Serial				varchar(50),
	SlotId				int,
	TotalMemory			int,
	UsrLbl				varchar(50),
	Vendor				varchar(50)
)

Create Table AdaptorUnits
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	ChassisId		int,
	BladeId			int,
	Dn				varchar(100),
	Rn				varchar(50),
	Model			varchar(50),
	Serial			varchar(50)
)

Create Table ProcessorUnit
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Rn					varchar(20),
	SocketDesignation	varchar(20),
	Cores				int,
	CoresEnabled		int,
	Threads				int,
	Speed				float,
	OperState			varchar(50),
	Thermal				varchar(50),
	Model				varchar(100)
)

Create Table StorageController
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Dn				varchar(100),
	Rn				varchar(50),
	Vendor			varchar(50),
	Model			varchar(50)
)

Create Table StorageLocalDisk
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Model			varchar(100),
	Size			varchar(100),
	Serial			varchar(50)
)

Create Table BootPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Rn				varchar(50),
	Name			varchar(50),
	Descr			varchar(50),
	Purpose			varchar(50)
)

Create Table UCSStatus
(
	RID							int Primary Key Not Null Identity(1,1),
	DataSetID					int,
	Name						varchar(50),
	VirtualIpv4Address			varchar(50),
	HaConfiguration				varchar(50),
	HaReadiness					varchar(50),
	HaReady						varchar(50),
	FiALeadership				varchar(50),
	FiAOobIpv4Address			varchar(50),
	FiAOobIpv4DefaultGateway	varchar(50),
	FiAManagementServicesState	varchar(50),
	FiBLeadership				varchar(50),
	FiBOobIpv4Address			varchar(50),
	FiBOobIpv4DefaultGateway	varchar(50),
	FiBManagementServicesState	varchar(50)
)

Create Table Firmware
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Deployment		varchar(50),
	Dn				varchar(100),
	[Type]			varchar(50),
	[Version]		varchar(50),
	PackageVersion	varchar(50)
)

Create Table MgmtInterfaceMonitoringPolicy
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	AdminState			varchar(50),
	EnableHAFailover	varchar(50),
	MonitorMechanism	varchar(50)
)

Create Table ChassisDiscoveryPolicy
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Rn					varchar(50),
	LinkAggregationPref	varchar(50),
	[Action]			varchar(50)
)

Create Table PowerControlPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Rn				varchar(50),
	Redundancy		varchar(50)
)

Create Table PowerGroup
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Rn				varchar(50),
	Descr			varchar(100),
	AdminPeak		varchar(50),
	CurReqPower		varchar(50),
	CurrentPower	varchar(50),
	MinReqPower		varchar(50),
	OperState		varchar(50),
	Realloc			varchar(50)
)

Create Table PowerChassisMember
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Rn				varchar(50),
	ID				varchar(50),
	OperState		varchar(50)
)

Create Table Org
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(50),
	Dn				varchar(50)
)

Create Table FaultPolicy
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Rn					varchar(50),
	AckAction			varchar(50),
	ClearAction			varchar(50),
	ClearInterval		varchar(50),
	FlapInterval		varchar(50),
	RetentionInterval	varchar(50)
)

Create Table SyslogClient
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	AdminState			varchar(50),
	ForwardingFacility	varchar(50),
	Hostname			varchar(100),
	Name				varchar(50),
	Severity			varchar(50),
	Dn					varchar(100),
	Rn					varchar(50)
)

Create Table SyslogSource
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Rn				varchar(50),
	Audits			varchar(50),
	Events			varchar(50),
	Faults			varchar(50)
)

Create Table SyslogFile
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Rn				varchar(50),
	Name			varchar(50),
	AdminState		varchar(50),
	Severity		varchar(50),
	Size			int
)

Create Table MgmtBackupPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Descr			varchar(100),
	Host			varchar(100),
	LastBackup		varchar(50),
	Proto			varchar(50),
	Schedule		varchar(50),
	AdminState		varchar(50)
)

Create Table MgmtCfgExportPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Descr			varchar(100),
	Host			varchar(100),
	LastBackup		varchar(50),
	Proto			varchar(50),
	Schedule		varchar(50),
	AdminState		varchar(50)
)

Create Table NativeAuth
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Rn				varchar(50),
	DefLogin		varchar(50),
	ConLogin		varchar(50),
	DefRolePolicy	varchar(50)
)

Create Table CallHome
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	AdminState		varchar(50)
)

Create Table CallHomeSmtp
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Host			varchar(100)
)

Create Table CallHomeRecipient
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Email			varchar(100)
)

Create Table SNMP
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	AdminState		varchar(50),
	Community		varchar(50),
	SysContact		varchar(50),
	SysLocation		varchar(50)
)

Create Table DnsServer
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(50)
)

Create Table NtpServer
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(50)
)

Create Table Timezone
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Timezone		varchar(100)
)

Create Table ServiceProfiles
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	[Type]				varchar(50),
	Dn					varchar(100),
	Name				varchar(50),
	BiosProfileName		varchar(50),
	PnDn				varchar(100),
	BootPolicyName		varchar(50),
	HostFwPolicyName	varchar(50),
	LocalDiskPolicyName	varchar(50),
	MaintPolicyName		varchar(50),
	VconProfileName		varchar(50),
	OperSrcTemplName	varchar(100),
	AssocState			varchar(50),
	IdentPoolName		varchar(50),
	Uuid				varchar(100),
	OperState			varchar(20)
)

Create Table LdapProvider
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(50),
	Rootdn			varchar(200),
	Basedn			varchar(100),
	Attribute		varchar(50)
)

Create Table LdapGroupMap
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(200)
)

Create Table LsbootSanImagePath
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	[Type]			varchar(50),
	VnicName		varchar(50),
	Lun				varchar(50),
	Wwn				varchar(50)
)

Create Table MaintenancePolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(50),
	Dn				varchar(100),
	UptimeDisr		varchar(50),
	Descr			varchar(50)
)

Create Table FirmwareComputerHostPack
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Name				varchar(50),
	BladeBundleVersion	varchar(50),
	RackBundleVersion	varchar(50)
)

Create Table LocalDiskConfigPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	Mode			varchar(50),
	Descr			varchar(50)
)

Create Table ScrubPolicy
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Name				varchar(50),
	BiosSettingsScrub	varchar(50),
	DiskScrub			varchar(50)
)

Create Table BiosHyperThreading
(
	RID							int Primary Key Not Null Identity(1,1),
	DataSetID					int,
	Ucs							varchar(50),
	Dn							varchar(100),
	VpIntelHyperThreadingTech	varchar(50)
)

Create Table BiosVfSelectMemoryRASConfig
(
	RID								int Primary Key Not Null Identity(1,1),
	DataSetID						int,
	Ucs								varchar(50),
	Dn								varchar(100),
	VpSelectMemoryRASConfiguration	varchar(50)
)

Create Table LsVConAssign
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	VnicName		varchar(50),
	AdminVcon		varchar(50),
	[Order]			varchar(50),
	Transport		varchar(50)
)

Create Table IpPool
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	AssignmentOrder	varchar(50),
	Size			int
)

Create Table IpPoolBlock
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	[From]			varchar(50),
	[To]			varchar(50),
	Subnet			varchar(50),
	DefGw			varchar(50)
)

Create Table IpPoolAddr
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	AssignedToDn	varchar(100),
	Id				varchar(50)
)

Create Table UuidSuffixPool
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	AssignmentOrder	varchar(50),
	Prefix			varchar(50),
	Size			int,
	Assigned		int
)

Create Table UuidSuffixBlock
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(200),
	[From]			varchar(50),
	[To]			varchar(50)
)

Create Table UuidpoolAddr
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	AssignedToDn	varchar(100),
	Id				varchar(50)
)

Create Table MacPool
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	AssignmentOrder	varchar(50),
	Size			int,
	Assigned		int
)

Create Table MacMemberBlock
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(200),
	[From]			varchar(50),
	[To]			varchar(50)
)

Create Table Vnic
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	IdentPoolName	varchar(50),
	Addr			varchar(50)
)

Create Table WwnPool
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	AssignmentOrder	varchar(50),
	Purpose			varchar(50),
	Size			int,
	Assigned		int
)

Create Table Vhba
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	IdentPoolName	varchar(50),
	NodeAddr		varchar(50),
	Addr			varchar(50)
)

Create Table ServerPool
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	Assigned		int
)

Create Table ServerPoolAssignment
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Name			varchar(50),
	AssignedToDn	varchar(100)
)

Create Table LanCloud
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Rn				varchar(50),
	MacAging		varchar(50),
	Mode			varchar(50)
)

Create Table FabricPort
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	IfRole			varchar(50),
	LicState		varchar(50),
	Mode			varchar(50),
	OperState		varchar(50),
	OperSpeed		varchar(50),
	XcvrType		varchar(50)
)

Create Table UplinkPortChannel
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	OperSpeed		varchar(50),
	OperState		varchar(50),
	Transport		varchar(50)
)

Create Table UplinkPortChannelMember
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Membership		varchar(50)
)

Create Table QosClass
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	[Priority]		varchar(50),
	AdminState		varchar(50),
	[Cos]			varchar(50),
	[Weight]		varchar(50),
	[Drop]			varchar(50),
	Mtu				varchar(50)
)

Create Table QosPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50)
)

Create Table VnicEgressPolicy
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Prio			varchar(50)
)

Create Table NetworkControlPolicy
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Name				varchar(50),
	Cdp					varchar(50),
	UplinkFailAction	varchar(50)
)

Create Table VnicTemplate
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Name				varchar(50),
	Descr				varchar(50),
	SwitchId			varchar(50),
	TemplType			varchar(50),
	IdentPoolName		varchar(50),
	Mtu					int,
	NwCtrlPolicyName	varchar(50),
	QosPolicyName		varchar(50)
)

Create Table Vlan
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Id					int,
	Dn					varchar(100),
	Cloud				varchar(50),
	Name				varchar(50),
	SwitchId			varchar(50)
)

Create Table AdaptorVlan
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Dn					varchar(100),
	Name				varchar(50),
	Id					int,
	SwitchId			varchar(50)
)

Create Table SanCloud
(
	RID					int Primary Key Not Null Identity(1,1),
	DataSetID			int,
	Ucs					varchar(50),
	Rn					varchar(50),
	Mode				varchar(50)
)

Create Table FiFcPort
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	EpDn			varchar(100),
	SwitchId		varchar(50),
	SlotId			int,
	PortId			int,
	LicState		varchar(50),
	Mode			varchar(50),
	OperSpeed		varchar(50),
	OperState		varchar(50),
	Wwn				varchar(50)
)

Create Table FcUplinkPortChannel
(
	RID				int Primary Key Not Null Identity(1,1),	
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	OperSpeed		varchar(50),
	OperState		varchar(50),
	Transport		varchar(50)
)

Create Table FabricPort2
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	UCS				varchar(50),
	IfRole			varchar(50),
	EpDn			varchar(100),
	LicState		varchar(50),
	OperState		varchar(50),
	OperSpeed		varchar(50)
)

Create Table FabricFcoeSanPc
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	FcoeState		varchar(50),
	OperState		varchar(50),
	Transport		varchar(50),
	[Type]			varchar(50)
)

Create Table FabricFcoeSanPcEp
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	IfRole			varchar(50),
	LicState		varchar(50),
	Membership		varchar(50),
	OperState		varchar(50),
	SwitchId		varchar(50),
	PortId			varchar(50),
	[Type]			varchar(50)
)

Create Table Vsan
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Id				int,
	FcoeVlan		int,
	DefaultZoning	varchar(50)
)

Create Table VsanMemberFcPortChannel
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	EpDn			varchar(100),
	IfType			varchar(50)
)

Create Table VhbaTemplate
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	Name			varchar(50),
	Descr			varchar(50),
	SwitchId		varchar(50),
	TemplType		varchar(50),
	QosPolicyName	varchar(50)
)

Create Table AdaptorHostFcIf
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	VnicDn			varchar(100),
	Vendor			varchar(50),
	Model			varchar(50),
	LinkState		varchar(50),
	SwitchId		varchar(50),
	NodeWwn			varchar(50),
	Wwn				varchar(50)
)

Create Table VhbaInterface
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetID		int,
	Ucs				varchar(50),
	Dn				varchar(100),
	OperVnetName	varchar(50),
	[Initiator]		varchar(50)
)

Create Table CimXml
(
	RID				int Primary Key Not Null Identity(1,1),
	DataSetId		int,
	Ucs				varchar(50),
	Name			varchar(50),
	Descr			varchar(100),
	AdminState		varchar(50),
	OperPort		varchar(50),
	Port			varchar(50),
	Proto			varchar(50),
	Rn				varchar(50)
)
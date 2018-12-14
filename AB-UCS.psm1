
function Connect-ABUCS
{
    <#
        .SYNOPSIS
            Connect to a UCS instance using the standard Company read-only account.
        .DESCRIPTION
            Returns a UCS Connection Object using the standard Company read-only UCS account.
        .NOTES
            You should always clean up by calling Disconnect-UCS -Ucs <$Connection Object Variable>
        .PARAMETER Chassis
            This parameter is required to specify which UCS instance you are connecting to.
        .EXAMPLE
            PS C:\> $UCS = Connect-ABUCS -UCS UCSSSERVER1
    #>    
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$UCS
    ) # end param

    $user = "ucs-ldap\ldap-auth"
    $pass = "*************"

    $password = $pass | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object system.Management.Automation.PSCredential($user, $password)

    $UCSConn = Connect-Ucs -Name $UCS -Credential $cred -ea 0

    return $UCSConn
} # end function Connect-ABUCS

function Get-DatabaseData 
{
    <#
        .SYNOPSIS
            Returns a dataset object.
        .DESCRIPTION
            Returns a dataset object by executed a query against a database based on the connection string supplied.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .PARAMETER Query
            This parameter is the database query to run.  This ideally would be a select statment of some kind.
        .EXAMPLE
            PS C:\> Get-DatabaseData -verbose -connectionString (Get-UCSConnectionString) -query "Select InstanceName From UCSInstances Where Status = 'Online'"
    #>   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$connectionString = (Get-UCSConnectionString),
        [Parameter(Mandatory=$true)][string]$query
    ) # end param

    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString

    $command = $connection.CreateCommand()
    $command.CommandText = $query

    $adapter = New-Object -TypeName System.Data.SqlClient.SqlDataAdapter $command
    $dataset = New-Object -TypeName System.Data.DataSet
    $adapter.Fill($dataset) | Out-Null

    $dataset.Tables[0]
} # end function Get-DatabaseData 

function Invoke-DatabaseQuery 
{
    <#
        .SYNOPSIS
            Invokes a database command.
        .DESCRIPTION
            This function is for running commands against a database other than select statements.  This function does not return anything.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .PARAMETER Query
            This parameter is required.  This is the query that will be executed against the database specified in the connectionstring.
        .EXAMPLE
            PS C:\> Invoke-DatabaseQuery -verbose -connectionString (Get-UCSConnectionString) -query "Update UCSInstance Set Status = 'offline' where InstanceName = 'LABUCS001'"
    #>   
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$connectionString  = (Get-UCSConnectionString),
        [Parameter(Mandatory=$true)][string]$query
    ) # end param

    Write-Verbose $query
    $connection = New-Object -TypeName System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString

    $command = $connection.CreateCommand()
    $command.CommandText = $query

    $connection.Open()
    $command.ExecuteNonQuery()

    $connection.close()
} # end function Invoke-DatabaseQuery 
 
function Set-UCSInstanceStatus
{
    <#
        .SYNOPSIS
            Change the status of a UCS Instance in the database
        .DESCRIPTION
            This function is used to change the status of a given UCSInstance in the database.  This status determines if the 
            UCS Instance will be included in the results returned by Get-UCSInstanceList
        .PARAMETER UCS
            This parameter is the UCS entry to update in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .PARAMETER Status
            This parameter needs to be either 'Online' or 'Offline'.
        .EXAMPLE
            PS C:\> Set-UCSInstanceStatus -UCS LABUCS002 -Status offline
    #>   
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$Ucs,
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$ConnectionString = (Get-UCSConnectionString),
        [Parameter(Mandatory=$true)][ValidateSet("Online", "Offline")][string]$Status

    ) # end param

    $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Update UCSInstances Set Status = '$Status' Where InstanceName = '$UCS'" 
    return (Get-UCSInstanceStatus -Ucs $UCS)  
} # end function Set-UCSInstanceStatus

function Remove-UCSInstance
{
    <#
        .SYNOPSIS
            Deletes a UCS Instance from the database
        .DESCRIPTION
            This function is used to a given UCSInstance in the database.  
        .PARAMETER UCS
            This parameter is the UCS entry to update in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .EXAMPLE
            PS C:\> Remove-UCSInstance -UCS LABUCS003
    #>   
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$Ucs,
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$ConnectionString = (Get-UCSConnectionString)
    ) # end param

    $List = ""
    $List = Get-UCSInstanceList | Where-Object InstanceName -eq $UCS

    if ($List.InstanceName -eq $UCS)
    {
        $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Delete from UCSInstances Where InstanceName = '$UCS'"
        return "Operation was successful."
    }
    else
    {
        Write-Error "The specified UCS Instance ($UCS) was not found in the database.  Check the spelling and try again.  Use Get-UCSInstanceList to see which UCS Instances are in the database."
    } # end if
} # end function Remove-UCSInstance

function New-UCSInstance 
{
    <#
        .SYNOPSIS
            Add a UCS Instance to the database
        .DESCRIPTION
            This function is used to add a new UCSInstance in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .PARAMETER UCS
            This parameter is the UCS entry to add to the database.
        .PARAMETER IPAddress
            This parameter is the IP Address that the instance name resolves to.
        .PARAMETER Location
            This parameter is the location of the datacenter where this instance is installed. e.g. Nashville, Sterling, Sydney, etc...
        .PARAMETER Notes
            This parameter is for notes.
        .PARAMETER CoreDMZ
            This parameter is for the network location type.  e.g. Core, eDMZ, iDMZ etc...
        .PARAMETER DataCenter
            This parameter is for the DataCenter code for where the UCSInstance is located.
        .PARAMETER Status
            This parameter needs to be either 'online' or 'offline'.
        .EXAMPLE
            PS C:\> New-UCSInstance -UCS LABUCS002 -IPAddress 192.168.4.100 -Location Nashville -Notes 'In the lab yo' -CoreDMZ Core -DataCenter LAB
    #>  
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$Ucs,
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$ConnectionString = (Get-UCSConnectionString),
        [Parameter(Mandatory=$false)][Alias("ip")][String]$IPAddress,
        [Parameter(Mandatory=$false)][String]$Location,
        [Parameter(Mandatory=$false)][String]$Notes,
        [Parameter(Mandatory=$false)][ValidateSet("Core","eDMZ","iDMZ","Mixed")][String]$CoreDMZ = 'Core',
        [Parameter(Mandatory=$false)][ValidateSet("online", "offline")][string]$Status = 'online',
        [Parameter(Mandatory=$true)][ValidateSet("APN","CNBJ","ELO","JP2","JPK","LAB","NDC","NDP1","NED","NEW","NPR","SDC","SDP1","SED","SKT","SYD","TLC","VP3")][Alias("dc")][String]$DataCenter
    ) # end param

    $TableName = 'UCSInstances'
    $Fields =  "InstanceName,IPAddress,Location,Notes,CoreDMZ,Status,DataCenter"
    $Values =  "'$UCS','$IPAddress','$Location','$Notes','$CoreDMZ','$Status','$DataCenter'"
    $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
    Get-UCSInstanceDetails -UCS $UCS | Write-Output
} # end function New-UCSInstance 

function Get-UCSInstanceDetails
{
    <#
        .SYNOPSIS
            Gets the status of a UCS Instance in the database
        .DESCRIPTION
            This function is used to get the status of a given UCSInstance in the database.  This status determines if the 
            UCS Instance will be included in the results returned by Get-UCSInstanceList
        .PARAMETER UCS
            This parameter is the UCS entry to update in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .PARAMETER Status
            This parameter needs to be either 'online' or 'offline'.
        .EXAMPLE
            PS C:\> Get-UCSInstanceDetails -UCS LABUCS002

            RID          : 23
            InstanceName : LABUCS002
            IPAddress    : 10.98.34.200
            Location     : Austin
            Notes        :
            CoreDmz      : Core
            Status       : offline
            DataCenter   : LAB
        .EXAMPLE
            PS C:\> 'LABUCS001','NPRUCS001' | Get-UCSInstanceDetails

            RID          : 22
            InstanceName : LABUCS001
            IPAddress    : 10.98.34.100
            Location     : Austin
            Notes        :
            CoreDmz      : Core
            Status       : Online
            DataCenter   : LAB

            RID          : 3
            InstanceName : NPRUCS001
            IPAddress    : 10.93.99.10
            Location     : Austin
            Notes        :
            CoreDmz      : Core
            Status       : Online
            DataCenter   : NPR

        .EXAMPLE
            PS C:\> Get-UCSInstanceList | Get-UCSInstanceDetails

            RID InstanceName             IPAddress                Location                 Notes                    CoreDmz                  Status                   DataCenter
            --- ------------             ---------                --------                 -----                    -------                  ------                   ----------
    #>   
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]$Ucs
    ) # end param

    process
    {
        $Ucs | ForEach-Object { 
            $Instance = $_
            If ($_ -is [System.Data.DataRow]) { $Instance = $Instance.InstanceName }
            $InstanceDetails = Get-DatabaseData -verbose -connectionString (Get-UCSConnectionString) -query "Select * From UCSInstances Where InstanceName = '$Instance'"  
            $InstanceDetails | Write-Output
        } # end foreach
    } # end process
} # end function Get-UCSInstanceDetails

function Get-UCSInstanceStatus
{
    <#
        .SYNOPSIS
            Gets the status of a UCS Instance in the database
        .DESCRIPTION
            This function is used to get the status of a given UCSInstance in the database.  This status determines if the 
            UCS Instance will be included in the results returned by Get-UCSInstanceList
        .PARAMETER UCS
            This parameter is the UCS entry to update in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .PARAMETER Status
            This parameter needs to be either 'online' or 'offline'.
        .EXAMPLE
            PS C:\> Get-UCSInstanceStatus -UCS LABUCS002
    #>   
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$Ucs,
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$ConnectionString = (Get-UCSConnectionString)
    ) # end param

    $InstanceStatus = Get-DatabaseData -verbose -connectionString (Get-UCSConnectionString) -query "Select InstanceName,Status From UCSInstances Where InstanceName = '$UCS'"
    return $InstanceStatus
} # end function Get-UCSInstanceStatus

function Get-UCSConnectionString
{
    <#
        .SYNOPSIS
            This function returns a connection string for the UCS database.
        .DESCRIPTION
            This function is a easy place to store the connection information for the UCS database.
        .EXAMPLE
            PS C:\PS Script\UCS> Get-UCSConnectionString
            Server=SQLUCS\UCS;Database=UCS;Integrated Security=true
    #>   
    [CmdletBinding()]
    param()
    $DBServer = 'SQLUCS\UCS'
    $DBName   = 'UCS'

    $ConnectionString = "Server=$DBServer;Database=$DBName;Integrated Security=true"
    return $ConnectionString
} # end function Get-UCSConnectionString

function Get-UCSInstanceList
{
    <#
        .SYNOPSIS
            This function returns a list of UCS Instances in the UCS database that have a status of 'online'.
        .DESCRIPTION
            This function returns a list of UCS Instances in the UCS database that have a status of 'online'.
            Use Get-UCSInstanceStatus to check the status and Set-UCSInstanceStatus to change the status of a UCS instance.
        .NOTES
            I need to add a parameter to allow returning all UCS Instances regardless of status.
        .EXAMPLE
            PS C:\> Get-UCSInstanceList

            InstanceName
            ------------
            ...

    #>   
    [CmdletBinding()]
    param()
    $InstanceList = Get-DatabaseData -verbose -connectionString (Get-UCSConnectionString) -query "Select InstanceName From UCSInstances Where Status = 'Online'"
    return $InstanceList
} # end function Get-UCSInstanceList

function Invoke-UCSPowerReadingDataCollection
{
    <#
        .SYNOPSIS
            Collect power readings from all of the UCS instances and write the results to the database.
        .DESCRIPTION
            Loop through a list of UCS Instances that is generated with (Get-UCSInstanceList) and collect power usage stats and 
            write that data to the UCS database.
        .EXAMPLE
            PS C:\> Invoke-UCSPowerReadingsDataCollection
    #>   
    [CmdletBinding()]
    param()
    Get-UCSInstanceList | ForEach-Object { Get-UCSPowerReading -UCS $_.InstanceName -ConnectionString (Get-UCSConnectionString) }
} # end function Invoke-UCSPowerReadingDataCollection

function Invoke-UcsInstanceDataCollection
{
    <#
        .SYNOPSIS
            Collect all data from all of the UCS instances and write the results to the database as a new dataset.
        .DESCRIPTION
             Loop through a list of UCS Instances that is generated with (Get-UCSInstanceList) and collect all useful UCS data
             and write that data to the UCS database using a new DataSetID.
        .EXAMPLE
            PS C:\> Invoke-UcsInstanceDataCollection
    #>   
    [CmdletBinding()]
    param()
    Get-UCSInstanceList | ForEach-Object { Get-UCSData -UCS $_.InstanceName -ConnectionString (Get-UCSConnectionString) }
} # end function Invoke-UcsInstanceDataCollection

function Get-UCSPowerReading
{
    <#
        .SYNOPSIS
            Collect power readings from a UCS instance and write the results to the database.
        .DESCRIPTION
            Collect power readings from a UCS instance and write the results to the database.
        .PARAMETER UCS
            This parameter is the UCS entry to update in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .EXAMPLE
            PS C:\> Get-UCSPowerReadings -UCS LABUCS001 -connectionstring (Get-UCSConnectionString)
    #>   
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$Ucs,
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$ConnectionString = (Get-UCSConnectionString)
    ) # end param

    $DateTime = Get-Date

    $UCSConnArray = Connect-ABUCS -Ucs $UCS   

    # Check to see if we made a connection to a chassis
    if($null -ne $UCSConnArray)
    {
        $UCSConnStatus = 'Successful'

        $null = Get-UcsPowerGroup -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,Descr,AdminPeak,CurReqPower,CurrentPower,MinReqPower,OperState,Realloc,Name | ForEach-Object {
            $TableName = 'PowerReadingGroup'
            $Fields =  "TimeStamp,Ucs,Dn,Rn,Descr,AdminPeak,CurReqPower,CurrentPower,MinReqPower,OperState,Realloc,Name"
            $Values =  "'$DateTime','$UCS','$($_.Dn)','$($_.Rn)','$($_.Descr)','$($_.AdminPeak)','$($_.CurReqPower)','$($_.CurrentPower)','$($_.MinReqPower)','$($_.OperState)','$($_.Realloc)','$($_.Name)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        }

        $null = Get-UcsPowerBudget -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,GroupName,DynRealloc,CapAction,OperState,Prio,PsuState,PsuCapacity,Style,UpdateTime,AdminCommitted,AdminPeak,CatalogPower,CurrentPower,IdlePower,MaxPower,MinPower,OperCommitted,OperMin,OperPeak,ScaledWt,Weight,Status | ForEach-Object {
            $TableName = 'PowerReadingBudget'
            $Fields =  "TimeStamp,Ucs,Dn,Rn,GroupName,DynRealloc,CapAction,OperState,Prio,PsuState,PsuCapacity,Style,UpdateTime,AdminCommitted,AdminPeak,CatalogPower,CurrentPower,IdlePower,MaxPower,MinPower,OperCommitted,OperMin,OperPeak,ScaledWt,Weight,Status"
            $Values =  "'$DateTime','$UCS','$($_.Dn)','$($_.Rn)','$($_.GroupName)','$($_.DynRealloc)','$($_.CapAction)','$($_.OperState)','$($_.Prio)','$($_.PsuState)','$($_.PsuCapacity)','$($_.Style)','$($_.UpdateTime)','$($_.AdminCommitted)','$($_.AdminPeak)','$($_.CatalogPower)','$($_.CurrentPower)','$($_.IdlePower)','$($_.MaxPower)','$($_.MinPower)','$($_.OperCommitted)','$($_.OperMin)','$($_.OperPeak)','$($_.ScaledWt)','$($_.Weight)','$($_.Status)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        }

    } 
    else
    {
        $UCSConnStatus = 'Failed'
    } # End Chassis Check if statement

    $info = [ordered]@{
        'UCS' = "$Ucs";       
        'Status' = "$UCSConnStatus";
    } # end ordered hash

    $object = New-Object -TypeName psobject -Property $info     
    return $object
} # end function Get-UCSPowerReading

function Get-UCSData
{
    <#
        .SYNOPSIS
            Collect all data from a UCS instance and write the results to the database as a new dataset.
        .DESCRIPTION
            Collect all data from a UCS instance and write the results to the database as a new dataset.
        .PARAMETER UCS
            This parameter is the UCS entry to update in the database.
        .PARAMETER ConnectionString
            This parameter is required to connect to a database to run a query.  This is a standard format connection string.
            A default is used if not supplied.  To see the default run cmdlet: Get-UCSConnectionString.
        .EXAMPLE
            PS C:\> Get-UCSData -UCS LABUCS001 -connectionstring (Get-UCSConnectionString)
    #>   
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory=$true)][string]$Ucs,
        [Parameter(Mandatory=$false)][Alias("conn","cs")][string]$ConnectionString = (Get-UCSConnectionString)
    ) # end param

    $DateTime = Get-Date

    $UCSConnArray = Connect-ABUCS -Ucs $UCS   

    # Check to see if we made a connection to a chassis
    if($null -ne $UCSConnArray)
    {
        $UCSConnStatus = 'Successful'
        $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Update CollectionData Set RecordStatus = 'historical' Where Ucs = '$UCS'"
        $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into CollectionData (RecordStatus,DateCollected,UCS) values ('Active','$DateTime','$UCS')"
        $DataSetID = (Get-DatabaseData -verbose -connectionString $ConnectionString -query "Select DataSetID From CollectionData Where Ucs = '$UCS' and RecordStatus = 'Active'").DataSetID

        $InstanceFWVersion = ((Get-UcsFirmwareRunning -Ucs $UCSConnArray | Where-Object type -eq mgmt-ext | Select-Object version).Version).Split('(')[0]
    
        $null = Get-UcsNetworkElement -Ucs $UCSConnArray | Select-Object Ucs,Rn,Dn,OobIfIp,OobIfMask,OobIfGw,Operability,Model,Serial | ForEach-Object {
            $TableName = 'NetworkElements'
            $Fields =  "DataSetID,Ucs,Rn,Dn,OobIfIP,OobIfMask,OobIfGw,Operability,Model,Serial"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.Dn)','$($_.OobIfIP)','$($_.OobIfMask)','$($_.OobIfGw)','$($_.Operability)','$($_.Model)','$($_.Serial)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFiModule -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn | Select-Object Ucs,Dn,Rn,Model,Descr,OperState,State,Serial | ForEach-Object {
            $TableName = 'FiModules'
            $Fields =  "DataSetID,Ucs,Dn,Rn,Model,Descr,OperState,State,Serial"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.Model)','$($_.Descr)','$($_.OperState)','$($_.State)','$($_.Serial)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLocatorLed -UCS $UCSConnArray | Select-Object -Property DN,AdminState,OperState,Color | ForEach-Object {
            $TableName = 'LocatorLED'
            $Fields = "DataSetID,UCS,DN,AdminState,OperState,Color"
            $Values = "'$DataSetID','$UCS','$($_.DN)','$($_.AdminState)','$($_.OperState)','$($_.Color)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLicense -Ucs $UCSConnArray | Sort-Object -Property Ucs,Scope | Select-Object Ucs,Sku,Scope,AbsQuant,UsedQuant,PeerStatus,OperState | ForEach-Object {
            $TableName = 'Licenses'
            $Fields =  "DataSetID,Ucs,Sku,Scope,AbsQuant,UsedQuant,PeerStatus,OperState"
            $Values =  "'$DataSetID','$UCS','$($_.Sku)','$($_.Scope)','$($_.AbsQuant)','$($_.UsedQuant)','$($_.PeerStatus)','$($_.OperState)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsChassis -Ucs $UCSConnArray | Sort-Object -Property Ucs,Rn | Select-Object Ucs,Rn,Dn,id,AdminState,Model,OperState,LicState,Power,Thermal,Serial | ForEach-Object {
            $TableName = 'Chassis'
            $Fields =  "DataSetID,Ucs,Rn,Dn,ChassisID,AdminState,Model,OperState,LicState,Power,Thermal,Serial"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.Dn)','$($_.ID)','$($_.AdminState)','$($_.Model)','$($_.OperState)','$($_.LicState)','$($_.Power)','$($_.Thermal)','$($_.Serial)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsIom -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn | Select-Object Ucs,ChassisId,Dn,Rn,Model,Discovery,ConfigState,OperState,Side,Thermal,Serial,SwitchID | ForEach-Object {
            $TableName = 'IOM'
            $Fields =  "DataSetID,Ucs,ChassisId,Dn,Rn,Model,Discovery,ConfigState,OperState,Side,Thermal,Serial,SwitchID"
            $Values =  "'$DataSetID','$UCS','$($_.ChassisId)','$($_.Dn)','$($_.Rn)','$($_.Model)','$($_.Discovery)','$($_.ConfigState)','$($_.OperState)','$($_.Side)','$($_.Thermal)','$($_.Serial)','$($_.SwitchID)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsEtherSwitchIntFIo -Ucs $UCSConnArray | Select-Object Ucs,ChassisId,Dn,Rn,PeerDn,Discovery,Model,OperState,SwitchId,PeerSlotId,PeerPortId,SlotId,PortId,XcvrType | ForEach-Object {
            $TableName = 'EtherSwitchIntFIos'
            $Fields =  "DataSetID,Ucs,ChassisId,Dn,Rn,PeerDn,Discovery,Model,OperState,SwitchId,PeerSlotId,PeerPortId,SlotId,PortId,XcvrType"
            $Values =  "'$DataSetID','$UCS','$($_.ChassisId)','$($_.Dn)','$($_.Rn)','$($_.PeerDn)','$($_.Discovery)','$($_.Model)','$($_.OperState)','$($_.SwitchId)','$($_.PeerSlotId)','$($_.PeerPortId)','$($_.SlotId)','$($_.PortId)','$($_.XcvrType)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsBlade -Ucs $UCSConnArray | Sort-Object -Property Ucs,ChassisID,SlotID | Select-Object Ucs,AdminState,AssignedToDn,AvailableMemory,ChassisId,Descr,ManagingInst,MemorySpeed,Model,Name,NumOfAdaptors,NumOfCores,NumOfCoresEnabled,NumOfCpus,NumOfEthHostIfs,NumOfFcHostIfs,NumOfThreads,OperPower,OperState,Operability,PartNumber,Presence,Serial,SlotId,TotalMemory,UsrLbl,Vendor,Dn,Rn | ForEach-Object {
            $TableName = 'Blades'
            $Fields =  "DataSetID,Ucs,AdminState,AssignedToDn,AvailableMemory,ChassisId,Descr,ManagingInst,MemorySpeed,Model,Name,NumOfAdaptors,NumOfCores,NumOfCoresEnabled,NumOfCpus,NumOfEthHostIfs,NumOfFcHostIfs,NumOfThreads,OperPower,OperState,Operability,PartNumber,Presence,Serial,SlotId,TotalMemory,UsrLbl,Vendor,Dn,Rn"
            $Values =  "'$DataSetID','$UCS','$($_.AdminState)','$($_.AssignedToDn)','$($_.AvailableMemory)','$($_.ChassisId)','$($_.Descr)','$($_.ManagingInst)','$($_.MemorySpeed)','$($_.Model)','$($_.Name)','$($_.NumOfAdaptors)','$($_.NumOfCores)','$($_.NumOfCoresEnabled)','$($_.NumOfCpus)','$($_.NumOfEthHostIfs)','$($_.NumOfFcHostIfs)','$($_.NumOfThreads)','$($_.OperPower)','$($_.OperState)','$($_.Operability)','$($_.PartNumber)','$($_.Presence)','$($_.Serial)','$($_.SlotId)','$($_.TotalMemory)','$($_.UsrLbl)','$($_.Vendor)','$($_.Dn)','$($_.Rn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsRackUnit -Ucs $UCSConnArray | Sort-Object -Property Ucs,ID | Select-Object Ucs,AdminState,AssignedToDn,AvailableMemory,Id,Descr,ManagingInst,MemorySpeed,Model,Name,NumOfAdaptors,NumOfCores,NumOfCoresEnabled,NumOfCpus,NumOfEthHostIfs,NumOfFcHostIfs,NumOfThreads,OperPower,OperState,Operability,PartNumber,Presence,Serial,TotalMemory,UsrLbl,Vendor,Dn,Rn | ForEach-Object {
            $TableName = 'RackUnit'
            $Fields =  "DataSetID,Ucs,AdminState,AssignedToDn,AvailableMemory,Id,Descr,ManagingInst,MemorySpeed,Model,Name,NumOfAdaptors,NumOfCores,NumOfCoresEnabled,NumOfCpus,NumOfEthHostIfs,NumOfFcHostIfs,NumOfThreads,OperPower,OperState,Operability,PartNumber,Presence,Serial,TotalMemory,UsrLbl,Vendor,Dn,Rn"
            $Values =  "'$DataSetID','$UCS','$($_.AdminState)','$($_.AssignedToDn)','$($_.AvailableMemory)','$($_.Id)','$($_.Descr)','$($_.ManagingInst)','$($_.MemorySpeed)','$($_.Model)','$($_.Name)','$($_.NumOfAdaptors)','$($_.NumOfCores)','$($_.NumOfCoresEnabled)','$($_.NumOfCpus)','$($_.NumOfEthHostIfs)','$($_.NumOfFcHostIfs)','$($_.NumOfThreads)','$($_.OperPower)','$($_.OperState)','$($_.Operability)','$($_.PartNumber)','$($_.Presence)','$($_.Serial)','$($_.TotalMemory)','$($_.UsrLbl)','$($_.Vendor)','$($_.Dn)','$($_.Rn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFabricComputeSlotEp -Ucs $UCSConnArray | Sort-Object -Property ChassisID,SlotId | Select-Object Ucs,ChassisID,SlotId,presence | ForEach-Object {
            $TableName = 'Slots'
            $Fields =  "DataSetID,Ucs,ChassisId,SlotId,Presence"
            $Values =  "'$DataSetID','$UCS','$($_.ChassisId)','$($_.SlotId)','$($_.presence)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsAdaptorUnit -Ucs $UCSConnArray | Where-Object {$_.ChassisID -ne 'N/A'} | Sort-Object -Property Ucs,Dn | Select-Object Ucs,ChassisId,BladeId,Dn,Rn,Model,Serial | ForEach-Object {
            $TableName = 'AdaptorUnits'
            $Fields =  "DataSetID,Ucs,ChassisId,BladeId,Dn,Rn,Model,Serial"
            $Values =  "'$DataSetID','$UCS','$($_.ChassisId)','$($_.BladeId)','$($_.Dn)','$($_.Rn)','$($_.Model)','$($_.Serial)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsProcessorUnit -Ucs $UCSConnArray | Where-Object {$_.Arch -ne 'any'} | Sort-Object -Property Ucs,Dn | Select-Object Ucs,Dn,Rn,SocketDesignation,Cores,CoresEnabled,Threads,Speed,OperState,Thermal,Model | Where-Object {$_.OperState -ne "removed"} | ForEach-Object {
            $TableName = 'ProcessorUnit'
            $Fields =  "DataSetID,Ucs,Dn,Rn,SocketDesignation,Cores,CoresEnabled,Threads,Speed,OperState,Thermal,Model"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.SocketDesignation)','$($_.Cores)','$($_.CoresEnabled)','$($_.Threads)','$($_.Speed)','$($_.OperState)','$($_.Thermal)','$($_.Model)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsStorageController -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn | Select-Object Ucs,Dn,Rn,Vendor,Model | ForEach-Object {
            $TableName = 'StorageController'
            $Fields =  "DataSetID,Ucs,Dn,Rn,Vendor,Model"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.Vendor)','$($_.Model)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsStorageLocalDisk -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn | Select-Object Ucs,Dn,Model,Size,Serial | Where-Object {$_.Size -ne "unknown"} | ForEach-Object {
            $TableName = 'StorageLocalDisk'
            $Fields =  "DataSetID,Ucs,Dn,Model,Size,Serial"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Model)','$($_.Size)','$($_.Serial)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsBootPolicy -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn | Select-Object Ucs,Dn,Rn,Name,Descr,Purpose | ForEach-Object {
            $TableName = 'BootPolicy'
            $Fields =  "DataSetID,Ucs,Dn,Rn,Name,Descr,Purpose"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.Name)','$($_.Descr)','$($_.Purpose)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsStatus -Ucs $UCSConnArray | Select-Object Ucs,Name,VirtualIpv4Address,HaConfiguration,HaReadiness,HaReady,FiALeadership,FiAOobIpv4Address,FiAOobIpv4DefaultGateway,FiAManagementServicesState,FiBLeadership,FiBOobIpv4Address,FiBOobIpv4DefaultGateway,FiBManagementServicesState | ForEach-Object {
            $TableName = 'UCSStatus'
            $Fields =  "DataSetID,Ucs,Name,VirtualIpv4Address,HaConfiguration,HaReadiness,HaReady,FiALeadership,FiAOobIpv4Address,FiAOobIpv4DefaultGateway,FiAManagementServicesState,FiBLeadership,FiBOobIpv4Address,FiBOobIpv4DefaultGateway,FiBManagementServicesState"
            $Values =  "'$DataSetID','$UCS','$($_.Name)','$($_.VirtualIpv4Address)','$($_.HaConfiguration)','$($_.HaReadiness)','$($_.HaReady)','$($_.FiALeadership)','$($_.FiAOobIpv4Address)','$($_.FiAOobIpv4DefaultGateway)','$($_.FiAManagementServicesState)','$($_.FiBLeadership)','$($_.FiBOobIpv4Address)','$($_.FiBOobIpv4DefaultGateway)','$($_.FiBManagementServicesState)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFirmwareRunning -Ucs $UCSConnArray | Select-Object Ucs,Deployment,Dn,Type,Version,PackageVersion | Sort-Object -Property Ucs,Dn | ForEach-Object {
            $TableName = 'Firmware'
            $Fields =  "DataSetID,Ucs,Deployment,Dn,Type,Version,PackageVersion"
            $Values =  "'$DataSetID','$UCS','$($_.Deployment)','$($_.Dn)','$($_.Type)','$($_.Version)','$($_.PackageVersion)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsMgmtInterfaceMonitorPolicy -Ucs $UCSConnArray | Select-Object UCS,AdminState,EnableHAFailover,MonitorMechanism | ForEach-Object {
            $TableName = 'MgmtInterfaceMonitoringPolicy'
            $Fields =  "DataSetID,Ucs,AdminState,EnableHAFailover,MonitorMechanism"
            $Values =  "'$DataSetID','$UCS','$($_.AdminState)','$($_.EnableHAFailover)','$($_.MonitorMechanism)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsChassisDiscoveryPolicy -Ucs $UCSConnArray | Select-Object Ucs,Rn,LinkAggregationPref,Action | ForEach-Object {
            $TableName = 'ChassisDiscoveryPolicy'
            $Fields =  "DataSetID,Ucs,Rn,LinkAggregationPref,Action"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.LinkAggregationPref)','$($_.Action)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsPowerControlPolicy -Ucs $UCSConnArray | Select-Object Ucs,Rn,Redundancy | ForEach-Object {
            $TableName = 'PowerControlPolicy'
            $Fields =  "DataSetID,Ucs,Rn,Redundancy"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.Redundancy)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsPowerGroup -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,Descr,AdminPeak,CurReqPower,CurrentPower,MinReqPower,OperState,Realloc,Name | ForEach-Object {
            $TableName = 'PowerGroup'
            $Fields =  "DataSetID,Ucs,Dn,Rn,Descr,AdminPeak,CurReqPower,CurrentPower,MinReqPower,OperState,Realloc,Name"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.Descr)','$($_.AdminPeak)','$($_.CurReqPower)','$($_.CurrentPower)','$($_.MinReqPower)','$($_.OperState)','$($_.Realloc)','$($_.Name)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsPowerBudget -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,GroupName,DynRealloc,CapAction,OperState,Prio,PsuState,PsuCapacity,Style,UpdateTime,AdminCommitted,AdminPeak,CatalogPower,CurrentPower,IdlePower,MaxPower,MinPower,OperCommitted,OperMin,OperPeak,ScaledWt,Weight,Status | ForEach-Object {
            $TableName = 'PowerBudget'
            $Fields =  "DataSetID,Ucs,Dn,Rn,GroupName,DynRealloc,CapAction,OperState,Prio,PsuState,PsuCapacity,Style,UpdateTime,AdminCommitted,AdminPeak,CatalogPower,CurrentPower,IdlePower,MaxPower,MinPower,OperCommitted,OperMin,OperPeak,ScaledWt,Weight,Status"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.GroupName)','$($_.DynRealloc)','$($_.CapAction)','$($_.OperState)','$($_.Prio)','$($_.PsuState)','$($_.PsuCapacity)','$($_.Style)','$($_.UpdateTime)','$($_.AdminCommitted)','$($_.AdminPeak)','$($_.CatalogPower)','$($_.CurrentPower)','$($_.IdlePower)','$($_.MaxPower)','$($_.MinPower)','$($_.OperCommitted)','$($_.OperMin)','$($_.OperPeak)','$($_.ScaledWt)','$($_.Weight)','$($_.Status)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsPowerChassisMember -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,Id,OperState | ForEach-Object {
            $TableName = 'PowerChassisMember'
            $Fields =  "DataSetID,Ucs,Dn,Rn,Id,OperState"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.Id)','$($_.OperState)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsOrg -Ucs $UCSConnArray | Select-Object Ucs,Name,Dn | ForEach-Object {
            $TableName = 'Org'
            $Fields =  "DataSetID,Ucs,Name,Dn"
            $Values =  "'$DataSetID','$UCS','$($_.Name)','$($_.Dn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFaultPolicy -Ucs $UCSConnArray | Select-Object Ucs,Rn,AckAction,ClearAction,ClearInterval,FlapInterval,RetentionInterval | ForEach-Object {
            $TableName = 'FaultPolicy'
            $Fields =  "DataSetID,Ucs,Rn,AckAction,ClearAction,ClearInterval,FlapInterval,RetentionInterval"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.AckAction)','$($_.ClearAction)','$($_.ClearInterval)','$($_.FlapInterval)','$($_.RetentionInterval)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        }# end foreach   

        $null = Get-UcsFault -Ucs $UCSConnArray | Sort-Object -Property Ucs,Severity -Descending | Select-Object Ucs,Severity,Created,Descr,dn | ForEach-Object {
            $TableName = 'Fault'
            $Fields =  "DataSetID,Ucs,Severity,Created,Descr,dn"
            $Values =  "'$DataSetID','$UCS','$($_.Severity)','$($_.Created)','$($_.Descr.Replace("'","''"))','$($_.dn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsSyslogClient -Ucs $UCSConnArray | Where-Object {$_.AdminState -ne "disabled"} | Select-Object Ucs,AdminState,ForwardingFacility,Hostname,Name,Severity,Dn,Rn | ForEach-Object {
            $TableName = 'SyslogClient'
            $Fields =  "DataSetID,Ucs,AdminState,ForwardingFacility,Hostname,Name,Severity,Dn,Rn"
            $Values =  "'$DataSetID','$UCS','$($_.AdminState)','$($_.ForwardingFacility)','$($_.Hostname)','$($_.Name)','$($_.Severity)','$($_.Dn)','$($_.Rn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsSyslogSource -Ucs $UCSConnArray | Select-Object Ucs,Rn,Audits,Events,Faults | ForEach-Object {
            $TableName = 'SyslogSource'
            $Fields =  "DataSetID,Ucs,Rn,Audits,Events,Faults"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.Audits)','$($_.Events)','$($_.Faults)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsSyslogFile -Ucs $UCSConnArray | Select-Object Ucs,Rn,Name,AdminState,Severity,Size | ForEach-Object {
            $TableName = 'SyslogFile'
            $Fields =  "DataSetID,Ucs,Rn,Name,AdminState,Severity,Size"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.Name)','$($_.AdminState)','$($_.Severity)','$($_.Size)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        # The following CiscoUCSPS Cmdlets only return data if the Firmware Version is at least 2.0
        if($InstanceFWVersion -ne "2.0")
        {
            $null = Get-UcsMgmtBackupPolicy -Ucs $UCSConnArray | Select-Object Ucs,Descr,Host,LastBackup,Proto,Schedule,AdminState | ForEach-Object {
                $TableName = 'MgmtBackupPolicy'
                $Fields =  "DataSetID,Ucs,Descr,Host,LastBackup,Proto,Schedule,AdminState"
                $Values =  "'$DataSetID','$UCS','$($_.Descr)','$($_.Host)','$($_.LastBackup)','$($_.Proto)','$($_.Schedule)','$($_.AdminState)'"
                $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
            } # end foreach

            $null = Get-UcsMgmtCfgExportPolicy -Ucs $UCSConnArray | Select-Object Ucs,Descr,Host,LastBackup,Proto,Schedule,AdminState | ForEach-Object {
                $TableName = 'MgmtCfgExportPolicy'
                $Fields =  "DataSetID,Ucs,Descr,Host,LastBackup,Proto,Schedule,AdminState"
                $Values =  "'$DataSetID','$UCS','$($_.Descr)','$($_.Host)','$($_.LastBackup)','$($_.Proto)','$($_.Schedule)','$($_.AdminState)'"
                $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
            } # end foreach

            $null = Get-UcsLsVConAssign -Ucs $UCSConnArray | Select-Object UCS,dn,vnicname,adminvcon,order,transport | Sort-Object dn | ForEach-Object {
                $TableName = 'LsVConAssign'
                $Fields =  "DataSetID,Ucs,dn,vnicname,adminvcon,[order],transport"
                $Values =  "'$DataSetID','$UCS','$($_.dn)','$($_.vnicname)','$($_.adminvcon)','$($_.order)','$($_.transport)'"
                $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
            } # end foreach

            $null = Get-UcsFabricFcoeSanPc -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,FcoeState,OperState,Transport,Type | ForEach-Object {
                $TableName = 'FabricFcoeSanPc'
                $Fields =  "DataSetID,Ucs,Dn,Name,FcoeState,OperState,Transport,Type"
                $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.FcoeState)','$($_.OperState)','$($_.Transport)','$($_.Type)'"
                $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
            } # end foreach

            $null = Get-UcsFabricFcoeSanPcEp -Ucs $UCSConnArray | Select-Object Ucs,Dn,IfRole,LicState,Membership,OperState,SwitchId,PortId,Type | ForEach-Object {
                $TableName = 'FabricFcoeSanPcEp'
                $Fields =  "DataSetID,Ucs,Dn,IfRole,LicState,Membership,OperState,SwitchId,PortId,Type"
                $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.IfRole)','$($_.LicState)','$($_.Membership)','$($_.OperState)','$($_.SwitchId)','$($_.PortId)','$($_.Type)'"
                $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
            } # end foreach
        } # end Firmware Version > 2.0 Cmdlets

        $null = Get-UcsNativeAuth -Ucs $UCSConnArray | Select-Object Ucs,Rn,DefLogin,ConLogin,DefRolePolicy | ForEach-Object {
            $TableName = 'NativeAuth'
            $Fields =  "DataSetID,Ucs,Rn,DefLogin,ConLogin,DefRolePolicy"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.DefLogin)','$($_.ConLogin)','$($_.DefRolePolicy)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsCallhome -Ucs $UCSConnArray | Sort-Object -Property Ucs | Select-Object Ucs,AdminState | ForEach-Object {
            $TableName = 'CallHome'
            $Fields =  "DataSetID,Ucs,AdminState"
            $Values =  "'$DataSetID','$UCS','$($_.AdminState)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsCallhomeSmtp -Ucs $UCSConnArray | Sort-Object -Property Ucs | Select-Object Ucs,Host | ForEach-Object {
            $TableName = 'CallHomeSmtp'
            $Fields =  "DataSetID,Ucs,Host"
            $Values =  "'$DataSetID','$UCS','$($_.Host)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsCallhomeRecipient -Ucs $UCSConnArray | Sort-Object -Property Ucs | Select-Object Ucs,Dn,Email | ForEach-Object {
            $TableName = 'CallHomeRecipient'
            $Fields =  "DataSetID,Ucs,Dn,Email"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Email)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsSnmp -Ucs $UCSConnArray | Sort-Object -Property Ucs | Select-Object Ucs,AdminState,Community,SysContact,SysLocation | ForEach-Object {
            $TableName = 'SNMP'
            $Fields =  "DataSetID,Ucs,AdminState,Community,SysContact,SysLocation"
            $Values =  "'$DataSetID','$UCS','$($_.AdminState)','$($_.Community)','$($_.SysContact)','$($_.SysLocation)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsDnsServer -Ucs $UCSConnArray | Select-Object Ucs,Name | ForEach-Object {
            $TableName = 'DnsServer'
            $Fields =  "DataSetID,Ucs,Name"
            $Values =  "'$DataSetID','$UCS','$($_.Name)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsNtpServer -Ucs $UCSConnArray | Select-Object Ucs,Name | ForEach-Object {
            $TableName = 'NtpServer'
            $Fields =  "DataSetID,Ucs,Name"
            $Values =  "'$DataSetID','$UCS','$($_.Name)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsTimezone -Ucs $UCSConnArray | Select-Object Ucs,Timezone | ForEach-Object {
            $TableName = 'Timezone'
            $Fields =  "DataSetID,Ucs,Timezone"
            $Values =  "'$DataSetID','$UCS','$($_.Timezone)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsServiceProfile -Ucs $UCSConnArray | Sort-object -Property Ucs,Type,Name | Select-Object Ucs,Type,Dn,Name,BiosProfileName,PnDn,BootPolicyName,HostFwPolicyName,LocalDiskPolicyName,MaintPolicyName,VconProfileName,OperSrcTemplName,AssocState,IdentPoolName,Uuid,OperState | ForEach-Object {
            $TableName = 'ServiceProfiles'
            $Fields =  "DataSetID,Ucs,Type,Dn,Name,BiosProfileName,PnDn,BootPolicyName,HostFwPolicyName,LocalDiskPolicyName,MaintPolicyName,VconProfileName,OperSrcTemplName,AssocState,IdentPoolName,Uuid,OperState"
            $Values =  "'$DataSetID','$UCS','$($_.Type)','$($_.Dn)','$($_.Name)','$($_.BiosProfileName)','$($_.PnDn)','$($_.BootPolicyName)','$($_.HostFwPolicyName)','$($_.LocalDiskPolicyName)','$($_.MaintPolicyName)','$($_.VconProfileName)','$($_.OperSrcTemplName)','$($_.AssocState)','$($_.IdentPoolName)','$($_.Uuid)','$($_.OperState)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLdapProvider -Ucs $UCSConnArray | Select-Object Ucs,Name,Rootdn,Basedn,Attribute | ForEach-Object {
            $TableName = 'LdapProvider'
            $Fields =  "DataSetID,Ucs,Name,Rootdn,Basedn,Attribute"
            $Values =  "'$DataSetID','$UCS','$($_.Name)','$($_.Rootdn)','$($_.Basedn)','$($_.Attribute)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLdapGroupMap -Ucs $UCSConnArray | Select-Object Ucs,Name | ForEach-Object {
            $TableName = 'LdapGroupMap'
            $Fields =  "DataSetID,Ucs,Name"
            $Values =  "'$DataSetID','$UCS','$($_.Name)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLsbootSanImagePath -Ucs $UCSConnArray | sort-object -Property Ucs,Dn | Select-Object Ucs,dn,type,vnicname,lun,wwn | ForEach-Object {
            $TableName = 'LsbootSanImagePath'
            $Fields =  "DataSetID,Ucs,dn,type,vnicname,lun,wwn"
            $Values =  "'$DataSetID','$UCS','$($_.dn)','$($_.type)','$($_.vnicname)','$($_.lun)','$($_.wwn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsMaintenancePolicy -Ucs $UCSConnArray | Select-Object Ucs,Name,Dn,UptimeDisr,Descr | ForEach-Object {
            $TableName = 'MaintenancePolicy'
            $Fields =  "DataSetID,Ucs,Name,Dn,UptimeDisr,Descr"
            $Values =  "'$DataSetID','$UCS','$($_.Name)','$($_.Dn)','$($_.UptimeDisr)','$($_.Descr)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFirmwareComputeHostPack -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,BladeBundleVersion,RackBundleVersion | ForEach-Object {
            $TableName = 'FirmwareComputerHostPack'
            $Fields =  "DataSetID,Ucs,Dn,Name,BladeBundleVersion,RackBundleVersion"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.BladeBundleVersion)','$($_.RackBundleVersion)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLocalDiskConfigPolicy -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,Mode,Descr | ForEach-Object {
            $TableName = 'LocalDiskConfigPolicy'
            $Fields =  "DataSetID,Ucs,Dn,Name,Mode,Descr"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.Mode)','$($_.Descr)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsScrubPolicy -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,BiosSettingsScrub,DiskScrub | Where-Object {$_.Name -ne "policy"} | ForEach-Object {
            $TableName = 'ScrubPolicy'
            $Fields =  "DataSetID,Ucs,Dn,Name,BiosSettingsScrub,DiskScrub"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.BiosSettingsScrub)','$($_.DiskScrub)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsBiosPolicy -Ucs $UCSConnArray | Where-Object {$_.Name -ne "SRIOV"}  | Get-UcsBiosHyperThreading | Sort-Object UCS,Dn | Select-Object UCS,dn,Vp* | ForEach-Object {
            $TableName = 'BiosHyperThreading'
            $Fields =  "DataSetID,Ucs,Dn,VpIntelHyperThreadingTech"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.VpIntelHyperThreadingTech)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsBiosPolicy -Ucs $UCSConnArray | Where-Object {$_.Name -ne "SRIOV"}  | Get-UcsBiosVfSelectMemoryRASConfiguration | Sort-Object UCS,Dn | Select-Object UCS,dn,Vp* | ForEach-Object {
            $TableName = 'BiosVfSelectMemoryRASConfig'
            $Fields =  "DataSetID,Ucs,Dn,VpSelectMemoryRASConfiguration"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.VpSelectMemoryRASConfiguration)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsIpPool -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,AssignmentOrder,Size | ForEach-Object {
            $TableName = 'IpPool'
            $Fields =  "DataSetID,Ucs,Dn,Name,AssignmentOrder,Size"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.AssignmentOrder)','$($_.Size)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsIpPoolBlock -Ucs $UCSConnArray | Select-Object Ucs,Dn,From,To,Subnet,DefGw | ForEach-Object {
            $TableName = 'IpPoolBlock'
            $Fields =  "DataSetID,Ucs,Dn,[From],[To],Subnet,DefGw"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.From)','$($_.To)','$($_.Subnet)','$($_.DefGw)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsIpPoolAddr -Ucs $UCSConnArray | Sort-Object -Property Ucs,AssignedToDn | Where-Object {$_.Assigned -eq "yes"} | Select-Object Ucs,AssignedToDn,Id | ForEach-Object {
            $TableName = 'IpPoolAddr'
            $Fields =  "DataSetID,Ucs,AssignedToDn,Id"
            $Values =  "'$DataSetID','$UCS','$($_.AssignedToDn)','$($_.Id)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsUuidSuffixPool -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,AssignmentOrder,Prefix,Size,Assigned | ForEach-Object {
            $TableName = 'UuidSuffixPool'
            $Fields =  "DataSetID,Ucs,Dn,Name,AssignmentOrder,Prefix,Size,Assigned"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.AssignmentOrder)','$($_.Prefix)','$($_.Size)','$($_.Assigned)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsUuidSuffixBlock -Ucs $UCSConnArray | Select-Object Ucs,Dn,From,To | ForEach-Object {
            $TableName = 'UuidSuffixBlock'
            $Fields =  "DataSetID,Ucs,Dn,[From],[To]"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.From)','$($_.To)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsUuidpoolAddr -Ucs $UCSConnArray | Where-Object {$_.Assigned -ne "no"} | select-object Ucs,AssignedToDn,Id | sort-object -property Ucs,AssignedToDn | ForEach-Object {
            $TableName = 'UuidpoolAddr'
            $Fields =  "DataSetID,Ucs,AssignedToDn,Id"
            $Values =  "'$DataSetID','$UCS','$($_.AssignedToDn)','$($_.Id)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsMacPool -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,AssignmentOrder,Size,Assigned | ForEach-Object {
            $TableName = 'MacPool'
            $Fields =  "DataSetID,Ucs,Dn,Name,AssignmentOrder,Size,Assigned"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.AssignmentOrder)','$($_.Size)','$($_.Assigned)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsMacMemberBlock -Ucs $UCSConnArray | Select-Object Ucs,Dn,From,To | ForEach-Object {
            $TableName = 'MacMemberBlock'
            $Fields =  "DataSetID,Ucs,Dn,[From],[To]"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.From)','$($_.To)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVnic -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn | Select-Object Ucs,Dn,IdentPoolName,Addr,AdminVcon,BootDev,DynamicId,InstType,Mtu,Name,OperAdaptorProfileName,OperIdentPoolName,OperNwCtrlPolicyName,OperOrder,OperSpeed,OperStatsPolicyName,OperVcon,Order,Owner,StatsPolicyName,SwitchId,Type,VirtualizationPreference,Rn,OperNwTemplName,NwTemplName | Where-Object {$_.Addr -ne "derived"} | ForEach-Object {
            $TableName = 'Vnic'
            $Fields =  "DataSetID,Ucs,Dn,IdentPoolName,Addr,AdminVcon,BootDev,DynamicId,InstType,Mtu,Name,OperAdaptorProfileName,OperIdentPoolName,OperNwCtrlPolicyName,OperOrder,OperSpeed,OperStatsPolicyName,OperVcon,[Order],Owner,StatsPolicyName,SwitchId,Type,VirtualizationPreference,Rn,OperNwTemplName,NwTemplName"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.IdentPoolName)','$($_.Addr)','$($_.AdminVcon)','$($_.BootDev)','$($_.DynamicId)','$($_.InstType)','$($_.Mtu)','$($_.Name)','$($_.OperAdaptorProfileName)','$($_.OperIdentPoolName)','$($_.OperNwCtrlPolicyName)','$($_.OperOrder)','$($_.OperSpeed)','$($_.OperStatsPolicyName)','$($_.OperVcon)','$($_.Order)','$($_.Owner)','$($_.StatsPolicyName)','$($_.SwitchId)','$($_.Type)','$($_.VirtualizationPreference)','$($_.Rn)','$($_.OperNwTemplName)','$($_.NwTemplName)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsWwnPool -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,AssignmentOrder,Purpose,Size,Assigned | ForEach-Object {
            $TableName = 'WwnPool'
            $Fields =  "DataSetID,Ucs,Dn,Name,AssignmentOrder,Purpose,Size,Assigned"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.AssignmentOrder)','$($_.Purpose)','$($_.Size)','$($_.Assigned)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        # The service profile name and PNDN values have to be derived from elements of the DN property.  Once that is done the data is inserted like everything else.
        $Vhba = Get-UcsVhba -Ucs $UCSConnArray | Sort-Object -Property Ucs,Addr | Select-Object Ucs,Dn,IdentPoolName,NodeAddr,Addr | Where-Object {$_.NodeAddr -ne "vnic-derived"}
        $Vhba | ForEach-Object {
            $TempArray = $_.Dn.Split('/')
            $TempDN = ""
            for ($i=0; $i -lt $TempArray.Count -1; $i++)
            {
                if ($i -eq 0)
                {
                    $TempDN = $TempArray[$i]
                }
                else
                {
                    $TempDN = $TempDN + "/" + $TempArray[$i]
                } # end if
            } # end for

            $TableName = 'Vhba'
            $Fields =  "DataSetID,Ucs,Dn,IdentPoolName,NodeAddr,Addr,PNDN"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.IdentPoolName)','$($_.NodeAddr)','$($_.Addr)','$TempDN'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $vNicTemplateVlansList = Get-UcsVnicTemplate -ucs $UCSConnArray
        $vNicTemplateVlansList | ForEach-Object { 
            $VnicTemplate = $_
            Get-UcsManagedObject -ucs $UCSConnArray -dn $VnicTemplate.DN | get-ucschild | Select-Object -Property Addr,DefaultNet,Dn,Name,OperState,Owner,Rn,SwitchId,Type,Ucs,Vnet | ForEach-Object {                
                $TableName = 'vNicTemplateVlans'
                $Fields = "DataSetID,Ucs,vNicTemplateName,TemplateType,Addr,DefaultNet,DN,Name,Operstate,[Owner],Rn,SwitchId,[Type],Vnet"
                $Values = "'$DataSetID','$UCS','$($VnicTemplate.Name)','$($VnicTemplate.TemplType)','$($_.Addr)','$($_.DefaultNet)','$($_.Dn)','$($_.Name)','$($_.OperState)','$($_.Owner)','$($_.Rn)','$($_.SwitchId)','$($_.Type)','$($_.Vnet)'"
                $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"  
            } # end foreach
        } # end foreach

        $null = Get-UcsServerPool -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,Assigned | ForEach-Object {
            $TableName = 'ServerPool'
            $Fields =  "DataSetID,Ucs,Dn,Name,Assigned"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.Assigned)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsServerPoolAssignment -Ucs $UCSConnArray | Select-Object Ucs,Name,AssignedToDn | ForEach-Object {
            $TableName = 'ServerPoolAssignment'
            $Fields =  "DataSetID,Ucs,Name,AssignedToDn"
            $Values =  "'$DataSetID','$UCS','$($_.Name)','$($_.AssignedToDn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsLanCloud -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,MacAging,Mode | ForEach-Object {
            $TableName = 'LanCloud'
            $Fields =  "DataSetID,Ucs,Dn,Rn,MacAging,Mode"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.MacAging)','$($_.Mode)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFabricPort -Ucs $UCSConnArray | Select-Object Ucs,Dn,IfRole,LicState,Mode,OperState,OperSpeed,XcvrType | Where-Object {$_.OperState -eq "up"} | ForEach-Object {
            $TableName = 'FabricPort'
            $Fields =  "DataSetID,Ucs,Dn,IfRole,LicState,Mode,OperState,OperSpeed,XcvrType"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.IfRole)','$($_.LicState)','$($_.Mode)','$($_.OperState)','$($_.OperSpeed)','$($_.XcvrType)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsUplinkPortChannel -Ucs $UCSConnArray | Sort-Object -Property Ucs,Name | Select-Object Ucs,Dn,Name,OperSpeed,OperState,Transport | ForEach-Object {
            $TableName = 'UplinkPortChannel'
            $Fields =  "DataSetID,Ucs,Dn,Name,OperSpeed,OperState,Transport"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.OperSpeed)','$($_.OperState)','$($_.Transport)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsUplinkPortChannelMember -Ucs $UCSConnArray | Sort-Object -Property Ucs,Dn |Select-Object Ucs,Dn,Membership | ForEach-Object {
            $TableName = 'UplinkPortChannelMember'
            $Fields =  "DataSetID,Ucs,Dn,Membership"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Membership)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsQosClass -Ucs $UCSConnArray | Select-Object Ucs,Priority,AdminState,Cos,Weight,Drop,Mtu | ForEach-Object {
            $TableName = 'QosClass'
            $Fields =  "DataSetID,Ucs,Priority,AdminState,Cos,Weight,[Drop],Mtu"
            $Values =  "'$DataSetID','$UCS','$($_.Priority)','$($_.AdminState)','$($_.Cos)','$($_.Weight)','$($_.Drop)','$($_.Mtu)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsQosPolicy -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name | ForEach-Object {
            $TableName = 'QosPolicy'
            $Fields =  "DataSetID,Ucs,Dn,Name"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVnicEgressPolicy -Ucs $UCSConnArray |sort-object -Property Prio | Select-Object UCS,Dn,Prio | ForEach-Object {
            $TableName = 'VnicEgressPolicy'
            $Fields =  "DataSetID,Ucs,Dn,Prio"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Prio)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsNetworkControlPolicy -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,Cdp,UplinkFailAction | ForEach-Object {
            $TableName = 'NetworkControlPolicy'
            $Fields =  "DataSetID,Ucs,Dn,Name,Cdp,UplinkFailAction"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.Cdp)','$($_.UplinkFailAction)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVnicTemplate -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,Descr,SwitchId,TemplType,IdentPoolName,Mtu,NwCtrlPolicyName,QosPolicyName | ForEach-Object {
            $TableName = 'VnicTemplate'
            $Fields =  "DataSetID,Ucs,Dn,Name,Descr,SwitchId,TemplType,IdentPoolName,Mtu,NwCtrlPolicyName,QosPolicyName"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.Descr)','$($_.SwitchId)','$($_.TemplType)','$($_.IdentPoolName)','$($_.Mtu)','$($_.NwCtrlPolicyName)','$($_.QosPolicyName)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVlan -Ucs $UCSConnArray | Where-Object {$_.IfRole -eq "network"} | Sort-Object -Property Ucs,Id | Select-Object Ucs,Id,Dn,Cloud,Name,SwitchId | ForEach-Object {
            $TableName = 'Vlan'
            $Fields =  "DataSetID,Ucs,Id,Dn,Cloud,Name,SwitchId"
            $Values =  "'$DataSetID','$UCS','$($_.Id)','$($_.Dn)','$($_.Cloud)','$($_.Name)','$($_.SwitchId)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsAdaptorVlan -Ucs $UCSConnArray | sort-object Ucs,Dn |Select-Object Ucs,Dn,Name,Id,SwitchId | ForEach-Object {
            $DN = $_.Dn
            $Adaptor = $DN.Split("/")[-3]
            $Port = $DN.Split("/")[-2]
            $TableName = 'AdaptorVlan'
            $Fields =  "DataSetID,Ucs,Dn,Name,Id,SwitchId,Adaptor,Port"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.Id)','$($_.SwitchId)','$Adaptor','$Port'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsSanCloud -Ucs $UCSConnArray | Select-Object Ucs,Rn,Mode | ForEach-Object {
            $TableName = 'SanCloud'
            $Fields =  "DataSetID,Ucs,Rn,Mode"
            $Values =  "'$DataSetID','$UCS','$($_.Rn)','$($_.Mode)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFiFcPort -Ucs $UCSConnArray | Select-Object Ucs,EpDn,SwitchId,SlotId,PortId,LicState,Mode,OperSpeed,OperState,wwn | sort-object -descending  | where-object {$_.OperState -ne "sfp-not-present"} | ForEach-Object {
            $TableName = 'FiFcPort'
            $Fields =  "DataSetID,Ucs,EpDn,SwitchId,SlotId,PortId,LicState,Mode,OperSpeed,OperState,wwn"
            $Values =  "'$DataSetID','$UCS','$($_.EpDn)','$($_.SwitchId)','$($_.SlotId)','$($_.PortId)','$($_.LicState)','$($_.Mode)','$($_.OperSpeed)','$($_.OperState)','$($_.wwn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFcUplinkPortChannel -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,OperSpeed,OperState,Transport | ForEach-Object {
            $TableName = 'FcUplinkPortChannel'
            $Fields =  "DataSetID,Ucs,Dn,Name,OperSpeed,OperState,Transport"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.OperSpeed)','$($_.OperState)','$($_.Transport)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsFabricPort -Ucs $UCSConnArray | Where-Object {$_.IfRole -eq "fcoe-uplink"} | Select-Object UCS,IfRole,EpDn,LicState,OperState,OperSpeed | ForEach-Object {
            $TableName = 'FabricPort2'
            $Fields =  "DataSetID,Ucs,IfRole,EpDn,LicState,OperState,OperSpeed"
            $Values =  "'$DataSetID','$UCS','$($_.IfRole)','$($_.EpDn)','$($_.LicState)','$($_.OperState)','$($_.OperSpeed)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVsan -Ucs $UCSConnArray | Select-Object Ucs,Dn,Id,FcoeVlan,DefaultZoning | ForEach-Object {
            $TableName = 'Vsan'
            $Fields =  "DataSetID,Ucs,Dn,Id,FcoeVlan,DefaultZoning"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Id)','$($_.FcoeVlan)','$($_.DefaultZoning)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVsanMemberFcPortChannel -Ucs $UCSConnArray | Select-Object Ucs,EpDn,IfType | ForEach-Object {
            $TableName = 'VsanMemberFcPortChannel'
            $Fields =  "DataSetID,Ucs,EpDn,IfType"
            $Values =  "'$DataSetID','$UCS','$($_.EpDn)','$($_.IfType)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVhbaTemplate -Ucs $UCSConnArray | Select-Object Ucs,Dn,Name,Descr,SwitchId,TemplType,QosPolicyName | ForEach-Object {
            $TableName = 'VhbaTemplate'
            $Fields =  "DataSetID,Ucs,Dn,Name,Descr,SwitchId,TemplType,QosPolicyName"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Name)','$($_.Descr)','$($_.SwitchId)','$($_.TemplType)','$($_.QosPolicyName)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsAdaptorHostFcIf -Ucs $UCSConnArray | sort-object -Property Ucs,VnicDn -Descending | Select-Object Ucs,VnicDn,Vendor,Model,LinkState,SwitchId,NodeWwn,Wwn | Where-Object {$_.NodeWwn -ne "00:00:00:00:00:00:00:00"} | ForEach-Object {
            $TableName = 'AdaptorHostFcIf'
            $Fields =  "DataSetID,Ucs,VnicDn,Vendor,Model,LinkState,SwitchId,NodeWwn,Wwn"
            $Values =  "'$DataSetID','$UCS','$($_.VnicDn)','$($_.Vendor)','$($_.Model)','$($_.LinkState)','$($_.SwitchId)','$($_.NodeWwn)','$($_.Wwn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsAdaptorHostEthIf -Ucs $UCSConnArray | Select-Object Ucs,Dn,Rn,AdminState,BootDev,Discovery,EpDn,Id,IfRole,IfType,Lc,LinkState,Mac,Model,Mtu,Name,OperQualifierReason,OperState,Operability,Order,OriginalMac,PeerDn,PeerPortId,PeerSlotId,PfDn,PortId,Presence,Purpose,Revision,Serial,Side,SlotId,SwitchId,Thermal,VirtualizationPreference,VnicDn,Voltage | ForEach-Object {
            $TableName = 'AdaptorHostEthIf'
            $Fields =  "DataSetID,Ucs,Dn,Rn,AdminState,BootDev,Discovery,EpDn,Id,IfRole,IfType,Lc,LinkState,Mac,Model,Mtu,Name,OperQualifierReason,OperState,Operability,[Order],OriginalMac,PeerDn,PeerPortId,PeerSlotId,PfDn,PortId,Presence,Purpose,Revision,Serial,Side,SlotId,SwitchId,Thermal,VirtualizationPreference,VnicDn,Voltage"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.Rn)','$($_.AdminState)','$($_.BootDev)','$($_.Discovery)','$($_.EpDn)','$($_.Id)','$($_.IfRole)','$($_.IfType)','$($_.Lc)','$($_.LinkState)','$($_.Mac)','$($_.Model)','$($_.Mtu)','$($_.Name)','$($_.OperQualifierReason)','$($_.OperState)','$($_.Operability)','$($_.Order)','$($_.OriginalMac)','$($_.PeerDn)','$($_.PeerPortId)','$($_.PeerSlotId)','$($_.PfDn)','$($_.PortId)','$($_.Presence)','$($_.Purpose)','$($_.Revision)','$($_.Serial)','$($_.Side)','$($_.SlotId)','$($_.SwitchId)','$($_.Thermal)','$($_.VirtualizationPreference)','$($_.VnicDn)','$($_.Voltage)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsVhbaInterface -Ucs $UCSConnArray | Select-Object Ucs,Dn,OperVnetName,Initiator | Where-Object {$_.Initiator -ne "00:00:00:00:00:00:00:00"} | ForEach-Object {
            $TableName = 'VhbaInterface'
            $Fields =  "DataSetID,Ucs,Dn,OperVnetName,Initiator"
            $Values =  "'$DataSetID','$UCS','$($_.Dn)','$($_.OperVnetName)','$($_.Initiator)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        $null = Get-UcsCimXml -Ucs $UCSConnArray | Select-Object -Property Ucs,Name,Descr,AdminState,OperPort,Port,Proto,Rn | ForEach-Object {
            $TableName = 'CimXml'
            $Fields =  "DataSetID,Ucs,Name,Descr,AdminState,OperPort,Port,Proto,Rn"
            $Values =  "'$DataSetID','$UCS','$($_.Name)','$($_.Descr)','$($_.AdminState)','$($_.OperPort)','$($_.Port)','$($_.Proto)','$($_.Rn)'"
            $null = Invoke-DatabaseQuery -connectionString $ConnectionString -query "Insert Into $TableName ($Fields) values ($Values)"
        } # end foreach

        Disconnect-Ucs -Ucs $UCSConnArray
    }
    else
    {
        $UCSConnStatus = 'Failed'
    } # End Chassis Connection check if

    $info = [ordered]@{
        'UCS' = "$Ucs";
        'DataSetID' = "$DataSetID";       
        'Status' = "$UCSConnStatus";
    } # end ordered hash

    $object = New-Object -TypeName psobject -Property $info     
    return $object
} # end fucntion Get-UCSData

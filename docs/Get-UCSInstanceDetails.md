---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Get-UCSInstanceDetails

## SYNOPSIS
Gets the status of a UCS Instance in the database

## SYNTAX

```
Get-UCSInstanceDetails [-Ucs] <Object> [<CommonParameters>]
```

## DESCRIPTION
This function is used to get the status of a given UCSInstance in the database. 
This status determines if the 
UCS Instance will be included in the results returned by Get-UCSInstanceList

## EXAMPLES

### EXAMPLE 1
```
Get-UCSInstanceDetails -UCS LABUCS002
```

RID          : 23
InstanceName : LABUCS002
IPAddress    : 10.0.34.200
Location     : Nashville
Notes        :
CoreDmz      : Core
Status       : offline
DataCenter   : LAB

### EXAMPLE 2
```
'LABUCS001','NPRUCS001' | Get-UCSInstanceDetails
```

RID          : 22
InstanceName : LABUCS001
IPAddress    : 10.0.34.100
Location     : Nashville
Notes        :
CoreDmz      : Core
Status       : Online
DataCenter   : LAB

RID          : 3
InstanceName : NPRUCS001
IPAddress    : 10.2.99.10
Location     : Nashville
Notes        :
CoreDmz      : Core
Status       : Online
DataCenter   : NPR

### EXAMPLE 3
```
Get-UCSInstanceList | Get-UCSInstanceDetails
```

RID InstanceName             IPAddress                Location                 Notes                    CoreDmz                  Status                   DataCenter
--- ------------             ---------                --------                 -----                    -------                  ------                   ----------
  1 NDCUCSTEL                10.2.32.67               Nashville                                         Core                     Online                   NDC
  2 SDCUCSTEL                10.4.32.67               Sterling                                          Core                     Online                   SDC
  3 NPRUCS001                10.2.99.10               Nashville                                         Core                     Online                   NPR
  4 NDCUCS001                10.2.58.36               Nashville                                         Core                     Online                   NDC
  5 SDCUCS001                10.4.53.70               Sterling                                          Core                     Online                   SDC
  6 SYDUCS001                10.79.34.33              Sydney                                            Core                     Online                   SYD
  7 SYDUCS002                10.79.34.105             Sydney                                            eDMZ                     Online                   SYD
  8 NEDUCS001                10.3.36.32               Nashville                                         Core                     Online                   NED
...

## PARAMETERS

### -Ucs
This parameter is the UCS entry to update in the database.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

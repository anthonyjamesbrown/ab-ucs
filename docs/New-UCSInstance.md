---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# New-UCSInstance

## SYNOPSIS
Add a UCS Instance to the database

## SYNTAX

```
New-UCSInstance [-Ucs] <String> [[-ConnectionString] <String>] [[-IPAddress] <String>] [[-Location] <String>]
 [[-Notes] <String>] [[-CoreDMZ] <String>] [[-Status] <String>] [-DataCenter] <String> [<CommonParameters>]
```

## DESCRIPTION
This function is used to add a new UCSInstance in the database.

## EXAMPLES

### EXAMPLE 1
```
New-UCSInstance -UCS LABUCS002 -IPAddress 192.168.4.100 -Location Nashville -Notes 'In the lab yo' -CoreDMZ Core -DataCenter LAB
```

## PARAMETERS

### -Ucs
This parameter is the UCS entry to add to the database.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConnectionString
This parameter is required to connect to a database to run a query. 
This is a standard format connection string.
A default is used if not supplied. 
To see the default run cmdlet: Get-UCSConnectionString.

```yaml
Type: String
Parameter Sets: (All)
Aliases: conn, cs

Required: False
Position: 2
Default value: (Get-UCSConnectionString)
Accept pipeline input: False
Accept wildcard characters: False
```

### -IPAddress
This parameter is the IP Address that the instance name resolves to.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ip

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Location
This parameter is the location of the datacenter where this instance is installed.
e.g.
Nashville, Sterling, Sydney, etc...

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Notes
This parameter is for notes.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CoreDMZ
This parameter is for the network location type. 
e.g.
Core, eDMZ, iDMZ etc...

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Core
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
This parameter needs to be either 'online' or 'offline'.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Online
Accept pipeline input: False
Accept wildcard characters: False
```

### -DataCenter
This parameter is for the DataCenter code for where the UCSInstance is located.

```yaml
Type: String
Parameter Sets: (All)
Aliases: dc

Required: True
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Get-DatabaseData

## SYNOPSIS
Returns a dataset object.

## SYNTAX

```
Get-DatabaseData [[-connectionString] <String>] [-query] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns a dataset object by executed a query against a database based on the connection string supplied.

## EXAMPLES

### EXAMPLE 1
```
Get-DatabaseData -verbose -connectionString (Get-UCSConnectionString) -query "Select InstanceName From UCSInstances Where Status = 'Online'"
```

## PARAMETERS

### -connectionString
This parameter is required to connect to a database to run a query. 
This is a standard format connection string.
A default is used if not supplied. 
To see the default run cmdlet: Get-UCSConnectionString.

```yaml
Type: String
Parameter Sets: (All)
Aliases: conn, cs

Required: False
Position: 1
Default value: (Get-UCSConnectionString)
Accept pipeline input: False
Accept wildcard characters: False
```

### -query
This parameter is the database query to run. 
This ideally would be a select statment of some kind.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Invoke-DatabaseQuery

## SYNOPSIS
Invokes a database command.

## SYNTAX

```
Invoke-DatabaseQuery [[-connectionString] <String>] [-query] <String> [<CommonParameters>]
```

## DESCRIPTION
This function is for running commands against a database other than select statements. 
This function does not return anything.

## EXAMPLES

### EXAMPLE 1
```
Invoke-DatabaseQuery -verbose -connectionString (Get-UCSConnectionString) -query "Update UCSInstance Set Status = 'offline' where InstanceName = 'LABUCS001'"
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
This parameter is required. 
This is the query that will be executed against the database specified in the connectionstring.

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

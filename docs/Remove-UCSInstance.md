---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Remove-UCSInstance

## SYNOPSIS
Deletes a UCS Instance from the database

## SYNTAX

```
Remove-UCSInstance [-Ucs] <String> [[-ConnectionString] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function is used to a given UCSInstance in the database.

## EXAMPLES

### EXAMPLE 1
```
Remove-UCSInstance -UCS LABUCS003
```

## PARAMETERS

### -Ucs
This parameter is the UCS entry to update in the database.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

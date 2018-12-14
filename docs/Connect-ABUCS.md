---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Connect-ABUCS

## SYNOPSIS
Connect to a UCS instance using the standard Asurion read-only account.

## SYNTAX

```
Connect-ABUCS [-UCS] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns a UCS Connection Object using the standard Asurion read-only UCS account.

## EXAMPLES

### EXAMPLE 1
```
$UCS = Connect-ABUCS -UCS NEDUCS001
```

## PARAMETERS

### -UCS
{{Fill UCS Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
You should always clean up by calling Disconnect-UCS -Ucs \<$Connection Object Variable\>

## RELATED LINKS

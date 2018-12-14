---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Invoke-UCSPowerReadingDataCollection

## SYNOPSIS
Collect power readings from all of the UCS instances and write the results to the database.

## SYNTAX

```
Invoke-UCSPowerReadingDataCollection [<CommonParameters>]
```

## DESCRIPTION
Loop through a list of UCS Instances that is generated with (Get-UCSInstanceList) and collect power usage stats and 
write that data to the UCS database.

## EXAMPLES

### EXAMPLE 1
```
Invoke-UCSPowerReadingsDataCollection
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Get-UCSInstanceList

## SYNOPSIS
This function returns a list of UCS Instances in the UCS database that have a status of 'online'.

## SYNTAX

```
Get-UCSInstanceList [<CommonParameters>]
```

## DESCRIPTION
This function returns a list of UCS Instances in the UCS database that have a status of 'online'.
Use Get-UCSInstanceStatus to check the status and Set-UCSInstanceStatus to change the status of a UCS instance.

## EXAMPLES

### EXAMPLE 1
```
Get-UCSInstanceList
```

InstanceName
------------'
NDCUCSTEL
SDCUCSTEL
NPRUCS001
NDCUCS001
SDCUCS001
...

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
I need to add a parameter to allow returning all UCS Instances regardless of status.

## RELATED LINKS

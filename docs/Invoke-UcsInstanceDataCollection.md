---
external help file: AB-UCS-help.xml
Module Name: AB-UCS
online version:
schema: 2.0.0
---

# Invoke-UcsInstanceDataCollection

## SYNOPSIS
Collect all data from all of the UCS instances and write the results to the database as a new dataset.

## SYNTAX

```
Invoke-UcsInstanceDataCollection [<CommonParameters>]
```

## DESCRIPTION
Loop through a list of UCS Instances that is generated with (Get-UCSInstanceList) and collect all useful UCS data
and write that data to the UCS database using a new DataSetID.

## EXAMPLES

### EXAMPLE 1
```
Invoke-UcsInstanceDataCollection
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

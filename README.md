---
external help file: ab-ucs-help.xml
Module Name: ab-ucs
online version:
schema: 2.0.0
---

# AB-UCS

## SYNOPSIS
This project is used to perform a daily data collection from all configured UCS Domains in an environment.  This data is
stored in a centralized database.  A seperate web project is used as the data front-end for this database.

## DESCRIPTION
This project contains a number of functions for collecting UCS data and managing some aspects of the database configuration.

The files located in the AB folder contain information about the DB schema and have SQL scripts for creating the database.

Functions include:

[Connect-ABUCS](.\docs\Connect-ABUCS.md)

[Get-DatabaseData](.\docs\Get-DatabaseData.md)

[Get-UCSConnectionString](.\docs\Get-UCSConnectionString.md)

[Get-UCSData](.\docs\Get-UCSData.md)

[Get-UCSInstanceDetails](.\docs\Get-UCSInstanceDetails.md)

[Get-UCSInstanceList](.\docs\Get-UCSInstanceList.md)

[Get-UCSInstanceStatus](.\docs\Get-UCSInstanceStatus.md)

[Get-UCSPowerReading](.\docs\Get-UCSPowerReading.md)

[Invoke-DatabaseQuery](.\docs\Invoke-DatabaseQuery.md)

[Invoke-UcsInstanceDataCollection](.\docs\Invoke-UcsInstanceDataCollection.md)

[Invoke-UCSPowerReadingDataCollection](.\docs\Invoke-UCSPowerReadingDataCollection.md)

[New-UCSInstance](.\docs\New-UCSInstance.md)

[Remove-UCSInstance](.\docs\Remove-UCSInstance.md)

[Set-UCSInstanceStatus](.\docs\Set-UCSInstanceStatus.md)

See the docs directory for more information.

## RELATED LINKS

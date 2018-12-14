$ConnectionString = "Server=SQLUCS\UCS;Database=UCS;Integrated Security=true"
$DaysOld = 90

[datetime]$OlderThanDate = (get-date).AddDays(-($DaysOld))

$DataSets = Get-DatabaseData -connectionString $ConnectionString -query "Select * From CollectionData Where RecordStatus = 'historical' and DateCollected <= '$($OlderThanDate.ToString('MM/dd/yyyy'))'"

$Count = $DataSets.Count
$DataSets.DataSetID | ForEach-Object -Begin {$i=0} -Process{ 
    Write-Progress -Activity "Deleting DataSetID: $_" -Status "Progress: $i of $Count" -PercentComplete ($i/$count*100)
    $result = Invoke-DatabaseQuery -connectionString $ConnectionString -query "exec DeleteDataSet $_"
    ++$i
} # End Loop 

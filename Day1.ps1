#
# https://adventofcode.com/2020
#
# $InputData = Invoke-WebRequest "https://adventofcode.com/2020/day/1/input"
# Can't use this because it request authentication
#
Start-Transcript .\Day1.log 
$InputData = Get-Content .\Day1.data
Write-Host "$($InputData.Count) values to check !"

Write-Host "# Part1"
$counter1 = 0
$ValueFound = $false
while (($counter1 -lt $InputData.Count) -and -not $ValueFound) {
    $counter2 = $counter1 + 1
    while (($counter2 -lt $InputData.Count) -and -not $ValueFound) {
        $ValuesSum = [int]$InputData[$counter1] + [int]$InputData[$counter2]
        if ( $ValuesSum -eq 2020) {
            Write-Host  "$($InputData[$counter1]) + $($InputData[$counter2]) = 2020 "
            $ValuesMultiplied = [int]$InputData[$counter1] * [int]$InputData[$counter2]
            Write-Host  "$($InputData[$counter1]) * $($InputData[$counter2]) = $ValuesMultiplied "
            Write-Host "$counter1 / $counter2"
            $ValueFound = $true
        }
        $counter2 += 1
    }
    $counter1 += 1
}

Write-Host "# Part2"
$counter1 = 0
$ValueFound = $false
while (($counter1 -lt $InputData.Count) -and -not $ValueFound) {
    $counter2 = $counter1 + 1
    while (($counter2 -lt $InputData.Count) -and -not $ValueFound) {
        $counter3 = $counter2 + 1
        while (($counter3 -lt $InputData.Count) -and -not $ValueFound) {
            $ValuesSum = [int]$InputData[$counter1] + [int]$InputData[$counter2] + [int]$InputData[$counter3]
            if ( $ValuesSum -eq 2020) {
                Write-Host  "$($InputData[$counter1]) + $($InputData[$counter2]) + $($InputData[$counter3]) = 2020 "
                $ValuesMultiplied = [int]$InputData[$counter1] * [int]$InputData[$counter2] * [int]$InputData[$counter3]
                Write-Host  "$($InputData[$counter1]) * $($InputData[$counter2]) * $($InputData[$counter3]) = $ValuesMultiplied "
                Write-Host "$counter1 / $counter2 / $counter3"
                $ValueFound = $true
            }
            $counter3 += 1
        }
        $counter2 += 1
    }
    $counter1 += 1
}

Stop-Transcript

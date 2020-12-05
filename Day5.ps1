#
# https://adventofcode.com/2020
#
#
Start-Transcript .\Day5.log 
$InputData = Get-Content .\Day5.data
Write-Host "$($InputData.Count) values to check !"

function GetSeat {
    param (
        [string]$SeatCode
    )
    $SeatCodeArray = $SeatCode.ToCharArray()
    $MinRow = 0
    $MaxRow = 127
    for ($i = 0; $i -lt 7; $i++) {
        if ($SeatCodeArray[$i] -eq "F") {
            $MaxRow = $MaxRow - (($MaxRow - $MinRow + 1) / 2)
        } elseif ($SeatCodeArray[$i] -eq "B") {
            $MinRow = $MinRow + (($MaxRow - $MinRow + 1) / 2)
        }
        #Write-Host $i $MinRow $MaxRow
    }

    $MinCol = 0
    $MaxCol = 7

    for ($i = 7; $i -lt 10; $i++) {
        if ($SeatCodeArray[$i] -eq "L") {
            $MaxCol = $MaxCol - (($MaxCol - $MinCol + 1) / 2)
        }
        elseif ($SeatCodeArray[$i] -eq "R") {
            $MinCol = $MinCol + (($MaxCol - $MinCol + 1) / 2)
        }
        #Write-Host $i $MinCol $MaxCol
    }
    Return $MaxRow * 8 + $MaxCol
}

$MaxSeatID = 0
foreach ($InputDataLine in $InputData) {
    if ($MaxSeatID -lt $(GetSeat($InputDataLine))) {
        $MaxSeatID = $(GetSeat($InputDataLine))        
    }
}

Write-Host "Max Seat ID = $MaxSeatID"

# Part 2

$Seats = New-Object int[] $MaxSeatID
foreach ($InputDataLine in $InputData) {
    $Seats[$(GetSeat($InputDataLine))-1] = 1
}

$Start = $False
for ($i = 0; $i -lt $Seats.Count; $i++) {
    if ($Seats[$i] -eq 0 -and $Start) {
        Write-Host "My Seat $i"
    } elseif ($Seats[$i] -ne 0) {
        $Start = $true
    } 
}

Stop-Transcript

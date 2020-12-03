#
# https://adventofcode.com/2020
#
#
Start-Transcript .\Day3.log 
$InputData = Get-Content .\Day3.data
Write-Host "$($InputData.Count) values to check !"
$Moves = @((1, 1), (3,1), (5,1), (7,1), (1,2))
#To create an array of array with a single element => $Moves = @(,(3,1))
$Part2Result = 1 
foreach ($Move in $Moves) {
    $MoveRight = $Move[0]
    $MoveDown = $Move[1]
    Write-Host "Testing for $MoveRight right moves and $MoveDown down moves..."
    $NumberOfTrees = 0
    $Row = 0 
    $Col = 0
    $Landscape = $InputData[0]
    while ($Row -le $InputData.Count) {
        # Could we go 3 rigth and stay on the same Row ?
        if ($Col + $MoveRight -le $Landscape.Length - 1) {
            $Col += $MoveRight
            $Row += $MoveDown
        }
        else {
            $Col += $MoveRight
            $Col -= $Landscape.Length 
            $Row += $MoveDown
        }
        $Landscape = $InputData[$Row]
        # Do we hit a Tree ?
        if ($Landscape) {
            if ($Landscape.ToCharArray()[$Col] -eq "#") {
                $NumberOfTrees += 1
            }
        }
    }
    Write-Host "There's $NumberOfTrees on the way for ($MoveRight,$MoveDown)."
    $Part2Result = $Part2Result * $NumberOfTrees
}

Write-Host "Answer for Part2 is $Part2Result"
Stop-Transcript

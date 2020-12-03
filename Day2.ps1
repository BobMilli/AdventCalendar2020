#
# https://adventofcode.com/2020
#
# $InputData = Invoke-WebRequest "https://adventofcode.com/2020/day/2/input"
# Can't use this because it request authentication
#
Start-Transcript .\Day2.log 
$InputData = Get-Content .\Day2.data
Write-Host "$($InputData.Count) values to check !"

# Part1
$NumberOfValidPassword = 0
foreach ($Password in $InputData) {
    $tokens = $Password.Split(" ")
    $Minimum = [int]$tokens[0].Split("-")[0]
    $Maximum = [int]$tokens[0].Split("-")[1]
    $Letter = $tokens[1].Split(":")[0]
    $PasswordToCheck = $tokens[2]

    if ((($PasswordToCheck.ToCharArray() -eq $Letter).count -ge $Minimum) -and (($PasswordToCheck.ToCharArray() -eq $Letter).count -le $Maximum)) {
        $NumberOfValidPassword += 1
    }
}
Write-Host "There's $NumberOfValidPassword valid passwords in the list."

# Part2
$NumberOfValidPassword = 0
foreach ($Password in $InputData) {
    $tokens = $Password.Split(" ")
    $FirstPosition = [int]$tokens[0].Split("-")[0] - 1
    $SecondPosition = [int]$tokens[0].Split("-")[1] - 1
    $Letter = $tokens[1].Split(":")[0]
    $PasswordToCheck = $tokens[2]

    if ((($PasswordToCheck[$FirstPosition] -eq $Letter) -and ($PasswordToCheck[$SecondPosition] -ne $Letter)) -or 
        (($PasswordToCheck[$FirstPosition] -ne $Letter) -and ($PasswordToCheck[$SecondPosition] -eq $Letter))) {
        $NumberOfValidPassword += 1
    }
}
Write-Host "There's $NumberOfValidPassword valid passwords in the list."

Stop-Transcript

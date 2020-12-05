#
# https://adventofcode.com/2020
#
#
Start-Transcript .\Day4.log 
$InputData = Get-Content .\Day4.data
Write-Host "$($InputData.Count) values to check !"

<#
byr (Birth Year)
iyr (Issue Year)
eyr (Expiration Year)
hgt (Height)
hcl (Hair Color)
ecl (Eye Color)
pid (Passport ID)
cid (Country ID)
#>

Write-Host "#Part1"

$PassportFields = @("byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid")
$LineIndex = 0
$NumberOfValidPassports = 0
$NumberOfPassports = 0
$PassportControl = "00000000".ToCharArray()
while ($LineIndex -le $InputData.Count) {
    $InputDataLine = $InputData[$LineIndex]
    if (($InputDataLine -ne "") -and ($null -ne $InputDataLine)) {
        # Let's control the Passports field
        foreach ($Field in $InputDataLine.Split(' ')) {
            $Field = $Field.Split(':')[0]
            $FieldIndex = [array]::IndexOf($PassportFields, $Field)
            if ( $FieldIndex -ne -1 ) {
                $PassportControl[$FieldIndex] = "1"
            }
        }
    } else {
        # We are on a Passport "splitter" (empty line) or at the end of the "file"
        $NumberOfPassports += 1
        if ( ((-join $PassportControl) -eq "11111111") -or ((-join $PassportControl) -eq "11111110")) {
            $NumberOfValidPassports += 1
        }
        Write-Host "Controlling Passport $($NumberOfPassports) / Password Control = $(-join $PassportControl) / Number of valid Passports = $NumberOfValidPassports" 
        $PassportControl = "00000000".ToCharArray()
    }
    $LineIndex += 1
}

Write-Host "The number of valid Passports is $NumberOfValidPassports out of $NumberOfPassports"

Write-Host "#Part2"
# Part 2
$LineIndex = 0
$NumberOfValidPassports = 0
$NumberOfPassports = 0
$PassportControl = "00000000".ToCharArray()
$InvalidReason = ""
while ($LineIndex -le $InputData.Count) {
    $InputDataLine = $InputData[$LineIndex]
    if (($InputDataLine -ne "") -and ($null -ne $InputDataLine)) {
        # Let's control the Passports field
        foreach ($Field in $InputDataLine.Split(' ')) {
            $FieldValue = $Field.Split(':')[1]
            $Field = $Field.Split(':')[0]
            $FieldIndex = [array]::IndexOf($PassportFields, $Field)
            if ( $FieldIndex -ne -1 ) {
                $FieldValid = $true
                # Birth year
                if ($Field -eq "byr") {
                    if (([int]$FieldValue -lt 1920) -or ([int]$FieldValue -gt 2002) ) {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                # Issue year
                if ($Field -eq "iyr") {
                    if (([int]$FieldValue -lt 2010) -or ([int]$FieldValue -gt 2020) ) {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                # Expiration year
                if ($Field -eq "eyr") {
                    if (([int]$FieldValue -lt 2020) -or ([int]$FieldValue -gt 2030) ) {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                # Height 
                if ($Field -eq "hgt") {
                    if ($FieldValue -match '^(\d*)(cm|in)') {
                        if ($matches[2] -eq "cm") {
                            if (([int]$matches[1] -lt 150) -or ([int]$matches[1] -gt 193) ) {
                                $FieldValid = $false
                                $InvalidReason += " ($Field)"
                            }
                        } else {
                            if (([int]$matches[1] -lt 59) -or ([int]$matches[1] -gt 76) ) {
                                $FieldValid = $false
                                $InvalidReason += " ($Field)"
                            }
                        }
                    } else {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                # Hair color
                if ($Field -eq "hcl") {
                    if (-not ($FieldValue -match '^#[0-9a-f]{6}$')) {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                # Eye color
                if ($Field -eq "ecl") {
                    if (-not ($FieldValue -match '^(amb|blu|brn|gry|grn|hzl|oth)$')) {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                # Passport ID
                if ($Field -eq "pid") {
                    if (-not ($FieldValue -match '^\d{9}$')) {
                        $FieldValid = $false
                        $InvalidReason += " ($Field)"
                    }
                }
                if ($FieldValid) {
                    $PassportControl[$FieldIndex] = "1"
                } 
            }
        }
    }
    else {
        # We are on a Passport "splitter" (empty line) or at the end of the "file"
        $NumberOfPassports += 1
        if ( ((-join $PassportControl) -eq "11111111") -or ((-join $PassportControl) -eq "11111110")) {
            $NumberOfValidPassports += 1
        }
        Write-Host "Controlling Passport $($NumberOfPassports) / Password Control = $(-join $PassportControl) $InvalidReason / Number of valid Passports = $NumberOfValidPassports" 
        $InvalidReason = ""
        $PassportControl = "00000000".ToCharArray()
    }
    $LineIndex += 1
}

Write-Host "The number of valid Passports is $NumberOfValidPassports"


Stop-Transcript
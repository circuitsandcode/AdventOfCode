# Solution for 2015 Day 1: Not Quite Lisp
# https://adventofcode.com/2015/day/1
# Written in PowerShell by Chris Hansen
# Works in Windows PowerShell 5.1 and PowerShell 7.1
# Website: https://circuitsandcode.wehappyfew.net/
# Twitter: https://twitter.com/CircuitsAndCode
# Github: https://github.com/circuitsandcode
# MIT License: https://github.com/circuitsandcode/AdventOfCode/blob/master/LICENSE

[datetime]$start = Get-Date

# Import Input File to a string
# I've used an Environment Path variable to shortcut to my AdventOfCode folder. Adjust this to the absolute or relative path with your input file.
[string]$directions = Get-Content -Path $env:AdventPath\2015\InputFiles\2015_01_input.txt

# Part I

# Count the number of floors Santa went up
[int]$upFloors = [regex]::matches($directions,"\(").count
# Count the number of floors Santa went down
[int]$downFloors = [regex]::matches($directions,"\)").count
# Subtract the two to get the ending floor
[int]$floors = $upFloors - $downFloors
write-host "Part I: Santa ended on floor $($floors)."

# Part II
# Set starting variables
$floors = 0
[int]$counter = 0

# Convert the Directions String to an Array with individual characters
[array]$directionsArr = $directions.toCharArray()

# Loop through the directionsArr array
foreach ($direction in $directionsArr)
{
    # Adjust the counter to count moves so we can determing when Santa first entered the basement.
    $counter++
    # Adjust the floors variable depending on the current direction.
    switch ($direction)
    {
        "(" {$floors++}
        ")" {$floors--}
    }
    # Check if Santa entered the basement and if so, break the loop.
    if ($floors -lt 0)
    {
        write-host "Part II: Santa entered the basement on move $($counter)."
        break
    }
}

[datetime]$end = Get-Date
[timespan]$elapsed = $end-$start
write-host "Program run time: $($elapsed.TotalSeconds) seconds"
# Solution for 2015 Day 1: Not Quite Lisp
# Part II
# https://adventofcode.com/2015/day/1
# Written in PowerShell by Chris Hansen
# Website: https://circuitsandcode.wehappyfew.net/
# Twitter: https://twitter.com/CircuitsAndCode
# Github: https://github.com/circuitsandcode
# MIT License: https://github.com/circuitsandcode/AdventOfCode/blob/master/LICENSE

[datetime]$start = Get-Date

# I've used an Environment Path variable to shortcut to my AdventOfCode folder. Adjust this to the absolute or relative path with your input file.
[string]$directions = Get-Content -Path $env:AdventPath\2015\InputFiles\2015_01_input.txt

# Set starting variables
[int]$floors = 0
[int]$counter = 0

# Convert the Directions String to an Array
[array]$directions = $directions.toCharArray()

# Loop through the directions array
foreach ($direction in $directions)
{
    # Adjust the counter to count moves so we can determing when Santa first entered the basement.
    $counter++
    # Adjust the floors variable depending on the current direction.
    if ($direction -eq "(")
    {
        $floors++
    } else
    {
        $floors--
    }
    if ($floors -lt 0)
    # Check if Santa entered the basement and if so, break the loop.
    {
        write-host "Santa entered the basement on move $($counter)."
        break
    }
}

[datetime]$end = Get-Date
[timespan]$elapsed = $end-$start
write-host "Program run time: $($elapsed.TotalSeconds) seconds"
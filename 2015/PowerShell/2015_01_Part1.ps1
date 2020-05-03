# Solution for 2015 Day 1: Not Quite Lisp
# Part I
# https://adventofcode.com/2015/day/1
# Written in PowerShell by Chris Hansen
# Website: https://circuitsandcode.wehappyfew.net/
# Twitter: https://twitter.com/CircuitsAndCode
# Github: https://github.com/circuitsandcode
# MIT License: https://github.com/circuitsandcode/AdventOfCode/blob/master/LICENSE

$start = Get-Date

# I've used an Environment Path variable to shortcut to my AdventOfCode folder. Adjust this to the absolute or relative path with your input file.
$directions = Get-Content -Path $env:AdventPath\2015\InputFiles\2015_01_input.txt

# Set starting variables
$floors = 0

# Convert the Directions String to an Array
$directions = $directions.toCharArray()

# Loop through the directions array
foreach ($direction in $directions) {
    # Adjust the floors variable depending on the current direction.
    if ($direction -eq "(")
    {
        $floors++
    } else
    {
        $floors--
    }
}

# The loop will end with Santa's current location.
write-host "Santa ended on floor $($floors)."

$end = Get-Date
$elapsed = $end-$start
write-host "Program run time: $($elapsed.TotalSeconds) seconds"
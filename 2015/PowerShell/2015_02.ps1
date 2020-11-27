# Solution for 2015 Day 2: I Was Told There Would Be No Math
# https://adventofcode.com/2015/day/2
# Written in PowerShell by Chris Hansen
# Works in Windows PowerShell 5.1 and PowerShell 7.1
# Website: https://circuitsandcode.wehappyfew.net/
# Twitter: https://twitter.com/CircuitsAndCode
# Github: https://github.com/circuitsandcode
# MIT License: https://github.com/circuitsandcode/AdventOfCode/blob/master/LICENSE

[datetime]$start = Get-Date

# Import Input File to an Array
# I've used an Environment Path variable to shortcut to my AdventOfCode folder. Adjust this to the absolute or relative path with your input file.
[string[]]$dimensions = Get-Content -Path $env:AdventPath\2015\InputFiles\2015_02_input.txt

# Set the starting variables
[int]$totalPaper = 0 # Used in Part I
[int]$totalRibbon = 0 # Used in Part II

# Loop through the Dimensions array.
foreach ($dimension in $dimensions)
{
    # Part I
    # The dimensions are written like this "14x16x19" (length, width, height)
    # Split the string into an array of the three sizes into an array
    [string[]]$sizesStr = $dimension.Split("x")
    # Convert the strings to ints so they can be calculated
    [int[]]$sizes = foreach ($sizeStr in $sizesStr)
    {
        [int]$sizeStr
    }
    # Get the area of each side. These will be put into an array called $areas
    [int[]]$areas = ($sizes[0]*$sizes[1]),($sizes[1]*$sizes[2]),($sizes[0]*$sizes[2])
    # Determine which size is the smallest side for the extra paper needed.
    [int]$smallestside = ($areas | Measure-Object -Minimum).Minimum
    # Determine the paper needed using the formula given.
    # 2*l*w + 2*w*h + 2*h*l + smallest side
    [int]$paper = ((2 * $areas[0]) + (2 * $areas[1]) + (2 * $areas[2]) + $smallestside)
    # Increment the $totalPaper variable by the current $paper value
    $totalPaper += $paper

    # Part II
    # Sort the sides from smallest to largest.
    $sizes = $sizes | Sort-Object
    # Determine Cubic Feet my multipling each size dimension of the box
    [int]$cubicFeet = 1
    foreach ($size in $sizes)
    {
        $cubicFeet *= $size
    }
    # Ribbon needed is the shortest distance around two sides + cubic area
    [int]$ribbon = ($sizes[0] * 2) + ($sizes[1] * 2) + $cubicFeet
    # Increment the totalRibbon variable by the current $ribbon value
    $totalRibbon += $ribbon 
}

# Print the answers to the puzzle for Part I and Part II.
Write-Host "The elves need $($totalPaper) square feet of paper for Part I."
Write-Host "The elves need $($totalRibbon) feet of ribbon for Part II."

[datetime]$end = Get-Date
[timespan]$elapsed = $end-$start
write-host "Program run time: $($elapsed.TotalSeconds) seconds"
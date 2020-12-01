# Solution for 2020 Day 1: Report Repair
# https://adventofcode.com/2020/day/1
# Written in PowerShell by Chris Hansen
# Works in Windows PowerShell 5.1 and PowerShell 7.1
# Website: https://circuitsandcode.wehappyfew.net/
# Twitter: https://twitter.com/CircuitsAndCode
# Github: https://github.com/circuitsandcode
# MIT License: https://github.com/circuitsandcode/AdventOfCode/blob/master/LICENSE

[datetime]$start = Get-Date

# Import Input File to an Array
# I've used an Environment Path variable to shortcut to my AdventOfCode folder. Adjust this to the absolute or relative path with your input file.
[string[]]$reportStr = Get-Content -Path $env:AdventPath\2020\InputFiles\2020_01_input.txt

# Convert the strings to ints so they can be calculated
[int[]]$report = foreach ($reportItemStr in $reportStr)
{
    [int]$reportItemStr
}

# Remove unneeded original variable
Remove-Variable -name reportStr

# Part I
# Loop through all possible combinations of numbers from the report looking for two numbers that total 2020. Multiply them when found and exit the loop.
# Label for outer loop
:outerLoop foreach ($reportItemA in $report)
{
    foreach ($reportItemB in $report)
    {
        # Two numbers that are the same can be skipped since we are looking for two different numbers from the report.
        if ($reportItemA -eq $reportItemB)
        {
            continue
        }
        if ($reportItemA + $reportItemB -eq 2020)
        {
            [int]$reportProduct = ($reportItemA * $reportItemB)
            Write-Host "Part I: The two values that equal 2020 are $($reportItemA) and $($reportItemB). The sum of them is: $($reportProduct)"
            break outerLoop
        }
    }
}

# Part II
# Loop through all possible combinations of numbers from the report looking for three numbers that total 2020. Multiply them when found and exit the loop.
# Label for outer loop
:outerLoop foreach ($reportItemA in $report)
{
    # Label for inner loop
    foreach ($reportItemB in $report)
    {
        foreach ($reportItemC in $report)
        {
            # Any two numbers that are the same can be skipped since we are looking for three different numbers from the report.
            if ($reportItemA -eq $reportItemB -or $reportItemA -eq $reportItemC -or $reportItemB -eq $reportItemC)
            {
                continue
            }
            if ($reportItemA + $reportItemB + $reportItemC -eq 2020)
            {
                [int]$reportProduct = ($reportItemA * $reportItemB * $reportItemC)
                Write-Host "Part I: The three values that equal 2020 are $($reportItemA), $($reportItemB), and $($reportItemC). The sum of them is: $($reportProduct)"
                break outerLoop
            }
        }
    }
}

[datetime]$end = Get-Date
[timespan]$elapsed = $end-$start
write-host "Program run time: $($elapsed.TotalSeconds) seconds"
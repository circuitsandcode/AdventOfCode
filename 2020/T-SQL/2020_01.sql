/*
Solution for 2020 Day 1: Report Repair
https://adventofcode.com/2020/day/1
Written in T-SQL by Chris Hansen
Website: https://circuitsandcode.wehappyfew.net/
Twitter: https://twitter.com/CircuitsAndCode
Github: https://github.com/circuitsandcode
MIT License: https://github.com/circuitsandcode/AdventOfCode/blob/master/LICENSE

Solutions written in T-SQL for Microsoft SQL Server
Written in SQL Server 2019 Express and SQL Server Management Studio 18.7.1
Both tools available for free at:
https://www.microsoft.com/en-us/sql-server/sql-server-downloads

Solutions use temp tables where possible.
*/

-- Clean up existing temp tables.
drop table if exists dbo.#inputRecords
;
drop table if exists dbo.#inputRecordsCombos2
;
drop table if exists dbo.#inputRecordsCombos3
;
go

-- Create temp table to store the input
-- This is nice and simple since the input is just one column of Integers
create table #inputRecords
(
	inputValue int
)
;
go

-- Load the input file to the temp table.
-- Update to the folder and name of your input file
bulk insert #inputRecords
from 'C:\Files\2020_01_input.txt'
with
(
	--fieldterminator = '\t', -- No additional fields in this input.
	rowterminator = '0x0a' -- Input files have the Linux LF line end. Use the hex notation '0x0A' to signify line end.
	--, keepnulls
)
;
go

-- Part I
-- Cross join the table onto itself to compare the sum of every value with every other value.
-- When a row is found that matches up on to 2020, the query multiples the two values.
-- Using a distinct since the cross join will put both matching numbers in each columns resulting in the correct answer appearing twice.
select distinct
	ir1.inputValue * ir2.inputValue as inputValueProduct
	into #inputRecordsCombos2
from
	#inputRecords ir1
	cross join #inputRecords ir2 -- Join every record to every record
where
	ir1.inputValue + ir2.inputValue = 2020 -- Only keep the records that add up to 2020
;
go

-- Part II
-- Same as Part I but looking for three values that sum to 2020 instead of just two values
select distinct
	ir1.inputValue * ir2.inputValue * ir3.inputValue as inputValueProduct
	into #inputRecordsCombos3
from
	#inputRecords ir1
	cross join #inputRecords ir2 -- Join every record to every record
	cross join #inputRecords ir3 -- One more cross join to get a third column with every record
where
	ir1.inputValue + ir2.inputValue + ir3.inputValue = 2020 -- Only keep the records that add up to 2020
;
go

-- Output the solutions
select
	'Part I' as partName
	, irc2.inputValueProduct
from
	#inputRecordsCombos2 irc2
union
select
	'Part II' as partName
	, irc3.inputValueProduct
from
	#inputRecordsCombos3 irc3
;
go
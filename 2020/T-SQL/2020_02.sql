/*
Solution for 2020 Day 2: Password Philosophy
https://adventofcode.com/2020/day/2
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
drop table if exists dbo.#inputPasswords
;
go

-- Create temp table to store the input
-- Input has three columns 
create table #inputPasswords
(
	passwordRange varchar(5) -- Maximum value is two two-digit numbers and a hyphen (xx-xx)
	, passwordChar char(2) -- value is one character and a colon
	, passwordStr varchar(50) -- Confirmed that max length in my input file is 20. 
)
;
go

-- Load the input file to the temp table.
-- Update to the folder and name of your input file
bulk insert #inputPasswords
from 'C:\Files\2020_02_input.txt'
with
(
	fieldterminator = ' ', -- Fields are split on the space
	rowterminator = '0x0a' -- Input files have the Linux LF line end. Use the hex notation '0x0A' to signify line end.
	--, keepnulls
)
;
go

select
	-- Sum the totals of the subqueries
	sum(p3.ValidPasswordPart1) as ValidPasswordPart1 -- Part I
	, sum(p3.ValidPasswordPart2) as ValidPasswordPart2 -- Part II
from
(
	select
		p2.passwordStr
		-- Part I
		-- Check if the password contains the character between the first and second value
		, case
			-- Use the original string length compared to the value of the replace function to determine the total number of matching characters.
			-- If it is within the range, it scores a 1 to be summed later.
			when len(p2.passwordStr) - len(replace(p2.passwordStr,p2.passwordChar,'')) between p2.firstValue and p2.secondValue
			then 1
			else 0
			end as ValidPasswordPart1
		-- Part II
		-- Check if the character is in one and only one of the matching positions from the range
		-- Same as above, if it is within the range, it scores a 1 to be summed later.
		, case
			when (substring(p2.passwordStr,p2.firstValue,1) = p2.passwordChar and substring(p2.passwordStr,p2.secondValue,1) <> p2.passwordChar)
				or (substring(p2.passwordStr,p2.firstValue,1) <> p2.passwordChar and substring(p2.passwordStr,p2.secondValue,1) = p2.passwordChar)
			then 1
			else 0
			end as ValidPasswordPart2
	from
	(
		select
			-- Divide the range into two values, first and second by doing a substring before and after the '-'
			cast(substring(p.passwordRange,1,charindex('-',p.passwordRange)-1) as int) as firstValue
			, cast(substring(p.passwordRange,charindex('-',p.passwordRange)+1,len(p.passwordRange)-charindex('-',p.passwordRange)) as int) as secondValue
			, p.passwordRange
			-- Capture only the character and filter out the colon
			, substring(p.passwordChar,1,charindex(':',p.passwordChar)-1) as passwordChar
			, p.passwordStr
		from
			#inputPasswords p
	) p2
) p3
;
go
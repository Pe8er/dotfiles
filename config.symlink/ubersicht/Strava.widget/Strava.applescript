-- Strava API documentation: http://strava.github.io/api/

property enableLogging : true -- options: true | false


-- Set a few global variables because I'm lazy, please don't touch.
global scriptStart, scriptEnd, myID, unit, otherSeparator
property userDecimalSeparator : item 2 of (1.1 as string)

-- I use the below commands to test. Please don't touch.
my test({"7217285", "7e704c75672b44b28c2f588f4eadd33d34dc912c", "KM", "4000", "12/12/24"})

on test(arguments)
	-- Grab arguments from input
	set myID to item 1 of arguments
	set token to item 2 of arguments
	set unit to item 3 of arguments
	set yDistGoal to item 4 of arguments
	try
		set deadline to item 5 of arguments
	on error
		set {year:y} to (current date)
		set deadline to "12/31/" & y
	end try
	set deadline to convertDate(deadline)
	
	-- Set up other variables
	set wNumber to (do shell script "date '+%V'") as number
	set dNumber to (do shell script "date '+%u'") as number
	
	set scriptStart to "curl -G https://www.strava.com/api/v3/athlete"
	set scriptEnd to " -H 'Authorization: Bearer " & token & "'"
	
	set otherSeparator to ","
	if userDecimalSeparator is "," then set otherSeparator to "."
	
	
	-------------------------------------------------------
	---------------MAIN CALCULATIONS----------------
	-------------------------------------------------------
	
	try
		-- Distance ridden this week, from Strava
		set wDistance to getwDistance()
		
		-- Distance ridden this year, from Strava
		set yDistance to getyDistance()
		
		-- How many weeks are remaining until the deadline?
		set wRemaining to round (((date deadline) - (current date)) div days / 7)
		
		-- Distance I need to ride weekly to meet my yearly goal
		set wDistGoal to (yDistGoal - yDistance) / wRemaining
		
		-- Percentage of weekly progress I have completed
		set wProgress to makePercent(wDistance / wDistGoal)
		
		-- Percentage of weekly progress I should have completed
		set wGoal to makePercent((dNumber * wDistGoal / 7) / wDistGoal)
		
		-- Percentage of yearly progress I have completed
		set yProgress to makePercent(yDistance / yDistGoal)
		
		-- Percentage of yearly progress I should have completed
		set yGoal to makePercent((wNumber * (yDistGoal / 52)) / yDistGoal)
		
		if unit is "M" then
			set yDistance to toMiles(yDistance)
			set wDistance to toMiles(wDistance)
		end if
		
		logEvent("My yearly goal (yDistGoal): " & yDistGoal & space & unit & return & Â
			"Distance I rode this year so far (yDistance): " & yDistance & space & unit & return & Â
			"Distance I rode this week so far (wDistance): " & wDistance & space & unit & return & Â
			"Percentage of weekly progress I have completed (wProgress): " & wProgress & return & Â
			"Percentage of weekly progress I should have completed (wGoal): " & wGoal & return & Â
			"Percentage of yearly progress I have completed (yProgress): " & yProgress & return & Â
			"Percentage of yearly progress I should have completed (yGoal): " & yGoal Â
			as string)
		
		return Â
			format(wDistance) & space & unit & "~" & Â
			wProgress & "~" & Â
			wGoal & "~" & Â
			format(yDistance) & space & unit & "~" & Â
			yProgress & "~" & Â
			yGoal Â
				as string
		
	on error e
		logEvent(e)
		return "NA"
	end try
end test


--------------------------------------------------------
---------------SUBROUTINES GALORE---------------
--------------------------------------------------------


on getwDistance()
	set wDistance to 0
	try
		set wDistanceRaw to do shell script scriptStart & "/activities" & scriptEnd & " -d after=" & (do shell script "date -v-Mon -v 0H -v 0M -v 0S +%s")
		set AppleScript's text item delimiters to "\"distance\":"
		set wDistanceRaw to text items 2 thru -1 of wDistanceRaw
	on error e
		logEvent(e)
		set AppleScript's text item delimiters to ""
		return 0
	end try
	repeat with aDay in wDistanceRaw
		set AppleScript's text item delimiters to ","
		set aDistance to text item 1 of aDay
		set wDistance to (aDistance as meters as kilometers as number) + wDistance
	end repeat
	set AppleScript's text item delimiters to ""
end getwDistance

on getyDistance()
	try
		set totalsRaw to do shell script scriptStart & "s/" & myID & "/stats" & scriptEnd
		set AppleScript's text item delimiters to "ytd_ride_totals\":{\"count\""
		set totalsRaw to text item 2 of totalsRaw
		set AppleScript's text item delimiters to ":"
		set totalsRaw to text item 3 of totalsRaw
		set AppleScript's text item delimiters to ","
		set yDistance to (text item 1 of totalsRaw)
		set AppleScript's text item delimiters to ""
		set yDistance to yDistance as meters as kilometers as number
		return yDistance
	on error e
		logEvent(e)
		return 0
	end try
end getyDistance

on convertDate(aDate)
	set deadline to current date
	set AppleScript's text item delimiters to "/"
	set d to text item 2 of aDate
	set m to text item 1 of aDate
	set y to text item 3 of aDate
	set AppleScript's text item delimiters to ""
	set deadline's year to y
	set deadline's month to m
	set deadline's day to d
	return deadline as string
end convertDate

on format(aNumber)
	if aNumber contains "E" then set aNumber to round aNumber
	set aNumber to my roundNumber(aNumber, 1)
	return my commaDelimit(aNumber)
end format

on roundNumber(n, numDecimals)
	if n contains "E" then set n to round n
	set x to 10 ^ numDecimals
	numberToString((((n * x) + 0.5) div 1) / x) as number
end roundNumber

on commaDelimit(aNumber)
	set aNumber to aNumber as string
	if aNumber contains "E" then set aNumber to numberToString(aNumber)
	if aNumber contains userDecimalSeparator then
		set AppleScript's text item delimiters to userDecimalSeparator
		set workingNumber to text item 1 of aNumber
		set suffixNumber to text item 2 of aNumber
		set AppleScript's text item delimiters to ""
	else
		set workingNumber to aNumber
		set suffixNumber to ""
	end if
	
	set the num_length to the length of workingNumber
	set the workingNumber to (the reverse of every character of workingNumber) as string
	set the newNumber to ""
	repeat with i from 1 to the num_length
		if i is the num_length or (i mod 3) is not 0 then
			set the newNumber to (character i of workingNumber & the newNumber) as string
		else
			set the newNumber to (otherSeparator & character i of workingNumber & the newNumber) as string
		end if
	end repeat
	if aNumber contains userDecimalSeparator then
		set newNumber to newNumber & userDecimalSeparator & suffixNumber
	end if
	return newNumber
end commaDelimit

on makePercent(thisNumber)
	set output to round thisNumber * 100
	if output is less than 0 then set output to 100
	return output & "%" as string
end makePercent

on toMiles(n)
	set n to n as kilometers as miles as number
end toMiles

on numberToString(aNumber)
	set aNumber to aNumber as string
	if aNumber contains "E+" then
		set x to the offset of userDecimalSeparator in aNumber
		set y to the offset of "+" in aNumber
		set z to the offset of "E" in aNumber
		set the decimal_adjust to characters (y - (length of aNumber)) thru Â
			-1 of aNumber as string as number
		if x is not 0 then
			set the first_part to characters 1 thru (x - 1) of aNumber as string
		else
			set the first_part to ""
		end if
		set the second_part to characters (x + 1) thru (z - 1) of aNumber as string
		set the converted_number to the first_part
		repeat with i from 1 to the decimal_adjust
			try
				set the converted_number to Â
					the converted_number & character i of the second_part
			on error
				set the converted_number to the converted_number & "0"
			end try
		end repeat
		return the converted_number
	else
		return aNumber
	end if
end numberToString

on logEvent(e)
	if enableLogging is true then
		set e to e as string
		tell application "Finder" to set myName to (name of file (path to me))
		do shell script "echo '" & "***LOG START***" & return & (current date) & return & e & return & "***LOG END***" & "' >> ~/Library/Logs/" & quoted form of myName & ".log"
	else
		return
	end if
end logEvent
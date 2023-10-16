--tell application "Music" to return properties of current track

try
	set songDuration to 0
	set currentPosition to 0
	
	try
		tell application "Music"
			set {artistName, songName, albumName, songDuration} to {artist, name, album, duration} of current track
			set coverURL to "NA"
			set songDuration to my comma_delimit(songDuration)
			set currentPosition to my formatNum(player position as string)
			set songDuration to my formatNum(songDuration as string)
			set audioCodec to kind of current track
		end tell
	on error e
		log e
	end try
on error e
	log e
end try
return artistName & " @ " & songName & " @ " & albumName & " @ " & songDuration & " @ " & currentPosition & " @ " & coverURL & " @ " & audioCodec


on formatNum(aNumber)
	set delimiters to {",", "."}
	repeat with aDelimiter in delimiters
		if aNumber contains aDelimiter then
			set AppleScript's text item delimiters to aDelimiter
			set outValue to text item 1 of aNumber
			set AppleScript's text item delimiters to ""
			return outValue
		end if
	end repeat
	if aNumber does not contain delimiters then return aNumber
end formatNum

on comma_delimit(this_number)
	set this_number to this_number as string
	if this_number contains "E" then set this_number to number_to_string(this_number)
	set the num_length to the length of this_number
	set the this_number to (the reverse of every character of this_number) as string
	set the new_num to ""
	repeat with i from 1 to the num_length
		if i is the num_length or (i mod 3) is not 0 then
			set the new_num to (character i of this_number & the new_num) as string
		else
			set the new_num to ("." & character i of this_number & the new_num) as string
		end if
	end repeat
	return the new_num
end comma_delimit

on number_to_string(this_number)
	set this_number to this_number as string
	if this_number contains "E+" then
		set x to the offset of "." in this_number
		set y to the offset of "+" in this_number
		set z to the offset of "E" in this_number
		set the decimal_adjust to characters (y - (length of this_number)) thru Â
			-1 of this_number as string as number
		if x is not 0 then
			set the first_part to characters 1 thru (x - 1) of this_number as string
		else
			set the first_part to ""
		end if
		set the second_part to characters (x + 1) thru (z - 1) of this_number as string
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
		return this_number
	end if
end number_to_string
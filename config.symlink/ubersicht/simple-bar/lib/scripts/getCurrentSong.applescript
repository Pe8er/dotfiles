set TID to AppleScript's text item delimiters
set mypath to POSIX path of (path to me)
set AppleScript's text item delimiters to "/"
set mypath to (mypath's text items 1 thru -2 as string) & "/"
set AppleScript's text item delimiters to TID

set musicPlayer to isMusicPlaying()

if musicPlayer is not "NA" then
	set rawOutput to run script mypath & "getCurrentSong" & musicPlayer & ".applescript"
	set AppleScript's text item delimiters to " @ "
	if (count of text items in rawOutput) > 1 then
		set tArtist to text item 1 of rawOutput
		set tSong to text item 2 of rawOutput
		set tAlbum to text item 3 of rawOutput
		set tCodec to text item -1 of rawOutput
		set AppleScript's text item delimiters to TID
		
		return tArtist & ":" & space & tSong & space & "[" & makeUpper(tCodec) & "]"
	end if
else
	return ""
end if

on isMusicPlaying()
	-- Spotify
	tell application "System Events" to if name of processes contains "Spotify" is true then
		try
			set musicPlayer to do shell script "osascript -e 'tell application \"Spotify\" to if player state is playing then return \"Spotify\"'"
			if musicPlayer is not "" then return musicPlayer
		on error e
			log e
		end try
	end if
	
	-- Music
	tell application "System Events" to if name of processes contains "Music" is true then
		try
			set musicPlayer to do shell script "osascript -e 'tell application \"Music\" to if player state is playing then return \"Music\"'"
			if musicPlayer is not "" then return musicPlayer
		on error e
			log e
		end try
	end if
	
	-- Plexamp
	tell application "System Events" to if (name of processes) contains "Plexamp" is true then return "Plexamp"
	
	-- If nothing is playing
	return "NA"
end isMusicPlaying

on makeUpper(inString)
	return (do shell script "awk '{ print toupper($0) }' <<< \"" & inString & "\"")
end makeUpper
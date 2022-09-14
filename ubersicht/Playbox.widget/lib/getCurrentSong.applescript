global mypath, plexOutput

set mypath to POSIX path of (path to me)
set AppleScript's text item delimiters to "/"
set mypath to (mypath's text items 1 thru -2 as string) & "/"
set AppleScript's text item delimiters to ""

set musicPlayer to isMusicPlaying()

if musicPlayer is "Plexamp" then
	return plexOutput
else if musicPlayer is "Spotify" then
	run script mypath & "getCurrentSongSpotify.applescript"
else
	return "NA"
end if

on isMusicPlaying()
	
	-- Plexamp
	tell application "System Events" to set isRunning to (name of processes) contains "Plexamp"
	if isRunning is true then
		try
			with timeout of 2 seconds
				-- get Plex server status and playback details
				set plexOutput to do shell script "/opt/homebrew/bin/python3" & space & quoted form of mypath & "plex-now-playing.py"
				set AppleScript's text item delimiters to " @ "
				set isPlexAmpPlaying to text item 1 of plexOutput
				set AppleScript's text item delimiters to ""
				if isPlexAmpPlaying is "playing" then
					-- remove player state from the output string
					set plexOutput to characters 11 thru -1 of plexOutput as string
					return "Plexamp"
				end if
			end timeout
		on error e
			log e
		end try
	end if
	
	-- Spotify
	tell application "System Events" to set isRunning to (name of processes) contains "Spotify"
	if isRunning is true then
		try
			with timeout of 2 seconds
				tell application "Spotify" to if player state is playing then return "Spotify"
			end timeout
		on error e
			log e
		end try
	end if
	
	-- Music
	tell application "System Events" to set isRunning to (name of processes) contains "Music"
	if isRunning is true then
		try
			with timeout of 2 seconds
				tell application "Music" to if player state is playing then return "Music"
			end timeout
		on error e
			log e
		end try
	end if
	
	-- If nothing is playing
	return "NA"
end isMusicPlaying
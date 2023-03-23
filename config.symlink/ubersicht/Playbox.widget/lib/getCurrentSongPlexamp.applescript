global mypath, plexToken, plexUsername, plexPassword, plexXML
set plexServer to "http://192.168.1.200:32400"
set plexUsername to "pe8er"

-- Find my path
set mypath to POSIX path of (path to me)
set AppleScript's text item delimiters to "/"
set mypath to (mypath's text items 1 thru -2 as string) & "/"
set AppleScript's text item delimiters to ""

-- Get token
-- Check if token exists
if FileExists(mypath & ".plextoken") is false then
	
	-- Request token using username and password
	my requestToken()
else
	set tokenFile to POSIX file (mypath & ".plextoken") as string
	
	--If plextoken is older than 1 day, request a new token
	tell application "System Events"
		if (current date) - (modification date of file tokenFile) > 86400 then
			my requestToken()
		end if
	end tell
end if

-- Get token from the file
set plexToken to read (mypath & ".plextoken") as string


-- Get current Plex session using token
try
	set plexXML to (do shell script "curl -H 'X-Plex-Token: " & plexToken & "'" & space & plexServer & "/status/sessions")
on error e
	log e
	return "NA"
end try

-- Extract metadata from session XML, as long as it's valid
if (count of paragraphs of plexXML) is greater than 3 then
	tell application "System Events"
		tell XML element "Track" of XML element "MediaContainer" of (make new XML data with data plexXML)
			set playerState to value of XML attribute "state" of XML element "Player"
			set artistName to value of XML attribute "grandparentTitle"
			set songName to value of XML attribute "title"
			set albumName to value of XML attribute "parentTitle"
			set songDuration to value of XML attribute "duration"
			set currentPosition to value of XML attribute "viewOffset"
			set coverURL to plexServer & value of XML attribute "parentThumb"
			set audioCodec to value of XML attribute "audioCodec" of XML element "Media"
		end tell
	end tell
	
	--Return the string for Ubersicht to show
	if playerState is "paused" then
		return "NA"
	else
		return artistName & space & "@" & space & songName & space & "@" & space & albumName & space & "@" & space & songDuration & space & "@" & space & currentPosition & space & "@" & space & coverURL & space & "@" & space & audioCodec
	end if
else
	return "NA"
end if





on findPassword()
	-- Find password in Keychain
	try
		set plexPassword to (do shell script "security find-generic-password -a " & plexUsername & " -s Playbox -w")
	on error e
		-- If password doesn't exist, create it
		log e
		my createPassword()
	end try
end findPassword

on requestToken()
	set plexPassword to my findPassword()
	
	-- Request token using username and password
	my curlToken()
	
	--local JSON for testing
	--set plexXML to (read file ((path to desktop as text) & "plexlogin.json"))
	
	-- If there is an authentication problem, ask for a new password
	if plexXML begins with "{\"error\"" then
		my createPassword()
		my curlToken()
	end if
	
	-- Extract authentication token from Plex response, caveman style because Applescript can't parse JSON on its own
	try
		set TID to AppleScript's text item delimiters
		set AppleScript's text item delimiters to "authToken\":\""
		set plexToken to text item 2 of plexXML
		set AppleScript's text item delimiters to "\""
		set plexToken to text item 1 of plexToken
		set AppleScript's text item delimiters to TID
	on error e
		display dialog "Authentication problem. Most likely Plex API's fault. Please try again."
		error number -128
	end try
	
	-- Save token to a hidden file
	writeToFile(plexToken, POSIX file (mypath & ".plextoken"))
end requestToken

on createPassword()
	set plexPassword to text returned of (display dialog "What is your Plex password?" default answer "Your Plex password")
	set plexPassword to (do shell script "security add-generic-password -a " & plexUsername & " -s Playbox -U -w " & quoted form of plexPassword)
end createPassword

on curlToken()
	set plexXML to (do shell script "curl -d 'user%5Blogin%5D=" & plexUsername & "' -d 'user%5Bpassword%5D=" & plexPassword & "' -H 'X-Plex-Client-Identifier: Playbox' -H 'X-Plex-Client-Product: Playbox' -H 'X-Plex-Version: 1.0' https://plex.tv/users/sign_in.json")
end curlToken

on FileExists(theFile) -- (String) as Boolean
	tell application "System Events"
		if exists file theFile then
			return true
		else
			return false
		end if
	end tell
end FileExists

on writeToFile(thisData, targetFile)
	try
		set the targetFile to the targetFile as string
		set the openTargetFile to open for access file targetFile with write permission
		set eof of the openTargetFile to 0
		write thisData to the openTargetFile starting at eof
		close access the openTargetFile
		return true
	on error e
		try
			close access file targetFile
		end try
		return e
	end try
end writeToFile
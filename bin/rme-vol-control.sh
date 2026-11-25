#!/bin/bash

################################################################################
# Script Name: volcontrol.sh
# Description: This script changes volume up/down/mute on the RME ADI DAC. Can be used with a hotkey daemon like triggerhapp or home assistant.
# Author: Jostein Guldal
# GitHub Repository: https://github.com/JolleNo10/RmeAdiVolumeController/
################################################################################


# Configuration
    # Default log level
    enableLogging=0 # 1 enable, 0 disable

    # Global variables
    defaultVolume=-350 # start/default volume state when you don't know the RME state
    highVolume=-200 # limit max volume (for protection) will cycle back to defaultVolume
    lowVolume=-1000 # limit min volume (for protection) will cycle back to defaultVolume
    volumeTick=5 # volume increase per tick
    volumeTickMultiplierTimeThreshold=500 # time between concurrent ticks for increased/faster volume change
    volumeTickMultiplier=2 # volumeTick multiplier if ticks differ with less than volumeTickMultiplierTimeThreshold, 1 to disable
    defaultMute=0 # start/default mute state when you don't know the RME state

    rmeCurrentVolumeFile="/Users/pe8er/.dotfiles/bin/rme-current-volume" #store virtual RME state (only calculated from relative changes)
    logfile="/Users/pe8er/.dotfiles/bin/rme-log" #log file location
    rmeAdiMidiControlScript="/Users/pe8er/.dotfiles/bin/rme-midi-control.sh" #RME ADI MIDI script location

    # Based on https://www.rme-audio.de/downloads/adi2remote_midi_protocol.zip
    midiConfig_device_id=0x71 # 0x71 - ADI-2 DAC # 0x72 - ADI-2 Pro # 0x73 - ADI-2/4 Pro SE
    midiConfig_command_id=0x02 # 0x02 - Send Parameter(s) to device
    midiConfig_address=6 # 6 - Phones Channel Settings
    midiConfig_index_mute=15 # 15 - Mute
    midiConfig_index_volume=12 # 12 - Volume
# --

log() {
    local loglevel="$1"
    local logmessage="$2"
    if [ "$enableLogging" -eq 0 ]; then
        return 0;
    fi

    local logdate=$(date +"%Y-%m-%d %H:%M:%S")
    local logentry="$logdate [$loglevel] $logmessage"
        
    # Check if log file exists, create if it doesn't
    if [ ! -f "$logfile" ]; then
        touch "$logfile" || { echo "Error: Failed to create log file $logfile"; return; }
    fi

    if [ "$loglevel" = "DEBUG" ] && ([ "$log_level" = "DEBUG" ]); then
        echo "$logentry" >> $logfile
    elif [ "$loglevel" = "INFO" ] && ( [ "$log_level" = "INFO" ] || [ "$log_level" = "DEBUG" ]); then
        echo "$logentry" >> $logfile
    elif [ "$loglevel" = "ERROR" ] && ( [ "$log_level" = "INFO" ] || [ "$log_level" = "DEBUG" ] || [ "$log_level" = "ERROR" ]); then
        echo "$logentry" >> $logfile
    fi
}

getTimestampWithMillis() {
    date +%s%3N
}

#Reading state file and sets defaults
readStateFromFile() {
    log "DEBUG" "Reading Volume from File"
    local file=$rmeCurrentVolumeFile
    if [ -f "$file" ]; then

        # Use read command to split the string into variables
        IFS=',' read -r volumeTimestamp currentVolume currentMute < "$file"

        if checkVolume "$currentVolume"; then
            log "DEBUG" "Read value from file is valid: $currentVolume"
        else
            log "ERROR" "Read value from file is not valid: $currentVolume"
            volumeTimestamp=$(getTimestampWithMillis)
            currentVolume=$defaultVolume
            currentMute=$defaultMute
            writeStateToFile $currentVolume $currentMute
        fi
    else
        log "ERROR" "File rmeAdiCurrentVolume.txt not found."
    fi
}

writeStateToFile() { #adjustedVolume="$1" adjustedMute="$2"
    local currentTime=$(getTimestampWithMillis)

    log "DEBUG" "Writing state to File: $currentTime,$1,$2"
    echo "$currentTime,$1,$2" > "$rmeCurrentVolumeFile"
}

checkVolume() {
    local volume="$1"
    
    # Check if volume is an integer and within the range
    if ! (( volume >= lowVolume && volume <= highVolume )); then
        log "ERROR" "Volume Check: Volume is not within the range of $lowVolume to $highVolume or not an integer value: $volume."
        return 1
    fi

    log "DEBUG" "Volume Check ok: $volume"
    return 0
}

adjustVolume() {
    local mode=$1

    # Read state from file and extract currentVolume and currentMute
    readStateFromFile

    local value
    local midiConfig_index
    local state

    if ([ "$mode" = "up" ] || [ "$mode" = "down" ]); then
        # Calculate adjusted volume tick based on time difference
        local currentTime=$(getTimestampWithMillis)
        local tsDiff=$(($currentTime - $volumeTimestamp))
        local adjustedVolumeTick

        #Small volume change scaling, adjusting tick with multiplier $volumeTickMultiplier if changing quicker than $volumeTickMultiplierTimeThreshold
        if [ "$tsDiff" -lt $volumeTickMultiplierTimeThreshold ]; then
            adjustedVolumeTick=$(echo "$volumeTick * $volumeTickMultiplier" | bc)
            log "DEBUG" "Diff, ms since last volume adjust: $tsDiff, less than threshold"
        else
            adjustedVolumeTick=$volumeTick
            log "DEBUG" "Diff, ms since last volume adjust: $tsDiff, outside threshold"
        fi
        
        log "DEBUG" "Adjusting volume $mode volumeTick: $volumeTick, adjustedVolumeTick: $adjustedVolumeTick"

        #Setting new volume
        if [ "$mode" = "up" ]; then
            value=$((currentVolume + adjustedVolumeTick))
        else
            value=$((currentVolume - adjustedVolumeTick))
        fi

        #Check volume value
        if checkVolume "$value"; then
            log "INFO" "All checks ok, setting adjusted volume: $1, volumeTick: $volumeTick, adjustedVolumeTick: $adjustedVolumeTick"
        else
            log "ERROR" "Volume not valid $value Restting volume to $defaultVolume"
            value=$defaultVolume
        fi

        # 12 - Volume
        midiConfig_index=$midiConfig_index_volume

        state="$value $currentMute"
    elif  [ "$mode" = "mute" ]; then
        value=$((currentMute ^ 1))

        # 15 - Mute
        midiConfig_index=$midiConfig_index_mute

        state="$currentVolume $value"
    else
        log "ERROR" "Invalid input parameter. Please provide either 'up', 'down' or 'mute'."
        exit 1
    fi

    performChange $value $midiConfig_device_id $midiConfig_command_id $midiConfig_address $midiConfig_index
    writeStateToFile $state
}

performChange() {
    local adjustedValue="$1"
    local midiconfig="$2 $3 $4 $5"

    log "DEBUG" "Perform change, variables $adjustedValue $midiconfig $enableLogging $log_level $logfile"
    
    error=$(bash "$rmeAdiMidiControlScript" $adjustedValue $midiconfig $enableLogging $log_level $logfile 2>&1)

    if [ $? -eq 0 ]; then
        log "DEBUG" "MidiScript call succeeded."
    else
        log "ERROR" "MidiScript call failed with error: $error"
    fi
}

#------------------------------------------------------------------------------------------------------------------
timeStart=$(getTimestampWithMillis)

# Check if the first input parameter is provided
if [ $# -eq 0 ]; then
    echo "Error: First input parameter is missing." >&2  # Redirect error message to stderr
    exit 1
fi

# Set log level to uppercase if the second parameter is defined
if [ ! -z "$2" ]; then 
    log_level="${2^^}"
else
    log_level="${2:-ERROR}"  # Set to ERROR if not defined
fi

if [ ! -z "$3" ] && ([ "$3" -eq 0 ] || [ "$3" -eq 1 ]); then
    enableLogging=$3
fi

log "DEBUG" "-- SCRIPT STARTED --"
log "DEBUG" "Perf: Timestart: $timeStart"

# Check the value of the first input parameter and call the appropriate function
case "$1" in
    up|down|mute)
        log "DEBUG" "Adjusting volume $1"
        adjustVolume "$1"
        ;;
    *)
        log "ERROR" "Invalid input parameter. Please provide either 'up', 'down', or 'mute'."
        exit 1
        ;;
esac

log "DEBUG" "Perf: TimeEnd: $(getTimestampWithMillis) diff: $((($(getTimestampWithMillis) - timeStart)))"
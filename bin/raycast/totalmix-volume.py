#!/usr/bin/python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title RME TotalMix Volume
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔊
# @raycast.argument1 { "type": "text", "placeholder": "up | down | mute | toggle" }
# @raycast.packageName com.pe8er.rme

# Documentation:
# @raycast.author Pior Gajos
# @raycast.authorURL https://github.com/Pe8er

# No third-party packages on purpose: this runs on macOS's built-in
# /usr/bin/python3, so Homebrew/pyenv Python upgrades can't break it.

import os
import socket
import struct
import sys

# Configuration
IP = "127.0.0.1"
PORT = 7001
STATE_FILE = os.path.expanduser("~/.totalmix_vol_state")
STEP = 0.05
MAX_VOL = 0.8  # Limiter
MIN_VOL = 0.0
DEFAULT_VOL = 0.3

def _osc_string(value):
    """OSC string: UTF-8, null-terminated, padded to a multiple of 4 bytes."""
    data = value.encode("utf-8") + b"\0"
    return data + b"\0" * (-len(data) % 4)

def send_osc(address, value):
    """Send one OSC message with a single float argument over UDP."""
    packet = _osc_string(address) + _osc_string(",f") + struct.pack(">f", float(value))
    with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
        sock.sendto(packet, (IP, PORT))

def get_state():
    """Returns (current_volume, last_unmuted_volume)"""
    if os.path.exists(STATE_FILE):
        with open(STATE_FILE, "r") as f:
            try:
                lines = f.readlines()
                curr = float(lines[0].strip())
                # If we have a second line, that's our restore point
                prev = float(lines[1].strip()) if len(lines) > 1 else curr
                return curr, prev
            except (ValueError, IndexError):
                return DEFAULT_VOL, DEFAULT_VOL
    return DEFAULT_VOL, DEFAULT_VOL

def save_state(curr, prev):
    with open(STATE_FILE, "w") as f:
        f.write(f"{round(curr, 2)}\n{round(prev, 2)}")

def main():
    if len(sys.argv) < 2:
        print("Usage: totalmix-volume.py [up|down|mute|toggle]")
        return

    command = sys.argv[1].lower().strip()

    # Speaker B toggle: TotalMix flips the Control Room "Speaker B" button
    # (Main Out <-> Main Out B) on each 1.0 it receives. No local state needed.
    if command in ("b", "speakerb", "speaker-b", "toggle"):
        send_osc("/1/mainSpeakerB", 1.0)
        print("RME Fireface: main out toggled")
        return
    current_vol, last_unmuted = get_state()
    
    new_vol = current_vol
    new_last_unmuted = last_unmuted

    if command == "up":
        # If we were at 0 (muted), we might want to jump back to last volume,
        # but standard behavior is usually just to increment from 0.
        new_vol = min(MAX_VOL, current_vol + STEP)
        new_last_unmuted = new_vol # Update restore point since we're active
    
    elif command == "down":
        new_vol = max(MIN_VOL, current_vol - STEP)
        if new_vol > 0:
            new_last_unmuted = new_vol
    
    elif command == "mute":
        if current_vol > 0:
            # We are currently audible, so MUTE it
            new_last_unmuted = current_vol # Remember this level
            new_vol = 0.0
        else:
            # We are currently muted (0.0), so UNMUTE it
            new_vol = last_unmuted if last_unmuted > 0 else DEFAULT_VOL
    
    else:
        print(f"Unknown command: {command}")
        return

    # Save and Send
    save_state(new_vol, new_last_unmuted)
    send_osc("/1/mastervolume", new_vol)
    
    status = f"{round(new_vol * 100)}%"
    print(f"RME Fireface: Volume set to {status}")

if __name__ == "__main__":
    main()

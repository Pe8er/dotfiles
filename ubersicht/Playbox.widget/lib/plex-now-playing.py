from curses import echo
from pathlib import Path
from cmath import log
# import logging
# import sys
import os
import json
import requests
import re
from datetime import datetime
from xml.etree import ElementTree as ET
import keyring

# logging.basicConfig(level=logging.DEBUG)

VERSION = "0.1.0"
WORKING_DIR = os.path.dirname(os.path.realpath(__file__))
PLEX_SERVER = 'http://192.168.1.200:32400'  # Address of Plex server to query
USERNAME = 'pe8er'  # Plex username to login, only required on first run
# Plex password to login, after first run, stored in keyring

# The location of the file that stores Plex token
token_path = os.path.expanduser(WORKING_DIR) + '/' + '.plextoken'

PASSWORD = Path(os.path.expanduser(WORKING_DIR) + '/' + 'password.txt').read_text()

print(PASSWORD)

# Check if there's a token saved
token = None
username = None
if os.path.exists(token_path):
    with open(token_path) as file:
        username, token = file.readline().split(',')
    token_last_update = os.path.getmtime(token_path)
    token_last_update = datetime.fromtimestamp(token_last_update)
    if (datetime.now() - token_last_update).days >= 1:
        token = None

# Update the token if there wasn't one saved, or it's older than a day
if not token:
    username = username or USERNAME
    password = keyring.get_password('Plex-Now-Playing', username) or PASSWORD
    keyring.set_password('Plex-Now-Playing', username, password)
    token_request = requests.post(
        url='https://plex.tv/users/sign_in.json',
        data='user%5Blogin%5D={u}&user%5Bpassword%5D={p}'.format(u=username, p=password),
        headers={
            'X-Plex-Client-Identifier': 'Plex-Now-Playing',
            'X-Plex-Product': 'Plex-Now-Playing',
            'X-Plex-Version': VERSION
        },
        verify=False
    )
    if token_request.status_code < 300:
        token = json.loads(token_request.text)['user']['authToken']
        with open(token_path, 'w') as file:
            file.write('{0},{1}'.format(username, token))
    else:
        print('Authentication problem')
        exit()

# Ask the local Plex server for the current sessions
now_playing = requests.get(
        url=PLEX_SERVER + '/status/sessions',
        headers={'X-Plex-Token': token}
    )
streams_xml = ET.fromstring(now_playing.text)  # Parse the XML returned by Plex

# For each stream, print an informative line about the stream
if len(streams_xml):  # Is len() here necessary?
    for stream in streams_xml:

        # Return the player state
        player_state = str(stream.find('Player').get('state', default='Unknown User'))
        playerstate = re.search('[^@]+', player_state)
        if playerstate is not None:
            playerstate = playerstate.group(0)
        else:
            playerstate = player_state

        # Return either the time a transcode started _or_ the current time as a string
        start_time = stream.get('lastViewedAt', default=datetime.now())
        if type(start_time) is str:
            start_time = datetime.fromtimestamp(int(start_time))
        start_time = start_time.strftime('%a %H:%M')  # Mon HH:MM

        # The regex returns None if there's no match, None.group() is AttributeError
        season = re.search('[0-9]+', str(stream.get('parentTitle')))
        if season is not None:
            season = season.group(0)

        # Truncate the series name to make it shorter
        series_name_long = stream.get('grandparentTitle', default='Unknown Series')
        series_name = ' '.join(series_name_long.split(' ')[:5])  # Only first five words

        # Define how each type of stream is displayed
        stream_formats = dict()
        stream_formats['track'] = '{playerstate}^{track_artist}^{track_title}^{album}^{currentCoverURL}^{codec}'
        stream_formats['episode'] = '{start}, {playerstate} // {series} - S{season}E{episode} - {tv_name}'
        stream_formats['movie'] = '{start}, {playerstate} // {movie_title} ({year})'
        stream_formats.setdefault('{start}, {playerstate} // Unknown Stream')

        # Apply formatting to stream data
        display_str = stream_formats[stream.get('type')].format(
            start=start_time,
            movie_title=stream.get('title', default='Unknown Movie'),
            playerstate=playerstate,
            series=series_name,
            season=season,
            album=str(stream.get('parentTitle', default='0')),
            duration=str(stream.get('duration', default='0')),
            isloved=str(stream.get('userRating', default='')),
            # http: // 192.168.1.200: 32400/library/metadata/48167/thumb/1661222466
            # currentCoverURL='http://192.168.1.200:32400/library/metadata/48167/thumb/1661222466',
            currentCoverURL=PLEX_SERVER+stream.get(
                'parentThumb', default='None'),
            codec=str(stream.find('Media').get('audioCodec', default='FLAC')),
            episode=stream.get('index', default=''),
            tv_name=stream.get('title', default='Unknown Episode'),
            # year=stream.get('originallyAvailableAt').split('-')[0],
            track_title=stream.get('title', default='Unknown Song'),
            track_artist=stream.get('grandparentTitle', default='Unknown Artist'),
            track_album=stream.get('parentTitle', default='Unknown Album'),
        )

        print("" + display_str)  # Truncate display at 75 characters
else:
    print('Nothing')
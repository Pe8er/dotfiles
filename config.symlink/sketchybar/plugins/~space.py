#!/usr/bin/python3

import os, json, re

ICON_MAP = [
    {"regex": r"1Password 7", "icon": ":one_password:"},
    {"regex": r"Affinity Designer|Adobe Photoshop 2024", "icon": ":affinity_designer:"},
    {"regex": r"Affinity Photo|Lightroom Classic", "icon": ":affinity_photo:"},
    {"regex": r"Affinity Publisher", "icon": ":affinity_publisher:"},
    {"regex": r"Airmail", "icon": ":airmail:"},
    {"regex": r"Alacritty|Hyper|iTerm2|kitty|Terminal|WezTerm", "icon": ":terminal:"},
    {"regex": r"Alfred", "icon": ":alfred:"},
    {"regex": r"Android Messages", "icon": ":android_messages:"},
    {"regex": r"Android Studio", "icon": ":android_studio:"},
    {"regex": r"App Store", "icon": ":app_store:"},
    {"regex": r"Atom", "icon": ":atom:"},
    {"regex": r"Audacity", "icon": ":audacity:"},
    {"regex": r"Bear", "icon": ":bear:"},
    {"regex": r"Bitwarden", "icon": ":bit_warden:"},
    {"regex": r"Blender", "icon": ":blender:"},
    {"regex": r"Books", "icon": "book"},
    {"regex": r"Brave Browser", "icon": ":brave_browser:"},
    {"regex": r"Calendar|Fantastical", "icon": ":calendar:"},
    {"regex": r"Calibre", "icon": ":book:"},
    {"regex": r"Canary Mail|HEY|Mail|Mailspring|MailMate|邮件|Outlook", "icon": ":mail:"},
    {"regex": r"Caprine", "icon": ":caprine:"},
    {"regex": r"Chromium|Google Chrome|Google Chrome Canary", "icon": ":google_chrome:"},
    {"regex": r"CleanMyMac X", "icon": ":desktop:"},
    {"regex": r"ClickUp", "icon": ":click_up:"},
    {"regex": r"Code|Code - Insiders", "icon": ":code:"},
    {"regex": r"Color Picker", "icon": ":color_picker:"},
    {"regex": r"DataGrip", "icon": ":datagrip:"},
    {"regex": r"Default", "icon": ":default:"},
    {"regex": r"DEVONthink 3", "icon": ":devonthink3:"},
    {"regex": r"Discord|Discord Canary|Discord PTB", "icon": ":discord:"},
    {"regex": r"Drafts", "icon": ":drafts:"},
    {"regex": r"Dropbox", "icon": ":dropbox:"},
    {"regex": r"Element", "icon": ":element:"},
    {"regex": r"Emacs", "icon": ":emacs:"},
    {"regex": r"Evernote Legacy", "icon": ":evernote_legacy:"},
    {"regex": r"FaceTime", "icon": ":face_time:"},
    {"regex": r"Figma", "icon": ":figma:"},
    {"regex": r"Final Cut Pro", "icon": ":final_cut_pro:"},
    {"regex": r"Finder|访达", "icon": ":finder:"},
    {"regex": r"Firefox Developer Edition|Firefox Nightly", "icon": ":firefox_developer_edition:"},
    {"regex": r"Firefox", "icon": ":firefox:"},
    {"regex": r"Folx", "icon": ":folx:"},
    {"regex": r"GitHub Desktop", "icon": ":git_hub:"},
    {"regex": r"Grammarly Editor", "icon": ":grammarly:"},
    {"regex": r"GrandTotal|Receipts", "icon": ":dollar:"},
    {"regex": r"IINA", "icon": ":playing:"},
    {"regex": r"Insomnia", "icon": ":insomnia:"},
    {"regex": r"IntelliJ IDEA", "icon": ":idea:"},
    {"regex": r"Iris", "icon": ":iris:"},
    {"regex": r"Joplin", "icon": ":joplin:"},
    {"regex": r"Kakoune", "icon": ":kakoune:"},
    {"regex": r"KeePassXC", "icon": ":kee_pass_x_c:"},
    {"regex": r"Keyboard Maestro", "icon": ":keyboard_maestro:"},
    {"regex": r"Keynote", "icon": ":keynote:"},
    {"regex": r"League of Legends", "icon": ":league_of_legends:"},
    {"regex": r"LibreWolf", "icon": ":libre_wolf:"},
    {"regex": r"Linear", "icon": ":linear:"},
    {"regex": r"Live", "icon": ":ableton:"},
    {"regex": r"MAMP|MAMP PRO", "icon": ":mamp:"},
    {"regex": r"Matlab", "icon": ":matlab:"},
    {"regex": r"Mattermost", "icon": ":mattermost:"},
    {"regex": r"Messages|Nachrichten", "icon": ":messages:"},
    {"regex": r"Microsoft Edge", "icon": ":microsoft_edge:"},
    {"regex": r"Microsoft Excel", "icon": ":microsoft_excel:"},
    {"regex": r"Microsoft PowerPoint", "icon": ":microsoft_power_point:"},
    {"regex": r"Microsoft Teams", "icon": ":microsoft_teams:"},
    {"regex": r"Microsoft To Do|Things", "icon": ":things:"},
    {"regex": r"Microsoft Word", "icon": ":microsoft_word:"},
    {"regex": r"Min", "icon": ":min_browser:"},
    {"regex": r"MoneyMoney", "icon": ":bank:"},
    {"regex": r"mpv", "icon": ":mpv:"},
    {"regex": r"Music", "icon": ":music:"},
    {"regex": r"Neovide|MacVim|Vim|VimR", "icon": ":vim:"},
    {"regex": r"Notability", "icon": ":notability:"},
    {"regex": r"Notes", "icon": ":notes:"},
    {"regex": r"Notion", "icon": ":notion:"},
    {"regex": r"Nova", "icon": ":nova:"},
    {"regex": r"Numbers", "icon": ":numbers:"},
    {"regex": r"Numi", "icon": ":add:"},
    {"regex": r"OBS", "icon": ":obsstudio:"},
    {"regex": r"Obsidian", "icon": ":obsidian:"},
    {"regex": r"OmniFocus", "icon": ":omni_focus:"},
    {"regex": r"Pages", "icon": ":pages:"},
    {"regex": r"Parallels Desktop", "icon": ":parallels:"},
    {"regex": r"Pi-hole Remote", "icon": ":pihole:"},
    {"regex": r"Pine", "icon": ":pine:"},
    {"regex": r"Podcasts", "icon": ":podcasts:"},
    {"regex": r"PomoDone App", "icon": ":pomodone:"},
    {"regex": r"Preview|Skim|zathura", "icon": ":pdf:"},
    {"regex": r"qutebrowser", "icon": ":qute_browser:"},
    {"regex": r"Reeder", "icon": ":reeder5:"},
    {"regex": r"Reminders", "icon": ":reminders:"},
    {"regex": r"Safari|Safari Technology Preview", "icon": ":safari:"},
    {"regex": r"Sequel Ace", "icon": ":sequel_ace:"},
    {"regex": r"Sequel Pro", "icon": ":sequel_pro:"},
    {"regex": r"Setapp", "icon": ":setapp:"},
    {"regex": r"SF Symbols", "icon": ":android_studio:"},
    {"regex": r"Signal", "icon": ":signal:"},
    {"regex": r"Silicio", "icon": ":music:"},
    {"regex": r"Sketch", "icon": ":sketch:"},
    {"regex": r"Skype", "icon": ":skype:"},
    {"regex": r"Slack", "icon": ":slack:"},
    {"regex": r"Spark", "icon": ":spark:"},
    {"regex": r"Spotify", "icon": ":spotify:"},
    {"regex": r"Spotlight", "icon": ":spotlight:"},
    {"regex": r"Sublime Text", "icon": ":sublime_text:"},
    {"regex": r"System Preferences|System Settings", "icon": ":gear:"},
    {"regex": r"TeamSpeak 3", "icon": ":team_speak:"},
    {"regex": r"Telegram", "icon": ":telegram:"},
    {"regex": r"Thunderbird", "icon": ":thunderbird:"},
    {"regex": r"TickTick", "icon": ":tick_tick:"},
    {"regex": r"TIDAL", "icon": ":tidal:"},
    {"regex": r"Todoist", "icon": ":todoist:"},
    {"regex": r"Tor Browser", "icon": ":tor_browser:"},
    {"regex": r"Tower", "icon": ":tower:"},
    {"regex": r"Transmit", "icon": ":transmit:"},
    {"regex": r"Trello", "icon": ":trello:"},
    {"regex": r"Tweetbot|Twitter", "icon": ":twitter:"},
    {"regex": r"Typora", "icon": ":text:"},
    {"regex": r"Vivaldi", "icon": ":vivaldi:"},
    {"regex": r"VLC", "icon": ":vlc:"},
    {"regex": r"VMware Fusion", "icon": ":vmware_fusion:"},
    {"regex": r"VSCodium", "icon": ":vscodium:"},
    {"regex": r"WebStorm", "icon": ":web_storm:"},
    {"regex": r"WhatsApp", "icon": ":whats_app:"},
    {"regex": r"Xcode", "icon": ":xcode:"},
    {"regex": r"Zeplin", "icon": ":zeplin:"},
    {"regex": r"zoom.us", "icon": ":zoom:"},
    {"regex": r"Zotero", "icon": ":zotero:"},
    {"regex": r"Zulip", "icon": ":zulip:"},
    {"regex": r"微信", "icon": ":wechat:"},
    {"regex": r"网易云音乐", "icon": ":netease_music:"},
]

def to_sup(s):
    sups = {u'0': u'\u2070',
            u'1': u'\xb9',
            u'2': u'\xb2',
            u'3': u'\xb3',
            u'4': u'\u2074',
            u'5': u'\u2075',
            u'6': u'\u2076',
            u'7': u'\u2077',
            u'8': u'\u2078',
            u'9': u'\u2079'}

    return ''.join(sups.get(char, char) for char in str(s))


def to_icon(app):
    for x in ICON_MAP:
        if re.search(x['regex'], app):
            return x['icon']
    return ':default:'


def to_formatted_icon(app, c):
    cnt = f" {to_sup(c)}" if c > 1 else ''
    return f"{to_icon(app)}{cnt}"

def to_formatted_icons(apps):
    return ' '.join([to_formatted_icon(app, cnt) for app, cnt in apps.items()])


spaces = {}
apps = json.loads(os.popen('yabai -m query --windows').read())
for app in apps:
    spaces[app['space']] = spaces.get(app['space'], {})
    spaces[app['space']][app['app']] = spaces[app['space']].get(app['app'], 0) + 1

# current_window = json.loads(os.popen('yabai -m query --windows --window').read())

# if [current_window['has-focus']] == [True]:
#     color = "label.color=$RED"
# else:
#     color = "label.color=$GREY"

args = ' '.join([f'--set space.{space} label="{to_formatted_icons(apps)}" label.drawing=on' for space, apps in spaces.items()])
default_args = "--set '/space\..*/' background.drawing=on --animate sin 10"

args2 = ''
spaces = json.loads(os.popen('yabai -m query --spaces').read())
for space in spaces:
    if not space['windows']:
        args2 = f'{args2} --set space.{space["index"]} label="" label.drawing=off'

os.system(f'sketchybar -m {default_args} {args} {args2}')
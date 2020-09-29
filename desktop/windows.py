#!/usr/bin/env python3
import subprocess
import getpass

def get(command):
    return subprocess.check_output(["/bin/bash", "-c", command]).decode("utf-8")

def execute(command):
    subprocess.Popen(["/bin/bash", "-c", command])
# calculate screen resolution
res_output = get("xrandr").split(); idf = res_output.index("current")
res = (int(res_output[idf+1]), int(res_output[idf+3].replace(",", "")))
# creating window list on current viewport / id's / application names
w_data = [l.split()[0:7] for l in get("wmctrl -lpG").splitlines()]
windows = [[get("ps -u "+getpass.getuser()+" | grep "+w[2]).split()[-1], w[0]]
           for w in w_data if 0 < int(w[3]) < res[0] and 0 < int(w[4]) < res[1]]
# preparing zenity optionlist
apps = [item[0] for item in windows]
# prevent multiple zenity windows
if apps.count("zenity") > 1:
    pass
elif apps.count("zenity") > 0:
    execute('zenity --info --text "Another Zenity window is open already"')
# preventing empty windowlist
elif len(apps) > 0:
    applist = [[app, str(apps.count(app))] for app in set(apps)]
    applist.sort(key=lambda x: x[1])
    # calling zenity window
    try:
        arg = get('zenity  --list  --text "Choose an application" '+\
               '--title "Current windows" '+\
               '--column "application" '+\
               '--column "windows" '+\
               '--height 250 '+\
               '--width 250 '+\
               (" ").join(sum(applist, [])))
    except subprocess.CalledProcessError:
        pass
    # raise matching windows
    try:
        [execute("wmctrl -ia "+item[1]) \
         for item in windows if arg.startswith(item[0])]
    except (subprocess.CalledProcessError, NameError):
        pass
else:
    execute('zenity --info --text "No windows to list"')

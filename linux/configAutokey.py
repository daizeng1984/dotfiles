#!/bin/python3
import os
import sys
import json

# TODO: left, right ctrl difference https://askubuntu.com/questions/251479/how-to-bind-ctrlarrows-to-home-and-end-keys-xmodmap-does-not-work#answer-1176213

eitherTermOrNot = '''
className = window.get_active_class()
if ('Wine' in className) or ('URxvt' in className) or ('terminal' in className) :
    keyboard.send_keys('{0}')
else:
    keyboard.send_keys('{1}')
'''

runURxvt = '''
import os
os.system('gtk-launch rxvt-unicode')
'''

captureScreen = '''
import os
#os.system('"$(which shutter)" -s -e')
os.system('sleep 0.5 && "$(which gnome-screenshot)" {0}')
'''

killWindow = '''
import os
os.system('wmctrl -c :ACTIVE:')
'''

maximize = '''
import os
os.system('wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz')
'''

moveWindowLeftOrRight = '''
import os
os.system(\'\'\'
#define the height in px of the top system-bar:
TOPMARGIN=27

#sum in px of all horizontal borders:
RIGHTMARGIN=10

# get width of screen and height of screen
SCREEN_WIDTH=$(xwininfo -root | awk '$1=="Width:" {{print $2}}')
SCREEN_HEIGHT=$(xwininfo -root | awk '$1=="Height:" {{print $2}}')

# new width and height
W=$(( $SCREEN_WIDTH / 2 - $RIGHTMARGIN ))
H=$(( $SCREEN_HEIGHT - 2 * $TOPMARGIN ))

# X, change to move left or right:

# moving to the right half of the screen:
X=$(( $SCREEN_WIDTH / 2 ))
# moving to the left:
#X=0;

Y=$TOPMARGIN

wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz && wmctrl -r :ACTIVE: -e 0,{0},$Y,$W,$H
\'\'\')
'''

jsonTemplate = '''
{{
    "type": "script",
    "store": {{}},
    "usageCount": 0,
    "omitTrigger": false,
    "prompt": false,
    "description": "{name}",
    "abbreviation": {{
        "wordChars": "[\\\\w]",
        "abbreviations": [],
        "immediate": false,
        "ignoreCase": false,
        "backspace": true,
        "triggerInside": false
    }},
    "hotkey": {hotkey},
    "modes": [
        3
    ],
    "showInTrayMenu": false,
    "matchCase": false,
    "filter": {{
        "regex": null,
        "isRecursive": false
    }}
}}
'''

folderJson = '''
{
    "type": "folder",
    "title": "autokey",
    "modes": [],
    "usageCount": 0,
    "showInTrayMenu": false,
    "abbreviation": {
        "abbreviations": [],
        "backspace": true,
        "ignoreCase": false,
        "immediate": false,
        "triggerInside": false,
        "wordChars": "[\\\\w]"
    },
    "hotkey": {
        "modifiers": [],
        "hotKey": null
    },
    "filter": {
        "regex": null,
        "isRecursive": false
    }
}
'''

# assembly the script, and don't have time for elegant python cli
dest = os.environ.get('HOME') + '/.config/autokey/data/autokey'
os.system('rm -rf "' + dest + '"') #"' + dest + '.backup"')
os.system('mkdir -p "' + dest + '"')


with open(dest + '/.folder.json', 'w') as jsonfile:
    jsonfile.write(folderJson)


def makeFile(name, modifiers, hotkey, template, *variables):
    # make py script
    with open(dest + '/' + name + '.py', 'w') as pyscript:
        pyscript.write(template.format(*variables))
    # make json
    jsondumps = json.dumps(
        {
            "hotKey": hotkey,
            "modifiers": modifiers
        }
    )
    #print(jsondumps)
    with open(dest + '/.' + name + '.json', 'w') as jsonfile:
        jsonfile.write(jsonTemplate.format(hotkey=jsondumps, name=name))


# Now let's build the scripts!
makeFile('gnome-capture-area-clip', ['<ctrl>', '<shift>', '<alt>'], '4', captureScreen, ' -c -a ')
makeFile('gnome-capture-area-file', ['<shift>', '<alt>'], '4', captureScreen, ' -a ')
makeFile('maximize-window', ['<super>'], 'o', maximize)
makeFile('move-window-left', ['<super>'], ',', moveWindowLeftOrRight, '0')
makeFile('move-window-right', ['<super>'], '.', moveWindowLeftOrRight, '$X')
makeFile('kill-window', ['<alt>'], 'q', killWindow)

# I like Mac
makeFile('ctrl-n', ['<ctrl>'], 'n', eitherTermOrNot, '<ctrl>+n', '<down>')
makeFile('ctrl-p', ['<ctrl>'], 'p', eitherTermOrNot, '<ctrl>+p', '<up>')
makeFile('ctrl-a', ['<ctrl>'], 'a', eitherTermOrNot, '<ctrl>+a', '<home>')
makeFile('ctrl-e', ['<ctrl>'], 'e', eitherTermOrNot, '<ctrl>+e', '<end>')
#makeFile('ctrl-u', ['<ctrl>'], 'u', eitherTermOrNot, '<ctrl>+u', '<>')
makeFile('ctrl-w', ['<ctrl>'], 'w', eitherTermOrNot, '<ctrl>+w', '<ctrl>+<backspace>')
# basically disable these ctrl
makeFile('ctrl-l', ['<ctrl>'], 'l', eitherTermOrNot, '<ctrl>+l', '')
makeFile('ctrl-h', ['<ctrl>'], 'h', eitherTermOrNot, '<ctrl>+h', '')
makeFile('ctrl-j', ['<ctrl>'], 'j', eitherTermOrNot, '<ctrl>+j', '')
makeFile('ctrl-k', ['<ctrl>'], 'k', eitherTermOrNot, '<ctrl>+k', '')
makeFile('ctrl-o', ['<ctrl>'], 'o', eitherTermOrNot, '<ctrl>+o', '')
makeFile('ctrl-r', ['<ctrl>'], 'r', eitherTermOrNot, '<ctrl>+r', '')
makeFile('ctrl-f', ['<ctrl>'], 'f', eitherTermOrNot, '<ctrl>+f', '<right>')
makeFile('ctrl-g', ['<ctrl>'], 'g', eitherTermOrNot, '<ctrl>+g', '')
makeFile('ctrl-t', ['<ctrl>'], 't', eitherTermOrNot, '<ctrl>+t', '')
makeFile('ctrl-q', ['<ctrl>'], 'q', eitherTermOrNot, '<ctrl>+q', '')
makeFile('ctrl-z', ['<ctrl>'], 'z', eitherTermOrNot, '<ctrl>+z', '')
makeFile('ctrl-b', ['<ctrl>'], 'b', eitherTermOrNot, '<ctrl>+b', '<left>')

# copy paste so far
makeFile('ctrl-c', ['<ctrl>'], 'c', eitherTermOrNot, '<ctrl>+c', '')
makeFile('ctrl-v', ['<ctrl>'], 'v', eitherTermOrNot, '<ctrl>+v', '')
makeFile('ctrl-x', ['<ctrl>'], 'x', eitherTermOrNot, '<ctrl>+x', '')

makeFile('alt-c', ['<alt>'], 'c', eitherTermOrNot, '<ctrl>+<insert>', '<ctrl>+<insert>')
makeFile('alt-v', ['<alt>'], 'v', eitherTermOrNot, '<shift>+<insert>', '<shift>+<insert>')
#makeFile('alt-x', ['<alt>'], 'x', eitherTermOrNot, '<alt>+x', '<ctrl>+<insert>')

makeFile('alt-a', ['<alt>'], 'a', eitherTermOrNot, '<alt>+a', '<ctrl>+a')
makeFile('alt-f', ['<alt>'], 'f', eitherTermOrNot, '<alt>+f', '<ctrl>+f')
makeFile('alt-t', ['<alt>'], 't', eitherTermOrNot, '<alt>+t', '<ctrl>+t')
makeFile('shift-alt-t', ['<alt>', '<shift>'], 't', eitherTermOrNot, '', '<ctrl>+<shift>+t')

makeFile('alt-h', ['<alt>'], 'h', eitherTermOrNot, '<alt>+h', '<ctrl>+h')
makeFile('alt-j', ['<alt>'], 'j', eitherTermOrNot, '<alt>+j', '<down>')
makeFile('alt-k', ['<alt>'], 'k', eitherTermOrNot, '<alt>+k', '<up>')
makeFile('alt-l', ['<alt>'], 'l', eitherTermOrNot, '<alt>+l', '<ctrl>+l')
makeFile('shift-alt-g', ['<alt>', '<shift>'], 'g', eitherTermOrNot, '', '<ctrl>+l')

makeFile('alt-r', ['<alt>'], 'r', eitherTermOrNot, '<alt>+r', '<ctrl>+r')
makeFile('alt-z', ['<alt>'], 'z', eitherTermOrNot, '', '<ctrl>+z')
makeFile('shift-alt-z', ['<alt>', '<shift>'], 'z', eitherTermOrNot, '', '<ctrl>+y')
makeFile('shift-alt-f', ['<alt>', '<shift>'], 'f', eitherTermOrNot, '', '<ctrl>+<shift>+f')
makeFile('shift-alt-e', ['<alt>', '<shift>'], 'e', eitherTermOrNot, '', '<ctrl>+<shift>+e')

makeFile('alt-y', ['<alt>'], 'y', eitherTermOrNot, '<alt>+y', '<ctrl>+h')
makeFile('alt-w', ['<alt>'], 'w', eitherTermOrNot, '<alt>+w', '<ctrl>+w')
makeFile('alt-p', ['<alt>'], 'p', eitherTermOrNot, '<alt>+p', '<ctrl>+p')
makeFile('super-alt-i', ['<super>', '<alt>'], 'i', eitherTermOrNot, '', '<ctrl>+<shift>+i')

# makeFile('shift-alt-leftb', ['<alt>', '<shift>'], '[', eitherTermOrNot, '<ctrl>+<pageup>', '<ctrl>+<pageup>')
# makeFile('shift-alt-rightb', ['<alt>', '<shift>'], ']', eitherTermOrNot, '<ctrl>+<pagedown>', '<ctrl>+<pagedown>')
makeFile('alt-up', ['<alt>', ], '<up>', eitherTermOrNot, '<ctrl>+<home>', '<ctrl>+<home>')
makeFile('alt-down', ['<alt>', ], '<down>', eitherTermOrNot, '<ctrl>+<end>', '<ctrl>+<end>')
# makeFile('ctrl-alt-t', ['<ctrl>', '<alt>'], 't', runURxvt) too much crap env vars polution

makeFile('ctrl-[', ['<ctrl>'], '[', eitherTermOrNot, '<ctrl>+[', '<escape>')

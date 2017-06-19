import os
import subprocess
import uuid
import platform
from ranger.api.commands import *
from ranger.core.loader import CommandLoader

# Extract and Compress
class extracthere(Command):
    def execute(self):
        """ Extract copied files to current directory """
        copied_files = tuple(self.fm.copy_buffer)

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = copied_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path

        newfolder = cwd.path + '/' + os.path.splitext(os.path.basename(one_file.path))[0];
        au_flags = ['-X', newfolder]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']
        au_flags += ['-q']
        au_flags += ['-f']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(copied_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(one_file.dirname)
        self.fm.execute_console(
        'shell mkdir -p ' + newfolder + " && aunpack " + " ".join(au_flags) \
                + " " + " ".join([ "'" + f.path + "'" for f in copied_files]) + " ") 

        self.fm.reload_cwd()

class compress(Command):
    def execute(self):
        """ Compress marked files to current directory """
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()
        au_flags = parts[1:]
        au_flags += ['-q']
        au_flags += ['-f']

        descr = "compressing files in: " + os.path.basename(parts[1])
        self.fm.execute_console(
        'shell apack ' + " ".join(au_flags) + \
                " " + " ".join(['"' + os.path.relpath(f.path, cwd.path) + '"' for f in marked_files]) + " &")

        self.fm.reload_cwd()
        #obj = CommandLoader(args=['apack'] + au_flags + \
        #        [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr)

        #obj.signal_bind('after', refresh)
        #self.fm.loader.add(obj)

    def tab(self):
        """ Complete with current folder name """

        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + os.path.basename(self.fm.thisdir.path) + ext for ext in extension]

class trash(Command):
    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        parts = self.line.split()

        uuidname = uuid.uuid4();
        trashpath = "${HOME}/.Trash/" + str(uuidname);

        # Nasty but good to hear some sound coming out
        # TODO: separate to a separate command
        playsound = ""
        if 'cygwin' in platform.system().lower():
            playsound = "cat `cygpath -W`/Media/recycle.wav > /dev/dsp & "
        elif 'darwin' in platform.system().lower():
            playsound = "afplay /System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/dock/drag\ to\ trash.aif & "

        self.fm.execute_console(
        'shell mkdir -p ' + trashpath + ' && mv ' + \
                " " + " ".join(['"' + os.path.relpath(f.path, cwd.path) + '"' for f in marked_files]) + " " + trashpath + " & " + playsound)

        self.fm.reload_cwd()

    def tab(self):
        return ['trash ' + os.path.basename(self.fm.thisdir.path) ]



# For windows
class openas(Command):
    # Yes, Windows is the ugliest
    apps = { "npp" :"C:/Program Files (x86)/Notepad++/notepad++.exe",\
                "gvim" :"C:/Program Files (x86)/Vim/vim80/gvim.exe",\
                "gvimdiff" :"C:/Program Files (x86)/Vim/vim80/gvim.exe -d",\
                "gimp" :"C:/Program Files/GIMP 2/bin/gimp-2.8.exe",\
                "paint" :"C:/Windows/system32/mspaint.exe",\
                "chrome" : "C:/Users/daz2pal/AppData/Local/Google/Chrome/Application/chrome.exe"
                }

    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if 'cygwin' in platform.system().lower():

            if not marked_files:
                return

            original_path = cwd.path
            parts = self.line.split()
            if len(parts) < 1 :
                self.fm.notify("No arguments!")
            else:
                runapp = ""
                if (parts[1] in self.apps):
                    runapp = self.apps[parts[1]]
                else:
                    runapp = parts[1]
                self.fm.execute_console( "shell '" + runapp + "' " + " ".join(['"$(cygpath -wma "' + os.path.relpath(f.path, cwd.path) + '")"' for f in marked_files]) + " &>/dev/null &")

    def tab(self):
        return ['openas ' + app for app in self.apps]

# A really simple wrapper for my convenience
class ripgrep(Command):
    def execute(self):
        parts = self.line.split()

        if len(parts) < 1 :
            self.fm.notify("No arguments!")
        else:
            self.fm.execute_console( "shell rg -p " + " ".join(parts[1:]) + " | less -R ")

# import pyperclip  DOESN'T WORK! DIY now
class copyfilepath(Command):
    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        original_path = cwd.path
        parts = self.line.split()

        def cygwin_copy(path):
            self.fm.notify( "Copied file path: " + path)
            os.system("echo -n " + path  + "  > /dev/clipboard")
            return 
        def darwin_copy(path):
            self.fm.notify( "Copied file path: " + path)
            ps = subprocess.Popen(("echo", "-n", path ), stdout=subprocess.PIPE)
            subprocess.check_output(("pbcopy"), stdin=ps.stdout)
            ps.wait()
        def donothing_copy(path):
            self.fm.notify( "Cannot do anything about this path: " + path)

        # Pyperclip Doesn't support Cygwin for some reason 
        if "cygwin" in platform.system().lower():
            cygwin_copy(" ".join(["$(cygpath -wma \"" + os.path.abspath(f.path) + "\")" for f in marked_files]))
        elif "darwin" in platform.system().lower():
            darwin_copy(" ".join([os.path.abspath(f.path) for f in marked_files]))
        else:
            donothing_copy(" ".join([os.path.abspath(f.path) for f in marked_files]))

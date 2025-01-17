import os
import subprocess
import uuid
import platform
import pdb
from ranger.api.commands import *
from ranger.core.loader import CommandLoader

# TODO: these 2 guys might be able replaced by simply shell mapping in rc.conf. 
# Extract and Compress
class extracthere(Command):
    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        archieves = ['"' + os.path.relpath(f.path, cwd.path) + '"' for f in marked_files]

        descr = "extracted file(s): " + " ".join(archieves);

        self.fm.execute_console(
        'shell patool extract ' + \
                " ".join(archieves))
        self.fm.reload_cwd()
        self.fm.notify(descr)

    
    
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
        if len(parts) < 2 :
            self.fm.notify("Please input file name, e.g. my_files.zip")

        descr = "compressing files to: " + str(os.path.basename(parts[1]))
        self.fm.execute_console(
        'shell patool create ' + str(os.path.basename(parts[1])) + \
                " " + " ".join(['"' + os.path.relpath(f.path, cwd.path) + '"' for f in marked_files]) )

        self.fm.reload_cwd()
        self.fm.notify(descr)

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

        # Nasty but good to hear some sound coming out
        # TODO: separate to a separate command
        playsound = ""
        if 'cygwin' in platform.system().lower():
            playsound = "cat `cygpath -W`/Media/recycle.wav > /dev/dsp & "
        elif 'darwin' in platform.system().lower():
            playsound = "afplay /System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/dock/drag\\ to\\ trash.aif & "

        self.fm.execute_console(
        'shell trash-put ' + \
                " " + " ".join(['"' + os.path.relpath(f.path, cwd.path) + '"' for f in marked_files]) + " & " + playsound)

        self.fm.reload_cwd()

    def tab(self):
        return ['trash ' + os.path.basename(self.fm.thisdir.path) ]


# A really simple wrapper for my convenience
class ripgrep(Command):
    def execute(self):
        parts = self.line.split()

        if len(parts) < 1 :
            self.fm.notify("No arguments!")
        else:
            self.fm.execute_console( "shell rg -p " + " ".join(parts[1:]) + " | less -R ")

def os_env_name():
    system_info = platform.uname()
    # Pyperclip Doesn't support Cygwin for some reason 
    if "cygwin" in platform.system().lower():
        return 'cygwin'
    elif 'microsoft' in system_info.release.lower() or 'wsl' in system_info.version.lower():
        return 'wsl'
    elif "darwin" in platform.system().lower() or "linux" in platform.system().lower():
        return 'darwin'
    else:
        return 'linux'

class guiopen(Command):
    def execute(self):
        parts = self.line.split()

        os_name = os_env_name();
        def wsl_open(path):
            os.system("wslpath -m \"" + path + "\" | sed -e 's/\\//\\\\\\\\/g' | xargs -I {} explorer.exe '{}'");
            pass
        def darwin_open(path):
            os.system("open " + path)
        def linux_open(path):
            os.system("xdg-open " + path)

        open_cmd = None
        if os_name == 'wsl':
            open_cmd = wsl_open
        elif os_name == 'darwin':
            open_cmd = darwin_open
        elif os_name == 'cygwin':
            pass
            #TODO
        elif os_name == 'linux':
            open_cmd == linux_open


        if len(parts) < 1 :
            self.fm.notify("No arguments!")
        else:
            if open_cmd:
                open_cmd(" ".join(parts[1:]))

def linux_to_windows_path(linux_path):
    result = subprocess.run(['wslpath', '-w', linux_path], capture_output=True, text=True)
    if result.returncode == 0:
        return result.stdout.strip()
    else:
        raise Exception(f"Error translating path: {result.stderr.strip()}")

class copyfilepath(Command):
    def execute(self):
        cwd = self.fm.thisdir
        marked_files = cwd.get_selection()

        if not marked_files:
            return

        original_path = cwd.path
        parts = self.line.split()

        def cygwin_copy(marked_files):
            path = " ".join(["$(cygpath -wma \"" + os.path.abspath(f.path) + "\")" for f in marked_files])
            self.fm.notify( "Copied file path: " + path)
            os.system("echo -n " + path  + "  > /dev/clipboard")
        def nix_copy(marked_files):
            path = " ".join([os.path.abspath(f.path) for f in marked_files])
            self.fm.notify( "Copied file path: " + path)
            os.system("echo \"" + path + "\" | pbcopy ")
        def wsl_copy(marked_files):
            path = " ".join([linux_to_windows_path(os.path.abspath(f.path)) for f in marked_files])
            self.fm.notify( "Copied file path: " + path)
            subprocess.run("clip.exe", input=path, text=True)
        def donothing_copy(marked_files):
            path = " ".join([os.path.abspath(f.path) for f in marked_files])
            self.fm.notify( "Cannot do anything about this path: " + path)

        system_info = platform.uname()
        # Check if the system is WSL
        is_wsl = 'microsoft' in system_info.release.lower() or 'wsl' in system_info.version.lower()

        if "cygwin" in platform.system().lower():
            cygwin_copy(marked_files)
        elif is_wsl:
            wsl_copy(marked_files)
        elif "darwin" in platform.system().lower() or "linux" in platform.system().lower():
            nix_copy(marked_files)
        else:
            donothing_copy(marked_files)

# Modified from https://lists.nongnu.org/archive/html/ranger-users/2010-09/msg00003.html
class bulkrename(Command):
  """
  :bulkrename

  This command opens a list of selected files in an external editor.
  After you edit and save the file, it will generate a shell script
  which does bulk renaming according to the changes you did in the file.

  This shell script is opened in an editor for you to review.
  After you close it, it will be executed.
  """
  def execute(self):
    import tempfile
    from ranger.ext.shell_escape import shell_escape as esc

    # Create and edit the file list
    cwd = self.fm.thisdir
    
    filenames = [f.basename for f in cwd.get_selection()]
    listfile = tempfile.NamedTemporaryFile()
    listfile.write("\n".join(filenames))
    listfile.flush()
    listfile_name = listfile.name
    self.fm.run(['nvim', listfile_name])
    # Interestingly, nvim is using backupcopy way to write file and we need a fresh read for the tempfile
    # see https://stackoverflow.com/questions/22976454/vim-cannot-save-to-temporary-files-created-by-python
    new_filenames = open(listfile_name).read().split("\n")
    listfile.close()
    
    if all(a == b for a, b in zip(filenames, new_filenames)):
      self.fm.notify("No renaming to be done!")
      return

    # Generate and execute script
    cmdfile = tempfile.NamedTemporaryFile()
    cmdfile.write("# This file will be executed when you close the editor.\n")
    cmdfile.write("# Please double-check everything, clear the file to abort.\n")
    cmdfile.write("\n".join("mv -vi " + esc(old) + " " + esc(new) \
        for old, new in zip(filenames, new_filenames) if old != new))
    cmdfile.flush()
    self.fm.run(['nvim', cmdfile.name])
    cmdfile_name = cmdfile.name
    self.fm.run(['/bin/sh', cmdfile_name], flags='w')
    cmdfile.close()


# https://github.com/ranger/ranger/wiki/Commands#visit-frequently-used-directories
# Slightly adjust its flavor
class z(Command):
    """
    :z

    Jump to directory using fzf and fasd
    """
    def execute(self):
        arg = self.rest(1)
        command = 'zoxide query -l | fzf -1 -0 --no-sort +m'
        #command = 'fasd -Rdl \'' + arg + '\' | fzf -1 -0 --no-sort +m'
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)


class fzf_select(Command):
    """
    :fzf_select

    Find a file using fzf.

    With a prefix argument select only directories.

    See: https://github.com/junegunn/fzf
    """
    def execute(self):
        import os.path
        if self.quantifier:
            # match only directories
            command="find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
            -o -type d -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        else:
            # match files and directories
            command="find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
            -o -print 2> /dev/null | sed 1d | cut -b3- | fzf +m"
        fzf = self.fm.execute_command(command, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.decode('utf-8').rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

# https://github.com/ranger/ranger/wiki/Integration-with-other-programs#fasd
import ranger.api
import os

old_hook_init = ranger.api.hook_init

def hook_init(fm):
    def database_add():
        # fm.execute_console("shell fasd --add '" + fm.thisfile.path + "'")
        fm.execute_console("shell zoxide add '" + os.path.dirname(fm.thisfile.path) + "'")
    fm.signal_bind('execute.before', database_add)
    return old_hook_init(fm)

ranger.api.hook_init = hook_init

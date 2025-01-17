; credit https://gist.github.com/ascendbruce/677c3169259c975259045f905cd889d6?permalink_comment_id=3762847#file-mac-ahk

; REMOVED: #NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
InstallMouseHook()
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode("Input")  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir(A_ScriptDir)  ; Ensures a consistent starting directory.

; Docs:
; https://autohotkey.com/docs/Hotkeys.htm
; https://autohotkey.com/docs/KeyList.htm
; Ref https://autohotkey.com/board/topic/60675-osx-style-command-keys-in-windows/

; You need to disable "Between input languages" shotcut from Control Panel\Clock, Language, and Region\Language\Advanced settings > Change lanugage bar hot keys

; Universal shotcuts

$!x::Send("^x")
$!c::
{ ; V1toV2: Added bracket
if WinActive("ahk_exe alacritty.exe")
    Send("!c")
else if WinActive("ahk_exe wsl.exe")
    Send("!c")
else
    Send("^c")
Return
} ; V1toV2: Added Bracket before hotkey or Hotstring
$!v::
{ ; V1toV2: Added bracket
if WinActive("ahk_exe alacritty.exe")

    Send("!v")
else if WinActive("ahk_exe wsl.exe")
    Send("!v")
else
    Send("^v")
Return
} ; V1toV2: Added Bracket before hotkey or Hotstring

$!BS::
{ ; V1toV2: Added bracket
if WinActive("ahk_exe explorer.exe")
    Send("^d")
else
    Send("{LShift down}{Home}{LShift Up}{Del}")
return

} ; V1toV2: Added Bracket before hotkey or Hotstring

$^d::
{ ; V1toV2: Added bracket
if WinActive("ahk_exe explorer.exe")
    Send("{PageDown}")
else
    Send("^d")
Return
} ; V1toV2: Added Bracket before hotkey or Hotstring


$!s::Send("^s")
$!a::Send("^a")
$!z::Send("^z")
$!+z::Send("^y")
$!w::Send("^w")

$!f::Send("^f")
$!n::Send("^n")

$!q::Send("!{f4}")
$!r::Send("^r")
$!m::Send("{LWin Down}{Down}{LWin Up}")


; mouse
$!LButton::Send("{Ctrl Down}{LButton Down}{LButton Up}{Ctrl Up}")
$^LButton::RButton

RButton::LButton

; Quick Switch Tab shotcuts


$!1::Send("^1")
$!2::Send("^2")

$!3::Send("^3")
$!4::Send("^4")

$!5::Send("^5")
$!6::Send("^6")

$!7::Send("^7")
$!8::Send("^8")

$!9::Send("^9")
$!0::Send("^0")


; Chrome shotcuts


$!t::Send("^t")
$!+t::Send("^+t")
$!+]::Send("{Ctrl Down}{Tab Down}{Tab Up}{Ctrl Up}")

$!+[::Send("{Ctrl Down}{Shift Down}{Tab Down}{Tab Up}{Shift Up}{Ctrl Up}")
$!l::Send("^l")

; input methods


; $+,::Send ^,
; $+.::Send ^.

; navigation, selection, delete a word/till end

$^a::
{
if (WinActive("ahk_exe alacritty.exe") || WinActive("ahk_exe wsl.exe"))
    Send("^a")  ;for alacritty.exe or wsl.exe
else
    Send("{Home}")
Return
}
$^e::
{
if (WinActive("ahk_exe alacritty.exe") || WinActive("ahk_exe wsl.exe"))
    Send("^e")  ;for alacritty.exe or wsl.exe
else
    Send("{End}")
Return
}
$^[::
{
if (WinActive("ahk_exe alacritty.exe") || WinActive("ahk_exe wsl.exe"))
    Send("^[")  ;for alacritty.exe or wsl.exe
else
    Send("{Escape}")
Return
}


$!Left::Send("{Home}")
$!Right::Send("{End}")
$!Up::Send("{Lctrl down}{Home}{Lctrl up}")
$!Down::Send("{Lctrl down}{End}{Lctrl up}")


$!+Left::Send("{shift down}{Home}{shift up}")
$!+Right::Send("{shift down}{End}{shift up}")
$!+Up::Send("{Ctrl Down}{shift down}{Home}{shift up}{Ctrl Up}")
$!+Down::Send("{Ctrl Down}{shift down}{End}{shift up}{Ctrl Up}")


$#Left::Send("{ctrl down}{Left}{ctrl up}")
$#Right::Send("{ctrl down}{Right}{ctrl up}")
$#+Left::Send("{ctrl down}{shift down}{Left}{shift up}{ctrl up}")

$#+Right::Send("{ctrl down}{shift down}{Right}{shift up}{ctrl up}")

$#BS::Send("{LCtrl down}{BS}{LCtrl up}")

$#Space::Send("{Ctrl Down}{LWin Down}{Space}{LWin Up}{Ctrl Up}")

; hjkl
AppsKey::return

AppsKey & h::Send("{Left}")
AppsKey & j::Send("{Down}")
AppsKey & k::Send("{Up}")
AppsKey & l::Send("{Right}")
RALT::return

RALT & h::Send("{Left}")
RALT & j::Send("{Down}")
RALT & k::Send("{Up}")
RALT & l::Send("{Right}")

; windows
$#o::WinMaximize("A")
$#,::Send("{LWin Down}{Left}{LWin Up}")
$#.::Send("{LWin Down}{Right}{LWin Up}")



$!`:: ; Next window
{ ; V1toV2: Added bracket
ActiveClass := WinGetClass("A")
WinClassCount := WinGetCount("ahk_class " ActiveClass)

if (WinClassCount = 1)
    Return
Else
oList := WinGetList("ahk_class " ActiveClass,,,)
aList := Array()
List := oList.Length
For v in oList
{   aList.Push(v)
}
Loop aList.Length
{
    index := aList.Length - A_Index + 1
    State := WinGetMinMax("ahk_id " aList[index])
    if (State != -1)
    {

        WinID := aList[index]
        break
    }
}
WinActivate("ahk_id " WinID)
return
} ; V1toV2: Added Bracket before hotkey or Hotstring

$!^`:: ; Last window
{ ; V1toV2: Added bracket
ActiveClass := WinGetClass("A")
WinClassCount := WinGetCount("ahk_class " ActiveClass)

if (WinClassCount = 1)
    Return
Else
oList := WinGetList("ahk_class " ActiveClass,,,)
aList := Array()
List := oList.Length
For v in oList
{   aList.Push(v)
}
Loop aList.Length
{
    index := aList.Length - A_Index + 1
    State := WinGetMinMax("ahk_id " aList[index])
    if (State != -1)
    {

        WinID := aList[index]
        break
    }
}
WinActivate("ahk_id " WinID)
return


; suppress capslock at any cost!
} ; V1toV2: Added Bracket before hotkey or Hotstring
CapsLock::      ; CapsLock
+CapsLock::   ; Shift+CapsLock
!CapsLock::   ; Alt+CapsLock
^CapsLock::      ; Ctrl+CapsLock
#CapsLock::      ; Win+CapsLock
^!CapsLock::   ; Ctrl+Alt+CapsLock
^!#CapsLock::   ; Ctrl+Alt+Win+CapsLock

{ ; V1toV2: Added bracket
return         ; Do nothing, return

} ; V1toV2: Added Bracket before hotkey or Hotstring

$^!q:: DllCall("LockWorkStation")
; suppress win
LAlt & Space::Send("{Alt Down}{Space}{Alt Up}")
LAlt::Return

LWin::LAlt
LWin & Left::Send("^{Left}")
LWin & Right::Send("^{Right}")
LWin & Backspace::Send("^{Backspace}")

; tools
$^!$::
{ ; V1toV2: Added bracket
Run("explorer.exe ms-screenclip:")
return

;#IfWinActive ahk_exe WindowsTerminal.exe ahk_class CASCADIA_HOSTING_WINDOW_CLASS
;$^b::waitforkey := true
;
;#If waitforkey
;$-::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{- Down}{- Up}{Alt Up}{Ctrl Up}
;return
;$|::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{\ Down}{\ Up}{Alt Up}{Ctrl Up}
;return
;$h::
;    waitforkey := false

;    Send {Ctrl Down}{Alt Down}{Left Down}{Left Up}{Alt Up}{Ctrl Up}

;return
;$l::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{Right Down}{Right Up}{Alt Up}{Ctrl Up}
;return
;$j::

;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{Down Down}{Down Up}{Alt Up}{Ctrl Up}
;return
;$k::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{Up Down}{Up Up}{Alt Up}{Ctrl Up}
;return
;$1::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{1 Down}{1 Up}{Alt Up}{Ctrl Up}
;return
;$2::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{2 Down}{2 Up}{Alt Up}{Ctrl Up}
;return
;$3::

;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{3 Down}{3 Up}{Alt Up}{Ctrl Up}
;return
;$4::
;    waitforkey := false
;    Send {Ctrl Down}{Alt Down}{4 Down}{4 Up}{Alt Up}{Ctrl Up}
;return
;$c::
;    waitforkey := false
;    Send {Ctrl Down}{Shift Down}{t Down}{t Up}{Shift Up}{Ctrl Up}
;return
;$p::
;    waitforkey := false
;    Send {Ctrl Down}{Shift Down}{Tab Down}{Tab Up}{Shift Up}{Ctrl Up}
;return
;$n::
;    waitforkey := false
;    Send {Ctrl Down}{Tab Down}{Tab Up}{Ctrl Up}
;return
;

;#If

} ; V1toV2: Added bracket in the end

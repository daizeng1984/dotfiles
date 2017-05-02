; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.


;^#Up::Send {LWin & Up}
;*^{Space} Up::Send {LWin Up}

!q::Send !{f4}

;!a::Send ^{a}
!w::Send ^{w}
^l::Send !{d}
!s::Send ^{s}
!z::Send ^{z}
;!c::Send ^{c}
!t::Send ^{t}
;!f::Send ^{f}
;!x::Send ^{x}
;!v::Send ^{v}
;^!]::
;run 
;return

;^!n::
;IfWinExist Untitled - Notepad
;	WinActivate
;else
;	Run Notepad
;return

; These command are there because of Win's right-click freeze
GetExplorerFolder() {
Send !d
ClipSaved := ClipboardAll
Send ^c
ClipWait
epath := Clipboard
Clipboard := ClipSaved
ClipSaved =
;msgbox, 262208,ActiveFolder ,%epath%
return epath
}

GetExplorerFilePath() {
ClipSaved := ClipboardAll
Send ^c
ClipWait
FullPath := Clipboard
Clipboard := ClipSaved
ClipSaved =
return FullPath
}

^!$::
run, "%windir%\system32\SnippingTool.exe"
return

^!o::
FullPath := GetExplorerFilePath()
run, "%FullPath%"
return

^!n::
FullPath := GetExplorerFilePath()
run, notepad++.exe "%FullPath%"
return

^!g::
FullPath := GetExplorerFilePath()
run, "C:/Program Files (x86)/Vim/vim80/gvim.exe" "%FullPath%"
return

^!t::
run, "D:/Programs/ConEmu/ConEmu64.exe" -loadcfgfile "%HOME%/.dotfiles/windows/ConEmu.xml"
return

^!p::
epath := GetExplorerFilePath()
Run, properties "%epath%"
return

^!z::
;TODO 7zip
return

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
!`:: ; Next window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return

!^`:: ; Last window
WinGetClass, ActiveClass, A
WinGet, WinClassCount, Count, ahk_class %ActiveClass%
IF WinClassCount = 1
    Return
Else
WinGet, List, List, % "ahk_class " ActiveClass
Loop, % List
{
    index := List - A_Index + 1
    WinGet, State, MinMax, % "ahk_id " List%index%
    if (State <> -1)
    {
        WinID := List%index%
        break
    }
}
WinActivate, % "ahk_id " WinID
return

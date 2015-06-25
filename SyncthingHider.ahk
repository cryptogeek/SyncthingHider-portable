#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance ignore

FileCreateDir, config

Run, syncthing.exe -no-browser -home %A_ScriptDir%/config
WinWait, ahk_exe syncthing.exe
WinHide

OnExit, ExitSub

OnMessage(0x404, "AHK_NOTIFYICON")
 
AHK_NOTIFYICON(wParam, lParam)
{
    if (lParam = 0x202) ; WM_LBUTTONUP
	{
		run, http://127.0.0.1:8080/
	}
}

return

ExitSub:
Process, Close, syncthing.exe
Process, Close, syncthing.exe
Process, Close, syncthing.exe
ExitApp
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance ignore

Menu, Tray, add, Show console, console

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

DetectHiddenWindows, On
Loop
{
	IfWinNotExist, ahk_exe syncthing.exe
	{
		ExitApp
	}
	
	WinGet, winState, MinMax, ahk_exe syncthing.exe
	if (winState = -1) {
		WinHide, ahk_exe syncthing.exe
	}
   
	sleep 100
}

console:
WinShow, ahk_exe syncthing.exe
WinRestore, ahk_exe syncthing.exe
return

ExitSub:
WinShow, ahk_exe syncthing.exe
WinClose, ahk_exe syncthing.exe
ExitApp
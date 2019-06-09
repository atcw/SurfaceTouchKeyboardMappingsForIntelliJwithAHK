; SurfaceTouchKeyboardMappingsForIntelliJAHK
;
; Useful for IntelliJ on Notebooks (Especially Surface Pro 4/5)
; Remaps the AppsKey (aka RightClick-Key or Menu-Key) to 3 different Functions
; Long-Press: "Control-Key" because there no control-key on the right side
; Single-Press: Normal AppKey-Functions
; Double-Press: IntelliJ Comment Out Code which normally needs the NumpadDiv. 
;				(Todo: Combine with Shift at your leisure.)
; Press CapsLock: 
;				Peek through the current window which becomes transparent and you can even click through
; Known Bugs: CTRL-State hangs after Appskey, if a window is opened via the app-menu.

; Thanks to https://autohotkey.com/boards/viewtopic.php?t=8267
; 
; ©2019 Thorben Weber

;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <https://www.gnu.org/licenses/>.



SetCapsLockState, AlwaysOff


$AppsKey::
	KeyWait, AppsKey, T0.1
	
	if (ErrorLevel) ;;; long press
		Send {Control down} 

	else {
		KeyWait, AppsKey, D T0.1

		if (ErrorLevel) ;;; Single press
			Send {AppsKey} 
		
		else ;;; Double press
		; For directly Sending {^NumpadDiv} to work in IntelliJ
		; AHK would need to be run in Admin-Mode 
			Send {Control down}
			Send {NumpadDiv}
			Send {Control up}
		
	}
	
	KeyWait, AppsKey
	
return


$+AppsKey::
		Send {Shift down}
		Send {Control down}
		Send {NumpadDiv}
		Send {Control up}		 
		Send {Shift up}
return




CapsLock::
	WinGet, currentWindow, ID, A
	WinSet, ExStyle, +0x80020, ahk_id %currentWindow% ; Mouse-Click-TRANSPARENCY on
	WinSet, Transparent, 30, ahk_id %currentWindow% ; SET TRANSPARENCY BETWEEN 0-255
	KeyWait ,CapsLock , U, P   ;Wait until CapsLock be physically released
	WinSet, Transparent, 255, ahk_id %currentWindow% ; SET TRANSPARENCY OFF
	WinSet, ExStyle, -0x20, ahk_id %currentWindow% ; Mouse-Click-TRANSPARENCY off
return

#InstallKeybdHook
;KeyHistory ; Display the history info in a window.

; # SurfaceTouchKeyboardMappingsForIntelliJwithAHK  
;   
; Needs https://www.autohotkey.com/ to run.
;  
; Useful for IntelliJ on Windows-Notebooks (Especially Surface Pro 4/5)  
; especiallly if you don't have a right Control-Key but do have an App-Key.  
;  
; Remaps the AppsKey aka RightClick-Key or Menu-Key that looks like the Hamburger  
; Menu Button found on Websites [☰] to 3 different Functions:  
;  
; ## Long-Press: 
;  * "Control-Key" 
; ## Single-Press: 
;  * Normal AppKey-Functions  
; ## Double-Press: 
;  * IntelliJ Comment Out Code with Line-Comment which normally needs the NumpadDiv.  
; 	(Todo: Combine with Shift for Block-Comment)  
; ## Hold CapsLock:  
;  * Peek through the current window which becomes transparent and you can even click through  
;  
; # Known Bugs: 
; Double-Press sends unintended keydown.
; Shift + Appkey-Doublepress only works with rshift.
;  
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

global shiftdown := false

$+AppsKey::
$AppsKey::
	
	KeyWait, AppsKey, T0.1
	
	if (ErrorLevel){ ;;; long press
		;Function1
		Send {Control down} 
		
	}
	else {
		KeyWait, AppsKey, D T0.1

		if (ErrorLevel){ ;;; Single press
			;Function2
			Send {AppsKey}
			
		}
		else { ;;; Double press
			;Function 3
			global shiftdown
			if (!shiftdown) {
				Send {Control down}
				Send {NumpadDiv}
				Send {Control up}
				; NB: For directly Sending {^NumpadDiv} to work in 
				; IntelliJ Autohotkey would need to be run in Admin-Mode
				}
			else {
				Send {shift down}
				Send {Control down}
				Send {NumpadDiv}
				Send {Control up}		 
				Send {shift up}
			}
		}
	}
	
	KeyWait, AppsKey ; release
	Send {Control up} ;cleanup
	
return

; Getkeystate("shift","P") did not work for me (probably due to threading)
~shift::
	global shiftdown
	shiftdown := true
return
~shift up::
	global shiftdown
	shiftdown := false
return

	
	
; Peek hrough Window function
SetCapsLockState, AlwaysOff
CapsLock::
	WinGet, currentWindow, ID, A
	WinSet, ExStyle, +0x80020, ahk_id %currentWindow% ; Mouse-Click-TRANSPARENCY on
	WinSet, Transparent, 30, ahk_id %currentWindow% ; SET TRANSPARENCY BETWEEN 0-255
	KeyWait ,CapsLock , U, P   ;Wait until CapsLock is physically released
	WinSet, Transparent, 255, ahk_id %currentWindow% ; SET TRANSPARENCY OFF
	WinSet, ExStyle, -0x20, ahk_id %currentWindow% ; Mouse-Click-TRANSPARENCY off
return

#InstallKeybdHook
;KeyHistory ; Display the history info in a window.

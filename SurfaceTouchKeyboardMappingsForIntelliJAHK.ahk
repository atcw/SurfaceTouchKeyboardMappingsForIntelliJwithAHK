; IntelliJ on Notebooks (Especially Surface Pro 4/5)
; Remaps AppsKey (aka RightClick-Key) to 3 different Functions
; Long-Press: Control as there might not be a control on the right side
; Single-Press: Normal AppKey-Functions
; Double-Press: IntelliJ CommentOut which needs the NumpadDiv. 
;				(Todo: Combine with Shift at your leisure.)
; Press CapsLock: 

; Bug: CTRL-State hängt nach Appskey, wenn darüber (rechtsklickmenü) fenster geöffnet wird.

; Thanks to https://autohotkey.com/boards/viewtopic.php?t=8267

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
		
		; For Send {^NumpadDiv} to work in IntelliJ
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

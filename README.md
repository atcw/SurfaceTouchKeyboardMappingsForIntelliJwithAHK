# SurfaceTouchKeyboardMappingsForIntelliJwithAHK

; Needs https://www.autohotkey.com/ to run
;
; Useful for IntelliJ on Windows-Notebooks (Especially Surface Pro 4/5)
; that don't have a right Control-Key but do have an AppsKey.
;
; Remaps the AppsKey aka RightClick-Key or Menu-Key that looks like the Hamburger
; Menu Button found on Websites [☰] to 3 different Functions:
;
; Long-Press: "Control-Key" because there no control-key on the right side
; Single-Press: Normal AppKey-Functions
; Double-Press: IntelliJ Comment Out Code which normally needs the NumpadDiv. 
;				(Todo: Combine with Shift at your leisure.)
; Press CapsLock: 
;				Peek through the current window which becomes transparent and you can even click through
;
; Known Bugs: CTRL-State hangs after Appskey, if a window is opened via the app-menu.

; Thanks to https://autohotkey.com/boards/viewtopic.php?t=8267

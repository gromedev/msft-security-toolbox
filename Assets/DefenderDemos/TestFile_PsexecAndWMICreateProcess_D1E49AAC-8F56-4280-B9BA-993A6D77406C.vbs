on error resume next

set process = GetObject("winmgmts:Win32_Process")

WScript.Echo "Executing notepad"

result = process.Create ("notepad.exe",null,null,processid)

WScript.Echo "Method returned result = " & result
WScript.Echo "Id of new process is " & processid
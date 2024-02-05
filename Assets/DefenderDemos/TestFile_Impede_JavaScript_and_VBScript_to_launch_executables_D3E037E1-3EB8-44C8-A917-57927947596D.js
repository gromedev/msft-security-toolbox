// SCPT:xmlHttpRequest
var xmlHttp = WScript.CreateObject("MSXML2.XMLHTTP");
xmlHttp.open("GET", "https://www.bing.com", false);
xmlHttp.send();

// SCPT:JSRunsFile
var shell = WScript.CreateObject("WScript.Shell");
shell.Run("notepad.exe");
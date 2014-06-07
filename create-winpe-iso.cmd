REM -*- bat -*-
@Echo on

rem http://goo.gl/keTHVZ
rem http://goo.gl/87GvwX
rem http://goo.gl/gZdPBl
rem http://www.certforums.com/forums/windows-vista-7-8-client-exams/39897-help-dism-windows-7-a.html

cd c:\
rmdir /q /s C:\WinPE_x86
rmdir /q /s C:\WinPE_x86

cd "c:\Program Files\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment"
cmd /c copype.cmd x86 C:\WinPE_x86
cmd /c MakeWinPEMedia.cmd /ISO C:\WinPE_x86 C:\WinPE_x86\WinPE_x86.iso

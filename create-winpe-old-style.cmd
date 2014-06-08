REM -*- bat -*-
@Echo on

rem http://goo.gl/keTHVZ
rem http://goo.gl/87GvwX
rem http://goo.gl/gZdPBl
rem http://www.certforums.com/forums/windows-vista-7-8-client-exams/39897-help-dism-windows-7-a.html

cd c:\
rmdir /q /s c:\winpe_x86
rmdir /q /s c:\winpe_x86
cmd /c copype.cmd x86 c:\winpe_x86
rem copy /y "C:\Program Files\Windows Embedded Standard 7\Tools\IBW\AMD64\sources\boot.wim" c:\winpe_x86\winpe.wim
copy /y "C:\Program Files\Windows Embedded Standard 7\Tools\IBW\x86\sources\boot.wim" c:\winpe_x86\winpe.wim
copy c:\winpe_x86\winpe.wim c:\winpe_x86\ISO\sources\boot.wim
imagex /mountrw c:\winpe_x86\winpe.wim 1 c:\winpe_x86\mount
rem Dism /Mount-Wim /WimFile:c:\winpe_x86\ISO\sources\boot.wim /index:1 /MountDir:c:\winpe_x86\mount

copy /y c:\winpe_x86\ISO\bootmgr c:\winpe_x86\mount
mkdir c:\winpe_x86\mount\boot
xcopy /cherky C:\winpe_x86\ISO\boot C:\winpe_x86\mount\boot
copy "c:\Program Files\Windows Embedded Standard 7\Tools\x86\imagex.exe" C:\winpe_x86\mount

Del c:\winpe_x86\mount\boot\BCD
Bcdedit /createstore c:\winpe_x86\mount\boot\BCD
Bcdedit /store c:\winpe_x86\mount\boot\BCD -create {bootmgr} /d "Boot Manager"
Bcdedit /store c:\winpe_x86\mount\boot\BCD -set {bootmgr} device boot
Bcdedit /store c:\winpe_x86\mount\boot\BCD -create /d "WINPE" -application osloader | tee guid_tmp.txt

sed -ne 's,The entry \(.*\) was successfully created.,set guid=\1 >sg.cmd,p' guid_tmp.txt

call sg.cmd

Bcdedit /store c:\winpe_x86\mount\boot\BCD -set %guid% osdevice boot
Bcdedit /store c:\winpe_x86\mount\boot\BCD -set %guid% device boot
Bcdedit /store c:\winpe_x86\mount\boot\BCD -set %guid% path \windows\system32\winload.exe
Bcdedit /store c:\winpe_x86\mount\boot\BCD -set %guid% systemroot \windows
Bcdedit /store c:\winpe_x86\mount\boot\BCD -set %guid% winpe yes
Bcdedit /store c:\winpe_x86\mount\boot\BCD -displayorder %guid% -addlast

rem Dism /Unmount-Wim /MountDir:C:\winpe_x86\mount /Commit

Oscdimg -n -m -o -bC:\winpe_x86\Etfsboot.com C:\winpe_x86\ISO C:\winpe_x86\winpex86.iso

rem robocopy C:\winpe_x86 h:\MDTDSTestTmp winpex86.iso

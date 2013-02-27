set local
set cURRENTPATH=%~dp0%
echo %CURRENTPATH%
echo %USERPROFILE%
whoami

mkdir "C:\mylogs"
icacls "C:\mylogs" /inheritance:r /grant Administrators:(OI)(CI)F System:(OI)(CI)F

mkdir "%USERPROFILE%\AppData\Local\Microsoft\Web Platform Installer"
icacls "%USERPROFILE%\AppData\Local\Microsoft\Web Platform Installer" /inheritance:r /grant Administrators:(OI)(CI)F System:(OI)(CI)F
icalcs %TEMP% /inheritance:r /grant Administrators:(OI)(CI)F System:(OI)(CI)F

REM %CURRENTPATH%\webpicmd /install /products:ARRv2_5 /acceptEULA /log:C:\mylogs\webpicmd.log

ARRv2_setup_amd64_en-us.exe /q

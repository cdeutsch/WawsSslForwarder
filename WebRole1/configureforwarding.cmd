
REM don't recycle and dont restart app
%windir%\system32\inetsrv\appcmd.exe set config -section:applicationPools -applicationPoolDefaults.processModel.idleTimeout:00:00:00 /commit:apphost
%WINDIR%\SYSTEM32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools -applicationPoolDefaults.recycling.periodicRestart.time:00:00:00 /commit:apphost


REM   Enable the web proxy feature
REM   ----------------------------
%WINDIR%\SYSTEm32\inetsrv\appcmd.exe set config  -section:system.webServer/proxy /enabled:"True" /reverseRewriteHostInResponseHeaders:"False"  /commit:apphost



@echo off
rem Script idea based on discussons from:  http://superuser.com/questions/821032/svchost-exe-high-memory-usage-wuauserv
cls

if [%1]==[/q] goto skipwarning
goto warning

:warning
echo.
echo This script must be run as administrator for it to work as expected.
pause
:skipwarning

echo stopping wuauserv
net stop wuauserv
 
echo.
echo stopping background intelligent transfer service
net stop bits
 
echo.
echo removing %windir%\softwaredistribution
rd /s /q %windir%\softwaredistribution
 
echo.
echo Starting BITS and WUAUSERV
net start bits
net start wuauserv
 
echo.
echo Tell WUAUSERV to detect new updates
wuauclt.exe /detectnow

if NOT [%1]==[/q] pause
:endoffile

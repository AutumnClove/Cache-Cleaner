@echo off
mode 100
color 0a
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
echo This program will clean out your computers temporary files, and get rid of junk on your hard drive, helping slightly with performance.
pause 
cls
echo This might take awhile
pause 
cls
del /s /f /q %temp%
rd /s /q %temp%
del /s /f /q C:\TEMP
del /s /f /q c:\WINDOWS\temp
rd /s /q c:\WINDOWS\temp
del /s /f /q C:\WINDOWS\Prefetch
rd /s /q C:\WINDOWS\Prefetch
del /s /f /q %temp%
rd /s /q %temp%
del /f /s /q %temp%
rd /s /q %temp% 
echo Done cleaning out your files now moving onto your dns, don't worry nothing important will be lost.
pause
cls
ipconfig /release *
ipconfig /renew *
ipconfig /flushdns
echo Done with everything
pause
cls
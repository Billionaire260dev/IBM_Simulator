REM This is an old retro IBM pcs recreation.
REM Feel free to edit or pull this project!


@echo off
title IBM Personal Computer (Model 2025)
setlocal enabledelayedexpansion
color 0A

REM Boot Sequence
call :boot

REM Main Loop
:menu
cls

:: Live date & time
set displayDate=%date%
set displayTime=%time:~0,5%

echo ===============================
echo   IBM Personal Computer DOS
echo ===============================
echo Version 1.2.2
echo.
echo Date: %displayDate%
echo Time: %displayTime%
echo.
echo Installed applications:
echo CHAT
echo IBMPAD
echo CALCULATOR
echo ABOUT (i)
echo.
echo Note: type 'about' for info and commands
set /p "command=C:\> "

:: ===== COMMAND HANDLER =====
if /i "%command%"=="help" call :help
if /i "%command%"=="about" call :info
if /i "%command%"=="exit" exit

if /i "%command%"=="open_chat" call :chat
if /i "%command%"=="open_ibmpad" call :ibmpad
if /i "%command%"=="open_calculator" call :calc

if /i "%command%"=="cls" goto menu

echo.
echo Invalid command. Type HELP
pause
goto menu


:: ===== BOOT FUNCTION =====
:boot
cls
echo 64 GB OK _
timeout /t 1 >nul
cls
echo Starting MS-DOS25... _
timeout /t 1 >nul
cls
echo Loading system...
timeout /t 1 >nul
goto :eof


:: ===== HELP =====
:help
echo.
echo Commands:
echo HELP
echo ABOUT
echo EXIT
echo OPEN_CHAT
echo OPEN_IBMPAD
echo OPEN_CALCULATOR
pause
goto menu


:: ===== INFO =====
:info
cls
echo ===== SYSTEM INFO =====
echo RAM: 64 GB DDR5
echo CPU: IBM Quantum-X
echo Storage: 1 TB SSD Gen-4
echo OS: MS-DOS25
echo.
echo  ===== OS INFO =====
echo Version: 1.2.1
echo Release Date: 12/04/26
echo Coded in: Batch
echo.
echo   ===== TIPS =====
echo - Please read this section before using this computer.
echo - Enter the command 'Help' in the command line for more commands
echo - Restart the OS if any unexpected error occurs
echo - Do not try to enter invalid characters or very long sequence of characters, it may crash
echo - Any other bugs would be fixed in upcoming versions.
echo - Thank you for using our OS
echo.
pause
goto menu


:: ===== REAL CHAT APP =====
:chat
cls
echo Launching Chat...
timeout /t 1 >nul

if exist "%~dp0Chat\Chat.bat" (
    start "" /D "%~dp0Chat" "%~dp0Chat\Chat.bat"
) else (
    echo ERROR: Chat.bat not found!
    pause
)

goto menu


:: ===== TEXT EDITOR =====
:ibmpad
cls
echo IBM PAD v1.0
echo Type something below:
set /p note=
echo Saved: "!note!"
pause
goto menu


:: ===== CALCULATOR =====
:calc
cls
echo Calculator
set /p expr=Enter math expression:

if "%expr%"=="" (
    echo No input given!
    pause
    goto menu
)

set "result="
set /a result=%expr% 2>nul

if not defined result (
    echo Invalid expression!
) else (
    echo Result = %result%
)

pause
goto menu
@echo off
setlocal enabledelayedexpansion
title CMD Chat

:: Initialization
set ChatFile=%~dp0chat-history.txt
:: Ask for the username on the first run
:inputname
cls
echo ========================================
echo Welcome to The Chat !
echo ========================================
echo.
set /p UserName=Enter your name: 
if "!UserName!"=="" (
    echo Name cannot be empty. Please try again.
    pause>nul
    goto inputname
)


:: Main menu
:mainmenu
cls
echo ========================================
echo The Chat
echo Your Name: %UserName%
echo ========================================
echo [1] Send Messages
echo [2] View Messages
echo [3] Change Name
echo [4] Clear Chat log
echo [5] Change Theme
echo [6] Exit
echo ========================================
set /p choice=Please select a menu: 

if "%choice%"=="2" goto viewmessages
if "%choice%"=="1" goto sendmessage
if "%choice%"=="3" goto changename
if "%choice%"=="6" goto leavemenu
if "%choice%"=="4" goto clearchat
if "%choice%"=="5" goto changetheme

goto mainmenu

:: Menu to view messages
:viewmessages
cls
echo ========================================
echo Chat Log:
type "%ChatFile%" 2>nul
echo ========================================
pause
goto mainmenu

:: Menu to send messages
:sendmessage
cls
echo ========================================
echo Type your message (Type "cancel" to return to the main menu):
set /p Message=[%UserName%]: 
if /i "!Message!"=="cancel" goto mainmenu
(echo [%UserName%]: !Message!) >> "%ChatFile%"
goto mainmenu

:: Menu to change name
:changename
cls
echo ========================================
echo Change Username
echo Your current name: %UserName%
echo ========================================
set /p NewName=Enter a new name (Type "cancel" to cancel): 
if /i "!NewName!"=="cancel" goto mainmenu
if "!NewName!"=="" (
    echo Name cannot be empty. Please try again.
    pause>nul
    goto changename
)
set UserName=!NewName!
echo Your name has been changed to: %UserName%
pause>nul
goto mainmenu

:clearchat
cls
echo ========================================
echo Clear Chat Log
echo ========================================
echo Are you sure you want to clear the chat log? (This cannot be undone.)
echo [1] Yes
echo [2] No
echo ========================================
set /p cchoice=Your choice: 
if "%cchoice%"=="1" (del "%ChatFile%" 2>nul & echo Chat log cleared! & pause > nul)
goto mainmenu

:changetheme
cls
echo ========================================
echo Change Theme - Dynamic Previews
echo ========================================
echo [1] Default (White on Black)
echo [2] Blue Theme (Blue on White)
echo [3] Green Theme (Green on Black)
echo [4] Red Theme (Red on Black)
echo [5] Yellow Theme (Yellow on Black)
echo [6] Cyan Theme (Cyan on Black)
echo [7] Purple Theme (Purple on Black)
echo [8] Custom Theme (Choose Your Own Colors)
echo ========================================
echo Type the number of your choice to preview the theme.
echo Type "apply" to set the current theme or "cancel" to return to the main menu.
echo ========================================
set "currentTheme=07"
:previewloop
set /p themechoice=Your choice: 

:: Handle cancellations
if /i "!themechoice!"=="cancel" (color %currentTheme% & goto mainmenu)

:: Apply a preview for each option
if "%themechoice%"=="1" (color 07 & echo Default Theme Preview & set currentTheme=07)
if "%themechoice%"=="2" (color 1F & echo Blue Theme Preview & set currentTheme=1F)
if "%themechoice%"=="3" (color 2F & echo Green Theme Preview & set currentTheme=2F)
if "%themechoice%"=="4" (color 4F & echo Red Theme Preview & set currentTheme=4F)
if "%themechoice%"=="5" (color 6F & echo Yellow Theme Preview & set currentTheme=6F)
if "%themechoice%"=="6" (color 3F & echo Cyan Theme Preview & set currentTheme=3F)
if "%themechoice%"=="7" (color 5F & echo Purple Theme Preview & set currentTheme=5F)
if "%themechoice%"=="apply" goto mainmenu

:: Handle custom theme input
if "%themechoice%"=="8" goto customtheme

goto previewloop

:customtheme
cls
echo ========================================
echo Create Your Custom Theme
echo ========================================
echo CMD Color Codes:
echo 0 = Black,  1 = Blue,   2 = Green,   3 = Aqua
echo 4 = Red,    5 = Purple, 6 = Yellow,  7 = White
echo 8 = Gray,   9 = Light Blue, A = Light Green
echo B = Light Aqua, C = Light Red, D = Light Purple
echo E = Light Yellow, F = Bright White
echo ========================================
echo Enter a combination of two codes (e.g., "1F" for Blue on White).
echo The first code is the background, and the second is the text color.
echo ========================================
set /p customColor=Enter your custom color code: 

:: Validate custom input
if not "%customColor:~0,1%"=="" if not "%customColor:~1,1%"=="" (
    color %customColor%
    set currentTheme=%customColor%
    echo Custom Theme Applied! Code: %customColor%
    pause
    goto changetheme
)

echo Invalid color code. Please try again.
pause
goto customtheme

:: Exit menu
:leavemenu
cls
echo ========================================
echo Exit Request
echo ========================================
echo Do you want to leave The Chat?
echo [1] Yes
echo [2] No
echo ========================================
set /p lchoice= Your choice:

if "%lchoice%"=="1" goto thanks
if "%lchoice%"=="2" goto mainmenu

:: Thank you and exit
:thanks
cls
@echo off
echo ========================================
echo Thanks for using The Chat! I hope you liked it. (closing chat soon...)
echo ========================================
timeout /t 4 > nul
exit
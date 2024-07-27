ECHO OFF
set DOTNET_CLI_TELEMETRY_OPTOUT=1
:MainMenu
echo Input Options:
echo.
echo ::1) Mount Storage (Series Console)
echo ::2) Mount Storage (One Console)
echo ::3) Get Temp XVD Owner (Warning - needs fix does not exit command)
echo ::4) Backup XBFS (Important file)
echo ::5) Allow Emulators (Only needs to be run once)
echo ::6) Backup Licences to USB:\Licenses
echo ::7) Backup Saves (Mount Storage First)
echo ::8) Start Defult Account Shell
echo ::Q) Quit
echo.
echo Thanks to carrot-c4k3, xbox one research project team, tuxuser, lllsondowlll, Helloyunho, burninrubber0 and everyone else on the Xbox-Scene Discord
echo.
set /p input=Input:
if "%input%" == "1" call :MountStorageseries
if "%input%" == "2" call :MountStorageone
if "%input%" == "3" call :Tempxvd
if "%input%" == "4" call :xbfsbackup
if "%input%" == "5" call :allowemu
if "%input%" == "6" call :sclip
if "%input%" == "7" call :Dumpsaves
if "%input%" == "8" call :Dashell
if "%input%" == "Q" exit /b 0
if "%input%" == "q" exit /b 0
goto :MainMenu

:MountStorageseries
ECHO Mount Storage on Xbox Series
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\mount_connectedstoragess.xml
echo.
echo Please observe the outputted harddisk number and type the command below replace ## with the harddisk number above. 
echo mklink /j T:\connectedStorage "\\?\GLOBALROOT\Device\Harddisk##\Partition1\"
echo.
Pause
exit /b 0

:MountStorageone
ECHO Mount Storage on Xbox One
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\mount_connectedstorage.xml
echo.
echo Please observe the outputted harddisk number and type the command below replace ## with the harddisk number above.
echo mklink /j T:\connectedStorage "\\?\GLOBALROOT\Device\Harddisk##\Partition1\"
echo.
Pause
exit /b 0

:Tempxvd
ECHO Get Temp XVD Owner (gets XVD but but will not exit out of command, need a fix)
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\get_tempxvd_owners.xml
GOTO End

:xbfsbackup
ECHO Perform XBFS Backup
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\xbfs_backup.xml
GOTO End

:allowemu
ECHO Allow Emulators (unsure if it works properly)
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\allow_emulators.xml
GOTO End

:sclip
ECHO Backup Licenses
mkdir D:\Licenses
copy s:\clip\*.* D:\Licenses
GOTO End

:DumpSaves
ECHO Dump Saves (Credit to burninrubber0 on Discord)
echo.
cd t:\connectedstorage
t:
for /R /D %%d in (.\*) do (
    mkdir D:\xb1\saves%%~pnxd
)
for /R %%f in (.\*) do (
    copy %%f D:\xb1\saves%%~pnxf
)
GOTO End

:Dashell
ECHO IMPORTANT = Open a second command prompt and listen on port 1337 before continuing.
echo.
Pause
echo.
schtasks /create /f /tn "DAShell" /ru DefaultAccount /sc ONSTART /tr "D:\dotnet\dotnet.exe msbuild D:\msbuild_tasks\shell.xml"
schtasks /run /tn "DAShell"
GOTO End

:End

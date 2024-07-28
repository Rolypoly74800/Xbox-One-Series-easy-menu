ECHO OFF

set pwd=%cd%

:MainMenu
echo Input Options:
echo.
echo ::1) Mount Storage
echo ::2) Get Temp XVD Owner
echo ::3) Backup XBFS (Important file)
echo ::4) Allow Emulators (Only needs to be run once)
echo ::5) Backup Licences to USB:\Licenses
echo ::6) Backup Saves to USB (Mount Storage First)
echo ::Q) Quit
echo.
echo Thanks to carrot-c4k3, xbox one research project team, tuxuser, lllsondowlll, burninrubber0, Helloyunho and everyone else on the Xbox-Scene Discord
echo.
set /p input=Input:
if "%input%" == "1" call :MountStorage
if "%input%" == "2" call :Tempxvd
if "%input%" == "3" call :xbfsbackup
if "%input%" == "4" call :allowemu
if "%input%" == "5" call :sclip
if "%input%" == "6" call :Dumpsaves
if "%input%" == "Q" exit /b 0
if "%input%" == "q" exit /b 0
goto :MainMenu

:MountStorage
ECHO Mount Storage
echo.
%pwd%\dotnet\dotnet.exe msbuild %pwd%\msbuild_tasks\mount_connectedstorage.xml
echo.
set /p input=Please type the harddrive number only you see above in the field Device\Harddisk##\Partition1=
mklink /j T:\connectedStorage "\\?\GLOBALROOT\Device\Harddisk%input%\Partition1\"
GOTO End

:Tempxvd
ECHO Get Temp XVD Owner
echo.
%pwd%\dotnet\dotnet.exe msbuild %pwd%\msbuild_tasks\get_tempxvd_owners.xml
GOTO End

:xbfsbackup
ECHO Perform XBFS Backup
echo.
%pwd%\dotnet\dotnet.exe msbuild %pwd%\msbuild_tasks\xbfs_backup.xml
GOTO End

:allowemu
ECHO Allow Emulators (unsure if it works properly)
echo.
%pwd%\dotnet\dotnet.exe msbuild %pwd%\msbuild_tasks\allow_emulators.xml
GOTO End

:sclip
ECHO Backup Licenses
IF NOT EXIST %pwd%\Licenses (
    MKDIR %pwd%\Licenses
)
copy s:\clip\*.* %pwd%\Licenses
GOTO End

:DumpSaves
ECHO Dump Saves (Credit to burninrubber0 on Discord)
echo.
cd /d t:connectedstorage
for /R /D %%d in (.\*) do (
    mkdir %pwd%\xb1\saves%%~pnxd
)
for /R %%f in (.\*) do (
    copy %%f %pwd%\xb1\saves%%~pnxf
)
d:
GOTO End

:End

ECHO OFF
set DOTNET_CLI_TELEMETRY_OPTOUT=1
:MainMenu

echo Input Options:
echo.
echo ::1) Mount Storage (Series Console)
echo ::2) Mount Storage (One Console)
echo ::3) Get Temp XVD Owner
echo ::4) Backup XBFS (Important file)
echo ::5) Allow Emulators (Only needs to be run once, gives 1 error but seems to work)
echo ::6) Backup Licences to USB:\Licenses
echo ::7) Backup Saves to USB (Mount Storage First)
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
if "%input%" == "Q" exit /b 0
if "%input%" == "q" exit /b 0

:MountStorageseries
ECHO Mount Storage on Xbox Series
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\mount_connectedstoragess.xml
echo.
set /p input=Please type the harddrive number only you see above in the field Device\Harddisk##\Partition1=
mklink /j T:\connectedStorage "\\?\GLOBALROOT\Device\Harddisk%input%\Partition1\"
GOTO :mainmenu

:MountStorageone
ECHO Mount Storage on Xbox One
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\mount_connectedstorage.xml
echo.
set /p input=Please type the harddrive number only you see above in the field Device\Harddisk##\Partition1=
mklink /j T:\connectedStorage "\\?\GLOBALROOT\Device\Harddisk%input%\Partition1\"
GOTO :mainmenu

:Tempxvd
ECHO Get Temp XVD Owner
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\get_tempxvd_owners.xml
GOTO :mainmenu

:xbfsbackup
ECHO Perform XBFS Backup
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\xbfs_backup.xml
GOTO :mainmenu

:allowemu
ECHO Allow Emulators (unsure if it works properly)
echo.
d:\dotnet\dotnet.exe msbuild d:\msbuild_tasks\allow_emulators.xml
GOTO :mainmenu

:sclip
ECHO Backup Licenses
IF NOT EXIST D:\Licenses (
    MKDIR D:\Licenses
)
copy s:\clip\*.* D:\Licenses
GOTO :mainmenu

:DumpSaves
ECHO Dump Saves (Credit to burninrubber0 on Discord)
echo.
cd /d t:\connectedstorage
for /R /D %%d in (.\*) do (
    mkdir D:\xb1\saves%%~pnxd
)
for /R %%f in (.\*) do (
    copy %%f D:\xb1\saves%%~pnxf
)
d:
GOTO :mainmenu

:End

@ECHO OFF

rem ****************
rem VARIABLE DEFINES
rem ****************

set DIR=%~dp0

set SV_ASSETS=zzz_sup_server
set CL_ASSETS=zzz_sup_client

rem ***************
rem START OF SCRIPT 
rem ***************

ECHO.
ECHO ===========
ECHO Making Pk3s
ECHO ===========

ECHO Y | DEL %SV_ASSETS%.pk3
ECHO Y | DEL %CL_ASSETS%.pk3

rmdir %DIR%\%SV_ASSETS% /S /Q
rmdir %DIR%\%CL_ASSETS% /S /Q

rem These assets are what the clients needs
xcopy %DIR%\fonts\*.*							%DIR%\%CL_ASSETS%\fonts\						/E

xcopy %DIR%\maps\*.bsp							%DIR%\%CL_ASSETS%\maps\							/E
xcopy %DIR%\maps\*.siege						%DIR%\%CL_ASSETS%\maps\							/E

xcopy %DIR%\models\								%DIR%\%CL_ASSETS%\models\						/E
xcopy %DIR%\shaders\							%DIR%\%CL_ASSETS%\shaders\						/E
xcopy %DIR%\textures\							%DIR%\%CL_ASSETS%\textures\						/E
xcopy %DIR%\gfx\								%DIR%\%CL_ASSETS%\gfx\							/E

xcopy %DIR%\music\								%DIR%\%CL_ASSETS%\music\						/E
xcopy %DIR%\sound\								%DIR%\%CL_ASSETS%\sound\						/E

xcopy %DIR%\ext_data\cm\*.cm					%DIR%\%CL_ASSETS%\ext_data\cm\					/E
xcopy %DIR%\ext_data\sabers\*.sab				%DIR%\%CL_ASSETS%\ext_data\sabers\				/E
xcopy %DIR%\ext_data\vehicles\*.veh				%DIR%\%CL_ASSETS%\ext_data\vehicles\			/E
xcopy %DIR%\ext_data\vehicles\weapons\*.vwp		%DIR%\%CL_ASSETS%\ext_data\vehicles\weapons\	/E

mkdir %DIR%\%CL_ASSETS%\ext_data\mb2\teamconfig
for /R %DIR%\ext_data\mb2\teamconfig %%f in (*.mbtc) do (
    copy "%%f" %DIR%\%CL_ASSETS%\ext_data\mb2\teamconfig\
)

rem Use a for loop to process clientize each file individually
mkdir %DIR%\%CL_ASSETS%\ext_data\mb2\character
for /R %DIR%\ext_data\mb2\character %%f in (*.mbch) do (
    call 0_Clientize_Single.bat %%f
)
xcopy %DIR%\%CL_ASSETS%\ext_data\mb2\clientize\character\*.mbch		%DIR%\%CL_ASSETS%\ext_data\mb2\character\			/E


rem These assets need be on the server
xcopy %DIR%\botfiles\							%DIR%\%SV_ASSETS%\botfiles\						/E
xcopy %DIR%\campaignfiles\						%DIR%\%SV_ASSETS%\campaignfiles\				/E
xcopy %DIR%\scripts\							%DIR%\%SV_ASSETS%\scripts\						/E

xcopy %DIR%\maps\*.bsp							%DIR%\%SV_ASSETS%\maps\							/E
xcopy %DIR%\maps\*.siege						%DIR%\%SV_ASSETS%\maps\							/E

xcopy %DIR%\models\								%DIR%\%SV_ASSETS%\models\						/E

xcopy %DIR%\ext_data\npcs\*.npc					%DIR%\%SV_ASSETS%\ext_data\npcs\				/E

xcopy %DIR%\ext_data\sabers\*.sab				%DIR%\%SV_ASSETS%\ext_data\sabers\				/E
xcopy %DIR%\ext_data\vehicles\*.veh				%DIR%\%SV_ASSETS%\ext_data\vehicles\			/E
xcopy %DIR%\ext_data\vehicles\weapons\*.vwp		%DIR%\%SV_ASSETS%\ext_data\vehicles\weapons\	/E

mkdir %DIR%\%SV_ASSETS%\ext_data\mb2\teamconfig
for /R %DIR%\ext_data\mb2\teamconfig %%f in (*.mbtc) do (
    copy "%%f" %DIR%\%SV_ASSETS%\ext_data\mb2\teamconfig\
)
mkdir %DIR%\%SV_ASSETS%\ext_data\mb2\character
for /R %DIR%\ext_data\mb2\character %%f in (*.mbch) do (
    copy "%%f" %DIR%\%SV_ASSETS%\ext_data\mb2\character\
)


0_7zip.exe a -tzip %SV_ASSETS%.pk3 %DIR%\%SV_ASSETS%\* -mx9
0_7zip.exe a -tzip %CL_ASSETS%.pk3 %DIR%\%CL_ASSETS%\* -mx9

rem Archieve to pk3 with winrar (Does not work)
rem copy %DIR%\0.pk3	%DIR%\%SV_ASSETS%.pk3 /y
rem copy %DIR%\0.pk3	%DIR%\%CL_ASSETS%.pk3 /y
rem %Winrar% A %SV_ASSETS%.pk3 -y %DIR%\%SV_ASSETS%\
rem %Winrar% A %CL_ASSETS%.pk3 -y %DIR%\%CL_ASSETS%\


rmdir %DIR%\%SV_ASSETS% /S /Q
rmdir %DIR%\%CL_ASSETS% /S /Q


pause&exit

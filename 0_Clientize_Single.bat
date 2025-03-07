@echo off
setlocal enabledelayedexpansion

:: Check if no files were dragged onto the script
if "%~1"=="" (
    echo Please run the 0_Make_PK3 to clientize.
    pause
    exit /b
)

rem echo Directory is %DIR%.

set "inputfile=%~1"
::set "outputfile=%~dpn1_filtered%~x1"

:: Prefix rather than Suffix
rem set "outputfile=%~1"
rem set "outputfile=%~dp1%~nx1" 
rem set "outputfile=%~dp1/processed/%~1"
rem set "outputfile=%~dp1_sp_%~nx1" 
rem set "outputfile=\process\%~1"
set "outputfile=%~dp0\%CL_ASSETS%\ext_data\mb2\character\%~nx1" 

rem echo File %outputfile% output.

:: Use sed to replace content in lines starting with specific case sensitive keywords and lines with // comments, but keep the lines themselves
0_sed.exe -r "s/^[ \t]*(model|skin|attributes|weapons|forcepowers|saberstyle|holdables|MBClass|modelscale|classNumberLimit|extralives|respawnCustomTime|sabercolor|saber2color|customveh|meleeknockback|bargeSoundOverride|rageSoundOverride|customred|customgreen|customblue|special1|special2|special3|special4).*/\1/I; s/^[ \t]*\/\/.*/\/\//" "%inputfile%" > "%outputfile%"

0_sed.exe -i -e "/^model$/d" -e "/^skin$/d" -e "/^attributes$/d" -e "/^weapons$/d" -e "/^forcepowers$/d" -e "/^saberstyle$/d" -e "/^holdables$/d" -e "/^MBClass$/d" -e "/^modelscale$/d" -e "/^classNumberLimit$/d" -e "/^extralives$/d" -e "/^respawnCustomTime$/d" -e "/^sabercolor$/d" -e "/^saber2color$/d" -e "/^customveh$/d" -e "/^meleeknockback$/d" -e "/^bargeSoundOverride$/d" -e "/^rageSoundOverride$/d" -e "/^customred$/d" -e "/^customgreen$/d" -e "/^customblue$/d" -e "/^special1$/d" -e "/^special2$/d" -e "/^special3$/d" -e "/^special4$/d" -e "/^\/\/$/d"  "%outputfile%"

echo File %inputfile% input.
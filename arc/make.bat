@echo off

echo Start build...
if EXIST build del /Q build\*.*
if NOT EXIST build mkdir build

echo Assembling code...
bin\vasmarm_std_win32.exe -L build\compile.txt -m250 -Fbin -opt-adr -o build\rose-arc.bin rose.asm

if %ERRORLEVEL% neq 0 (
	echo Failed to assemble code.
	exit /b 1
)

echo Making !folder...
set FOLDER="!Rose"
if EXIST %FOLDER% del /Q "%FOLDER%"
if NOT EXIST %FOLDER% mkdir %FOLDER%

echo Adding files...
copy folder\*.* "%FOLDER%\*.*"
copy build\rose-arc.bin "%FOLDER%\!RunImage,ff8"
rem copy "music\h0ffman_-_everyway.mod" "%FOLDER%\Music,001"
copy "music\way_too_rude.mod" "%FOLDER%\Music,001"
rem copy "music\logicos.mod" "%FOLDER%\Music,001"
rem copy "music\h0ffman_-_technova.mod" "%FOLDER%\Music,001"

echo Copying !folder...
set HOSTFS=..\..\..\Arculator_V2.1_Windows\hostfs
if EXIST "%HOSTFS%\%FOLDER%" del /Q "%HOSTFS%\%FOLDER%"
if NOT EXIST "%HOSTFS%\%FOLDER%" mkdir "%HOSTFS%\%FOLDER%"
copy "%FOLDER%\*.*" "%HOSTFS%\%FOLDER%"

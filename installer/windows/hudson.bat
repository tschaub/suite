REM job to build .EXE
REM assumes that
REM   http://svn.opengeo.org/suite/trunk/installer
REM has been checked out
REM Also assumes that it is running inside installer\windows

REM Start by cleaning up target
rd /s /q ..\..\target\ >nul 2>nul

REM Get the maven artifact in place
@echo Downloading http://suite.opengeo.org/builds/opengeosuite-latest-win.zip ...
wget http://suite.opengeo.org/builds/opengeosuite-latest-win.zip >nul 2>nul
mkdir ..\..\target\win 2>nul
unzip opengeosuite-latest-win.zip -d ..\..\target\win
del opengeosuite-latest-win.zip

REM Get the dashboard in place
@echo Downloading http://suite.opengeo.org/builds/dashboard-latest-win32.zip ...
wget http://suite.opengeo.org/builds/dashboard-latest-win32.zip >nul 2>nul
rd /s /q ..\..\target\win\dashboard
unzip dashboard-latest-win32.zip -d ..\..\target\win\
del dashboard-latest-win32.zip
ren "..\..\target\win\OpenGeo Dashboard" dashboard

REM Get today's date
FOR /F "TOKENS=1* DELIMS= " %%A IN ('DATE/T') DO SET CDATE=%%B
FOR /F "TOKENS=1,2 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET mm=%%B
FOR /F "TOKENS=1,2 DELIMS=/ eol=/" %%A IN ('echo %CDATE%') DO SET dd=%%B
FOR /F "TOKENS=2,3 DELIMS=/ " %%A IN ('echo %CDATE%') DO SET yyyy=%%B
SET todaysdate=%yyyy%-%mm%-%dd%

REM Get version number
findstr suite_version ..\..\target\win\version.ini > "%TEMP%\vertemp.txt"
set /p vertemp=<"%TEMP%\vertemp.txt"
del "%TEMP%\vertemp.txt"
for /f "tokens=1,2 delims=/=" %%a in ("%vertemp%") do set trash=%%a&set version=%%b

REM Get revision number
findstr svn_revision ..\..\target\win\version.ini > "%TEMP%\revtemp.txt"
set /p revtemp=<"%TEMP%\revtemp.txt"
del "%TEMP%\revtemp.txt"
for /f "tokens=1,2 delims=/=" %%a in ("%revtemp%") do set trash=%%a&set revision=%%b

makensis /DVERSION=%version% /DLONGVERSION=0.0.0.%revision% OpenGeoInstaller.nsi

REM Clean up
rd /s /q ..\..\target\

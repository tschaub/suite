REM job to build .EXE
REM assumes that...
REM   http://svn.opengeo.org/suite/trunk/installer/windows
REM   http://svn.opengeo.org/suite/trunk/installer/common
REM ...have both been checked out
REM Also assumes that it is running inside installer\windows

REM Start by cleaning up target
rd /s /q ..\..\target\

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

makensis OpenGeoInstaller.nsi

REM Clean up
rd /s /q ..\..\target\

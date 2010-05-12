REM job to build .EXE
REM assumes that http://svn.opengeo.org/suite/trunk/installer has been checked out

REM Get the maven artifact in place
@echo Downloading http://suite.opengeo.org/builds/opengeosuite-latest-win.zip ...
wget http://suite.opengeo.org/builds/opengeosuite-latest-win.zip >nul 2>nul
mkdir ..\..\target\opengeosuite-1.0-win 2>nul
unzip opengeosuite-latest-win.zip -d ..\..\target\opengeosuite-1.0-win
del opengeosuite-latest-win.zip

REM Get the dashboard in place
@echo Downloading http://suite.opengeo.org/builds/dashboard-latest-win32.zip ...
wget http://suite.opengeo.org/builds/dashboard-latest-win32.zip >nul 2>nul
unzip dashboard-latest-win32.zip -d ..\..\target\opengeosuite-1.0-win\dashboard
del dashboard-latest-win32.zip
rd /s /q ..\..\target\opengeosuite-1.0-win\dashboard\assembly

makensis OpenGeoInstaller.nsi

REM Clean up
rd /s /q ..\..\target\

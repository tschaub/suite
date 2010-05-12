REM job to build .EXE
REM assumes that http://svn.opengeo.org/suite/trunk/installer has been checked out

wget http://suite.opengeo.org/builds/opengeosuite-latest-win.zip >nul
mkdir ..\target\opengeosuite-1.0-win 2>nul
unzip opengeosuite-latest-win.zip ..\..\target\opengeosuite-1.0-win
del opengeosuite-latest-win.zip
makensis OpenGeoInstaller.nsi
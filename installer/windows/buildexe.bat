@echo off
:: This will build the OpenGeo Suite Windows executable
:: Assumes that
::   git://github.com/opengeo/suite.git
:: has been checked out
:: Also assumes that it is running inside installer\windows

:: Requires two paramters
:: buildexe.bat %dist_path% %revision% [%profile%]
:: See Usage at bottom
if "x%2"=="x" goto Usage
if not "x%4"=="x" goto Usage
set dist_path=%1
set revision=%2
set profile=%3

:: Start by cleaning up target
rd /s /q ..\..\target\ >nul 2>nul

:: Assemble artifact base URL
set url=http://suite.opengeo.org/builds/%dist_path%/%revision%

:: GDAL binaries
set gdal_zip=gdal-win.zip
set gdal_bin=http://suite.opengeo.org/winbuilds/%gdal_zip%

:: Generate id string (for file names)
if "x%profile%"=="x" (
  set id=%revision%
) else (
  set id=%profile%-%revision%
)

:: File names
set mainzip=opengeosuite-%id%-win.zip
set dashzip=opengeosuite-%id%-dashboard-win32.zip

:: Get the maven artifacts 
echo Downloading %url%/%mainzip% ...
if not exist %mainzip% (
  wget %url%/%mainzip% >nul 2>nul || (
    echo Error: File not found
    exit /b 1
  )
)

echo Downloading %url%/%dashzip% ...
if not exist %dashzip% (
  wget %url%/%dashzip% >nul 2>nul || (
    echo Error: File not found
    exit /b 1
  )
)

:: Get the GDAL bindings
echo Downloading %gdal_bin% ...
if not exist %gdal_zip% (
  wget %gdal_bin% >nul 2>nul || (
    echo Error: File not found
    exit /b 1
  )
)

:: Put artifacts in place
mkdir ..\..\target\win 2>nul
unzip -o %mainzip% -d ..\..\target\win
del %mainzip%
rd /s /q ..\..\target\win\dashboard
unzip -o %dashzip% -d ..\..\target\win\
del %dashzip%
ren "..\..\target\win\OpenGeo Dashboard" dashboard
unzip -o %gdal_zip% -d gdal
move gdal\c\build\gdal\bin\gdal18.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\gdalconstjni.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\gdaljni.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\ogrjni.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\osrjni.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\lti_dsdk.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\lti_dsdk_cdll.dll ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\gdalplugins ..\..\target\win\jre\bin
move gdal\c\build\gdal\bin\gdal-1.8.1.jar ..\..\target\win\webapps\geoserver\WEB-INF\lib
rd /s /q gdal
del %gdal_zip%

:: Get version number
:: Example: "2.1.2" or "2.3-SNAPSHOT"
findstr suite_version ..\..\target\win\version.ini > "%TEMP%\vertemp.txt"
set /p vertemp=<"%TEMP%\vertemp.txt"
del "%TEMP%\vertemp.txt"
for /f "tokens=1,2 delims=/=" %%a in ("%vertemp%") do set trash=%%a&set version=%%b

:: Figure out if the version is a release version or a SNAPSHOT/RC
:: Used to pass the correct longversion parameter to NSIS
:: since NSIS longversion must be of the form #.#.#.#

:: First, split the version string on a dash (to check for -SNAPSHOT or -RC)
for /f "tokens=1,2 delims=-" %%a in ("%version%") do set verpredash=%%a&set verpostdash=%%b
:: If a second chunk exists, then it's a -SNAPSHOT or -RC
if not "x%verpostdash%"=="x" goto Snapshot
:: Now check for empty substrings (to check for bad versions)
for /f "tokens=1,2,3,4 delims=." %%a in ("%version%") do set vermajor=%%a&set verminor=%%b&set verpatch=%%c&set vertrash=%%d
:: There must be three substrings here, so check for the third
if "x%verpatch%"=="x" goto Snapshot
:: There can't be a fourth substring, though
if not "x%vertrash%"=="x" goto Snapshot

:: If we made it this far, it's probably in the proper form
:: Back when the revision was a number, we used set longversion=%version%.%rev%
:: But now that revision is a hash, we can't insert it into the version string
set longversion=%version%.0
goto Build

:Snapshot
set longversion=0.0.0.0
goto Build

:Build
:: Now build the EXE with NSIS

echo Running NSIS: version %version%, longversion %longversion%, [profile %profile%]
if "%profile%"=="ee" (
  makensis /DVERSION=%version% /DLONGVERSION=%longversion% /DEEPROFILE=-%profile% OpenGeoInstaller.nsi
) else (
  makensis /DVERSION=%version% /DLONGVERSION=%longversion% /DEEPROFILE= OpenGeoInstaller.nsi
)

:: Clean up
rd /s /q ..\..\target\

goto End


:Usage
echo.
echo OpenGeo Suite build process
echo.
echo Usage:
echo   buildexe.bat dist_path revision [profile]
echo Exs:
echo   buildexe.bat latest 2d34ad3 ee
echo   buildexe.bat archive e4317fa
echo.
exit /b 1



:End

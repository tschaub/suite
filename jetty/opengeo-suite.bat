@echo off
echo.

REM Check for one argument, display usage and quit if not found

if "%1" == "" (
  echo Sorry, one argument is required.
  goto Usage
)

REM pushd to current working directory
pushd %~dp0%

REM Check for og-jetty.jar
if not exist og-jetty.jar (
  echo File og-jetty.jar not found!  Aborting...
  goto Done
)

REM Check for JRE
if not exist jre\bin\java.exe (
  echo JRE not found!  Aborting...
  goto Done
)

REM Check debug flag
set COMMAND=start jre\bin\javaw.exe
if "%2" == "debug" (
  set COMMAND=jre\bin\java.exe  
)

REM Java flags
set CLASSPATH=og-jetty.jar;jetty-start.jar;lib/ini4j-0.5.1.jar;lib/log4j-1.2.14.jar;lib/commons-logging-1.0.jar;lib/slf4j-jcl-1.0.1.jar
set OPTS=-Dslf4j=false -cp %CLASSPATH%

REM Start
if "%1" == "start" (
  echo Starting the OpenGeo Suite...
  start jre\bin\javaw.exe %OPTS% org.opengeo.jetty.Start
  goto Done
)


REM Stop
if "%1" == "stop" (
  echo Stopping the OpenGeo Suite...
  start jre\bin\javaw.exe %OPTS% org.opengeo.jetty.Start --stop
  goto Done
)

REM if %1 is unknown

:Usage
REM Display usage 
echo.
echo Usage:
echo    opengeo-suite ^[start^|stop^] ^[debug^]
goto End

:Done
popd
goto End

:End
echo.


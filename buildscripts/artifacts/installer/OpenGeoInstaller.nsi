; OpenGeo Suite Windows installer creation file

; Define your application name
!define COMPANYNAME "OpenGeo"
!define APPNAME "OpenGeo Suite"
!define VERSION "0.4"
!define LONGVERSION "0.4.0.0" ; must be a.b.c.d
!define APPNAMEANDVERSION "${APPNAME} ${VERSION}"


; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES\${APPNAMEANDVERSION}"
InstallDirRegKey HKLM "Software\${COMPANYNAME}\${APPNAME}" ""
OutFile "OpenGeoSuite-0.4.exe"

;Compression options
CRCCheck on

; This is the gray text on the bottom left of the installer.
BrandingText " "

; Hide the "Show details" button during the install/uninstall
ShowInstDetails nevershow
ShowUninstDetails nevershow

; For Vista
RequestExecutionLevel admin

; Includes
!include "MUI.nsh" ; Modern interface settings
!include "StrFunc.nsh" ; String functions
!include "x64.nsh" ; To check for 64 bit OS
!include "LogicLib.nsh" ; ${If} ${Case} etc.
!include "nsDialogs.nsh" ; For Installer Type page (Radio buttons)
!include "WordFunc.nsh" ; For VersionCompare

; WARNING!!! These plugins need to be installed spearately
; See http://nsis.sourceforge.net/ModernUI_Mod_to_Display_Images_while_installing_files
!include "Image.nsh" ; For graphics during the install 
; http://nsis.sourceforge.net/TextReplace_plugin
!include "TextReplace.nsh" ; For text replacing
; AccessControl plugin needed as well for permissions changes
; See http://nsis.sourceforge.net/AccessControl_plug-in

; Might be the same as !define
Var JavaHome
Var STARTMENU_FOLDER
Var CommonAppData
Var Manual
Var Service
Var IsManual

; Version Information (Version tab for EXE)
VIProductVersion ${LONGVERSION}
VIAddVersionKey ProductName "${APPNAME}"
VIAddVersionKey CompanyName "OpenGeo"
VIAddVersionKey LegalCopyright "Copyright (c) 1999 - 2009 OpenGeo"
VIAddVersionKey FileDescription "OpenGeo Suite Installer"
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey Comments "http://opengeo.org"

; Install options page headers
LangString TEXT_READY_TITLE ${LANG_ENGLISH} "Ready to Install"
LangString TEXT_READY_SUBTITLE ${LANG_ENGLISH} "OpenGeo Suite is ready to be installed."
LangString TEXT_TYPE_TITLE ${LANG_ENGLISH} "Type of Installation"
LangString TEXT_TYPE_SUBTITLE ${LANG_ENGLISH} "Select the type of installation."

;Interface Settings
!define MUI_ICON "opengeo.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\win-uninstall.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP header.bmp
!define MUI_WELCOMEFINISHPAGE_BITMAP side_left.bmp

;Start Menu Folder Page Configuration
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${COMPANYNAME}\${APPNAME}" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

; "Are you sure you wish to cancel" popup.
!define MUI_ABORTWARNING

; Optional welcome text here
!define MUI_WELCOMEPAGE_TEXT "Welcome to the OpenGeo Suite.\r\n\r\n\
                              It is recommended that you close all other applications before starting Setup.\r\n\r\n\
	                          Click Next to continue."

; What to do when done
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Start GeoServer and launch the Data Importer"
!define MUI_FINISHPAGE_RUN_FUNCTION "RunStuff"

; Launch a shortcut after install
Function RunStuff

  ${If} $IsManual == 0 ; i.e. only if service install
	; Run the service (t)
    nsExec::Exec "$INSTDIR\GeoServer\wrapper\wrapper.exe -t wrapper.conf"
  ${EndIf}
  ${If} $IsManual == 1 ; i.e. only if manual install
    ExecShell "open" "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Start GeoServer.lnk"
  ${EndIf}

  ;Script to check if GeoServer has finished launching.  Checks for a response on port 8080
  ;We could delete this file after it's finished running, as it's no longer needed...
  SetOutPath "$TEMP"
  File /a gscheck.bat
  ExecWait $TEMP\gscheck.bat
  Delete $TEMP\gscheck.bat

  ClearErrors
  ExecShell "open" "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Data Importer.lnk"
  IfErrors 0 +2
    MessageBox MB_ICONSTOP "Unable to start GeoServer or open browser.  Please use the Start Menu to manually start the application."
  ClearErrors

FunctionEnd


; Install Page order
; This is the main list of installer things to do
!insertmacro MUI_PAGE_WELCOME                                 ; Hello
Page custom CheckUserType                                     ; Die if not admin
Page custom PriorInstall                                      ; Check to see if previously installed
!insertmacro MUI_PAGE_LICENSE "license.txt"                   ; Show license
;!insertmacro MUI_PAGE_COMPONENTS                              ; List of stuff to install
!insertmacro MUI_PAGE_DIRECTORY                               ; Where to install
;Page custom DirectoryCheck                                   ; Check for bad location
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER ; Start menu location
Page custom GetJRE                                            ; Check for JRE
Page custom InstallType InstallTypeTest                       ; Install manually or as a service?
Page custom Ready                                             ; Ready to install page
!insertmacro MUI_PAGE_INSTFILES                               ; Actually do the install
!insertmacro MUI_PAGE_FINISH                                  ; Done

; Uninstall Page order
!insertmacro MUI_UNPAGE_CONFIRM   ; Are you sure you wish to uninstall?
!insertmacro MUI_UNPAGE_INSTFILES ; Do the uninstall
;!insertmacro MUI_UNPAGE_FINISH    ; Done

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL


; Startup tasks
Function .onInit
	
  ; Splash screen
  SetOutPath $TEMP
; File /oname=spltmp.bmp "splash.bmp" ; normal splash
; advsplash::show 2000 500 500 -1 $TEMP\spltmp 
  File /oname=spltmp.bmp "splashtransparent.bmp" ; transparent splash
  advsplash::show 2500 500 500 0xEC008C $TEMP\spltmp
	;advsplash::show Delay FadeIn FadeOut KeyColor FileName
  Pop $0 ; $0 has '1' if the user closed the splash screen early,
         ;    has '0' if everything closed normally, and '-1' if some error occurred.
  Delete $TEMP\spltmp.bmp
	
  ; Extract install options from .ini files
  !insertmacro MUI_INSTALLOPTIONS_EXTRACT "ready.ini"
		
  ; Tests for 32/64 bit system
  ; Bombs out if 64 bit
  ${If} ${RunningX64}
  MessageBox MB_ICONSTOP "Sorry, this installer is only supported on 32 bit systems."
  Quit
  ${EndIf}

  ; Get the Common App Data path
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Common AppData"
  StrCpy $CommonAppData $R0

  ;Set $IsManual at the onset, to allow for memory of radio boxes in next section
  StrCpy $IsManual 1

FunctionEnd

; Check the user type, and quit if it's not an administrator.
; Taken from Examples/UserInfo that ships with NSIS.
Function CheckUserType
  ClearErrors
  UserInfo::GetName
  IfErrors Win9x
  Pop $0
  UserInfo::GetAccountType
  Pop $1
  StrCmp $1 "Admin" Admin NoAdmin

  NoAdmin:
    MessageBox MB_ICONSTOP "Sorry, you must have administrative rights in order to install the OpenGeo Suite."
    Quit

  Win9x:
    MessageBox MB_ICONSTOP "Sorry, this installer is not supported on Windows 9x/ME."
    Quit
		
  Admin:
	
FunctionEnd


; Checks for existing versions
Function PriorInstall

  ClearErrors
  ReadRegStr $R0 HKLM "Software\${COMPANYNAME}\${APPNAME}" ""
  IfErrors NoPriorInstall
  ClearErrors
  ReadRegStr $R1 HKLM "Software\${COMPANYNAME}\${APPNAME}" "CurrentVersion"
  IfErrors CorruptedReg ; Can't find the version!
 
  ${VersionCompare} $R1 ${VERSION} $R2 ; 0 if =, 1 if <, 2 if >
  ${Switch} $R2
    ${Case} 0 ; Same version
    MessageBox MB_ICONSTOP "Setup has found an existing installation of the OpenGeo Suite \
                            on your machine. If you wish to reinstall the OpenGeo Suite, \
                            please uninstall it first and then run this installer again."
    Goto Fail
    ${Case} 1 ; Upgrading
    MessageBox MB_ICONSTOP "Setup has found an existing installation of the OpenGeo Suite \
                            on your machine.  Please uninstall this version first before \
                            running Setup."
    Goto Fail
    ${Case} 2 ; Downgrading
    MessageBox MB_ICONSTOP "Setup has found an existing installation of the OpenGeo Suite \
                            on your machine that is newer than the one you are trying to \
                            install.  Please uninstall this newer version first before \
                            running Setup."
    Goto Fail 
  ${EndSwitch}

  CorruptedReg:
    MessageBox MB_ICONSTOP "Setup is unable to determine the existing version of the OpenGeo \
                            Suite installed on your machine.  This may be due to a corrupted \
                            registry.  If you feel you have received this message in error, \
                            please contact OpenGeo at inquiry@opengeo.org."
    Goto Fail

  Fail:
    MessageBox MB_OK "Setup will now exit."
    Quit

  NoPriorInstall:

FunctionEnd
  

; Will build a page with radio buttons for manual vs service selection
Function InstallType

  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "$(TEXT_TYPE_TITLE)" "$(TEXT_TYPE_SUBTITLE)"

  ;Syntax: ${NSD_*} x y width height text
  ${NSD_CreateLabel} 0 0 100% 24u 'Select the type of installation for the OpenGeo Suite.  If you are unsure of which option to select, choose the "Run manually" option.'
  ${NSD_CreateRadioButton} 10 28u 50% 12u "Run manually"
  Pop $Manual

  ${NSD_CreateLabel} 10 44u 90% 24u "For evaulating the OpenGeo Suite.  Software will be installed as a standalone application."
  ${NSD_CreateRadioButton} 10 72u 50% 12u "Install as a service"
  Pop $Service

  ${If} $IsManual == 1
    ${NSD_Check} $Manual ; Default
  ${Else}
    ${NSD_Check} $Service
  ${EndIf}

  ${NSD_CreateLabel} 10 88u 90% 24u "For system administrators who wish to integrate with Windows Services.  GeoServer will run in a restricted account for greater security."

  nsDialogs::Show

FunctionEnd


; Records the final state of manual vs service
Function InstallTypeTest

  ${NSD_GetState} $Manual $IsManual
  ; $IsManual = 1 -> Run manually
  ; $IsManual = 0 -> Run as service

FunctionEnd


; Find Java on the system
; Lovingly ripped off from http://nsis.sourceforge.net/Java_Launcher
Function GetJRE

  ; use javaw.exe to avoid dosbox.
  ; use java.exe to keep stdout/stderr
  !define JAVAEXE "java.exe"


  ; look in registry 
  ClearErrors
  ReadRegStr $R1 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment" "CurrentVersion"
  ReadRegStr $R0 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment\$R1" "JavaHome"
  IfFileExists "$R0\bin\${JAVAEXE}" JreFound


  ; look for %JAVA_HOME%
  ClearErrors
  ReadEnvStr $R0 JAVA_HOME
  IfFileExists "$R0\bin\${JAVAEXE}" JREFound  

  ; Can't find Java, will install later
  StrCpy $JavaHome "NoJava"
  Goto Skip
  
  JREFound:
    StrCpy $JavaHome $R0

  Skip:
 
FunctionEnd

/*; This is a test to warn about installing in a stupid directory
Function DirectoryCheck


; This is a flag to prevent duplicate warning messages when using Back

  ; Filter out reserved directories
  StrCpy $0 $INSTDIR "" 2 ; get rid of c:
  ${WordReplace} $0 "\" "" "+" $0
  ${WordReplace} $0 "program files" "" "+" $0
  ${WordReplace} $0 "windows" "" "+" $0

  ; If nothing is left, user is installing to a bad directory
  StrCmp $0 "" BadDir GoodDir
  
  BadDir:
    
    MessageBox MB_ICONSTOP "You have chosen to install into the following directory:\
                            $\r$\n   $INSTDIR\$\r$\n\
                            To avoid potentially disastrous consequences, please go back \
                            and select a different directory."
  GoodDir:

FunctionEnd
*/

; One final page to review options
Function Ready

  StrCpy $8 "OpenGeo Suite install directory:\
             \r\n     $INSTDIR\r\n\r\n"

  StrCmp $IsManual 1 Manual Service

  Manual:
    StrCpy $8 "$8Installation type:\
               \r\n     Manual\r\n\r\n"
    Goto Java
  Service:
    StrCpy $8 "$8Installation type:\
               \r\n     Service\r\n\r\n"
    Goto Java
 
  Java:

  StrCmp $JavaHome "NoJava" NoJava YesJava
  NoJava:
    StrCpy $8 "$8Java Runtime Environment (JRE):\
               \r\n     (will be installed as part of Setup)"
    Goto Continue
  YesJava:
    StrCpy $8 "$8Java Runtime Environment (JRE):\
               \r\n     $JavaHome"
    Goto Continue

  Continue:

  !insertmacro MUI_HEADER_TEXT "$(TEXT_READY_TITLE)" "$(TEXT_READY_SUBTITLE)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ready.ini" "Field 2" "Text" $8
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "ready.ini"

FunctionEnd


; Install Java if necessary
Section -Prerequisites

  StrCmp $JavaHome "NoJava" Prereq NoPrereq

  Prereq:
    !insertmacro DisplayImage "slide_1_suite.bmp"
    MessageBox MB_OK "Please wait while Setup launches the Sun Java Runtime Environment (JRE) installer.  \
                      When the JRE is successfully installed, Setup will continue."
    SetOutPath $TEMP
    File /a ..\sun-java.exe

    ; reloading graphic on purpose, can get undrawn if minimized
    !insertmacro DisplayImage "slide_1_suite.bmp"

    ExecWait $TEMP\sun-java.exe $0
    Delete $TEMP\sun-java.exe
    StrCmp $0 "0" JavaSuccess JavaFail
    JavaFail:
      MessageBox MB_ICONSTOP "Sorry, the Java Runtime Environment (JRE) was not successfully installed.\
                              A JRE is required for the OpenGeo Suite.  Please run this installer again, \
                              and if you continue to have difficulties, please contact OpenGeo at \
                              inquiry@opengeo.org."
      Quit
    JavaSuccess:
      Call GetJRE

  NoPrereq:

SectionEnd

; The main install section
Section "GeoServer" Section1
	
  ; Makes this install mandatory
  SectionIn RO

  ; Set Section properties
  SetOverwrite on

  !insertmacro DisplayImage "slide_3_geoserver.bmp"

  ; Set Section Files and Shortcuts
  CreateDirectory $INSTDIR\GeoServer
  SetOutPath "$INSTDIR\GeoServer"
  File /a /oname=start.jar ..\geoserver\start.jar
  File /a /oname=GPL.txt ..\geoserver\GPL.txt
  File /a /oname=LICENSE.txt ..\geoserver\LICENSE.txt
  File /a /oname=README.txt ..\geoserver\README.txt
  File /a /oname=RUNNING.txt ..\geoserver\RUNNING.txt 
  File /a geoserver.ico
  ;File /r ..\geoserver\bin   ;Don't need it, making our own
  File /r ..\geoserver\etc 
  File /r ..\geoserver\lib 
  File /r ..\geoserver\resources 
  File /r ..\geoserver\webapps
  ; writable files to $CommonAppData (a la DocsSettings\AllUsers\AppData 
  CreateDirectory $CommonAppData\OpenGeo
  CreateDirectory $CommonAppData\OpenGeo\GeoServer
  SetOutPath "$CommonAppData\OpenGeo\GeoServer"
  ;File /r ..\data_dir            ; Custom data_dir
  File /r /x logging.xml ..\geoserver\data_dir   ; Default data_dir
  File /r ..\geoserver\logs
  SetOutPath "$CommonAppData\OpenGeo\GeoServer\data_dir"
  File /a logging.xml
  SetOutPath "$INSTDIR"
  File /a opengeo.ico


  ${If} $IsManual == 0 ; i.e. only if service install
    SetOutPath $INSTDIR\GeoServer
    CreateDirectory $INSTDIR\GeoServer\wrapper
    File /a /oname=wrapper\wrapper.exe wrapper.exe
    File /a /oname=wrapper\wrapper-server-license.txt wrapper-server-license.txt
    File /a /oname=wrapper\wrapper.conf wrapper.conf
    CreateDirectory $INSTDIR\GeoServer\wrapper\lib
    File /a /oname=wrapper\lib\wrapper.dll wrapper.dll
    File /a /oname=wrapper\lib\wrapper.jar wrapper.jar
  ${EndIf}
	

  ; Write GEOSERVER_DATA_DIR environment variable

  ; Unclear if we still need to do this, now that we hard code into the wrapper,
    ;Push GEOSERVER_DATA_DIR                         ; name
    ;Push "$CommonAppData\OpenGeo\GeoServer\data_dir"  ; value
    ;Call WriteEnvStr
  WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "GEOSERVER_DATA_DIR" "$CommonAppData\OpenGeo\GeoServer\data_dir"
  ; Make sure Windows knows about the change (not quite sure what this does)
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000


  ; logging.xml file is deleted/recreated here

  SetOutPath "$CommonAppData\OpenGeo\GeoServer"

  ; Replacing the [changeme] tag with the specific path to geoserver.log
  ${textreplace::ReplaceInFile} "$CommonAppData\OpenGeo\GeoServer\data_dir\logging.xml" \
                                "$CommonAppData\OpenGeo\GeoServer\data_dir\logging.xml" \
                                "[gslogpath]" "$CommonAppData\OpenGeo\GeoServer\logs" \
                                "/S=1" $0
  
  ${If} $IsManual == 0 ; i.e. only if service install
    ; wrapper.conf is customized here
    ; since we can't use environment variables (running as NetworkService)
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[javapath]" "$JavaHome" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[datadirpath]" "$CommonAppData\OpenGeo\GeoServer\data_dir" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[jettylogpath]" "$CommonAppData\OpenGeo\GeoServer\logs" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[wrapperlogpath]" "$CommonAppData\OpenGeo\GeoServer\logs\" \ 
                                  "/S=1" $1
    ; Give permission for NetworkService to be able to read/write to data_dir and logs
    AccessControl::GrantOnFile "$CommonAppData\OpenGeo" "NT AUTHORITY\NetworkService" "FullAccess"
	; Install the service (i)
    nsExec::Exec "$INSTDIR\GeoServer\wrapper\wrapper.exe -i wrapper.conf"

  ${EndIf}

  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application

  ;Create shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Web Admin Page.lnk" \
                 "http://localhost:8080/geoserver/web"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Data Importer.lnk" \
                 "http://localhost:8080/geoserver/web/?wicket:bookmarkablePage=:org.geoserver.web.importer.ImportPage"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"



  ; Different Start/Stop shortcuts depending on service/manual
  ${If} $IsManual == 0 ; i.e. only if service install
    CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Start GeoServer.lnk' '"$INSTDIR\GeoServer\wrapper\wrapper.exe"' '"-t" "wrapper.conf"' '$INSTDIR\GeoServer\geoserver.ico' 0
    CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Stop GeoServer.lnk' '"$INSTDIR\GeoServer\wrapper\wrapper.exe"' '"-p" "wrapper.conf"' '$INSTDIR\GeoServer\geoserver.ico' 0
  ${EndIf}
  ${If} $IsManual == 1 ; i.e. only if manual install

    SetOutPath "$INSTDIR\GeoServer"

    FileOpen $9 startgs.bat w ;Opens a Empty File and fills it
    FileWrite $9 'call "$JavaHome\bin\java.exe" -DGEOSERVER_DATA_DIR="$CommonAppData\OpenGeo\GeoServer\data_dir" -Xmx300m -DSTOP.PORT=8079 -DSTOP.KEY=geoserver -Djetty.logs="$CommonAppData\OpenGeo\GeoServer\logs" -jar start.jar'
    FileClose $9 ;Closes the filled file

    FileOpen $9 stopgs.bat w ;
    FileWrite $9 'call "$JavaHome\bin\java.exe" -DSTOP.PORT=8079 -DSTOP.KEY=geoserver -jar start.jar --stop'
    ;FileWrite $9 '$\r$\npause'
    FileClose $9

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Start GeoServer.lnk" "$INSTDIR\GeoServer\startgs.bat" "" "$INSTDIR\GeoServer\geoserver.ico" 0 SW_SHOWMINIMIZED

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Stop GeoServer.lnk" "$INSTDIR\GeoServer\stopgs.bat" "" "$INSTDIR\GeoServer\geoserver.ico" 0 SW_SHOWMINIMIZED

  ${EndIf}

    !insertmacro MUI_STARTMENU_WRITE_END
	
SectionEnd

Section "GeoExplorer" Section2

  ; Set Section properties
  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section Files and Shortcuts
  SetOutPath "$CommonAppData\OpenGeo\GeoServer\data_dir\www"
  File /r /x .svn ..\geoexplorer
  File /a /oname=geoexplorer\geoext.ico geoext.ico
  ; Next few lines are for a custom index.html (for looking at local host + no proxy)
  SetOutPath "$CommonAppData\OpenGeo\GeoServer\data_dir\www\GeoExplorer"
  Delete index.html
  File /a gxindex.html
  Rename gxindex.html index.html

  ; Shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer\GeoExplorer.lnk" \
		         "http://localhost:8080/geoserver/www/geoexplorer/index.html" \
                 "$CommonAppData\OpenGeo\GeoServer\data_dir\www\geoexplorer\geoext.ico"

SectionEnd

Section "Styler" Section3

  ; Set Section properties
  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section Files and Shortcuts
  SetOutPath "$CommonAppData\OpenGeo\GeoServer\data_dir\www"
  File /r /x .svn ..\styler
  File /a /oname=styler\geoext.ico geoext.ico

  ; Shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\Styler"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Styler\Styler.lnk" \
		         "http://localhost:8080/geoserver/www/styler/index.html" \
                 "$CommonAppData\OpenGeo\GeoServer\data_dir\www\styler\geoext.ico"

SectionEnd

Section "GeoServer Documentation" Section4

  !insertmacro DisplayImage "slide_1_suite.bmp"

  ; Set Section properties
  SetOverwrite on

  ; Set Section Files and Shortcuts
  SetOutPath "$INSTDIR\GeoServer"
  File /r /x .svn ..\geoserver_doc
  Rename "$INSTDIR\GeoServer\geoserver_doc" "$INSTDIR\GeoServer\docs"

  ; Shortcuts
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Documentation.lnk" \
		         "$INSTDIR\GeoServer\docs\index.html"

SectionEnd

Section "GeoExplorer Documentation" Section5

  !insertmacro DisplayImage "slide_1_suite.bmp"

  ; Set Section properties
  SetOverwrite on

  ; Set Section Files and Shortcuts
  CreateDirectory "$INSTDIR\GeoExplorer"
  SetOutPath "$INSTDIR\GeoExplorer"
  File /r /x .svn ..\geoexplorer_doc
  Rename "$INSTDIR\GeoExplorer\geoexplorer_doc" "$INSTDIR\GeoExplorer\docs"

  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer\GeoExplorer Documentation.lnk" \
		         "$INSTDIR\GeoExplorer\docs\index.html"

SectionEnd

Section "Getting Started" Section6

  !insertmacro DisplayImage "slide_1_suite.bmp"

  ; Set Section properties
  SetOverwrite on

  ; Set Section Files and Shortcuts
  SetOutPath "$INSTDIR"
  File /r /x .svn ..\integrationdocs_doc
  Rename "$INSTDIR\integrationdocs_doc" "$INSTDIR\Getting Started"

  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Getting Started.lnk" \
		         "$INSTDIR\Getting Started\index.html"

SectionEnd

/*; Modern install component descriptions
; Yes, this needs needs to go after the install sections. 
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1} "Installs Geoserver core components"
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2} "Installs GeoExplorer"
  !insertmacro MUI_DESCRIPTION_TEXT ${Section3} "Installs documentation"
!insertmacro MUI_FUNCTION_DESCRIPTION_END
*/

; What happens at the end of the install.
Section -FinishSection

  ; Reg Keys
  WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}" "" "$INSTDIR"
  WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}" "CurrentVersion" "${VERSION}"

  !define UNINSTALLREGPATH "Software\Microsoft\Windows\CurrentVersion\Uninstall"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "DisplayName" "${APPNAMEANDVERSION}"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "DisplayIcon" "$INSTDIR\opengeo.ico"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "Publisher" "OpenGeo"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "HelpLink" "http://opengeo.org"

  ; Next two keys are to display "Remove" instead of "Modify/Remove". 
  WriteRegDWORD HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "NoModify" "1"
  WriteRegDWORD HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "NoRepair" "1"

  ; This regkey will be needed for uninstall
  ${If} $IsManual == 0 ; i.e. only if service install
    WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}" "InstallType" "Service"
  ${EndIf}
  ${If} $IsManual == 1 ; i.e. only if manual install
    WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}" "InstallType" "Manual"
  ${EndIf}

  WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd


; Uninstall section
Section Uninstall

  ; First check if registry info is intact, otherwise install will fail
  ReadRegStr $0 HKLM "Software\${COMPANYNAME}\${APPNAME}\" ""
  ${If} $0 == ""
    MessageBox MB_ICONSTOP "Debug message: No regkey found!"
    Goto Fail
  ${EndIf}

  ; Check for service/manual
  ReadRegStr $0 HKLM "Software\${COMPANYNAME}\${APPNAME}" "InstallType"
  ${If} $0 == ""
    MessageBox MB_ICONSTOP "Debug message: No install type found!  Was this a service or manual install?"
    Goto Fail
  ${ElseIf} $0 == "Manual"
    ; Stop GeoServer
    SetOutPath "$INSTDIR\GeoServer"
    Exec "$INSTDIR\GeoServer\stopgs.bat"
    ; Wait for Start GeoServer window to go away
    Sleep 3000
  ${ElseIf} $0 == "Service"
    ; Stop and remove service
    nsExec::Exec "$INSTDIR\GeoServer\wrapper\wrapper.exe -r wrapper.conf"
  ${Else}
    MessageBox MB_ICONSTOP "Debug message: Wrong InstallType found!"
    Goto Fail
  ${EndIf}

  ; Get the Common App Data path
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Common AppData"
  StrCpy $CommonAppData $R0

  ; Check if user wants to remove the data dir
  MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "Do you want to remove your GeoServer data directory?  (If you have anything you want to keep, click No.)" IDYES DelDataDir IDNO NoDelDataDir

  DelDataDir:

    ; Have to move out of the directory to delete it
    SetOutPath $TEMP
    ; Remove env var
    DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "GEOSERVER_DATA_DIR"
    ; Make sure Windows knows about the change (not quite sure what this does)
    SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

    ; Delete whole $CommonAppData directory (including logs)!
    RMDir /r "$CommonAppData\OpenGeo\data_dir"
    RMDir /r "$CommonAppData\OpenGeo\logs"
    RMDir /r "$CommonAppData\OpenGeo"

  Goto Continue

  NoDelDataDir:

    ; Can't delete something we're inside!
    SetOutPath $PROGRAMFILES
    ; Just delete logs from CommonAppData
    RMDir /r "$CommonAppData\OpenGeo\GeoServer\logs"

  Goto Continue

  Continue:

    ; Remove all reg entries
    DeleteRegKey HKLM "Software\${COMPANYNAME}"
    DeleteRegKey HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}"

    ; Delete self
    Delete "$INSTDIR\uninstall.exe"
	
    ; Delete Shortcuts
    RMDir /r "$SMPROGRAMS\$STARTMENU_FOLDER"

	; Delete all!
    RMDir /r "$INSTDIR\GeoServer"
    RMDir /r "$INSTDIR\GeoExplorer"
    RMDir /r "$INSTDIR\Getting Started"
    Delete "$INSTDIR\*.*"

  Try:
    RMDir "$INSTDIR"
    IfFileExists "$INSTDIR" Warn Succeed

  Warn:
    MessageBox MB_RETRYCANCEL "Setup is having trouble removing all files and folders from:$\r$\n   $INSTDIR\$\r$\nPlease make sure no files are open in this directory and close all browser windows.  To try again, click Retry." IDRETRY Try IDCANCEL GiveUp

  GiveUp:
    MessageBox MB_ICONINFORMATION "WARNING: Some files and folders could not be removed from:$\r$\n   $INSTDIR\$\r$\nYou will have to manually remove these files and folders."
    Goto Succeed

  Fail:
    MessageBox MB_OK "Could not uninstall.  This may be due to a corrupted registry entry.  If you feel you have reached this message in error, please contact OpenGeo at inquiry@opengeo.org."
    Quit

  Succeed:

SectionEnd


; The End
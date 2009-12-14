; OpenGeo Suite Windows installer creation file

; Define your application name
!define COMPANYNAME "OpenGeo"
!define APPNAME "OpenGeo Suite"
!define VERSION "1.0-SNAPSHOT"
!define LONGVERSION "1.0.0.0" ; must be a.b.c.d
!define APPNAMEANDVERSION "${APPNAME} ${VERSION}"
!define SOURCEPATHROOT "..\..\target\suite-${VERSION}-raw"


; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAMEANDVERSION}"
InstallDirRegKey HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" ""
OutFile "OpenGeoSuite-${VERSION}.exe"

;Compression options
CRCCheck on

; This is the gray text on the bottom left of the installer.
BrandingText " " ; blank

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
!include "nsDialogs.nsh" ; For Custom page layouts (Radio buttons etc)
!include "WordFunc.nsh" ; For VersionCompare

; WARNING!!! These plugins need to be installed spearately


; See http://nsis.sourceforge.net/ModernUI_Mod_to_Display_Images_while_installing_files
!include "Image.nsh" ; For graphics during the install 

; http://nsis.sourceforge.net/TextReplace_plugin
!include "TextReplace.nsh" ; For text replacing

; AccessControl plugin needed as well for permissions changes
; See http://nsis.sourceforge.net/AccessControl_plug-in

; See http://nsis.sourceforge.net/Dialogs_plug-in
; Needs Dialogs.dll!
!include "defines.nsh" ; For nice UI-file/folder dialogs


; Might be the same as !define
Var STARTMENU_FOLDER
Var CommonAppData
Var Manual
Var Service
Var IsManual
Var GSUser
Var GSPass
Var Port
Var GSUserTemp
Var GSPassTemp
Var PortTemp
Var GSUserWarn
Var GSPassWarn
Var PortWarn
Var GSUserFilter
Var GSPassFilter
Var DataDirPath
Var FolderName


; Version Information (Version tab for EXE properties)
VIProductVersion ${LONGVERSION}
VIAddVersionKey ProductName "${APPNAME}"
VIAddVersionKey CompanyName "OpenGeo"
VIAddVersionKey LegalCopyright "Copyright (c) 1999 - 2009 OpenGeo"
VIAddVersionKey FileDescription "OpenGeo Suite Installer"
VIAddVersionKey ProductVersion "${VERSION}"
VIAddVersionKey FileVersion "${VERSION}"
VIAddVersionKey Comments "http://opengeo.org"

; Page headers for pages
LangString TEXT_TYPE_TITLE ${LANG_ENGLISH} "Type of Installation"
LangString TEXT_TYPE_SUBTITLE ${LANG_ENGLISH} "Select the type of installation."
LangString TEXT_CREDS_TITLE ${LANG_ENGLISH} "Administration"
LangString TEXT_CREDS_SUBTITLE ${LANG_ENGLISH} "Set configuration credentials and port."
LangString TEXT_READY_TITLE ${LANG_ENGLISH} "Ready to Install"
LangString TEXT_READY_SUBTITLE ${LANG_ENGLISH} "OpenGeo Suite is ready to be installed."

; Interface Settings
!define MUI_ICON "opengeo.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\win-uninstall.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP header.bmp
!define MUI_WELCOMEFINISHPAGE_BITMAP side_left.bmp

; Start Menu Folder Page Configuration
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM" 
!define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" 
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"

; "Are you sure you wish to cancel" dialog.
!define MUI_ABORTWARNING

; Optional welcome text here
!define MUI_WELCOMEPAGE_TEXT "Welcome to the OpenGeo Suite.\r\n\r\n\
                              It is recommended that you close all other applications before starting Setup.\r\n\r\n\
	                          Click Next to continue."

; What to do when done
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Start the OpenGeo Suite and launch the Dashboard"
!define MUI_FINISHPAGE_RUN_FUNCTION "RunStuff"

; Do things after install
Function RunStuff

  ${If} $IsManual == 0 ; i.e. only if service install
	; Run the service (t)
    nsExec::Exec "$INSTDIR\wrapper\wrapper.exe -t wrapper.conf"
  ${EndIf}
  ${If} $IsManual == 1 ; i.e. only if manual install
    ExecShell "open" "$SMPROGRAMS\$STARTMENU_FOLDER\Start OpenGeo Suite.lnk"
  ${EndIf}

  ;Script to check if Suite has finished launching.  Waits for a response on $Port 
  ExecWait $INSTDIR\checksuite.bat

  ClearErrors
  ExecShell "open" "$INSTDIR\Dashboard\OpenGeo Suite.exe" SW_SHOWMAXIMIZED
  IfErrors 0 +2
    MessageBox MB_ICONSTOP "Unable to start the OpenGeo Suite or launch the Dashboard.  Please use the Start Menu to manually start these applications."
  ClearErrors

FunctionEnd


; Install Page order
; This is the main list of installer pages
!insertmacro MUI_PAGE_WELCOME                                 ; Hello
;Page custom FileStuff FileStuffLeave                                    
Page custom CheckUserType                                     ; Die if not admin
Page custom PriorInstall                                      ; Check to see if previously installed
!insertmacro MUI_PAGE_LICENSE "..\common\license.txt"         ; Show license
!insertmacro MUI_PAGE_DIRECTORY                               ; Where to install
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER ; Start menu location
!insertmacro MUI_PAGE_COMPONENTS                              ; List of stuff to install
Page custom InstallType InstallTypeTest                       ; Install manually or as a service?
Page custom Creds CredsLeave                                  ; Set GeoServer admin credentials
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
  File /oname=spltmp.bmp "splash.bmp" ; transparent splash
  advsplash::show 2500 500 500 0xEC008C $TEMP\spltmp
  ;advsplash::show Delay FadeIn FadeOut KeyColor FileName
  Pop $0 ; '1' if the user closed the splash screen early
         ; '0' if everything closed normally
         ; '-1' if some error occurred.
  Delete $TEMP\spltmp.bmp


;Don't need to check for 64 bit anymore!
/*

  ; Tests for 32/64 bit system
  ; Bombs out if 64 bit
  ${If} ${RunningX64}
  MessageBox MB_ICONSTOP "Sorry, this installer is only supported on 32 bit systems."
  Quit
  ${EndIf}

*/

  ; Get the Common App Data path
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Common AppData"
  StrCpy $CommonAppData $R0

  ;Set $IsManual at the onset, to allow for memory of radio boxes in next section
  StrCpy $IsManual 1

  StrCpy $FolderName $EXEDIR



FunctionEnd

/*
Function FileStuff


  nsDialogs::Create 1018
  ;!insertmacro MUI_HEADER_TEXT "$(TEXT_TYPE_TITLE)" "$(TEXT_TYPE_SUBTITLE)"

   ;Syntax: ${NSD_*} x y width height text
   ${NSD_CreateLabel} 0 0 100% 24u "Setup needs to know the location of a folder.  Please select the folder or type it into the box below."

   ${NSD_CreateText} 10u 50u 200u 15u "$FolderName"
   Pop $R9 

   ${NSD_CreateBrowseButton} 220u 50u 60u 15u "Browse..."
   Pop $R1
   ${NSD_OnClick} $R1 FolderSpawn
    
  nsDialogs::Show

FunctionEnd

Function FolderSpawn

MessageBox MB_OK $R1

  nsDialogs::SelectFolderDialog "Please select a folder..." $EXEDIR
  Pop $R2
  StrCpy $FolderName $R2
  ${NSD_SetText} $R9 $FolderName

FunctionEnd

Function FileStuffLeave

   ${NSD_GetText} $R9 $FolderName

  MessageBox MB_OK "$FolderName"

FunctionEnd
*/

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

  ; Is this version already installed?
  ReadRegStr $R1 HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "InstallDir"
  IfErrors NoPriorInstall ; This specific version is not installed

  ClearErrors
  ; Fail!  This exact version is installed!

  MessageBox MB_ICONSTOP "Setup has found this version (${VERSION}) of the OpenGeo Suite \
                          installed on your machine.  If you wish to reinstall the \
                          OpenGeo Suite, please uninstall first.  After you have \
                          uninstalled, you may run Setup again.$\r$\n$\r$\nPlease note that \
                          it is also possible to run different versions of the OpenGeo Suite \
                          on your machine simultaneously."
  MessageBox MB_OK "Setup will now exit..."
  Quit

  NoPriorInstall:
  ClearErrors

FunctionEnd


; Will build a page with radio buttons for manual vs service selection
Function InstallType

  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "$(TEXT_TYPE_TITLE)" "$(TEXT_TYPE_SUBTITLE)"

  ;Syntax: ${NSD_*} x y width height text
  ${NSD_CreateLabel} 0 0 100% 24u 'Select the type of installation for the OpenGeo Suite.  If you are unsure of which option to choose, select the "Run manually" option.'
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

  ${NSD_CreateLabel} 10 88u 90% 24u "For system administrators who wish to integrate with Windows Services.  The OpenGeo Suite will run in a restricted account for greater security."

  nsDialogs::Show

FunctionEnd


; Records the final state of manual vs service
Function InstallTypeTest

  ${NSD_GetState} $Manual $IsManual
  ; $IsManual = 1 -> Run manually
  ; $IsManual = 0 -> Run as service

FunctionEnd


; Will build a page to input default GS admin creds
Function Creds
  
  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "$(TEXT_CREDS_TITLE)" "$(TEXT_CREDS_SUBTITLE)"

  ; Populates defaults on first display, and resets to default user blanked any of the values
  StrCmp $GSUser "" 0 +3
    StrCpy $GSUser "admin"
    StrCpy $GSPass "geoserver"
  StrCmp $GSPass "" 0 +3
    StrCpy $GSUser "admin"
    StrCpy $GSPass "geoserver"
  StrCmp $Port "" 0 +2
    StrCpy $Port 8080


  ;Syntax: ${NSD_*} x y width height text
  ${NSD_CreateLabel} 0 0 100% 36u "GeoServer requires a username and password in order to manage \
                                   and edit configuration.  Please enter a username and password \
                                   in each of the below fields, or leave unchanged to accept the \
                                   default values.  If either the username or password fields are \
                                   left blank, both fields will be replaced by the default values."
  ${NSD_CreateLabel} 20u 40u 40u 14u "Username"  
  ${NSD_CreateText} 70u 38u 50u 14u $GSUser
  Pop $GSUserTemp
  ${NSD_CreateLabel} 130u 40u 120u 14u "No commas or equal signs, please."
  Pop $GSUserWarn
  ${NSD_OnChange} $GSUserTemp UsernameCheck

  ${NSD_CreateLabel} 20u 60u 40u 14u "Password" 
  ${NSD_CreateText} 70u 58u 50u 14u $GSPass
  Pop $GSPassTemp
  ${NSD_CreateLabel} 130u 60u 120u 14u "No commas or equal signs, please."
  Pop $GSPassWarn
  ${NSD_OnChange} $GSPassTemp PasswordCheck

  ${NSD_CreateLabel} 0 80u 100% 20u "Enter the port that the OpenGeo Suite will respond on.  \
                                     Illegal values entered here will be replaced by the default \
                                     value."
  ${NSD_CreateLabel} 20u 102u 40u 14u "Port" 
  ${NSD_CreateNumber} 70u 100u 50u 14u $Port
  Pop $PortTemp
  ${NSD_CreateLabel} 130u 102u 120u 14u "Valid range is 1024-65535." 
  Pop $PortWarn
  ${NSD_OnChange} $PortTemp PortCheck

  nsDialogs::Show

FunctionEnd

Function UsernameCheck

  ; Check for illegal values of $GSUser and fix immediately
  ${NSD_GetText} $GSUserTemp $GSUser
  ${StrFilter} $GSUser "" "" ",=" $GSUserFilter
  StrCmp $GSUser $GSUserFilter +2 0        ; was anything filtered?
  ${NSD_SetText} $GSUserTemp $GSUserFilter ; if so display the filtered string

FunctionEnd

Function PasswordCheck

  ; Check for illegal values of $GSPass and fix immediately
  ${NSD_GetText} $GSPassTemp $GSPass
  ${StrFilter} $GSPass "" "" ",=" $GSPassFilter
  StrCmp $GSPass $GSPassFilter +2 0        ; was anything filtered?
  ${NSD_SetText} $GSPassTemp $GSPassFilter ; if so display the filtered string

FunctionEnd

Function PortCheck

  ; Check for illegal values of $Port and fix immediately

  ${NSD_GetText} $PortTemp $Port

  ${If} $Port > 65535
    StrCpy $Port 65535
    ${NSD_SetText} $PortTemp $Port  
  ;${ElseIf} $Port < 1
  ;  StrCpy $Port "8080"
  ;  ${NSD_SetText} $PortTemp $Port 

  ${EndIf}  

FunctionEnd

; Second half of Creds function
Function CredsLeave

  ${NSD_GetText} $GSUserTemp $GSUser ; converts numeric string into text...
  ${NSD_GetText} $GSPassTemp $GSPass ; ...and then saves into the same variable
  ${NSD_GetText} $PortTemp $Port             ; ditto  

  ; If user blanked either username/password, use defaults anyway!

  StrCmp $GSUser "" 0 +4
    MessageBox MB_ICONEXCLAMATION "The Username field cannot be blank.  Resetting username and \
                                   password fields to default values."
    StrCpy $GSUser "admin"
    StrCpy $GSPass "geoserver"
  StrCmp $GSPass "" 0 +4
    MessageBox MB_ICONEXCLAMATION "The Password field cannot be blank.  Resetting username and \
                                   password fields to default values."
    StrCpy $GSUser "admin"
    StrCpy $GSPass "geoserver"
  StrCmp $Port "" 0 +3 
    MessageBox MB_ICONEXCLAMATION "The Port field cannot be blank.  Resetting to default value."
    StrCpy $Port 8080

  ; Check for illegal values of $Port
  ${If} $Port < 1024        ; Too low
  ${OrIf} $Port > 65535     ; Too high
    MessageBox MB_ICONSTOP "Bad value in Port field.  Resetting to default value."
    StrCpy $Port 8080
  ${EndIf}  

FunctionEnd

; Custom page, last page before install
Function Ready

  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "$(TEXT_READY_TITLE)" "$(TEXT_READY_SUBTITLE)"

  ;Syntax: ${NSD_*} x y width height text
  ${NSD_CreateLabel} 0 0 100% 24u "Please review the settings below and click the Back button if \
                                   changes need to be made.  Click the Install button to continue."

  ${NSD_CreateLabel} 20u 25u 75% 12u "OpenGeo Suite install directory:"
  ${NSD_CreateLabel} 40u 34u 70% 12u "$INSTDIR"

  ; Install type
  ${NSD_CreateLabel} 20u 47u 75% 12u "OpenGeo Suite installation type:"
  StrCmp $IsManual 1 Manual Service
  Manual:
    ${NSD_CreateLabel} 40u 56u 70% 12u "Run manually"
    Goto Creds
  Service:
    ${NSD_CreateLabel} 40u 56u 70% 12u "Installed as a service"
    Goto Creds

  Creds:

    ${NSD_CreateLabel} 20u 69u 75% 12u "GeoServer username and password:"
    ${NSD_CreateLabel} 40u 78u 70% 12u "$GSUser : $GSPass"

    ${NSD_CreateLabel} 20u 91u 75% 12u "OpenGeo Suite web server port:"
    ${NSD_CreateLabel} 40u 100u 70% 12u "$Port"

  nsDialogs::Show

FunctionEnd


; Install Prerequisites if necessary
Section -Prerequisites

; No prereqs.

SectionEnd


; The webapp container
Section "-Jetty" SectionJetty ; dash = hidden

  SectionIn RO  ; Mandatory
  SetOverwrite on ; Set Section properties

  !insertmacro DisplayImage "slide_1_suite.bmp"

  SetOutPath "$INSTDIR"
  File /a "${SOURCEPATHROOT}\jetty\*.*"
  File /r "${SOURCEPATHROOT}\jetty\etc"
  File /r "${SOURCEPATHROOT}\jetty\lib"
  File /r "${SOURCEPATHROOT}\jetty\resources"

  File /a checksuite.bat ; Watches for port activity
  
  ; Set checksuite.bat to use the correct port
  ${textreplace::ReplaceInFile} "$INSTDIR\checksuite.bat" \
                                "$INSTDIR\checksuite.bat" \
                                "[jettyport]" "$Port" \ 
                                "/S=1" $1

  File /a opengeo.ico
  File /a ..\common\changelog.txt

  ; Copy our own JRE (which includes native JAI)
  File /r "${SOURCEPATHROOT}\jre"

  ; Create some dirs
  CreateDirectory "$INSTDIR\webapps"
  CreateDirectory "$CommonAppData\${COMPANYNAME}"
  CreateDirectory "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"

  ;Create shortcut
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"


  ${If} $IsManual == 0 ; i.e. only if service install
    SetOutPath "$INSTDIR"
    CreateDirectory "$INSTDIR\wrapper"
    File /a /oname=wrapper\wrapper.exe wrapper.exe
    File /a /oname=wrapper\wrapper-server-license.txt wrapper-server-license.txt
    CreateDirectory "$INSTDIR\wrapper\lib"
    File /a /oname=wrapper\lib\wrapper.dll wrapper.dll
    File /a /oname=wrapper\lib\wrapper.jar wrapper.jar
    File /a /oname=wrapper\wrapper.conf wrapper.conf
    ; wrapper.conf is customized here
    ${textreplace::ReplaceInFile} "$INSTDIR\wrapper\wrapper.conf" \
                                  "$INSTDIR\wrapper\wrapper.conf" \
                                  "[javapath]" "$INSTDIR\jre" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\wrapper\wrapper.conf" \
                                  "$INSTDIR\wrapper\wrapper.conf" \
                                  "[datadirpath]" "$DataDirPath" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\wrapper\wrapper.conf" \
                                  "$INSTDIR\wrapper\wrapper.conf" \
                                  "[jettylogpath]" "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\wrapper\wrapper.conf" \
                                  "$INSTDIR\wrapper\wrapper.conf" \
                                  "[wrapperlogpath]" "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs\" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\wrapper\wrapper.conf" \
                                  "$INSTDIR\wrapper\wrapper.conf" \
                                  "[jettyport]" "$Port" \ 
                                  "/S=1" $1

    ; Give permission for NetworkService to be able to read/write to data_dir and logs
    AccessControl::GrantOnFile "$CommonAppData\${COMPANYNAME}" "NT AUTHORITY\NetworkService" "FullAccess"
	; Install the service (i)
    nsExec::Exec "$INSTDIR\wrapper\wrapper.exe -i wrapper.conf"

  ${EndIf}





SectionEnd


Section "GeoServer" SectionGS

  SectionIn RO  ; Makes this install mandatory
  SetOverwrite on  

  !insertmacro DisplayImage "slide_3_geoserver.bmp"

  ; Copy GeoServer
  SetOutPath "$INSTDIR\webapps"
  File /r /x jai*.* "${SOURCEPATHROOT}\geoserver"
  SetOutPath "$INSTDIR\webapps\geoserver"
  File /a geoserver.ico

  ; Copy data_dir
  SetOutPath "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"
  File /r /x logging.xml /x security\users.properties  "${SOURCEPATHROOT}\data_dir"    ; Custom data_dir
  ; Next line is lame, but I can't figure out where this directory is being created
  RMDir /r "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\geoserver"

  ; Log path
  CreateDirectory "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs"


  StrCpy $DataDirPath "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\data_dir"
  SetOutPath "$DataDirPath"
  File /a logging.xml
  ; Replacing the [gslogpath] tag with the specific path to geoserver.log
  ${textreplace::ReplaceInFile} "$DataDirPath\logging.xml" \
                                "$DataDirPath\logging.xml" \
                                "[gslogpath]" "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs" \
                                "/S=1" $0

  SetOutPath "$DataDirPath\security"
  File /a users.properties
  ; Overwrite username and password in users.properties
  ${textreplace::ReplaceInFile} "$DataDirPath\security\users.properties" \
                                "$DataDirPath\security\users.properties" \
                                "[gsusername]" "$GSUser" \
                                "/S=1" $0
  ${textreplace::ReplaceInFile} "$DataDirPath\security\users.properties" \
                                "$DataDirPath\security\users.properties" \
                                "[gspassword]" "$GSPass" \
                                "/S=1" $0

  ; Shortcuts
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer Admin.lnk" \
                 "http://localhost:$Port/geoserver/web" \
                 "$INSTDIR\webapps\geoserver\geoserver.ico"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Import Layers.lnk" \
                 "http://localhost:$Port/geoserver/web/?wicket:bookmarkablePage=:org.geoserver.web.importer.ImportPage" \
                 "$INSTDIR\webapps\geoserver\geoserver.ico"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer Data Directory.lnk" \
                 "$DataDirPath"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer Logs.lnk" \
                 "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs" \
                 "$INSTDIR\webapps\geoserver\geoserver.ico"

SectionEnd


SectionGroup "GeoServer Extensions" SectionGSExt

  Section "GDAL" SectionGSGDAL

    SetOutPath "$INSTDIR\jre\bin"
    File /a "${SOURCEPATHROOT}\gdal\*.*"

  SectionEnd

  Section "H2" SectionGSH2

    ;SetOutPath "$INSTDIR\webapps\geoserver\WEB-INF\lib"
    ;File /a "${SOURCEPATHROOT}\geoserver_plugins\h2\*.*"

  SectionEnd

  Section "Oracle" SectionGSOracle

    ;SetOutPath "$INSTDIR\webapps\geoserver\WEB-INF\lib"
    ;File /a "${SOURCEPATHROOT}\geoserver_plugins\oracle\*.*"

  SectionEnd

SectionGroupEnd

Section "GeoWebCache" SectionGWC

  ; Set Section properties
  SectionIn RO ; mandatory
  SetOverwrite on

  ; Too Short to display graphic
  ; !insertmacro DisplayImage "slide_4_gwc.bmp"

  SetOutPath "$INSTDIR\webapps\geoserver"
  File /a geowebcache.ico



  ; GWC included with GS!

  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoWebCache.lnk" \
		         "http://localhost:$Port/geoserver/gwc/demo/" \
                 "$INSTDIR\webapps\geoserver\geowebcache.ico"

SectionEnd


Section "GeoExplorer" SectionGX

  SectionIn RO ; mandatory
  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  SetOutPath "$INSTDIR\webapps\"
  File /r /x doc "${SOURCEPATHROOT}\geoexplorer"
  File /a /oname=geoexplorer\geoext.ico geoext.ico
  
  ; Shortcuts
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer.lnk" \
		         "http://localhost:$Port/geoexplorer/index.html" \
                 "$INSTDIR\webapps\geoexplorer\geoext.ico"

  ; Give permission for NetworkService to be able to read/write
  ; This needs to change, shouldn't give write access to Program Files
  AccessControl::GrantOnFile "$INSTDIR\webapps\geoexplorer" "NT AUTHORITY\NetworkService" "FullAccess"

SectionEnd

Section "Styler" SectionStyler

  SectionIn RO ; mandatory
  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section Files and Shortcuts
  SetOutPath "$INSTDIR\webapps\"
  File /r "${SOURCEPATHROOT}\styler"
  File /a /oname=styler\geoext.ico geoext.ico

  ; Shortcuts
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Styler.lnk" \
		         "http://localhost:$Port/styler/" \
                 "$INSTDIR\webapps\styler\geoext.ico"

SectionEnd


Section "Documentation" SectionDocs

  SetOverwrite on

  !insertmacro DisplayImage "slide_1_suite.bmp"

  SetOutPath "$INSTDIR\webapps"

  ; Copy all doc projects
  File /r "${SOURCEPATHROOT}\docs"

  ; Shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\Documentation"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Documentation\GeoServer Documentation.lnk" \
		         "$INSTDIR\webapps\docs\geoserver\index.html" \
                 "$INSTDIR\webapps\geoserver\geoserver.ico"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Documentation\GeoExplorer Documentation.lnk" \
		         "$INSTDIR\webapps\docs\geoexplorer\index.html" \
                 "$INSTDIR\webapps\geoexplorer\geoext.ico"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Documentation\Styler Documentation.lnk" \
		         "$INSTDIR\webapps\docs\styler\index.html" \
                 "$INSTDIR\webapps\styler\geoext.ico"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Documentation\GeoWebCache Documentation.lnk" \
		         "$INSTDIR\webapps\docs\geoserver\geowebcache\index.html" \
                 "$INSTDIR\webapps\geoserver\geowebcache.ico"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Documentation\Getting Started.lnk" \
		         "$INSTDIR\webapps\docs\gettingstarted\index.html"

SectionEnd


Section "-Dashboard" SectionDashboard ;dash means hidden

  SectionIn RO  ; Makes this install mandatory
  SetOverwrite on
 
  !insertmacro DisplayImage "slide_1_suite.bmp"

  SetOutPath "$INSTDIR"
  ;File /r /x config.ini "${SOURCEPATHROOT}\dashboard"
  File /r "${SOURCEPATHROOT}\dashboard"
  SetOutPath "$INSTDIR\dashboard\Resources"
  ;File /a /oname=config.ini dashboard.ini
  ;${textreplace::ReplaceInFile} "$INSTDIR\dashboard\Resources\config.ini" \
  ;                              "$INSTDIR\dashboard\Resources\config.ini" \
  ;                              "[jettyport]" "$Port" \ 
  ;                              "/S=1" $1
  ${textreplace::ReplaceInFile} "$INSTDIR\dashboard\Resources\config.ini" \
                                "$INSTDIR\dashboard\Resources\config.ini" \
                                "8080" "$Port" \ 
                                "/S=1" $1

  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\OpenGeo Suite Dashboard.lnk" \
		         "$INSTDIR\dashboard\OpenGeo Suite.exe" \
                 "$INSTDIR\opengeo.ico"

SectionEnd


Section "-StartStop" SectionStartStop


  ; Create Start/Stop shortcuts
  ; Different shortcuts depending on install type

  ${If} $IsManual == 0 ; i.e. only if service install
    CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\Start OpenGeo Suite.lnk' '"$INSTDIR\wrapper\wrapper.exe"' '"-t" "wrapper.conf"' '$INSTDIR\opengeo.ico' 0
    CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\Stop OpenGeo Suite.lnk' '"$INSTDIR\wrapper\wrapper.exe"' '"-p" "wrapper.conf"' '$INSTDIR\opengeo.ico' 0
  ${EndIf}

  ${If} $IsManual == 1 ; i.e. only if manual install

    SetOutPath "$INSTDIR"

    FileOpen $9 startsuite.bat w ; Opens a Empty File and fills it
    FileWrite $9 'call "$INSTDIR\jre\bin\java.exe" -DGEOSERVER_DATA_DIR="$DataDirPath" -Xmx512m -DSTOP.PORT=8079 -DSTOP.KEY=geoserver -Djetty.logs="$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs" -Djetty.port=$Port -jar start.jar'
    FileClose $9 ; Closes the file

    FileOpen $9 stopsuite.bat w ; Opens a Empty File and fills it
    FileWrite $9 'call "$INSTDIR\jre\bin\java.exe" -DSTOP.PORT=8079 -DSTOP.KEY=geoserver -jar start.jar --stop'
    FileClose $9 ; Closes the file

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Start OpenGeo Suite.lnk" "$INSTDIR\startsuite.bat" "" "$INSTDIR\opengeo.ico" 0 SW_SHOWMINIMIZED

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Stop OpenGeo Suite.lnk" "$INSTDIR\stopsuite.bat" "" "$INSTDIR\opengeo.ico" 0 SW_SHOWMINIMIZED

  ${EndIf}

SectionEnd



; Modern install component descriptions
; Yes, this needs to go after the install sections. 
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionJetty} "Installs Jetty, a web server."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGS} "Installs GeoServer, a spatial data server."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGSExt} "Includes GeoServer Extensions."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGSGDAL} "Adds support for GDAL image formats."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGSH2} "Adds support for H2 databases."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGSOracle} "Adds support for Oracle databases."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGWC} "Includes GeoWebCache, a tile cache server."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionGX} "Installs GeoExplorer, a graphical map editor."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionStyler} "Installs Styler, a graphical map style editor."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionDocs} "Includes full documentation for all applications."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionDashboard} "Installs the OpenGeo Suite Dashboard for access to all components."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionStartStop} "Creates shortcuts for starting and stopping the OpenGeo Suite."
!insertmacro MUI_FUNCTION_DESCRIPTION_END


; What happens at the end of the install.
Section -FinishSection

  ; Reg Keys
  WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "" ""
  WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "InstallDir" "$INSTDIR"

  ; This regkey will be needed for uninstall
  ${If} $IsManual == 0 ; i.e. only if service install
    WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "InstallType" "Service"
  ${EndIf}
  ${If} $IsManual == 1 ; i.e. only if manual install
    WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "InstallType" "Manual"
  ${EndIf}  

  ; For the Add/Remove programs area
  !define UNINSTALLREGPATH "Software\Microsoft\Windows\CurrentVersion\Uninstall"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "DisplayName" "${APPNAMEANDVERSION}"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "DisplayIcon" "$INSTDIR\opengeo.ico"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "Publisher" "OpenGeo"
  WriteRegStr HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "HelpLink" "http://opengeo.org"
  WriteRegDWORD HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "NoModify" "1"
  WriteRegDWORD HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}" "NoRepair" "1"

  WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd


; Uninstall section
Section Uninstall

  ; First check if registry info is intact, otherwise install will fail
  ReadRegStr $0 HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "InstallDir"
  ${If} $0 == ""
    MessageBox MB_ICONSTOP "Debug message: No regkey found!"
    Goto Fail
  ${EndIf}

  ; Check for service/manual
  ReadRegStr $0 HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "InstallType"
  ${If} $0 == ""
    MessageBox MB_ICONSTOP "Debug message: No install type found!  Was this a service or manual install?"
    Goto Fail
  ${ElseIf} $0 == "Manual"
    ; Stop GeoServer
    SetOutPath "$INSTDIR"
    Exec "$INSTDIR\stopsuite.bat"
    ; Wait for Start GeoServer window to go away
    Sleep 5000
  ${ElseIf} $0 == "Service"
    ; Stop and remove service
    nsExec::Exec "$INSTDIR\wrapper\wrapper.exe -r wrapper.conf"
  ${Else}
    MessageBox MB_ICONSTOP "Debug message: Wrong InstallType found!"
    Goto Fail
  ${EndIf}

  ; Get the Common App Data path
  ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Common AppData"
  StrCpy $CommonAppData $R0

  StrCpy $DataDirPath "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\data_dir"

  MessageBox MB_OKCANCEL                    "Your data directory will be deleted!$\r$\n$\r$\n\
                                             Your data directory is located at:\
                                             $\r$\n     $DataDirPath$\r$\n$\r$\n\
                                             If you wish to save this directory for future use, \
                                             please take a moment to back it up now.$\r$\n\
                                             Click OK when ready to proceed." IDOK 0 IDCANCEL Die

  ; Have to move out of the directory to delete it
  SetOutPath $TEMP

  ; Delete whole $CommonAppData directory (including logs)!
  RMDir /r "$DataDirPath"
  RMDir /r "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs"
  RMDir /r "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"
  RMDir "$CommonAppData\${COMPANYNAME}"  ; Only delete if not empty!!!!!

  ; Remove all reg entries
  DeleteRegKey HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}"
  DeleteRegKey /ifempty HKLM "Software\${COMPANYNAME}"
  DeleteRegKey HKLM "${UNINSTALLREGPATH}\${APPNAMEANDVERSION}"

  ; Delete self
  Delete "$INSTDIR\uninstall.exe"

  ; Delete Shortcuts
  RMDir /r "$SMPROGRAMS\$STARTMENU_FOLDER"

  ; Delete all!

  Try:

    RMDir /r "$INSTDIR\dashboard"
    RMDir /r "$INSTDIR\etc"
    RMDir /r "$INSTDIR\lib"
    RMDir /r "$INSTDIR\resources"
    RMDir /r "$INSTDIR\webapps"
    RMDir /r "$INSTDIR\jre"
    RMDir /r "$INSTDIR\wrapper"
    Delete "$INSTDIR\*.*"
    RMDir "$INSTDIR"
    IfFileExists "$INSTDIR" Warn Succeed

  Warn:
    MessageBox MB_RETRYCANCEL "Setup is having trouble removing all files and folders from:$\r$\n   $INSTDIR\$\r$\nPlease make sure no files are open in this directory and close all browser windows.  You can also manually delete this folder if you choose.  To try again, click Retry." IDRETRY Try IDCANCEL GiveUp

  GiveUp:
    MessageBox MB_ICONINFORMATION "WARNING: Some files and folders could not be removed from:$\r$\n   $INSTDIR\$\r$\nYou will have to manually remove these files and folders."
    Goto Succeed

  Die:
    MessageBox MB_OK "Uninstallation was interrupted..."
    Quit

  Fail:
    MessageBox MB_ICONEXCLAMATION "Could not uninstall cleanly.  This may be due to a corrupted registry entry.  If you feel you have reached this message in error, please contact OpenGeo at inquiry@opengeo.org."
    Quit

  Succeed:
    RMDir "$PROGRAMFILES\${COMPANYNAME}"

SectionEnd

; The End
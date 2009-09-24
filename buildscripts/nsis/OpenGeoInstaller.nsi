; OpenGeo Suite Windows installer creation file

; Define your application name
!define COMPANYNAME "OpenGeo"
!define APPNAME "OpenGeo Suite"
!define VERSION "0.9"
!define LONGVERSION "0.9.0.0" ; must be a.b.c.d
!define APPNAMEANDVERSION "${APPNAME} ${VERSION}"


; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES\${COMPANYNAME}\${APPNAMEANDVERSION}"
InstallDirRegKey HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" ""
OutFile "OpenGeoSuite-0.9beta.exe"

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
Var GSUsername
Var GSPassword
Var GSUsernameTemp
Var GSPasswordTemp
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
LangString TEXT_CREDS_TITLE ${LANG_ENGLISH} "GeoServer Administrator"
LangString TEXT_CREDS_SUBTITLE ${LANG_ENGLISH} "Set administrator credentials."
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
!define MUI_FINISHPAGE_RUN_TEXT "Start GeoServer and launch the Data Importer"
!define MUI_FINISHPAGE_RUN_FUNCTION "RunStuff"

; Do things after install
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
  SetOutPath "$INSTDIR\GeoServer"
  File /a gscheck.bat
  ExecWait $INSTDIR\GeoServer\gscheck.bat
  ;Delete $INSTDIR\GeoServer\gscheck.bat

  ClearErrors
  ExecShell "open" "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Data Importer.lnk"
  IfErrors 0 +2
    MessageBox MB_ICONSTOP "Unable to start GeoServer or open browser.  Please use the Start Menu to manually start the application."
  ClearErrors

FunctionEnd


; Install Page order
; This is the main list of installer pages
!insertmacro MUI_PAGE_WELCOME                                 ; Hello
;Page custom FileStuff FileStuffLeave                                    
Page custom CheckUserType                                     ; Die if not admin
Page custom PriorInstall                                      ; Check to see if previously installed
!insertmacro MUI_PAGE_LICENSE "license.txt"                   ; Show license
!insertmacro MUI_PAGE_COMPONENTS                              ; List of stuff to install
!insertmacro MUI_PAGE_DIRECTORY                               ; Where to install
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER ; Start menu location
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
; File /oname=spltmp.bmp "splash.bmp" ; normal splash
; advsplash::show 2000 500 500 -1 $TEMP\spltmp 
  File /oname=spltmp.bmp "splashtransparent.bmp" ; transparent splash
  advsplash::show 2500 500 500 0xEC008C $TEMP\spltmp
	;advsplash::show Delay FadeIn FadeOut KeyColor FileName
  Pop $0 ; $0 has '1' if the user closed the splash screen early,
         ;    has '0' if everything closed normally, and '-1' if some error occurred.
  Delete $TEMP\spltmp.bmp
	
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


; Will build a page to input default GS admin creds
Function Creds

  
  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "$(TEXT_CREDS_TITLE)" "$(TEXT_CREDS_SUBTITLE)"

  ; This needs to be done at the beginning too to avoid clobbering these variables back into numbers
  ;${NSD_GetText} $GSUsernameTemp $GSUsername ; converts numeric string into text...
  ;${NSD_GetText} $GSPasswordTemp $GSPassword ; ...and then saves into the same variable

  ; Populate defaults on first display, and reset if user blanked eitehr username/password
  StrCmp $GSUsername "" 0 +3
    StrCpy $GSUsername "admin"
    StrCpy $GSPassword "geoserver"
  StrCmp $GSPassword "" 0 +3
    StrCpy $GSUsername "admin"
    StrCpy $GSPassword "geoserver"

  ;Syntax: ${NSD_*} x y width height text
  ${NSD_CreateLabel} 0 10u 100% 36u "GeoServer requires a username and password in order to edit its configuration.  Please enter a username and password in each of the below fields, or leave unchanged or blank to accept the defaults.  Neither the username nor password can be blank."
  ${NSD_CreateLabel} 20u 50u 40u 14u "Username"  
  ${NSD_CreateText} 70u 48u 50u 14u $GSUsername
  Pop $GSUsernameTemp
  ${NSD_CreateLabel} 20u 70u 40u 14u "Password" 
  ${NSD_CreateText} 70u 68u 50u 14u $GSPassword
  Pop $GSPasswordTemp

  nsDialogs::Show

FunctionEnd

; Second half of Creds function
Function CredsLeave


  ${NSD_GetText} $GSUsernameTemp $GSUsername ; converts numeric string into text...
  ${NSD_GetText} $GSPasswordTemp $GSPassword ; ...and then saves into the same variable

  ; If user blanked either username/password, use defaults anyway!
  StrCmp $GSUsername "" 0 +3
    StrCpy $GSUsername "admin"
    StrCpy $GSPassword "geoserver"
  StrCmp $GSPassword "" 0 +3
    StrCpy $GSUsername "admin"
    StrCpy $GSPassword "geoserver"


FunctionEnd

; Last page before install
Function Ready

  nsDialogs::Create 1018
  !insertmacro MUI_HEADER_TEXT "$(TEXT_READY_TITLE)" "$(TEXT_READY_SUBTITLE)"

  ;Syntax: ${NSD_*} x y width height text
  ${NSD_CreateLabel} 0 0 100% 24u "Please review the settings below and click the Back button if changes need to be made.  Click the Install button to continue."

  ${NSD_CreateLabel} 20u 25u 75% 12u "OpenGeo Suite install directory:"
  ${NSD_CreateLabel} 30u 33u 70% 12u "$INSTDIR"

  ; Install type
  ${NSD_CreateLabel} 20u 45u 75% 12u "GeoServer installation:"
  StrCmp $IsManual 1 Manual Service
  Manual:
    ${NSD_CreateLabel} 30u 53u 70% 12u "Run manually"
    Goto Creds
  Service:
    ${NSD_CreateLabel} 30u 53u 70% 12u "Installed as a service"
    Goto Creds

  Creds:

    ${NSD_CreateLabel} 20u 65u 75% 12u "GeoServer username and password:"
    ${NSD_CreateLabel} 30u 73u 70% 12u "$GSUsername : $GSPassword"

    ${NSD_CreateLabel} 20u 85u 75% 12u "Data and configuration will be stored here:"
    ${NSD_CreateLabel} 30u 93u 80% 20u "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"

  nsDialogs::Show

FunctionEnd


; Install Prerequisites if necessary
Section -Prerequisites

; No prereqs.

SectionEnd

; The main install section

SectionGroup "GeoServer" Section1

Section "GeoServer Core" Section1a
	
  SectionIn RO  ; Makes this install mandatory

  SetOverwrite on  ; Set Section properties

  !insertmacro DisplayImage "slide_3_geoserver.bmp"

  ; Copy GeoServer (minus data_dir)
  CreateDirectory $INSTDIR\GeoServer
  SetOutPath "$INSTDIR\GeoServer"
  File /a /oname=start.jar ..\artifacts\geoserver\start.jar 
  File /a /oname=GPL.txt ..\artifacts\geoserver\GPL.txt
  File /a /oname=LICENSE.txt ..\artifacts\geoserver\LICENSE.txt
  File /a /oname=README.txt ..\artifacts\geoserver\README.txt
  File /a /oname=RUNNING.txt ..\artifacts\geoserver\RUNNING.txt 
  File /a geoserver.ico
  File /r ..\artifacts\geoserver\etc 
  File /r ..\artifacts\geoserver\resources 
  File /r /x jai*.* ..\artifacts\geoserver\webapps ; excludes JAI
  File /r /x jai*.* ..\artifacts\geoserver\lib ; ugh, copies WEB-INF\lib too

  ; Copy our own JRE (which includes native JAI)
  File /r ..\artifacts\jre

  ; Copy data_dir
  CreateDirectory "$CommonAppData\${COMPANYNAME}"
  CreateDirectory "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"
  SetOutPath "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"
  File /r /x logging.xml /x security\users.properties ..\artifacts\data_dir    ; Custom data_dir
 ; Next line is lame, but I can't figure out where this directory is being created
  RMDir /r "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\geoserver"


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
                                "[gsusername]" "$GSUsername" \
                                "/S=1" $0
  ${textreplace::ReplaceInFile} "$DataDirPath\security\users.properties" \
                                "$DataDirPath\security\users.properties" \
                                "[gspassword]" "$GSPassword" \
                                "/S=1" $0



  ; Continuing on...
  SetOutPath "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"
  File /r ..\artifacts\geoserver\logs
  SetOutPath "$INSTDIR"
  File /a opengeo.ico

  ; NOT USING ENV VAR!
  ; Write GEOSERVER_DATA_DIR environment variable
  ;WriteRegExpandStr HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "GEOSERVER_DATA_DIR" "$CommonAppData\OpenGeo\GeoServer\data_dir"
  ; Make sure Windows knows about the change (not quite sure what this does)
  ;SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

  ${If} $IsManual == 0 ; i.e. only if service install
    SetOutPath $INSTDIR\GeoServer
    CreateDirectory $INSTDIR\GeoServer\wrapper
    File /a /oname=wrapper\wrapper.exe wrapper.exe
    File /a /oname=wrapper\wrapper-server-license.txt wrapper-server-license.txt
    CreateDirectory $INSTDIR\GeoServer\wrapper\lib
    File /a /oname=wrapper\lib\wrapper.dll wrapper.dll
    File /a /oname=wrapper\lib\wrapper.jar wrapper.jar

    File /a /oname=wrapper\wrapper.conf wrapper.conf
    ; wrapper.conf is customized here
    ; since we can't use environment variables (running as NetworkService)
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[javapath]" "$INSTDIR\GeoServer\jre" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[datadirpath]" "$DataDirPath" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[jettylogpath]" "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs" \ 
                                  "/S=1" $1
    ${textreplace::ReplaceInFile} "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "$INSTDIR\GeoServer\wrapper\wrapper.conf" \
                                  "[wrapperlogpath]" "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs\" \ 
                                  "/S=1" $1



    ; Give permission for NetworkService to be able to read/write to data_dir and logs
    AccessControl::GrantOnFile "$CommonAppData\${COMPANYNAME}" "NT AUTHORITY\NetworkService" "FullAccess"
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
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Data Directory.lnk" \
                 "$DataDirPath"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"


  ; Create Start/Stop shortcuts
  ; Different shortcuts depending on install type

  ${If} $IsManual == 0 ; i.e. only if service install
    CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Start GeoServer.lnk' '"$INSTDIR\GeoServer\wrapper\wrapper.exe"' '"-t" "wrapper.conf"' '$INSTDIR\GeoServer\geoserver.ico' 0
    CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Stop GeoServer.lnk' '"$INSTDIR\GeoServer\wrapper\wrapper.exe"' '"-p" "wrapper.conf"' '$INSTDIR\GeoServer\geoserver.ico' 0
  ${EndIf}

  ${If} $IsManual == 1 ; i.e. only if manual install

    SetOutPath "$INSTDIR\GeoServer"

    FileOpen $9 startgs.bat w ; Opens a Empty File and fills it
    FileWrite $9 'call "$INSTDIR\GeoServer\jre\bin\java.exe" -DGEOSERVER_DATA_DIR="$DataDirPath" -Xmx300m -DSTOP.PORT=8079 -DSTOP.KEY=geoserver -Djetty.logs="$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs" -jar start.jar'
    FileClose $9 ; Closes the file

    FileOpen $9 stopgs.bat w ; Opens a Empty File and fills it
    FileWrite $9 'call "$INSTDIR\GeoServer\jre\bin\java.exe" -DSTOP.PORT=8079 -DSTOP.KEY=geoserver -jar start.jar --stop'
    FileClose $9 ; Closes the file

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Start GeoServer.lnk" "$INSTDIR\GeoServer\startgs.bat" "" "$INSTDIR\GeoServer\geoserver.ico" 0 SW_SHOWMINIMIZED

    CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Stop GeoServer.lnk" "$INSTDIR\GeoServer\stopgs.bat" "" "$INSTDIR\GeoServer\geoserver.ico" 0 SW_SHOWMINIMIZED

  ${EndIf}

  !insertmacro MUI_STARTMENU_WRITE_END
	

SectionEnd

Section "GeoServer Documentation" Section1b

  !insertmacro DisplayImage "slide_3_geoserver.bmp"

  ; Set Section properties
  SetOverwrite on

  ; Set Section Files and Shortcuts
  SetOutPath "$INSTDIR\GeoServer"
  File /r /x .svn ..\artifacts\geoserver_doc
  Rename "$INSTDIR\GeoServer\geoserver_doc" "$INSTDIR\GeoServer\docs"

  ; Shortcuts
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Documentation.lnk" \
		         "$INSTDIR\GeoServer\docs\index.html"

SectionEnd

SectionGroup "GeoServer Extensions" Section1c

  Section "GDAL" Section1c1

    SetOutPath "$INSTDIR\GeoServer\jre\bin"
    File /a ..\artifacts\gdal\*.*

  SectionEnd

  Section "H2" Section1c2

    SetOutPath "$INSTDIR\GeoServer\webapps\geoserver\WEB-INF\lib"
    File /a ..\artifacts\geoserver_plugins\h2\*.*

  SectionEnd

  Section "Image Pyramid" Section1c3

    SetOutPath "$INSTDIR\GeoServer\webapps\geoserver\WEB-INF\lib"
    File /a ..\artifacts\geoserver_plugins\pyramid\*.*

  SectionEnd

  Section "Oracle" Section1c4

    SetOutPath "$INSTDIR\GeoServer\webapps\geoserver\WEB-INF\lib"
    File /a ..\artifacts\geoserver_plugins\oracle\*.*

  SectionEnd

  SectionGroupEnd

SectionGroupEnd


SectionGroup "GeoExplorer" Section2
Section "GeoExplorer Application" Section2a

  ; Set Section properties

  SectionIn RO ; mandatroy

  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section Files and Shortcuts
  SetOutPath "$DataDirPath\www"
  File /r /x .svn ..\artifacts\geoexplorer
  File /a /oname=geoexplorer\geoext.ico geoext.ico
  ; Next few lines are for a custom index.html (for looking at local host + no proxy)
  SetOutPath "$DataDirPath\www\GeoExplorer"
  Delete index.html
  File /a gxindex.html
  Rename gxindex.html index.html

  ; Shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer\GeoExplorer.lnk" \
		         "http://localhost:8080/geoserver/www/geoexplorer/index.html" \
                 "$DataDirPath\www\geoexplorer\geoext.ico"

SectionEnd

Section "GeoExplorer Documentation" Section2b

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section properties
  SetOverwrite on

  ; Set Section Files and Shortcuts
  CreateDirectory "$INSTDIR\GeoExplorer"
  SetOutPath "$INSTDIR\GeoExplorer"
  File /r /x .svn ..\artifacts\geoexplorer_doc
  Rename "$INSTDIR\GeoExplorer\geoexplorer_doc" "$INSTDIR\GeoExplorer\docs"

  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer\GeoExplorer Documentation.lnk" \
		         "$INSTDIR\GeoExplorer\docs\index.html"

SectionEnd

SectionGroupEnd


Section "Styler" Section3

  SectionIn RO ; mandatory

  ; Set Section properties
  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section Files and Shortcuts
  SetOutPath "$DataDirPath\www"
  ;File /r /x .svn ..\artifacts\styler
  File /r /x .svn /x tmp /x prop-base /x props /x text-base ..\artifacts\styler ; Just to make sure
  File /a /oname=styler\geoext.ico geoext.ico

  ; Shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\Styler"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Styler\Styler.lnk" \
		         "http://localhost:8080/geoserver/www/styler/index.html" \
                 "$DataDirPath\www\styler\geoext.ico"

SectionEnd


Section "-Getting Started" SectionH1 ;dash means hidden

  !insertmacro DisplayImage "slide_1_suite.bmp"

  ; Set Section properties
  SetOverwrite on

  ; Set Section Files and Shortcuts
  SetOutPath "$INSTDIR"
  File /r /x .svn ..\artifacts\integrationdocs_doc
  Rename "$INSTDIR\integrationdocs_doc" "$INSTDIR\Getting Started"

  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Getting Started.lnk" \
		         "$INSTDIR\Getting Started\index.html"

SectionEnd

; Modern install component descriptions
; Yes, this needs needs to go after the install sections. 
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1} "Installs GeoServer, a spatial data server."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1a} "Installs GeoServer core components."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1b} "Includes GeoServer User Manual."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1c} "Includes GeoServer Extensions."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1c1} "Adds support for GDAL image formats."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1c2} "Adds support for H2 databases."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1c3} "Adds support for image pyramid stores."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section1c4} "Adds support for Oracle databases."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2} "Installs GeoExplorer, a graphical map editor."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2a} "Installs GeoExplorer application."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section2b} "Includes GeoExplorer documentation."
  !insertmacro MUI_DESCRIPTION_TEXT ${Section3} "Installs Styler, a graphical map style editor."
  !insertmacro MUI_DESCRIPTION_TEXT ${SectionH1} "Quickstart guide on the OpenGeo Suite."
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

  ; OLD! v0.7 and before
  ;WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}\${VERSION}" "" "$INSTDIR"
  ;WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}" "" "OpenGeo Suite"
  ;WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAME}" "CurrentVersion" "${VERSION}"

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
    SetOutPath "$INSTDIR\GeoServer"
    Exec "$INSTDIR\GeoServer\stopgs.bat"
    ; Wait for Start GeoServer window to go away
    Sleep 5000
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

;  ; Check if user wants to remove the data dir
;  MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 "Do you want to remove your GeoServer data directory?  (If you have anything you want to keep, click No.)" IDYES DelDataDir IDNO NoDelDataDir

;  DelDataDir:

    ; Have to move out of the directory to delete it
    SetOutPath $TEMP
    ; Remove env var
    ;DeleteRegValue HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "GEOSERVER_DATA_DIR"
    ; Make sure Windows knows about the change (not quite sure what this does)
    ;SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000

    ; Delete whole $CommonAppData directory (including logs)!
    RMDir /r "$DataDirPath"
    RMDir /r "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}\logs"
    RMDir /r "$CommonAppData\${COMPANYNAME}\${APPNAMEANDVERSION}"
    RMDir "$CommonAppData\${COMPANYNAME}"  ; Only delete if not empty!!!!!

 

  Goto Continue

;  NoDelDataDir:
;
;    ; Can't delete something we're inside!
;    SetOutPath $PROGRAMFILES
;    ; Just delete logs from CommonAppData
;    RMDir /r "$CommonAppData\OpenGeo\GeoServer\logs"
;
;  Goto Continue

  Continue:

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
    RMDir /r "$INSTDIR\GeoServer"
    RMDir /r "$INSTDIR\GeoExplorer"
    RMDir /r "$INSTDIR\Getting Started"
    Delete "$INSTDIR\*.*"
    RMDir "$INSTDIR"
    IfFileExists "$INSTDIR" Warn Succeed

  Warn:
    MessageBox MB_RETRYCANCEL "Setup is having trouble removing all files and folders from:$\r$\n   $INSTDIR\$\r$\nPlease make sure no files are open in this directory and close all browser windows.  You can also manually delete this folder if you choose.  To try again, click Retry." IDRETRY Try IDCANCEL GiveUp

  GiveUp:
    MessageBox MB_ICONINFORMATION "WARNING: Some files and folders could not be removed from:$\r$\n   $INSTDIR\$\r$\nYou will have to manually remove these files and folders."
    Goto Succeed

  Fail:
    MessageBox MB_OK "Could not uninstall cleanly.  This may be due to a corrupted registry entry.  If you feel you have reached this message in error, please contact OpenGeo at inquiry@opengeo.org."
    Quit

  Succeed:

  RMDir "$PROGRAMFILES\${COMPANYNAME}"

SectionEnd


; The End
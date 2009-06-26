; OpenGeo Suite Windows installer creation file.

; Define your application name
!define COMPANYNAME "OpenGeo"
!define APPNAME "OpenGeo Suite"
!define APPNAMEANDVERSION "OpenGeo Suite v0.2"

;Compression options
CRCCheck on
;SetCompressor /SOLID lzma

; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES\${APPNAMEANDVERSION}"
InstallDirRegKey HKLM "Software\${COMPANYNAME}\${APPNAME}" ""
OutFile "OpenGeoSuite-v0.2.exe"

; This is the gray text on the bottom left of the installer.
BrandingText " "

; Expand the Show details button during the install
ShowInstDetails nevershow

; Includes
!include "MUI.nsh" ; Modern interface settings
!include "StrFunc.nsh" ; String functions
!include "x64.nsh" ; To check for 64 bit OS

; WARNING!!! These plugins need to be installed spearately
; See http://nsis.sourceforge.net/ModernUI_Mod_to_Display_Images_while_installing_files
!include "Image.nsh" ; For graphics during the install 
; http://nsis.sourceforge.net/TextReplace_plugin
!include "TextReplace.nsh" ; For text replacing
; AccessControl plugin needed as well for permissions changes
; See: http://nsis.sourceforge.net/AccessControl_plug-in


; Might be the same as !define
Var JavaHome
Var STARTMENU_FOLDER
Var CommonAppData
	
; Install options page headers
LangString TEXT_READY_TITLE ${LANG_ENGLISH} "Ready to Install"
LangString TEXT_READY_SUBTITLE ${LANG_ENGLISH} "OpenGeo Suite is ready to be installed."

;No credscheck for now
;LangString TEXT_CREDS_TITLE ${LANG_ENGLISH} "GeoServer Administrator"
;LangString TEXT_CREDS_SUBTITLE ${LANG_ENGLISH} "Set administrator credentials"

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
!define MUI_FINISHPAGE_RUN_TEXT "Launch the OpenGeo Data Importer"
!define MUI_FINISHPAGE_RUN_FUNCTION "RunLink"

; Launch a shortcut after install
Function RunLink
  ExecShell "" "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Web Admin Page.lnk"
FunctionEnd




; Install Page order
; This is the main list of installer things to do


!insertmacro MUI_PAGE_WELCOME                                 ; Hello
Page custom CheckUserType                                     ; Die if not admin
Page custom PriorInstall                                      ; Check to see if previously installed
!insertmacro MUI_PAGE_LICENSE "..\geoserver\LICENSE.txt"      ; Show license NEEDS TO INCLUDE ALL SOFTWARE!
;!insertmacro MUI_PAGE_COMPONENTS                              ; List of stuff to install
!insertmacro MUI_PAGE_DIRECTORY                               ; Where to install
!insertmacro MUI_PAGE_STARTMENU Application $STARTMENU_FOLDER ; Start menu location
Page custom GetJRE                                            ; Check for JRE
;Page custom CredsCheck                                        ; Will set admin/password (if new install)
Page custom Ready                                             ; Ready to install page
!insertmacro MUI_PAGE_INSTFILES                               ; Actually do the install
!insertmacro MUI_PAGE_FINISH                                  ; Done


; Uninstall Page order
!insertmacro MUI_UNPAGE_CONFIRM   ; Are you sure you wish to uninstall?
!insertmacro MUI_UNPAGE_INSTFILES ; Do the uninstall
!insertmacro MUI_UNPAGE_FINISH    ; Done

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL




; Startup tasks
Function .onInit
	
  ; Splash screen
  SetOutPath $TEMP
  File /oname=spltmp.bmp "splash.bmp"
  advsplash::show 2000 500 500 -1 $TEMP\spltmp
	;advsplash::show Delay FadeIn FadeOut KeyColor FileName
  Pop $0 ; $0 has '1' if the user closed the splash screen early,
         ;    has '0' if everything closed normally, and '-1' if some error occurred.
  Delete $TEMP\spltmp.bmp
	
  ; Extract install options from .ini files
  ;!insertmacro MUI_INSTALLOPTIONS_EXTRACT "creds.ini"
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

FunctionEnd


Function PriorInstall

  ClearErrors
  ReadRegStr $R0 HKLM "Software\${COMPANYNAME}" ""
  IfErrors NoPriorInstall
  ClearErrors
  MessageBox MB_ICONSTOP "Setup has found an existing installation of the OpenGeo Suite on your machine.  Please uninstall this version before running Setup."
  Abort

  NoPriorInstall:

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


; Find Java on the system
; Lovingly ripped off from http://nsis.sourceforge.net/Java_Launcher
Function GetJRE

;  Returns the full path of a valid java.exe
;  Looks in:
;  * JAVA_HOME environment variable
;  * Registry
 
  Push $R0
  Push $R1
 
  ; use javaw.exe to avoid dosbox.
  ; use java.exe to keep stdout/stderr
  !define JAVAEXE "java.exe"

  ; look for %JAVA_HOME%
  ClearErrors
  ReadEnvStr $R0 JAVA_HOME
  StrCpy $R0 "$R0\bin\${JAVAEXE}"
  IfErrors 0 JreFound  

  ; look for registry key 
  ClearErrors
  ReadRegStr $R1 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment" "CurrentVersion"
  ReadRegStr $R0 HKLM "SOFTWARE\JavaSoft\Java Runtime Environment\$R1" "JavaHome"
  StrCpy $R2 "$R0\bin\${JAVAEXE}"
  IfErrors 0 JreFound

  ; Can't find Java, will install 
  StrCpy $JavaHome "NoJava"
  Goto Skip
  
  JreFound:
    StrCpy $JavaHome $R0
    ;MessageBox MB_OK "Java found here: $JavaHome"

    ; Write JAVA_HOME environment variable
    Push "JAVA_HOME"           ; name
    Push "$JavaHome"          ; value
    Call WriteEnvStr

  Skip:
 
FunctionEnd


; Page for setting admin username/password
;Function CredsCheck
;
;  ; New data directory, so can set credentials without harming existing setup
;	
;	!insertmacro MUI_HEADER_TEXT "$(TEXT_CREDS_TITLE)" "$(TEXT_CREDS_SUBTITLE)"
;    !insertmacro MUI_INSTALLOPTIONS_DISPLAY "creds.ini"
;		
;    ; Username (admin) to $6
;	!insertmacro MUI_INSTALLOPTIONS_READ $6 "creds.ini" "Field 3" "State"
;    ; Password (geoserver) to $7
;    !insertmacro MUI_INSTALLOPTIONS_READ $7 "creds.ini" "Field 5" "State"	
;	
;FunctionEnd


; One final page to review options
Function Ready

  StrCmp $JavaHome "NoJava" NoJava YesJava
  NoJava:
    StrCpy $8 "Java Runtime Environment (JRE):\
               \r\n     (will be installed as part of Setup)"
    Goto Continue
  YesJava:
    StrCpy $8 "Java Runtime Environment (JRE):\
               \r\n     $JavaHome"
    Goto Continue
               
  Continue:

  ; Big long string with all the settings
  StrCpy $9 "OpenGeo Suite install directory:\
             \r\n     $INSTDIR\r\n\r\n$8" 

  !insertmacro MUI_HEADER_TEXT "$(TEXT_READY_TITLE)" "$(TEXT_READY_SUBTITLE)"
  !insertmacro MUI_INSTALLOPTIONS_WRITE "ready.ini" "Field 2" "Text" $9
  !insertmacro MUI_INSTALLOPTIONS_DISPLAY "ready.ini"

FunctionEnd

; Install Java if necessary
Section -Prerequisites

  !insertmacro DisplayImage "slide_1_suite.bmp"

  SetOutPath $TEMP
  StrCmp $JavaHome "NoJava" Prereq NoPrereq

  Prereq:
    MessageBox MB_OK "Please wait while Setup launches the Sun Java Runtime Environment (JRE) installer.  \
                      When the JRE is successfully installed, Setup will continue."
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
    CreateDirectory $INSTDIR\GeoServer\wrapper
	File /a /oname=wrapper\wrapper.exe wrapper.exe
	File /a /oname=wrapper\wrapper-server-license.txt wrapper-server-license.txt
    File /a /oname=wrapper\wrapper.conf wrapper.conf
    CreateDirectory $INSTDIR\GeoServer\wrapper\lib
    File /a /oname=wrapper\lib\wrapper.dll wrapper.dll
    File /a /oname=wrapper\lib\wrapper.jar wrapper.jar
	File /r ..\geoserver\bin 
	File /r ..\geoserver\etc 
	File /r ..\geoserver\lib 
	File /r ..\geoserver\resources 
	File /r ..\geoserver\webapps
    ; writable files to $CommonAppData (a la DocsSettings\AllUsers\AppData 
    CreateDirectory $CommonAppData\OpenGeo
    CreateDirectory $CommonAppData\OpenGeo\GeoServer
   	SetOutPath "$CommonAppData\OpenGeo\GeoServer"
	File /r ..\data_dir  ; CHANGE TO CUSTOM DATADIR?
	File /r ..\geoserver\logs
	
	; New users.properties file is created here
	;Delete "$DataDir\security\users.properties"
    ;FileOpen $R9 "$DataDir\security\users.properties" w
	;FileWrite $R9 "$6=$7,ROLE_ADMINISTRATOR"
    ;FileClose $R9

    ; Write GEOSERVER_DATA_DIR environment variable
    ; Unclear if we still need to do this, now that we hard code into the wrapper,
    Push "GEOSERVER_DATA_DIR"                         ; name
    Push "$CommonAppData\OpenGeo\GeoServer\data_dir"  ; value
    Call WriteEnvStr

    ; logging.xml file is deleted/recreated here
    Delete data_dir\logging.xml
    FileOpen $9 data_dir\logging.xml w ;Opens a Empty File an fills it
    FileWrite $9 "<logging>$\r$\n"
    FileWrite $9 "<level>DEFAULT_LOGGING.properties</level>$\r$\n"
    FileWrite $9 "$CommonAppData\OpenGeo\GeoServer\logs\geoserver.log</location>$\r$\n"
    FileWrite $9 "<stdOutLogging>true</stdOutLogging>$\r$\n"
    FileWrite $9 "</logging>$\r$\n"
    FileClose $9 ;Closes the filled file
    ;; Replacing the [changeme] tag with the specific path to geoserver.log
    ;${textreplace::ReplaceInFile} "$CommonAppData\OpenGeo\GeoServer\data_dir\logging.xml" \
    ;                              "$CommonAppData\OpenGeo\GeoServer\data_dir\logging.xml" \
    ;                              "[path]" "$CommonAppData\OpenGeo\GeoServer\logs\" \
    ;                              "/S=1" $0

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
                                  "[wrapperlogpath]" "$CommonAppData\OpenGeo\GeoServer\logs" \ 
                                  "/S=1" $1

   
    ; Give permission for NetworkService to be able to read/write to data_dir and logs
    AccessControl::GrantOnFile "$CommonAppData\OpenGeo" "NT AUTHORITY\NetworkService" "FullAccess"
	
	; Install the service (i)
    ; and start it (t)
    nsExec::Exec "$INSTDIR\GeoServer\wrapper\wrapper.exe -it wrapper.conf"

    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application

       ;Create shortcuts
       CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER"
       CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer"
       CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Homepage.lnk" \
		               "http://geoserver.org"
       CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\GeoServer Web Admin Page.lnk" \
		               "http://localhost:8080/geoserver/web"
       CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Start GeoServer.lnk' '"$INSTDIR\GeoServer\wrapper\wrapper.exe"' '"-t" "wrapper.conf"' '$INSTDIR\GeoServer\geoserver.ico' 0
       CreateShortCut '$SMPROGRAMS\$STARTMENU_FOLDER\GeoServer\Stop GeoServer.lnk'  '"$INSTDIR\GeoServer\wrapper\wrapper.exe"' '"-p" "wrapper.conf"' '$INSTDIR\GeoServer\geoserver.ico' 0
       CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\Uninstall.lnk" "$INSTDIR\Uninstall.exe"

    !insertmacro MUI_STARTMENU_WRITE_END
	
SectionEnd

Section "GeoExplorer" Section2

  ; Set Section properties
  SetOverwrite on

  !insertmacro DisplayImage "slide_6_geoext.bmp"

  ; Set Section Files and Shortcuts
  ReadEnvStr $R0 GEOSERVER_DATA_DIR
  SetOutPath "$R0\www"
  File /r ..\geoexplorer
  File /a geoext.ico

; index.html, embed.html, about.html, license/readme
; theme/ script/ externals/ 

  ; Shortcuts
  CreateDirectory "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer"
  CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\GeoExplorer\GeoExplorer.lnk" \
		         "http://localhost:8080/geoserver/www/geoexplorer/index.html" \
                 "$R0\www\geoserver.ico" 0

SectionEnd
;
;Section "Documentation" Section3
;
;   ; Set Section properties
;   SetOverwrite on
;
;   ; Set Section Files and Shortcuts
;   SetOutPath "$INSTDIR\"
;   File wrappertest.jar
;
;    ; See http://nsis.sourceforge.net/ModernUI_Mod_to_Display_Images_while_installing_files
;    !insertmacro DisplayImage "side_left.bmp"
;
;
;SectionEnd


; Modern install component descriptions
; Yes, this needs needs to go after the install sections. 
; !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
;	!insertmacro MUI_DESCRIPTION_TEXT ${Section1} "Installs Geoserver core components"
;	!insertmacro MUI_DESCRIPTION_TEXT ${Section2} "Installs GeoExplorer"
;	!insertmacro MUI_DESCRIPTION_TEXT ${Section3} "Installs documentation"
; !insertmacro MUI_FUNCTION_DESCRIPTION_END


; What happens at the end of the install.
Section -FinishSection

  ; Reg Keys
  WriteRegStr HKLM "Software\${COMPANYNAME}\${APPNAMEANDVERSION}" "" "$INSTDIR"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAMEANDVERSION}" "DisplayName" "${APPNAMEANDVERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAMEANDVERSION}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd




; ----------------------------------
; Environment Variable stuff (start)

!ifndef _WriteEnvStr_nsh
  !define _WriteEnvStr_nsh
  !include WinMessages.nsh
 
  !ifndef WriteEnvStr_RegKey
    !ifdef ALL_USERS
      !define WriteEnvStr_RegKey \
       'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
    !else
			; This is hacked to set a System var, not a user var
      !define WriteEnvStr_RegKey  'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
    !endif
  !endif


# WriteEnvStr - Writes an environment variable
# Note: Win9x systems requires reboot
#
# Example:
#  Push "HOMEDIR"           # name
#  Push "C:\New Home Dir\"  # value
#  Call WriteEnvStr
Function WriteEnvStr
  Exch $1 ; $1 has environment variable value
  Exch
  Exch $0 ; $0 has environment variable name
  Push $2
 
  Call IsNT
  Pop $2
  StrCmp $2 1 WriteEnvStr_NT
    ; Not on NT
    StrCpy $2 $WINDIR 2 ; Copy drive of windows (c:)
    FileOpen $2 "$2\autoexec.bat" a
    FileSeek $2 0 END
    FileWrite $2 "$\r$\nSET $0=$1$\r$\n"
    FileClose $2
    SetRebootFlag true
    Goto WriteEnvStr_done
 
  WriteEnvStr_NT:
      WriteRegExpandStr ${WriteEnvStr_RegKey} $0 $1
      SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} \
        0 "STR:Environment" /TIMEOUT=5000
 
  WriteEnvStr_done:
    Pop $2
    Pop $0
    Pop $1
FunctionEnd

 
# un.DeleteEnvStr - Removes an environment variable
# Note: Win9x systems requires reboot
#
# Example:
#  Push "HOMEDIR"           # name
#  Call un.DeleteEnvStr
Function un.DeleteEnvStr
  Exch $0 ; $0 now has the name of the variable
  Push $1
  Push $2
  Push $3
  Push $4
  Push $5
 
  Call un.IsNT
  Pop $1
  StrCmp $1 1 DeleteEnvStr_NT
    ; Not on NT
    StrCpy $1 $WINDIR 2
    FileOpen $1 "$1\autoexec.bat" r
    GetTempFileName $4
    FileOpen $2 $4 w
    StrCpy $0 "SET $0="
    SetRebootFlag true
 
    DeleteEnvStr_dosLoop:
      FileRead $1 $3
      StrLen $5 $0
      StrCpy $5 $3 $5
      StrCmp $5 $0 DeleteEnvStr_dosLoop
      StrCmp $5 "" DeleteEnvStr_dosLoopEnd
      FileWrite $2 $3
      Goto DeleteEnvStr_dosLoop
 
    DeleteEnvStr_dosLoopEnd:
      FileClose $2
      FileClose $1
      StrCpy $1 $WINDIR 2
      Delete "$1\autoexec.bat"
      CopyFiles /SILENT $4 "$1\autoexec.bat"
      Delete $4
      Goto DeleteEnvStr_done
 
  DeleteEnvStr_NT:
    DeleteRegValue ${WriteEnvStr_RegKey} $0
    SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} \
      0 "STR:Environment" /TIMEOUT=5000
 
  DeleteEnvStr_done:
    Pop $5
    Pop $4
    Pop $3
    Pop $2
    Pop $1
    Pop $0
FunctionEnd
 
!ifndef IsNT_KiCHiK
!define IsNT_KiCHiK
 
;---------------------------------------
 
# [un.]IsNT - Pushes 1 if running on NT, 0 if not
#
# Example:
#   Call IsNT
#   Pop $0
#   StrCmp $0 1 +3
#     MessageBox MB_OK "Not running on NT!"
#     Goto +2
#     MessageBox MB_OK "Running on NT!"
#
!macro IsNT UN
Function ${UN}IsNT
  Push $0
  ReadRegStr $0 HKLM \
    "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
  StrCmp $0 "" 0 IsNT_yes
  ; we are not NT.
  Pop $0
  Push 0
  Return
 
  IsNT_yes:
    ; NT!!!
    Pop $0
    Push 1
FunctionEnd
!macroend
!insertmacro IsNT ""
!insertmacro IsNT "un."
 
!endif ; IsNT_KiCHiK
 
!endif ; _WriteEnvStr_nsh 

; Environment Variable stuff (end)
; ----------------------------------


;Uninstall section
Section Uninstall

   Call un.inst

SectionEnd

; Abstracting Uninstall to a function so it can be called from multiple places
Function un.inst

;  Push GEOSERVER_DATA_DIR
;  Call un.DeleteEnvStr

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAMEANDVERSION}"
	DeleteRegKey HKLM "SOFTWARE\${COMPANYNAME}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"
	
	; Remove service
    nsExec::Exec "$INSTDIR\GeoServer\wrapper\wrapper.exe -r wrapper.conf"

	; Delete Shortcuts
	RMDir /r "$SMPROGRAMS\${APPNAMEANDVERSION}"

	; Clean up
	RMDir /r "$INSTDIR\"

FunctionEnd

; eof
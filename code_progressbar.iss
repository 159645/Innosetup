; Permet d'afficher un "jeton passant" pendant la durée du [run]
; - créer la fonction dans le code
; - penser a ajouter le paramètre "BeforeInstall: progressbar;"


#define MyAppName "progressbar"
#define MyAppVersion "1.0"
#define MyAppPublisher "jet"
#define MyAppURL "http://www.example.com/"
#define MyAppExeName MyAppName

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
;AppId={{E3928140-5441-4974-BE29-4EA1198A07F2}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
CreateAppDir=no
OutputBaseFilename={#MyAppName}
Compression=none
SolidCompression=no
DisableWelcomePage=true
DisableFinishedPage=true
DisableReadyPage=true
CreateUninstallRegKey=no
Uninstallable=no
PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[run]
Filename: "timeout"; Parameters: "20"; Description: "patientez pendant la durée de l'installation ..."; Flags: runhidden; BeforeInstall: progressbar;

[code]
{
  PROCEDURE PROGRESSBAR:
  Permet d'afficher un jeton pendant la durée du [run]
}
Function GetWindowLong(hwnd: hwnd; nIndex: Integer ): longint;
external 'GetWindowLongA@user32.dll stdcall';

Function SetWindowLong(hwnd: longint; nIndex: Integer; dwNewLong: longint): longint;
external 'SetWindowLongA@user32.dll stdcall';

procedure progressbar();
begin
  GetWindowLong(WizardForm.ProgressGauge.handle,-16);
  SetWindowLong(WizardForm.ProgressGauge.handle,-16,GetWindowLong(WizardForm.ProgressGauge.handle,-16)+$8);
  sendmessage(WizardForm.ProgressGauge.handle,1024+10,1,40)
end;

//THE END

; package minimal pas de désinstallation.
#define MyAppName "minimal"
#define MyAppVersion "1.0"

[Setup]
AppName={#MyAppName}
AppVersion={#MyAppVersion}
OutputBaseFilename={#MyAppName}
CreateAppDir=no
DisableWelcomePage=true
DisableFinishedPage=true
DisableReadyPage=true
CreateUninstallRegKey=no
Uninstallable=no
PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

; [Files]
; [registry]

[code]
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then     // Placez ici les scripts de pre installation
  begin
  end;
  
  if CurStep = ssPostInstall then // Placer ici les scripts de post installation
  begin
  end;
end;

//THE END

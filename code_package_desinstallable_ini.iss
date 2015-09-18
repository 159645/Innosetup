#define MyAppName "PROII_retrofit_W7_V100_x86"
#define MyAppVersion "1.0"
#define MyAppPublisher "IFPen"
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "MyProg.exe"
                                                 
; Paramétrage du chemin du dossier d'installation
#define IFP_CHEM_DESINSTALL    "C:\system\Desinstall"
#define IFP_CHEM_DESINSTALL_PKG IFP_CHEM_DESINSTALL+ '\' + MyAppName
                                                 
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
;PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

; le package est désinstallatble mais on ne crée pas de clef de desinstallation
CreateUninstallRegKey=no
Uninstallable=yes
UninstallFilesDir={#IFP_CHEM_DESINSTALL_PKG}

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Files]
; On copie le fichiers correspondant, voir Check dans le code, dans le dossier ou se decompresse le msi.
Source: "sources/Products_installed83.txt"; DestDir: "{%TEMP|c:\Temp}\{{A8E81F69-8F3A-4DB0-96EE-4477568B6792}"; DestName: "Products_installed.txt"; Check: proii83check;
Source: "sources/Products_installed92.txt"; DestDir: "{%TEMP|c:\Temp}\{{A8E81F69-8F3A-4DB0-96EE-4477568B6792}"; DestName: "Products_installed.txt"; Check: proii92check;
Source: "sources/Products_installed8392.txt"; DestDir: "{%TEMP|c:\Temp}\{{A8E81F69-8F3A-4DB0-96EE-4477568B6792}"; DestName: "Products_installed.txt"; Check: proii8392check;

; Copie de tous les fichiers et sous dossiers situés dans le dossier sources/
; au même endroit que le .iss, dans {tmp}
Source: "sources/*"; DestDir: "{tmp}"; Flags: recursesubdirs; 

[Run]
Filename: "{tmp}/ISSetupPrerequisites\{{0BE9572E-8558-404f-B0A5-8C347D145655}/vcredist_x86.exe"; \
Parameters: "/q"; StatusMsg: "Patientez pendant l'installation des prérequis"; BeforeInstall: progressbar;
Filename: "{tmp}/setup.exe"; Parameters: "/S /v/qn"; StatusMsg: "Installation de FNP1111_Retrofit";

[code]
// is appruning
function IsAppRunning(const FileName : string): Boolean;
var
    FSWbemLocator: Variant;
    FWMIService   : Variant;
    FWbemObjectSet: Variant;
begin
    Result := false;
    FSWbemLocator := CreateOleObject('WBEMScripting.SWBEMLocator');
    FWMIService := FSWbemLocator.ConnectServer('', 'root\CIMV2', '', '');
    FWbemObjectSet := FWMIService.ExecQuery(Format('SELECT Name FROM Win32_Process Where Name="%s"',[FileName]));
    Result := (FWbemObjectSet.Count > 0);
    FWbemObjectSet := Unassigned;
    FWMIService := Unassigned;
    FSWbemLocator := Unassigned;
end;

// Progression
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

// Checks, on vérifie quelle version de proii est installé 
// soit la 8.3, soit la 9.2 soit les deux
function proii83check(): Boolean;
begin
    if ( ExpandConstant('{reg:HKLM32\SOFTWARE\SIMSCI\PRO/II\8.3,INSTALLDIR|none}') <> 'none' ) and 
       ( ExpandConstant('{reg:HKLM32\SOFTWARE\SIMSCI\PRO/II\9.2,INSTALLDIR|none}') = 'none' ) then begin
      Result := True;
      Exit;
    end;
    Result := False;
end;

Function proii92check(): Boolean;
begin
    if ( ExpandConstant('{reg:HKLM32\SOFTWARE\SIMSCI\PRO/II\8.3,INSTALLDIR|none}') = 'none' ) and 
       ( ExpandConstant('{reg:HKLM32\SOFTWARE\SIMSCI\PRO/II\9.2,INSTALLDIR|none}') <> 'none' ) then begin
      Result := True;
      Exit;
    end;
    Result := False;
end;

function proii8392check(): Boolean;
begin
    if ( ExpandConstant('{reg:HKLM32\SOFTWARE\SIMSCI\PRO/II\8.3,INSTALLDIR|none}') <> 'none' ) and
       ( ExpandConstant('{reg:HKLM32\SOFTWARE\SIMSCI\PRO/II\9.2,INSTALLDIR|none}') <> 'none' ) then begin
      Result := True;
      Exit;
    end;
    Result := False;
end;

procedure modini(fliste: TArrayOfString);
var
  i : Integer;
  securityType: String;
begin
  // FLXLM95
  for i := 0 to GetArrayLength(fliste)-1 do
  begin
    securityType := GetIniString('wss_Security', 'Type', 'none', fliste[i]);
    // MsgBox(Format('%s %s', [ fliste[i], securityType ]) , mbInformation, MB_OK);
    if securityType = 'FNP1111' then begin
      SetIniString('wss_Security', 'Type', 'FLXLM95', fliste[i]); 
    end;
  end;
end;


//////////////////////////////////////////////////////////////////////////////////////////
///
///   DESINSTALLATION DU PACKAGE
///
//////////////////////////////////////////////////////////////////////////////////////////
             

// Initialisation de l'installation
function InitializeSetup: Boolean;
begin
    while IsAppRunning('PROII.exe') do
    begin

    // On verifie si l'application est en cours d'utilisation
    if MsgBox('PROII est en cours d’utilisation. Veuillez fermer l''application et cliquer sur « Recommencer ».',  mbError, MB_RETRYCANCEL) = IDCANCEL then begin
           // On quitte l'installation
           Result := False;
           Exit;
        end;
    end;

    // création du dossier ou sera placé la désinstallation du package
    // Preciser UninstallFilesDir={#IFP_CHEM_DESINSTALL_PKG}
    // dans la section [setup]
    CreateDir(ExpandConstant('{#IFP_CHEM_DESINSTALL_PKG}'));
    Result := True;
end;


//////////////////////////////////////////////////////////////////////////////////////////
///
///   DESINSTALLATION DU PACKAGE
///
//////////////////////////////////////////////////////////////////////////////////////////

// Initialisation de la désinstallation.
function InitializeUninstall: Boolean;
begin
  while IsAppRunning('PROII.exe') do
    begin
       if MsgBox('PROII est en cours d’utilisation. Veuillez fermer l''application et cliquer sur « Recommencer ».',  mbError, MB_RETRYCANCEL) = IDCANCEL then begin
           // On quitte l'installation
           Result := False;
           Exit;
        end;
    end;
    Result := True;
end;

// Etapes des desinstallation
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
  listeini: TArrayOfString;
begin
  if CurUninstallStep = usPostUninstall then            // %POST DESINSTALLATION //
  begin
    listeini := [ Expandconstant('{pf32}\SIMSCI\V 8.3\PROII83\User\proii.ini') ];
    modini(listeini)
    
    // Suppression du dossier de désinstallation
    RemoveDir('{#IFP_CHEM_DESINSTALL_PKG}'); 
  end;
end;


//THE END

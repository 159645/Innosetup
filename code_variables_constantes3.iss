#define MyAppName "constantes3"
#define MyAppVersion "1.0"
#define MyAppPublisher "jet"
#define MyAppURL "http://www.example.com/"

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

[code]
var
  mondessert : String;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then begin

  // rappel on peut utiliser les constantes dans toutes les sections du setup

  // Lire le contenu d'une variable d'environnement
  // {%NAME|DefaultValue}
  MsgBox('Contenu de la variable d''environnement OS : ' + ExpandConstant('{%OS}'), mbInformation, MB_OK);
  MsgBox('Contenu de la variable d''environnement TEMP : ' + ExpandConstant('{%TEMP}'), mbInformation, MB_OK);
  MsgBox('Contenu de la variable d''environnement ? : ' + ExpandConstant('{%?|inconnue}'), mbInformation, MB_OK);

  // Extraire la lettre de lecteur d'un fichier ou le chemin UAC si placé sur une zone réseau
  // {drive:Path}
  MsgBox('cet executable est placé sur :' + ExpandConstant('{drive:{src}}'), mbInformation, MB_OK);

  // lire une valeur depuis un fichier ini
  // {ini:Filename,Section,Key|DefaultValue}
   MsgBox('Valeur de la clef "CurrentLanguage", de la section "Intel", du fichier c:\windows\win.ini ' + ExpandConstant('{ini:{win}\win.ini,Intel,CurrentLanguage|none}'),
           mbInformation, MB_OK);

  // Lire une valeur depuis le registre
  // {reg:HKxx\SubkeyName,ValueName|DefaultValue}
  MsgBox('Windows current version : ' + ExpandConstant('{reg:HKLM32\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion,CurrentVersion}'),
          mbInformation, MB_OK);

   // Lire un paramètre passé sur la ligne de commande
   // {param:ParamName|DefaultValue}

   // ci dessous si on a passé le paramètre /desert=yahourt au setup
   // mondessert vaudra 'yahourt' sinon 'aucun'
   mondessert := ExpandConstant('{param:dessert|aucun}');
  end;
end;

//THE END

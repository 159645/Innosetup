; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "constantes"
#define MyAppVersion "1.0"
#define MyAppPublisher "jet"
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "constantes.exe"

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
procedure CurStepChanged(CurStep: TSetupStep);
var
 // declaration d'un tableau de chaines
 constantes: TArrayOfString;
 // decalration du compteur
 i : Integer;

begin
  if CurStep = ssPostInstall then                       // %POST INSTALLATION //
  begin
     // voir dans l'aide innosetup pour toutes les variables
      constantes := [ '{app}', \
                      '{win}', \
                      '{sys}', \
                      '{syswow64}', \
                      '{src}', \
                      '{sd}', \
                      '{pf}', \
                      '{pf32}', \
                      '{pf64}', \
                      '{cf}', \
                      '{cf32}', \
                      '{cf64}', \
                      '{tmp}', \
                      '{fonts}' ];

      // parcours du tableau
      for i := 0 to GetArrayLength(constantes)-1 do
      begin
         // Pour connaitre la valeur d'une constante dans le code il faut utiliser la fonction
         // ExpandConstant('{constante}')
         SuppressibleMsgBox(Format('%s : %s', [constantes[i], ExpandConstant(constantes[i])]) , mbInformation, MB_OK, MB_OK);
      end; 
  end;
end;

//THE END

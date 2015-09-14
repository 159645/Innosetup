#define MyAppName "path"
#define MyAppVersion "1.0"
#define MyAppPublisher "jet"
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "path.exe"

; On peut définir des variables dans la partie préprocesseur
#define monchemin "c:\monappli"


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
; Par defaut lorsque le package de désinstallation
; sera déposé dans c:\Windows\unins000.exe ... 
PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

; On ajoute une section [Registry]
; On peut lire et ecrire directement la valeur d'une clef a ce niveau
; On verifie si le path contient deja la valeur a ajouter
[Registry]
Root: HKLM; \
SubKey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment\"; \
ValueType: expandsz; \
ValueName: "Path"; \
ValueData: "{reg:HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\,Path};{#monchemin}"; \
Check: existdeja;

[code]
// Check pour vérifier si la ligne doit être executée, on veut eviter
// de rajouter plusieurs fois le chemin dans le path
function existdeja(): Boolean;
var
   path : String;
   trouve : Integer;
begin
   // recupere PATH dans path
   RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment\', 'Path', path)
   // la fonction Pos cherche une sous chaine dans une chaine, retourne 0 si non trouvé
   trouve := Pos(Expandconstant('{#monchemin}'),path)

   if ( trouve = 0) then begin
      Result := True;
   end
   else begin 
      Result := False;
   end;
end;


//////////////////////////////////////////////////////////////////////////////////////////////
// Procedure d'évenement "CurUninstallStepChanged", qui est apelée pendant la desinstallation
// du package, on va supprimmer le chemin ajouté a PATH pendant l'installation
//////////////////////////////////////////////////////////////////////////////////////////////
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
var
   index : Integer; // contiendra la position du chemin dans le PATH
   newpath : String; // la nouvelle valeur sans le chemin 

begin
  if CurUninstallStep = usPostUninstall then            // %POST DESINSTALLATION //
  begin
      // On récupere la valeur du PATH dans la variable newpath
      if RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment\', 'Path', newpath) then
      begin
         // on recupere l'index (début) de notre chemin dans la variable newpath 
         Index := Pos(Expandconstant('{#monchemin}'), newpath)
         // on supprimme la plage dans la variable newpath  
         Delete(newpath, Index-1, Length(Expandconstant('{#monchemin}'))+1);
         // on ecrase la contenu de la clef par sa nouvelle valeur
         RegWriteExpandStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment\','Path', newpath);
      end;
  end;
end;

//THE END

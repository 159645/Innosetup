#define MyAppName "page_de_choix_multiple"
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
SetupLogging=yes
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[code]
{
  On va ajouter une nouvelle page au setup
  avec un choix multiple de différents desserts

  La variable mondessert contiendra le dessert selectionné

  Il est possible de préciser un desert sur la ligne de commande 
  si on installe le package en mode silencieux.

  ex:

  cmd> page_de_choix_multiple.exe /VERYSILENT /NORESTART /dessert=banane

}
var
    mondessert : String; // variable qui servira a récuperer le choix
    Selection_dessert_page: TInputOptionWizardPage; // La nouvelle page


procedure InitializeWizard();
begin
  { Creation de la page

   On utilise une page déja prête a l'emploi "CreateInputOptionPage" 
   function CreateInputOptionPage(const AfterID: Integer; const ACaption, ADescription, ASubCaption: String; Exclusive, ListBox: Boolean): TInputOptionWizardPage;

   AfterID (Integer): ce paramètre indique après quelle page du setup notre page doit apparaitre
   const ACaption, ADescription, ASubCaption (String): descriptions diverses
   Exclusive, ListBox (Boolean): Le parametre Exclusive a False on a des cases a cocher, True une radio box
  }  
  Selection_dessert_page := CreateInputOptionPage(wpWelcome, 'Choix du dessert', \
                                                             'Les desserts suivants sont compris dans le menu', \
                                                             'Sélectionnez votre dessert, puis cliquez sur Suivant.', \
                                                              True, True);
  { ajout des possibilités de choix } 
  Selection_dessert_page.Add('aucun');
  Selection_dessert_page.Add('yahourt');
  Selection_dessert_page.Add('banane');
  Selection_dessert_page.Add('glace');
  Selection_dessert_page.Add('crêpe');
  Selection_dessert_page.Add('tarte');
 
  { Selection de la valeur par default }
  Selection_dessert_page.Values[0] := False;
  Selection_dessert_page.Values[1] := False;
  Selection_dessert_page.Values[2] := False;
  Selection_dessert_page.Values[3] := True;
  Selection_dessert_page.Values[4] := False;
  Selection_dessert_page.Values[5] := False;
end;

{ la fonction NextButtonClick va permettre de récuperer le choix }
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  // si la page courante est notre page on recupere l'option choisie
  if CurPageID = Selection_dessert_page.ID then begin
     if Selection_dessert_page.Values[0] then mondessert := 'aucun';
     if Selection_dessert_page.Values[1] then mondessert := 'yahourt';
     if Selection_dessert_page.Values[2] then mondessert := 'banane';
     if Selection_dessert_page.Values[3] then mondessert := 'glace';
     if Selection_dessert_page.Values[4] then mondessert := 'crêpe';
     if Selection_dessert_page.Values[5] then mondessert := 'tarte';
  end;
  Result := True;
end;


procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then                       // %POST INSTALLATION //
  begin

   // Si le setup est lancé en mode silencieux on recupère l'info sur la ligne de commande
   // /dessert=banane
   if WizardSilent then begin
      // si on oublie de spécifier le paramètre et ben on a pas de dessert.
      mondessert :=  ExpandConstant('{param:dessert|''aucun''}');
   end;

   case mondessert of
      'aucun':
        MsgBox('Vraiment, pas de dessert ?', mbInformation, MB_OK);
      'yahourt':
        MsgBox('Yahourt, excellent choix !', mbInformation, MB_OK);
      'banane':
        MsgBox('Banane, excellent choix !', mbInformation, MB_OK);
      'glace':
        MsgBox('Glace, excellent choix !', mbInformation, MB_OK);
      'crêpe':
        MsgBox('Crêpe, excellent choix !', mbInformation, MB_OK);
      'tarte':
        MsgBox('Tarte, excellent choix !', mbInformation, MB_OK);
    end;

    Log('le dessert choisit est ' + mondessert);

  end;
end;

//THE END

#define MyAppName "etapes"
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
DisableWelcomePage=false
DisableFinishedPage=false
DisableReadyPage=false
CreateUninstallRegKey=no
Uninstallable=no
PrivilegesRequired=lowest
UserInfoPage=yes
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[code]
/// Pendant le déroulement de l'installation InnoSetup apelle une succession d'étapes
/// dans un ordre définit. On est libre d'intervenir a chaque étapes pour modifier le
/// comportement de l'installation.

/////////////////////////////////////////////////////////////////////////////////////////
/// 
///  FONCTIONS APPELEE PENDANT LA PROCEDURE D'INSTALLATION
///  dans l'ordre d'appel
///                  
/////////////////////////////////////////////////////////////////////////////////////////


{
  InitializeSetup :
  - Premiere fonction apellée par le setup.
  - Permet de faire ici des tests préléminaires, pour determiner si le package
    est installable sur le système. Ex: espace disque, architecture

}
function InitializeSetup: Boolean;
begin
    MsgBox('Appel de l''étape InitializeSetup', mbInformation, MB_OK);
    // Le retour de cette fonction est très important, un retour "False" provoquera
    // l'arrêt de l'installation du package et celuici retournera "1"
    // Aucune interface ne sera affichée.
    // Result := False;
    Result := True;
end;


{
  InitializeWizard :
  - fonction apellée après InitializeSetup, elle initialise 
    l'interface du setup. C'est ici qu'on pourra créer nos pages
    personnalisée.
}
procedure InitializeWizard();
begin 
    MsgBox('Appel de l''étape InitializeWizard', mbInformation, MB_OK);
    // On peut désactiver l'affichage de certaines pages directement dans la section
    // [Setup], ex: DisableFinishedPage=true
    // On peut créer des nouvelles pages ici
end;


{
  CurStepChanged : 
  - Procedure qui permet d'efectuer des tâches en 
    - pre installation "ssInstall"
    - post installation "ssPostInstall"
    - done installation (a partir du momment ou on clique ok
                         sur la page de fin) "ssDone"
}
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then                 // %PRE INSTALLATION //
  begin
    MsgBox(Format('Appel de l''étape ssInstall, CurStep=%d, démarrage des scripts de pre installation', [CurStep] ), \
                   mbInformation, MB_OK);

    // il est encore possible de faire échoer l'installationa ce niveau
    // si une condition n'est pas remplie, grace a la fonction abort()
    // le code retour du package sera alors 3

    // abort();
  end;
  
  if CurStep = ssPostInstall then            // %POST INSTALLATION //
  begin
    MsgBox(Format('Appel de l''étape ssPostInstall, CurStep=%d, démarrage des scripts de post installation', [CurStep] ), \
                   mbInformation, MB_OK);
  end;

  if CurStep = ssDone then                   // %POST-POST INSTALLATION // 
  begin
    MsgBox(Format('Appel de l''étape ssDone, CurStep=%d, démarrage des scripts de done installation', [CurStep] ), \
                   mbInformation, MB_OK);
    // on peut ici copier le fichier de log par exemple car a cette étape plus rien n'y sera inscrit
  end;
end;


{
  DeinitializeSetup : 
  - Dernière fonction apellée par le setup,
    elle est appelée même si le setup echoue. 
}
procedure DeinitializeSetup;
begin
    MsgBox('Appel de l''étape DeinitializeSetup', mbInformation, MB_OK);
    // C'est une procedure donc contrairement a une fonction
    // elle n'est pas sensée renvoyer qqchose
    // elle sera appelée même si Initializesetup echoue
end;


/////////////////////////////////////////////////////////////////////////////////////////
/// 
///  FONCTIONS APPELEE PENDANT LA PROCEDURE DE DESINSTALLATION
///  dans l'ordre d'appel
///                  
///  - La construction du package de désinstallation se fait en meme temps
///  que la compilation du package (si le paramètre "Uninstallable=yes" est
///  spécifié dans la section[setup]).Par défaut lors de l'installation du 
///  package, le package de désinstallation est copié dans "c:\windows\unins000.exe".
///  
///  - La section [UninstallRun] permet de spécifier a executable a lancer lors de la
///    désinstallation
///  
///  - Les fonctions ci-dessous permettent de créer des scripts de désinstallation
///    elles sont a l'image des fonctions evenement de l'installation. 
/////////////////////////////////////////////////////////////////////////////////////////


{
  InitializeUninstall :
  Fonction apellée avant la désinstallation:
 - On supprimme le fichier de Log
 - On upprimme la clef dans PKGIFP
}
function InitializeUninstall(): Boolean;
begin
  MsgBox('Appel de l''étape InitializeUninstall', mbInformation, MB_OK);
  Result := True;
end;


{
 CurUninstallStepChanged :
 fonction apellée pendant la désinstallation
 - usAppMutexCheck
 - usUninstall
 - usPostUninstall
 - usDone
}
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then              // %PRE DESINSTALLATION //
  begin
    // Scripts de %pre désinstallation 

  end;

  if CurUninstallStep = usPostUninstall then            // %POST DESINSTALLATION //
  begin
    // Scripts de %post Desinstallation

  end;

  if CurUninstallStep = usDone then                     // %POST %POST DESINSTALLATION //
  begin
    // Scripts de %post %post Désinstallation

  end;
end;


{
  DeinitializeUninstall : 
  - Dernière fonction apellée par la désinstallation,
    elle est appelée dans tous les cas. 
}
procedure DeinitializeUninstall();
begin
    MsgBox('Appel de l''étape DeinitializeUninstall', mbInformation, MB_OK);
end;


////////////////////////////////////////////////////////////////////////////////
/// FONCTIONS ET PROCEDURES POUR INTERAGIR AVEC LE SETUP
/// 
////////////////////////////////////////////////////////////////////////////////


{
  CurPageChanged :
  Procedure qui intervient au chargement d'une page du setup
  A chaque changement de page la fonction est apelée avec l'id 
  de la page a afficher
}
procedure CurPageChanged(CurPageID: Integer);
var
  pages: array of Integer;
  i: Integer;
begin
  // ci dessous la liste de toutes les pages disponibles dans un setup correspond a des entiers 
  pages := [ wpWelcome, wpLicense, wpPassword, wpInfoBefore, wpUserInfo, wpSelectDir, wpSelectComponents, \
             wpSelectProgramGroup, wpSelectTasks, wpReady, wpPreparing, wpInstalling, wpInfoAfter, wpFinished ];

  for i := 0 to GetArrayLength(pages)-1 do begin
     if CurPageID = pages[i] then
     begin
        MsgBox(Format('la page ID n° %d est apelée', [pages[i]]), mbConfirmation, MB_OK);
        break;
     end;
  end;
end;


{
  NextButtonClick :
  function qui intervient a chaque click sur le bouton suivant
}
function NextButtonClick(CurPageID: Integer): Boolean;
begin
   MsgBox('Bouton suivant cliqué sur la page ' + IntToStr(CurPageID), mbError, MB_OK);

   // si la fonction renvoie vrai l'installation passe a
   // la page suivante.
   // Si on retourne False l'installation reste sur la page
   // courante CurPageID
   Result := True;
end;


{
  BackButtonClick : 
  function qui intervient a chaque click sur le bouton precedent
}
function BackButtonClick(CurPageID: Integer): Boolean;
begin
   MsgBox('Bouton precedent cliqué sur la page ' + IntToStr(CurPageID), mbError, MB_OK);

   // On veut desactiver le retour sur la page 10 wpReady
   if CurPageID = wpReady then begin
      MsgBox('Désolé mais il est trop tard pour revenir en arrière', mbCriticalError, MB_OK);
      Result := False;
      Exit;
   end;
   Result := True;
end;


{
  CancelButtonClick :
  procedure appelée lorsque l'on clique sur le bouton cancel
}
procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
   // Desactive le message de confirmation 
   // Confirm := False;
   MsgBox('Le bouton cancel a été cliqué', mbCriticalError, MB_OK);
   // DeinitializeSetup sera appelé avant de quitter
end;


{
  ShouldSkipPage:
  la fonction ShouldSkipPage permet de désactiver l'affichage
  d'une page du setup suivant les evenements. Avant chaque
  changement de page la fonction est appelée si elle retourne True
  la page ne sera pas affichée "skippée" ?
}
function ShouldSkipPage(PageID: Integer): Boolean;
var 
   SkipPageFin: Boolean;
begin
  // par exemple si on ne veut pas afficher la derniere page du setup
  // SkipPageFin := True;
  SkipPageFin := False;

  MsgBox('Fonction ShouldSkipPage appelée', mbCriticalError, MB_OK);
  if SkipPageFin then begin
    case PageID of
      wpFinished:
        Result := True;
    else
      Result := False;
    end;
  end;
end;


{
  NeedRestart:
  On doit redémarrer a la fin du package
}
function NeedRestart(): Boolean;
begin
   // Provoque l'affichage d'une page supplémentaire
   // (Ou plutot une modification de la page de fin)
   // voulez-vous redémarrer tout de suite ou plus tard etc ...
   // suivant les package Innosetup peut déterminer lui même
   // si le package a besoin de redémarrer..
   Result := True;
   // Result := False;
end;


{ 
  UninstallNeedRestart:
  - retourne True pour indiquer si l'utilisateur est
  invité a redémarrer apreès la désinstallation.
}
function UninstallNeedRestart(): Boolean;
begin
  Result := False;
end;


{
  CheckPassword:
  fonction qui permet d'ajouter un mot de passe
  si la fonction est présente dans le code la page est automatiquement
  ajoutée.
}
function CheckPassword(Password: String): Boolean;
var
   secret: String;
begin
    // secret := GetSHA1OfString('secret')
    // MsgBox('le password est : ' + secret, mbCriticalError, MB_OK);

   // pour protéger le password comparez les hash le password saisi
   // est stocké dans la variable Password
   if GetSHA1OfString(Password) = 'e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4' then begin
      // le password est accepté
      Result := True;
      Exit;
   end;
   // le password est rejeté
   Result := False;
end;


{
  UpdateReadyMemo:
  function qui va permettre d'ajouter un texte a la page ready (dernière page avant l'installation)
  par ailleur on peut changer par d'autre biais ces textes et de toutes les pages.
}
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
begin
   NewLine := '@';
   Result := 'Super package qui ne fait absolument rien.@ Merci pour votre comprehension et bonne journée.'
end;


{
  CheckSerial:
  Si cette fonction est indiquée dans le code, et "UserInfoPage=yes"
  spécifié dans la section [setup]. Une page pour spécifier un numéro
  de série est affichée. Retourne True si le serial est validé
}
function CheckSerial(Serial: String): Boolean;
begin
  // le bouton suivant restera inactif tant que le serial ne sera pas correctement
  // renseigné.
  // Comme il n'y a pas de cryptage et que les sources de Innosetup
  // sont ouvertes, ce n'est pas très sécurisé.
  if ExpandConstant('{userinfoserial}') = 'abcd-efgh-ijkl' then begin
    Result := True;
    Exit
  end;
  Result := False;
end;


{
  PrepareToInstall:
  peut déterminer si les fichiers inclus dans le package sont en cours 
  d'utilisation par une application... voir l'aide
}
function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
end;


{
  GetCustomSetupExitCode:
  Permet de renvoyer un code retour différent de 0
  donc uniquement quand le package se termine correctement.
}
function GetCustomSetupExitCode: Integer;
begin
  // le package retournera 12 au lieu de 0
  Result := 12;
end;

// Voir l'aide de l'application pour une liste plus complète.
//THE END

#define MyAppName "exemple_dirs"
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
Uninstallable=yes
PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Dirs]
; Créer des répertoires et sous-répertoires dans le système de fichier.
; A noter que dans la section [Files], si on ajoute un fichier les répertoires
; intermédiaires sont automatiquement crées si innexistants. Par contre on a pas 
; vraiment de controle dessus.
; Mieux vaut créer les répertoires vides puis dans un second temps les fichiers.

; création d'un simple répertoire dans programfiles(x86), le dossier sera supprimmé a la désinstallation
; si vide
Name: "{pf32}\monProgramme"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Attributs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; spécifier des attribut, si le dossier existe déja les attributs sont mergés avec ceux existants.
; les attributs sont :
; readonly : les fichiers contenus dans le dossier seront en lecture seule
; hidden : création d'un dossier caché
; system : création d'un dossier système
Name: "{pf32}\monProgramme"; Attribs: readonly;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Permissions
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Permissions <user or group identifier>-<access type>
; full : controle totale pour le groupe indiqué (c-a-d mêmes droits que modify mais en plus possibilité de s'approprier le dossier et changer les permissions)
; modify: droit d'executer, créer, modifier et supprimmer les fichiers dans le dossier et sous dossiers.
; readexec: lecture, execution
Name: "{pf32}\monProgramme"; Permissions: users-modify;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Flags
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; permet de créer une sorte de dossier temporaire le temps de l'installation
; sera supprimmé seulement si il est vide
Name: "{pf32}\monProgramme"; Flags: deleteafterinstall;

; indique au setup de toujours essayer de détruire le dossier a la désinsatllation
; c-a-d essayer même si le dossier était déja présent avant l'installation.
; toujours si il est vide.
Name: "{pf32}\monProgramme"; Flags: uninsalwaysuninstall;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;   Check
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; On peut aussi emettre des conditions par exemple ici ne créer ce dossier uniquement
; si le compte qui a lancé le package est membre du groupe admin local
Name: "{pf32}\monProgramme"; Attribs: readonly; Check: IsAdminLoggedOn;


//THE END

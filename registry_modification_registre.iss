#define MyAppName "registre"
#define MyAppVersion "1.0"
#define MyAppPublisher "jet"
#define MyAppURL "http://www.example.com/"
#define MyAppExeName "MyProg.exe"

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

[Registry]
; Ajout de clef/valeurs dans le registre.
; Par defaut les clef crées ne sont pas supprimées à la désinstallation du package.
;
; HKCR (HKEY_CLASSES_ROOT) 
; HKCU (HKEY_CURRENT_USER)
; HKLM (HKEY_LOCAL_MACHINE) 
; HKU  (HKEY_USERS) 
; HKCC (HKEY_CURRENT_CONFIG) 
;
; Sur un système 64bit on peut faire la différence entre la vue du registre 32-bit
; ou la vue 64-bit
;
; pour un package 32-bit sur un système 64-bit: 
;     HKLM\SOFTWARE = HKLM32\SOFTWARE = HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node
;     HKLM64\SOFTWARE = HKEY_LOCAL_MACHINE\SOFTWARE
;
; pour un package 64-bit:
;     HKLM\SOFTWARE = HKLM64\SOFTWARE = HKEY_LOCAL_MACHINE\SOFTWARE
;     HKLM32\SOFTWARE = HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node  



; lorsque l'on crée des valeurs les sousclefs sont crées automatiquement si non existantes
; (sauf si le Flag:dontcreatekey est explicitement indiqué). Dans un premier temps il vaut 
; mieux créer les clefs pour pouvoir ensuite désinstaller proprement ou appliquer les droits a la racine.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;         Creer des clefs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; va créer la clef HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\My Company et supprimmera la 
; clef à la désinstallation si elle est vide.
Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty;
Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekeyifempty;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;         Permissions
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; donne un acces total a la clef et toutes les sous-clef au groupe utilisateurs
Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty; Permissions: users-full;

; modify est dans la plupart des cas plus approprié
Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty; Permissions: users-modify;

; droits seulement en lecture
Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty; Permissions: users-read;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;         Creer des valeurs
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Les différents types de valeurs que l'on peut utiliser:
; none      : création de la clef mais pas de la valeurs (paramètres ignorés)
; string
; expandsz
; multisz
; dword
; qword
; binary

; ValueType: string indique le type de valeur a créer, ValueName: "InstallPath" son nom et ValueData: "{app}" son contenu 
Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletevalue; 

; pout modifier la valeur (par défaut) d'une clef ValueName: ""
Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: ""; ValueData: "test"; Flags: uninsdeletevalue;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;         Ajout conditionnel
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; On peut utiliser un Check pour les la création des clefs ici l'ajout se fera uniquement si l'os est 64-bit 'Check: isWin64;'
; ou comme d'habitude utiliser une fonction du code pour déterminer la condition
Root: HKLM; SubKey: SYSTEM\CurrentControlSet\services\LanmanServer\Parameters; ValueType: dword; ValueName: Size; ValueData: 3; Check: isWin64;
                                                                                        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;         Ajout depuis un .reg
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; NOTE pour ajouter un nombre elevé de clef/valeurs on peut importer un .reg dans le logiciel "istools"
Root: HKCU; SubKey: Software\PDFCreator\Ghostscript; ValueType: string; ValueName: DirectoryGhostscriptBinaries; ValueData: C:\Program Files (x86)\gs\gs9.00\bin\
Root: HKCU; SubKey: Software\PDFCreator\Ghostscript; ValueType: string; ValueName: DirectoryGhostscriptFonts; ValueData: C:\Program Files (x86)\gs\fonts
Root: HKCU; SubKey: Software\PDFCreator\Ghostscript; ValueType: string; ValueName: DirectoryGhostscriptLibraries; ValueData: C:\Program Files (x86)\gs\gs9.00\lib
Root: HKCU; SubKey: Software\PDFCreator\Ghostscript; ValueType: string; ValueName: DirectoryGhostscriptResource; ValueData: C:\Program Files (x86)\gs\gs9.00\Resource
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: Counter; ValueData: 3
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: DeviceHeightPoints; ValueData: 842
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: DeviceWidthPoints; ValueData: 595
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: OnePagePerFile; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: Papersize; ValueData: a4
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StampFontColor; ValueData: #FF0000
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StampFontname; ValueData: Arial
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StampFontsize; ValueData: 48
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StampOutlineFontthickness; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StampString; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StampUseOutlineFont; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardAuthor; ValueData: <Username>
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardCreationdate; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardDateformat; ValueData: YYYYMMDDHHNNSS
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardKeywords; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardMailDomain; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardModifydate; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardSaveformat; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardSubject; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: StandardTitle; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: UseCreationDateNow; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: UseCustomPaperSize; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: UseFixPapersize; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing; ValueType: string; ValueName: UseStandardAuthor; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: BMPColorscount; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: BMPResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: JPEGColorscount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: JPEGQuality; ValueData: 75
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: JPEGResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PCLColorsCount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PCLResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PCXColorscount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PCXResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PNGColorscount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PNGResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PSDColorsCount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: PSDResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: RAWColorsCount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: RAWResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: TIFFColorscount; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\Bitmap\Colors; ValueType: string; ValueName: TIFFResolution; ValueData: 150
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Colors; ValueType: string; ValueName: PDFColorsCMYKToRGB; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Colors; ValueType: string; ValueName: PDFColorsColorModel; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Colors; ValueType: string; ValueName: PDFColorsPreserveHalftone; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Colors; ValueType: string; ValueName: PDFColorsPreserveOverprint; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Colors; ValueType: string; ValueName: PDFColorsPreserveTransfer; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompression; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompressionChoice; ValueData: 3
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompressionJPEGHighFactor; ValueData: 0.9
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompressionJPEGLowFactor; ValueData: 0.25
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompressionJPEGMaximumFactor; ValueData: 2
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompressionJPEGMediumFactor; ValueData: 0.5
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorCompressionJPEGMinimumFactor; ValueData: 0.1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorResample; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorResampleChoice; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionColorResolution; ValueData: 300
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompression; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompressionChoice; ValueData: 3
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompressionJPEGHighFactor; ValueData: 0.9
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompressionJPEGLowFactor; ValueData: 0.25
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompressionJPEGMaximumFactor; ValueData: 2
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompressionJPEGMediumFactor; ValueData: 0.5
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyCompressionJPEGMinimumFactor; ValueData: 0.1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyResample; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyResampleChoice; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionGreyResolution; ValueData: 300
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionMonoCompression; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionMonoCompressionChoice; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionMonoResample; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionMonoResampleChoice; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionMonoResolution; ValueData: 1200
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Compression; ValueType: string; ValueName: PDFCompressionTextCompression; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Fonts; ValueType: string; ValueName: PDFFontsEmbedAll; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Fonts; ValueType: string; ValueName: PDFFontsSubSetFonts; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Fonts; ValueType: string; ValueName: PDFFontsSubSetFontsPercent; ValueData: 100
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFGeneralASCII85; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFGeneralAutorotate; ValueData: 2
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFGeneralCompatibility; ValueData: 3
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFGeneralDefault; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFGeneralOverprint; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFGeneralResolution; ValueData: 600
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFOptimize; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\General; ValueType: string; ValueName: PDFUpdateMetadata; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFAllowAssembly; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFAllowDegradedPrinting; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFAllowFillIn; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFAllowScreenReaders; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFDisallowCopy; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFDisallowModifyAnnotations; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFDisallowModifyContents; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFDisallowPrinting; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFEncryptor; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFHighEncryption; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFLowEncryption; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFOwnerPass; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFOwnerPasswordString; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFUserPass; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFUserPasswordString; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Security; ValueType: string; ValueName: PDFUseSecurity; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningMultiSignature; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningPFXFile; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningPFXFilePassword; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureContact; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureLeftX; ValueData: 100
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureLeftY; ValueData: 100
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureLocation; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureReason; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureRightX; ValueData: 200
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureRightY; ValueData: 200
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignatureVisible; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PDF\Signing; ValueType: string; ValueName: PDFSigningSignPDF; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PS\LanguageLevel; ValueType: string; ValueName: EPSLanguageLevel; ValueData: 2
Root: HKCU; SubKey: Software\PDFCreator\Printing\Formats\PS\LanguageLevel; ValueType: string; ValueName: PSLanguageLevel; ValueData: 2
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AutosaveDirectory; ValueData: <MyFiles>\<username>\
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: LastsaveDirectory; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: Language; ValueData: french
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrinterTemppath; ValueData: %Temp%
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AdditionalGhostscriptParameters; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AdditionalGhostscriptSearchpath; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AddWindowsFontpath; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AutosaveFilename; ValueData: <DateTime>
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AutosaveFormat; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: AutosaveStartStandardProgram; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: ClientComputerResolveIPAddress; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: DisableEmail; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: DontUseDocumentSettings; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: FilenameSubstitutions; ValueData: Microsoft Word - |\.docx|\.doc|\Microsoft Excel - |\.xlsx|\.xls|\Microsoft PowerPoint - |\.pptx|\.ppt|
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: FilenameSubstitutionsOnlyInTitle; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: Logging; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: LogLines; ValueData: 100
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: NoConfirmMessageSwitchingDefaultprinter; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: NoProcessingAtStartup; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: NoPSCheck; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: OptionsDesign; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: OptionsEnabled; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: OptionsVisible; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrintAfterSaving; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrintAfterSavingDuplex; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrintAfterSavingNoCancel; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrintAfterSavingPrinter; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrintAfterSavingQueryUser; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrintAfterSavingTumble; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: PrinterStop; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: ProcessPriority; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: ProgramFont; ValueData: MS Sans Serif
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: ProgramFontCharset; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: ProgramFontSize; ValueData: 8
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RemoveAllKnownFileExtensions; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RemoveSpaces; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramAfterSaving; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramAfterSavingProgramname; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramAfterSavingProgramParameters; ValueData: "<OutputFilename>"
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramAfterSavingWaitUntilReady; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramAfterSavingWindowstyle; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramBeforeSaving; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramBeforeSavingProgramname; ValueData: 
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramBeforeSavingProgramParameters; ValueData: "<TempFilename>"
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: RunProgramBeforeSavingWindowstyle; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: SaveFilename; ValueData: <Title>
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: SendEmailAfterAutoSaving; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: SendMailMethod; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: ShowAnimation; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: StartStandardProgram; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: Toolbars; ValueData: 1
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: UseAutosave; ValueData: 0
Root: HKCU; SubKey: Software\PDFCreator\Program; ValueType: string; ValueName: UseAutosaveDirectory; ValueData: 1

//THE END


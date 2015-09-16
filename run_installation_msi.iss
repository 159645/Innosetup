; Dans l'exemple ci-dessous on installe les sources a partir de {tmp},
; qui correspond au dossier temporaire du système par exemple "c:\temp"
; le package va dans un premier temps extraire les sources dans 
; c:\temp\<dossier_temporaire> puis executer chaque ligne du [run], 
; puis supprimmer de lui même le dossier temporaire.

; par exemple dans la section Files on pourrait avoir ceci 
; Sources\* : on placera tous les executables dans un dossier Source au même
; niveau que le fichier iss.
; DestDir dans {tmp}
; le flags recursesubdirs indique de copier les répertoires et sous-repertoires
; BeforeInstall et AfterInstall font référence a des fonctions du code executée
; avant et apres l'installation des fichiers.
[Files]
Source: "Sources\*"; DestDir: {tmp}; Flags: recursesubdirs; \
BeforeInstall: AvantCopiedessources; \
AfterInstall: ApresCopiedessources;


[Run]
;;; INstallation des prérequis
; Installation de .exe
Filename: {tmp}\Microsoft .NET Framework 4 Setup\dotNetFx40_Full_x86_x64.exe; \
Parameters: /q /norestart; StatusMsg: Installation du prérequis (.Net 4.0); \
BeforeInstall: AvantRun;

Filename: {tmp}\Microsoft.2005.C++.Redistributable\vcredist_x86.exe; \
Parameters: /q; StatusMsg: Installation du prérequis (Microsoft Visual C++ 2005 Redistributable);

Filename: {tmp}\Microsoft.2008.C++.Runtime\vcredist_x86-2008.exe; \
Parameters: /qn; StatusMsg: Installation du prérequis (Microsoft Visual C++ 2008 Redistributable);

Filename: {tmp}\Microsoft Visual C++ 2010  x86 Redistributable\vcredist_x86.exe; \
Parameters: /qn; StatusMsg: Installation du prérequis (Microsoft Visual C++ 2010 Redistributable);

Filename: {tmp}\ThirdPartySoftware\VSTO2.0SE\vstor2.0se.exe; \
Parameters: /q; StatusMsg: Installation du prérequis (VSTO 3.0 SE);

Filename: {tmp}\ThirdPartySoftware\VSTO4.0\vstor40_x86.exe; \
Parameters: /q; StatusMsg: Installation du prérequis (VSTO 4.0 x86);

Filename: {tmp}\ThirdPartySoftware\OLI\OLI_Engine_in_PROII_9.2.9.0.6.exe; \
Parameters: "/qn" ; StatusMsg: Installation du prérequis (OLI);

Filename: {tmp}\ThirdPartySoftware\NOTEPAD\npp.6.3.Installer.exe; \
Parameters: "/S" ; StatusMsg: Installation du prérequis (npp.6.3);

;; MSI
Filename: "msiexec.exe"; \
Parameters: "/i ""{tmp}\ThirdPartySoftware\O2007PIA\o2007pia.msi"" /quiet /norestart"; \
StatusMsg: Installation du prérequis (O2007PIA);

Filename: "msiexec.exe"; \
Parameters: "/i ""{tmp}\ThirdPartySoftware\CAPE-OPEN.msi"" /quiet /norestart"; \
StatusMsg: Installation du prérequis (CAPE-OPEN);

;;; Installation de Pro II
; ici on utilise un "Check" la ligne sera executée uniquement si le check est vrai, dans ce cas on test si
; l'os est 32 bit ou 64 bit, IsWin64 est une fonction qui fait partie de InnoSetup mais on peut tres bien
; créer ses propres fonctions appelée par Check.
Filename: "msiexec.exe"; \
Parameters: "/i ""{tmp}\PROII93.msi"" SECURITY_TYPE=FLXLM95 INSTALLDIR=""c:\program files (x86)\SIMSCI\V9.2"" DESKTOP_ICON="""" IPASSI_LICENSE_FILE=2003@issrvlic2 /quiet /norestart"; \
StatusMsg: "Installation de ProII pour Windows 7"; Check: IsWin64;

Filename: "msiexec.exe"; \
Parameters: "/i ""{tmp}\PROII93.msi"" SECURITY_TYPE=FLXLM95 INSTALLDIR=""c:\program files\SIMSCI\V9.2"" DESKTOP_ICON="""" IPASSI_LICENSE_FILE=2003@issrvlic2 /quiet /norestart"; \
StatusMsg: "Installation de ProII pour Windows Xp"; Check: not IsWin64; \
AfterInstall: ApresRun('{#IFP_PKG_ID}');


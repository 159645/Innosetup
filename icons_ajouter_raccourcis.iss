; Exemple de la setion qui ajoute quelques raccourcis

[Icons]

; Name : le chemin complet du raccourcis
; Filename : la cible du raccourci
; WorkingDir: Spécifie le repertoire de démarrage pour le programme.
; IconFilename : si une icone est disponible
; Parameters : ajoute des paramètres a FileName
; ... beaucoup d'autre options disponibles

Name: "C:\ProgramData\Microsoft\Windows\Start Menu\Applications Complémentaires\Divers\ReportOne\MyReport Builder"; \
Filename: "C:\Program Files (x86)\ReportOne\MyReport5\Builder5.exe"; \
WorkingDir: "C:\Program Files (x86)\ReportOne\MyReport5\";

Name: "{commonappdata}\Microsoft\Windows\Start Menu\Applications Complémentaires\Divers\ReportOne\ISL Client"; \
Filename: "{pf32}\ReportOne\MyReport5\ISL Client.url"; \
WorkingDir: "{pf32}\ReportOne\MyReport5\"; \
IconFilename: "{pf32}\ReportOne\MyReport5\ISLIco.ico";

Name: "{commonappdata}\Microsoft\Windows\Start Menu\Applications Complémentaires\Divers\ReportOne\A propos\A propos de MyReport Builder"; \
Filename: "{pf32}\ReportOne\MyReport5\Builder5.exe"; \
WorkingDir: "{pf32}\ReportOne\MyReport5\"; \
Parameters: "APropos";



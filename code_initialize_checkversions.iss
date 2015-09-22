; package minimal pas de désinstallation.
#define MyAppName "discriminant"
#define MyAppVersion "1.0"

; on definit le chemin du fichier discriminant
#define discr "C:\Program Files (x86)\WinScp\WinSCP.exe"

; on donne la version de ce fichier
#define version "5.5.5.4610"


[Setup]
AppName={#MyAppName}
AppVersion={#MyAppVersion}
OutputBaseFilename={#MyAppName}
CreateAppDir=no
DisableWelcomePage=true
DisableFinishedPage=true
DisableReadyPage=true
CreateUninstallRegKey=no
Uninstallable=no
PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

; [Files]
; [registry]

[code]

function GetVersion(versionFichier: String): TarrayOfString;
  /// retourne les quatres premieres sequences de la version 0.0.0.0, dans un tableau de String
var
  current: String;
  TversionFichier: TarrayOfString;
  index, indexT : Integer;
begin
  // definit la taille du tableau on se limite a une version 0.0.0.0
  // initialise le tableau
  SetArrayLength(TversionFichier, 5);
  TversionFichier[1] := '0';
  TversionFichier[2] := '0';
  TversionFichier[3] := '0';
  TversionFichier[4] := '0';

  // Index du tableau
  indexT := 1;
  // chaine courante
  current := '';

  // On rajoute un point après la version, sinon on sort de la 
  // boucle au dernier caractere sans enregistrer le numero de version 
  versionFichier := versionFichier + '.';

  // On parcours la chaine de caractères
  For index := 1 To length(versionFichier) do
  begin
        // On ne rempli pas plus de quatres cases du tableau
        if indexT <= 4 then begin
            // MsgBox(Format('Caractere n° %d / %d', [index, length(versionFichier)]),  mbInformation, MB_OK);
            // si le caractère en cours n'est pas un point on constitue la chaine
            if versionFichier[index] <> '.' then begin
              current := current + versionFichier[index];
            end
            else begin
              if length(current) = 0 then current := IntToStr(0);
              // Si le caractère rencontre est un point on stocke la chaine dans le tableau
              TversionFichier[indexT] := current;
              // MsgBox(Format('numéro de version n°%d trouvé: %s', [indexT, current]),  mbInformation, MB_OK);
              // On passe a la suivante
              indexT := indexT+1;
              // on reprend a vide
              current := '';
            end;
        end
        else begin
          // On quitte si le numéro de version est plus long
          break;
        end;
   end;       
   Result := TversionFichier; // [ '0', '0', '0', '0' ]
end;


function CompareVersion(fichier: String): Integer;
  /// La fonction retourne 0 si le discriminant est absent du poste
  /// 1 si le fichier sur le poste est plus recent
  /// 2 si la version du package est plus recente
  /// 3 si les versions sont identiques
var
  versionPoste, versionPackage: String;
  TversionPoste, TversionPackage: TarrayOfString;
  i: Integer;
begin
   versionPackage := '{#version}';

   if GetVersionNumbersString(fichier, versionPoste) then begin
      // le fichier existe sur le poste
      // MsgBox(versionPoste,  mbInformation, MB_OK);
      // MsgBox(versionPackage,  mbInformation, MB_OK);

      TversionPoste := GetVersion(versionPoste);
      TversionPackage := GetVersion(versionPackage);
    
      MsgBox(Format('Version Poste  : ''%s'' ''%s'' ''%s'' ''%s''', [TversionPoste[1], TversionPoste[2], TversionPoste[3], TversionPoste[4] ]) +#13 + \
             Format('Version Package: ''%s'' ''%s'' ''%s'' ''%s''', [TversionPackage[1], TversionPackage[2], TversionPackage[3], TversionPackage[4] ]),  \
             mbInformation, MB_OK);

      // Compare les versions
      for i := 1 to 4 do 
      begin
        if StrToInt(TversionPoste[i]) > StrToInt(TversionPackage[i]) then begin          
           Result := 1;
           Exit;
        end
        else if StrToInt(TversionPoste[i]) < StrToInt(TversionPackage[i]) then begin
           Result := 2;
           Exit;
        end
        else if StrToInt(TversionPoste[i]) = StrToInt(TversionPackage[i]) then begin
            // si on compare les dernier numeros sont egaux
            // on declare que les versions sont identiques,
            if i = 4 then begin             
                Result := 3;
                Exit;
            end; 
            continue;    
        end;         
      end;
   end;
   // le fichier n'existe pas
   Result := 0;    
end;




function InitializeSetup: Boolean;
var
  checkVersion: Integer; 
begin
    // on peut utiliser les deux fonctions ci-dessus pour 
    // quitter l'installation si la version installée est la
    // même, ou plus recente.
    checkVersion := CompareVersion('{#discr}');
    case checkVersion of
      0:
        MsgBox('L''application n''est pas installée sur le poste.',  mbInformation, MB_OK);
      1:
        begin
          MsgBox('La version installée sur le poste est plus recente',  mbInformation, MB_OK);
          // InitializeSetup echoue on quitte
          Result := False;
          Exit;
        end;
      2:
        MsgBox('La version installée sur le poste est plus ancienne',  mbInformation, MB_OK);
      3:
        begin
          MsgBox('La version installée sur le poste est identique',  mbInformation, MB_OK);
          Result := False;
          Exit;
        end;       
    end;

    Result := True;
end;

//THE END


#define MyAppName "installQueue"
#define MyAppVersion "1.0"

[Setup]
AppName={#MyAppName}
AppVersion={#MyAppVersion}
CreateAppDir=no
OutputBaseFilename={#MyAppName}
Compression=none
SolidCompression=no
DisableWelcomePage=true
DisableFinishedPage=true
DisableReadyPage=true
CreateUninstallRegKey=no
Uninstallable=no
;PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64
SetupLogging=yes

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[Files]
Source: fichiers/*; Flags: dontCopy; 


[code]

function install(commande: String): Integer;
  /// Execution d'un package .exe, .msi ou script .bat
  ///
  /// ex: install(package.msi);
  /// ex: install(package.exe /S /PARAM=2);
  /// ex: install(script.bat);
  ///
  /// Retourne le code retour du programme ou 666
var
  index, ResultCode: Integer;
  fichier, ext, params : String;
begin
  // code retour si la commande n'est pas conforme 
  ResultCode := 666;

  // on separe le fichier executable des paramètres
  index := Pos(' ', commande);
  if index <> 0 then begin
    fichier := Copy(commande, 0, index -1);
    params := Copy(commande, index +1, length(commande));
  end
  else begin
    fichier := commande;
    params := '';
  end;
  
  if length(fichier) > 0 then begin
    // MsgBox(Format('exe: %s', [exe]) + #13 + Format('params: %s', [params]), mbInformation, MB_OK);
    // On extrait le fichier dans les temporaires
    ExtractTemporaryFile(fichier);
    fichier := Format('%s\%s', [ ExpandConstant('{tmp}'), fichier ]);

    if FileExists(fichier) then
    begin
        //MsgBox(Format('%s\%s', [ExpandConstant('{tmp}'), fichier]), mbInformation, MB_OK);
        ext := ExtractFileExt(fichier)
        case ext of
          '.exe':
            Exec(fichier, params,'' , SW_HIDE, ewWaitUntilTerminated, ResultCode);
          '.msi':
            begin
              params := Format('/i%s /qn', [ fichier, params ]);
              fichier := 'msiexec.exe';
              // MsgBox(Format('%s %s', [fichier, params]), mbInformation, MB_OK);
              Exec(fichier, params, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
            end;
          '.bat':
              ShellExec('', fichier, params, '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
        end;
        DeleteFile(fichier);
    end;
  end;

  Result := ResultCode;
end;


procedure CurStepChanged(CurStep: TSetupStep);
var
  rt, i: Integer;
  InstallQueue: TarrayOfString;
begin
  if CurStep = ssInstall then
  begin

    // Liste des packages a installer
    InstallQueue := [ '', 'code_retour0.exe /VERYSILENT /NORESTART', \
                          'code_retour1.exe /VERYSILENT /NORESTART', \
                          'code_retour2.exe /VERYSILENT /NORESTART', \
                          'code_retour3.exe /VERYSILENT /NORESTART', \
                          'MM26_FR.msi', \
                          'test.bat' ]
    
    for i := 0 to GetArrayLength(InstallQueue) -1 do
    begin
      // On installe chaque fichier du tableau
      rt:= install(InstallQueue[i]);

      MsgBox(Format('Le code retour de %s est %d', [InstallQueue[i], rt]), mbError, MB_OK);
      Log(Format('Le code retour du package %s est %d', [ InstallQueue[i], rt ]));

      // On traite le retour de la commande      
      case rt of
        666:
           continue
          0:
            // Succes       
       else
            // une erreur s'est produite pendant l'installation
            // break;
      end;
    end;
  end;
end;

//THE END

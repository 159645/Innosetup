#define MyAppName "sortie_erreur"
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
PrivilegesRequired=lowest
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[code]

// Modifie le code retour uniquement si le setup se termine correctement
// et aurait retourné 0.
//
// pour une application fenetrée utiliser start /wait.
// cmd> start /wait sortie_erreur.exe /SILENT
// cmd> echo %errorlevel%
// cmd> 1086
//
function GetCustomSetupExitCode: Integer;
begin
    Result := 1086;
    //Result := 12;
    //Result := 2;
end;


{
  Utilisés par Innosetup:

  0 Setup was successfully run to completion or the /HELP or /? command line parameter was used. 
  1 Setup failed to initialize. 
  2 The user clicked Cancel in the wizard before the actual installation started, or chose "No" on the opening "This will install..." message box.
  3 A fatal error occurred while preparing to move to the next installation phase (for example, from displaying the pre-installation wizard pages to the actual installation process). This should never happen except under the most unusual of circumstances, such as running out of memory or Windows resources.
  4 A fatal error occurred during the actual installation process.

  Note: Errors that cause an Abort-Retry-Ignore box to be displayed are not fatal errors. If the user chooses Abort at such a message box, exit code 5 will be returned.
 
  5 The user clicked Cancel during the actual installation process, or chose Abort at an Abort-Retry-Ignore box. 
  6 The Setup process was forcefully terminated by the debugger (Run | Terminate was used in the IDE).
  7 The Preparing to Install stage determined that Setup cannot proceed with installation. (First introduced in Inno Setup 5.4.1.)
  8 The Preparing to Install stage determined that Setup cannot proceed with installation, and that the system needs to be restarted in order to correct the problem. (First introduced in Inno Setup 5.4.1.)
} 

//THE END

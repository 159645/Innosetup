#define MyAppName "constantes"
#define MyAppVersion "1.0"
#define MyAppPublisher "IFPen"
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
;ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "french"; MessagesFile: "compiler:Languages\French.isl"

[code]
var
  newpage : TOutputMsgMemoWizardPage;
  text : AnsiString;
  constantes: TArrayOfString;
  i : Integer;


procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then begin

    constantes := [ '{app}', \
                    '{win}', \
                    '{sys}', \
                    '{syswow64}', \
                    '{src}', \
                    '{sd}', \
                    '{pf}', '{pf32}', '{pf64}', \
                    '{cf}', '{cf32}', '{cf64}', \
                    '{tmp}', \
                    '{fonts}', \
                    '{group}', \
                    '{localappdata}', \
                    '{sendto}', \
                    '{userappdata}', '{commonappdata}', \
                    '{usercf}', \
                    '{userdesktop}', '{commondesktop}', \
                    '{userdocs}', '{commondocs}', \
                    '{userfavorites}', '{commonfavorites}', \
                    '{userpf}', \
                    '{userprograms}', '{commonprograms}', \
                    '{userstartmenu}', '{commonstartmenu}', \
                    '{userstartup}', '{commonstartup}', \
                    '{usertemplates}', '{commontemplates}',
                    '{cmd}', \
                    '{computername}', \
                    '{groupname}', \
                    '{hwnd}', \
                    '{wizardhwnd}', \
                    '{language}', \
                    '{srcexe}', \
                    '{uninstallexe}', \
                    '{sysuserinfoname}', \
                    '{sysuserinfoorg}', \
                    '{userinfoname}', \
                    '{userinfoorg}', \
                    '{userinfoserial}', \
                    '{username}', \
                    '{log}'
                  ];

    for i := 0 to GetArrayLength(constantes)-1 do
    begin
      // Pour connaitre la valeur d'une constante dans le code il faut utiliser la fonction
      // ExpandConstant('{constante}')

      // #13 permet d'inserer un \n %n newline
      text := text + Format('%-s --> %-s', [constantes[i], ExpandConstant(constantes[i])]) + #13 + #13;
    end; 

    // Ajout de la nouvelle page pour afficher les constantes et leurs valeurs
    newpage := CreateOutputMsgMemoPage(wpInstalling, 'Information', 'Visualisation des constantes:', '', text);
  end;
end;

//THE END

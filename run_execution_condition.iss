; Les lignes du [run] sont exécutées les unes a la suite des autres.
; Le flag Check permet d'y appliquer une condition, il fait référence a une fonction du [code]
; si la fonction retourne vrai la ligne est executée, si la fonction retourne faux passe a la suivante

[Run]
; Désinstallation des anciennes versions de Java Run Environment
; JRE 6 U 24
Filename: "msiexec.exe"; Parameters: "/X{{26A24AE4-039D-4CA4-87B4-2F83216024FF} /quiet /norestart"; StatusMsg: Jre 6u24 x86 trouvé .. Désinstallation de Jre 6u24 x86...; Check: jre6u24_x86;
; JRE 6 U 20
Filename: "msiexec.exe"; Parameters: "/X{{26A24AE4-039D-4CA4-87B4-2F83216020F0} /quiet /norestart"; StatusMsg: Jre 6u20 x86 trouvé .. Désinstallation de Jre 6u20 x86...; Check: jre6u20_x86 ;
; JRE 6 U 18
Filename: "msiexec.exe"; Parameters: "/X{{26A24AE4-039D-4CA4-87B4-2F83216018F0} /quiet /norestart"; StatusMsg: Jre 6u18 x86 trouvé .. Désinstallation de Jre 6u18 x86...; Check: jre6u18_x86 ;
; JRE 6 U 10
Filename: "msiexec.exe"; Parameters: "/X{{26A24AE4-039D-4CA4-87B4-2F83216010F0} /quiet /norestart"; StatusMsg: Jre 6u10 x86 trouvé .. Désinstallation de Jre 6u10 x86...; Check: jre6u10_x86 ;
; JRE 5 U 11
Filename: "msiexec.exe"; Parameters: "/X{{3248F0A8-6813-11D6-A77B-00B0D0150110} /quiet /norestart"; StatusMsg: Jre 5u11 x86 trouvé .. Désinstallation de Jre 5u11 x86...; Check: jre5u11_x86 ;
; JRE 5 U 8
Filename: "msiexec.exe"; Parameters: "/X{{3248F0A8-6813-11D6-A77B-00B0D0150080} /quiet /norestart"; StatusMsg: Jre 5u8 x86 trouvé .. Désinstallation de Jre 5u8 x86...; Check: jre5u8_x86 ;


[code]
; La fonction RegKeyExists comme son nom l'indique permet de déterminer si la clef existe
;
; function jre6u24_x86(): Boolean;
; begin
;    Result := RegKeyExists(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{26A24AE4-039D-4CA4-87B4-2F83216024FF}');
; end;
;
function jre6u24_x86(): Boolean;
var 
   trouve: Boolean;
begin
  trouve := RegKeyExists(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{26A24AE4-039D-4CA4-87B4-2F83216024FF}');
  if trouve then Log('Java Jre 6 Update 24 32 bits trouve');
  Result := trouve; 
end;
function jre6u20_x86(): Boolean;
var 
   trouve: Boolean;
begin
  trouve := RegKeyExists(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{26A24AE4-039D-4CA4-87B4-2F83216020F0}');
  if trouve then Log('Java Jre 6 Update 20 32 bits trouve');
  Result := trouve; 
end;
function jre6u18_x86(): Boolean;
var 
   trouve: Boolean;
begin
  trouve := RegKeyExists(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{26A24AE4-039D-4CA4-87B4-2F83216018F0}');
  if trouve then Log('Java Jre 6 Update 18 32 bits trouve');
  Result := trouve; 
end;
function jre6u10_x86(): Boolean;
var 
   trouve: Boolean;
begin
  trouve := RegKeyExists(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{26A24AE4-039D-4CA4-87B4-2F83216010F0}');
  if trouve then Log('Java Jre 6 Update 10 32 bits trouve');
  Result := trouve; 
end;

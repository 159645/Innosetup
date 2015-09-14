; Installation du package
 
[code]

; On lance le script dans la fonction d'evenement "PostInstallScript"
; le script sera éxecuté après l'installation du package
function PostInstallScript(): Boolean;
var
  Errorcode: Integer;
  key, chem, valueex, newvalue: string;

 
begin
   chem     := 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
   key      := 'MAVARIABLE';
   newvalue := 'nouvelle valeure';

   // on recupere la valeur existante.
   if RegQueryStringValue(HKLM, chem, key, valueex) then begin
      log('La valeur de la clef est ' + valueex);
      
      // ON ecrit la nouvelle valeure seulement si différente de l'ancienne.
      if (valueex <> newvalue ) then RegWriteStringValue(HKLM, chem, key, newvalue);
   end 
   else begin 
      // la valeur n'existe pas on ecrit
      Log('La valeur est innexistante');
      RegWriteStringValue(HKLM, chem, key, newvalue);
   end;
   Result := true;
end;


; Désinstallation du package

; On lance le script dans la fonction d'evenement "PostUninstallScript"
; le script sera éxecuté après la désinstallation du package
function PostUninstallScript(): Boolean;
var
   key, chem: string;

begin
   chem := 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment';
   key  := 'MAVARIABLE';
   RegDeleteValue(HKLM,chem, key );
   Result := true;
end;

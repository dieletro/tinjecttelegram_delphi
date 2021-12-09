program ExemplosTInjectTelegram;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uResourceString in 'uResourceString.pas';

{$R *.res}
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

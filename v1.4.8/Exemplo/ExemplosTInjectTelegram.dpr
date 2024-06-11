program ExemplosTInjectTelegram;
uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {Form1},
  uResourceString in 'uResourceString.pas',
  XSuperJSON in 'XSuperJSON.pas',
  XSuperObject in 'XSuperObject.pas';

{$R *.res}
begin

//  ReportMemoryLeaksOnShutdown := True;


  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

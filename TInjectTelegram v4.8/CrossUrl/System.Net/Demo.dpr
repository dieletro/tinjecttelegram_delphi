program Demo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  CrossUrl.HttpClient,
  System.SysUtils;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.


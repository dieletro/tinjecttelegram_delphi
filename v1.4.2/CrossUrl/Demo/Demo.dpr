program Demo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  CrossUrl.HttpClient,
  CrossUrl.SystemNet.HttpClient,
  CrossUrl.Indy.HttpClient,
  System.SysUtils;

const
  SERVER = 'http://example.com/';

procedure TestCore(Client: IcuHttpClient);
var
  r: IcuHttpResponse;
begin
  r := Client.Get(SERVER);
  Writeln(r.StatusText);
  Writeln(r.StatusCode);
  Writeln(r.ContentAsString);
end;

procedure TestSysNet;
begin
  Writeln('Test System.Net: ');
  TestCore(TcuHttpClientSysNet.Create(nil));
end;

procedure TestIndy;
begin
  Writeln('Test Indy: ');
  TestCore(TcuHttpClientIndy.Create(nil));
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    TestSysNet;
    TestIndy;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.


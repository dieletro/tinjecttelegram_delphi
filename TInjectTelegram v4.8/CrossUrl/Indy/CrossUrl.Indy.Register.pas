unit CrossUrl.Indy.Register;

interface

procedure register;

implementation

uses
  System.Classes,
  CrossUrl.Indy.HttpClient;

procedure register;
begin
  RegisterComponents('CrossUrl', [TcuHttpClientIndy]);
end;

end.

unit CrossUrl.SystemNet.Register;

interface

procedure register;

implementation

uses
  System.Classes,
  CrossUrl.SystemNet.HttpClient;

procedure register;
begin
  RegisterComponents('CrossUrl', [TcuHttpClientSysNet]);
end;

end.


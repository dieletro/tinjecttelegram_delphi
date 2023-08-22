unit CrossUrl.Indy.HttpClient;

interface

uses
  CrossUrl.HttpClient,
  System.Classes,
  IdHTTP,
  IdSSLOpenSSL;

type
  TcuHttpClientIndy = class(TComponent, IcuHttpClient)
  private
    FHttpClient: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    function GetProxy: TcuProxy;
    procedure SetProxy(const AProxy: TcuProxy);
  public

    destructor Destroy; override;
    function Get(const AURL: string): IcuHttpResponse;
    function Post(const AURL: string; const ASource: IcuMultipartFormData):
      IcuHttpResponse;
    function CreateMultipartFormData: IcuMultipartFormData;
    constructor Create(AOwner: TComponent); override;
    property Proxy: TcuProxy read GetProxy write SetProxy;
  end;

implementation

uses
  CrossUrl.Indy.HttpResponse,
  CrossUrl.Indy.MultipartFormData;
{ TcuHttpClient }



constructor TcuHttpClientIndy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv23;

  FHttpClient := TIdHTTP.Create(nil);
    FHttpClient.Request.Connection := 'Keep-Alive';
    FHttpClient.Request.Accept := 'application/json';
    FHttpClient.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
    FHttpClient.Request.CustomHeaders.Clear;
    FHttpClient.Request.ContentType := 'application/json';
  FHttpClient.HandleRedirects := True;
  FHttpClient.Request.UserAgent := '';
end;

function TcuHttpClientIndy.CreateMultipartFormData: IcuMultipartFormData;
begin
  Result := TcuMultipartFormDataIndy.Create;
end;

destructor TcuHttpClientIndy.Destroy;
begin
  FHttpClient.Free;
  FIdSSLIOHandlerSocketOpenSSL.Free;
  inherited;
end;

function TcuHttpClientIndy.Get(const AUrl: string): IcuHttpResponse;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    FHttpClient.Get(AUrl, LStream);
    Result := TcuHttpResponce.Create(FHttpClient.Response, LStream);
  finally
   // LStream.Free;
  end;
end;

function TcuHttpClientIndy.GetProxy: TcuProxy;
begin
  Result.Host := FHttpClient.ProxyParams.ProxyServer;
  Result.Port := FHttpClient.ProxyParams.ProxyPort;
  Result.UserName := FHttpClient.ProxyParams.ProxyUsername;
  Result.Password := FHttpClient.ProxyParams.ProxyPassword;
end;

function TcuHttpClientIndy.Post(const AURL: string; const ASource:
  IcuMultipartFormData): IcuHttpResponse;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    FHttpClient.Post(AURL, (ASource as TcuMultipartFormDataIndy).GetCore);
    Result := TcuHttpResponce.Create(FHttpClient.Response, LStream);
  finally
   // LStream.Free;
  end;
end;

procedure TcuHttpClientIndy.SetProxy(const AProxy: TcuProxy);
begin
  FHttpClient.ProxyParams.Clear;
  FHttpClient.ProxyParams.ProxyServer := AProxy.Host;
  FHttpClient.ProxyParams.ProxyPort := AProxy.Port;
  FHttpClient.ProxyParams.ProxyUsername := AProxy.UserName;
  FHttpClient.ProxyParams.ProxyPassword := AProxy.Password;
end;

end.


unit CrossUrl.SystemNet.HttpClient;

interface

uses
  CrossUrl.HttpClient,
  System.Classes,
  System.Net.HttpClient;

type
  TcuHttpClientSysNet = class(TComponent, IcuHttpClient)
  private
    FHttpClient: THTTPClient;
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
  CrossUrl.SystemNet.HttpResponse,
  CrossUrl.SystemNet.MultipartFormData,
  System.Net.URLClient;

{ TcuHttpClient }

constructor TcuHttpClientSysNet.Create(AOwner: TComponent);
begin
  inherited;
  FHttpClient := THTTPClient.Create;
end;

function TcuHttpClientSysNet.CreateMultipartFormData: IcuMultipartFormData;
begin
  Result := TcuMultipartFormDataSysNet.Create;
end;

destructor TcuHttpClientSysNet.Destroy;
begin
  FHttpClient.Free;
  inherited Destroy;
end;

function TcuHttpClientSysNet.Get(const AUrl: string): IcuHttpResponse;
begin
  Result := TcuHttpResponce.Create(FHttpClient.Get(AUrl));
end;

function TcuHttpClientSysNet.GetProxy: TcuProxy;
begin
  Result.Host := FHttpClient.ProxySettings.Host;
  Result.Port := FHttpClient.ProxySettings.Port;
  Result.UserName := FHttpClient.ProxySettings.UserName;
  Result.Password := FHttpClient.ProxySettings.Password;
end;

function TcuHttpClientSysNet.Post(const AURL: string; const ASource:
  IcuMultipartFormData): IcuHttpResponse;
begin
  Result := TcuHttpResponce.Create(FHttpClient.Post(AURL, (ASource as
    TcuMultipartFormDataSysNet).GetCore));
end;

procedure TcuHttpClientSysNet.SetProxy(const AProxy: TcuProxy);
begin
  FHttpClient.ProxySettings := TProxySettings.Create(AProxy.Host, AProxy.Port,
    AProxy.UserName, AProxy.Password);
end;

end.


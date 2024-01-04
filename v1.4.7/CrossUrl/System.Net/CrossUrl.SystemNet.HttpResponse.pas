unit CrossUrl.SystemNet.HttpResponse;

interface

uses
  System.Net.HttpClient,
  CrossUrl.HttpClient,
  System.SysUtils,
  System.Classes;

type
  TcuHttpResponce = class(TInterfacedObject, IcuHttpResponse)
  private
    FHttpResponse: IHTTPResponse;
    function GetStatusCode: Integer;
    function GetStatusText: string;
    function GetContentStream: TStream;
  public
    constructor Create(AHttpResponse: IHTTPResponse);
    function ContentAsString(const AnEncoding: TEncoding = nil): string;
    property StatusText: string read GetStatusText;
    property StatusCode: Integer read GetStatusCode;
    property ContentStream: TStream read GetContentStream;
  end;

implementation

{ TcuHttpResponce }

function TcuHttpResponce.ContentAsString(const AnEncoding: TEncoding): string;
begin
  Result := FHttpResponse.ContentAsString(AnEncoding);
end;

constructor TcuHttpResponce.Create(AHttpResponse: IHTTPResponse);
begin
  FHttpResponse := AHttpResponse;
end;

function TcuHttpResponce.GetContentStream: TStream;
begin
  Result := FHttpResponse.ContentStream;
end;

function TcuHttpResponce.GetStatusCode: Integer;
begin
  Result := FHttpResponse.StatusCode;
end;

function TcuHttpResponce.GetStatusText: string;
begin
  Result := FHttpResponse.StatusText;
end;

end.


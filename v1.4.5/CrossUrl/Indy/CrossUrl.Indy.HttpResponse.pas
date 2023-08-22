unit CrossUrl.Indy.HttpResponse;

interface

uses
  CrossUrl.HttpClient,
  IdHTTP,
  System.SysUtils,
  System.Classes;

type
  TcuHttpResponce = class(TInterfacedObject, IcuHttpResponse)
  private
    FResponse: TIdHTTPResponse;
    FStream: TMemoryStream;
    function GetStatusCode: Integer;
    function GetStatusText: string;
    function GetContentStream: TStream;
  public
    constructor Create(AResponse: TIdHTTPResponse; AData: TMemoryStream);
    function ContentAsString(const AnEncoding: TEncoding = nil): string;
    property StatusText: string read GetStatusText;
    property StatusCode: Integer read GetStatusCode;
    property ContentStream: TStream read GetContentStream;
  end;

implementation

{ TcuHttpResponce }

function TcuHttpResponce.ContentAsString(const AnEncoding: TEncoding): string;
var
  LReader: TStringStream;
  LCharset: string;
  LStream: TStream;
  LFreeLStream: Boolean;
begin
  Result := '';
  LStream := nil;
  if AnEncoding = nil then
  begin
    LCharset := FResponse.CharSet;
    if (LCharset <> '') and (string.CompareText(LCharset, 'utf-8') <> 0) then  // do not translate
      LReader := TStringStream.Create('', TEncoding.GetEncoding(LCharset), True)
    else
      LReader := TStringStream.Create('', TEncoding.UTF8, False);
  end
  else
    LReader := TStringStream.Create('', AnEncoding, False);
  try
    {$IFNDEF MACOS} // NSURLConnection automatically decompresses response body.
    if FResponse.ContentEncoding = 'gzip' then
    begin
      // 15 is the default mode.
      // 16 is to enable gzip mode.  http://www.zlib.net/manual.html#Advanced
   //   LStream := TDecompressionStream.Create(FStream, 15 + 16);
      LFreeLStream := True;
    end
    else
    {$ENDIF}
    begin
      LStream := GetContentStream;
      LFreeLStream := False;
    end;

    try
      LReader.CopyFrom(LStream, 0);
      Result := LReader.DataString;
    finally
      if LFreeLStream then
        LStream.Free;
    end;
  finally
    LReader.Free;
  end;
end;

constructor TcuHttpResponce.Create(AResponse: TIdHTTPResponse; AData: TMemoryStream);
begin
  FResponse := AResponse;
  FStream := AData;
end;

function TcuHttpResponce.GetContentStream: TStream;
begin
  Result := FStream //FResponse.ContentStream;
end;

function TcuHttpResponce.GetStatusCode: Integer;
begin
  Result := FResponse.ResponseCode;
end;

function TcuHttpResponce.GetStatusText: string;
begin
  Result := FResponse.ResponseText;
end;

end.


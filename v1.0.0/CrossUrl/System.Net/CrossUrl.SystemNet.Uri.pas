unit CrossUrl.SystemNet.Uri;

interface

uses
  System.Net.URLClient,
  CrossUrl.HttpClient,
  System.Classes;

type
  TcuUriSysNet = class(TInterfacedObject, IcuUri)
  private
    FUri: TURI;
    function GetScheme: string;
    procedure SetScheme(const Value: string);
  public
    constructor Create(const AURIStr: string);
    property Scheme: string read GetScheme write SetScheme;
  end;

implementation

{ TcuUriSysNet }

constructor TcuUriSysNet.Create(const AURIStr: string);
begin
  FUri := turi.Create(AURIStr);
end;

function TcuUriSysNet.GetScheme: string;
begin
  Result := FUri.Scheme;
end;

procedure TcuUriSysNet.SetScheme(const Value: string);
begin
  FUri.Scheme := Value;
end;

end.


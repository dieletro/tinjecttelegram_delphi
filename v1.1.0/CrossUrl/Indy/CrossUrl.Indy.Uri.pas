unit CrossUrl.Indy.Uri;

interface

uses
  IdURI,
  CrossUrl.HttpClient,
  System.Classes;

type
  TcuUriSysNet = class(TInterfacedObject, IcuUri)
  private
    FUri: TIdURI;
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
  FUri := TIdURI.Create(AURIStr);
end;

function TcuUriSysNet.GetScheme: string;
begin
  Result := FUri.Protocol;
end;

procedure TcuUriSysNet.SetScheme(const Value: string);
begin
  FUri.Protocol := Value;
end;

end.


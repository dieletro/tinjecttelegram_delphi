unit TinjectTelegram.Ext.Sessions;

interface

uses
  System.Rtti,
  System.Generics.Collections;

type
  ItdSession = interface
    ['{D581A266-7AC0-496A-8784-9DCEDC6849C9}']
    function GetItem(const AKey: string): TValue;
    procedure SetItem(const AKey: string; const Value: TValue);
    function GetCreatedAt: TDateTime;
    procedure SetCreatedAt(const Value: TDateTime);
    //
    procedure Clear;
    property Items[const AKey: string]: TValue read GetItem write SetItem; Default;
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
  end;

  TtdSession = class(TInterfacedObject, ItdSession)
  private
    FItems: TDictionary<string, TValue>;
    FCreatedAt: TDateTime;
    function GetItem(const AKey: string): TValue;
    procedure SetItem(const AKey: string; const Value: TValue);
    function GetCreatedAt: TDateTime;
    procedure SetCreatedAt(const Value: TDateTime);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
    property Items[const AKey: string]: TValue read GetItem write SetItem; Default;
  end;

  ItdSessionManager = interface
    ['{52E3CD5C-C096-4C3D-BC70-D284233C0250}']
    function GetItem(const AID: Int64): ItdSession;
    procedure SetItem(const AID: Int64; const Value: ItdSession);
    procedure Clear;
    property Items[const AID: Int64]: ItdSession read GetItem write SetItem; Default;
  end;

  TtdSessionManager = class(TInterfacedObject, ItdSessionManager)
  private
    class var
      FInstance: TtdSessionManager;
  private
    FItems: TDictionary<Int64, ItdSession>;
    function GetItem(const AID: Int64): ItdSession;
    procedure SetItem(const AID: Int64; const Value: ItdSession);
  public
    class function NewInstance: TObject; override;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property Items[const AID: Int64]: ItdSession read GetItem write SetItem; Default;
  end;

implementation

uses
  System.SysUtils;

procedure TtdSession.Clear;
begin
  FItems.Clear;
end;

constructor TtdSession.Create;
begin
  FItems := TDictionary<string, TValue>.Create;
end;

destructor TtdSession.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TtdSession.GetCreatedAt: TDateTime;
begin
  Result := FCreatedAt;
end;

function TtdSession.GetItem(const AKey: string): TValue;
begin
  if not FItems.ContainsKey(AKey) then
    FItems.Add(AKey, TValue.Empty);
  Result := FItems.Items[AKey]
end;

procedure TtdSession.SetCreatedAt(const Value: TDateTime);
begin
  FCreatedAt := Value;
end;

procedure TtdSession.SetItem(const AKey: string; const Value: TValue);
begin
  FItems.AddOrSetValue(AKey, Value);
end;

{ TtdSesionManager }

procedure TtdSessionManager.Clear;
begin
  FItems.Clear;
end;

constructor TtdSessionManager.Create;
begin
  FItems := TDictionary<Int64, ItdSession>.Create;
end;

destructor TtdSessionManager.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TtdSessionManager.GetItem(const AID: Int64): ItdSession;
begin
  if not FItems.ContainsKey(AID) then
    FItems.Add(AID, TtdSession.Create);
  Result := FItems.Items[AID]
end;

class function TtdSessionManager.NewInstance: TObject;
begin
  if FInstance = nil then
    FInstance := TtdSessionManager(inherited NewInstance);
  Result := FInstance;
end;

procedure TtdSessionManager.SetItem(const AID: Int64; const Value: ItdSession);
begin
  FItems.AddOrSetValue(AID, Value);
  FItems.Items[AID].CreatedAt := Now;
end;

end.


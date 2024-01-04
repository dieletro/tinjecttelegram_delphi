unit TinjectTelegram.Core;
interface
uses
  System.Rtti,
  System.TypInfo,
  System.SysUtils,
  System.Generics.Collections,
  System.Classes,
  TinjectTelegram.Base,
  TinjectTelegram.Types,
  TinjectTelegram.Helpers,
  CrossUrl.HttpClient;
type
  ItdRequestAPI = interface
    ['{3DC5A653-F52D-4A31-87AD-0C008AFA7111}']
    // private
    function GetOnError: TProc<Exception>;
    procedure SetOnError(const Value: TProc<Exception>);
    function GetOnSend: TProc<string, string>;
    procedure SetOnSend(const Value: TProc<string, string>);
    function GetOnReceive: TProc<string>;
    procedure SetOnReceive(const Value: TProc<string>);
    function GetDataExtractor: TFunc<string, string>;
    procedure SetDataExtractor(const Value: TFunc<string, string>);
    function GetFormData: IcuMultipartFormData;
    function GetHttpCore: IcuHttpClient;
    procedure SetHttpCore(const AHttpCore: IcuHttpClient);
    function GetUrlAPI: string;
    procedure SetUrlAPI(const AValue: string);
    // public
    function SetToken(const AToken: string): ItdRequestAPI;
    function SetMethod(const AMethod: string): ItdRequestAPI;
    //
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      string; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      Int64{Integer}; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      TDateTime; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; AValue, ADefaultValue:
      TtdFileToSend; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      TtdUserLink; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; AValue, ADefaultValue: TObject;
      const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      Boolean; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      Single; const ARequired: Boolean = False): ItdRequestAPI; overload;
    //
    function AddRawField(const AField, AValue: string): ItdRequestAPI;
    function AddRawFile(const AFieldName, AFileName: string): ItdRequestAPI;
    function AddRawStream(const AFieldName: string; Data: TStream; const
      AFileName: string): ItdRequestAPI;
    //
    function ClearParameters: ItdRequestAPI;
    function Execute: string;
    function ExecuteAsBool: Boolean;
    function ExecuteAsInt64(AKey: String): Int64;
    function ExecuteAndReadValue: string;
    // props
    property DataExtractor: TFunc<string, string> read GetDataExtractor write
      SetDataExtractor;
    property MultipartFormData: IcuMultipartFormData read GetFormData;
    property HttpCore: IcuHttpClient read GetHttpCore write SetHttpCore;
    property UrlAPI: string read GetUrlAPI write SetUrlAPI;
    // events
    property OnError: TProc<Exception> read GetOnError write SetOnError;
    property OnSend: TProc<string, string> read GetOnSend write SetOnSend;
    property OnReceive: TProc<string> read GetOnReceive write SetOnReceive;
  end;
  TtdCoreApiBase = class(TInterfacedObject, ItdRequestAPI)
  private
    FGetOnSend: TProc<string, string>;
    FDataExtractor: TFunc<string, string>;
    FOnReceive: TProc<string>;
    FToken: string;
    FMethod: string;
    FOnError: TProc<Exception>;
    FFormData: IcuMultipartFormData;
    FHttpCore: IcuHttpClient;
    FHaveFields: Boolean;
    FUrlAPI: string;
  private
    function GetOnError: TProc<Exception>;
    procedure SetOnError(const Value: TProc<Exception>);
    function GetOnSend: TProc<string, string>;
    procedure SetOnSend(const Value: TProc<string, string>);
    function GetOnReceive: TProc<string>;
    procedure SetOnReceive(const Value: TProc<string>);
    function GetDataExtractor: TFunc<string, string>;
    procedure SetDataExtractor(const Value: TFunc<string, string>);
    function GetUrl: string;
    function GetFormData: IcuMultipartFormData;
    procedure SetHttpCore(const Value: IcuHttpClient);
    function GetHttpCore: IcuHttpClient;
    function GetUrlAPI: string;
    procedure SetUrlAPI(const AValue: string);
  protected
    procedure DoHaveException(const AException: Exception);
    function StreamToString(Stream: TStream): string;
  public
    function SetToken(const AToken: string): ItdRequestAPI;
    function SetMethod(const AMethod: string): ItdRequestAPI;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      string; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      Int64{Integer}; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      TDateTime; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; AValue, ADefaultValue:
      TtdFileToSend; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      TtdUserLink; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; AValue, ADefaultValue: TObject;
      const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      Boolean; const ARequired: Boolean = False): ItdRequestAPI; overload;
    function AddParameter(const AKey: string; const AValue, ADefaultValue:
      Single; const ARequired: Boolean = False): ItdRequestAPI; overload;
    //
    function AddRawField(const AField, AValue: string): ItdRequestAPI;
    function AddRawFile(const AFieldName, AFileName: string): ItdRequestAPI;
    function AddRawStream(const AFieldName: string; Data: TStream; const
      AFileName: string): ItdRequestAPI;
    function HaveFields: Boolean;
    function ClearParameters: ItdRequestAPI;
    function Execute: string; virtual; abstract;
    function ExecuteAsBool: Boolean;
    function ExecuteAsInt64(AKey:String): Int64;
    function ExecuteAndReadValue: string;
    constructor Create;
    // props
    property DataExtractor: TFunc<string, string> read GetDataExtractor write
      SetDataExtractor;
    property Url: string read GetUrl;
    property HttpCore: IcuHttpClient read FHttpCore write SetHttpCore;
    property UrlAPI: string read GetUrlAPI write SetUrlAPI;
    // events
    property OnError: TProc<Exception> read GetOnError write SetOnError;
    property OnSend: TProc<string, string> read GetOnSend write SetOnSend;
    property OnReceive: TProc<string> read GetOnReceive write SetOnReceive;
  end;
  TtdCoreApi = class(TtdCoreApiBase, ItdRequestAPI)
  private
  protected
    function DoPost: string;
    function DoGet: string;
  public
    function Execute: string; override;
  end;
implementation
uses
  REST.Json,
  System.DateUtils,
  System.Json,
  TInjectTelegram.Utils.Json,
  TInjectTelegram.Types.ReplyMarkups;
{ TtdCoreApiBase }
{$REGION 'TtdCoreApiBase.AddParameter'}
function TtdCoreApiBase.AddParameter(const AKey, AValue, ADefaultValue: string;
  const ARequired: Boolean): ItdRequestAPI;
begin
  if ARequired and (AValue.Equals(ADefaultValue) or AValue.IsEmpty) then
    DoHaveException(Exception.Create('Mandatory data not assigned'));
  if AValue <> ADefaultValue then
    AddRawField(AKey, AValue);
  Result := Self;
end;
function TtdCoreApiBase.AddParameter(const AKey: string; const AValue,
  ADefaultValue: Int64{Integer}; const ARequired: Boolean): ItdRequestAPI;
begin
  Result := AddParameter(AKey, AValue.ToString, ADefaultValue.ToString, ARequired);
end;
function TtdCoreApiBase.AddParameter(const AKey: string; const AValue,
  ADefaultValue: TDateTime; const ARequired: Boolean): ItdRequestAPI;
begin
  Result := AddParameter(AKey, DateTimeToUnix(AValue, False).ToString,
    DateTimeToUnix(ADefaultValue, False).ToString, ARequired);
end;
function TtdCoreApiBase.AddParameter(const AKey: string; AValue, ADefaultValue:
  TtdFileToSend; const ARequired: Boolean): ItdRequestAPI;
begin
  if ARequired and (AValue.Equals(ADefaultValue) or AValue.IsEmpty) then
    DoHaveException(Exception.Create('Mandatory data not assigned'));
  Result := Self;
  case AValue.Tag of
    TtdFileToSendTag.FromStream:
      AddRawStream(AKey, AValue.Content, AValue.Data);
    TtdFileToSendTag.FromFile:
      AddRawFile(AKey, AValue.Data);
    TtdFileToSendTag.ID, TtdFileToSendTag.FromURL:
      Result := AddParameter(AKey, AValue.Data, '', ARequired);
  else
    raise Exception.Create('Unable to convert TtdFileToSend: Unknown prototype tag');
  end;
  if Assigned(AValue) then
    FreeAndNil(AValue);
  if Assigned(ADefaultValue) then
    FreeAndNil(ADefaultValue);
end;
function TtdCoreApiBase.AddParameter(const AKey: string; const AValue,
  ADefaultValue: TtdUserLink; const ARequired: Boolean): ItdRequestAPI;
begin
  Result := AddParameter(AKey, AValue.ToString, ADefaultValue.ToString, ARequired);
end;
function TtdCoreApiBase.AddParameter(const AKey: string; AValue, ADefaultValue:
  TObject; const ARequired: Boolean): ItdRequestAPI;
begin
  Result := AddParameter(AKey, TJsonUtils.ObjectToJString(AValue),  //
    TJsonUtils.ObjectToJString(ADefaultValue), ARequired);
end;
function TtdCoreApiBase.AddParameter(const AKey: string; const AValue,
  ADefaultValue, ARequired: Boolean): ItdRequestAPI;
begin
  Result := AddParameter(AKey, AValue.ToJSONBool, ADefaultValue.ToJSONBool, ARequired);
end;
function TtdCoreApiBase.AddParameter(const AKey: string; const AValue,
  ADefaultValue: Single; const ARequired: Boolean): ItdRequestAPI;
Var StrSingle: String;
    I: Integer;
begin
   StrSingle := AValue.ToString;
   for I:=1 to length(StrSingle) do
     if StrSingle[I]= ',' then
        StrSingle[I]:= '.';
  Result := AddParameter(AKey, StrSingle, ADefaultValue.ToString, ARequired);
end;
{$ENDREGION}
function TtdCoreApiBase.AddRawField(const AField, AValue: string): ItdRequestAPI;
begin
  FFormData.AddField(AField, AValue);
  FHaveFields := True;
  Result := Self;
end;
function TtdCoreApiBase.AddRawFile(const AFieldName, AFileName: string): ItdRequestAPI;
begin
  FFormData.AddFile(AFieldName, AFileName);
  FHaveFields := True;
  Result := Self;
end;
function TtdCoreApiBase.AddRawStream(const AFieldName: string; Data: TStream;
  const AFileName: string): ItdRequestAPI;
begin
  FFormData.AddStream(AFieldName, Data, AFileName);
  FHaveFields := True;
  Result := Self;
end;
function TtdCoreApiBase.ClearParameters: ItdRequestAPI;
begin
  FFormData := nil;
  FHaveFields := False;
  FFormData := HttpCore.CreateMultipartFormData;
  Result := Self;
end;
constructor TtdCoreApiBase.Create;
begin
  FHaveFields := False;
end;
procedure TtdCoreApiBase.DoHaveException(const AException: Exception);
begin
  if Assigned(OnError) then
    OnError(AException)
  else
    raise AException;
end;
function TtdCoreApiBase.ExecuteAndReadValue: string;
var
  LJson: TJSONValue;
begin
  LJson := TJSONObject.ParseJSONValue(Execute);
  try
    Result := LJson.Value;
  finally
    LJson.Free;
  end;
end;
function TtdCoreApiBase.ExecuteAsBool: Boolean;
var
  LJson: TJSONValue;
begin
  LJson := TJSONObject.ParseJSONValue(Execute);
  try
    Result := LJson is TJSONTrue;
  finally
    LJson.Free;
  end;
end;
function TtdCoreApiBase.ExecuteAsInt64(AKey :String): Int64;
var
  LJson: TJSONValue;
begin
  LJson := TJSONObject.ParseJSONValue(Execute);
  try
    Result := LJson.GetValue<Int64>(AKey);
  finally
    LJson.Free;
  end;
end;

function TtdCoreApiBase.GetDataExtractor: TFunc<string, string>;
begin
  Result := FDataExtractor;
end;
function TtdCoreApiBase.GetFormData: IcuMultipartFormData;
begin
  Result := FFormData;
end;
function TtdCoreApiBase.GetHttpCore: IcuHttpClient;
begin
  Result := FHttpCore;
end;
function TtdCoreApiBase.GetOnError: TProc<Exception>;
begin
  Result := FOnError;
end;
function TtdCoreApiBase.GetOnReceive: TProc<string>;
begin
  Result := FOnReceive;
end;
function TtdCoreApiBase.GetOnSend: TProc<string, string>;
begin
  Result := FGetOnSend;
end;
function TtdCoreApiBase.GetUrl: string;
begin
  Result := GetUrlAPI + FToken + '/' + FMethod;
end;
function TtdCoreApiBase.GetUrlAPI: string;
begin
  Result := FUrlAPI;
end;
function TtdCoreApiBase.HaveFields: Boolean;
begin
  Result := FHaveFields;
end;
procedure TtdCoreApiBase.SetDataExtractor(const Value: TFunc<string, string>);
begin
  FDataExtractor := Value;
end;
procedure TtdCoreApiBase.SetHttpCore(const Value: IcuHttpClient);
begin
  FHttpCore := Value;
  if FHttpCore <> nil then
    FFormData := FHttpCore.CreateMultipartFormData;
end;
function TtdCoreApiBase.SetMethod(const AMethod: string): ItdRequestAPI;
begin
  FMethod := AMethod;
  Result := Self;
end;
procedure TtdCoreApiBase.SetOnError(const Value: TProc<Exception>);
begin
  FOnError := Value;
end;
procedure TtdCoreApiBase.SetOnReceive(const Value: TProc<string>);
begin
  FOnReceive := Value;
end;
procedure TtdCoreApiBase.SetOnSend(const Value: TProc<string, string>);
begin
  FGetOnSend := Value;
end;
function TtdCoreApiBase.SetToken(const AToken: string): ItdRequestAPI;
begin
  FToken := AToken;
  Result := Self;
end;
procedure TtdCoreApiBase.SetUrlAPI(const AValue: string);
begin
  FUrlAPI := AValue;
end;
function TtdCoreApiBase.StreamToString(Stream: TStream): string;
var
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    Stream.Position := 0;
    LStrings.LoadFromStream(Stream);
    Result := LStrings.Text;
  finally
    LStrings.Free;
  end;
end;
{ TtdCoreApiSysNet }
function TtdCoreApi.DoGet: string;
begin
  Result := FHttpCore.Get(Url).ContentAsString;
end;
function TtdCoreApi.DoPost: string;
begin
  Result := FHttpCore.Post(Url, FFormData).ContentAsString;
end;
function TtdCoreApi.Execute: string;
begin
  if Assigned(OnSend) then
    OnSend(Url, StreamToString(FFormData.Stream));
  try
    if HaveFields then
    begin
      Result := DoPost;
      ClearParameters;
    end
    else
      Result := DoGet;
  except
    on E: Exception do
    begin
      Result := '';
      DoHaveException(E);
    end;
  end;
  if Result = '' then
    Exit;
  if Assigned(OnReceive) then
    OnReceive(Result);
  if Assigned(DataExtractor) then
    Result := DataExtractor(Result);
end;
end.

unit TelegAPI.Utils.Json;

interface

{$I config.inc}

uses
  System.Json, REST.Json, REST.JsonReflect, REST.Json.Types;

type
  TBaseJsonClass = class of TBaseJson;

  TBaseJson = class(TInterfacedObject)
  private
  protected
    FJSON: TJSONObject;
    FJsonRaw: string; //for debbuger
    function ReadToClass<T: class, constructor>(const AKey: string): T;
    function ReadToSimpleType<T>(const AKey: string): T;
    function ReadToDateTime(const AKey: string): TDateTime;
    function ReadToArray<TI: IInterface>(TgClass: TBaseJsonClass; const AKey:
      string): TArray<TI>;
    procedure Write(const AKey, AValue: string);
    procedure SetJson(const AJson: string);
  public
    function AsJson: string;
    class function FromJson(const AJson: string): TBaseJson;
    class function GetTgClass: TBaseJsonClass; virtual; // abstract;
    class procedure UnSupported;
    constructor Create(const AJson: string); virtual;
    destructor Destroy; override;
  end;

  TJsonUtils = class
    /// Nova Função ArrayStringToJString By Ruan Diego Lacerda Menezes
    /// para compatibilizar e add o SendPoll
    class function ObjectToJsonValue(AObject: TObject; AOptions: TJsonOptions): TJSONValue; static;
    class procedure ProcessOptions(AJsonObject: TJSONObject; AOptions: TJsonOptions); static;
    class function ArrayStringToJString(LArray: Array of String): string;
    class function ArrayLebeledPriceToJString<T: class>(LArray:  TArray<T>): string; static;
    class function ArrayToJString2<T: class>(LArray: TArray<T>): string;
    class function ArrayToJString<T: class>(LArray: TArray<T>): string;
    class function ObjectToJString(AObj: TObject): string;
    class function FileToObject<T: class, constructor>(const AFileName: string): T;
    class procedure ObjectToFile(AObj: TObject; const AFileName: string);
  end;

  TJSONValueHelper = class helper for TJSONValue
  strict private
  private
    function GetS(const APath: string): string;
    procedure SetS(const APath, AValue: string);
  public
    property S[const APath: string]: string read GetS write SetS;
  end;

implementation

uses
  TelegAPI.Types.Impl,
  System.DateUtils,
  System.IOUtils,
  System.SysUtils,
  System.TypInfo;

{ TJSONValueHelper }
type
  TJSONStringHack = class(TJSONString);

function TJSONValueHelper.GetS(const APath: string): string;
begin
  if (not Self.TryGetValue<string>(APath, Result)) then
    Result := string.Empty;
end;

//By Ruan Diego Lacerda Menezes
procedure TJSONValueHelper.SetS(const APath, AValue: string);
var
  LValue: TJSONValue;
begin
  LValue := Self.FindValue(APath);

  if (LValue is TJSONString) then
  begin
  {$IFDEF DELPHI13_UP}
    TJSONStringHack(LValue).FValue := '';
    TJSONStringHack(LValue).FValue := AValue;
  {$ELSE}
    TJSONStringHack(LValue).FStrBuffer.Clear;
    TJSONStringHack(LValue).FStrBuffer.Append(AValue);
  {$ENDIF}
  end;
end;

{ TJsonUtils }

//By Ruan Diego Lacerda Menezes
class function TJsonUtils.ArrayStringToJString(LArray: Array of String): string;
Var
  I: Integer;
begin
  result := '[';
  for I := Low(LArray) to High(LArray) do
  if LArray[I] <> '' then
  begin
     Result := Result + '"' +LArray[I] + '"' ;
     if I <> High(LArray) then
       result := result +',';
  End;
  Result := Result + ']';
  Result := Result.Replace('"inline_keyboard":null', '', [rfReplaceAll]);

end;

class function TJsonUtils.ArrayLebeledPriceToJString<T>(LArray:  TArray<T>): string;
Var
  I: Integer;
begin
  result := '[{"jSon":"{';
  for I := Low(LArray) to High(LArray) do
  begin
    if (LArray[I] as TtgLabeledPrice).sLabel <> '' then
      Result := Result + '"label":"' + (LArray[I] as TtgLabeledPrice).sLabel + '"';
    if (LArray[I] as TtgLabeledPrice).sAmount.ToString <> '' then
      Result := Result + ',"amount":"' +(LArray[I] as TtgLabeledPrice).sAmount.ToString +'"}' ;
     if I <> High(LArray) then
       result := result +',';
  End;
  Result := Result + '}]';
  Result := Result.Replace('"inline_keyboard":null', '', [rfReplaceAll]);
end;

class function TJsonUtils.ArrayToJString2<T>(LArray: TArray<T>): string;
var
  I: Integer;
begin
  Result := '[';
  for I := Low(LArray) to High(LArray) do
    if Assigned(LArray[I]) then
    begin
      Result := Result  + ObjectToJString(LArray[I]);
      if I <> High(LArray) then
        Result := Result + ',';
    end;
  Result := Result + ']';
  Result := Result.Replace('"inline_keyboard":null', '', [rfReplaceAll]);
//
end;

class function TJsonUtils.ArrayToJString<T>(LArray: TArray<T>): string;
var
  I: Integer;
begin
  Result := '[';
  for I := Low(LArray) to High(LArray) do
    if Assigned(LArray[I]) then
    begin
      Result := Result + TJson.ObjectToJsonString(LArray[I]);
      if I <> High(LArray) then
        Result := Result + ',';
    end;
  Result := Result + ']';
  Result := Result.Replace('"inline_keyboard":null', '', [rfReplaceAll]);
  // barata
end;

class function TJsonUtils.FileToObject<T>(const AFileName: string): T;
var
  LContent: string;
begin
  Result := nil;
  if TFile.Exists(AFileName) then
  begin
    LContent := TFile.ReadAllText(AFileName, TEncoding.UTF8);
    Result := TJson.JsonToObject<T>(LContent);
  end;
end;

class procedure TJsonUtils.ObjectToFile(AObj: TObject; const AFileName: string);
var
  LContent: string;
begin
  LContent := ObjectToJString(AObj);
  TFile.WriteAllText(AFileName, LContent, TEncoding.UTF8);
end;

class function TJsonUtils.ObjectToJString(AObj: TObject): string;
begin // IF DELPHI_VERSION < TOKIO
  if Assigned(AObj) then
    Result := TJson.ObjectToJsonString(AObj)
  else
    Result := 'null';
end;

class function TJsonUtils.ObjectToJsonValue(AObject: TObject; AOptions: TJsonOptions): TJSONValue;
var
  LMarshaler: TJSONMarshal;
begin

  LMarshaler := TJSONMarshal.Create(TJSONConverter.Create);
  try
    LMarshaler.DateTimeIsUTC  := joDateIsUTC in AOptions;
    if joDateFormatUnix in AOptions then
      LMarshaler.DateFormat :=jdfUnix
    else if joDateFormatISO8601 in AOptions then
      LMarshaler.DateFormat := jdfISO8601
    else if joDateFormatMongo in AOptions then
      LMarshaler.DateFormat := jdfMongo
    else if joDateFormatParse in AOptions then
      LMarshaler.DateFormat := jdfParse;

    Result := LMarshaler.Marshal(AObject);
    if Result is TJSONObject then
      ProcessOptions(TJSONObject(Result), AOptions);
  finally
    LMarshaler.Free;
  end;
end;

class procedure TJsonUtils.ProcessOptions(AJsonObject: TJSONObject;
  AOptions: TJsonOptions);
var
  LPair: TJSONPair;
  LItem: TObject;
  i: Integer;

  function IsEmpty(ASet: TJsonOptions): Boolean;
  var
    LElement: TJsonOption;
  begin
    Result := True;
    for LElement in ASet do
    begin
      Result := False;
      break;
    end;
  end;

begin
  if Assigned(AJsonObject) and not IsEmpty(AOptions) then

    for i := AJsonObject.Count - 1 downto 0 do
    begin
      LPair := TJSONPair(AJsonObject.Pairs[i]);
      if LPair.JsonValue is TJSONObject then
        ProcessOptions(TJSONObject(LPair.JsonValue), AOptions)
      else if LPair.JsonValue is TJSONArray then
      begin
        if (joIgnoreEmptyArrays in AOptions) and (TJSONArray(LPair.JsonValue).Count = 0) then
          AJsonObject.RemovePair(LPair.JsonString.Value).DisposeOf
        else
          for LItem in TJSONArray(LPair.JsonValue) do
            if LItem is TJSONObject then
              ProcessOptions(TJSONObject(LItem), AOptions)
      end
      else
        if (joIgnoreEmptyStrings in AOptions) and (LPair.JsonValue.value = '') then
          AJsonObject.RemovePair(LPair.JsonString.Value).DisposeOf;
    end;
end;

{ TBaseJson }

function TBaseJson.AsJson: string;
begin
  if Assigned(FJSON) then
    Result := FJSON.ToJSON
  else
    Result := '';
end;

constructor TBaseJson.Create(const AJson: string);
begin
  inherited Create;
  SetJson(AJson);
end;

function TBaseJson.ReadToArray<TI>(TgClass: TBaseJsonClass; const AKey: string):
  TArray<TI>;
var
  LJsonArray: TJSONArray;
  I: Integer;
  GUID: TGUID;
begin
// estágio 1: verificação de tipo
// valor do cache para uso posterior
  GUID := GetTypeData(TypeInfo(TI))^.GUID;
  // verifique o suporte da interface TI
  if TgClass.GetInterfaceEntry(GUID) = nil then
    raise Exception.Create('GetArrayFromMethod: unsupported interface for ' +
      TgClass.ClassName);
  // estágio 2: continuar dados
  LJsonArray := FJSON.GetValue(AKey) as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to High(Result) do
  begin
    TgClass.GetTgClass.Create(LJsonArray.Items[I].ToString).GetInterface(GUID, Result[I]);
  end;
end;

function TBaseJson.ReadToClass<T>(const AKey: string): T;
var
  LValue: string;
  LObj: TJSONValue;
begin
  Result := nil;
  LObj := FJSON.GetValue(AKey);
  if Assigned(LObj) and (not LObj.Null) then
  begin
{$IFDEF USE_INDY}
    // A diretiva não se encaixa bem. Este é o caso se você estiver usando a versão antiga do IDE
    LValue := LObj.ToString;
{$ELSE}
    LValue := LObj.ToJSON;
{$ENDIF}
    Result := TBaseJsonClass(T).Create(LValue) as T;
  end
end;

destructor TBaseJson.Destroy;
begin
  FJSON.Free;
  inherited;
end;

class function TBaseJson.FromJson(const AJson: string): TBaseJson;
begin
  if AJson.IsEmpty then
    Result := nil
  else
    Result := TBaseJson.Create(AJson);
end;

class function TBaseJson.GetTgClass: TBaseJsonClass;
begin
  Result := Self;
end;

function TBaseJson.ReadToDateTime(const AKey: string): TDateTime;
var
  LValue: Int64;
begin
  Result := 0;
  if FJSON.TryGetValue<Int64>(AKey, LValue) then
    Result := UnixToDateTime(LValue, False);
end;

function TBaseJson.ReadToSimpleType<T>(const AKey: string): T;
begin
  if (not Assigned(FJSON)) or (not FJSON.TryGetValue<T>(AKey, Result)) then
    Result := Default(T);
end;

procedure TBaseJson.SetJson(const AJson: string);
begin
  FJsonRaw := AJson;
  if FJsonRaw.IsEmpty then
    Exit;
  if Assigned(FJSON) then
    FreeAndNil(FJSON);
  FJSON := TJSONObject.ParseJSONValue(AJson) as TJSONObject;
end;

class procedure TBaseJson.UnSupported;
begin
  raise Exception.Create('Método do Telegram não suportado na Biblioteca TelegAPi. Desculpe!');
end;

procedure TBaseJson.Write(const AKey, AValue: string);
var
  JoX: TJSONPair;
begin
  JoX := FJSON.GetValue<TJSONPair>(AKey);
  if Assigned(JoX.JsonValue) then
    JoX.JsonValue.Free;
  JoX.JsonValue := TJSONString.Create(AValue);
end;

end.


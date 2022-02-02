unit TinjectTelegram.Types.ReplyMarkups;
interface
uses
  REST.Json.Types,
  TInjectTelegram.Types;
type
  TtdButtonBase = class
  private
    [JSONName('text')]
    FText: string;
  public
    property Text: string read FText write FText;
  end;
  TtdKeyboardButtonPollType = class
  private
    [JSONName('type')]
    FType: string;
  public
    property &Type: string read FType write FType;
    constructor Create(const AType: string); overload;
  end;
  TtdInlineKeyboardButton = class(TtdButtonBase)
  private
    [JSONName('callback_data')]
    FCallbackData: string;
    [JSONName('pay')]
    FPay: Boolean;
    [JSONName('url')]
    FURL: string;
    [JSONName('loginurl')]
    FLoginURL : ItdLoginURL;
    [JSONName('switch_inline_query')]
    FSwitchInlineQuery: string;
    [JSONName('switch_inline_query_current_chat')]
    FSwitchInlineQueryCurrentChat: string;
    [JSONName('callback_game')]
    FCallbackGame: string;
  public
    constructor Create(const AText: string); overload;
    constructor Create(const AText, ACallbackData: string); overload;
    property Url: string read FURL write FURL;
    property LoginURL : ItdLoginURL read FLoginURL write FLoginURL;
    property CallbackData: string read FCallbackData write FCallbackData;
    property SwitchInlineQuery: string read FSwitchInlineQuery write FSwitchInlineQuery;
    property SwitchInlineQueryCurrentChat: string read
      FSwitchInlineQueryCurrentChat write FSwitchInlineQueryCurrentChat;
    property CallbackGame: string read FCallbackGame write FCallbackGame;
    property Pay: Boolean read FPay write FPay;
  end;
  TtdKeyboardButton = class(TtdButtonBase)
  private
    [JSONName('request_location')]
    FRequestLocation: Boolean;
    [JSONName('request_contact')]
    FRequestContact: Boolean;
    FRequestPoll : TtdKeyboardButtonPollType;
  public
    constructor Create(Const ARequestPoll: TtdKeyboardButtonPollType; AText: string; ARequestContact: Boolean = False;
      ARequestLocation: Boolean = False); overload;
    constructor Create(const AText: string; ARequestContact: Boolean = False;
      ARequestLocation: Boolean = False); overload;
    property RequestContact: Boolean read FRequestContact write FRequestContact;
    property RequestLocation: Boolean read FRequestLocation write FRequestLocation;
    [JSONName('request_poll')] //Resolvido
    property RequestPoll : TtdKeyboardButtonPollType read FRequestPoll write FRequestPoll;
  end;
  TtdReplyMarkup = class abstract(TInterfacedObject, IReplyMarkup)
  private
    [JSONName('selective')]
    FSelective: Boolean;
  public
    property Selective: Boolean read FSelective write FSelective;
  end;
  TtdForceReply = class(TtdReplyMarkup)
  private
    [JSONName('force_reply')]
    FForce: Boolean;
    [JSONName('input_field_placeholder')]
    FInputFieldPlaceholder: String;
  public
    property Force: Boolean read FForce write FForce;
    property InputFieldPlaceholder: String read FInputFieldPlaceholder write FInputFieldPlaceholder;
  end;
  TtdInlineKeyboardMarkup = class(TInterfacedObject, IReplyMarkup)
  private
    [JSONName('inline_keyboard')]
    FKeyboard: TArray<TArray<TtdInlineKeyboardButton>>;
  public
    procedure AddRow(AKeyboardRow: TArray<TtdInlineKeyboardButton>);
    constructor Create; overload;
    constructor Create(AInlineKeyboardRow: TArray<TtdInlineKeyboardButton>); overload;
    constructor Create(AInlineKeyboard: TArray<TArray<TtdInlineKeyboardButton>>);
      overload;
    destructor Destroy; override;
    property Keyboard: TArray<TArray<TtdInlineKeyboardButton>> read FKeyboard
      write FKeyboard;
  end;
  TtdReplyKeyboardMarkup = class(TtdReplyMarkup)
  private
    [JSONName('resize_keyboard')]
    FResizeKeyboard: Boolean;
    [JSONName('one_time_keyboard')]
    FOneTimeKeyboard: Boolean;
    [JSONName('selective')]
    FSelective: Boolean;
    [JSONName('keyboard')]
    FKeyboard: TArray<TArray<TtdKeyboardButton>>;
    [JSONName('input_field_placeholder')]
    FInputFieldPlaceholder: String;
  public
    procedure AddRow(AKeyboardRow: TArray<TtdKeyboardButton>);
    constructor Create(AResizeKeyboard, AOneTimeKeyboard: Boolean); overload;
    constructor Create(AKeyboardRow: TArray<TtdKeyboardButton>; AResizeKeyboard:
      Boolean = False; AOneTimeKeyboard: Boolean = False); overload;
    constructor Create(AKeyboard: TArray<TArray<TtdKeyboardButton>>;
      AResizeKeyboard: Boolean = False; AOneTimeKeyboard: Boolean = False); overload;
    destructor Destroy; override;
    property Keyboard: TArray<TArray<TtdKeyboardButton>> read FKeyboard write FKeyboard;
    property OneTimeKeyboard: Boolean read FOneTimeKeyboard write FOneTimeKeyboard;
    property ResizeKeyboard: Boolean read FResizeKeyboard write FResizeKeyboard;
    property Selective: Boolean read FSelective write FSelective;
    property InputFieldPlaceholder: String read FInputFieldPlaceholder write FInputFieldPlaceholder;
  end;
  TtdReplyKeyboardRemove = class(TtdReplyMarkup)
  private
    [JSONName('remove_keyboard')]
    FRemoveKeyboard: Boolean;
  public
    constructor Create(ARemoveKeyboard: Boolean = True);
    property RemoveKeyboard: Boolean read FRemoveKeyboard write FRemoveKeyboard;
  end;
implementation
uses
  System.SysUtils;
constructor TtdInlineKeyboardButton.Create(const AText: string);
begin
  Text := AText;
end;
constructor TtdInlineKeyboardButton.Create(const AText, ACallbackData: string);
begin
  Self.Create(AText);
  Self.CallbackData := ACallbackData;
end;
constructor TtdKeyboardButton.Create(Const ARequestPoll: TtdKeyboardButtonPollType; AText: string; ARequestContact: Boolean = False;
      ARequestLocation: Boolean = False);
begin
  inherited Create;
  Self.Text := AText;
  Self.RequestContact := ARequestContact;
  Self.RequestLocation := ARequestLocation;
  if ARequestPoll <> nil then
  Begin
    Self.RequestPoll := ARequestPoll;
  End;
end;
constructor TtdInlineKeyboardMarkup.Create(AInlineKeyboardRow: TArray<
  TtdInlineKeyboardButton>);
begin
  inherited Create;
  AddRow(AInlineKeyboardRow);
end;
procedure TtdInlineKeyboardMarkup.AddRow(AKeyboardRow: TArray<TtdInlineKeyboardButton>);
begin
  SetLength(FKeyboard, Length(FKeyboard) + 1);
  FKeyboard[High(FKeyboard)] := AKeyboardRow;
end;
constructor TtdInlineKeyboardMarkup.Create(AInlineKeyboard: TArray<TArray<
  TtdInlineKeyboardButton>>);
var
  i: Integer;
begin
  Self.Create;
  for i := Low(AInlineKeyboard) to High(AInlineKeyboard) do
    AddRow(AInlineKeyboard[i]);
end;
destructor TtdInlineKeyboardMarkup.Destroy;
var
  i, j: Integer;
begin
  for i := Low(FKeyboard) to High(FKeyboard) do
    for j := Low(FKeyboard[i]) to High(FKeyboard[i]) do
      FKeyboard[i, j].Free;
  inherited;
end;
constructor TtdInlineKeyboardMarkup.Create;
begin
  inherited Create;
end;
constructor TtdReplyKeyboardMarkup.Create(AKeyboardRow: TArray<TtdKeyboardButton
  >; AResizeKeyboard, AOneTimeKeyboard: Boolean);
begin
  inherited Create;
  AddRow(AKeyboardRow);
  ResizeKeyboard := AResizeKeyboard;
  OneTimeKeyboard := AOneTimeKeyboard;
end;
procedure TtdReplyKeyboardMarkup.AddRow(AKeyboardRow: TArray<TtdKeyboardButton>);
begin
  SetLength(FKeyboard, Length(FKeyboard) + 1);
  FKeyboard[High(FKeyboard)] := AKeyboardRow;
end;
constructor TtdReplyKeyboardMarkup.Create(AKeyboard: TArray<TArray<
  TtdKeyboardButton>>; AResizeKeyboard, AOneTimeKeyboard: Boolean);
begin
  inherited Create;
  Keyboard := AKeyboard;
  ResizeKeyboard := AResizeKeyboard;
  OneTimeKeyboard := AOneTimeKeyboard;
end;
destructor TtdReplyKeyboardMarkup.Destroy;
var
  i, j: Integer;
begin
  for i := Low(FKeyboard) to High(FKeyboard) do
    for j := Low(FKeyboard[i]) to High(FKeyboard[i]) do
      FKeyboard[i, j].Free;
  inherited;
end;

constructor TtdReplyKeyboardMarkup.Create(AResizeKeyboard, AOneTimeKeyboard: Boolean);
begin
  inherited Create;
  ResizeKeyboard := AResizeKeyboard;
  OneTimeKeyboard := AOneTimeKeyboard;
end;
constructor TtdReplyKeyboardRemove.Create(ARemoveKeyboard: Boolean);
begin
  inherited Create;
  RemoveKeyboard := ARemoveKeyboard;
end;
{ TtdKeyboardButtonPollType }

constructor TtdKeyboardButtonPollType.Create(const AType: string);
begin
  &Type := AType;
end;

constructor TtdKeyboardButton.Create(const AText: string; ARequestContact,
  ARequestLocation: Boolean);
begin
  inherited Create;
  Self.Text := AText;
  Self.RequestContact := ARequestContact;
  Self.RequestLocation := ARequestLocation;
end;

end.

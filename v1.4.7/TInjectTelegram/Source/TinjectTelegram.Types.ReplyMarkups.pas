unit TinjectTelegram.Types.ReplyMarkups;
interface
uses
  REST.Json.Types,
  TInjectTelegram.Types,
  TinjectTelegram.Types.Impl,
  TinjectTelegram.Utils.JSON;
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

  TtdKeyboardButtonRequestUsers = class
  private
    [JSONName('request_id')]
    Frequest_id: string;
    [JSONName('user_is_bot')]
    Fuser_is_bot: string;
    [JSONName('user_is_premium')]
    Fuser_is_premium: string;
    [JSONName('max_quantity')]
    Fmax_quantity: Integer;
  public
    property request_id: string read Frequest_id write Frequest_id;
    property user_is_bot: string read Fuser_is_bot write Fuser_is_bot;
    property user_is_premium: string read Fuser_is_premium write Fuser_is_premium;
    property max_quantity: Integer read Fmax_quantity write Fmax_quantity;
    constructor Create(const Arequest_id: string); overload;
  end;

  TtdKeyboardButtonRequestChat = class
  private
    Fchat_is_created: boolean;
    [JSONName('request_id')]
    Frequest_id: integer;
    Fbot_is_member: boolean;
    Fuser_administrator_rights: TtdChatAdministratorRights;
    Fchat_has_username: boolean;
    Fchat_is_forum: boolean;
    Fbot_administrator_rights: TtdChatAdministratorRights;
    Fchat_is_channel: boolean;
  public
    property request_id: integer read Frequest_id write Frequest_id;
    property chat_is_channel: boolean read Fchat_is_channel write Fchat_is_channel;
    property chat_is_forum: boolean read Fchat_is_forum write Fchat_is_forum;
    property chat_has_username: boolean read Fchat_has_username write Fchat_has_username;
    property chat_is_created: boolean read Fchat_is_created write Fchat_is_created;
    property user_administrator_rights: TtdChatAdministratorRights read Fuser_administrator_rights write Fuser_administrator_rights;
    property bot_administrator_rights: TtdChatAdministratorRights read Fbot_administrator_rights write Fbot_administrator_rights;
    property bot_is_member: boolean read Fbot_is_member write Fbot_is_member;
    constructor Create(const Arequest_id: integer); overload;
  end;

  TtdInlineKeyboardButton = class(TInterfacedObject, IReplyMarkup)
  private
    [JSONName('text')]
    FText: string;
    [JSONName('url')]
    FURL: string;
    [JSONName('callback_data')]
    FCallbackData: string;
    [JSONName('web_app')]
    FWebApp: TtdWebAppInfo;
    [JSONName('login_url')]
    FLoginURL : ItdLoginURL;
    [JSONName('switch_inline_query')]
    FSwitchInlineQuery: string;
    [JSONName('switch_inline_query_current_chat')]
    FSwitchInlineQueryCurrentChat: string;
    [JSONName('switch_inline_query_chosen_chat')]
    FSwitchInlineQueryChosenChat: ItdSwitchInlineQueryChosenChat;
    [JSONName('callback_game')]
    FCallbackGame: string;
    [JSONName('pay')]
    FPay: Boolean;
  public
    constructor Create(const AText: string); overload;
    constructor Create(const AText, ACallbackData: string); overload;
    constructor Create(const AText, ACallbackData: string; url: string); overload;
    constructor Create(const AText: string; AWebApp: TtdWebAppInfo); overload;
    property Text: string read FText write FText;
    property Url: string read FURL write FURL;
    property CallbackData: string read FCallbackData write FCallbackData;
    property WebApp: TtdWebAppInfo read FWebApp write FWebApp;
    property LoginURL : ItdLoginURL read FLoginURL write FLoginURL;
    property SwitchInlineQuery: string read FSwitchInlineQuery write FSwitchInlineQuery;
    property SwitchInlineQueryCurrentChat: string read
      FSwitchInlineQueryCurrentChat write FSwitchInlineQueryCurrentChat;
    property SwitchInlineQueryChosenChat: ItdSwitchInlineQueryChosenChat read FSwitchInlineQueryChosenChat write FSwitchInlineQueryChosenChat;
    property CallbackGame: string read FCallbackGame write FCallbackGame;
    property Pay: Boolean read FPay write FPay;

  end;

  TtdInlineKeyboardWebAppButton = class(TInterfacedObject, IReplyMarkup)
  private
    [JSONName('text')]
    FText: string;
    [JSONName('web_app')]
    FWebApp: TtdWebAppInfo;
  public
    constructor Create(const AText: string; AWebApp: TtdWebAppInfo); overload;
    property Text: string read FText write FText;
    property WebApp: TtdWebAppInfo read FWebApp write FWebApp;
  end;

  TtdKeyboardButton = class (TInterfacedObject, IReplyMarkup){= class(TtdButtonBase)}
  private
    [JSONName('text')]
    FText: string;
    [JSONName('request_location')]
    FRequestLocation: Boolean;
    [JSONName('request_contact')]
    FRequestContact: Boolean;
    FRequestPoll : TtdKeyboardButtonPollType;
    FRequestUser: TtdKeyboardButtonRequestUsers;
    FRequestChat: TtdKeyboardButtonRequestChat;
  public
    constructor Create(Const ARequestPoll: TtdKeyboardButtonPollType; AText: string; ARequestContact: Boolean = False;
      ARequestLocation: Boolean = False); overload;
    constructor Create(const AText: string; ARequestContact: Boolean = False;
      ARequestLocation: Boolean = False); overload;
    [JSONName('request_users')]
    property RequestUser: TtdKeyboardButtonRequestUsers read FRequestUser write FRequestUser;
    [JSONName('request_chat')]
    property RequestChat: TtdKeyboardButtonRequestChat read FRequestChat write FRequestChat;

    property RequestContact: Boolean read FRequestContact write FRequestContact;
    property RequestLocation: Boolean read FRequestLocation write FRequestLocation;
    [JSONName('request_poll')] //Resolvido
    property RequestPoll : TtdKeyboardButtonPollType read FRequestPoll write FRequestPoll;
    property Text: string read FText write FText;
  end;

  TtdKeyboardWebAppButton = class (TtdKeyboardButton){= class(TtdButtonBase)}
  private
    [JSONName('web_app')]
    FWebApp: TtdWebAppInfo;
  public
    constructor Create(const AText: string; AWebApp: TtdWebAppInfo); overload;
    property WebApp: TtdWebAppInfo read FWebApp write FWebApp;
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
    procedure AddRow(AKeyboardRow: TArray<TtdInlineKeyboardButton>); overload;
    constructor Create; overload;
    constructor Create(AInlineKeyboardRow: TArray<TtdInlineKeyboardButton>); overload;
    constructor Create(AInlineKeyboard: TArray<TArray<TtdInlineKeyboardButton>>);
      overload;
    destructor Destroy; override;
    property Keyboard: TArray<TArray<TtdInlineKeyboardButton>> read FKeyboard
      write FKeyboard;
  end;

  TtdInlineKeyboardMarkupWebApp = class(TInterfacedObject, IReplyMarkup)
  private
    [JSONName('inline_keyboard')]
    FKeyboard: TArray<TArray<TtdInlineKeyboardWebAppButton>>;
  public
    procedure AddRow(AKeyboardRow: TArray<TtdInlineKeyboardWebAppButton>); overload;
    constructor Create; overload;
    constructor Create(AInlineKeyboardRow: TArray<TtdInlineKeyboardWebAppButton>); overload;
    constructor Create(AInlineKeyboard: TArray<TArray<TtdInlineKeyboardWebAppButton>>);
      overload;
    destructor Destroy; override;
    property Keyboard: TArray<TArray<TtdInlineKeyboardWebAppButton>> read FKeyboard
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
    [JSONName('is_persistent')]
    FIsPersistent: Boolean;
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
    property IsPersistent: Boolean read FIsPersistent write FIsPersistent;
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
  Self.Text := AText;
  Self.RequestContact := ARequestContact;
  Self.RequestLocation := ARequestLocation;
  inherited Create;
end;
constructor TtdInlineKeyboardButton.Create(const AText, ACallbackData: string;
  url: string);
begin
  Self.Create(AText);
  Self.CallbackData := ACallbackData;
  Self.Url := url;
end;

{ TtdInlineKeyboardWebAppButton }

constructor TtdInlineKeyboardWebAppButton.Create(const AText: string;
  AWebApp: TtdWebAppInfo);
begin
  Text := AText;
  WebApp := AWebApp;
end;

{ TtdKeyboardWebAppButton }

constructor TtdKeyboardWebAppButton.Create(const AText: string;
  AWebApp: TtdWebAppInfo);
begin
  Self.Create(AText);
  Self.FWebApp := AWebApp;
end;

constructor TtdInlineKeyboardButton.Create(const AText: string;
  AWebApp: TtdWebAppInfo);
begin
  WebApp := AWebApp;
  Text := AText;;
end;

{ TtdKeyboardButtonRequestUser }

constructor TtdKeyboardButtonRequestUsers.Create(const Arequest_id: string);
begin
  Frequest_id := Arequest_id;
end;

{ TtdKeyboardButtonRequestChat }

constructor TtdKeyboardButtonRequestChat.Create(const Arequest_id: integer);
begin
  Frequest_id := Arequest_id;
end;

{ TtdInlineKeyboardMarkupWebApp }

procedure TtdInlineKeyboardMarkupWebApp.AddRow(
  AKeyboardRow: TArray<TtdInlineKeyboardWebAppButton>);
begin
  SetLength(FKeyboard, Length(FKeyboard) + 1);
  FKeyboard[High(FKeyboard)] := AKeyboardRow;
end;

constructor TtdInlineKeyboardMarkupWebApp.Create;
begin
  inherited Create;
end;

constructor TtdInlineKeyboardMarkupWebApp.Create(
  AInlineKeyboard: TArray<TArray<TtdInlineKeyboardWebAppButton>>);
var
  i: Integer;
begin
  Self.Create;
  for i := Low(AInlineKeyboard) to High(AInlineKeyboard) do
    AddRow(AInlineKeyboard[i]);

end;

constructor TtdInlineKeyboardMarkupWebApp.Create(
  AInlineKeyboardRow: TArray<TtdInlineKeyboardWebAppButton>);
begin
  inherited Create;
  AddRow(AInlineKeyboardRow);
end;

destructor TtdInlineKeyboardMarkupWebApp.Destroy;
var
  i, j: Integer;
begin
  for i := Low(FKeyboard) to High(FKeyboard) do
    for j := Low(FKeyboard[i]) to High(FKeyboard[i]) do
      FKeyboard[i, j].Free;
  inherited;
end;

end.

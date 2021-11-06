unit TinjectTelegram.Receiver.Manager.Base;
interface
uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  TInjectTelegram.UpdateParser,
  TInjectTelegram.Bot,
  TInjectTelegram.Bot.Impl,
  TInjectTelegram.Types,
  TInjectTelegram.Types.Enums,
  TInjectTelegram.Bot.Chat;
type
  TtdOnRuning = procedure(AChatBot: TInjectTelegramChatBot) of object;

  TtdOnUpdate = procedure(ASender: TObject; AUpdate: ItdUpdate) of object;
  TtdOnUpdates = procedure(ASender: TObject; AUpdates: TArray<ItdUpdate>) of object;
  TtdOnMessage = procedure(ASender: TObject; AMessage: ItdMessage) of object;
  TtdOnInlineQuery = procedure(ASender: TObject; AInlineQuery: ItdInlineQuery) of object;
  TtdOnInlineResultChosen = procedure(ASender: TObject; AChosenInlineResult: ItdChosenInlineResult) of object;
  TtdOnCallbackQuery = procedure(ASender: TObject; ACallbackQuery: ItdCallbackQuery) of object;
  TtdOnChannelPost = procedure(ASender: TObject; AChanelPost: ItdMessage) of object;
  TtdOnShippingQuery = procedure(ASender: TObject; AShippingQuery: ItdShippingQuery) of object;
  TtdOnPreCheckoutQuery = procedure(ASender: TObject; APreCheckoutQuery: ItdPreCheckoutQuery) of object;
  TtdOnPollStatus = procedure(ASender: TObject; APoll: ItdPoll) of object;
  TtdOnPollAnswer = procedure(ASender: TObject; APollAnswer: ItdPollAnswer) of object;
  TtdOnMyChatMember = procedure(ASender: TObject; AMyChatMember: ItdChatMemberUpdated) of object;
  TtdOnChatMember = procedure(ASender: TObject; AChatMember: ItdChatMemberUpdated) of object;
  {TInjectTelegramBotReceiverManagerBase}
  TInjectTelegramBotReceiverManagerBase = class(TInjectTelegramBotUpdateParser)
  private
    FBotDonor: TInjectTelegramBot;
    FAllowedUpdates: TAllowedUpdates;
    FMessageOffset: Int64;
    FPollingInterval: Integer;
    FThread: TThread;
    FIsActive: Boolean;
    FConversas: TObjectList<TInjectTelegramChatBot>;
    FConversa: TInjectTelegramChatBot;    procedure SetIsActive(const AValue: Boolean);
  protected
    function ReadUpdates: TArray<ItdUpdate>; virtual;
    procedure Go; virtual;
    //Ruan Diego
    procedure DoOnRuning(AChatBot: TInjectTelegramChatBot); virtual; abstract;
    procedure DoOnStart; virtual; abstract;
    procedure DoOnStop; virtual; abstract;
    procedure DoOnUpdates(AUpdates: TArray<ItdUpdate>); virtual; abstract;
    procedure DoOnUpdate(AUpdate: ItdUpdate); virtual; abstract;
    procedure DoOnMessage(AMessage: ItdMessage); virtual; abstract;
    procedure DoOnInlineQuery(AInlineQuery: ItdInlineQuery); virtual; abstract;
    procedure DoOnChosenInlineResult(AChosenInlineResult: ItdChosenInlineResult); virtual; abstract;
    procedure DoOnEditedMessage(AEditedMessage: ItdMessage); virtual; abstract;
    procedure DoOnChannelPost(AChannelPost: ItdMessage); virtual; abstract;
    procedure DoOnEditedChannelPost(AEditedChannelPost: ItdMessage); virtual; abstract;
    procedure DoOnShippingQuery(AShippingQuery: ItdShippingQuery); virtual; abstract;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: ItdPreCheckoutQuery); virtual; abstract;
    procedure DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery); virtual; abstract;
    procedure DoOnPollStatus(APoll: ItdPoll); virtual; abstract;
    procedure DoOnPollAnswer(APollAnswer: ItdPollAnswer); virtual; abstract;
    procedure DoOnChatJoinRequest(AChatJoinRequest: ItdChatJoinRequest); virtual; abstract;
    procedure DoOnMyChatMember(AMyChatMember: ItdChatMemberUpdated); virtual; abstract;
    procedure DoOnChatMember(AChatMember: ItdChatMemberUpdated); virtual; abstract;
    procedure Init; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(ABot: IInjectTelegramBot); reintroduce; overload;
    destructor Destroy; override;
    procedure Start;
    procedure Stop;
    [Default(False)]
    property IsActive: Boolean read FIsActive write SetIsActive;
    property Conversas: TObjectList<TInjectTelegramChatBot> read FConversas;
    property Conversa: TInjectTelegramChatBot read FConversa write FConversa;
  published
    property Bot: TInjectTelegramBot read FBotDonor write FBotDonor;
    [Default(0)]
    property MessageOffset: Int64 read FMessageOffset write FMessageOffset;
    property AllowedUpdates: TAllowedUpdates read FAllowedUpdates write
      FAllowedUpdates default UPDATES_ALLOWED_ALL;
    [Default(1000)]
    property PollingInterval: Integer read FPollingInterval write FPollingInterval;
  end;
implementation

{ TInjectTelegramBotReceiverManagerBase }
constructor TInjectTelegramBotReceiverManagerBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MessageOffset := 0;
  AllowedUpdates := UPDATES_ALLOWED_ALL;
  PollingInterval := 1000;
end;
constructor TInjectTelegramBotReceiverManagerBase.Create(ABot: IInjectTelegramBot);
begin
  Self.Create(nil);
  FBotDonor := ABot as TInjectTelegramBot;
end;
destructor TInjectTelegramBotReceiverManagerBase.Destroy;
begin
 // FBotDonor.Free;
  Stop;
  inherited;
end;
procedure TInjectTelegramBotReceiverManagerBase.Go;
var
  LUpdates: TArray<ItdUpdate>;
begin
  DoOnStart;
  while FIsActive do
  begin
    DoOnRuning(FConversa);
    LUpdates := ReadUpdates;
    if Length(LUpdates) = 0 then
    begin
      Sleep(FPollingInterval);
      Continue;
    end;
    MessageOffset := LUpdates[High(LUpdates)].ID + 1;
    EventParser(LUpdates);
    Sleep(FPollingInterval);
  end;
  DoOnStop;
end;
function TInjectTelegramBotReceiverManagerBase.ReadUpdates: TArray<ItdUpdate>;
var
  LBot: TInjectTelegramBot;
begin
  LBot := TInjectTelegramBot.Create(Self);
  try
    FBotDonor.AssignTo(LBot);
    Result := LBot.GetUpdates(MessageOffset, 100, 0, AllowedUpdates);
  except
    on E: Exception do
      Bot.Logger.Fatal('TInjectTelegramBotReceiverManagerBase.ReadUpdates', E)
  end;
end;
procedure TInjectTelegramBotReceiverManagerBase.SetIsActive(const AValue: Boolean);
begin
  if FIsActive = AValue then
    Exit;
  FIsActive := AValue;
  if AValue then
  begin
    FThread := TThread.CreateAnonymousThread(Go);
    FThread.FreeOnTerminate := False;
    FThread.Start;
  end
  else
    FreeAndNil(FThread);
end;
procedure TInjectTelegramBotReceiverManagerBase.Start;
begin
  IsActive := True;
end;
procedure TInjectTelegramBotReceiverManagerBase.Stop;
begin
  IsActive := False;
end;
end.

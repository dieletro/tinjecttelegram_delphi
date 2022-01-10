unit TinjectTelegram.Receiver.Console;
interface
uses
  TInjectTelegram.Receiver.Base,
  TInjectTelegram.Types,
  System.SysUtils;
type
  TInjectTelegramReceiverConsole = class(TInjectTelegramBotReceiverBase)
  private
    FOnStart: TProc;
    FOnStop: TProc;
    FOnUpdates: TProc<TArray<ItdUpdate>>;
    FOnUpdate: TProc<ItdUpdate>;
    FOnMessage: TProc<ItdMessage>;
    FOnInlineQuery: TProc<ItdInlineQuery>;
    FOnChosenInlineResult: TProc<ItdChosenInlineResult>;
    FOnEditedMessage: TProc<ItdMessage>;
    FOnChannelPost: TProc<ItdMessage>;
    FOnEditedChannelPost: TProc<ItdMessage>;
    FOnShippingQuery: TProc<ItdShippingQuery>;
    FOnPreCheckoutQuery: TProc<ItdPreCheckoutQuery>;
    FOnOnCallbackQuery: TProc<ItdCallbackQuery>;
    FOnPollStatus: TProc<ItdPoll>;
    FOnPollAnswer: TProc<ItdPollAnswer>;
    FOnMyChatMember: TProc<ItdChatMemberUpdated>;
    FOnChatMember: TProc<ItdChatMemberUpdated>;
  protected
    procedure DoOnStart; override;
    procedure DoOnStop; override;
    procedure DoOnUpdates(AUpdates: TArray<ItdUpdate>); override;
    procedure DoOnUpdate(AUpdate: ItdUpdate); override;
    procedure DoOnMessage(AMessage: ItdMessage); override;
    procedure DoOnInlineQuery(AInlineQuery: ItdInlineQuery); override;
    procedure DoOnChosenInlineResult(AChosenInlineResult: ItdChosenInlineResult); override;
    procedure DoOnEditedMessage(AEditedMessage: ItdMessage); override;
    procedure DoOnChannelPost(AChannelPost: ItdMessage); override;
    procedure DoOnEditedChannelPost(AEditedChannelPost: ItdMessage); override;
    procedure DoOnShippingQuery(AShippingQuery: ItdShippingQuery); override;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: ItdPreCheckoutQuery); override;
    procedure DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery); override;
    procedure DoOnPollStatus(APoll: ItdPoll); override;
    procedure DoOnPollAnswer(APollAnswer: ItdPollAnswer); override;
    procedure DoOnMyChatMember(AMyChatMember: ItdChatMemberUpdated); override;
    procedure DoOnChatMember(AChatMember: ItdChatMemberUpdated); override;
  public
    property OnStart: TProc read FOnStart write FOnStart;
    property OnStop: TProc read FOnStop write FOnStop;
    property OnUpdates: TProc<TArray<ItdUpdate>> read FOnUpdates write FOnUpdates;
    property OnUpdate: TProc<ItdUpdate> read FOnUpdate write FOnUpdate;
    property OnMessage: TProc<ItdMessage> read FOnMessage write FOnMessage;
    property OnInlineQuery: TProc<ItdInlineQuery> read FOnInlineQuery write FOnInlineQuery;
    property OnChosenInlineResult: TProc<ItdChosenInlineResult> read FOnChosenInlineResult write FOnChosenInlineResult;
    property OnEditedMessage: TProc<ItdMessage> read FOnEditedMessage write FOnEditedMessage;
    property OnChannelPost: TProc<ItdMessage> read FOnChannelPost write FOnChannelPost;
    property OnEditedChannelPost: TProc<ItdMessage> read FOnEditedChannelPost write FOnEditedChannelPost;
    property OnShippingQuery: TProc<ItdShippingQuery> read FOnShippingQuery write FOnShippingQuery;
    property OnPreCheckoutQuery: TProc<ItdPreCheckoutQuery> read FOnPreCheckoutQuery write FOnPreCheckoutQuery;
    property OnCallbackQuery: TProc<ItdCallbackQuery> read FOnOnCallbackQuery write FOnOnCallbackQuery;
    property OnPollStatus: TProc<ItdPoll> read FOnPollStatus write FOnPollStatus;
    property OnPollAnswer: TProc<ItdPollAnswer> read FOnPollAnswer write FOnPollAnswer;
    property OnMyChatMember: TProc<ItdChatMemberUpdated> read FOnMyChatMember write FOnMyChatMember;
    property OnChatMember:   TProc<ItdChatMemberUpdated> read FOnChatMember write FOnChatMember;
  end;
implementation
{ TInjectTelegramReceiverConsole }
procedure TInjectTelegramReceiverConsole.DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery);
begin
  inherited;
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(ACallbackQuery);
end;
procedure TInjectTelegramReceiverConsole.DoOnChannelPost(AChannelPost: ItdMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(AChannelPost);
end;
procedure TInjectTelegramReceiverConsole.DoOnChatMember(
  AChatMember: ItdChatMemberUpdated);
begin
  inherited;
  if Assigned(OnChatMember) then
    OnChatMember(AChatMember);
end;

procedure TInjectTelegramReceiverConsole.DoOnChosenInlineResult(AChosenInlineResult: ItdChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(AChosenInlineResult);
end;
procedure TInjectTelegramReceiverConsole.DoOnEditedChannelPost(AEditedChannelPost: ItdMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(AEditedChannelPost);
end;
procedure TInjectTelegramReceiverConsole.DoOnEditedMessage(AEditedMessage: ItdMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(AEditedMessage);
end;
procedure TInjectTelegramReceiverConsole.DoOnInlineQuery(AInlineQuery: ItdInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(AInlineQuery);
end;
procedure TInjectTelegramReceiverConsole.DoOnMessage(AMessage: ItdMessage);
begin
  inherited;
  if Assigned(OnMessage) then
    OnMessage(AMessage);
end;
procedure TInjectTelegramReceiverConsole.DoOnMyChatMember(
  AMyChatMember: ItdChatMemberUpdated);
begin
  inherited;
  if Assigned(OnMyChatMember) then
    OnMyChatMember(AMyChatMember);
end;

procedure TInjectTelegramReceiverConsole.DoOnPollAnswer(
  APollAnswer: ItdPollAnswer);
begin
  inherited;
  if Assigned(OnPollAnswer) then
    OnPollAnswer(APollAnswer);
end;

procedure TInjectTelegramReceiverConsole.DoOnPollStatus(
  APoll: ItdPoll);
begin
  inherited;
  if Assigned(OnPollStatus) then
    OnPollStatus(APoll);
end;

procedure TInjectTelegramReceiverConsole.DoOnPreCheckoutQuery(APreCheckoutQuery: ItdPreCheckoutQuery);
begin
  inherited;
  if Assigned(OnPreCheckoutQuery) then
    OnPreCheckoutQuery(APreCheckoutQuery);
end;
procedure TInjectTelegramReceiverConsole.DoOnShippingQuery(AShippingQuery: ItdShippingQuery);
begin
  inherited;
  if Assigned(OnShippingQuery) then
    OnShippingQuery(AShippingQuery);
end;
procedure TInjectTelegramReceiverConsole.DoOnStart;
begin
  inherited;
  if Assigned(OnStart) then
    OnStart();
end;
procedure TInjectTelegramReceiverConsole.DoOnStop;
begin
  inherited;
  if Assigned(OnStop) then
    OnStop();
end;
procedure TInjectTelegramReceiverConsole.DoOnUpdate(AUpdate: ItdUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(AUpdate);
end;
procedure TInjectTelegramReceiverConsole.DoOnUpdates(AUpdates: TArray<ItdUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(AUpdates);
end;
end.

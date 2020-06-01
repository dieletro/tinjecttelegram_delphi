unit TelegAPI.Receiver.Console;

interface

uses
  TelegAPI.Receiver.Base,
  TelegAPI.Types,
  System.SysUtils;

type
  TInjectTelegramReceiverConsole = class(TInjectTelegramBotReceiverBase)
  private
    FOnStart: TProc;
    FOnStop: TProc;
    FOnUpdates: TProc<TArray<ItgUpdate>>;
    FOnUpdate: TProc<ItgUpdate>;
    FOnMessage: TProc<ITgMessage>;
    FOnInlineQuery: TProc<ItgInlineQuery>;
    FOnChosenInlineResult: TProc<ItgChosenInlineResult>;
    FOnEditedMessage: TProc<ITgMessage>;
    FOnChannelPost: TProc<ITgMessage>;
    FOnEditedChannelPost: TProc<ITgMessage>;
    FOnShippingQuery: TProc<ItgShippingQuery>;
    FOnPreCheckoutQuery: TProc<ItgPreCheckoutQuery>;
    FOnOnCallbackQuery: TProc<ItgCallbackQuery>;
    FOnPollStatus: TProc<ItgPoll>;
    FOnPollAnswer: TProc<ItgPollAnswer>;
  protected
    procedure DoOnStart; override;
    procedure DoOnStop; override;
    procedure DoOnUpdates(AUpdates: TArray<ItgUpdate>); override;
    procedure DoOnUpdate(AUpdate: ItgUpdate); override;
    procedure DoOnMessage(AMessage: ITgMessage); override;
    procedure DoOnInlineQuery(AInlineQuery: ItgInlineQuery); override;
    procedure DoOnChosenInlineResult(AChosenInlineResult: ItgChosenInlineResult); override;
    procedure DoOnEditedMessage(AEditedMessage: ITgMessage); override;
    procedure DoOnChannelPost(AChannelPost: ITgMessage); override;
    procedure DoOnEditedChannelPost(AEditedChannelPost: ITgMessage); override;
    procedure DoOnShippingQuery(AShippingQuery: ItgShippingQuery); override;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: ItgPreCheckoutQuery); override;
    procedure DoOnCallbackQuery(ACallbackQuery: ItgCallbackQuery); override;
    procedure DoOnPollStatus(APoll: ItgPoll); override;
    procedure DoOnPollAnswer(APollAnswer: ItgPollAnswer); override;
  public
    property OnStart: TProc read FOnStart write FOnStart;
    property OnStop: TProc read FOnStop write FOnStop;
    property OnUpdates: TProc<TArray<ItgUpdate>> read FOnUpdates write FOnUpdates;
    property OnUpdate: TProc<ItgUpdate> read FOnUpdate write FOnUpdate;
    property OnMessage: TProc<ITgMessage> read FOnMessage write FOnMessage;
    property OnInlineQuery: TProc<ItgInlineQuery> read FOnInlineQuery write FOnInlineQuery;
    property OnChosenInlineResult: TProc<ItgChosenInlineResult> read FOnChosenInlineResult write FOnChosenInlineResult;
    property OnEditedMessage: TProc<ITgMessage> read FOnEditedMessage write FOnEditedMessage;
    property OnChannelPost: TProc<ITgMessage> read FOnChannelPost write FOnChannelPost;
    property OnEditedChannelPost: TProc<ITgMessage> read FOnEditedChannelPost write FOnEditedChannelPost;
    property OnShippingQuery: TProc<ItgShippingQuery> read FOnShippingQuery write FOnShippingQuery;
    property OnPreCheckoutQuery: TProc<ItgPreCheckoutQuery> read FOnPreCheckoutQuery write FOnPreCheckoutQuery;
    property OnCallbackQuery: TProc<ItgCallbackQuery> read FOnOnCallbackQuery write FOnOnCallbackQuery;
    property OnPollStatus: TProc<ItgPoll> read FOnPollStatus write FOnPollStatus;
    property OnPollAnswer: TProc<ItgPollAnswer> read FOnPollAnswer write FOnPollAnswer;
  end;

implementation

{ TInjectTelegramReceiverConsole }

procedure TInjectTelegramReceiverConsole.DoOnCallbackQuery(ACallbackQuery: ItgCallbackQuery);
begin
  inherited;
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(ACallbackQuery);
end;

procedure TInjectTelegramReceiverConsole.DoOnChannelPost(AChannelPost: ITgMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(AChannelPost);
end;

procedure TInjectTelegramReceiverConsole.DoOnChosenInlineResult(AChosenInlineResult: ItgChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(AChosenInlineResult);
end;

procedure TInjectTelegramReceiverConsole.DoOnEditedChannelPost(AEditedChannelPost: ITgMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(AEditedChannelPost);
end;

procedure TInjectTelegramReceiverConsole.DoOnEditedMessage(AEditedMessage: ITgMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(AEditedMessage);
end;

procedure TInjectTelegramReceiverConsole.DoOnInlineQuery(AInlineQuery: ItgInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(AInlineQuery);
end;

procedure TInjectTelegramReceiverConsole.DoOnMessage(AMessage: ITgMessage);
begin
  inherited;
  if Assigned(OnMessage) then
    OnMessage(AMessage);
end;

procedure TInjectTelegramReceiverConsole.DoOnPollAnswer(
  APollAnswer: ItgPollAnswer);
begin
  inherited;
  if Assigned(OnPollAnswer) then
    OnPollAnswer(APollAnswer);
end;

procedure TInjectTelegramReceiverConsole.DoOnPollStatus(
  APoll: ItgPoll);
begin
  inherited;
  if Assigned(OnPollStatus) then
    OnPollStatus(APoll);
end;

procedure TInjectTelegramReceiverConsole.DoOnPreCheckoutQuery(APreCheckoutQuery: ItgPreCheckoutQuery);
begin
  inherited;
  if Assigned(OnPreCheckoutQuery) then
    OnPreCheckoutQuery(APreCheckoutQuery);
end;

procedure TInjectTelegramReceiverConsole.DoOnShippingQuery(AShippingQuery: ItgShippingQuery);
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

procedure TInjectTelegramReceiverConsole.DoOnUpdate(AUpdate: ItgUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(AUpdate);
end;

procedure TInjectTelegramReceiverConsole.DoOnUpdates(AUpdates: TArray<ItgUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(AUpdates);
end;

end.


unit TinjectTelegram.Receiver.Service;
interface
uses
  System.Classes,
  TInjectTelegram.Receiver.Base,
  TInjectTelegram.Types.Enums,
  TInjectTelegram.Types;
type
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
  TtdOnChatJoinRequest = procedure(ASender: TObject; AChatJoinRequest: ItdChatJoinRequest) of object;
  TtdOnMessageEntityReceiver = procedure(ASender: TObject; AMessageEntityType: TtdMessageEntityType) of object;
  TtdOnWebAppData = procedure(ASender: TObject; AWebAppData: ItdWebAppData) of object;

  TInjectTelegramReceiverService = class(TInjectTelegramBotReceiverBase)
  private
    FOnUpdate: TtdOnUpdate;
    FOnMessage: TtdOnMessage;
    FOnUpdates: TtdOnUpdates;
    FOnStop: TNotifyEvent;
    FOnStart: TNotifyEvent;
    FOnEditedMessage: TtdOnMessage;
    FOnChannelPost: TtdOnMessage;
    FOnPreCheckoutQuery: TtdOnPreCheckoutQuery;
    FOnInlineQuery: TtdOnInlineQuery;
    FOnShippingQuery: TtdOnShippingQuery;
    FOnChosenInlineResult: TtdOnInlineResultChosen;
    FOnEditedChannelPost: TtdOnMessage;
    FOnCallbackQuery: TtdOnCallbackQuery;
    FOnPollStatus: TtdOnPollStatus;
    FOnPollAnswer: TtdOnPollAnswer;
    FOnMyChatMember: TtdOnMyChatMember;
    FOnChatMember: TtdOnChatMember;
    FOnChatJoinRequest: TtdOnChatJoinRequest;
    FOnMessageEntityReceiver: TtdOnMessageEntityReceiver;
    FOnWebAppData: TtdOnWebAppData;
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
    procedure DoOnChatJoinRequest(AChatJoinRequest: ItdChatJoinRequest); override;
    procedure DoOnMessageEntityReceiver(AMessageEntityReceiver: TtdMessageEntityType); override;
    procedure DoOnWebAppData(AWebAppData: ItdWebAppData); override;
  published
    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnStop: TNotifyEvent read FOnStop write FOnStop;
    property OnUpdates: TtdOnUpdates read FOnUpdates write FOnUpdates;
    property OnUpdate: TtdOnUpdate read FOnUpdate write FOnUpdate;
    property OnMessage: TtdOnMessage read FOnMessage write FOnMessage;
    property OnInlineQuery: TtdOnInlineQuery read FOnInlineQuery write FOnInlineQuery;
    property OnChosenInlineResult: TtdOnInlineResultChosen read FOnChosenInlineResult write FOnChosenInlineResult;
    property OnEditedMessage: TtdOnMessage read FOnEditedMessage write FOnEditedMessage;
    property OnChannelPost: TtdOnMessage read FOnChannelPost write FOnChannelPost;
    property OnEditedChannelPost: TtdOnMessage read FOnEditedChannelPost write FOnEditedChannelPost;
    property OnShippingQuery: TtdOnShippingQuery read FOnShippingQuery write FOnShippingQuery;
    property OnPreCheckoutQuery: TtdOnPreCheckoutQuery read FOnPreCheckoutQuery write FOnPreCheckoutQuery;
    property OnCallbackQuery: TtdOnCallbackQuery read FOnCallbackQuery write FOnCallbackQuery;
    property OnPollStatus: TtdOnPollStatus read FOnPollStatus write FOnPollStatus;
    property OnPollAnswer: TtdOnPollAnswer read FOnPollAnswer write FOnPollAnswer;
    property OnMyChatMember: TtdOnMyChatMember read FOnMyChatMember write FOnMyChatMember;
    property OnChatMember:   TtdOnChatMember read FOnChatMember write FOnChatMember;
    property OnChatJoinRequest: TtdOnChatJoinRequest read FOnChatJoinRequest write FOnChatJoinRequest;
    property OnMessageEntityReceiver : TtdOnMessageEntityReceiver read FOnMessageEntityReceiver write FOnMessageEntityReceiver;
    property OnWebAppData: TtdOnWebAppData read FOnWebAppData write FOnWebAppData;
 end;
implementation
{ TInjectTelegramReceiverService }
procedure TInjectTelegramReceiverService.DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery);
begin
  inherited;
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(Self, ACallbackQuery);
end;
procedure TInjectTelegramReceiverService.DoOnChannelPost(AChannelPost: ItdMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(Self, AChannelPost);
end;
procedure TInjectTelegramReceiverService.DoOnChatJoinRequest(
  AChatJoinRequest: ItdChatJoinRequest);
begin
  inherited;
  if Assigned(OnChatJoinRequest) then
    OnChatJoinRequest(Self, AChatJoinRequest);
end;
procedure TInjectTelegramReceiverService.DoOnChatMember(
  AChatMember: ItdChatMemberUpdated);
begin
  inherited;
  if Assigned(OnChatMember) then
    OnChatMember(Self, AChatMember);
end;
procedure TInjectTelegramReceiverService.DoOnChosenInlineResult(AChosenInlineResult: ItdChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(Self, AChosenInlineResult);
end;
procedure TInjectTelegramReceiverService.DoOnEditedChannelPost(AEditedChannelPost: ItdMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(Self, AEditedChannelPost);
end;
procedure TInjectTelegramReceiverService.DoOnEditedMessage(AEditedMessage: ItdMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(Self, AEditedMessage);
end;
procedure TInjectTelegramReceiverService.DoOnInlineQuery(AInlineQuery: ItdInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(Self, AInlineQuery);
end;
procedure TInjectTelegramReceiverService.DoOnMessage(AMessage: ItdMessage);
begin
  inherited;
  if Assigned(OnMessage) then
    OnMessage(Self, AMessage);
end;
procedure TInjectTelegramReceiverService.DoOnMessageEntityReceiver(
  AMessageEntityReceiver: TtdMessageEntityType);
begin
  inherited;
  if Assigned(OnMessageEntityReceiver) then
    OnMessageEntityReceiver(Self, AMessageEntityReceiver);
end;

procedure TInjectTelegramReceiverService.DoOnMyChatMember(
  AMyChatMember: ItdChatMemberUpdated);
begin
  inherited;
  if Assigned(OnMyChatMember) then
    OnMyChatMember(Self, AMyChatMember);
end;
procedure TInjectTelegramReceiverService.DoOnPollAnswer(
  APollAnswer: ItdPollAnswer);
begin
  inherited;
  if Assigned(OnPollAnswer) then
    OnPollAnswer(Self, APollAnswer);
end;
procedure TInjectTelegramReceiverService.DoOnPollStatus(
  APoll: ItdPoll);
begin
  inherited;
  if Assigned(OnPollStatus) then
    OnPollStatus(Self, APoll);
end;
procedure TInjectTelegramReceiverService.DoOnPreCheckoutQuery(APreCheckoutQuery: ItdPreCheckoutQuery);
begin
  inherited;
  if Assigned(OnPreCheckoutQuery) then
    OnPreCheckoutQuery(Self, APreCheckoutQuery);
end;
procedure TInjectTelegramReceiverService.DoOnShippingQuery(AShippingQuery: ItdShippingQuery);
begin
  inherited;
  if Assigned(OnShippingQuery) then
    OnShippingQuery(Self, AShippingQuery);
end;
procedure TInjectTelegramReceiverService.DoOnStart;
begin
  inherited;
  if Assigned(OnStart) then
    OnStart(Self);
end;
procedure TInjectTelegramReceiverService.DoOnStop;
begin
  inherited;
  if Assigned(OnStop) then
    OnStop(Self);
end;
procedure TInjectTelegramReceiverService.DoOnUpdate(AUpdate: ItdUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(Self, AUpdate);
end;
procedure TInjectTelegramReceiverService.DoOnUpdates(AUpdates: TArray<ItdUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(Self, AUpdates);
end;
procedure TInjectTelegramReceiverService.DoOnWebAppData(
  AWebAppData: ItdWebAppData);
begin
  inherited;
  if Assigned(OnWebAppData) then
    OnWebAppData(Self, AWebAppData);
end;

end.procedure TInjectTelegramReceiverService.SetOnChatMember(
  const Value: TtdOnChatMember);
begin
  FOnChatMember := Value;
end;

procedure TInjectTelegramReceiverService.SetOnMyChatMember(
  const Value: TtdOnMyChatMember);
begin
  FOnMyChatMember := Value;
end;


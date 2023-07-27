unit TInjectTelegram.Bot.Manager;
{$I config.inc}
interface
uses
  REST.Json,
  REST.Types,
  REST.Client,
  System.Json,
  System.SysUtils,
  System.Generics.Collections,
  System.NetEncoding,
  System.TypInfo,
  System.AnsiStrings,
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  System.DateUtils,
  TInjectTelegram.Bot,
  TInjectTelegram.Bot.Impl,
  TInjectTelegram.Logger,
  TInjectTelegram.Logger.Old,
  TInjectTelegram.Types,
  TInjectTelegram.Types.Impl,
  TInjectTelegram.Types.Enums,
  TInjectTelegram.Types.ReplyMarkups,
  TInjectTelegram.Types.InlineQueryResults,
  TInjectTelegram.Types.InputMessageContents,
  TInjectTelegram.Ph,
  TInjectTelegram.UpdateParser,
  TInjectTelegram.Receiver.Base,
  TInjectTelegram.Receiver.Console,
  TInjectTelegram.Receiver.Service,
  TInjectTelegram.Receiver.UI,
  TInjectTelegram.Bot.Chat,
  WinApi.Windows,
  Vcl.Forms;
const
  URL_File_Download : String = 'https://api.telegram.org/file/bot';
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
  TtdOnSuccessfulPayment = procedure(ASender: TObject; ASuccessfulPayment: ItdSuccessfulPayment) of object;

  TtdOnForumTopicCreated = procedure(ASender: TObject; AForumTopicCreated: ItdForumTopicCreated) of object;
  TtdOnForumTopicClosed = procedure(ASender: TObject; AForumTopicClosed: ItdForumTopicClosed) of object;
  TtdOnForumTopicEdited = procedure(ASender: TObject; AForumTopicEdited: ItdForumTopicEdited) of object;
  TtdOnForumTopicReopened = procedure(ASender: TObject; AForumTopicReopened: ItdForumTopicReopened) of object;
  TtdOnGeneralForumTopicHidden = procedure(ASender: TObject; AGeneralForumTopicHidden: ItdGeneralForumTopicHidden) of object;
  TtdOnGeneralForumTopicUnhidden = procedure(ASender: TObject; AGeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden) of object;

  TtdOnMyChatMember = procedure(ASender: TObject; AMyChatMember: ItdChatMemberUpdated) of object;
  TtdOnChatMember = procedure(ASender: TObject; AChatMember: ItdChatMemberUpdated) of object;

  TtdOnMessageEntityReceiver = procedure(ASender: TObject; AMessageEntityType: TtdMessageEntityType) of object;

  TtdOnWebAppData = procedure(ASender: TObject; AWebAppData: ItdWebAppData) of object;

  TtdChatList = TObjectList<TInjectTelegramChat>;

  TInjectTelegramBotManager = class(TInjectTelegramBotReceiverBase)
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
    FSenhaADM: String;
    FSimultaneos: Integer;
    FInactivityTimeMinute: Integer;
    FConversas: TtdChatList;
    FConversa: TInjectTelegramChat;
    LParseMode: TtdParseMode;
    FOnTimer: TNotifyEvent;
    FTimeNow, FLimit: TTime;
    FOnMyChatMember: TtdOnMyChatMember;
    FOnChatMember: TtdOnChatMember;
    FOnChatJoinRequest: TtdOnChatJoinRequest;
    FOnSuccessfulPayment: TtdOnSuccessfulPayment;
    FMessage: ItdMessage;
    FOnForumTopicCreated: TtdOnForumTopicCreated;
    FOnForumTopicReopened: TtdOnForumTopicReopened;
    FOnForumTopicEdited: TtdOnForumTopicEdited;
    FOnForumTopicClosed: TtdOnForumTopicClosed;
    FOnGeneralForumTopicHidden: TtdOnGeneralForumTopicHidden;
    FOnGeneralForumTopicUnhidden: TtdOnGeneralForumTopicUnhidden;
    FTotaldeConversas: Integer;
    FConversasEmEspera: Integer;
    FTimeOutMessage: String;
    FTimeOutAutoIncSeconds: int64;
    FOnMessageEntityReceiver: TtdOnMessageEntityReceiver;
    FAvisoInatividade: Boolean;
    FOnWebAppData: TtdOnWebAppData;
    procedure SetMessage(const Value: ItdMessage);
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
    procedure DoOnChatJoinRequest(AChatJoinRequest: ItdChatJoinRequest); override;
    procedure DoOnMyChatMember(AMyChatMember: ItdChatMemberUpdated); override;
    procedure DoOnChatMember(AChatMember: ItdChatMemberUpdated); override;
    procedure DoOnSuccessfulPayment(ASuccessfulPayment: ItdSuccessfulPayment); override;
    procedure DoOnForumTopicCreated(AForumTopicCreated: ItdForumTopicCreated); override;
    procedure DoOnForumTopicReopened(AForumTopicReopened: ItdForumTopicReopened); override;
    procedure DoOnForumTopicEdited(AForumTopicEdited: ItdForumTopicEdited); override;
    procedure DoOnForumTopicClosed(AForumTopicClosed: ItdForumTopicClosed); override;
    procedure DoOnGeneralForumTopicHidden(AGeneralForumTopicHidden: ItdGeneralForumTopicHidden); override;
    procedure DoOnGeneralForumTopicUnhidden(AGeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden); override;
    procedure DoOnMessageEntityReceiver(AMessageEntityReceiver: TtdMessageEntityType); override;
    procedure DoOnWebAppData(AWebAppData: ItdWebAppData); override;
    procedure Init;
    procedure ParseMessageObject(AMessage : ItdMessage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TypeParser(AMessage : ItdMessage);
    procedure ProcessarResposta(AMessage : ItdMessage); overload;
    procedure ProcessarResposta(APreCheckoutQuery: ItdPreCheckoutQuery); overload;
    procedure ConversaSituacaoAlterada(AConversa: TInjectTelegramChat; AMessage : ItdMessage);

    function BuscarConversa(AID: String): TInjectTelegramChat;
    function NovaConversa(AMessage : ItdMessage): TInjectTelegramChat;
    function BuscarConversaEmEspera: TInjectTelegramChat;
    function AtenderProximoEmEspera: TInjectTelegramChat;

    procedure ReadChats(ABotManager: TInjectTelegramBotManager);


    property TotaldeConversas: Integer read FTotaldeConversas;
    property TotalConversasEmEspera: Integer read FConversasEmEspera;

    property Message : ItdMessage read FMessage write SetMessage;
    property Conversas: TtdChatList read FConversas;
    property Conversa: TInjectTelegramChat read FConversa write FConversa;
    function GetUserName(AMessage: ItdMessage): string; overload;
    function GetUserName(APreCheckoutQuery: ItdPreCheckoutQuery): string; overload;

    function CreateSubDir(const NomeSubDir: string; var OutDir: string): boolean;
    function DownloadFile(const Origem, Destino: String): Boolean;
    function ExtractFileNameFromURL(AURLFile: string): string;
  published
    property TimeOutMessage: String read FTimeOutMessage write FTimeOutMessage;
  /// <summary> This property is used to define the time to cancel a conversation, after the timeout warning.
  /// </summary>
  /// <param name="TimeOutSeconds">Time in Seconds
  /// </param>
  /// <remarks>
  /// If no value is defined, the time of 30 seconds will be assigned automatically.
  /// <see cref="TInjectTelegramBotManager.TimeOutSeconds"/>
  /// </remarks>
    property TimeOutAutoIncSeconds: int64 read FTimeOutAutoIncSeconds write FTimeOutAutoIncSeconds;
    {Propriedades}
    property AdminPassword: String read FSenhaADM write FSenhaADM;
    [Default(1)]
    property Simultaneous: Integer read FSimultaneos write FSimultaneos;
    [Default(1)]
    property InactivityTimeMinute: Integer read FInactivityTimeMinute write FInactivityTimeMinute;
    property InactivityNotice   : Boolean read FAvisoInatividade  write FAvisoInatividade;
    {Eventos}
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
    property OnSuccessfulPayment: TtdOnSuccessfulPayment read FOnSuccessfulPayment write FOnSuccessfulPayment;
    property OnPollStatus: TtdOnPollStatus read FOnPollStatus write FOnPollStatus;
    property OnPollAnswer: TtdOnPollAnswer read FOnPollAnswer write FOnPollAnswer;
    property OnChatJoinRequest: TtdOnChatJoinRequest read FOnChatJoinRequest write FOnChatJoinRequest;
    property OnMyChatMember: TtdOnMyChatMember read FOnMyChatMember write FOnMyChatMember;
    property OnChatMember:   TtdOnChatMember read FOnChatMember write FOnChatMember;
    property OnForumTopicCreated: TtdOnForumTopicCreated read FOnForumTopicCreated write FOnForumTopicCreated;
    property OnForumTopicClosed: TtdOnForumTopicClosed read FOnForumTopicClosed write FOnForumTopicClosed;
    property OnForumTopicEdited: TtdOnForumTopicEdited read FOnForumTopicEdited write FOnForumTopicEdited;
    property OnForumTopicReopened: TtdOnForumTopicReopened read FOnForumTopicReopened write FOnForumTopicReopened;
    property OnGeneralForumTopicHidden: TtdOnGeneralForumTopicHidden read FOnGeneralForumTopicHidden write FOnGeneralForumTopicHidden;
    property OnGeneralForumTopicUnhidden: TtdOnGeneralForumTopicUnhidden read FOnGeneralForumTopicUnhidden write FOnGeneralForumTopicUnhidden;
    property OnMessageEntityReceiver : TtdOnMessageEntityReceiver read FOnMessageEntityReceiver write FOnMessageEntityReceiver;
    property OnWebAppData: TtdOnWebAppData read FOnWebAppData write FOnWebAppData;
  end;
implementation
uses
  System.StrUtils, WinInet;
{ TInjectTelegramBotManager }

function TInjectTelegramBotManager.ExtractFileNameFromURL(AURLFile: string): string;
var
  AStrOut :String;
  I: Integer;
begin
  AStrOut := ExtractFileName(AURLFile);

  I := AStrOut.LastDelimiter('/');
  if I >= 0 then
    Result := Copy(AStrOut, I + 2)
  else
    Result := AStrOut;
end;

function TInjectTelegramBotManager.GetUserName(
  APreCheckoutQuery: ItdPreCheckoutQuery): string;
begin
  Result := IfThen(
        (APreCheckoutQuery.From.FirstName <> EmptyStr) and
        (APreCheckoutQuery.From.FirstName.Length > 1)
      ,APreCheckoutQuery.From.FirstName+' '+APreCheckoutQuery.From.LastName
      ,ifThen(
          (APreCheckoutQuery.From.Username <> EmptyStr) and
          (APreCheckoutQuery.From.Username.Length > 1)
        ,APreCheckoutQuery.From.Username
        ,'User '+APreCheckoutQuery.From.ID.ToString
             )
                  );
end;

function TInjectTelegramBotManager.DownloadFile(const Origem, Destino: String): Boolean;
const                 //1x    2x      3x     4x     8x
  BufferSize = 1024; //1024 //2048 //3060 //4056 //8112 //
var
  hSession,
  hURL: HInternet;
  Buffer: array[1..(BufferSize)] of Byte;
  BufferLen: DWORD;
  f: File;
  sAppName: string;
  StrFileName: String;
begin
  StrFileName := ExtractFileNameFromURL(Origem);
  Result  := False;
  sAppName := ExtractFileName(Application.ExeName);
  hSession := InternetOpen(PChar(sAppName),INTERNET_OPEN_TYPE_PRECONFIG,nil, nil, 0);

  try
    hURL := InternetOpenURL(hSession,PChar(Origem),nil,0,0,0);
    try
      AssignFile(f, Destino+'\'+StrFileName);
      Rewrite(f,1);

      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
        BlockWrite(f, Buffer, BufferLen);
      until BufferLen = 0;

      CloseFile(f);
      Result := True;
    finally
      InternetCloseHandle(hURL);
    end;
  finally
    InternetCloseHandle(hSession);
  end;
end;

function TInjectTelegramBotManager.CreateSubDir(const NomeSubDir: string; Var OutDir: string): boolean;
var
  CaminhoSub, CaminhoDir : string;
begin
  Result := False;
  CaminhoDir := ExtractFilePath(Application.ExeName)+'Chats';
  if Not DirectoryExists(CaminhoDir) then
    CreateDir(CaminhoDir)
  else
  Begin
    CaminhoSub := CaminhoDir +'\'+ NomeSubDir;
    if DirectoryExists(CaminhoSub) then
      Result := True
    else
      Result := CreateDir(CaminhoSub);
  End;

  if Result then
    OutDir := CaminhoSub;
end;

procedure TInjectTelegramBotManager.ReadChats(ABotManager: TInjectTelegramBotManager);
var
 mt: TThread;
begin

  if Self.InactivityTimeMinute <> 0 then
  Begin

    mt := TThread.CreateAnonymousThread(
    procedure
    var
      AConversa: TInjectTelegramChat;
      FTimeNow, FLimit: TTime;
      ADisponivel: Boolean;
    begin

      while Self.IsActive do
      Begin
        for AConversa in ABotManager.Conversas do
        Begin
          FTimeNow := StrToTime(FormatDateTime('hh:mm:ss',Now));
          FLimit := IncMinute(AConversa.LastIteration, ABotManager.InactivityTimeMinute);

          if (DateTimeToUnix(FTimeNow) > DateTimeToUnix(FLimit)) then
          Begin
            if (Self.InactivityNotice = True) and (AConversa.NotifiedInactivity = False) then
            Begin
              Self.Bot.SendMessage(AConversa.ClientID, FTimeOutMessage);

              AConversa.LastIteration := IncSecond(FTimeNow, FTimeOutAutoIncSeconds);
              AConversa.NotifiedInactivity := True;
              Continue;
            End
            Else
            Begin
              AConversa.ServiceSituation := TtdSituacaoAtendimento.saInativa;

              FConversas.Remove( AConversa ); //Deleta a Conversa
              FConversa := AtenderProximoEmEspera; //Atende o Próximo Cliente da fila
            End;
          End Else
            Continue;

          if AConversa.ServiceSituation = TtdSituacaoAtendimento.saFinalizada then
          Begin
            FConversas.Remove( AConversa ); //Deleta a Conversa
            FConversa := AtenderProximoEmEspera; //Atende o Próximo Cliente da fila
          End;

          if ABotManager.IsActive = False then
            Break;
        End;

        if ABotManager.IsActive = False then
          Break;

        Sleep(ABotManager.PollingInterval);
      End;
    end);
    mt.FreeOnTerminate := True;
    mt.Start;
  End;

end;

procedure TInjectTelegramBotManager.SetMessage(const Value: ItdMessage);
begin
  FMessage := Value;
end;

function TInjectTelegramBotManager.BuscarConversa(AID: String): TInjectTelegramChat;
var
  AConversa: TInjectTelegramChat;
begin
  Result := Nil;
  for AConversa in FConversas do
  begin
    if (AConversa.ClientID.ToString = AID) or
       (AConversa.ChatID.ToString = AID) then
    begin
      Result := AConversa;
      Break;
    end else
      continue;
  end;
end;

function TInjectTelegramBotManager.AtenderProximoEmEspera: TInjectTelegramChat;
begin
  Result := BuscarConversaEmEspera;
  if Assigned( Result ) then
  begin
    Result.ServiceSituation := TtdSituacaoAtendimento.saEmFila;
    if FConversasEmEspera > 0 then
      FConversasEmEspera := FConversasEmEspera - 1;
    Result.RestartTimer;
  end;
end;

function TInjectTelegramBotManager.BuscarConversaEmEspera: TInjectTelegramChat;
var
  AConversa: TInjectTelegramChat;
begin
  Result := nil;
  if FConversas.Count > 0 then
    for AConversa in FConversas do
    begin
      if AConversa.ServiceSituation = TtdSituacaoAtendimento.saEmEspera then
      begin
        Result := AConversa;
        Break;
      end;
    end;
end;

procedure TInjectTelegramBotManager.ConversaSituacaoAlterada(
  AConversa: TInjectTelegramChat; AMessage : ItdMessage);
begin
  //Se ficar Inativo ou Finalizar o Pedido
  if ((AConversa.ServiceSituation = TtdSituacaoAtendimento.saInativa) or
    (AConversa.ServiceSituation = TtdSituacaoAtendimento.saFinalizada)) then
  begin
    DoOnMessage(AMessage); //Encaminha a Mensagem
    FConversas.Remove( AConversa ); //Deleta a Conversa
    if FTotaldeConversas > 0 then
      FTotaldeConversas := FTotaldeConversas - 1;
    FConversa := AtenderProximoEmEspera; //Atende o Próximo Cliente da fila
  end;

  //Quano o Pedido estava Em Espera ele ao ser selecionado, passa a ter o status de em Fila
  if AConversa.ServiceSituation = TtdSituacaoAtendimento.saEmFila then
  Begin
    AConversa.ServiceSituation := TtdSituacaoAtendimento.saNova; //Atribui o Novo Status
    DoOnMessage(AMessage); //Encaminha a Mensagem
  End;

end;
constructor TInjectTelegramBotManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAvisoInatividade := False;
  FTimeOutAutoIncSeconds := 30;
  FInactivityTimeMinute := 0;
  FTimeOutMessage := 'Hello, I noticed that our conversation has reached the inactivity timeout, if you do not communicate with me anymore, our conversation will automatically end!';
  Init;
end;
destructor TInjectTelegramBotManager.Destroy;
begin
  if Assigned(FConversas) then
    FreeAndNil(FConversas);
  inherited Destroy;
end;
function TInjectTelegramBotManager.NovaConversa(AMessage: ItdMessage): TInjectTelegramChat;
var
  ADisponivel: Boolean;
begin
  ADisponivel := FConversas.Count < FSimultaneos;
  Result := TInjectTelegramChat.Create(Self);

  with Result do
  begin
    if AdminPassword <> '' then
      case TtdMessage(AMessage).Text = AdminPassword of
        True  : UserType := TtdTipoUsuario.tpAdm;
        False : UserType := TtdTipoUsuario.tpCliente;
      end;
    ConversationID    := Conversas.Count + 1;
    FTotaldeConversas := ConversationID;
    ID                := AMessage.MessageId.ToString;
    ChatID            := AMessage.Chat.ID;
    ClientID          := AMessage.From.ID;
    MSGText           := AMessage.Text;
    FMessage          := AMessage;
    Name              := GetUserName(AMessage);

    LastIteration := StrToTime(FormatDateTime('hh:mm:ss',Now));

    SetTempoInatividade(FInactivityTimeMinute);

    OnChangedSituation := ConversaSituacaoAlterada;
  end;

  if ((ADisponivel = True) or (Result.UserType = TtdTipoUsuario.tpAdm)) then
    Result.ServiceSituation := TtdSituacaoAtendimento.saNova
  else begin
    Result.ServiceSituation := TtdSituacaoAtendimento.saEmEspera;
    FConversasEmEspera := FConversasEmEspera + 1;
  end;

  FConversas.Add( Result );
end;

function TInjectTelegramBotManager.GetUserName(AMessage : ItdMessage): string;
Begin
  Result := IfThen(
        (AMessage.From.FirstName <> EmptyStr) and
        (AMessage.From.FirstName.Length > 1)
      ,AMessage.From.FirstName+' '+AMessage.From.LastName
      ,ifThen(
          (AMessage.From.Username <> EmptyStr) and
          (AMessage.From.Username.Length > 1)
        ,AMessage.From.Username
        ,'User '+AMessage.From.ID.ToString
             )
                  );
End;

procedure TInjectTelegramBotManager.ProcessarResposta(AMessage : ItdMessage);
var
  AConversa: TInjectTelegramChat;
  AID: String;
begin
  Self.Message := AMessage;

  if (AMessage.From.ID.ToString <> AMessage.Chat.ID.ToString) and (AMessage.Chat.ID.ToString <> '') then
    AID := AMessage.Chat.ID.ToString //Para uso de Grupos
  else
    AID := AMessage.From.ID.ToString; //Para uso de Chat Privado

  AConversa := BuscarConversa( AID );

  if AConversa <> Nil then
  begin
    AConversa.ID          := AMessage.MessageId.ToString;
    AConversa.ChatID      := AMessage.Chat.ID;
    AConversa.ClientID    := AMessage.From.ID;
    AConversa.MSGText     := AMessage.Text;
    AConversa.IdIdiomaStr := AMessage.From.LanguageCode;
    AConversa.FMessage    := AMessage;
    AConversa.Name        := GetUserName(AMessage);
    AConversa.ReceivedFile := '';

    AConversa.LastIteration := StrToTime(FormatDateTime('hh:mm:ss',Now));

    if AMessage.SuccessfulPayment <> NIl then
    Begin

      AConversa.SuccessfulPayment.TotalAmount             := AMessage.SuccessfulPayment.TotalAmount.ToString;
      AConversa.SuccessfulPayment.Currency                := AMessage.SuccessfulPayment.Currency;
      AConversa.SuccessfulPayment.InvoicePayload          := AMessage.SuccessfulPayment.InvoicePayload;
      AConversa.SuccessfulPayment.ShippingOptionId        := AMessage.SuccessfulPayment.ShippingOptionId;
      AConversa.SuccessfulPayment.TelegramPaymentChargeId := AMessage.SuccessfulPayment.TelegramPaymentChargeId;
      AConversa.SuccessfulPayment.ProviderPaymentChargeId := AMessage.SuccessfulPayment.ProviderPaymentChargeId;

    End;

    if Self.InactivityTimeMinute <> 0 then
    Begin
      FTimeNow := AConversa.LastIteration;
      FLimit := IncMinute(AConversa.LastIteration, Self.InactivityTimeMinute);

      if (DateTimeToUnix(FTimeNow) < DateTimeToUnix(FLimit)) then
        AConversa.RestartTimer;
    End;

  End Else
    AConversa := NovaConversa( AMessage );

  TypeParser(AMessage);

  FConversa := AConversa;
end;

procedure TInjectTelegramBotManager.TypeParser(AMessage : ItdMessage);
var
  FilePath, FileName : String;
  I: Integer;
  MyPhoto: ItdPhotoSize;
  MyFile : ItdFile;
  MyEntities: ItdMessageEntity;
Begin
  //Tratando Entidades
  if AMessage.&Type = TtdMessageType.TextMessage then
    for MyEntities in AMessage.Entities  do
    Begin
      if Assigned(OnMessageEntityReceiver) then
        OnMessageEntityReceiver(Self, MyEntities.TypeMessage);
    End;
  //Tratando a situacao em que vem a localizacao.
  if AMessage.&Type = TtdMessageType.LocationMessage then
    if (AMessage.Location.Latitude <> 0) and (AMessage.Location.Longitude <> 0) then
    begin
      FConversa.Latitude        := AMessage.Location.Latitude;
      FConversa.Longitude       := AMessage.Location.Longitude;
    end;
  //Tratamento para receber Fotos ou Imagens
  if AMessage.&Type = TtdMessageType.PhotoMessage then
  Begin
    for I := 0 to Length(AMessage.Photo) -1 do
    Begin
      if I = 0 then
        FileName := 'Thumbs';
      if I = 1 then
        FileName := 'Photo_Low';
      if I = 2 then
        FileName := 'Photo_Mid';
      if I = 3 then
        FileName := 'Photo_High';
      if I = 4 then
        FileName := 'Photo_Full_High';
      MyFile := Bot.GetFile(AMessage.Photo[I].FileId);
      FilePath := MyFile.FilePath;

      if Assigned(FConversa) then
        FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
    End;
  End;
  //Tratamento para receber Documentos
  if AMessage.&Type = TtdMessageType.DocumentMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Document.FileId);
    FilePath := MyFile.FilePath;

    FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
  End;
  if AMessage.&Type = TtdMessageType.VideoMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Video.FileId);
    FilePath := MyFile.FilePath;

    FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
  End;
  if AMessage.&Type = TtdMessageType.AudioMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Audio.FileId);
    FilePath := MyFile.FilePath;

    FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
  End;
  if AMessage.&Type = TtdMessageType.VideoNoteMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.VideoNote.FileId);
    FilePath := MyFile.FilePath;

    FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
  End;
  if AMessage.&Type = TtdMessageType.StickerMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Sticker.FileId);
    FilePath := MyFile.FilePath;

    FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
  End;
  if AMessage.&Type = TtdMessageType.AnimatoinMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Animation.FileId);
    FilePath := MyFile.FilePath;

    FConversa.ReceivedFile := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

End;

procedure TInjectTelegramBotManager.ParseMessageObject(AMessage: ItdMessage);
begin
  if AMessage.SuccessfulPayment <> Nil then
    if Assigned(OnSuccessfulPayment) then
      OnSuccessfulPayment(Self,AMessage.SuccessfulPayment);

  if AMessage.ForumTopicCreated <> Nil then
    if Assigned(OnForumTopicCreated) then
      OnForumTopicCreated(Self, AMessage.ForumTopicCreated);

  if AMessage.ForumTopicClosed <> Nil then
    if Assigned(OnForumTopicClosed) then
      OnForumTopicClosed(Self, AMessage.ForumTopicClosed);

  if AMessage.ForumTopicEdited <> Nil then
    if Assigned(OnForumTopicEdited) then
      OnForumTopicEdited(Self, AMessage.ForumTopicEdited);

  if AMessage.ForumTopicReopened <> Nil then
    if Assigned(OnForumTopicReopened) then
      OnForumTopicReopened(Self, AMessage.ForumTopicReopened);

  if AMessage.GeneralForumTopicHidden <> Nil then
    if Assigned(OnGeneralForumTopicHidden) then
      OnGeneralForumTopicHidden(Self, AMessage.GeneralForumTopicHidden);

  if AMessage.GeneralForumTopicUnhidden <> Nil then
    if Assigned(OnGeneralForumTopicUnhidden) then
      OnGeneralForumTopicUnhidden(Self, AMessage.GeneralForumTopicUnhidden);

  if AMessage.WebAppData <> Nil then
    if Assigned(OnWebAppData) then
      OnWebAppData(Self, AMessage.WebAppData);
end;

procedure TInjectTelegramBotManager.ProcessarResposta(APreCheckoutQuery: ItdPreCheckoutQuery);
var
  AConversa: TInjectTelegramChat;
  AID: String;
begin

  AID := APreCheckoutQuery.From.ID.ToString; //Para uso de Chat Privado

  AConversa := BuscarConversa( AID );

  if AConversa <> Nil then
  begin
    AConversa.ID          := APreCheckoutQuery.ID;
    AConversa.ChatID      := APreCheckoutQuery.From.ID;
    AConversa.ClientID   := APreCheckoutQuery.From.ID;
    AConversa.MSGText    := APreCheckoutQuery.TotalAmount.ToString;
    AConversa.IdIdiomaStr := APreCheckoutQuery.From.LanguageCode;
    //AConversa.FMessage    := AMessage;
    AConversa.Name        := GetUserName(APreCheckoutQuery);
    AConversa.ReceivedFile := '';

    if Self.InactivityTimeMinute <> 0 then
    Begin
      FTimeNow := StrToTime(FormatDateTime('hh:mm:ss',Now));
      FLimit := IncMinute(AConversa.LastIteration, Self.InactivityTimeMinute);

      if (DateTimeToUnix(FTimeNow) < DateTimeToUnix(FLimit)) then
        AConversa.RestartTimer;

      AConversa.LastIteration := StrToTime(FormatDateTime('hh:mm:ss',Now));
    End;


  End;

//  if AConversa = Nil then
//    AConversa := NovaConversa( AMessage );
//
//  TypeParser(AMessage);
//
  FConversa := AConversa;
end;

procedure TInjectTelegramBotManager.DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery);
begin
  inherited;
  //Teste
  if Assigned(OnCallbackQuery) then
  Begin
   // ProcessarResposta(ACallbackQuery.message);
    OnCallbackQuery(Self, ACallbackQuery);
  End;
end;
procedure TInjectTelegramBotManager.DoOnChannelPost(AChannelPost: ItdMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(Self, AChannelPost);
end;
procedure TInjectTelegramBotManager.DoOnChatJoinRequest(
  AChatJoinRequest: ItdChatJoinRequest);
begin
  inherited;
  if Assigned(OnChatJoinRequest) then
    OnChatJoinRequest(Self, AChatJoinRequest);
end;
procedure TInjectTelegramBotManager.DoOnChatMember(
  AChatMember: ItdChatMemberUpdated);
begin
  inherited;
  if Assigned(OnChatMember) then
    OnChatMember(Self, AChatMember);
end;
procedure TInjectTelegramBotManager.DoOnChosenInlineResult(AChosenInlineResult: ItdChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(Self, AChosenInlineResult);
end;
procedure TInjectTelegramBotManager.DoOnEditedChannelPost(AEditedChannelPost: ItdMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(Self, AEditedChannelPost);
end;
procedure TInjectTelegramBotManager.DoOnEditedMessage(AEditedMessage: ItdMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(Self, AEditedMessage);
end;
procedure TInjectTelegramBotManager.DoOnForumTopicClosed(
  AForumTopicClosed: ItdForumTopicClosed);
begin
  inherited;
  if Assigned(OnForumTopicClosed) then
    OnForumTopicClosed(Self, AForumTopicClosed);
end;

procedure TInjectTelegramBotManager.DoOnForumTopicCreated(
  AForumTopicCreated: ItdForumTopicCreated);
begin
  inherited;
  if Assigned(OnForumTopicCreated) then
    OnForumTopicCreated(Self, AForumTopicCreated);
end;

procedure TInjectTelegramBotManager.DoOnForumTopicEdited(
  AForumTopicEdited: ItdForumTopicEdited);
begin
  inherited;
  if Assigned(OnForumTopicEdited) then
    OnForumTopicEdited(Self, AForumTopicEdited);
end;

procedure TInjectTelegramBotManager.DoOnForumTopicReopened(
  AForumTopicReopened: ItdForumTopicReopened);
begin
  inherited;
  if Assigned(OnForumTopicReopened) then
    OnForumTopicReopened(Self, AForumTopicReopened);
end;

procedure TInjectTelegramBotManager.DoOnGeneralForumTopicHidden(
  AGeneralForumTopicHidden: ItdGeneralForumTopicHidden);
begin
  inherited;
  if Assigned(OnGeneralForumTopicHidden) then
    OnGeneralForumTopicHidden(Self, AGeneralForumTopicHidden);
end;

procedure TInjectTelegramBotManager.DoOnGeneralForumTopicUnhidden(
  AGeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden);
begin
  inherited;
  if Assigned(OnGeneralForumTopicUnhidden) then
    OnGeneralForumTopicUnhidden(Self, AGeneralForumTopicUnhidden);
end;

procedure TInjectTelegramBotManager.DoOnInlineQuery(AInlineQuery: ItdInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(Self, AInlineQuery);
end;
procedure TInjectTelegramBotManager.DoOnMessage(AMessage: ItdMessage);
begin
  inherited;
  if Assigned(OnMessage) then
  Begin
    ProcessarResposta(AMessage);

    OnMessage(Self, AMessage);

    ParseMessageObject(AMessage);

  End;
end;
procedure TInjectTelegramBotManager.DoOnMessageEntityReceiver(
  AMessageEntityReceiver: TtdMessageEntityType);
begin
  inherited;
  if Assigned(OnMessageEntityReceiver) then
    OnMessageEntityReceiver(Self, AMessageEntityReceiver);
end;

procedure TInjectTelegramBotManager.DoOnMyChatMember(
  AMyChatMember: ItdChatMemberUpdated);
begin
  inherited;
  if Assigned(OnMyChatMember) then
    OnMyChatMember(Self, AMyChatMember);
end;
procedure TInjectTelegramBotManager.DoOnPollAnswer(APollAnswer: ItdPollAnswer);
begin
  inherited;
  if Assigned(OnPollAnswer) then
    OnPollAnswer(Self, APollAnswer);
end;
procedure TInjectTelegramBotManager.DoOnPollStatus(APoll: ItdPoll);
begin
  inherited;
  if Assigned(OnPollStatus) then
    OnPollStatus(Self, APoll);
end;
procedure TInjectTelegramBotManager.DoOnPreCheckoutQuery(APreCheckoutQuery: ItdPreCheckoutQuery);
begin
  inherited;
  if Assigned(OnPreCheckoutQuery) then
  Begin
//    ProcessarResposta(APreCheckoutQuery);

    OnPreCheckoutQuery(Self, APreCheckoutQuery);
  End;
end;

procedure TInjectTelegramBotManager.DoOnShippingQuery(AShippingQuery: ItdShippingQuery);
begin
  inherited;
  if Assigned(OnShippingQuery) then
    OnShippingQuery(Self, AShippingQuery);
end;
procedure TInjectTelegramBotManager.DoOnStart;
begin
  inherited;
  Init;
  if Assigned(OnStart) then
    OnStart(Self);

  ReadChats(Self);
end;
procedure TInjectTelegramBotManager.DoOnStop;
begin
  ReadChats(Self);

  inherited;

  if Assigned(OnStop) then
    OnStop(Self);

  if Assigned(FConversas) then
    FreeAndNil(FConversas);
end;
procedure TInjectTelegramBotManager.DoOnSuccessfulPayment(
  ASuccessfulPayment: ItdSuccessfulPayment);
begin
  inherited;
  if Assigned(OnSuccessfulPayment) then
    OnSuccessfulPayment(Self, ASuccessfulPayment);
end;

procedure TInjectTelegramBotManager.DoOnUpdate(AUpdate: ItdUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
  Begin
    ProcessarResposta(AUpdate.&message);
    OnUpdate(Self, AUpdate);
  End;
end;
procedure TInjectTelegramBotManager.DoOnUpdates(AUpdates: TArray<ItdUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(Self, AUpdates);
end;
procedure TInjectTelegramBotManager.DoOnWebAppData(AWebAppData: ItdWebAppData);
begin
  inherited;
  if Assigned(OnWebAppData) then
    OnWebAppData(Self, AWebAppData);
end;

procedure TInjectTelegramBotManager.Init;
begin
  LParseMode := TtdParseMode.Markdown;
  if Not Assigned(FConversas) then
    FConversas := TObjectList<TInjectTelegramChat>.Create;
end;
end.

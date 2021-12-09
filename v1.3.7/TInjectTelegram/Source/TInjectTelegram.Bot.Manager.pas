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
  TInjectTelegram.Bot.Chat{,
    TinjectTelegram.Receiver.Manager.Base};

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

  TtdOnMyChatMember = procedure(ASender: TObject; AMyChatMember: ItdChatMemberUpdated) of object;
  TtdOnChatMember = procedure(ASender: TObject; AChatMember: ItdChatMemberUpdated) of object;
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
    FTempoInatividade: Integer;
    FConversas: TObjectList<TInjectTelegramChatBot>;
    FConversa: TInjectTelegramChatBot;
    LParseMode: TtdParseMode;
    FOnTimer: TNotifyEvent;

    FTimeNow, FLimit: TTime;
    FOnTimerSleepExecute: TOnTimerSleepExecute;
    FOnMyChatMember: TtdOnMyChatMember;
    FOnChatMember: TtdOnChatMember;
    FOnChatJoinRequest: TtdOnChatJoinRequest;

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
    procedure Init;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TypeParser(AMessage : ItdMessage);
    procedure ProcessarResposta(AMessage : ItdMessage);
    procedure ConversaSituacaoAlterada(AConversa: TInjectTelegramChatBot; AMessage : ItdMessage);

    function BuscarConversa(AID: String): TInjectTelegramChatBot;
    function NovaConversa(AMessage : ItdMessage): TInjectTelegramChatBot;
    function BuscarConversaEmEspera: TInjectTelegramChatBot;
    function AtenderProximoEmEspera: TInjectTelegramChatBot;


    property Conversas: TObjectList<TInjectTelegramChatBot> read FConversas;
    property Conversa: TInjectTelegramChatBot read FConversa write FConversa;
  published
    {Propriedades}
    property SenhaADM: String read FSenhaADM write FSenhaADM;
    [Default(1)]
    property Simultaneos: Integer read FSimultaneos write FSimultaneos;
    [Default(1)]
    property TempoInatividade: Integer read FTempoInatividade write FTempoInatividade;

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

    property OnPollStatus: TtdOnPollStatus read FOnPollStatus write FOnPollStatus;
    property OnPollAnswer: TtdOnPollAnswer read FOnPollAnswer write FOnPollAnswer;
    property OnChatJoinRequest: TtdOnChatJoinRequest read FOnChatJoinRequest write FOnChatJoinRequest;
    property OnTimerSleepExecute: TOnTimerSleepExecute read FOnTimerSleepExecute write FOnTimerSleepExecute;
    property OnMyChatMember: TtdOnMyChatMember read FOnMyChatMember write FOnMyChatMember;
    property OnChatMember:   TtdOnChatMember read FOnChatMember write FOnChatMember;
  end;

implementation

uses
  System.StrUtils;

{ TInjectTelegramBotManager }

function TInjectTelegramBotManager.AtenderProximoEmEspera: TInjectTelegramChatBot;
var
  AConversa: TInjectTelegramChatBot;
begin
  AConversa := BuscarConversaEmEspera;
  if Assigned( AConversa ) then
  begin
    if AConversa.Situacao <> saInativa then
    Begin
      AConversa.Situacao := saNova;
      AConversa.ReiniciarTimer;
      FConversa := AConversa;
      Result := AConversa;
    End;
  end;
end;

function TInjectTelegramBotManager.BuscarConversa(AID: String): TInjectTelegramChatBot;
var
  AConversa: TInjectTelegramChatBot;
begin
  Result := Nil;
  for AConversa in FConversas do
  begin
    if AConversa.IdChat.ToString = AID then  //Para Grupos...
    begin
      Result := AConversa;
      FConversa := AConversa;
     // FTimeNow := StrToTime(FormatDateTime('hh:mm:ss',Now));
      Break;
    end
     else
    if AConversa.IdCliente.ToString = AID then
    begin
      Result := AConversa;
      FConversa := AConversa;
     // FTimeNow := StrToTime(FormatDateTime('hh:mm:ss',Now));
      Break;
    end
    else //Nada encontrado
      Break;

  end; //Fim For in...
end;

function TInjectTelegramBotManager.BuscarConversaEmEspera: TInjectTelegramChatBot;
var
  AConversa: TInjectTelegramChatBot;
begin
 // Result := nil;
  for AConversa in FConversas do
  begin
    if AConversa.Situacao = saEmEspera then
    begin
      Result := AConversa;
      FConversa := AConversa;
      Break;
    end;
  end;
end;

procedure TInjectTelegramBotManager.ConversaSituacaoAlterada(
  AConversa: TInjectTelegramChatBot; AMessage : ItdMessage);
begin
  //Se ficar Inativo ou Finalizar o Pedido
  if AConversa.Situacao in [saInativa, saFinalizada] then
  begin
    DoOnMessage(AMessage); //Encaminha a Mensagem

    FConversas.Remove( AConversa ); //Deleta a Conversa

    AtenderProximoEmEspera; //Atende o Próximo Cliente da fila
  end;
end;

constructor TInjectTelegramBotManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Init;
end;

destructor TInjectTelegramBotManager.Destroy;
begin
  if Assigned(FConversas) then
    FreeAndNil(FConversas);
  inherited Destroy;
end;

function TInjectTelegramBotManager.NovaConversa(AMessage: ItdMessage): TInjectTelegramChatBot;
var
  ADisponivel: Boolean;
  AConversa: TInjectTelegramChatBot;
begin

  ADisponivel := FConversas.Count < Simultaneos;

  FConversa := TInjectTelegramChatBot.Create(Self);
  with FConversa do
  begin
    if SenhaADM <> '' then
      case TtdMessage(AMessage).Text = SenhaADM of
        True  : TipoUsuario := tpAdm;
        False : TipoUsuario := tpCliente;
      end;

    ID            := TtdMessage(AMessage).MessageId.ToString;{.Chat.ID.ToString;}
    IdChat        := TtdMessage(AMessage).Chat.ID;
    IdCliente     := TtdMessage(AMessage).From.ID;
    TextoMSG      := TtdMessage(AMessage).Text;
    Nome          := IfThen((AMessage.From.FirstName <> EmptyStr) and
                          (AMessage.From.FirstName.Length > 1)
                        ,AMessage.From.FirstName+' '+AMessage.From.LastName
                        ,ifThen((AMessage.From.Username <> EmptyStr) and (AMessage.From.Username.Length > 1)
                          ,AMessage.From.Username
                          ,'Cliente '+AMessage.From.ID.ToString)
                        );

    FConversa.UltimaIteracao := StrToTime(FormatDateTime('hh:mm:ss',Now));

    { TODO 5 -oRuan Diego -cTempodeInatividade : Corrigir o tempo de inatividade... }
    SetTempoInatividade(FTempoInatividade);

    //Eventos para controle externos
    FConversa.FMessage := AMessage;
    OnSituacaoAlterada := ConversaSituacaoAlterada;
    OnTimerSleepExecute := Self.OnTimerSleepExecute;
  end;

  //Validando a disponibilidade ou tipo adm
  if ((ADisponivel = True) or (FConversa.TipoUsuario = tpAdm)) then
    FConversa.Situacao := saNova
  else
    FConversa.Situacao := saEmEspera;

  FConversas.Add( FConversa );

  Result := FConversa;
end;

procedure TInjectTelegramBotManager.TypeParser(AMessage : ItdMessage);
var
  FilePath, FileName : String;
  I: Integer;
  MyPhoto: ItdPhotoSize;
  MyFile : ItdFile;
Begin
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
        FileName := 'Foto_Media_Qld';
      if I = 2 then
        FileName := 'Foto_Alta_Qld';
      if I = 3 then
        FileName := 'Foto_SuperAlta_Qld';
      if I = 4 then
        FileName := 'Foto_FULLHD_Qld';

      MyFile := Bot.GetFile(AMessage.Photo[I].FileId);
      FilePath := MyFile.FilePath;

      //Enviando para o proprio Bot...
      Bot.SendMessage(AMessage.From.ID,
        '[Baixar '+FileName+I.ToString+']('+URL_File_Download+
        Bot.Token+'/'+FilePath+')',LParseMode);
      //Bot.SendMessage(AMessage.From.ID, MyFile.GetFileUrl(Bot.Token),LParseMode);

      FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
    End;

  End;

  //Tratamento para receber Documentos
  if AMessage.&Type = TtdMessageType.DocumentMessage then
  Begin

    MyFile := Bot.GetFile(AMessage.Document.FileId);
    FilePath := MyFile.FilePath;

    Bot.SendMessage(AMessage.From.ID,
      '[Baixar '+ExtractFileName(FilePath)+']('+URL_File_Download+
      Bot.Token+'/'+FilePath+')',LParseMode);

    FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

  if AMessage.&Type = TtdMessageType.VideoMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Video.FileId);
    FilePath := MyFile.FilePath;

    Bot.SendMessage(AMessage.From.ID,
      '[Baixar '+ExtractFileName(FilePath)+']('+URL_File_Download+
      Bot.Token+'/'+FilePath+')',LParseMode);

    FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

  if AMessage.&Type = TtdMessageType.AudioMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Audio.FileId);
    FilePath := MyFile.FilePath;

    Bot.SendMessage(AMessage.From.ID,
      '[Baixar '+ExtractFileName(FilePath)+']('+URL_File_Download+
      Bot.Token+'/'+FilePath+')',LParseMode);

    FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

  if AMessage.&Type = TtdMessageType.VideoNoteMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.VideoNote.FileId);
    FilePath := MyFile.FilePath;

    Bot.SendMessage(AMessage.From.ID,
      '[Baixar '+ExtractFileName(FilePath)+']('+URL_File_Download+
      Bot.Token+'/'+FilePath+')',LParseMode);

    FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

  if AMessage.&Type = TtdMessageType.StickerMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Sticker.FileId);
    FilePath := MyFile.FilePath;

    Bot.SendMessage(AMessage.From.ID,
      '[Baixar '+ExtractFileName(FilePath)+']('+URL_File_Download+
      Bot.Token+'/'+FilePath+')',LParseMode);

    FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

  if AMessage.&Type = TtdMessageType.AnimatoinMessage then
  Begin
    MyFile := Bot.GetFile(AMessage.Animation.FileId);
    FilePath := MyFile.FilePath;

    Bot.SendMessage(AMessage.From.ID,
      '[Baixar '+ExtractFileName(FilePath)+']('+URL_File_Download+
      Bot.Token+'/'+FilePath+')',LParseMode);

    FConversa.ArquivoRecebido := URL_File_Download+Bot.Token+'/'+FilePath;
  End;

End;

procedure TInjectTelegramBotManager.ProcessarResposta(AMessage : ItdMessage);
var
  AConversa: TInjectTelegramChatBot;
begin
  FConversa := Nil;
      //id de usuario                   //id do grupo     no chat privado eles são iguais
  if (AMessage.From.ID.ToString <> AMessage.Chat.ID.ToString) then
    FConversa := BuscarConversa( AMessage.Chat.ID.ToString ) //Para uso de Grupos
  else
    FConversa := BuscarConversa( AMessage.From.ID.ToString ); //Para uso de Chat Privado

  if FConversa = Nil then
    FConversa := NovaConversa( AMessage );

  if FConversa <> Nil then
  begin
    FConversa.ID          := AMessage.MessageId.ToString;
    FConversa.IdChat      := AMessage.Chat.ID;
    FConversa.IdCliente   := AMessage.From.ID;
    FConversa.TextoMSG    := AMessage.Text;
    FConversa.IdIdiomaStr := AMessage.From.LanguageCode;
    FConversa.Nome        := IfThen((AMessage.From.FirstName <> EmptyStr) and
                                (AMessage.From.FirstName.Length > 1)
                                ,AMessage.From.FirstName+' '+AMessage.From.LastName
                                ,ifThen((AMessage.From.Username <> EmptyStr) and
                                (AMessage.From.Username.Length > 1)
                                ,AMessage.From.Username
                                ,'Cliente '+AMessage.From.ID.ToString)
                                );

    //Zera o Endereco de Arquivo recebido
    FConversa.ArquivoRecebido := '';

    //Se Existe Tempo de Inatividade definido, então controlo o timer;
    if Self.TempoInatividade <> 0 then
    Begin
      //Atualiza o Limite de Tempo da Sessão  {IncSecond}
      FTimeNow := StrToTime(FormatDateTime('hh:mm:ss',Now));
      FLimit := IncMinute(FConversa.UltimaIteracao, Self.TempoInatividade);

      if (DateTimeToUnix(FTimeNow) > DateTimeToUnix(FLimit)) then
      Begin
        //Atribuido para solução temporaria da falha na autofinalização
        FConversa.SetSituacao(saInativa);
      End
      Else
        FConversa.ReiniciarTimer;
    End;

  End;

  TypeParser(AMessage);

end;

procedure TInjectTelegramBotManager.DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery);
begin
  inherited;
  //Teste
//  ProcessarResposta(ACallbackQuery.message);
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(Self, ACallbackQuery);
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
  End;
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
    OnPreCheckoutQuery(Self, APreCheckoutQuery);
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
end;
procedure TInjectTelegramBotManager.DoOnStop;
begin
  inherited;
  if Assigned(OnStop) then
    OnStop(Self);
  if Assigned(FConversas) then
    FreeAndNil(FConversas);
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
procedure TInjectTelegramBotManager.Init;
begin
  LParseMode := TtdParseMode.Markdown;
  FConversas := TObjectList<TInjectTelegramChatBot>.Create;
end;

end.

unit uPrincipal;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  CrossUrl.Indy.HttpClient,
  CrossUrl.SystemNet.HttpClient,
  TInjectTelegram.UpdateParser,
  TInjectTelegram.Receiver.Base,
  TInjectTelegram.Receiver.Service,
  TInjectTelegram.Receiver.UI,
  TInjectTelegram.Logger,
  TInjectTelegram.Logger.Old,
  TInjectTelegram.Base,
  TInjectTelegram.Types, {Uso Especifico}
  TInjectTelegram.Types.Impl, {Uso Especifico}
  TInjectTelegram.Types.Enums, {Uso Especifico}
  TInjectTelegram.Types.ReplyMarkups,{Uso Especifico}
  TInjectTelegram.Bot, {Uso Especifico}
  TinjectTelegram.Emoji, {para usar os Emojis}
  TInjectTelegram.Bot.Impl,
  TinjectTelegram.Types.InlineQueryResults,
  TinjectTelegram.Types.InputMessageContents,
  TinjectTelegram.Utils.JSON,
  Vcl.Imaging.pngimage, uResourceString, TInjectTelegram.Bot.Manager,
  //Use JSON with X-SuperObject
  XSuperJSON,
  XSuperObject,

  System.Json, REST.Json, REST.JsonReflect, REST.Json.Types;
type

  TMessageToSend = record
    chatId: Int64;
    Text: String;
    ParseMode: TtdParseMode;
  end;

  TForm1 = class(TForm)
    Image1: TImage;
    btnEnviaTexto: TButton;
    txtToken: TEdit;
    Label1: TLabel;
    InjectTelegramExceptionManagerUI1: TInjectTelegramExceptionManagerUI;
    Button2: TButton;
    Button3: TButton;
    cuHttpClientSysNet1: TcuHttpClientSysNet;
    memConsole: TMemo;
    btnEnviaFoto: TButton;
    txtID: TEdit;
    Label2: TLabel;
    AbrirArquivo: TOpenDialog;
    ImgLoad: TImage;
    btnEnviaAudio: TButton;
    btnEnviarDocumento: TButton;
    btnEnviarVideo: TButton;
    btnEnviarVoz: TButton;
    Label3: TLabel;
    btnEnviarNotaDeVideo: TButton;
    btnEnviarLocalizacao: TButton;
    btnEnviarVenue: TButton;
    btnEnviarContato: TButton;
    btnEnviarPoll: TButton;
    btnEnviarDado: TButton;
    btnEnviarStiker: TButton;
    btnEnviarJogo: TButton;
    btnEnviarAcao: TButton;
    btnEnviarInvoice: TButton;
    btnEnviarGrpMidias: TButton;
    btnEnviarTxtComBt: TButton;
    btnEnviarTxtComBTInline: TButton;
    btnApagarBotoes: TButton;
    btnEnviarAnimacao: TButton;
    btnEnviarDardo: TButton;
    txtNomeJogo: TEdit;
    Label4: TLabel;
    btnSolicitarCtt: TButton;
    btnSolicitarLocalizacao: TButton;
    btnComoSaberID: TButton;
    btnADD: TButton;
    txtTokenBanco: TEdit;
    Label5: TLabel;
    Button1: TButton;
    Button4: TButton;
    Button5: TButton;
    InjectTelegramBot1: TInjectTelegramBot;
    btnCommands: TButton;
    btnGetCMD: TButton;
    btnDeleteCommands: TButton;
    BotManager1: TInjectTelegramBotManager;
    cbDisableNotification: TCheckBox;
    cbProtectedContent: TCheckBox;
    btnSetChatMenuButton: TButton;
    btnGetChatMenuButton: TButton;
    btnSetMyDefaultAdministratorRights: TButton;
    cbRightsAdmin: TCheckBox;
    cbChanel: TCheckBox;
    btnGetAdministratorRights: TButton;
    btnAnswerWebAppQuery: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    CriarTopico: TButton;
    EditarTopico: TButton;
    GetForumStikersTopic: TButton;
    SendTextTopic: TButton;
    procedure btnEnviaTextoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ServiceStart(Sender: TObject);
    procedure ServiceStop(Sender: TObject);
    procedure InjectTelegramExceptionManagerUI1Log(ASender: TObject;
      const Level: TLogLevel; const Msg: string; E: Exception);
    procedure btnEnviaFotoClick(Sender: TObject);
    procedure btnEnviaAudioClick(Sender: TObject);
    procedure btnEnviarDocumentoClick(Sender: TObject);
    procedure btnEnviarVideoClick(Sender: TObject);
    procedure btnEnviarVozClick(Sender: TObject);
    procedure btnEnviarNotaDeVideoClick(Sender: TObject);
    procedure btnEnviarLocalizacaoClick(Sender: TObject);
    procedure btnEnviarVenueClick(Sender: TObject);
    procedure btnEnviarContatoClick(Sender: TObject);
    procedure btnEnviarPollClick(Sender: TObject);
    procedure btnEnviarDadoClick(Sender: TObject);
    procedure btnEnviarStikerClick(Sender: TObject);
    procedure btnEnviarJogoClick(Sender: TObject);
    procedure btnEnviarAcaoClick(Sender: TObject);
    procedure btnEnviarInvoiceClick(Sender: TObject);
    procedure btnEnviarGrpMidiasClick(Sender: TObject);
    procedure btnEnviarTxtComBtClick(Sender: TObject);
    procedure btnEnviarTxtComBTInlineClick(Sender: TObject);
    procedure btnApagarBotoesClick(Sender: TObject);
    procedure ReceiverCallbackQuery(ASender: TObject;
      ACallbackQuery: ItdCallbackQuery);
    procedure ReceiverMessage(ASender: TObject;
  AMessage: ItdMessage);
    procedure ChosenInlineResult(ASender: TObject;
      AChosenInlineResult: ItdChosenInlineResult);
    procedure btnEnviarAnimacaoClick(Sender: TObject);
    procedure btnEnviarDardoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSolicitarCttClick(Sender: TObject);
    procedure btnSolicitarLocalizacaoClick(Sender: TObject);
    procedure btnComoSaberIDClick(Sender: TObject);
    procedure btnADDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure InjectTelegramBot1ReceiveRawData(ASender: TObject;
      const AData: string);
    procedure btnCommandsClick(Sender: TObject);
    procedure InjectTelegramBot1SendData(ASender: TObject; const AUrl,
      AData: string);
    procedure btnGetCMDClick(Sender: TObject);
    procedure btnDeleteCommandsClick(Sender: TObject);
    procedure InjectTelegramBot1Disconect(ASender: TObject;
      const AErrorCode: string);
    procedure BotManager1Message(ASender: TObject; AMessage: ItdMessage);
    procedure btnSetChatMenuButtonClick(Sender: TObject);
    procedure btnGetChatMenuButtonClick(Sender: TObject);
    procedure btnSetMyDefaultAdministratorRightsClick(Sender: TObject);
    procedure btnGetAdministratorRightsClick(Sender: TObject);
    procedure btnAnswerWebAppQueryClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure EnviarFotoSpoilerClick(Sender: TObject);
    procedure BotManager1ForumTopicCreated(ASender: TObject;
      AForumTopicCreated: ItdForumTopicCreated);
    procedure BotManager1ForumTopicEdited(ASender: TObject;
      AForumTopicEdited: ItdForumTopicEdited);
    procedure BotManager1ForumTopicReopened(ASender: TObject;
      AForumTopicReopened: ItdForumTopicReopened);
    procedure BotManager1ForumTopicClosed(ASender: TObject;
      AForumTopicClosed: ItdForumTopicClosed);
    procedure BotManager1GeneralForumTopicHidden(ASender: TObject;
      AGeneralForumTopicHidden: ItdGeneralForumTopicHidden);
    procedure BotManager1GeneralForumTopicUnhidden(ASender: TObject;
      AGeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden);
    procedure CriarTopicoClick(Sender: TObject);
    procedure EditarTopicoClick(Sender: TObject);
    procedure GetForumStikersTopicClick(Sender: TObject);
    procedure SendTextTopicClick(Sender: TObject);
  private
    procedure CarregarBTStr(AStrArrayBtName: TArray<TArray<String>>;
      AInlineMode: Boolean; url: string);
    { Private declarations }
  public
    procedure AplicarResource;
  var
    //Variaveis Globais
    MyCallback      : ItdCallbackQuery;
    MyMessage       : ItdMessage;
    MyInlineQuery   : ItdInlineQuery;
    MyFile          : TtdFileToSend;
    MyFiles         : TArray<TtdFileToSend>;
    MyLocation      : TtdLocation;
    MyVenue         : TtdVenue;
    MyMedia         : TArray<TtdInputMedia>;
    MyChatId        : TtdUserLink;
    MyContact       : Ttdcontact;
    MyAction        : TtdSendChatAction;
    MyPrices        : TArray<TtdLabeledPrice>;
    MyPollKey       : TtdKeyboardButtonPollType;  //Novo Recurso
    //SemUso...
    MyFotoFile      : TtdInputMediaPhoto;  //Add para teste
    LParseMode      : TtdParseMode; //Necessario declarar TelegAPI.Types.Enums
    LMarkup         : IReplyMarkup; //Necessario declarar TelegAPI.Types.ReplyMarkups
    LChatID         : Int64;
    FileCount       : Integer; //Variavel para contar os Arquivos no SendMediaGroup

    {$REGION 'MYRESOURCES'}
    VRes_Filtro_Foto_Video,
    VRes_Filtro_Video,
    VRes_Filtro_Fotos,
    VRes_Filtro_Voz,
    VRes_Filtro_Stiker,
    VRes_Filtro_Todos,
    VRes_Filtro_Audio,
    //
    VRes_Animacao,
    VRes_Dado,
    VRes_Dardo,
    VRes_Basquete,
    VRes_Grav_Voz,
    VRes_Video,
    VRes_Audio,
    VRes_Imagem,
    VRes_Acao,
    VRes_Localizacao,
    VRes_Stiker,
    VRes_Enquete_Quiz,
    VRes_Nota_Video,
    VRes_Jogo,
    VRes_Contato,
    VRes_Pagamento,
    VRes_Documento,
    VRes_GrupoMidia,
    //
    VRes_Texto_Video,
    VRes_Texto_Voz,
    VRes_Texto_Audio,
    VRes_Texto_Animacao,
    VRes_Texto_Foto,
    VRes_Texto_Documento,
    //
    VRes_Falha,
    VRes_Falha_Envio_Destinatario,
    VRes_Ative_Servico,
    VRes_Preencha_Token,
    VRes_MSG_Exemplo_Envio_BT,
    VRes_Servico_Ativo,
    VRes_Servico_Desativado,
    VRes_O_Usuario,
    VRes_Compartilhou_CTT,
    VRes_Compartilhou_Localizacao,
    VRes_Solicitou,
    VRes_Telefone,
    VRes_Qual_Meu_ID,
    VRes_Ola_Me_Passe_Localizacao,
    VRes_Solicitacao_Env_Mas_Incomp_Teleg_Descktop,
    VRes_Ola_Me_Passe_Contato,
    VRes_Enviar_Localizacao,
    VRes_Enviar_Contato,
    VRes_Use_Seu_Cel_Envio_MeuID,
    VRes_Este_Seu_ID,
    VRes_Ex_Endereco_Digitado,
    VRes_Ex_Titulo,
    VRes_Ex_Tipo,
    VRes_Ex_Remover_BT,
    VRes_Ta_Doidao,
    VRes_Quem_Desc_Brasil,
    VRes_Informe_Jogo_Valido,
    VRes_Ajuda_Token_Banco,
    VRes_ProdutoA,
    VRes_ProdutoB,
    VRes_Limite_Arquivos_MediaGroup,
    VRes_Teste_MidiaGroup,
    VRes_Titulo_PG,
    VRes_Descricao_PG,
    VRes_PlayLoad_PG: String;
    {$ENDREGION 'MYRESOURCES'}
    { Public declarations }
  end;
var
  Form1: TForm1;
  Clique          : Integer;
implementation
{$R *.dfm}
procedure TForm1.AplicarResource;
Begin
{$REGION 'Atribuição das Variaveis'}
  VRes_Filtro_Foto_Video  := ARes_Filtro_Foto_Video;
  VRes_Filtro_Video       := ARes_Filtro_Video;
  VRes_Filtro_Fotos       := ARes_Filtro_Fotos;
  VRes_Filtro_Voz         := ARes_Filtro_Voz;
  VRes_Filtro_Stiker      := ARes_Filtro_Stiker;
  VRes_Filtro_Todos       := ARes_Filtro_Todos;
  VRes_Filtro_Audio       := ARes_Filtro_Audio;
  //
  VRes_Animacao     := ARes_Animacao;
  VRes_Dado         := ARes_Dado;
  VRes_Dardo        := ARes_Dardo;
  VRes_Basquete     := ARes_Basquete;
  VRes_Grav_Voz     := ARes_Grav_Voz;
  VRes_Video        := ARes_Video;
  VRes_Audio        := ARes_Audio;
  VRes_Imagem       := ARes_Imagem;
  VRes_Acao         := ARes_Acao;
  VRes_Localizacao  := ARes_Localizacao;
  VRes_Stiker       := ARes_Stiker;
  VRes_Enquete_Quiz := ARes_Enquete_Quiz;
  VRes_Nota_Video   := ARes_Nota_Video;
  VRes_Jogo         := ARes_Jogo;
  VRes_Contato      := ARes_Contato;
  VRes_Pagamento    := ARes_Pagamento;
  VRes_Documento    := ARes_Documento;
  VRes_GrupoMidia   := ARes_GrupoMidia;
  //
  VRes_Texto_Video      := ARes_Texto_Video;
  VRes_Texto_Voz        := ARes_Texto_Voz;
  VRes_Texto_Audio      := ARes_Texto_Audio;
  VRes_Texto_Animacao   := ARes_Texto_Animacao;
  VRes_Texto_Foto       := ARes_Texto_Foto;
  VRes_Texto_Documento  := ARes_Texto_Documento;
  //
  VRes_Falha                    := ARes_Falha;
  VRes_Falha_Envio_Destinatario := ARes_Falha_Envio_Destinatario;
  VRes_Ative_Servico            := ARes_Ative_Servico;
  VRes_Preencha_Token           := ARes_Preencha_Token;
  VRes_MSG_Exemplo_Envio_BT     := ARes_MSG_Exemplo_Envio_BT;
  VRes_Servico_Ativo            := ARes_Servico_Ativo;
  VRes_Servico_Desativado       := ARes_Servico_Desativado;
  VRes_O_Usuario                := ARes_O_Usuario;
  VRes_Compartilhou_CTT         := ARes_Compartilhou_CTT;
  VRes_Compartilhou_Localizacao := ARes_Compartilhou_Localizacao;
  VRes_Solicitou                := ARes_Solicitou;
  VRes_Telefone                 := ARes_Telefone;
  VRes_Qual_Meu_ID              := ARes_Qual_Meu_ID;
  VRes_Ola_Me_Passe_Localizacao                   := ARes_Ola_Me_Passe_Localizacao;
  VRes_Solicitacao_Env_Mas_Incomp_Teleg_Descktop  := ARes_Solicitacao_Env_Mas_Incomp_Teleg_Descktop;
  VRes_Ola_Me_Passe_Contato                       := ARes_Ola_Me_Passe_Contato;
  VRes_Enviar_Localizacao                         := ARes_Enviar_Localizacao;
  VRes_Enviar_Contato                             := ARes_Enviar_Contato;
  VRes_Use_Seu_Cel_Envio_MeuID                    := ARes_Use_Seu_Cel_Envio_MeuID;
  VRes_Este_Seu_ID              := ARes_Este_Seu_ID;
  VRes_Ex_Endereco_Digitado     := ARes_Ex_Endereco_Digitado;
  VRes_Ex_Titulo                := ARes_Ex_Titulo;
  VRes_Ex_Tipo                  := ARes_Ex_Tipo;
  VRes_Ex_Remover_BT            := ARes_Ex_Remover_BT;
  VRes_Ta_Doidao                := ARes_Ta_Doidao;
  VRes_Quem_Desc_Brasil         := ARes_Quem_Desc_Brasil;
  VRes_Informe_Jogo_Valido      := ARes_Informe_Jogo_Valido;
  VRes_Ajuda_Token_Banco        := ARes_Ajuda_Token_Banco;
  VRes_ProdutoA       := ARes_ProdutoA;
  VRes_ProdutoB       := ARes_ProdutoB;
  VRes_Limite_Arquivos_MediaGroup := ARes_Limite_Arquivos_MediaGroup;
  VRes_Teste_MidiaGroup           := ARes_Teste_MidiaGroup;
  VRes_Titulo_PG      := ARes_Titulo_PG;
  VRes_Descricao_PG   := ARes_Descricao_PG;
  VRes_PlayLoad_PG    := ARes_PlayLoad_PG;
{$ENDREGION 'Atribuição das Variaveis'}
End;
procedure TForm1.BotManager1ForumTopicClosed(ASender: TObject;
  AForumTopicClosed: ItdForumTopicClosed);
begin
  memConsole.Lines.Add('Um Topico foi Fechado!');
end;

procedure TForm1.BotManager1ForumTopicCreated(ASender: TObject;
  AForumTopicCreated: ItdForumTopicCreated);
begin
  memConsole.Lines.Add('Topico Criado'+sLinebreak+
  'Name : '+AForumTopicCreated.name+sLinebreak+
  'icon_color : '+AForumTopicCreated.icon_color.ToString+sLinebreak+
  'icon_custom_emoji_id : '+AForumTopicCreated.icon_custom_emoji_id);
end;

procedure TForm1.BotManager1ForumTopicEdited(ASender: TObject;
  AForumTopicEdited: ItdForumTopicEdited);
begin
  memConsole.Lines.Add('Topico Editado'+sLinebreak+
  'Name : '+AForumTopicEdited.name+sLinebreak+
  'icon_custom_emoji_id : '+AForumTopicEdited.icon_custom_emoji_id);
end;

procedure TForm1.BotManager1ForumTopicReopened(ASender: TObject;
  AForumTopicReopened: ItdForumTopicReopened);
begin
  memConsole.Lines.Add('Um Topico foi Reaberto');
end;

procedure TForm1.BotManager1GeneralForumTopicHidden(ASender: TObject;
  AGeneralForumTopicHidden: ItdGeneralForumTopicHidden);
begin
  memConsole.Lines.Add('Um Topico foi Ocultado');
end;

procedure TForm1.BotManager1GeneralForumTopicUnhidden(ASender: TObject;
  AGeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden);
begin
  memConsole.Lines.Add('Um Topico foi Reexibido');
end;

procedure TForm1.BotManager1Message(ASender: TObject; AMessage: ItdMessage);
begin
//
end;
procedure TForm1.btnADDClick(Sender: TObject);
var
  I : Integer;
  F: Integer;
begin
  if FileCount > 10 then
    FileCount := 0;
  FileCount := FileCount + 1;
  AbrirArquivo.Filter := VRes_Filtro_Foto_Video;
  if FileCount <= 10 then // Limite de arquivos da API
  Begin
    SetLength(MyFiles, FileCount);
    if AbrirArquivo.Execute then
      MyFiles[FileCount - 1] := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName);
    SetLength(MyMedia, Length(MyFiles));
    if ExtractFileExt(AbrirArquivo.FileName) = '.png' then
      MyMedia[FileCount - 1] := TtdInputMediaPhoto.Create(MyFiles[FileCount - 1], VRes_Teste_MidiaGroup);
    if ExtractFileExt(AbrirArquivo.FileName) = '.mp4' then
      MyMedia[FileCount - 1] := TtdInputMediaVideo.Create(MyFiles[FileCount - 1], VRes_Teste_MidiaGroup);
  End
  Else
    Showmessage(VRes_Limite_Arquivos_MediaGroup);
end;
procedure TForm1.btnAnswerWebAppQueryClick(Sender: TObject);
var
  FResult: TtdInlineQueryResult;
  FWebSent: TtdSentWebAppMessage;
  imp: TtdInputTextMessageContent;
  InlineMarkup: TtdInlineKeyboardMarkup;
  InlineKeyboard: TtdInlineKeyboardButton;
begin

  if BotManager1.IsActive then
  Begin
    try
      FResult:= TtdInlineQueryResult.Create;
      FResult.&Type := 'article';
      FResult.Title := 'Teste';

      imp:= TtdInputTextMessageContent.Create('OLA MUNDO','Markdown',False);

      FResult.ParseMode := TtdParseMode.Markdown;
      FResult.InputMessageContent := imp;

      InlineKeyboard := TtdInlineKeyboardButton.Create('Teste','teste');
      InlineMarkup:= TtdInlineKeyboardMarkup.Create([[InlineKeyboard]]);

      FResult.ReplyMarkup := InlineMarkup;

      FWebSent := BotManager1.Bot.AnswerWebAppQuery('123456',FResult) as TtdSentWebAppMessage;
      memConsole.Lines.Add('inline_message_id: '+FWebSent.inline_message_id);
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.btnApagarBotoesClick(Sender: TObject);
begin
{
Aqui você Remove botoes do destinatario,apenas seguindo a mensagem
}
//Necessario declarar TelegAPI.Types.ReplyMarkups    //TtdReplyKeyboardRemove
LMarkup := TtdReplyKeyboardRemove.Create;
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),VRes_Ex_Remover_BT, LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;
procedure TForm1.btnCommandsClick(Sender: TObject);
var
 botcmdArr: TArray<TtdBotCommand>;
begin
  botcmdArr := [TtdBotCommand.Create('command1','Testando1'),
                TtdBotCommand.Create('command2','Testando2'),
                TtdBotCommand.Create('command3','Testando3'),
                TtdBotCommand.Create('command4','Testando4'),
                TtdBotCommand.Create('command5','Testando5')];
  if BotManager1.IsActive then
  begin
    try
      InjectTelegramBot1.SetMyCommands(botcmdArr, TtdBotCommandScope.BotCommandScopeDefault);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+' ao setar os comandos!');
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnComoSaberIDClick(Sender: TObject);
begin
  Showmessage(VRes_Use_Seu_Cel_Envio_MeuID);
end;
procedure TForm1.btnDeleteCommandsClick(Sender: TObject);
begin
  if BotManager1.IsActive then
  begin
    try
      InjectTelegramBot1.DeleteMyCommands(TtdBotCommandScope.BotCommandScopeDefault);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+' ao deletar a lista de comandos!');
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviaAudioClick(Sender: TObject);
begin
  AbrirArquivo.Filter := VRes_Filtro_Audio;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendAudio(StrToInt64(txtID.Text), MyFile,VRes_Texto_Audio,
        LParseMode, 0,'Titulo Sobreescrito',cbDisableNotification.Checked, 0, False, LMarkup, cbProtectedContent.Checked);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Audio);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviaFotoClick(Sender: TObject);
//From Stream Use
var
 MyStream: TMemoryStream;
 BoolStream: Boolean;
begin
  AbrirArquivo.Filter := VRes_Filtro_Fotos;
  if AbrirArquivo.Execute then
      ImgLoad.Picture.WICImage.LoadFromFile(AbrirArquivo.FileName);
  MyFile := Nil;
  if MessageDlg('Send from Stream?',mtInformation,[mbYes,mbNo],0) = mrYes then
  Begin
    BoolStream := True;
    //From Stream Use
    MyStream := TMemoryStream.Create;
    MyStream.Position := 0;
    ImgLoad.Picture.Graphic.SaveToStream(MyStream);
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromStream,AbrirArquivo.FileName, MyStream);
  End Else
  Begin
    BoolStream := False;
    //From File
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName, Nil);
  End;
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      try
        if Assigned(MyFile) then
        Begin
          if BoolStream then
            InjectTelegramBot1.SendPhoto(StrToInt64(txtID.Text), MyFile,VRes_Texto_Foto+
              ' - From Stream', LParseMode,  cbDisableNotification.Checked, 0, False, LMarkup,cbProtectedContent.Checked)
          else
            InjectTelegramBot1.SendPhoto(StrToInt64(txtID.Text), MyFile,VRes_Texto_Foto+
              ' - From File', LParseMode, cbDisableNotification.Checked, 0, False, LMarkup, cbProtectedContent.Checked);
        End Else
          memConsole.Lines.Add(VRes_Falha+VRes_Imagem+ ' ERROR: Nenhum Arquivo Assossiado para envio, foi encontrado!');
      except on e:exception do
        memConsole.Lines.Add(VRes_Falha+VRes_Imagem+ ' ERROR: '+e.Message);
      end;
    finally
      if BoolStream then
        MyStream.Free;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarAcaoClick(Sender: TObject);
begin
  {
  Basta Mudar a ação aqui para que ele envie a ação selecionada
  como por exemplo:
    MyAction := TtdSendChatAction.Record_audio;
    MyAction := TtdSendChatAction.Upload_document;
  entre outros
  }
  //Neste caso irei enviar a ação Escrevendo...  (Typing)
  MyAction := TtdSendChatAction.Typing;
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
      InjectTelegramBot1.SendChatAction(MyChatId, MyAction);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Acao);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarAnimacaoClick(Sender: TObject);
var
 MyThumb : TtdFileToSend;
begin
  AbrirArquivo.Filter := VRes_Filtro_Video;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile, AbrirArquivo.FileName);
  AbrirArquivo.Filter := VRes_Filtro_Fotos;
  if AbrirArquivo.Execute then
    MyThumb := TtdFileToSend.Create(TtdFileToSendTag.FromFile, AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendAnimation(StrToInt64(txtID.Text), MyFile,30,0,0,MyThumb,
        VRes_Texto_Animacao, LParseMode, cbDisableNotification.Checked, 0, False, LMarkup, cbProtectedContent.Checked);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Animacao);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarContatoClick(Sender: TObject);
begin
  MyContact := TtdContact.Create('5521997196000','Ruan Diego','Lacerda Menezes','CB Lacerda');
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendContact(StrToInt64(txtID.Text), MyContact, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Contato);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarDocumentoClick(Sender: TObject);
begin
  MyFile := Nil;
  AbrirArquivo.Filter := VRes_Filtro_Todos;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.FromFile(AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try                                                         //Thumb 320x320 px até 200k
      InjectTelegramBot1.SendDocument(StrToInt64(txtID.Text), MyFile, nil ,
         VRes_Texto_Documento, LParseMode, False, cbDisableNotification.Checked, 0,
         False, LMarkup,cbProtectedContent.Checked, 0, []);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Documento);
        memConsole.Lines.Add(e.Message);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarGrpMidiasClick(Sender: TObject);
var
  I: integer;
Begin
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
      if Assigned(MyMedia) then
        try
          InjectTelegramBot1.sendMediaGroup(MyChatId.ID, MyMedia,
              cbDisableNotification.Checked, 0, False, cbProtectedContent.Checked);
        except on e:exception do
          begin
            memConsole.Lines.Add(VRes_Falha+VRes_GrupoMidia);
          end;
        end;
    finally
      MyFile.Free;
      for I := 0 to Length(MyMedia) -1 do
        MyMedia[I].Free;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarInvoiceClick(Sender: TObject);
var
  AText, sJson, FotoUrl : String;
  Ctt : Int64;
  pvToken, BrandName, pgMetod: String;
begin
  FotoUrl := 'https://user-images.githubusercontent.com/11804577/79389701-fd284580-7f44-11ea-8238-bab525a19caa.png';
  pvToken := txtTokenBanco.Text;//'SEU TOKEN_PROVIDER GERADO NO BOTFATHER PARA PAGAMENTOS';
  BrandName := 'Visa';
  pgMetod := 'pm_card_visa';
                                                                                      //R$10,00
 // MyInvoice := TtdInvoice.Create('Teste Titulo','Descrição', 'www.lmcode.com.br','USD',1000);
  if txtTokenBanco.Text = '' then
  Begin
    Showmessage(VRes_Ajuda_Token_Banco);
    Exit;
  End;
  SetLength(MyPrices, 2);
  MyPrices[0] :=  TtdLabeledPrice.Create(VRes_ProdutoA, 1000);
  MyPrices[1] :=  TtdLabeledPrice.Create(VRes_ProdutoB, 300);

  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
                                 //ID          //TITULO   //DESC               //PLayload      //Token  //Param //Curr  //Prices //ProvData    //Foto
      InjectTelegramBot1.SendInvoice(MyChatId.ID,
          VRes_Titulo_PG,
          VRes_Descricao_PG,
          VRes_PlayLoad_PG,
          pvToken, pgMetod ,'USD', MyPrices,
          5478750, //MaxTipAmount
          [],  //SuggestedTipAmounts = Array of Integer
          '', //ProviderData
          FotoUrl, 300, 100, 100,
          FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,0, nil);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Pagamento);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarJogoClick(Sender: TObject);
var
  MyChatId: TtdUserLink; //Uses TelegAPI.Bot
begin
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      {É Necessário criar um game no BotFather para obter o
      nome do game que sera enviado }
      if txtNomeJogo.Text <> '' then
      Begin
        MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
        InjectTelegramBot1.SendGame(MyChatId.ID, txtNomeJogo.Text);
      End Else
        memConsole.Lines.Add(VRes_Informe_Jogo_Valido);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Jogo);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarLocalizacaoClick(Sender: TObject);
var
  lt, lg: Single;
begin
  lt := -22.8272758;
  lg := -43.0292233;
  MyLocation := TtdLocation.Create(lt,lg);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendLocation(StrToInt64(txtID.Text), MyLocation, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Localizacao);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarNotaDeVideoClick(Sender: TObject);
begin
  AbrirArquivo.Filter := VRes_Filtro_Video;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendVideoNote(StrToInt64(txtID.Text), MyFile, 0, 0, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Nota_Video);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarPollClick(Sender: TObject);
var
  MyStrArray: Array of String;
begin
  MyStrArray := [
  'Peido Alvares Cabral',
  'Sergio Cabral',
  'Cristovão Colombo',
  'Pedro Alvares Cabral'];
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendPoll(MyChatId,
              VRes_Quem_Desc_Brasil, MyStrArray, False,
              TtdQuizType.qtQuiz, False, 3, VRes_Ta_Doidao,
              [], 0, 0, False, False,0,False, LMarkup,False,0);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Enquete_Quiz);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarStikerClick(Sender: TObject);
begin
  AbrirArquivo.Filter := VRes_Filtro_Stiker;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendSticker(StrToInt64(txtID.Text), MyFile,
          cbDisableNotification.Checked, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Stiker);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarVenueClick(Sender: TObject);
var
  lt, lg: Single;
begin
  lt := -22.8272758;
  lg := -43.0292233;
///Desta Forma é necessário instanciar o MyLocation e passa-lo como paramentro ao instanciar o MyVenue
 // MyLocation := TtdLocation.Create(lt,lg);
 // MyVenue := TtdVenue.Create(MyLocation, VRes_Ex_Endereco_Digitado, VRes_Ex_Titulo,'',VRes_Ex_Tipo);
 //Desta Forma o MyLocation não precisa ser instanciado pois os parametros de coordenado sãopassados diretamente aqui
 MyVenue := TtdVenue.Create(lt,lg, VRes_Ex_Endereco_Digitado, VRes_Ex_Titulo,'',VRes_Ex_Tipo);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      //A Função SendVenue depende do Mylocation
      //InjectTelegramBot1.SendVenue(StrToInt64(txtID.Text), MyVenue, MyLocation, False, 0, LMarkup);
      //A Função SendVenue2 NÃO depende do Mylocation
      InjectTelegramBot1.SendVenue2(StrToInt64(txtID.Text), MyVenue, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Localizacao);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarVideoClick(Sender: TObject);
begin
  AbrirArquivo.Filter := VRes_Filtro_Video;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendVideo(StrToInt64(txtID.Text), MyFile,VRes_TExto_Video,
          LParseMode, True, 0, 0, 0, cbDisableNotification.Checked, 0, False, LMarkup, cbProtectedContent.Checked);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Video);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarVozClick(Sender: TObject);
begin
  AbrirArquivo.Filter := VRes_Filtro_Voz;
  if AbrirArquivo.Execute then
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName);
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendVoice(StrToInt64(txtID.Text), MyFile,VRes_Texto_Voz, LParseMode, 0, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Grav_Voz);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviaTextoClick(Sender: TObject);
begin
  if {InjectTelegramReceiverService1}BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      MyChatId := TtdUserLink.FromID(StrToInt64(txtID.Text));
      {InjectTelegramBot1}BotManager1.Bot.SendMessage(MyChatId.ID, VRes_Este_Seu_ID + MyChatId.ID.ToString, LParseMode, False, cbDisableNotification.Checked, 0, False, LMarkup, cbProtectedContent.Checked)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;
procedure TForm1.btnGetAdministratorRightsClick(Sender: TObject);
var
  rights: TtdChatAdministratorRights;
begin
  if BotManager1.IsActive then
  Begin
    try
      rights := BotManager1.Bot.getMyDefaultAdministratorRights(cbChanel.Checked) as TtdChatAdministratorRights;

      if Assigned(rights) then
      Begin
        memConsole.Lines.Add('is_anonymous:           '+rights.is_anonymous.ToString);
        memConsole.Lines.Add('can_manage_chat:        '+rights.can_manage_chat.ToString);
        memConsole.Lines.Add('can_delete_messages:    '+rights.can_delete_messages.ToString);
        memConsole.Lines.Add('can_manage_video_chats: '+rights.can_manage_video_chats.ToString);
        memConsole.Lines.Add('can_restrict_members:   '+rights.can_restrict_members.ToString);
        memConsole.Lines.Add('can_promote_members:    '+rights.can_promote_members.ToString);
        memConsole.Lines.Add('can_change_info:        '+rights.can_change_info.ToString);
        memConsole.Lines.Add('can_invite_users:       '+rights.can_invite_users.ToString);
        memConsole.Lines.Add('can_post_messages:      '+rights.can_post_messages.ToString);
        memConsole.Lines.Add('can_edit_messages:      '+rights.can_edit_messages.ToString);
        memConsole.Lines.Add('can_pin_messages:       '+rights.can_pin_messages.ToString);
      End;

    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.btnGetChatMenuButtonClick(Sender: TObject);
var MyMenuButton: TtdMenuButtonWebApp;
begin
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
      MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text))
    else
      MyChatId := 0;
    try

      MyMenuButton := BotManager1.Bot.GetChatMenuButton(MyChatId) as TtdMenuButtonWebApp;
      memConsole.Lines.Add('type : '+MyMenuButton.&type);
      if MyMenuButton.&type = 'web_app' then
      Begin
        memConsole.Lines.Add('text : '+MyMenuButton.text);
        memConsole.Lines.Add('web_app.url : '+MyMenuButton.web_app.url);
      End;
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.btnGetCMDClick(Sender: TObject);
var
  MyCommands: TArray<ItdBotCommand>;
  I: Integer;
begin
  if BotManager1.IsActive then
  begin
    try
      MyCommands := InjectTelegramBot1.GetMyCommands(TtdBotCommandScope.BotCommandScopeDefault);
      memConsole.Lines.Add('Command List...');
      for I := 0 to High(MyCommands) do
      Begin
        memConsole.Lines.Add('Command'+IntToStr(I)+' : '+MyCommands[I].Command);
        memConsole.Lines.Add('Description'+IntToStr(I)+' : '+MyCommands[I].Description);
        memConsole.Lines.Add('-----------------');
      End;
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+' ao obter a lista de comandos!');
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnSetChatMenuButtonClick(Sender: TObject);
var MyMenuButton: TtdMenuButton;
    MyWebAppInfo: TtdWebAppInfo;
    MyButtonType: TtdMenuButtonType;
    url, FUrl, FButtonName, ButtonName: string;
begin
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));

//      MyMenuButton := BotManager1.Bot.GetChatMenuButton(MyChatId) as TtdMenuButton;
//
//      if MyMenuButton.ClassName = TtdMenuButtonWebApp.ClassName then
//      Begin
//          if TtdMenuButtonWebApp(MyMenuButton).text <> 'Menu' then
//            FUrl := TtdMenuButtonWebApp(MyMenuButton).web_app.url;
//          FButtonName := TtdMenuButtonWebApp(MyMenuButton).text;
//      End;

      url := InputBox('Preencha o Campo com sua URL do Web Bot','URL',FUrl);
      ButtonName := InputBox('Preencha o Campo com um nome para o Botão do Web Bot','Nome do Botão',FButtonName);

      MyWebAppInfo:= TtdWebAppInfo.Create(url);

      if url <> '' then
        MyButtonType := TtdMenuButtonType.MenuButtonWebApp
      else begin
        MyButtonType := TtdMenuButtonType.MenuButtonCommands;
        ButtonName := '';
      end;

      if BotManager1.Bot.SetChatMenuButton(MyChatId, url, ButtonName,MyButtonType) = true then
        memConsole.Lines.Add('O Web Bot foi definido com sucesso!');
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.btnSetMyDefaultAdministratorRightsClick(Sender: TObject);
var
  rights: TtdChatAdministratorRights;
  Estado: Boolean;
begin
  Estado := cbRightsAdmin.Checked;
  rights:= TtdChatAdministratorRights.Create;

  with rights do
  Begin
    IsAnonymous         := Estado;
    CanManageChat       := Estado;
    CanDeleteMessages   := Estado;
    CanManageVideoChats := Estado;
    CanRestrictMembers  := Estado;
    CanPromoteMembers   := Estado;
    CanChangeInfo       := Estado;
    CanInviteUsers      := Estado;
    CanPostMessages     := Estado;
    CanEditMessages     := Estado;
    CanPinMessages      := Estado;
  End;

  if BotManager1.IsActive then
  Begin
    try
      BotManager1.Bot.setMyDefaultAdministratorRights(rights, cbChanel.Checked);
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);

end;

procedure TForm1.btnSolicitarCttClick(Sender: TObject);
begin
LMarkup := TtdReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtdKeyboardButton.Create(VRes_Enviar_Contato, True, FALSE)]], TRUE);
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),
        VRes_Ola_Me_Passe_Contato,
        LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;
procedure TForm1.btnSolicitarLocalizacaoClick(Sender: TObject);
begin
LMarkup := TtdReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtdKeyboardButton.Create(VRes_Enviar_Localizacao, False, TRUE)]], TRUE);
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      memConsole.Lines.Add(VRes_Solicitacao_Env_Mas_Incomp_Teleg_Descktop);
      InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),
        VRes_Ola_Me_Passe_Localizacao,
        LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarDadoClick(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendDice(MyChatId, TtdEmojiType.etDado ,False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Dado);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarDardoClick(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendDice(MyChatId, TtdEmojiType.etDardo ,False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Dardo);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.btnEnviarTxtComBtClick(Sender: TObject);
var
bt1, bt2, bt3: TtdKeyboardButton;
begin

  bt1 := TtdKeyboardButton.Create('texto1', FALSE, FALSE);

  bt2 := TtdKeyboardButton.Create('texto2', FALSE, FALSE);

  bt3 := TtdKeyboardButton.Create(VRes_Qual_Meu_ID, FALSE, FALSE);

{
Aqui você cria os botoes do tipo ReplyKeyboard para enviar na mensagem
eles serão criados como um teclado personalizado para seu destinatario
}
  LMarkup := TtdReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [bt1, bt2],
  { Segunda Linha }
  [bt3]], TRUE);


  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),
        VRes_MSG_Exemplo_Envio_BT,
        LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;
procedure TForm1.EditarTopicoClick(Sender: TObject);
var
  ForumTopicId: Int64;
  TopicName: string;
begin
  if BotManager1.IsActive then
  Begin
    TopicName := InputBox('Informe um Nome para o Tópico', 'Nome','TInjectTelegram - Topic01');
    ForumTopicId := InputBox('Informe o Id do Topico', 'ID','0').ToInt64;
    try
      MyChatId := TtdUserLink.FromID(StrToInt64(txtID.Text));
      BotManager1.Bot.editForumTopic(MyChatId, ForumTopicId, TopicName, '5312536423851630001');
    except on E: Exception do
      memConsole.Lines.Add('Falha ao criar um tópico - ' + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);

end;

procedure TForm1.EnviarFotoSpoilerClick(Sender: TObject);
var
 MyStream: TMemoryStream;
 BoolStream: Boolean;
begin
  AbrirArquivo.Filter := VRes_Filtro_Fotos;
  if AbrirArquivo.Execute then
      ImgLoad.Picture.WICImage.LoadFromFile(AbrirArquivo.FileName);
  MyFile := Nil;
  if MessageDlg('Send from Stream?',mtInformation,[mbYes,mbNo],0) = mrYes then
  Begin
    BoolStream := True;
    //From Stream Use
    MyStream := TMemoryStream.Create;
    MyStream.Position := 0;
    ImgLoad.Picture.Graphic.SaveToStream(MyStream);
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromStream,AbrirArquivo.FileName, MyStream);
  End Else
  Begin
    BoolStream := False;
    //From File
    MyFile := TtdFileToSend.Create(TtdFileToSendTag.FromFile,AbrirArquivo.FileName, Nil);
  End;
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      try
        if Assigned(MyFile) then
        Begin
          if BoolStream then
            InjectTelegramBot1.SendPhoto(StrToInt64(txtID.Text), MyFile,VRes_Texto_Foto+
              ' Spoiler - From Stream', LParseMode,  cbDisableNotification.Checked, 0, False,
              LMarkup,cbProtectedContent.Checked,0,[],True)
          else
            InjectTelegramBot1.SendPhoto(StrToInt64(txtID.Text), MyFile,VRes_Texto_Foto+
              ' Spoiler - From File', LParseMode, cbDisableNotification.Checked, 0, False,
              LMarkup, cbProtectedContent.Checked,0,[],True);
        End Else
          memConsole.Lines.Add(VRes_Falha+VRes_Imagem+ ' ERROR: Nenhum Arquivo Assossiado para envio, foi encontrado!');
      except on e:exception do
        memConsole.Lines.Add(VRes_Falha+VRes_Imagem+ ' ERROR: '+e.Message);
      end;
    finally
      if BoolStream then
        MyStream.Free;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendDice(MyChatId, TtdEmojiType.etBasquete ,False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Basquete);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
  if (txtToken.Text = '') or (length(txtToken.Text) < 20) {or (
    BotManager1.Bot.IsValidToken = false)} then
  Begin
    Showmessage(VRes_Preencha_Token);
  End
  Else
  Begin
    //InjectTelegramBot1.Token := txtToken.Text;
    //InjectTelegramReceiverService1.Start;
    BotManager1.Bot.Token := txtToken.Text;
    BotManager1.Start;
  End;
end;
procedure TForm1.Button3Click(Sender: TObject);
begin
  //InjectTelegramReceiverService1.Stop;
  BotManager1.Stop;
end;
procedure TForm1.Button4Click(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
  if {InjectTelegramReceiverService1}BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      {InjectTelegramBot1}BotManager1.Bot.SendDice(MyChatId, TtdEmojiType.etFootball ,False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Basquete);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.Button5Click(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtdUserLink.FromID(StrToInt64(txtID.Text));
  if BotManager1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendDice(MyChatId, TtdEmojiType.etSlotMachine ,False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Basquete);
      end;
    end;
  end
  else
    memConsole.Lines.Add(VRes_Ative_Servico);
end;
procedure TForm1.Button6Click(Sender: TObject);
var
 MT: TThread;
 MyMsg : TArray<TMessageToSend>;
 Sending: Boolean;
begin
  Clique := Clique + 1;
  SetLength(MyMsg,Clique);

  MT := TThread.CreateAnonymousThread(procedure
  var
    I: Integer;
    A: Integer;
    procedure DeleteArrayItem(X: TArray<TMessageToSend>; Index: Integer);
    Begin
      if Index > High(X) then Exit;
        if Index < Low(X) then Exit;
          if Index = High(X) then
            SetLength(X, Length(X) - 1);
      Exit;
    End;

  begin
    Sending := True;

    for I := 0 to Length(MyMsg) - 1  do
    begin
      MyMsg[I].chatId := StrToInt64(txtID.Text);
      MyMsg[I].Text := 'ALEATORIO ...'+(I+1).ToString;
      MyMsg[I].ParseMode := LParseMode;
    end;

    while Sending do
    begin

      if InjectTelegramBot1.IsBusy = false then
      Begin
        for A := 0 to Length(MyMsg) -1 do
        Begin
          if InjectTelegramBot1.SendMessage( MyMsg[A].chatId, MyMsg[A].Text, MyMsg[A].ParseMode) <> nil then
            DeleteArrayItem(MyMsg,A)
          else
            continue;

          Clique := Clique - 1;
          if A = Length(MyMsg) -1 then
          Begin
            Sending := False;
            Clique := 0;
            Break;
          End;

        End;
      End
      Else Begin
        Sleep(500);
        Continue;
      End;
    end;

  end
  );
  MT.FreeOnTerminate := True;
  MT.Start;

end;

procedure TForm1.Button7Click(Sender: TObject);
var
  MT: TThread;
begin
    MT := TThread.CreateAnonymousThread(procedure
    var
      I: Integer;
    begin
      for I := 1 to 5 do
       Begin
        InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),'TEXTO '+I.ToString,
           LParseMode, False, False, 0, False, LMarkup);
        if I < 5 then
          InjectTelegramBot1.IsBusy := True;
        if I = 5 then
          InjectTelegramBot1.IsBusy := False;
       End;
    end
    );
    MT.FreeOnTerminate := True;
    MT.Start;
end;

procedure TForm1.Button8Click(Sender: TObject);
var
 MyBT: TtdKeyboardWebAppButton; //TtdKeyboardWebAppButton
 web: TtdWebAppInfo;
 url, ButtonName: string;
begin

  try
    url := InputBox('Preencha o Campo com sua URL do Web Bot','URL','https://www.produlog.com.br/tinjecttelegram/');
    ButtonName := InputBox('Preencha o Campo com um nome para o Botão do Web Bot','Nome do Botão','OLA');

    web := TtdWebAppInfo.Create(url);

    MyBT := TtdKeyboardWebAppButton.Create(ButtonName, web);

    LMarkup := TtdReplyKeyboardMarkup.Create([
    { Primeira Linha }
    [MyBT],
    { Segunda Linha }
    []], TRUE);
    if BotManager1.IsActive then
    Begin
      if txtID.Text <> '' then
      try
        InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),
          'Acesse aqui o web bot e divirte-se testando!',
          LParseMode, False, False, 0, False, LMarkup)
      except on E: Exception do
        memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
      end;
    End
    else
      Showmessage(VRes_Ative_Servico);
  finally
    web.Free;
  end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
 MyBT: TtdInlineKeyboardButton{TtdInlineKeyboardWebAppButton};
 web: TtdWebAppInfo;
 url, ButtonName: string;
begin

  url := InputBox('Preencha o Campo com sua URL do Web Bot','URL','https://www.produlog.com.br/tinjecttelegram/cafe');
  ButtonName := InputBox('Preencha o Campo com um nome para o Botão do Web Bot','Nome do Botão','TESTE');

  web := TtdWebAppInfo.Create(url);

  MyBT := TtdInlineKeyboardButton.Create(ButtonName, web);
 // MyBT.SwitchInlineQuery := '123456';
 // MyBT.WebApp := web;
  LMarkup := TtdInlineKeyboardMarkup.Create([
  { Primeira Linha }
  [MyBT]]);
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),
        'Acesse aqui o web bot e divirte-se testando!',
        LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);

end;

procedure TForm1.btnEnviarTxtComBTInlineClick(Sender: TObject);
begin
{
Aqui você cria os botoes do tipo ReplyKeyboard para enviar na mensagem
eles serão criados como um teclado personalizado para seu destinatario
}
//Necessario declarar TelegAPI.Types.ReplyMarkups
LMarkup := TtdInlineKeyboardMarkup.Create([
  { Primeira Linha }
  [TtdInlineKeyboardButton.Create('Texto1Embutido','texto1retornoembutido'),
  TtdInlineKeyboardButton.Create('Texto2Embutido','texto2retornoembutido')],
  { Segunda Linha }
  [TtdInlineKeyboardButton.Create('Texto3Embutido','texto3retornoembutido')]]);
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegramBot1.SendMessage(StrToInt64(txtID.Text),VRes_MSG_Exemplo_Envio_BT, LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;
function SingleToStr(Value: String): String;
var
  FloatValue:  Extended;
Begin
  floatValue  := strtofloat(Value);
  result := FloatToStr(floatValue);
End;
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  if InjectTelegramReceiverService1.IsActive then
//    InjectTelegramReceiverService1.Stop;
  if BotManager1.IsActive then
    BotManager1.Stop;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
  {Envie Markdown ou HTML, se você deseja que os aplicativos Telegram
  mostrem texto em negrito, itálico, largura fixa ou URLs embutidos na
  mensagem do seu bot.}
  LParseMode := TtdParseMode.Markdown; //Necessario declarar TelegAPI.Types.Enums
  FileCount := 0;
  AbrirArquivo.InitialDir := '../../'+ExtractFilePath(Application.ExeName)+'\midias';
end;
procedure TForm1.FormShow(Sender: TObject);
begin
  AplicarResource;
end;
procedure TForm1.GetForumStikersTopicClick(Sender: TObject);
var
  MyStickerArray : TArray<ItdSticker>;
  I: Integer;
begin

  if BotManager1.IsActive then
  Begin
    try
      SetLength(MyStickerArray, Length(BotManager1.Bot.getForumTopicIconStickers) + 1);
      MyStickerArray := BotManager1.Bot.getForumTopicIconStickers;

      for I := 0 to Length(MyStickerArray) - 1 do
      Begin
        memConsole.Lines.Add(
          '---------------------------------------------------------------------'+sLineBreak+
          'CustomEmojiId : '+MyStickerArray[I].CustomEmojiId.ToString+sLineBreak+
          'Emoji : '+MyStickerArray[I].Emoji+sLineBreak);
      End;

     // memConsole.Lines.Add(TJsonUtils.ArrayToJString<TtdSticker>(BotManager1.Bot.getForumTopicIconStickers));
    except on E: Exception do
      memConsole.Lines.Add('Falha ao criar um tópico - ' + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.InjectTelegramBot1Disconect(ASender: TObject;
  const AErrorCode: string);
begin
//  while Not BotManager1.IsActive do
//  Begin
//    BotManager1.Stop;
//    Sleep(1000);
//    BotManager1.Start;
//  End;
  //Showmessage('Sua Aplicação perdeu a conexão com o servidor!');
end;
procedure TForm1.InjectTelegramBot1ReceiveRawData(ASender: TObject;
  const AData: string);
var
  TLOEvent, TLOReplyMarkup: ISuperObject;
  TLAInlineKeyBoard: ISuperArray;
  I: Integer;

  LValue: string;
  LObj: TJSONValue;
  FJSON: TJSONObject;
  MyKey: TtdInlineKeyboardMarkup;
begin
//  Result := nil;
//  LObj := FJSON.GetValue('reply_markup');
//  if Assigned(LObj) and (not LObj.Null) then
//  begin
//
//    LValue := LObj.ToJSON;
//
//   // MyKey := FJSON.Create(LValue) as T;
//  end;

{$REGION 'DOCUMENTATION'}
(*

{
   "ok":true,
   "result":[
      {
         "update_id":118364456,
         "message":{
            "message_id":7250,
            "from":{
               "id":1042366601,
               "is_bot":false,
               "first_name":"Ruan Diego",
               "last_name":"Lacerda Menezes",
               "username":"diegolacerdamenezes",
               "language_code":"pt-br"
            },
            "chat":{
               "id":1042366601,
               "first_name":"Ruan Diego",
               "last_name":"Lacerda Menezes",
               "username":"diegolacerdamenezes",
               "type":"private"
                  },
            "date":1650550138,
            "forward_from_chat":{
               "id":-1001560050482,
               "title":"HOLDING IR TR UR",
               "type":"channel"
            },
            "forward_from_message_id":151,
            "forward_date":1648714863,
            "photo":[
               {
                  "file_id":"AgACAgQAAxkBAAIcUmJhZXrj4LtPciacYnwfMiFpZiICAAKUuTEbo7opUg0LK__MttVVAQADAgADcwADJAQ",
                  "file_unique_id":"AQADlLkxG6O6KVJ4",
                  "file_size":2701,
                  "width":87,
                  "height":90
               },
               {
                  "file_id":"AgACAgQAAxkBAAIcUmJhZXrj4LtPciacYnwfMiFpZiICAAKUuTEbo7opUg0LK__MttVVAQADAgADbQADJAQ",
                  "file_unique_id":"AQADlLkxG6O6KVJy",
                  "file_size":40897,
                  "width":310,
                  "height":320
               },
               {
                  "file_id":"AgACAgQAAxkBAAIcUmJhZXrj4LtPciacYnwfMiFpZiICAAKUuTEbo7opUg0LK__MttVVAQADAgADeAADJAQ",
                  "file_unique_id":"AQADlLkxG6O6KVJ9",
                  "file_size":147542,
                  "width":774,
                  "height":800
               },
               {
                  "file_id":"AgACAgQAAxkBAAIcUmJhZXrj4LtPciacYnwfMiFpZiICAAKUuTEbo7opUg0LK__MttVVAQADAgADeQADJAQ",
                  "file_unique_id":"AQADlLkxG6O6KVJ-",
                  "file_size":171172,
                  "width":968,
                  "height":1000
               }],
            "caption":"\u062e\u062f\u0627 \u0642\u0648\u062a \u062f\u0648\u0633\u062a
                      \u0639\u0632\u06cc\u0632.\ud83c\udf08\ud83c\udf08\ud83d\udc99\n\n\ud83c
                      \udf3a\ud83c\udf3a\ud83c\udf3a\u0627\u0645\u06cc\u062f\u0648\u0627\u0631
                      \u06cc\u0645 \u0632\u0646\u062f\u06af\u06cc\u062a\u0648\u0646 \u067e\u0631
                      \u0627\u0632 \u0634\u0627\u062f\u06cc \u0648 \u0635\u0641\u0627 \u0628\u0627
                      \u0634\u0647\ud83c\udf3a\ud83c\udf3a\ud83c\udf3a\n\n\ud83c\udf0e\ud83c\udf0e
                      \u06af\u0631\u0648\u0647 \u0642\u062f\u0631\u062a\u0645\u0646\u062f \u062a
                      \u0628\u0644\u06cc\u063a \u0631\u0627\u06cc\u06af\u0627\u0646 : \u062a\u0631
                      \u06a9\u06cc\u0647|| \u0627\u06cc\u0631\u0627\u0646 || \u062c\u0647\u0627
                      \u0646||\ud83c\udf0e\ud83c\udf0e\n\n \ud83d\udc99\ud83d\udc99\u067e\u0631
                      \u0628\u0627\u0632\u062f\u06cc\u062f \u0628\u0631\u0627\u06cc \u0645\u0639
                      \u0631\u0641\u06cc \u0648 \u0631\u0648\u0646\u0642 \u062a\u062c\u0627\u0631
                      \u062a \u0648 \u06a9\u0633\u0628 \u0648 \u06a9\u0627\u0631 \u0634\u0645\u0627
                      \u062f\u0631 \u0627\u06cc\u0631\u0627\u0646\u060c\u062a\u0631\u06a9\u06cc\u0647
                      \u0648 \u0627\u0631\u0648\u067e\u0627\ud83d\udc99\ud83d\udc99\n\n\u0628\u062f\u0648
                      \u0646 \u0645\u062d\u062f\u0648\u062f\u06cc\u062a \u0645\u06cc\u062a\u0648\u0646
                      \u06cc\u062f \u062a\u0628\u0644\u06cc\u063a \u06a9\u0646\u06cc\u0646.\ud83d\udc99
                      \ud83c\udf3a\ud83d\udc99\n\ud83d\udc4c\ud83d\udc4c\ud83d\udc4c\u0634\u0627\u0645
                      \u0644 \u0645\u0639\u0631\u0648\u0641\u062a\u0631\u06cc\u0646 \u0641\u0639\u0627
                      \u0644\u0627\u0646 \u0635\u0646\u0641\u06cc \u0648 \u0628\u0631\u0646\u062f\u0647
                      \u0627\u06cc \u0645\u0639\u062a\u0628\u0631 \u06a9\u0633\u0628 \u0648 \u06a9\u0627
                      \u0631 \u062f\u0631 \u062a\u0631\u06a9\u06cc\u0647-\u0627\u06cc\u0631\u0627\u0646-
                      \u06af\u0631\u062c\u0633\u062a\u0627\u0646  \ud83d\udc4c\ud83d\udc4c\ud83d\udc4c
                      \n\n\n\ud83d\udfe2\u062a\u0628\u0644\u06cc\u063a\u0627\u062a \u0622\u0632\u0627
                      \u062f\n\ud83d\udfe2\u0631\u06af\u0628\u0627\u0631\u06cc\n\ud83d\udfe2\u0641\u0627
                      \u0635\u0644\u0647 \u06cc \u0628\u06cc\u0646 \u0647\u0631 \u067e\u0633\u062a : 10
                      \u062b\u0627\u0646\u06cc\u0647\n\ud83d\udfe2\u0634\u0628\u0627\u0646\u0647
                      \u0631\u0648\u0632\u06cc\n\n\u0628\u0647\u062a\u0631\u06cc\u0646 \u06af\u0631\u0648
                      \u0647 \u0628\u0627\u0632\u0627\u0631\u06cc\u0627\u0628\u06cc \u0648 \u062a\u062c
                      \u0627\u0631\u062a \u0648 \u06a9\u0633\u0628 \u0648 \u06a9\u0627\u0631\ud83c\udf3a
                      \ud83c\udf3a\ud83c\udf3a\n\n\ud83d\udc47\ud83d\udc47\ud83d\udc47\u06a9\u0644\u06cc
                      \u06a9 \u06a9\u0646\u06cc\u062f\ud83d\udc47\ud83d\udc47\ud83d\udc47",
            "reply_markup":{
               "inline_keyboard":[
                  [
                     {
                        "text":"\u0648\u0631\u0648\u062f \u0628\u0647 \u06af\u0631\u0648\u0647  \u0627\u06cc\u0631\u0627\u0646  \u062a\u0631\u06a9\u06cc\u0647  \u062c\u0647\u0627\u0646",
                        "url":"https://t.me/+FxR3O_lP8oZmM2Q0"
                     }
                  ]
               ]
            }
         }
      }
   ]
}

//  memConsole.Lines.Add('ID : '+TLOEvent.A['result'].O[0].I['update_id'].ToString);
//  memConsole.Lines.Add('CAPTION : '+TLOEvent.A['result'].O[0].O['message'].S['caption']);
//
//  memConsole.Lines.Add('CHAT ID : '+TLOEvent.A['result'].O[0].O['message'].O['chat'].I['id'].ToString );
//  memConsole.Lines.Add('FORWARD ID : '+TLOEvent.A['result'].O[0].O['message'].I['forward_from_message_id'].ToString);
//  memConsole.Lines.Add('MESSAGE ID : '+TLOEvent.A['result'].O[0].O['message'].I['message_id'].ToString);
//  memConsole.Lines.Add('REPLYMARKUP : '+TLOEvent.A['result'].O[0].O['message'].O['reply_markup'].A['inline_keyboard'].A[0].O[0].S['text']);
//  memConsole.Lines.Add('URL : '+TLOEvent.A['result'].O[0].O['message'].O['reply_markup'].A['inline_keyboard'].A[0].O[0].S['url']);

*)
{$ENDREGION 'DOCUMENTATION'}

//  if (AData <> '{"ok":true,"result":[]}') and (AData <> '{"ok":true,"result":true}') then
//    memConsole.Lines.Add('RECEIVING : '+AData);
//
//  ///For example:
//  TLOEvent := SO(AData);
//
//  if TLOEvent <> nil then
//  Begin
//    if Assigned(TLOEvent.A['result'].O[0].O['message'].O['reply_markup']) then
//    Begin
//      TLOReplyMarkup := TLOEvent.A['result'].O[0].O['message'].O['reply_markup'];
//      TLAInlineKeyBoard := TLOReplyMarkup.A['inline_keyboard'];
//      for I := 0 to TLOReplyMarkup.A['inline_keyboard'].A[0].Length -1  do
//      Begin
//
//        ///
//        /// Here you do what you need with the button
//        ///
//
//        ///For example:
//        memConsole.Lines.Add('TEXTO : '+TLAInlineKeyBoard.A[0].O[I].S['text']);
//        memConsole.Lines.Add('URL : '+TLAInlineKeyBoard.A[0].O[I].S['url']);
//      End;
//    End;
//  End;

  (*
{
   "ok":true,
   "result":{
      "file_id":"AgACAgQAAxkBAAIcY2Jhdu-dCZnuiVt7kgY4PaBYUTiHAAKXuDEb8fSQUq_9U-I_3GU7AQADAgADcwADJAQ",
      "file_unique_id":"AQADl7gxG_H0kFJ4",
      "file_size":2246,
      "file_path":"photos/file_15.jpg"
   }
}
  *)

end;
procedure TForm1.InjectTelegramBot1SendData(ASender: TObject; const AUrl,
  AData: string);
begin
//  memConsole.Lines.Add('SENDING URL: '+AUrl);
//  memConsole.Lines.Add('SENDING DATA: '+AData);
end;
procedure TForm1.InjectTelegramExceptionManagerUI1Log(ASender: TObject;
  const Level: TLogLevel; const Msg: string; E: Exception);
  var Texto: String;
begin
  if level >= TLogLevel.Error then
  begin
    if Assigned(e) then
    Begin
      memConsole.Lines.Add(msg + ' [ '+Texto + ' '+ e.ToString + '] ' );
    End
    else
      memConsole.Lines.Add(msg);
  end;
end;
procedure TForm1.ReceiverCallbackQuery(ASender: TObject;
  ACallbackQuery: ItdCallbackQuery);
  var
  Res: TtdInlineQueryResult;
begin
  if ACallbackQuery.Data.ToLower.Equals('texto1retornoembutido') then
    memConsole.Lines.Add(VRes_O_Usuario+
      ACallbackQuery.From.FirstName+VRes_Solicitou+
      ACallbackQuery.Data);
  if ACallbackQuery.Data.ToLower.Equals('texto2retornoembutido') then
    memConsole.Lines.Add(VRes_O_Usuario+
      ACallbackQuery.From.FirstName+VRes_Solicitou+
      ACallbackQuery.Data);
  if ACallbackQuery.Data.ToLower.Equals('texto3retornoembutido') then
    memConsole.Lines.Add(VRes_O_Usuario+
      ACallbackQuery.From.FirstName+VRes_Solicitou+
      ACallbackQuery.Data);

  if ACallbackQuery.Data.ToLower.Equals('inicio') then
    BotManager1.Bot.SendMessage(ACallbackQuery.From.ID,'Botão Criado!');

  if ACallbackQuery.Data.ToLower.Equals('fechar') then
    BotManager1.Bot.SendMessage(ACallbackQuery.From.ID,'Botão Destruido!');

  if ACallbackQuery.Data.ToLower.Equals('123456789456') then
  Begin
    try
      Res := TtdInlineQueryResult.Create;
      Res.ID := '123456789456';
      Res.&Type := 'article';
      Res.Title := 'TESTE DE TITULO';
      Res.InputMessageContent := TtdInputTextMessageContent.Create('OLA MUNDO','Markdown' ,False);
      memConsole.Lines.Add('inline_message_id : '+BotManager1.Bot.answerWebAppQuery('123456789456',Res).inline_message_id);
    finally
      Res.Free;
    end;
  End;

end;
procedure TForm1.ChosenInlineResult(
  ASender: TObject; AChosenInlineResult: ItdChosenInlineResult);
begin
  if AChosenInlineResult.Query.ToLower.Equals('texto3retornoembutido') then
    memConsole.Lines.Add(VRes_O_Usuario+
      AChosenInlineResult.From.FirstName+VRes_Solicitou+
      AChosenInlineResult.Query);
end;

procedure TForm1.CriarTopicoClick(Sender: TObject);
var
  MyTopic: ItdForumTopic;
  TopicName: string;
begin
  if BotManager1.IsActive then
  Begin
    TopicName := InputBox('Informe um Nome para o Tópico', 'Nome','TInjectTelegram - Topic01');
    if txtID.Text <> '' then
    try
      MyChatId := TtdUserLink.FromID(StrToInt64(txtID.Text));
      MyTopic := BotManager1.Bot.createForumTopic(MyChatId.ID, TopicName);
      BotManager1.Bot.SendMessage(MyTopic.message_thread_id, 'Texto de Abertura para o Topico Do TInjectTelegramBot',
      LParseMode,False,False,0,False,LMarkup,False);
    except on E: Exception do
      memConsole.Lines.Add('Falha ao criar um tópico - ' + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.CarregarBTStr(AStrArrayBtName: TArray<TArray<String>>;
  AInlineMode: Boolean; url: string);
var
  I, O: Integer;
  str: String;
  //InLine Mode
  LButtonIL: TArray<TtdInlineKeyboardButton>;
  DButtonIL: TArray<TtdInlineKeyboardButton>;
  RButtonIL: TArray<TArray<TtdInlineKeyboardButton>>;

  //Reply Mode
  LButton : TArray<TtdKeyboardButton>;
  DButton : TArray<TtdKeyboardButton>;
  RButton : TArray<TArray<TtdKeyboardButton>>;

  webinfo: TtdWebAppInfo;
Begin
{
Exemplo de uso
Assim ela criara os botoes de acordo com a quantidade de itens do array bidimencional
 CarregarBTStr([['REMOVER','FINALIZAR'],['INICIO','SAIR']]);
}
  try
    SetLength(AStrArrayBtName, Length(AStrArrayBtName[0]) + Length(AStrArrayBtName[1]));

    if AInlineMode = False then  //Reply Mode
    Begin

      SetLength(LButton, Length(AStrArrayBtName[0]));
      SetLength(DButton, Length(AStrArrayBtName[1]));
      SetLength(RButton, Length(LButton) + Length(DButton));

      for I := 0 to Length(AStrArrayBtName[0]) - 1 do
        LButton[I] := TtdKeyboardButton.Create(String(AStrArrayBtName[0,I]));

      if Length(AStrArrayBtName[1]) > 0 then
      Begin
        for O := 0 to Length(AStrArrayBtName[1]) - 1 do
          DButton[O] := TtdKeyboardButton.Create(String(AStrArrayBtName[1,O]));

        RButton[LOW(RButton)]   := LButton;
        RButton[HIGH(RButton)]  := DButton;

        LMarkup := TtdReplyKeyboardMarkup.Create(RButton,TRUE);
      End Else
        LMarkup := TtdReplyKeyboardMarkup.Create([LButton],TRUE);
    End
      Else //Inline Mode
    Begin

      SetLength(LButtonIL, Length(AStrArrayBtName[0]));
      SetLength(DButtonIL, Length(AStrArrayBtName[1]));
      SetLength(RButtonIL, Length(LButtonIL) + Length(DButtonIL));

      for I := 0 to Length(AStrArrayBtName[0]) - 1 do
      begin
        LButtonIL[I] := TtdInlineKeyboardButton.Create(String(AStrArrayBtName[0,I]),String(AStrArrayBtName[0,I]));
      end;

      if Length(AStrArrayBtName[1]) > 0 then
      Begin
        for O := 0 to Length(AStrArrayBtName[1]) - 1 do
        begin
          DButtonIL[O] := TtdInlineKeyboardButton.Create(String(AStrArrayBtName[1,O]),String(AStrArrayBtName[1,O]));
        end;

        RButtonIL[LOW(RButtonIL)] := LButtonIL;
        RButtonIL[HIGH(RButtonIL)] := DButtonIL;

        LMarkup := TtdInlineKeyboardMarkup.Create(RButtonIL);
      End
        Else
          LMarkup := TtdInlineKeyboardMarkup.Create([LButtonIL]);
    End;

  finally
    LButtonIL := Nil;
    DButtonIL := Nil;
    RButtonIL := Nil;

    LButton := Nil;
    DButton := Nil;
    RButton := Nil;
  end;

end;

procedure TForm1.ReceiverMessage(ASender: TObject;
  AMessage: ItdMessage);
var
  mRPL : IReplyMarkup;
  I: Integer;
  A: Integer;
  AOutDir: String;
begin
(*
data_check_string = ...
secret_key = HMAC_SHA256(<bot_token>, "WebAppData")
if (hex(HMAC_SHA256(data_check_string, secret_key)) == hash) {
  // data is from Telegram
}


uses system.hash;

var s, sst:string;
bt:TBytes;

HMAC 256:

s:=THashSHA2.GetHMAC(DATA, KEY, SHA256);

base64 HMAC 256:

bt:= THashSHA2.GetHMACAsBytes(DATA, KEY, SHA256);
sst:= TNetEncoding.Base64.EncodeBytesToString(bt);


*)
//  if AMessage.ReplyMarkup <> nil then
//  Begin
//    mRPL := TtdInlineKeyboardMarkup(AMessage.ReplyMarkup);
//
//    for I := 0 to TtdInlineKeyboardMarkup(mRPL).RefCount -1 do
//    bEGIN
//      for A := 0 to TtdInlineKeyboardMarkup(mRPL).RefCount -1 do
//      BEGIN
//        memConsole.Lines.Add('Keyboard ('+IntToStr(I) +', '+IntToStr(A)+')  '+TtdInlineKeyboardMarkup(mRPL).Keyboard[I][A].Text);
//      end;
//    end;
//  End;
 (*

'{"inline_keyboard":[[{"text":"asdfasdf","url":"aswdfasdf"}]]}'
 *)
//  if AMessage.ReplyMarkup <> NIl then
//  Begin
//    memConsole.Lines.Add('Text = '+((AMessage as TtdMessage).ReplyMarkup as TtdInlineKeyboardMarkup).Keyboard[0][0].Text);
//    memConsole.Lines.Add('Url = '+((AMessage as TtdMessage).ReplyMarkup as TtdInlineKeyboardMarkup).Keyboard[0][1].Url);
//    memConsole.Lines.Add('CallbackData = '+((AMessage as TtdMessage).ReplyMarkup as TtdInlineKeyboardMarkup).Keyboard[0][1].CallbackData);
//  End;

  if AMessage.WebAppData <> nil then
  Begin
    memConsole.Lines.Add('WEB DATA : ');
    memConsole.Lines.Add('button_text : '+AMessage.WebAppData.button_text);
    memConsole.Lines.Add('data : '+AMessage.WebAppData.data);
  End;

  if AMessage.Text <> '' then
    memConsole.Lines.Add(
      'Mensagem do Usuário '+ AMessage.From.FirstName+' : '+AMessage.Text);
    with BotManager1 do
    Begin
      with Conversa do
      Begin
        memConsole.Lines.Add(
          'Coversa ID : '+ ID+sLineBreak+
          'MSG : '+ TextoMSG+sLineBreak+
          'IdChat : ' + IdChat.ToString+sLineBreak+
          'Nome : ' + Nome+sLineBreak+
          'UltimaIteracao : ' +TimeToStr(UltimaIteracao)+sLineBreak+
          'MessageThreadId : '+AMessage.MessageThreadId.ToString+sLineBreak+
          '***********************************************************');
      End;
    End;
  if AMessage.&Type = TtdMessageType.ContactMessage then
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+VRes_Compartilhou_CTT+
      VRes_Telefone +AMessage.Contact.PhoneNumber+
      ' ID : '+AMessage.Contact.UserId.ToString);
  if AMessage.&Type = TtdMessageType.LocationMessage then
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+VRes_Compartilhou_Localizacao+
      'Latitude : '+AMessage.Location.Latitude.ToString+
      ' Longitude : '+AMessage.Location.Longitude.ToString);
  if AMessage.Text.ToLower.Equals('meuid') then
  Begin
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+' ID : '+AMessage.From.ID.ToString+VRes_Solicitou+
      '' + AMessage.Text);
    MyChatId  := TtdUserLink.FromID(AMessage.From.ID);
    BotManager1.Bot.SendMessage(MyChatId,
        AMessage.From.FirstName+' '+VRes_Solicitou+' '+AMessage.Text+sLineBreak+
        ' Seu ID é: '+AMessage.From.ID.ToString,
        LParseMode, False, False,0,False{,LMarkup, False});
  End;
  if AMessage.Text.ToLower.Equals('inicio') then
  Begin
    memConsole.Lines.Add('Botão Criado');
      MyChatId  := TtdUserLink.FromID(AMessage.From.ID);
      BotManager1.Bot.SetChatMenuButton(MyChatId,
        'https://produlog.com.br/tinjecttelegram/',
        'TinjectTelegram',TtdMenuButtonType.MenuButtonWebApp);
  End;
  if AMessage.Text.ToLower.Equals('fechar') then
  Begin
    memConsole.Lines.Add('Botão Destruido');
      MyChatId  := TtdUserLink.FromID(AMessage.From.ID);
      BotManager1.Bot.SetChatMenuButton(MyChatId,
        'https://produlog.com.br/tinjecttelegram/',
        'TinjectTelegram',TtdMenuButtonType.MenuButtonCommands);
  End;
  if (Pos(LowerCase(AMessage.Text),'oi.ola.bom.dia.boa.tarde.noite') > 0) then
  Begin

     // CarregarBTStr([['Web Bot']], true,'https://produlog.com.br/tinjecttelegram/');
      MyChatId  := TtdUserLink.FromID(AMessage.From.ID);
      BotManager1.Bot.SendMessage(MyChatId,
        'Olá, Digite inicio para criar o botão do webbot e fechar para destruir o botão.',
        LParseMode, False, False,0,False{,LMarkup, False});

  End;
  if AMessage.ReplyToMessage <> NIl then
    memConsole.Lines.Add(
      'Resposta do Usario : '+ AMessage.From.FirstName+sLineBreak+
      ' Para o Usario : '+ AMessage.ReplyToMessage.From.FirstName+sLineBreak+
      ' ID MSG Resposta : '+AMessage.From.ID.ToString+sLineBreak+
      ' ID MSG Pergunta : '+AMessage.ReplyToMessage.From.ID.ToString+sLineBreak+
      ' Resposta : ' + AMessage.Text+sLineBreak+
      ' Pergunta : ' + AMessage.ReplyToMessage.Text);

  //it is necessary to give permission to the project folder so that the bot can create the folders
  //Com CMD usar os Comandos para dar Permissão: ICACLS NomeOuDiretórioDoArquivo /GRANT NomeDoUsuárioOuGrupoDeUsuários:F
  With BotManager1 do
  Begin
    if Conversa.ArquivoRecebido <> '' then
    Begin  //memConsole is TMemo
      memConsole.Lines.Add('Arquivo Recebido : '+ ExtractFileNameFromURL(Conversa.ArquivoRecebido)); //ExtractFileNameFromURL is New Metod from Compoent TinjectTelegramBotManager
      if CreateSubDir(Conversa.IdCliente.ToString, AOutDir) then   //CreateSubDir is New Metod from Compoent TinjectTelegramBotManager
      Begin
        memConsole.Lines.Add('OutDir : '+ AOutDir);  //Var AOutDir: string;
        if DownloadFile(Conversa.ArquivoRecebido, AOutDir) then   //DownloadFile is New Metod from Compoent TinjectTelegramBotManager
          memConsole.Lines.Add('Arquivo Baxado em : '+ AOutDir+' ...')
        else
          memConsole.Lines.Add('Erro ao baixar o arquivo : '+ ExtractFileName(Conversa.ArquivoRecebido));
      End
      Else
        memConsole.Lines.Add('Erro ao criar a pasta : '+ AOutDir+'\'+Conversa.IdCliente.ToString);
    End;
  End;
end;
procedure TForm1.SendTextTopicClick(Sender: TObject);
var
  MyTopicId: Int64;
begin
  if BotManager1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      MyTopicId := InputBox('Informe o Id do Topico', 'ID','0').ToInt64;
      MyChatId := TtdUserLink.FromID(StrToInt64(txtID.Text));
      BotManager1.Bot.SendMessage(
        MyChatId.ID,
        VRes_Este_Seu_ID + MyChatId.ID.ToString,
        LParseMode, False, cbDisableNotification.Checked, 0,
        False, LMarkup, cbProtectedContent.Checked, MyTopicId);
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.ServiceStart(Sender: TObject);
begin
  memConsole.Lines.Add(VRes_Servico_Ativo);
end;
procedure TForm1.ServiceStop(Sender: TObject);
begin
  memConsole.Lines.Add(VRes_Servico_Desativado);
end;
end.

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
  TInjectTelegram.Bot.Impl,

  Vcl.Imaging.pngimage, uResourceString, TInjectTelegram.Bot.Manager;

type
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

  private

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
      InjectTelegramBot1.SendAudio(StrToInt64(txtID.Text), MyFile,VRes_Texto_Audio, LParseMode, 0,'Titulo Sobreescrito',False, 0, False, LMarkup);
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
        if BoolStream then
          InjectTelegramBot1.SendPhoto(StrToInt64(txtID.Text), MyFile,VRes_Texto_Foto+ ' - From Stream', LParseMode, False, 0, False, LMarkup)
        else
          InjectTelegramBot1.SendPhoto(StrToInt64(txtID.Text), MyFile,VRes_Texto_Foto+ ' - From File', LParseMode, False, 0, False, LMarkup);
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
        VRes_Texto_Animacao, LParseMode, False, 0, False, LMarkup);
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
  MyContact := TtdContact.Create('5521997196000','Ruan Diego','Lacerda Menezes');

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
    try                                                           //Thumb 320x320 px até 200k
      InjectTelegramBot1.SendDocument(StrToInt64(txtID.Text), MyFile, nil , VRes_Texto_Documento, LParseMode, [], False, False, 0, False, LMarkup);
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
          InjectTelegramBot1.sendMediaGroup(MyChatId.ID, MyMedia, False, 0, False);
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
              LParseMode, 30, 5, False, False, 0, False, LMarkup);
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
      InjectTelegramBot1.SendSticker(StrToInt64(txtID.Text), MyFile, False, 0, LMarkup);
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
      InjectTelegramBot1.SendVideo(StrToInt64(txtID.Text), MyFile,VRes_TExto_Video, LParseMode, True, 0, 0, 0, False, 0, False, LMarkup);
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
      {InjectTelegramBot1}BotManager1.Bot.SendMessage(MyChatId.ID, VRes_Este_Seu_ID + MyChatId.ID.ToString, LParseMode, False, False, 0, False, LMarkup)
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
begin
{
Aqui você cria os botoes do tipo ReplyKeyboard para enviar na mensagem
eles serão criados como um teclado personalizado para seu destinatario
}
LMarkup := TtdReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtdKeyboardButton.Create('texto1', FALSE, FALSE),
  TtdKeyboardButton.Create('texto2', FALSE, FALSE)],
  { Segunda Linha }
  [TtdKeyboardButton.Create(VRes_Qual_Meu_ID, FALSE, FALSE)]], TRUE);

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
  if (txtToken.Text = '') or (length(txtToken.Text) < 20) then
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
begin
 // memConsole.Lines.Add('RECEIVING : '+AData);
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

end;

procedure TForm1.ChosenInlineResult(
  ASender: TObject; AChosenInlineResult: ItdChosenInlineResult);
begin
  if AChosenInlineResult.Query.ToLower.Equals('texto3retornoembutido') then
    memConsole.Lines.Add(VRes_O_Usuario+
      AChosenInlineResult.From.FirstName+VRes_Solicitou+
      AChosenInlineResult.Query);
end;

procedure TForm1.ReceiverMessage(ASender: TObject;
  AMessage: ItdMessage);
begin

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
  End;

  if AMessage.ReplyToMessage <> NIl then
    memConsole.Lines.Add(
      'Resposta do Usario : '+ AMessage.From.FirstName+sLineBreak+
      ' Para o Usario : '+ AMessage.ReplyToMessage.From.FirstName+sLineBreak+
      ' ID MSG Resposta : '+AMessage.From.ID.ToString+sLineBreak+
      ' ID MSG Pergunta : '+AMessage.ReplyToMessage.From.ID.ToString+sLineBreak+
      ' Resposta : ' + AMessage.Text+sLineBreak+
      ' Pergunta : ' + AMessage.ReplyToMessage.Text);

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

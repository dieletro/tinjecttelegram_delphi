unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  CrossUrl.Indy.HttpClient,
  CrossUrl.SystemNet.HttpClient,
  TelegAPI.UpdateParser,
  TelegAPI.Receiver.Base,
  TelegAPI.Receiver.Service,
  TelegAPI.Receiver.UI,
  TelegAPI.Logger,
  TelegAPI.Logger.Old,
  TelegAPI.Base,
  TelegAPI.Types, {Uso Especifico}
  TelegAPI.Types.Impl, {Uso Especifico}
  TelegAPI.Types.Enums, {Uso Especifico}
  TelegAPI.Types.ReplyMarkups,{Uso Especifico}
  TelegAPI.Bot, {Uso Especifico}
  TelegAPI.Bot.Impl, Vcl.Imaging.pngimage, uResourceString;

type
  TForm1 = class(TForm)
    Image1: TImage;
    btnEnviaTexto: TButton;
    txtToken: TEdit;
    Label1: TLabel;
    InjectTelegram1: TInjectTelegram;
    InjectTelegramExceptionManagerUI1: TInjectTelegramExceptionManagerUI;
    Button2: TButton;
    Button3: TButton;
    InjectTelegramReceiverService1: TInjectTelegramReceiverService;
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
    procedure btnEnviaTextoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure InjectTelegramReceiverService1Start(Sender: TObject);
    procedure InjectTelegramReceiverService1Stop(Sender: TObject);
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
    procedure InjectTelegramReceiverService1CallbackQuery(ASender: TObject;
      ACallbackQuery: ItgCallbackQuery);
    procedure InjectTelegramReceiverService1Message(ASender: TObject;
      AMessage: ITgMessage);
    procedure InjectTelegramReceiverService1ChosenInlineResult(ASender: TObject;
      AChosenInlineResult: ItgChosenInlineResult);
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

  private

    { Private declarations }
  public
    procedure AplicarResource;
  var

    //Variaveis Globais
    MyCallback      : ItgCallbackQuery;
    MyMessage       : ItgMessage;
    MyInlineQuery   : ItgInlineQuery;

    MyFile          : TtgFileToSend;
    MyFiles         : TArray<TtgFileToSend>;
    MyLocation      : TtgLocation;
    MyVenue         : TtgVenue;
    MyMedia         : TArray<TtgInputMedia>;
    MyChatId        : TtgUserLink;
    MyContact       : Ttgcontact;
    MyAction        : TtgSendChatAction;
    MyPrices        : TArray<TtgLabeledPrice>;
    MyPollKey       : TtgKeyboardButtonPollType;  //Novo Recurso

    //SemUso...
    MyFotoFile      : TtgInputMediaPhoto;  //Add para teste

    LParseMode      : TtgParseMode; //Necessario declarar TelegAPI.Types.Enums
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
      MyFiles[FileCount - 1] := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

    SetLength(MyMedia, Length(MyFiles));

    if ExtractFileExt(AbrirArquivo.FileName) = '.png' then
      MyMedia[FileCount - 1] := TtgInputMediaPhoto.Create(MyFiles[FileCount - 1], VRes_Teste_MidiaGroup);
    if ExtractFileExt(AbrirArquivo.FileName) = '.mp4' then
      MyMedia[FileCount - 1] := TtgInputMediaVideo.Create(MyFiles[FileCount - 1], VRes_Teste_MidiaGroup);
  End
  Else
    Showmessage(VRes_Limite_Arquivos_MediaGroup);

end;

procedure TForm1.btnApagarBotoesClick(Sender: TObject);
begin
{
Aqui você Remove botoes do destinatario,apenas seguindo a mensagem
}
//Necessario declarar TelegAPI.Types.ReplyMarkups    //TtgReplyKeyboardRemove
LMarkup := TtgReplyKeyboardRemove.Create;

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(StrToint(txtID.Text),VRes_Ex_Remover_BT, LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);
end;

procedure TForm1.btnComoSaberIDClick(Sender: TObject);
begin

  Showmessage(VRes_Use_Seu_Cel_Envio_MeuID);

end;

procedure TForm1.btnEnviaAudioClick(Sender: TObject);
begin

  AbrirArquivo.Filter := VRes_Filtro_Audio;
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendAudio(StrToInt(txtID.Text), MyFile,VRes_Texto_Audio, LParseMode, 0,'Titulo Sobreescrito',False, 0, False, LMarkup);
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
begin

  AbrirArquivo.Filter := VRes_Filtro_Fotos;
  if AbrirArquivo.Execute then
      ImgLoad.Picture.LoadFromFile(AbrirArquivo.FileName);

  MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendPhoto(StrToInt(txtID.Text), MyFile,VRes_Texto_Foto, LParseMode, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Imagem);
      end;
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
    MyAction := TtgSendChatAction.Record_audio;
    MyAction := TtgSendChatAction.Upload_document;
  entre outros
  }

  //Neste caso irei enviar a ação Escrevendo...  (Typing)
  MyAction := TtgSendChatAction.Typing;

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));
      InjectTelegram1.SendChatAction(MyChatId, MyAction);
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
 MyThumb : TtgFileToSend;
begin

  AbrirArquivo.Filter := VRes_Filtro_Video;
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile, AbrirArquivo.FileName);

  AbrirArquivo.Filter := VRes_Filtro_Fotos;
  if AbrirArquivo.Execute then
    MyThumb := TtgFileToSend.Create(TtgFileToSendTag.FromFile, AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendAnimation(StrToInt(txtID.Text), MyFile,30,0,0,MyThumb,
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
  MyContact := TtgContact.Create('5521997196000','Ruan Diego','Lacerda Menezes');

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendContact(StrToInt(txtID.Text), MyContact, False, 0, False, LMarkup);
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

  AbrirArquivo.Filter := VRes_Filtro_Todos;
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try                                                        //Thumb
      InjectTelegram1.SendDocument(StrToInt(txtID.Text), MyFile, MyFile , VRes_Texto_Documento, LParseMode, Nil, False, False, 0, False, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add(VRes_Falha+VRes_Documento);
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

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));
      if Assigned(MyMedia) then
        try
          InjectTelegram1.sendMediaGroup(MyChatId.ID, MyMedia, False, 0, False);
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
  MyInvoice : TtgInvoice;
begin

  FotoUrl := 'https://user-images.githubusercontent.com/11804577/79389701-fd284580-7f44-11ea-8238-bab525a19caa.png';

  pvToken := txtTokenBanco.Text;//'SEU TOKEN_PROVIDER GERADO NO BOTFATHER PARA PAGAMENTOS';
  BrandName := 'Visa';
  pgMetod := 'pm_card_visa';
                                                                                      //R$10,00
 // MyInvoice := TtgInvoice.Create('Teste Titulo','Descrição', 'www.lmcode.com.br','USD',1000);

  if txtTokenBanco.Text = '' then
  Begin
    Showmessage(VRes_Ajuda_Token_Banco);
    Exit;
  End;

  SetLength(MyPrices, 2);
  MyPrices[0] :=  TtgLabeledPrice.Create(VRes_ProdutoA, 1000);
  MyPrices[1] :=  TtgLabeledPrice.Create(VRes_ProdutoB, 300);


  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));
                                 //ID          //TITULO   //DESC               //PLayload      //Token  //Param //Curr  //Prices //ProvData    //Foto
      InjectTelegram1.SendInvoice(MyChatId.ID,
          VRes_Titulo_PG,
          VRes_Descricao_PG,
          VRes_PlayLoad_PG,
          pvToken, pgMetod ,'USD', MyPrices, '' , FotoUrl, 300, 100, 100,
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
  MyChatId: TtgUserLink; //Uses TelegAPI.Bot
begin
  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      {É Necessário criar um game no BotFather para obter o
      nome do game que sera enviado }
      if txtNomeJogo.Text <> '' then
      Begin
        MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));
        InjectTelegram1.SendGame(MyChatId.ID, txtNomeJogo.Text);
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
  sJson : String;
begin
  lt := -22.8272758;
  lg := -43.0292233;

  MyLocation := TtgLocation.Create(lt,lg);
  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendLocation(StrToInt(txtID.Text), MyLocation, False, 0, False, LMarkup);
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
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendVideoNote(StrToInt(txtID.Text), MyFile, 0, 0, False, 0, False, LMarkup);
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
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendPoll(MyChatId,
              VRes_Quem_Desc_Brasil, MyStrArray, False,
              TtgQuizType.qtQuiz, False, 3, VRes_Ta_Doidao,
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
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendSticker(StrToInt(txtID.Text), MyFile, False, 0, LMarkup);
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
 // MyLocation := TtgLocation.Create(lt,lg);
 // MyVenue := TtgVenue.Create(MyLocation, VRes_Ex_Endereco_Digitado, VRes_Ex_Titulo,'',VRes_Ex_Tipo);

 //Desta Forma o MyLocation não precisa ser instanciado pois os parametros de coordenado sãopassados diretamente aqui
 MyVenue := TtgVenue.Create(lt,lg, VRes_Ex_Endereco_Digitado, VRes_Ex_Titulo,'',VRes_Ex_Tipo);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      //A Função SendVenue depende do Mylocation
      //InjectTelegram1.SendVenue(StrToInt(txtID.Text), MyVenue, MyLocation, False, 0, LMarkup);

      //A Função SendVenue2 NÃO depende do Mylocation
      InjectTelegram1.SendVenue2(StrToInt(txtID.Text), MyVenue, False, 0, False, LMarkup);
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
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendVideo(StrToInt(txtID.Text), MyFile,VRes_TExto_Video, LParseMode, True, 0, 0, 0, False, 0, False, LMarkup);
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
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendVoice(StrToInt(txtID.Text), MyFile,VRes_Texto_Voz, LParseMode, 0, False, 0, False, LMarkup);
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

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      MyChatId := TtgUserLink.FromID(StrToInt(txtID.Text));
      InjectTelegram1.SendMessage(MyChatId.ID, VRes_Este_Seu_ID + MyChatId.ID.ToString, LParseMode, False, False, 0, False, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add(VRes_Falha_Envio_Destinatario + E.Message);
    end;
  End
  else
    Showmessage(VRes_Ative_Servico);

end;

procedure TForm1.btnSolicitarCttClick(Sender: TObject);
begin
LMarkup := TtgReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtgKeyboardButton.Create(VRes_Enviar_Contato, True, FALSE)]], TRUE);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(StrToint(txtID.Text),
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
LMarkup := TtgReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtgKeyboardButton.Create(VRes_Enviar_Localizacao, False, TRUE)]], TRUE);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      memConsole.Lines.Add(VRes_Solicitacao_Env_Mas_Incomp_Teleg_Descktop);
      InjectTelegram1.SendMessage(StrToint(txtID.Text),
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
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etDado ,False, 0, False, LMarkup);
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
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etDardo ,False, 0, False, LMarkup);
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
LMarkup := TtgReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtgKeyboardButton.Create('texto1', FALSE, FALSE),
  TtgKeyboardButton.Create('texto2', FALSE, FALSE)],
  { Segunda Linha }
  [TtgKeyboardButton.Create(VRes_Qual_Meu_ID, FALSE, FALSE)]], TRUE);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(StrToint(txtID.Text),
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
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etBasquete ,False, 0, False, LMarkup);
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
    InjectTelegram1.Token := txtToken.Text;
    InjectTelegramReceiverService1.Start;
  End;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  InjectTelegramReceiverService1.Stop;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etFootball ,False, 0, False, LMarkup);
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
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etSlotMachine ,False, 0, False, LMarkup);
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
LMarkup := TtgInlineKeyboardMarkup.Create([
  { Primeira Linha }
  [TtgInlineKeyboardButton.Create('Texto1Embutido','texto1retornoembutido'),
  TtgInlineKeyboardButton.Create('Texto2Embutido','texto2retornoembutido')],
  { Segunda Linha }
  [TtgInlineKeyboardButton.Create('Texto3Embutido','texto3retornoembutido')]]);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(StrToint(txtID.Text),VRes_MSG_Exemplo_Envio_BT, LParseMode, False, False, 0, False, LMarkup)
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
  if InjectTelegramReceiverService1.IsActive then
    InjectTelegramReceiverService1.Stop;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  {Envie Markdown ou HTML, se você deseja que os aplicativos Telegram
  mostrem texto em negrito, itálico, largura fixa ou URLs embutidos na
  mensagem do seu bot.}
  LParseMode := TtgParseMode.Markdown; //Necessario declarar TelegAPI.Types.Enums
  FileCount := 0;
  AbrirArquivo.InitialDir := '../../'+ExtractFilePath(Application.ExeName)+'\midias';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  AplicarResource;
end;

procedure TForm1.InjectTelegramExceptionManagerUI1Log(ASender: TObject;
  const Level: TLogLevel; const Msg: string; E: Exception);
begin
  //Aqui você tem um modo de tratar as mensagens e os erros por meio de log
  if level >= TLogLevel.Error then
  begin
    if Assigned(e) then
     memConsole.Lines.Add('[' + e.ToString + '] ' + msg)
    else
     memConsole.Lines.Add(msg);
  end;
end;

procedure TForm1.InjectTelegramReceiverService1CallbackQuery(ASender: TObject;
  ACallbackQuery: ItgCallbackQuery);
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

procedure TForm1.InjectTelegramReceiverService1ChosenInlineResult(
  ASender: TObject; AChosenInlineResult: ItgChosenInlineResult);
begin
  if AChosenInlineResult.Query.ToLower.Equals('texto3retornoembutido') then
    memConsole.Lines.Add(VRes_O_Usuario+
      AChosenInlineResult.From.FirstName+VRes_Solicitou+
      AChosenInlineResult.Query);
end;

procedure TForm1.InjectTelegramReceiverService1Message(ASender: TObject;
  AMessage: ITgMessage);
begin

  if AMessage.&Type = TtgMessageType.ContactMessage then
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+VRes_Compartilhou_CTT+
      VRes_Telefone +AMessage.Contact.PhoneNumber+
      ' ID : '+AMessage.Contact.UserId.ToString);

  if AMessage.&Type = TtgMessageType.LocationMessage then
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+VRes_Compartilhou_Localizacao+
      'Latitude : '+AMessage.Location.Latitude.ToString+
      ' Longitude : '+AMessage.Location.Longitude.ToString);

  if AMessage.Text.ToLower.Equals('texto2') then
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+VRes_Solicitou+
      AMessage.Text);

  if AMessage.Text.ToLower.Equals('meuid') then
  Begin
    memConsole.Lines.Add(VRes_O_Usuario+
      AMessage.From.FirstName+' ID : '+AMessage.From.ID.ToString+VRes_Solicitou+
      '' + AMessage.Text);
  End;
end;

procedure TForm1.InjectTelegramReceiverService1Start(Sender: TObject);
begin
  memConsole.Lines.Add(VRes_Servico_Ativo);
end;

procedure TForm1.InjectTelegramReceiverService1Stop(Sender: TObject);
begin
  memConsole.Lines.Add(VRes_Servico_Desativado);
end;

end.

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
  TelegAPI.Bot.Impl, Vcl.Imaging.pngimage;

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
    Button1: TButton;
    Button4: TButton;
    btnApagarBotoes: TButton;
    btnEnviarAnimacao: TButton;
    btnEnviarDardo: TButton;
    txtNomeJogo: TEdit;
    Label4: TLabel;
    btnSolicitarCtt: TButton;
    btnSolicitarLocalizacao: TButton;
    btnComoSaberID: TButton;
    btnADD: TButton;
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
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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

  private
    { Private declarations }
  public

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
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnADDClick(Sender: TObject);
var
  I : Integer;
  F: Integer;
begin
  if FileCount > 10 then
    FileCount := 0;

  FileCount := FileCount + 1;

  AbrirArquivo.Filter := 'Fotos e Videos|*.jpeg;*.jpg;*.gif;*.png;*.bmp;*.mp4;*.wmv;*.vid;*.flv;*.m4v;*.f4v;*.lrv';

  if FileCount <= 10 then // Limite de arquivos da API
  Begin
    SetLength(MyFiles, FileCount);

    if AbrirArquivo.Execute then
      MyFiles[FileCount - 1] := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

    SetLength(MyMedia, Length(MyFiles));

    if ExtractFileExt(AbrirArquivo.FileName) = '.png' then
      MyMedia[FileCount - 1] := TtgInputMediaPhoto.Create(MyFiles[FileCount - 1], 'Meu teste de Midia Group');
    if ExtractFileExt(AbrirArquivo.FileName) = '.mp4' then
      MyMedia[FileCount - 1] := TtgInputMediaVideo.Create(MyFiles[FileCount - 1], 'Meu teste de Midia Group');
  End
  Else
    Showmessage('Você já atingiu o limite de 10 arquivos para envio agrupado!');

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
      InjectTelegram1.SendMessage(StrToint(txtID.Text),'Esta é uma mensagem de exemplo, onde os botões foram removidos...', LParseMode, False, False, 0, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add('Falha no Envio para este destinatáio  - ' + E.Message);
    end;
  End
  else
    Showmessage('Ative o Serviço primeiro!');
end;

procedure TForm1.btnComoSaberIDClick(Sender: TObject);
begin

  Showmessage('Use seu celular para enviar o comando meuid para o seu bot e ele retornara seu ID no LOG do Exemplo...');

end;

procedure TForm1.btnEnviaAudioClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Audio|*.mp3;*.wav;*.ogg';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendAudio(StrToInt(txtID.Text), MyFile,'Texto do Audio', LParseMode, 0,'Titulo Sobreescrito',False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro audio.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviaFotoClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Fotos|*.jpeg;*.jpg;*.gif;*.png;*.bmp';
  if AbrirArquivo.Execute then
      ImgLoad.Picture.LoadFromFile(AbrirArquivo.FileName);

  MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendPhoto(StrToInt(txtID.Text), MyFile,'Texto da Foto', LParseMode, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra imagem.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
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
        memConsole.Lines.Add('**** Falha ***** Tente outra Ação.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');

end;

procedure TForm1.btnEnviarAnimacaoClick(Sender: TObject);
var
 MyThumb : TtgFileToSend;
begin

  AbrirArquivo.Filter := 'Videos|*.mp4;*.wmv;*.vid;*.flv;*.m4v;*.f4v;*.lrv;*.tgs|Todos|*.*';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile, AbrirArquivo.FileName);

  AbrirArquivo.Filter := 'Fotos|*.jpeg;*.jpg;*.gif;*.png;*.bmp|Todos|*.*';
  if AbrirArquivo.Execute then
    MyThumb := TtgFileToSend.Create(TtgFileToSendTag.FromFile, AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendAnimation(StrToInt(txtID.Text), MyFile,30,0,0,MyThumb,'Texo da Animção', LParseMode, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra Animação.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');

end;

procedure TForm1.btnEnviarContatoClick(Sender: TObject);
begin
  MyContact := TtgContact.Create('5521997196000','Ruan Diego','Lacerda Menezes');

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendContact(StrToInt(txtID.Text), MyContact, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Contato.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarDocumentoClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Todos os Arquivos|*.*';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDocument(StrToInt(txtID.Text), MyFile,'Texo do Documento', LParseMode, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Documento.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
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
          InjectTelegram1.sendMediaGroup(MyChatId.ID, MyMedia, False, 0);
        except on e:exception do
          begin
            memConsole.Lines.Add('**** Falha ***** Tente outra Coletania de Midias.');
          end;
        end;
    finally
      MyFile.Free;
      for I := 0 to Length(MyMedia) -1 do
        MyMedia[I].Free;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarInvoiceClick(Sender: TObject);
var
  AText, sJson, FotoUrl : String;
  Ctt : Int64;
  pvToken, BrandName, pgMetod: String;
  MyInvoice : TtgInvoice;
begin

  FotoUrl := 'https://user-images.githubusercontent.com/11804577/79389701-fd284580-7f44-11ea-8238-bab525a19caa.png';

  pvToken := '';  //'SEU TOKEN_PROVIDER GERADO NO BOTFATHER PARA PAGAMENTOS';
  BrandName := 'Visa';
  pgMetod := 'pm_card_visa';
                                                                                      //R$10,00
 // MyInvoice := TtgInvoice.Create('Teste Titulo','Descrição', 'www.lmcode.com.br','USD',1000);

  if pvToken = '' then
    Showmessage('Gere seu Provider_Token no BotFather, use o comando /mybots, clique no seu bot e depois clique em Payments'+#10#13+
    'Eu recomendo obanco TRANZZO para testes, depois disso clique em Connect Tranzzo Test. Depois retorne ao BotFather e copie'+#10#13+
    ' o Token que aparece na parte superior da lista de bancos');

  SetLength(MyPrices, 2);
  MyPrices[0] :=  TtgLabeledPrice.Create('Goiaba', 1000);
  MyPrices[1] :=  TtgLabeledPrice.Create('Abacaxi', 300);


  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));
                                 //ID          //TITULO   //DESC               //PLayload      //Token  //Param //Curr  //Prices //ProvData    //Foto
      InjectTelegram1.SendInvoice(MyChatId.ID, 'Titulo', 'Teste de Descrição','LMCODE-Delivery',pvToken, pgMetod ,'USD', MyPrices, '' , FotoUrl, 300, 100, 100, FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,0,nil);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Pagamento.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');

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
        memConsole.Lines.Add('Informe o nome de um jogo Valido primeiro!');
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Jogo.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');

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
      InjectTelegram1.SendLocation(StrToInt(txtID.Text), MyLocation, 0, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra Localização.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarNotaDeVideoClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Videos|*.mp4;*.wmv;*.vid;*.mpeg';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendVideoNote(StrToInt(txtID.Text), MyFile, 0, 0, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra Nota de Vídeo.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
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
              'Quem Descobriu o Brasil?', MyStrArray, False,
              TtgQuizType.qtQuiz, False, 3,'Ta doidão, essa tavafacil, mané',
              LParseMode, 30, 5, False, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra Enquete ou Quiz.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarStikerClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Stiker|*.jpeg;*.jpg;*.gif;*.png;*.bmp;*.tgs';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendSticker(StrToInt(txtID.Text), MyFile, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Stiker.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarVenueClick(Sender: TObject);
var
  lt, lg: Single;
begin
  lt := -22.8272758;
  lg := -43.0292233;

///Desta Forma é necessário instanciar o MyLocation e passa-lo como paramentro ao instanciar o MyVenue
 // MyLocation := TtgLocation.Create(lt,lg);
 // MyVenue := TtgVenue.Create(MyLocation, 'Exemplo de Endereço digitado...', 'Exemplo de Titulo','','teste de tipo');

 //Desta Forma o MyLocation não precisa ser instanciado pois os parametros de coordenado sãopassados diretamente aqui
 MyVenue := TtgVenue.Create(lt,lg, 'Exemplo de Endereço digitado...', 'Exemplo de Titulo','','teste de tipo');

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      //A Função SendVenue depende do Mylocation
      //InjectTelegram1.SendVenue(StrToInt(txtID.Text), MyVenue, MyLocation, False, 0, LMarkup);

      //A Função SendVenue2 NÃO depende do Mylocation
      InjectTelegram1.SendVenue2(StrToInt(txtID.Text), MyVenue, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra Localização.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarVideoClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Videos|*.mp4;*.wmv;*.vid;*.flv;*.m4v;*.f4v;*.lrv';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendVideo(StrToInt(txtID.Text), MyFile,'Texo do Vídeo', LParseMode, True, 0, 0, 0, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Vídeo.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarVozClick(Sender: TObject);
begin

  AbrirArquivo.Filter := 'Arquivo de Voz|*.mp3;*.wav;*.ogg';
  if AbrirArquivo.Execute then
    MyFile := TtgFileToSend.Create(TtgFileToSendTag.FromFile,AbrirArquivo.FileName);

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendVoice(StrToInt(txtID.Text), MyFile,'Texo da Voz', LParseMode, 0, False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outra Gravação de Voz.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviaTextoClick(Sender: TObject);
begin

  MyChatId  := TtgUserLink.FromUserName(txtID.Text);

  Showmessage(InjectTelegram1.GetMe.ID.ToString);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(MyChatId.ID,'Este é o Seu ID : '+MyChatId.ID.ToString, LParseMode, False, False, 0, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add('Falha no Envio para este destinatáio  - ' + E.Message);
    end;
  End
  else
    Showmessage('Ative o Serviço primeiro!');

end;

procedure TForm1.btnSolicitarCttClick(Sender: TObject);
begin
LMarkup := TtgReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtgKeyboardButton.Create('Enviar Meu Contato', True, FALSE)]], TRUE);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(StrToint(txtID.Text),
        'Olá Caro Usuario, você pode me fornecer seu contato para continuar com o atendimento?',
        LParseMode, False, False, 0, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add('Falha no Envio para este destinatáio  - ' + E.Message);
    end;
  End
  else
    Showmessage('Ative o Serviço primeiro!');
end;

procedure TForm1.btnSolicitarLocalizacaoClick(Sender: TObject);
begin
LMarkup := TtgReplyKeyboardMarkup.Create([
  { Primeira Linha }
  [TtgKeyboardButton.Create('Enviar Minha Localização', False, TRUE)]], TRUE);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      memConsole.Lines.Add('Solicitação enviada, mas não é compativel com a versão desktop do Telegram!');
      InjectTelegram1.SendMessage(StrToint(txtID.Text),
        'Olá Caro Usuario, você pode me fornecer sua Localização para prosseguir com o atendimento?',
        LParseMode, False, False, 0, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add('Falha no Envio para este destinatáio  - ' + E.Message);
    end;
  End
  else
    Showmessage('Ative o Serviço primeiro!');
end;

procedure TForm1.btnEnviarDadoClick(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etDado ,False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Dado.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');

end;

procedure TForm1.btnEnviarDardoClick(Sender: TObject);
begin
  //Outra forma de Pegar o link com os dados do usuario e remeter na mensagem
  MyChatId  := TtgUserLink.FromID(StrToInt(txtID.Text));

  if InjectTelegramReceiverService1.IsActive then
  begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendDice(MyChatId, TtgEmojiType.etDardo ,False, 0, LMarkup);
      except on e:exception do
      begin
        memConsole.Lines.Add('**** Falha ***** Tente outro Dado.');
      end;
    end;
  end
  else
    memConsole.Lines.Add('Ative o Serviço primeiro!');
end;

procedure TForm1.Button1Click(Sender: TObject);
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
  [TtgKeyboardButton.Create('Qual é Meu ID?', FALSE, FALSE)]], TRUE);

  if InjectTelegramReceiverService1.IsActive then
  Begin
    if txtID.Text <> '' then
    try
      InjectTelegram1.SendMessage(StrToint(txtID.Text),
        'Esta é uma mensagem de exemplo para teste de envio dos botões',
        LParseMode, False, False, 0, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add('Falha no Envio para este destinatáio  - ' + E.Message);
    end;
  End
  else
    Showmessage('Ative o Serviço primeiro!');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if (txtToken.Text = '') or (length(txtToken.Text) < 20) then
  Begin
    Showmessage('Preencha o campo do Token, antes');
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
      InjectTelegram1.SendMessage(StrToint(txtID.Text),'Esta é uma mensagem de exemplo para teste de envio dos botões', LParseMode, False, False, 0, LMarkup)
    except on E: Exception do
      memConsole.Lines.Add('Falha no Envio para este destinatáio  - ' + E.Message);
    end;
  End
  else
    Showmessage('Ative o Serviço primeiro!');
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
    memConsole.Lines.Add('O Usuario : '+
      ACallbackQuery.From.FirstName+' Solicitou '+
      ACallbackQuery.Data);

  if ACallbackQuery.Data.ToLower.Equals('texto2retornoembutido') then
    memConsole.Lines.Add('O Usuario : '+
      ACallbackQuery.From.FirstName+' Solicitou '+
      ACallbackQuery.Data);

  if ACallbackQuery.Data.ToLower.Equals('texto3retornoembutido') then
    memConsole.Lines.Add('O Usuario : '+
      ACallbackQuery.From.FirstName+' Solicitou '+
      ACallbackQuery.Data);

end;

procedure TForm1.InjectTelegramReceiverService1ChosenInlineResult(
  ASender: TObject; AChosenInlineResult: ItgChosenInlineResult);
begin
  if AChosenInlineResult.Query.ToLower.Equals('texto3retornoembutido') then
    memConsole.Lines.Add('O Usuario : '+
      AChosenInlineResult.From.FirstName+' Solicitou '+
      AChosenInlineResult.Query);
end;

procedure TForm1.InjectTelegramReceiverService1Message(ASender: TObject;
  AMessage: ITgMessage);
begin

  if AMessage.&Type = TtgMessageType.ContactMessage then
    memConsole.Lines.Add('O Usuario : '+
      AMessage.From.FirstName+' Compartilhou seu Contato '+
      'Telefone : '+AMessage.Contact.PhoneNumber+
      ' ID : '+AMessage.Contact.UserId.ToString);

  if AMessage.&Type = TtgMessageType.LocationMessage then
    memConsole.Lines.Add('O Usuario : '+
      AMessage.From.FirstName+' Compartilhou sua Localização '+
      'Latitude : '+AMessage.Location.Latitude.ToString+
      ' Longitude : '+AMessage.Location.Longitude.ToString);

  if AMessage.Text.ToLower.Equals('texto2') then
    memConsole.Lines.Add('O Usuario : '+
      AMessage.From.FirstName+' Solicitou '+
      AMessage.Text);

  if AMessage.Text.ToLower.Equals('meuid') then
  Begin
    memConsole.Lines.Add('O Usuario : '+
      AMessage.From.FirstName+' ID : '+AMessage.From.ID.ToString+' Solicitou '+
      '' + AMessage.Text);
  End;
end;

procedure TForm1.InjectTelegramReceiverService1Start(Sender: TObject);
begin
  memConsole.Lines.Add('Serviço Ativado!');
end;

procedure TForm1.InjectTelegramReceiverService1Stop(Sender: TObject);
begin
  memConsole.Lines.Add('Serviço Desativado!');
end;

end.

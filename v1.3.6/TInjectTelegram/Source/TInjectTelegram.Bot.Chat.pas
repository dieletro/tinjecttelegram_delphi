unit TInjectTelegram.Bot.Chat;

{$I config.inc}

interface

uses
{/$DEFINE  USE_INDY_CORE}
{$IFDEF  USE_INDY_CORE} // Indy Http Core
//  CrossUrl.Indy.HttpClient,
{$ELSE}                 // System.Net HTTP Core
//  CrossUrl.SystemNet.HttpClient,
{$ENDIF}
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
  FireDAC.Comp.Client,
  Dialogs,
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
  TInjectTelegram.Receiver.UI;

type
  TtdEtapasAtendimento = (
    pvListarMenu = 0,
    pvInserirItem = 1,
    pvRemoverItem = 2,
    pvAtualizarLista = 3,
    pvLocalizacao = 4,
    pvFormaPG = 5,
    pvConfirmaRemocao = 6);

  TtdTipoArquivo = (
    taAudio = 14,
    taVideo = 13,
    taVoice = 12,
    taVideoNote = 11,
    taLocation = 10,
    taVenue = 9,
    taContact = 8,
    taChatAction = 7,
    taInvoice = 6,
    taGame = 5,
    taSticker = 4,
    taMediaGroup = 3,
    taTexto = 2,
    taDocumento = 1,
    taImagem = 0);

  TtdEndereco = record
    IdEndereco      : Integer;
    Endereco        : String;
    PontoReferencia : String;
    Latitude        : Single;
    Longetude       : Single;
  end;

  TtdTipoUsuario = (tpCliente, tpAdm);

  TtdSituacaoAtendimento = (saIndefinido,
                      saNova,
                      saEmAtendimento,
                      saEmEspera,
                      saInativa,
                      saFinalizada);

  TInjectTelegramChatBot = class;
  TNotifyTelegramBotConversa = procedure(Conversa: TInjectTelegramChatBot; AMessage: ItdMessage) of object;
  TNotifyOnMessage = procedure(AMessage: ItdMessage) of object;
  TNotifyOnInlineQuery = procedure (AInlineQuery: ItdInlineQuery) of object;
  TNotifyOnChosenInlineResult = procedure (AChosenInlineResult: ItdChosenInlineResult) of object;
  TNotifyOnCallBackQuery = procedure (ACallback: ItdCallbackQuery) of object;
  TNotifyOnStop = procedure of object;
  TNotifyOnStart = procedure of object;
  TNotifyOnLog = procedure (level: TLogLevel; msg: string; e: Exception) of object;

  TOnTimerSleepExecute = procedure (Sender: TObject) of object;

  //TAlvez TInjectTelegramChatBotControl???
  TInjectTelegramChatBot = class(TComponent)
  private
    //Enumerado
    FEtapaAtendimento: TtdEtapasAtendimento;
    FSituacao: TtdSituacaoAtendimento;
    FTipoUsuario: TtdTipoUsuario;

    //Propriedades Telegram
    FEnderecoEntrega: String;
    FLatitude: Single;
    FLongetude: Single;
    FTextoMSG: String;
    FTempoInatividade: Integer;
    FDescricao: String;
    FMaiorValor: Currency;
    FItemsPedido: TStringList;
      FID: String deprecated; //Use o IdChat
    FIdChat: Int64;
    FIdPedido: Integer;
    FIdCliente: Int64;
    FFormaPGT: String;
    FEtapa: Integer;
    FPontoReferencia: String;
    FNome: String;
    FIDInc: integer;
    FTipo: string;
    FTotalPedido: Real;
    FIdIdiomaStr: String;
    FOnTimer: TNotifyEvent;
    FUltimaIteracao: TTime;
    FDistanciaKM: String;
    FDuracaoMIN: String;
    FTaxaEntrega: Real;
    FCep: String;
    FNumero: String;
    FLogradouro: String;
    FBairro: String;
    FUF: String;
    FLocalidade: String;
    FArquivoRecebido: String;

    //Notifys Eventos
    FOnSituacaoAlterada: TNotifyTelegramBotConversa;
    FOnTimerSleepExecute: TOnTimerSleepExecute;
    FOnMessage: TtdOnMessage;
    FNomeArquivoRecebido: String;
  public
    FTimerSleep: TTimer;
    FMessage : ItdMessage;
    function CarregarBotoes(AQuery: TFDQuery; AFieldName: String;
      AInitZero: Boolean = True) : IReplyMarkup;
    function CarregarBTStr(AStrArrayBtName: TArray<TArray<String>>;
      AInlineMode: Boolean = false) : IReplyMarkup;
    procedure SetSituacao(const Value: TtdSituacaoAtendimento);
    procedure SetTempoInatividade(const Value: Integer);
    procedure DoOnTimerSleepExecute(Sender: TObject);
    //Construtores e destruidores
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure ReiniciarTimer;

  published
    //Proprieades
    [Default(0)]
    property  TipoUsuario      : TtdTipoUsuario          read FTipoUsuario       write FTipoUsuario {default tpCliente};
    [Default(0)]
    property  Situacao         : TtdSituacaoAtendimento  read FSituacao          write SetSituacao  {default saIndefinido};
    [Default(0)]
    property  EtapaAtendimento : TtdEtapasAtendimento    read FEtapaAtendimento  write FEtapaAtendimento {default pvListarMenu};
    [Default(0)]
    property  Etapa            : Integer               read FEtapa             write FEtapa {default 0};
    property  Tipo             : string                read FTipo              write FTipo;

    //Use  IdChat - Substituido pelo IdChat
    property  ID               : String                read FID                write FID;

    property  IdIdiomaStr      : String                read FIdIdiomaStr       write FIdIdiomaStr;
    property  IdPedido         : Integer               read FIdPedido          write FIdPedido;
    property  IdCliente        : Int64                 read FIdCliente         write FIdCliente;
    property  IdChat           : Int64                 read FIdChat            write FIdChat;
    property  IDInc            : Integer               read FIDInc             write FIDInc;
    property  TextoMSG         : String                read FTextoMSG          write FTextoMSG;
    property  Nome             : String                read FNome              write FNome;
    property  ItemsPedido      : TStringList           read FItemsPedido       write FItemsPedido;
    property  MaiorValor       : Currency              read FMaiorValor        write FMaiorValor;
    property  EnderecoEntrega  : String                read FEnderecoEntrega   write FEnderecoEntrega;

    property  Numero           : String                read FNumero            write FNumero;
    property  Cep              : String                read FCep               write FCep;
    property  Logradouro       : String                read FLogradouro        write FLogradouro;
    property  Bairro           : String                read FBairro            write FBairro;
    property  Localidade       : String                read FLocalidade        write FLocalidade;
    property  UF               : String                read FUF                write FUF;

    property  PontoReferencia  : String                read FPontoReferencia   write FPontoReferencia;
    property  DistanciaKM      : String                read FDistanciaKM       write FDistanciaKM;
    property  DuracaoMIN       : String                read FDuracaoMIN        write FDuracaoMIN;
    property  TaxaEntrega      : Real                  read FTaxaEntrega       write FTaxaEntrega;

    property  Latitude         : Single                read FLatitude          write FLatitude;
    property  Longitude        : Single                read FLongetude         write FLongetude;

    property  FormaPGT         : String                read FFormaPGT          write FFormaPGT;
    property  TotalPedido      : Real                  read FTotalPedido       write FTotalPedido;
    property  Descricao        : String                read FDescricao         write FDescricao;

    [Default('')]
    property  ArquivoRecebido   : String               read FArquivoRecebido   write FArquivoRecebido;

    property  SleepTimer       : TTimer                read FTimerSleep        write FTimerSleep;
    property  UltimaIteracao   : TTime                 read FUltimaIteracao    write FUltimaIteracao;
    property  TempoInatividade : Integer               read FTempoInatividade  write SetTempoInatividade;

    //Eventos
    property OnSituacaoAlterada: TNotifyTelegramBotConversa read FOnSituacaoAlterada write FOnSituacaoAlterada;
    property OnTimerSleepExecute: TOnTimerSleepExecute read FOnTimerSleepExecute write FOnTimerSleepExecute;
end;

implementation

{ TInjectTelegramChatBot }

procedure TInjectTelegramChatBot.Clear;
begin
 // Situacao := saIndefinido;
  FLatitude := 0.0;
  FLongetude := 0.0;
  FMaiorValor := 0;
  if Assigned(FItemsPedido) then
    FItemsPedido.Clear;
 // FIdPedido := 0;  //Não posso zerar essa propriedade
  FFormaPGT := '';
  //FIdCliente := 0; //Não posso zerar essa propriedade
  FPontoReferencia := '';
  FEnderecoEntrega := '';
  FCep := '';
  FNumero := '';
  FLogradouro := '';
  FBairro := '';
  FUF := '';
  FLocalidade := '';
  FDescricao := '';
  //FTempoInatividade := 0; //Não posso zerar essa propriedade
  FNome := '';
  FIDInc := 0;
  FID := ''; //deprecated
  FTipo := '';
  FEtapa := 0;
  FTipoUsuario := tpCliente;
  FEtapaAtendimento := pvListarMenu;
end;

function TInjectTelegramChatBot.CarregarBTStr(AStrArrayBtName: TArray<TArray<String>>;AInlineMode: Boolean = false) : IReplyMarkup;
var
  {$REGION 'VARIAVEIS'}
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
  {$ENDREGION 'VARIAVEIS'}
Begin
  {$REGION 'CARREGARBTStr'}
{
Exemplo de uso
Assim ela criara os botoes de acordo com a quantidade de itens do array bidimencional
 CarregarBTStr([['REMOVER','FINALIZAR'],['INICIO','SAIR']]);
}

  SetLength(AStrArrayBtName, Length(AStrArrayBtName[0]) + Length(AStrArrayBtName[1]));


  if Not AInlineMode then  //Reply Mode
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

        Result := TtdReplyKeyboardMarkup.Create(RButton,TRUE);
    End Else
        Result := TtdReplyKeyboardMarkup.Create([LButton],TRUE);
  End
    Else //Inline Mode
  Begin
    SetLength(LButtonIL, Length(AStrArrayBtName[0]));
    SetLength(DButtonIL, Length(AStrArrayBtName[1]));
    SetLength(RButtonIL, Length(LButton) + Length(DButton));

    for I := 0 to Length(AStrArrayBtName[0]) - 1 do
      LButtonIL[I] := TtdInlineKeyboardButton.Create(String(AStrArrayBtName[0,I]),String(AStrArrayBtName[0,I]));

    if Length(AStrArrayBtName[1]) > 0 then
    Begin
      for O := 0 to Length(AStrArrayBtName[1]) - 1 do
        DButtonIL[O] := TtdInlineKeyboardButton.Create(String(AStrArrayBtName[1,O]));

      RButtonIL[LOW(RButtonIL)] := LButtonIL;
      RButtonIL[HIGH(RButtonIL)] := DButtonIL;

      Result := TtdInlineKeyboardMarkup.Create(RButtonIL);
    End
      Else
        Result := TtdInlineKeyboardMarkup.Create([LButtonIL]);
  End;
  {$ENDREGION 'CARREGARBTStr'}
End;

function TInjectTelegramChatBot.CarregarBotoes(AQuery: TFDQuery; AFieldName: String; AInitZero: Boolean = True) : IReplyMarkup;
var
  {$REGION 'VARIAVEIS'}
  I: Integer;
  strTexto : String;
  INLButton: TArray<TtdInlineKeyboardButton>;  //Botoes Inline na mensagem
  LButton : TArray<TtdKeyboardButton>;
  RButton : TArray<TArray<TtdKeyboardButton>>;
  {$ENDREGION 'VARIAVEIS'}
Begin
  {$REGION 'CARREGARBOTOES'}
  if Assigned(AQuery) then
  Begin
    if AFieldName <> '' then
    Begin

      try
        try
          if AInitZero = True then
          Begin
            SetLength(LButton, AQuery.RecordCount + 1);
            SetLength(RButton, Length(LButton) + 1);

           // SetLength(INLbutton, AQuery.RecordCount + 1);

            AQuery.First;
            for I := 0 to AQuery.RecordCount do
            Begin
              strTexto := AQuery.FieldByName(AFieldName).AsString;
              if I = 0 then
              Begin
                LButton[I] := TtdKeyboardButton.Create('0');
                LButton[I+1] := TtdKeyboardButton.Create(strTexto);

               // INLbutton[I] := TtdInlineKeyboardButton.Create('0', '0');
               // INLbutton[I+1] := TtdInlineKeyboardButton.Create(strTexto, strTexto);
              End
                else
              Begin
                LButton[I+1] := TtdKeyboardButton.Create(strTexto);
               // INLbutton[I+1] := TtdInlineKeyboardButton.Create(strTexto, strTexto);
              End;
              AQuery.Next;

            End;
          End
            Else
          Begin
            SetLength(LButton, AQuery.RecordCount);
            SetLength(RButton, Length(LButton) + 1);

           // SetLength(INLbutton, AQuery.RecordCount);

            AQuery.First;
            for I := 0 to AQuery.RecordCount - 1 do
            Begin
              strTexto := AQuery.FieldByName(AFieldName).AsString;
              LButton[I] := TtdKeyboardButton.Create(strTexto);
              //INLbutton[I] := TtdInlineKeyboardButton.Create(strTexto, strTexto);
              AQuery.Next;
            End;
          End;
        except on E: Exception do
           E.Message := 'Erro ao Ler a tabela'+ E.Message;
        end;

      finally
        RButton[LOW(RButton)] := LButton;
        RButton[HIGH(RButton)] := [TtdKeyboardButton.Create('Inicio')];

        Result := TtdReplyKeyboardMarkup.Create(RButton, TRUE);
      end;
    End;
  End;
  {$ENDREGION 'CARREGARBOTOES'}
End;

constructor TInjectTelegramChatBot.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FIdIdiomaStr := 'pt-br';

  //Prepara Timer
  FTimerSleep := TTimer.Create(Self);
  FTimerSleep.Enabled  := False;
  FTimerSleep.Interval := FTempoInatividade*60000; //*60.000 = 1 min
  FTimerSleep.OnTimer  := DoOnTimerSleepExecute;
//  FTimerSleep.Enabled  := True;

end;

destructor TInjectTelegramChatBot.Destroy;
begin
  FTimerSleep.Free;
  inherited Destroy;
end;

procedure TInjectTelegramChatBot.ReiniciarTimer;
begin
  //Se estiver em atendimento reinicia o timer de inatividade
  if FSituacao in [saNova, saEmAtendimento] then
  begin
    FTimerSleep.Enabled := False;
    FTimerSleep.Enabled := True;
    FUltimaIteracao := StrToTime(FormatDateTime('hh:mm:ss',Now));
  end;
end;

procedure TInjectTelegramChatBot.SetSituacao(const Value: TtdSituacaoAtendimento);
begin
  //DoChange
    if FSituacao <> Value then
    begin
      FSituacao := Value;
      FTimerSleep.Enabled := FSituacao in [saNova, saEmAtendimento];//((FSituacao = saNova) or (FSituacao = saEmAtendimento));  //Habilita Time se situacao ativa.

  //    if Value = saInativa then
  //      DoOnTimerSleepExecute(Self);

      if Assigned( OnSituacaoAlterada ) then
         OnSituacaoAlterada(Self, FMessage);
    end;
end;

procedure TInjectTelegramChatBot.SetTempoInatividade(const Value: Integer);
begin
  FTempoInatividade := Value;
  FTimerSleep.Interval := FTempoInatividade;
end;

procedure TInjectTelegramChatBot.DoOnTimerSleepExecute(Sender: TObject);
begin
  FSituacao := saInativa;
  //Showmessage('Achei!');
  FTimerSleep.Enabled := False;

  if Assigned(OnTimerSleepExecute) then
    OnTimerSleepExecute(Sender);

end;

end.

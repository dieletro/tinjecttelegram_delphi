unit TinjectTelegram.Receiver.Base;
interface
uses
  System.Classes,
  System.SysUtils,
  TInjectTelegram.UpdateParser,
  TInjectTelegram.Bot,
  TInjectTelegram.Bot.Impl,
  TInjectTelegram.Types,
  TInjectTelegram.Types.Enums;
type
  {TInjectTelegramBotReceiverBase}
  TInjectTelegramBotReceiverBase = class(TInjectTelegramBotUpdateParser)
  private
    FBotDonor: TInjectTelegramBot;
    FAllowedUpdates: TAllowedUpdates;
    FMessageOffset: Int64;
    FPollingInterval: Integer;
    FThread: TThread;
    FIsActive: Boolean;
    procedure SetIsActive(const AValue: Boolean);
  protected
    function ReadUpdates: TArray<ItdUpdate>; virtual;
    procedure Go; virtual;
    procedure DoOnStart; virtual; abstract;
    procedure DoOnStop; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(ABot: IInjectTelegramBot); reintroduce; overload;
    destructor Destroy; override;
    procedure Start;
    procedure Stop;
    [Default(False)]
    property IsActive: Boolean read FIsActive write SetIsActive;
  published
    property Bot: TInjectTelegramBot read FBotDonor write FBotDonor;
    [Default(0)]
    property MessageOffset: Int64 read FMessageOffset write FMessageOffset;
    property AllowedUpdates: TAllowedUpdates read FAllowedUpdates write
      FAllowedUpdates default UPDATES_ALLOWED_ALL;
    [Default(1000)]
    property PollingInterval: Integer read FPollingInterval write FPollingInterval;
  end;
implementation
uses TinjectTelegram.Logger;
{ TInjectTelegramBotReceiverBase }
constructor TInjectTelegramBotReceiverBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  MessageOffset := 0;
  AllowedUpdates := UPDATES_ALLOWED_ALL;
  PollingInterval := 1000;
end;
constructor TInjectTelegramBotReceiverBase.Create(ABot: IInjectTelegramBot);
begin
  Self.Create(nil);
  FBotDonor := ABot as TInjectTelegramBot;
end;
destructor TInjectTelegramBotReceiverBase.Destroy;
begin
 // FBotDonor.Free;
  Stop;
  inherited;
end;
procedure TInjectTelegramBotReceiverBase.Go;
var
  LUpdates: TArray<ItdUpdate>;
begin
  DoOnStart;
  while FIsActive do
  begin
    try
      Self.Bot.Logger.Enter(Self, 'Go');
      LUpdates := ReadUpdates;
      if Length(LUpdates) = 0 then
      begin
        Sleep(FPollingInterval);
        Continue;
      end;
      MessageOffset := LUpdates[High(LUpdates)].ID + 1;
      EventParser(LUpdates);
      Sleep(FPollingInterval);
      Self.Bot.Logger.Leave(Self, 'Go');
    except on E: Exception do
      Begin
         Bot.Logger.Fatal('Go', E);
         //Independente do tipo de erro que o bot encontre,
         //ele nunca para de responder a novas solicitações
         continue;
      End;
    end;
  end;
  DoOnStop;
end;
function TInjectTelegramBotReceiverBase.ReadUpdates: TArray<ItdUpdate>;
var
  LBot: TInjectTelegramBot;
begin
  LBot := TInjectTelegramBot.Create(Self);
  try
    Bot.Logger.Enter(Self, 'ReadUpdates');
    FBotDonor.AssignTo(LBot);
    Result := LBot.GetUpdates(MessageOffset, 100, 0, AllowedUpdates);
    Bot.Logger.Leave(Self, 'ReadUpdates');
  except
    on E: Exception do
      Bot.Logger.Fatal('TInjectTelegramBotReceiverBase.ReadUpdates', E)
  end;
end;
procedure TInjectTelegramBotReceiverBase.SetIsActive(const AValue: Boolean);
begin
  if FIsActive = AValue then
    Exit;
  FIsActive := AValue;
  if AValue then
  begin
    FThread := TThread.CreateAnonymousThread(Go);
    FThread.FreeOnTerminate := False;
    FThread.Start;
  end
  else
    FreeAndNil(FThread);
end;
procedure TInjectTelegramBotReceiverBase.Start;
begin
  IsActive := True;
end;
procedure TInjectTelegramBotReceiverBase.Stop;
begin
  IsActive := False;
end;
end.

unit TelegAPI.Logger.Old;

interface

uses
  TelegAPI.Logger,
  System.SysUtils;

type
  {TInjectTelegramExceptionManagerConsole}
  TInjectTelegramExceptionManagerConsole = class(TLogEmpty)
  private
    FOnLog: TProc<TLogLevel, string, Exception>;
  public
    procedure Log(level: TLogLevel; const msg: string; const e: Exception); override;
    property OnLog: TProc<TLogLevel, string, Exception> read FOnLog write FOnLog;
  end;

  TtgOnLog = procedure(ASender: TObject; const Level: TLogLevel; const Msg:
    string; E: Exception) of object;

  {TInjectTelegramExceptionManagerUI}
  TInjectTelegramExceptionManagerUI = class(TLogEmpty)
  private
    FOnLog: TtgOnLog;
  public
    procedure Log(level: TLogLevel; const msg: string; const e: Exception); override;
  published
    property OnLog: TtgOnLog read FOnLog write FOnLog;
  end;

implementation

{ TInjectTelegramExceptionManagerConsole }

procedure TInjectTelegramExceptionManagerConsole.Log(level: TLogLevel; const msg: string;
  const e: Exception);
begin
  inherited;
  if Assigned(OnLog) then
    OnLog(level, msg, e)
  else if level >= TLogLevel.Error then
    raise e;
end;

{ TInjectTelegramExceptionManagerUI }

procedure TInjectTelegramExceptionManagerUI.Log(level: TLogLevel; const msg: string; const e:
  Exception);
begin
  inherited;
  if Assigned(OnLog) then
    OnLog(Self, level, msg, e)
  else if level >= TLogLevel.Error then
    raise e;
end;

end.


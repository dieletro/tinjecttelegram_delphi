unit TinjectTelegram.RegisterIDE;

interface

procedure Register;

implementation

{ /$DEFINE REG_IN_LOAD }

uses
{$IFDEF REG_IN_LOAD}
  VCL.Graphics,
  ToolsAPI,
{$ENDIF}
  System.Classes,
  {Add new components here}
  TInjectTelegram.Receiver.UI,
  TInjectTelegram.Logger.Old,
  TInjectTelegram.Bot.Impl,
  TInjectTelegram.Receiver.Service,
  TInjectTelegram.Types.Enums,
  TInjectTelegram.Ph;

{$IFDEF REG_IN_LOAD}
{$ENDIF}

procedure Register;
begin
{$IFDEF REG_IN_LOAD}
  RegisterWithSplashScreen;
{$ENDIF}
  RegisterComponents('InjectTelegram', [
    TInjectTelegramBot,
    TInjectTelegramPh,
    TInjectTelegramExceptionManagerUI,
    TInjectTelegramReceiverService,
    TInjectTelegramReceiverUI]);
end;

end.


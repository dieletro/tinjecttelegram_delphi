unit TelegAPI.RegisterIDE;

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
  TelegAPi.Receiver.UI,
  TelegAPi.Logger.Old,
  TelegAPi.Bot.Impl,
  TelegAPi.Receiver.Service,
  TelegAPI.Types.Enums,
  TelegraPh;

{$IFDEF REG_IN_LOAD}
{$ENDIF}

procedure Register;
begin
{$IFDEF REG_IN_LOAD}
  RegisterWithSplashScreen;
{$ENDIF}
  RegisterComponents('InjectTelegram', [
    TInjectTelegram,
    TInjectTelegramPh,
    TInjectTelegramExceptionManagerUI,
    TInjectTelegramReceiverService,
    TInjectTelegramReceiverUI]);
end;

end.


unit TinjectTelegram.Receiver.UI;

interface

uses
  TInjectTelegram.Types,
  TInjectTelegram.Receiver.Service;

type
  TInjectTelegramReceiverUI = class(TInjectTelegramReceiverService)
  protected
    procedure EventParser(AUpdates: System.TArray<TInjectTelegram.Types.ItdUpdate>); override;
  end;

implementation

uses
  System.Classes;
{ TInjectTelegramReceiverUI }

procedure TInjectTelegramReceiverUI.EventParser(AUpdates: System.TArray<TInjectTelegram.Types.ItdUpdate>);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      inherited EventParser(AUpdates);
    end);
end;

end.


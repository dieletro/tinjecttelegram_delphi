unit TInjectTelegram.Base;
{$I ..\Source\config.inc}
interface
uses
  System.Classes;
type
  TInjectTelegramAbstractComponent = class(TComponent)
  private
    FAPIVersion: string;
    FComponentVersion: string;
    FAutor: string;
    FDeveloper: string;
    FDateVersionAPI: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Author: string read FAutor;
    property Developer: string read FDeveloper;
    property APIVersion: string read FAPIVersion;
    property DateVersionAPI: string read FDateVersionAPI;
    property ComponentVersion: string read FComponentVersion;
  end;
implementation
{ TInjectTelegramAbstractComponent }
constructor TInjectTelegramAbstractComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutor := 'Maxin Sysoev';
  FDeveloper := 'Ruan Diego Lacerda Menezes';
  FComponentVersion := '1.3.7';
  FAPIVersion := '5.5';
  FDateVersionAPI := '7 de Dezembro de 2021';
end;
destructor TInjectTelegramAbstractComponent.Destroy;
begin
 //
  inherited;
end;

end.

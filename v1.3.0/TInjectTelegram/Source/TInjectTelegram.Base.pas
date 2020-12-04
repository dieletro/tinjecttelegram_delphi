unit TInjectTelegram.Base;

{$I ..\Source\config.inc}

interface

uses
  System.Classes;

type
  TInjectTelegramAbstractComponent = class(TComponent)
  private
    FVersaoAPI: string;
    FVersaoComponent: string;
    FAutor: string;
    FDesenvolvedor: string;
    FDataVersao: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Autor: string read FAutor;
    property Desenvolvedor: string read FDesenvolvedor;
    property VersaoAPI: string read FVersaoAPI;
    property DataVersaoAPI: string read FDataVersao;
    property VersaoComponent: string read FVersaoComponent;
  end;

implementation

{ TInjectTelegramAbstractComponent }

constructor TInjectTelegramAbstractComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutor := 'ITDevCon in an collaborative project';
  FDesenvolvedor := 'Ruan Diego Lacerda Menezes';
  FVersaoComponent := '1.2.0';
  FVersaoAPI := '5.0';
  FDataVersao := '04 de Novembro de 2020';
end;

destructor TInjectTelegramAbstractComponent.Destroy;
begin
 //
  inherited;
end;

end.

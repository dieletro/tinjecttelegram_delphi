unit TelegAPI.Base;

{$I config.inc}

interface

uses
  System.Classes;

type
  TInjectTelegramAbstractComponent = class(TComponent)
  private
    FVersion: string;
    FAutor: string;
    FDesenvolvedor: string;
    FDataVersao: string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Autor: string read FAutor;
    property Desenvolvedor: string read FDesenvolvedor;
    property Version: string read FVersion;
    property DataVersao: string read FDataVersao;
  end;

implementation

{ TInjectTelegramAbstractComponent }

constructor TInjectTelegramAbstractComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutor := 'Maxim Sysoev';
  FDesenvolvedor := 'Ruan Diego Lacerda Menezes';
  FVersion := '4.8';
  FDataVersao := '24 de Abril de 2020';

//  FColaboradores.Add('Renat Suleymanov');
//  FColaboradores.Add('Bonmario');
//  FColaboradores.Add('Alexey Shumkin');
//  FColaboradores.Add('Ilya Bukhonin');
//  FColaboradores.Add('Daniele Spinetti');

end;

destructor TInjectTelegramAbstractComponent.Destroy;
begin
 //
  inherited;
end;

end.

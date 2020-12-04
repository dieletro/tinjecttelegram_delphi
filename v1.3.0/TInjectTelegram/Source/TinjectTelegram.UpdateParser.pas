unit TinjectTelegram.UpdateParser;

interface

uses
  System.Classes,
  System.SysUtils,
  TInjectTelegram.Base,
  TInjectTelegram.Bot,
  TInjectTelegram.Types,
  TInjectTelegram.Types.Enums;

type
  TInjectTelegramBotUpdateParser = class(TInjectTelegramAbstractComponent)
  private
  protected
    procedure EventParser(AUpdates: TArray<ItdUpdate>); virtual;
    procedure TypeUpdate(AUpdate: ItdUpdate); virtual;
    //События
    procedure DoOnUpdates(AUpdates: TArray<ItdUpdate>); virtual; abstract;
    procedure DoOnUpdate(AUpdate: ItdUpdate); virtual; abstract;
    procedure DoOnMessage(AMessage: ItdMessage); virtual; abstract;
    procedure DoOnInlineQuery(AInlineQuery: ItdInlineQuery); virtual; abstract;
    procedure DoOnChosenInlineResult(AChosenInlineResult: ItdChosenInlineResult); virtual; abstract;
    procedure DoOnCallbackQuery(ACallbackQuery: ItdCallbackQuery); virtual; abstract;
    procedure DoOnEditedMessage(AEditedMessage: ItdMessage); virtual; abstract;
    procedure DoOnChannelPost(AChannelPost: ItdMessage); virtual; abstract;
    procedure DoOnEditedChannelPost(AEditedChannelPost: ItdMessage); virtual; abstract;
    procedure DoOnShippingQuery(AShippingQuery: ItdShippingQuery); virtual; abstract;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: ItdPreCheckoutQuery); virtual; abstract;
    procedure DoOnPollStatus(APoll: ItdPoll); virtual; abstract;
    procedure DoOnPollAnswer(APollAnswer: ItdPollAnswer); virtual; abstract;
  public
    procedure ParseResponse(const JSON: string);
  end;

implementation

uses
  TInjectTelegram.Bot.Impl;
{ TInjectTelegramBotUpdateParser }

procedure TInjectTelegramBotUpdateParser.EventParser(AUpdates: TArray<ItdUpdate>);
var
  LUpdate: ItdUpdate;
begin
  DoOnUpdates(AUpdates);
  for LUpdate in AUpdates do
  begin
    DoOnUpdate(LUpdate);
    TypeUpdate(LUpdate);
  end;
end;

procedure TInjectTelegramBotUpdateParser.ParseResponse(const JSON: string);
var
  LUpdates: TArray<ItdUpdate>;
  LBot: IInjectTelegramBot;
begin
  LBot := TInjectTelegramBot.Create(nil);
  LUpdates := LBot.GetUpdates(JSON);
  EventParser(LUpdates);
end;

procedure TInjectTelegramBotUpdateParser.TypeUpdate(AUpdate: ItdUpdate);
begin
  case AUpdate.&Type of
    TtdUpdateType.MessageUpdate:
      DoOnMessage(AUpdate.Message);

    TtdUpdateType.InlineQueryUpdate:
      DoOnInlineQuery(AUpdate.InlineQuery);

    TtdUpdateType.ChosenInlineResultUpdate:
      DoOnChosenInlineResult(AUpdate.ChosenInlineResult);

    TtdUpdateType.CallbackQueryUpdate:
      DoOnCallbackQuery(AUpdate.CallbackQuery);

    TtdUpdateType.EditedMessage:
      DoOnEditedMessage(AUpdate.EditedMessage);

    TtdUpdateType.ChannelPost:
      DoOnChannelPost(AUpdate.ChannelPost);

    TtdUpdateType.EditedChannelPost:
      DoOnEditedChannelPost(AUpdate.EditedChannelPost);

    TtdUpdateType.ShippingQueryUpdate:
      DoOnShippingQuery(AUpdate.ShippingQuery);

    TtdUpdateType.PreCheckoutQueryUpdate:
      DoOnPreCheckoutQuery(AUpdate.PreCheckoutQuery);

    TtdUpdateType.PollState:
      DoOnPollStatus(AUpdate.PollState);

    TtdUpdateType.PollAnswer:
      DoOnPollAnswer(AUpdate.PollAnswer);
  end;
end;

end.


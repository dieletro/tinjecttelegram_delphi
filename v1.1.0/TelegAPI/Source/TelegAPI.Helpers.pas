unit TelegAPI.Helpers;

interface

uses
  TelegAPi.Bot.Impl,
  TelegAPi.Types,
  TelegAPi.Types.Enums;

type
  TTelegramBotHelper = class helper for TInjectTelegram
    function IsValidToken: Boolean;
  end;

  TtgParseModeHelper = record helper for TtgParseMode
    function ToString: string;
  end;

  TAllowedUpdatesHelper = record helper for TAllowedUpdates
    function ToString: string;
  end;

  TSendChatActionHelper = record helper for TtgSendChatAction
    function ToString: string;
  end;

  TPassportDataHelper = record helper for TtgEncryptedPassportElementType
    function ToString: string;
  end;

  TSendDiceHelper = record helper for TtgEmojiType
    function ToString: string;
  End;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  System.RegularExpressions;

{ TtgParseModeHelper }

function TtgParseModeHelper.ToString: string;
begin
  case Self of
    TtgParseMode.Default:
      Result := '';
    TtgParseMode.Markdown:
      Result := 'Markdown';
    TtgParseMode.MarkdownV2:
      Result := 'MarkdownV2';
    TtgParseMode.Html:
      Result := 'HTML';
  end;
end;

{ TAllowedUpdatesHelper }

function TAllowedUpdatesHelper.ToString: string;
var
  LAllowed: TList<string>;
begin
  LAllowed := TList<string>.Create;
  try
    if TAllowedUpdate.Message in Self then
      LAllowed.Add('"message"');
    if TAllowedUpdate.Edited_message in Self then
      LAllowed.Add('"edited_message"');
    if TAllowedUpdate.Channel_post in Self then
      LAllowed.Add('"channel_post"');
    if TAllowedUpdate.Edited_channel_post in Self then
      LAllowed.Add('"edited_channel_post"');
    if TAllowedUpdate.Inline_query in Self then
      LAllowed.Add('"inline_query"');
    if TAllowedUpdate.Chosen_inline_result in Self then
      LAllowed.Add('"chosen_inline_result"');
    if TAllowedUpdate.Callback_query in Self then
      LAllowed.Add('"callback_query"');
    if TAllowedUpdate.ShippingQuery in Self then
      LAllowed.Add('"shipping_query"');
    if TAllowedUpdate.PreCheckoutQuery in Self then
      LAllowed.Add('"pre_checkout_query"');
    if TAllowedUpdate.PollState in Self then
      LAllowed.Add('"poll"');
    if TAllowedUpdate.PollAnswer in Self then
      LAllowed.Add('"poll_answer"');
    Result := '[' + Result.Join(',', LAllowed.ToArray) + ']';
  finally
    LAllowed.Free;
  end;
end;

{ TTelegramBotHelper }

function TTelegramBotHelper.IsValidToken: Boolean;
const
  TOKEN_CORRECT = '\d*:[\w\d-_]{35}';
begin
  Result := TRegEx.IsMatch(Token, TOKEN_CORRECT, [roIgnoreCase]);
end;

{ TSendChatActionHelper }

function TSendChatActionHelper.ToString: string;
begin
  case Self of
    TtgSendChatAction.Typing:
      Result := 'typing';
    TtgSendChatAction.UploadPhoto:
      Result := 'upload_photo';
    TtgSendChatAction.Record_video:
      Result := 'record_video';
    TtgSendChatAction.UploadVideo:
      Result := 'upload_video';
    TtgSendChatAction.Record_audio:
      Result := 'record_audio';
    TtgSendChatAction.Upload_audio:
      Result := 'upload_audio';
    TtgSendChatAction.Upload_document:
      Result := 'upload_document';
    TtgSendChatAction.Find_location:
      Result := 'find_location';
    TtgSendChatAction.Record_video_note:
      Result := 'record_video_note';
    TtgSendChatAction.Upload_video_note:
      Result := 'upload_video_note';
  end;
end;


{ TPassportDataHelper }

function TPassportDataHelper.ToString: string;
begin
    case self of
      TtgEncryptedPassportElementType.personal_details:
                Result := 'personal_details';
      TtgEncryptedPassportElementType.passport:
                Result := 'passport';
      TtgEncryptedPassportElementType.driver_license:
                Result := 'driver_license';
      TtgEncryptedPassportElementType.identity_card:
                Result := 'identity_card';
      TtgEncryptedPassportElementType.internal_passport:
                Result := 'internal_passport';
      TtgEncryptedPassportElementType.address:
                Result := 'address';
      TtgEncryptedPassportElementType.utility_bill:
                Result := 'utility_bill';
      TtgEncryptedPassportElementType.bank_statement:
                Result := 'bank_statement';
      TtgEncryptedPassportElementType.rental_agreement:
                Result := 'rental_agreement';
      TtgEncryptedPassportElementType.passport_registration:
                Result := 'passport_registration';
      TtgEncryptedPassportElementType.temporary_registration:
                Result := 'temporary_registration';
      TtgEncryptedPassportElementType.phone_number:
                Result := 'phone_number';
      TtgEncryptedPassportElementType.email:
                Result := 'email';
    end;
end;

{ TSendDiceHelper }

function TSendDiceHelper.ToString: string;
begin
  case Self of
    TtgEmojiType.etDado:
        Result  := '🎲';
    TtgEmojiType.etDardo:
        Result  := '🎯';
    TtgEmojiType.etBasquete:
        Result  := '🏀';
    TtgEmojiType.etBola:
        Result  := '⚽';
  end;
end;


end.


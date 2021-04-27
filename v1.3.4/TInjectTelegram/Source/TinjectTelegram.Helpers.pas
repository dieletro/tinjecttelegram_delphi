unit TinjectTelegram.Helpers;

interface

uses
 // TInjectTelegram.Bot.Impl,
  TInjectTelegram.Types,
  TInjectTelegram.Types.Enums;

type
  TtdParseModeHelper = record helper for TtdParseMode
    function ToString: string;
  end;

  TAllowedUpdatesHelper = record helper for TAllowedUpdates
    function ToString: string;
  end;

  TSendChatActionHelper = record helper for TtdSendChatAction
    function ToJsonString: string;
  end;

  TPassportDataHelper = record helper for TtdEncryptedPassportElementType
    function ToString: string;
  end;

  TSendDiceHelper = record helper for TtdEmojiType
    function ToString: string;
  End;

  TSendPollHelper = record helper for TtdQuizType
    function ToString: string;
  End;

  TSendHelper = record helper for TtdMessageEntityType
    function ToString: string;
  end;

  TBoolHelper = record helper for Boolean
    function ToJSONBool: string;
  end;

  TtdChatTypeHelper = record helper for TtdChatType
    function ToString: string;
  end;

implementation

uses
  System.SysUtils,
  System.Generics.Collections,
  System.RegularExpressions;

{ TtdParseModeHelper }

function TtdParseModeHelper.ToString: string;
begin
  case Self of
    TtdParseMode.Default:
      Result := '';
    TtdParseMode.Markdown:
      Result := 'Markdown';
    TtdParseMode.MarkdownV2:
      Result := 'MarkdownV2';
    TtdParseMode.Html:
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
    if TAllowedUpdate.MyChatMember in Self then
      LAllowed.Add('"my_chat_member"');
    if TAllowedUpdate.ChatMember in Self then
      LAllowed.Add('"chat_member"');
    Result := '[' + Result.Join(',', LAllowed.ToArray) + ']';
  finally
    LAllowed.Free;
  end;
end;

{ TSendChatActionHelper }

function TSendChatActionHelper.ToJsonString: string;
begin
  case Self of
    TtdSendChatAction.Typing:
      Result := 'typing';
    TtdSendChatAction.UploadPhoto:
      Result := 'upload_photo';
    TtdSendChatAction.Record_video:
      Result := 'record_video';
    TtdSendChatAction.UploadVideo:
      Result := 'upload_video';
    TtdSendChatAction.Record_audio:
      Result := 'record_audio';
    TtdSendChatAction.Upload_audio:
      Result := 'upload_audio';
    TtdSendChatAction.Upload_document:
      Result := 'upload_document';
    TtdSendChatAction.Find_location:
      Result := 'find_location';
    TtdSendChatAction.Record_video_note:
      Result := 'record_video_note';
    TtdSendChatAction.Upload_video_note:
      Result := 'upload_video_note';
  end;
end;


{ TPassportDataHelper }

function TPassportDataHelper.ToString: string;
begin
    case self of
      TtdEncryptedPassportElementType.personal_details:
        Result := 'personal_details';
      TtdEncryptedPassportElementType.passport:
        Result := 'passport';
      TtdEncryptedPassportElementType.driver_license:
        Result := 'driver_license';
      TtdEncryptedPassportElementType.identity_card:
        Result := 'identity_card';
      TtdEncryptedPassportElementType.internal_passport:
        Result := 'internal_passport';
      TtdEncryptedPassportElementType.address:
        Result := 'address';
      TtdEncryptedPassportElementType.utility_bill:
        Result := 'utility_bill';
      TtdEncryptedPassportElementType.bank_statement:
        Result := 'bank_statement';
      TtdEncryptedPassportElementType.rental_agreement:
        Result := 'rental_agreement';
      TtdEncryptedPassportElementType.passport_registration:
        Result := 'passport_registration';
      TtdEncryptedPassportElementType.temporary_registration:
        Result := 'temporary_registration';
      TtdEncryptedPassportElementType.phone_number:
        Result := 'phone_number';
      TtdEncryptedPassportElementType.email:
        Result := 'email';
    end;
end;

{ TSendDiceHelper }

function TSendDiceHelper.ToString: string;
begin
  case Self of
    TtdEmojiType.etDado:
        Result  := '🎲';
    TtdEmojiType.etDardo:
        Result  := '🎯';
    TtdEmojiType.etBasquete:
        Result  := '🏀';
    TtdEmojiType.etFootball:
        Result  := '⚽';
    TtdEmojiType.etSlotMachine:
        Result  := '🎰';
    TtdEmojiType.etBowling:
        Result  := '🎳';
  end;
end;

{ TSendPollHelper }

function TSendPollHelper.ToString: string;
begin
  case Self of
    TtdQuizType.qtPadrao:
      result := 'regular';
    TtdQuizType.qtRegular:
      result := 'regular';
    TtdQuizType.qtQuiz:
      result := 'quiz';
  end;
end;

{ TSendHelper }

function TSendHelper.ToString: string;
begin
  case Self of
    TtdMessageEntityType.mention:
      result := 'mention';
    TtdMessageEntityType.hashtag:
      result := 'hashtag';
    TtdMessageEntityType.cashtag:
      result := 'cashtag';
    TtdMessageEntityType.bot_command:
      result := 'bot_command';
    TtdMessageEntityType.url:
      result := 'url';
    TtdMessageEntityType.email:
      result := 'email';
    TtdMessageEntityType.phone_number:
      result := 'phone_number';
    TtdMessageEntityType.bold:
      result := 'bold';
    TtdMessageEntityType.italic:
      result := 'italic';
    TtdMessageEntityType.underline:
      result := 'underline';
    TtdMessageEntityType.strikethrough:
      result := 'strikethrough';
    TtdMessageEntityType.code:
      result := 'code';
    TtdMessageEntityType.pre:
      result := 'pre';
    TtdMessageEntityType.text_link:
      result := 'text_link';
    TtdMessageEntityType.text_mention:
      result := 'text_mention';
    TtdMessageEntityType.N_A:
      result := '';
  end;
end;

{ TBoolHelper }

function TBoolHelper.ToJSONBool: string;
var
  StrOut: String;
begin
  if Self = True then
    StrOut := 'True'
  else
    StrOut := 'False';

  Result := StrOut;
end;

{ TtdChatTypeHelper }

function TtdChatTypeHelper.ToString: string;
begin
  case Self of
    TtdChatType.private:
      Result := 'private';
    TtdChatType.Group:
      Result := 'Group';
    TtdChatType.Channel:
      Result := 'Channel';
    TtdChatType.Supergroup:
      Result := 'Supergroup';
  end;
end;

end.


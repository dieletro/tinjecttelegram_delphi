﻿unit TinjectTelegram.Bot;
interface
uses
  System.Classes,
  Winapi.Windows,
  TInjectTelegram.Types,
  TInjectTelegram.Types.Enums,
  TInjectTelegram.Types.Passport,
  TInjectTelegram.Types.InlineQueryResults,
  TInjectTelegram.Types.ReplyMarkups,
  TInjectTelegram.Types.Impl,
  TInjectTelegram.Logger,
  CrossUrl.HttpClient;
type
  {IInjectTelegramBot}
  IInjectTelegramBot = interface
    ['{12FA5CF8-3723-4ED1-BC1F-F1643B4FA361}']
    // private
    function GetToken: string;
    procedure SetToken(const Value: string);
    function GetLogger: ILogger;
    procedure SetLogger(const Value: ILogger);
    function GetHttpCore: IcuHttpClient;
    procedure SetHttpCore(const Value: IcuHttpClient);
    // public
{$REGION 'Getting updates'}
    /// <summary>
    /// <param>
    /// Use this method to receive incoming updates using long polling.
    /// </param>
    /// </summary>
    /// <param name="Offset">
    /// Identifier of the first update to be returned. Must be greater by one
    /// than the highest among the identifiers of previously received
    /// updates. By default, updates starting with the earliest unconfirmed
    /// update are returned. An update is considered confirmed as soon as
    /// <see cref="TInjectTelegram.Bot.Impl|TInjectTelegramBot.GetUpdates(Int64,Int64,Int64,TAllowedUpdates)">
    /// getUpdates</see> is called with an offset higher than its update_id.
    /// The negative offset can be specified to retrieve updates starting
    /// from -offset update from the end of the updates queue. All previous
    /// updates will forgotten.
    /// </param>
    /// <param name="Limit">
    /// The number of updates that can come in one request.
    /// Valid value is from 1 to 100. The default is 100. Limits the number
    /// of updates to be retrieved. Values between 1—100 are accepted.
    /// Defaults to 100.
    /// </param>
    /// <param name="Timeout">
    /// Timeout in seconds for long polling. Defaults to 0, i.e. usual short
    /// polling
    /// </param>
    /// <param name="AllowedUpdates">
    /// List the types of updates you want your bot to receive. For example,
    /// specify [“message”, “edited_channel_post”, “callback_query”] to only
    /// receive updates of these types. See Update for a complete list of
    /// available update types. Specify an empty list to receive all updates
    /// regardless of type (default). If not specified, the previous setting
    /// will be used. <br /><br />Please note that this parameter doesn't
    /// affect updates created before the call to the getUpdates, so unwanted
    /// updates may be received for a short period of time.
    /// </param>
    /// <returns>
    /// An Array of Update objects is returned.
    /// </returns>
    /// <remarks>
    /// 1. This method will not work if an outgoing webhook is set up. 2. In
    /// order to avoid getting duplicate updates, recalculate offset after
    /// each server response.
    /// </remarks>
    function GetUpdates( //
      const Offset: Int64 = 0; //
      const Limit: Int64 = 100; //
      const Timeout: Int64 = 0; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL)
      : TArray<ItdUpdate>; overload;
    function GetUpdates(const JSON: string): TArray<ItdUpdate>; overload;
    /// <summary>
    /// Use this method to specify a url and receive incoming updates via an
    /// outgoing webhook. Whenever there is an update for the bot, we will
    /// send an HTTPS POST request to the specified url, containing a
    /// JSON-serialized Update. In case of an unsuccessful request, we will
    /// give up after a reasonable amount of attempts.
    /// </summary>
    /// <param name="Url">
    /// HTTPS url to send updates to. Use an empty string to remove webhook
    /// integration
    /// </param>
    /// <param name="Certificate">
    /// Upload your public key certificate so that the root certificate in
    /// use can be checked. See our self-signed guide for details.
    /// </param>
    /// <param name="ip_address">
    /// <b>NEW!</b>Optional	The fixed IP address which will be used to send webhook
    /// requests instead of the IP address resolved through DNS.
    /// please check out this <see href="https://core.telegram.org/bots/webhooks">
    /// amazing guide to SetWebhooks</see>.
    /// </param>
    /// <param name="MaxConnections">
    /// Maximum allowed number of simultaneous HTTPS connections to the
    /// webhook for update delivery, 1-100. Defaults to 40. Use lower values
    /// to limit the load on your bot‘s server, and higher values to increase
    /// your bot’s throughput.
    /// </param>
    /// <param name="AllowedUpdates">
    /// List the types of updates you want your bot to receive. For example,
    /// specify [“message”, “edited_channel_post”, “callback_query”] to only
    /// receive updates of these types. See Update for a complete list of
    /// available update types. Specify an empty list to receive all updates
    /// regardless of type (default). If not specified, the previous setting
    /// will be used. <br /><br />Please note that this parameter doesn't
    /// affect updates created before the call to the setWebhook, so unwanted
    /// updates may be received for a short period of time.
    /// </param>
    /// </param>
    /// <param name="drop_pending_updates">
    /// <b>NEW!</b>Optional	Pass True to drop all pending updates
    /// please check out this <see href="https://core.telegram.org/bots/webhooks">
    /// amazing guide to SetWebhooks</see>.
    /// </param>
    /// <remarks>
    /// <param>
    /// Notes
    /// </param>
    /// <param>
    /// 1. You will not be able to receive updates using <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetUpdates(Int64,Int64,Int64,TAllowedUpdates)">
    /// getUpdates</see> for as long as an outgoing webhook is set up.
    /// </param>
    /// <param>
    /// 2. To use a self-signed certificate, you need to upload your <see href="https://core.telegram.org/bots/self-signed">
    /// public key certificate</see> using <c>certificate</c> parameter.
    /// Please upload as InputFile, sending a String will not work.
    /// </para>
    /// <param>
    /// 3. Ports currently supported for Webhooks: <b>443, 80, 88, 8443</b>
    /// </param>
    /// <param>
    /// <b>NEW!</b> If you're having any trouble setting up webhooks,
    /// please check out this <see href="https://core.telegram.org/bots/webhooks">
    /// amazing guide to Webhooks</see>.
    /// </remarks>
    function SetWebhook( //
      const Url: string; //
      const Certificate: TtdFileToSend = nil; //
      const IpAddress: String = '';
      const MaxConnections: Int64 = 40; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL;
      const DropPendingUpdates:	Boolean = False): Boolean;
    /// <summary>
    /// Use this method to remove webhook integration if you decide to switch
    /// back to getUpdates.
    /// <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetUpdates(Int64,Int64,Int64,TAllowedUpdates)">
    /// getUpdates</see>.
    /// </summary>
    /// <param name="drop_pending_updates">
    /// </param>
    /// <returns>
    /// Returns <c>True</c> on success.
    /// </returns>
    function DeleteWebhook(
    const DropPendingUpdates:	Boolean = False): Boolean;
    /// <summary>
    /// Use this method to get current webhook status.
    /// </summary>
    /// <returns>
    /// On success, returns a <see cref="TInjectTelegram.Types|TtdWebhookInfo">
    /// WebhookInfo</see> object
    /// </returns>
    /// <remarks>
    /// If the bot is using <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetUpdates(Int64,Int64,Int64,TAllowedUpdates)">
    /// getUpdates</see>, will return an object with the url field empty
    /// </remarks>
    function GetWebhookInfo: ItdWebhookInfo;
{$ENDREGION}
{$REGION 'Basic methods'}
    /// <summary>
    /// <para>
    /// Простой метод для проверки токена вашего бота
    /// </para>
    /// <para>
    /// A simple method for testing your bot's auth token.
    /// </para>
    /// </summary>
    /// <returns>
    /// <para>
    /// Возвращает основную информацию о боте
    /// </para>
    /// <para>
    /// Returns basic information about the bot in form of a <see cref="TInjectTelegram.Types|TtdUser">
    /// User</see> object.
    /// </para>
    /// </returns>
    function GetMe: ItdUser;
    /// <summary>
    /// Use este método para enviar mensagens de texto.
    /// </summary>
    /// <param name="ChatId">
    /// Int64 or String. Unique identifier for the target chat or username of
    /// the target channel (in the format <c>@channelusername</c> ).
    /// </param>
    /// <param name="Text">
    /// Texto da mensagem a ser enviada, 1-4096 caracteres após a análise das
    /// entidades
    /// </param>
    /// <param name="ParseMode">
    /// Modo para analisar entidades no texto da mensagem. Veja as opções de
    /// formatação para mais detalhes.
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Desativa visualizações de link para links nesta mensagem
    /// </param>
    /// <param name="DisableNotification">
    /// Envia a mensagem silenciosamente . Os usuários receberão uma notificação
    /// sem som.
    /// </param>
    /// <param name="ReplyToMessageId">
    /// Se a mensagem for uma resposta, o ID da mensagem original
    /// </param>
    /// <param name="ReplyMarkup">
    /// InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or
    /// ForceReply. Opções de interface adicionais. Um objeto serializado JSON
    /// para um teclado embutido , teclado de resposta personalizado , instruções
    /// para remover o teclado de resposta ou forçar uma resposta do usuário.
    /// </param>
    /// <returns>
    /// Em caso de sucesso, a mensagem enviada é retornada.
    /// <a href="https://core.telegram.org/bots/api#sendmessage">SendMessage</a>
    /// </returns>
    function SendMessage( //
      const ChatId: TtdUserLink; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to forward messages of any kind.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="FromChatId">
    /// Unique identifier for the chat where the original message was sent
    /// (or channel username in the format @channelusername) <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="MessageId">
    /// Unique message identifier <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function ForwardMessage( //
      const ChatId, FromChatId: TtdUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send photos.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Photo">
    /// Photo to send. You can either pass a file_id as String to resend a
    /// photo that is already on the Telegram servers, or upload a new photo
    /// using multipart/form-data. <br />
    /// </param>
    /// <param name="Caption">
    /// Photo caption (may also be used when resending photos by file_id),
    /// 0-200 characters <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to remove reply
    /// keyboard or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|TtdMessage">Message</see>
    /// is returned.
    /// </returns>
    /// <example>
    /// <code lang="Delphi">var
    /// LMessage: TtdMessage;
    /// Begin
    /// //Если не известен ИД файла
    /// LMessage := sendPhoto(chatId, TtdFileToSend.Create('Путь к файлу'), nil);
    /// //Если известен ИД файла
    /// LMessage := sendPhoto(chatId, 'ИД Файла');
    /// ...
    /// LMessage.Free;
    /// End; </code>
    /// </example>
    function SendPhoto( //
      const ChatId: TtdUserLink; //
      const Photo: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to
    /// display them in the music player. Your audio must be in the .mp3
    /// format.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Audio">
    /// Audio file to send. You can either pass a file_id as String to resend
    /// an audio that is already on the Telegram servers, or upload a new
    /// audio file using multipart/form-data. <br />
    /// </param>
    /// <param name="Duration">
    /// Duration of the audio in seconds <br />
    /// </param>
    /// <param name="Performer">
    /// Performer <br />
    /// </param>
    /// <param name="Title">
    /// Track name <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.
    /// </returns>
    /// <remarks>
    /// Bots can currently send audio files of up to 50 MB in size, this
    /// limit may be changed in the future. For sending voice messages, use
    /// the <see cref="TInjectTelegram.Bot|TInjectTelegramBot.SendVoice(TValue,TValue,Int64,Boolean,Int64,IReplyMarkup)">
    /// sendVoice</see> method instead.
    /// </remarks>
    function SendAudio( //
      const ChatId: TtdUserLink; //
      const Audio: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const Duration: Int64 = 0; //
      const Performer: string = ''; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to send general files.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Document">
    /// File to send. You can either pass a file_id as String to resend a
    /// file that is already on the Telegram servers, or upload a new file
    /// using multipart/form-data. <br />
    /// </param>
    /// <param name="Thumb">
    /// Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format
    /// and less than 200 kB in size. A thumbnail's width and height should not
    /// exceed 320. Ignored if the file is not uploaded using multipart/form-data.
    /// Thumbnails can't be reused and can be only uploaded as a new file, so you
    /// can pass “attach://<file_attach_name>” if the thumbnail was uploaded using
    /// multipart/form-data under <file_attach_name>. More info on Sending Files ».
    /// <br />
    /// </param>
    /// <param name="Caption">
    /// Document caption (may also be used when resending documents by
    /// file_id), 0-200 characters <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.
    /// </returns>
    /// <remarks>
    /// Bots can currently send files of any type of up to 50 MB in size,
    /// this limit may be changed in the future.
    /// </remarks>
    function SendDocument( //
      const ChatId: TtdUserLink; //
      const Document: TtdFileToSend; //
      const Thumb: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const CaptionEntities: TArray<TtdMessageEntity> = [];
      const DisableContentTypeDetection: Boolean = False;
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to send video files, Telegram clients support mp4
    /// videos (other formats may be sent as Document).
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Video">
    /// Video to send. You can either pass a file_id as String to resend a
    /// video that is already on the Telegram servers, or upload a new video
    /// file using multipart/form-data. <br />
    /// </param>
    /// <param name="Duration">
    /// Duration of sent video in seconds <br />
    /// </param>
    /// <param name="Width">
    /// Video width <br />
    /// </param>
    /// <param name="Height">
    /// Video height <br />
    /// </param>
    /// <param name="Caption">
    /// Video caption (may also be used when resending videos by file_id),
    /// 0-200 characters <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    /// <remarks>
    /// Bots can currently send video files of up to 50 MB in size, this
    /// limit may be changed in the future.
    /// </remarks>
    function SendVideo( //
      const ChatId: TtdUserLink; //
      const Video: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const SupportsStreaming: Boolean = True; //
      const Duration: Int64 = 0; //
      const Width: Int64 = 0; //
      const Height: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    ///Use this method to send animation files (GIF or H.264/MPEG-4 AVC video
    ///without sound). On success, the sent Message is returned. Bots can currently
    ///send animation files of up to 50 MB in size, this limit may be changed in the future.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Animation">
    /// Animation to send. Pass a file_id as String to send an animation that
    /// exists on the Telegram servers (recommended), pass an HTTP URL as a
    /// String for Telegram to get an animation from the Internet, or upload a
    /// new animation using multipart/form-data. More info on Sending Files » <br />
    /// </param>
    /// <param name="Duration">
    /// Duration of sent video in seconds <br />
    /// </param>
    /// <param name="Width">
    /// Video width <br />
    /// </param>
    /// <param name="Height">
    /// Video height <br />
    /// </param>
    /// <param name="Thumb">
    /// Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG
    /// format and less than 200 kB in size. A thumbnail‘s width and height
    /// should not exceed 320. Ignored if the file is not uploaded using
    /// multipart/form-data. Thumbnails can’t be reused and can be only uploaded
    /// as a new file, so you can pass “attach://<file_attach_name>” if the
    /// thumbnail was uploaded using multipart/form-data under <file_attach_name>.
    /// More info on Sending Files » <br />
    /// </param>
    /// <param name="Caption">
    /// Video caption (may also be used when resending videos by file_id),
    /// 0-200 characters <br />
    /// </param>
    /// <param name="Parse_mode">
    /// Mode for parsing entities in the animation caption. See formatting
    /// options for more details. <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    /// <remarks>
    /// Bots can currently send video files of up to 50 MB in size, this
    /// limit may be changed in the future.
    /// </remarks>
    function SendAnimation( //
      const ChatId: TtdUserLink; //
      const Animation: TtdFileToSend; //
      const Duration: Int64 = 0; //
      const Width: Int64 = 0; //
      const Height: Int64 = 0; //
      const Thumb: TtdFileToSend = nil; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to
    /// display the file as a playable voice message. For this to work, your
    /// audio must be in an .ogg file encoded with OPUS (other formats may be
    /// sent as Audio or Document).
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Voice">
    /// Audio file to send. You can either pass a file_id as String to resend
    /// an audio that is already on the Telegram servers, or upload a new
    /// audio file using multipart/form-data. <br />
    /// </param>
    /// <param name="Duration">
    /// Duration of sent audio in seconds <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned
    /// </returns>
    /// <remarks>
    /// Bots can currently send voice messages of up to 50 MB in size, this
    /// limit may be changed in the future.
    /// </remarks>
    function SendVoice( //
      const ChatId: TtdUserLink; //
      const Voice: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const Duration: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// As of <see href="https://telegram.org/blog/video-messages-and-telescope">
    /// v.4.0</see>, Telegram clients support rounded square mp4 videos of up
    /// to 1 minute long.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="VideoNote">
    /// Video note to send. Pass a file_id as String to send a video note
    /// that exists on the Telegram servers (recommended) or upload a new
    /// video using multipart/form-data. More info on Sending Files ».
    /// Sending video notes by a URL is currently unsupported <br />
    /// </param>
    /// <param name="Duration">
    /// Duration of sent video in seconds <br />
    /// </param>
    /// <param name="Length">
    /// Video width and height <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to remove reply
    /// keyboard or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.
    /// </returns>
    /// <remarks>
    /// Use this method to send video messages.
    /// </remarks>
    function SendVideoNote( //
      const ChatId: TtdUserLink; //
      const VideoNote: TtdFileToSend; //
      const Duration: Int64 = 0; //
      const Length: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to send point on the map.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Location">
    /// Latitude and Longitude of location
    /// This object represents a point on the map.
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <param name="AllowSendingWithoutReply">
    ///  Pass True, if the message should be sent even if the specified
    ///  replied-to message is not found
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.
    /// </returns>
    function SendLocation( //
      const ChatId: TtdUserLink; //
      const Location: ItdLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply: Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    ///  Updated by Ruan Diego Lacerda Menezes 13/04/2020
    /// Use this method to send information about a venue.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Venue">
    /// Latitude and Longitude of the venue <br />
    /// </param>
    /// </param>
    /// <param name="title">
    /// Name of the venue
    /// </param>
    /// <param name="address">
    /// Address of the venue
    /// </param>
    /// <param name="foursquare_id">
    /// Foursquare identifier of the venue
    /// </param>
    /// <param name="foursquare_type">
    /// String	Optional	Foursquare type of the venue, if known.
    /// (For example, “arts_entertainment/default”,
    /// “arts_entertainment/aquarium” or “food/icecream”.)
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function SendVenue( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const Location: ItdLocation; //Add Para Testes
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    ///  Updated by Ruan Diego Lacerda Menezes 13/04/2020
    /// Use this method to send information about a venue.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Venue">
    /// Latitude and Longitude of the venue <br />
    /// </param>
    /// </param>
    /// <param name="Venue.title">
    /// Name of the venue
    /// </param>
    /// <param name="Venue.address">
    /// Address of the venue
    /// </param>
    /// <param name="Venue.foursquare_id">
    /// Foursquare identifier of the venue
    /// </param>
    /// <param name="Venue.foursquare_type">
    /// String	Optional	Foursquare type of the venue, if known.
    /// (For example, “arts_entertainment/default”,
    /// “arts_entertainment/aquarium” or “food/icecream”.)
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function SendVenue2( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to send phone contacts.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Contact">
    /// Contact's phone number, first name, last name
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound.
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide keyboard or to
    /// force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#sendcontact" />
    function SendContact( //
      const ChatId: TtdUserLink; //
      const Contact: ItdContact; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Add By Ruan Diego Lacerda Menezes 13/04/2020
    /// sendPoll
    /// Use this method to send a native poll.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="question">
    /// String	Yes	Poll question, 1-255 characters
    /// </param>
    /// <param name="options">
    /// Array of String	Yes	A JSON-serialized list of answer options,
    /// 2-10 strings 1-100 characters each
    /// </param>
    /// <param name="is_anonymous">
    /// Boolean	Optional	True, if the poll needs to be anonymous, defaults to True
    /// </param>
    /// <param name="type">
    /// String	Optional	Poll type, “quiz” or “regular”, defaults to “regular”
    /// </param>
    /// <param name="allows_multiple_answers">
    /// Boolean	Optional	True, if the poll allows multiple answers,
    /// ignored for polls in quiz mode, defaults to False
    /// </param>
    /// <param name="correct_option_id">
    /// Integer	Optional	0-based
    /// identifier of the correct answer option, required for polls in quiz mode
    /// </param>
    /// <param name="explanation">
    /// Text that is shown when a user chooses an incorrect answer or taps on
    /// the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line
    /// feeds after entities parsing
    /// </param>
    /// <param name="explanation_parse_mode">
    /// Mode for parsing entities in the explanation. See formatting options
    /// for more details.
    /// </param>
    /// <param name="open_period">
    /// Amount of time in seconds the poll will be active after creation,
    /// 5-600. Can't be used together with close_date.
    /// </param>
    /// <param name="close_date">
    /// Point in time (Unix timestamp) when the poll will be automatically
    /// closed. Must be at least 5 and no more than 600 seconds in the future.
    /// Can't be used together with open_period.
    /// </param>
    /// <param name="is_closed">
    /// Boolean	Optional	Pass True,
    /// if the poll needs to be immediately closed. This can be useful for poll preview.
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// sendPoll
    /// On success, the sent Message is returned.
    /// </returns>
    function SendPoll( //
      const ChatId: TtdUserLink; //
      const Question: String; //Poll question, 1-255 characters
      const Options: Array of String; //
      const Is_Anonymous: Boolean = True; //
      const &type: TtdQuizType = TtdQuizType.qtPadrao;//String = '"regular"'; //regular ou quiz
      const Allows_Multiple_Answers: Boolean = False; //
      const Correct_Option_Id: Integer = 0;
      const Explanation: String = ''; //
      const Explanation_parse_mode: TtdParseMode = TtdParseMode.Default; //
      const Open_period : Integer = 0; //
      const Close_date: Integer= 0; //
      const Is_Closed: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Add By Ruan Diego Lacerda Menezes 13/04/2020
    /// sendDice
    /// Use this method to send a dice, which will have a random value from 1 to 6.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// sendDice
    ///  On success, the sent Message is returned. (Yes, we're aware of the
    ///  “proper” singular of die. But it's awkward, and we decided to help
    ///  it change. One dice at a time!)
    /// </returns>
    function SendDice( //
      const ChatId: TtdUserLink; //
      const Emoji: TtdEmojiType = TtdEmojiType.etDado;//
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method when you need to tell the user that something is
    /// happening on the bot's side. The status is set for 5 seconds or less
    /// (when a message arrives from your bot, Telegram clients clear its
    /// typing status).
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Action">
    /// Type of action to broadcast. Choose one, depending on what the user
    /// is about to receive: typing for text messages, upload_photo for
    /// photos, record_video or upload_video for videos, record_audio or
    /// upload_audio for audio files, upload_document for general files,
    /// find_location for location data <br />
    /// </param>
    /// <remarks>
    /// We only recommend using this method when a response from the bot will
    /// take a noticeable amount of time to arrive.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#sendchataction" />
    function SendChatAction( //
      const ChatId: TtdUserLink; //
      const Action: TtdSendChatAction): Boolean;
    /// <summary>
    /// Use this method to get a list of profile pictures for a user.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier of the target user <br />
    /// </param>
    /// <param name="Offset">
    /// Sequential number of the first photo to be returned. By default, all
    /// photos are returned. <br />
    /// </param>
    /// <param name="Limit">
    /// Limits the number of photos to be retrieved. Values between 1—100 are
    /// accepted. Defaults to 100. <br />
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|TtdUserProfilePhotos">
    /// UserProfilePhotos</see> object.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getuserprofilephotos" />
    function GetUserProfilePhotos( //
      const ChatId: TtdUserLink; //
      const Offset: Int64; //
      const Limit: Int64 = 100): ItdUserProfilePhotos;
    /// <summary>
    /// Use this method to get basic info about a file and prepare it for
    /// downloading. For the moment, bots can download files of up to 20MB in
    /// size.
    /// </summary>
    /// <param name="FileId">
    /// File identifier to get info about <br />
    /// </param>
    /// <returns>
    /// On success, a <see cref="TInjectTelegram.Types|TtdFile">File</see> object is
    /// returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getfile" />
    function GetFile(const FileId: string): ItdFile;
    /// <summary>
    /// Use this method to kick a user from a group, a supergroup or a
    /// channel. In the case of supergroups and channels, the user will not
    /// be able to return to the group on their own using invite links, etc.,
    /// unless unbanned first. The bot must be an administrator in the chat
    /// for this to work and must have the appropriate admin rights.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br />
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user <br />
    /// </param>
    /// <param name="UntilDate">
    /// Date when the user will be unbanned, unix time. If user is banned for
    /// more than 366 days or less than 30 seconds from the current time they
    /// are considered to be banned forever <br />unbanChatMember
    /// </param>
    /// <param name="RevokeMessages">
    /// Pass True to delete all messages from the chat for the user that is
    /// being removed. If False, the user will be able to see messages in the
    /// group that were sent before the user was removed. Always True for
    /// supergroups and channels.
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// Note: In regular groups (non-supergroups), this method will only work
    /// if the ‘All Members Are Admins’ setting is off in the target group.
    /// Otherwise members may only be removed by the group's creator or by
    /// the member that added them.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#kickchatmember" />
    function banChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const UntilDate: TDateTime = 0;
      const RevokeMessages: Boolean = False): Boolean;
    /// <summary>
    /// Use this method to unban a previously kicked user in a supergroup.
    /// The user will not return to the group automatically, but will be able
    /// to join via link, etc.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br />
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user <br />
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the group for this to work.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#unbanchatmember" />
    function UnbanChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64;
      const OnlyIfBanned:	Boolean): Boolean;
    /// <summary>
    /// Use this method for your bot to leave a group, supergroup or channel.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br />
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#leavechat" />
    function LeaveChat(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to get up to date information about the chat (current
    /// name of the user for one-on-one conversations, current username of a
    /// user, group or channel, etc.)
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup or channel (in the format @channelusername) <br />
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|TtdChat">Chat</see> object on
    /// success.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchat" />
    function GetChat(const ChatId: TtdUserLink): ItdChat;
    /// <summary>
    /// Use this method to get a list of administrators in a chat
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup or channel (in the format @channelusername) <br />
    /// </param>
    /// <returns>
    /// On success, returns an Array of <see cref="TInjectTelegram.Types|TtdChatMember">
    /// ChatMember</see> objects that contains information about all chat
    /// administrators except other bots. If the chat is a group or a
    /// supergroup and no administrators were appointed, only the creator
    /// will be returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchatadministrators" />
    function GetChatAdministrators(const ChatId: TtdUserLink)
      : TArray<ItdChatMember>;
    /// <summary>
    /// Use this method to get the number of members in a chat.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup or channel (in the format @channelusername) <br />
    /// </param>
    /// <returns>
    /// Returns Int64 on success.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchatmemberscount" />
    function GetChatMemberCount(const ChatId: TtdUserLink): Int64;
    /// <summary>
    /// Use this method to get information about a member of a chat.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br />
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user <br />
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|TtdChatMember">ChatMember</see>
    /// object on success.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchatmember" />
    function GetChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64): ItdChatMember;
    /// <summary>
    /// Use this method to send answers to callback queries sent from inline
    /// keyboards. The answer will be displayed to the user as a notification
    /// at the top of the chat screen or as an alert.
    /// </summary>
    /// <param name="CallbackQueryId">
    /// Unique identifier for the query to be answered <br />
    /// </param>
    /// <param name="Text">
    /// Text of the notification. If not specified, nothing will be shown to
    /// the user <br />
    /// </param>
    /// <param name="ShowAlert">
    /// If true, an alert will be shown by the client instead of a
    /// notification at the top of the chat screen. Defaults to false. <br />
    /// </param>
    /// <returns>
    /// On success, True is returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#answercallbackquery" />
    function AnswerCallbackQuery( //
      const CallbackQueryId: string; //
      const Text: string = ''; //
      const ShowAlert: Boolean = False; //
      const Url: string = ''; //
      const CacheTime: Int64 = 0): Boolean;
{$ENDREGION}
{$REGION 'BotCommands'}
    /// <summary>
    ///  setMyCommands
    ///  Use this method to change the list of the bot's commands.
    ///  See https://core.telegram.org/bots#commands for more details
    ///  about bot commands.
    /// </summary>
    /// <param name="commands" type="Array of BotCommand" require="YES">
    /// A JSON-serialized list of bot commands to be set as the list of the
    /// bot's commands. At most 100 commands can be specified. <br />
    /// </param>
    /// <param name="scope" type="TtdBotCommandScope" require="OPTIONAL">
    /// A JSON-serialized object, describing scope of users for which the
    /// commands are relevant. Defaults to BotCommandScopeDefault. <br />
    /// </param>
    /// <param name="language_code" type="String" require="OPTIONAL">
    /// A two-letter ISO 639-1 language code. If empty, commands will be applied
    /// to all users from the given scope, for whose language there are no
    /// dedicated commands. <br />
    /// </param>
    /// <returns>
    /// On success, True is returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#setmycommands" />
    function SetMyCommands(
        const Command: TArray<TtdBotCommand>;
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''
    ): Boolean;
    /// <summary>
    ///  getMyCommands
    ///  Use this method to get the current list of the bot's commands.
    ///  Requires no parameters.
    /// </summary>
    /// <param name="scope" type="TtdBotCommandScope" require="OPTIONAL">
    /// A JSON-serialized object, describing scope of users for which the
    /// commands are relevant. Defaults to BotCommandScopeDefault. <br />
    /// </param>
    /// <param name="language_code" type="String" require="OPTIONAL">
    /// A two-letter ISO 639-1 language code. If empty, commands will be applied
    /// to all users from the given scope, for whose language there are no
    /// dedicated commands. <br />
    /// </param>
    /// <returns>
    /// On success, Returns Array of BotCommand.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getmycommands" />
    function GetMyCommands(
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''
    ): TArray<ItdBotCommand>;
    /// <summary>
    ///  deleteMyCommands
    ///  Use this method to delete the list of the bot's commands for the given
    ///  scope and user language. After deletion, higher level commands will be
    ///  shown to affected users.
    /// </summary>
    /// <param name="scope" type="TtdBotCommandScope" require="OPTIONAL">
    /// A JSON-serialized object, describing scope of users for which the
    /// commands are relevant. Defaults to BotCommandScopeDefault. <br />
    /// </param>
    /// <param name="language_code" type="String" require="OPTIONAL">
    /// A two-letter ISO 639-1 language code. If empty, commands will be applied
    /// to all users from the given scope, for whose language there are no
    /// dedicated commands. <br />
    /// </param>
    /// <returns>
    /// Returns True on success..
    /// </returns>
    function DeleteMyCommands(
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''
    ): Boolean;
    /// <summary>
    ///  LogOut
    ///  Use this method to log out from the cloud Bot API server before
    ///  launching the bot locally. You must log out the bot before running
    ///  it locally, otherwise there is no guarantee that the bot will receive
    ///  updates. After a successful call, you can immediately log in on a local
    ///  server, but will not be able to log in back to the cloud Bot API
    ///  server for 10 minutes.
    /// </summary>
    /// <returns>
    ///  Returns True on success. Requires no parameters.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#logOut" />
    function LogOut: Boolean;
    /// <summary>
    ///  Close
    ///  Use this method to close the bot instance before moving it from one
    ///  local server to another. You need to delete the webhook before calling
    ///  this method to ensure that the bot isn't launched again after server
    ///  restart. The method will return error 429 in the first 10 minutes after
    ///  the bot is launched.
    /// </summary>
    /// <returns>
    ///  Returns True on success. Requires no parameters.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#logOut" />
    function Close: Boolean;
{$ENDREGION 'BotCommands'}
{$REGION 'Updating messages'}
    /// <summary>
    /// Use this method to edit text messages sent by the bot or via the bot
    /// (for inline bots).
    /// </summary>
    /// <param name="ChatId">
    /// Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername) <br />
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Unique identifier of
    /// the sent message <br />
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified. Identifier of
    /// the inline message <br />
    /// </param>
    /// <param name="Text">
    /// New text of the message <br />
    /// </param>
    /// <param name="ParseMode">
    /// Send Markdown or HTML, if you want Telegram apps to show bold,
    /// italic, fixed-width text or inline URLs in your bot's message. <br />
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Disables link previews for links in this message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br />
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editmessagetext" />
    function EditMessageText( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    function EditMessageText( //
      const InlineMessageId: string; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    /// <summary>
    /// Use this method to edit captions of messages sent by the bot or via
    /// the bot (for inline bots).
    /// </summary>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername) <br />
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Unique identifier of <br />
    /// the sent message <br />
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of the
    /// inline message <br />
    /// </param>
    /// <param name="Caption">
    /// New caption of the message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br />
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editmessagereplymarkup" />
    function EditMessageCaption( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    { TODO -oRuan Diego -cGeneral : Create Documentatiom }
    function EditMessageCaption( //
      const InlineMessageId: string; //
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    /// <summary>
    /// Use this method to edit live location messages sent by the bot or via
    /// the bot (for inline bots). A location can be edited until its
    /// live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation.
    /// </summary>
    /// <param name="ChatId">
    /// Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Identifier of the
    /// sent message
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified.
    /// Identifier of the inline message sent message
    /// </param>
    /// <param name="Location">
    /// new location
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard.
    /// </param>
    /// <returns>
    /// On success, if the edited message was sent by the bot, the edited
    /// Message is returned, otherwise True is returned.
    /// </returns>
    function editMessageLiveLocation( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Location: ItdLocation; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    /// <summary>
    /// Use this method to edit live location messages sent by the bot or via
    /// the bot (for inline bots). A location can be edited until its
    /// live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation.
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified. Identifier of
    /// the inline message
    /// </param>
    /// <param name="Location">
    /// new location
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard.
    /// </param>
    /// <param name="ChatId">
    /// Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Identifier of the
    /// sent message
    /// </param>
    /// <returns>
    /// On success, if the edited message was sent by the bot, the edited
    /// Message is returned, otherwise True is returned.
    /// </returns>
    function editMessageLiveLocation( //
      const InlineMessageId: string; //
      const Location: ItdLocation; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    /// <summary>
    /// Use this method to stop updating a live location message sent by the
    /// bot or via the bot (for inline bots) before live_period expires.
    /// </summary>
    /// <param name="ChatId">
    /// equired if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Identifier of the
    /// sent message
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard.
    /// </param>
    /// <returns>
    /// On success, if the message was sent by the bot, the sent Message is
    /// returned, otherwise True is returned.
    /// </returns>
    function stopMessageLiveLocation( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    /// <summary>
    /// Use this method to stop updating a live location message sent by the
    /// bot or via the bot (for inline bots) before live_period expires.
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified. Identifier of
    /// the inline message
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard.
    /// </param>
    /// <returns>
    /// On success, if the message was sent by the bot, the sent Message is
    /// returned, otherwise True is returned.
    /// </returns>
    function stopMessageLiveLocation( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    /// <summary>
    /// Use this method to edit only the reply markup of messages sent by the
    /// bot or via the bot (for inline bots).
    /// </summary>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for <br />
    /// the target chat or username of the target channel (in the format <br />
    /// @channelusername) <br />
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Unique identifier of <br />
    /// the sent message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br />
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.
    /// </returns>
    function EditMessageReplyMarkup( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    /// <summary>
    /// Use this method to edit only the reply markup of messages sent by the
    /// bot or via the bot (for inline bots).
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of <br />
    /// the inline message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br />
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.
    /// </returns>
    function EditMessageReplyMarkup( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    /// <summary>
    /// Use this method to delete a message.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="MessageId">
    /// Identifier of the message to delete <br />
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// A message can only be deleted if it was sent less than 48 hours ago.
    /// Any such recently sent outgoing message may be deleted. Additionally,
    /// if the bot is an administrator in a group chat, it can delete any
    /// message. If the bot is an administrator in a supergroup, it can
    /// delete messages from any other user and service messages about people
    /// joining or leaving the group (other types of service messages may
    /// only be removed by the group creator). In channels, bots can only
    /// remove their own messages.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#deletemessage" />
    function DeleteMessage( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64): Boolean;
{$ENDREGION}
{$REGION 'ChatInviteLink'}
    function createChatInviteLink( //
      const ChatId: TtdUserLink; //
      const name: String;  //Invite link name; 0-32 characters
      const expire_date: TDateTime;
      const member_limit: Integer = 0;
      const creates_join_request: boolean = false): ItdChatInviteLink;
    function editChatInviteLink( //
      const ChatId: TtdUserLink; //
      const expire_date: TDateTime;
      const invite_link: String = '';
      const name: String = '';  //Invite link name; 0-32 characters
      const member_limit: Integer = 0;
      const creates_join_request: boolean = false): ItdChatInviteLink;
    function revokeChatInviteLink( //
      const ChatId: TtdUserLink; //
      const invite_link: String = ''): ItdChatInviteLink;
    function approveChatJoinRequest(
      const ChatId: TtdUserLink; //
      const UserId: TtdUserLink): Boolean;
    function declineChatJoinRequest(
      const ChatId: TtdUserLink; //
      const UserId: TtdUserLink): Boolean;
{$ENDREGION 'ChatInviteLink'}
{$REGION 'Inline mode'}
    /// <summary>
    /// Use this method to send answers to an inline query.
    /// </summary>
    /// <param name="InlineQueryId">
    /// Unique identifier for the answered query <br />
    /// </param>
    /// <param name="Results">
    /// A JSON-serialized array of results for the inline query <br />
    /// </param>
    /// <param name="CacheTime">
    /// The maximum amount of time in seconds that the result of the inline
    /// query may be cached on the server. Defaults to 300. <br />
    /// </param>
    /// <param name="IsPersonal">
    /// Pass True, if results may be cached on the server side only for the
    /// user that sent the query. By default, results may be returned to any
    /// user who sends the same query <br />
    /// </param>
    /// <param name="NextOffset">
    /// Pass the offset that a client should send in the next query with the
    /// same text to receive more results. Pass an empty string if there are
    /// no more results or if you don‘t support pagination. Offset length
    /// can’t exceed 64 bytes. <br />
    /// </param>
    /// <param name="SwitchPmText">
    /// If passed, clients will display a button with specified text that
    /// switches the user to a private chat with the bot and sends the bot a
    /// start message with the parameter switch_pm_parameter <br />
    /// </param>
    /// <param name="SwitchPmParameter">
    /// Parameter for the start message sent to the bot when user presses the
    /// switch button <br />
    /// </param>
    /// <returns>
    /// On success, True is returned.
    /// </returns>
    /// <remarks>
    /// No more than 50 results per query are allowed.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#answerinlinequery" />
    function AnswerInlineQuery( //
      const InlineQueryId: string; //
      const Results: TArray<TtdInlineQueryResult>; //
      const CacheTime: Int64 = 300; //
      const IsPersonal: Boolean = False; //
      const NextOffset: string = ''; //
      const SwitchPmText: string = ''; //
      const SwitchPmParameter: string = ''): Boolean;
{$ENDREGION}
{$REGION 'Payments'}
    /// <summary>
    /// Use this method to send invoices.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target private chat <br />
    /// </param>
    /// <param name="Title">
    /// Product name
    /// </param>
    /// <param name="Description">
    /// Product description
    /// </param>
    /// <param name="Payload">
    /// Bot-defined invoice payload, 1-128 bytes. This will not be displayed
    /// to the user, use for your internal processes.
    /// </param>
    /// <param name="ProviderToken">
    /// Payments provider token, obtained via Botfather
    /// </param>
    /// <param name="StartParameter">
    /// Unique deep-linking parameter that can be used to generate this
    /// invoice when used as a start parameter
    /// </param>
    /// <param name="Currency">
    /// Three-letter ISO 4217 currency code, see more on currencies
    /// </param>
    /// <param name="Prices">
    /// Price breakdown, a list of components (e.g. product price, tax,
    /// discount, delivery cost, delivery tax, bonus, etc.)
    /// </param>
    /// <param name="max_tip_amount">
    ///   Optional. The maximum accepted amount for tips in
    ///   the smallest units of the currency (integer, not
    ///   float/double). For example, for a maximum tip of
    ///   US$ 1.45 pass max_tip_amount = 145. See the exp
    ///   parameter in currencies.json, it shows the number
    ///   of digits past the decimal point for each currency
    ///   (2 for the majority of currencies). Defaults to 0
    /// </param>
    /// <param name="suggested_tip_amounts">
    ///   Optional. A JSON-serialized array of suggested
    ///   amounts of tip in the smallest units of the
    ///   currency (integer, not float/double). At most 4
    ///   suggested tip amounts can be specified. The
    ///   suggested tip amounts must be positive, passed in
    ///   a strictly increased order and must not exceed
    ///   max_tip_amount.
    /// </param>
    /// <param name="PhotoUrl">
    /// URL of the product photo for the invoice. Can be a photo of the goods
    /// or a marketing image for a service.
    /// </param>
    /// <param name="PhotoSize">
    /// Photo size
    /// </param>
    /// <param name="PhotoWidth">
    /// Photo width
    /// </param>
    /// <param name="PhotoHeight">
    /// Photo height
    /// </param>
    /// <param name="NeedName">
    /// Pass True, if you require the user's full name to complete the order
    /// </param>
    /// <param name="NeedPhoneNumber">
    /// Pass True, if you require the user's phone number to complete the
    /// order
    /// </param>
    /// <param name="NeedEmail">
    /// Pass True, if you require the user's email to complete the order
    /// </param>
    /// <param name="NeedShippingAddress">
    /// Pass True, if you require the user's shipping address to complete the
    /// order
    /// </param>
    /// <param name="IsFlexible">
    /// Pass True, if the final price depends on the shipping method
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound.
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for a custom
    /// reply keyboard, instructions to hide keyboard or to force a reply
    /// from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage" /> is
    /// returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#sendinvoice" />
    function SendInvoice( //
      const ChatId: Int64; //
      const title: string; //
      const Description: string; //
      const Payload: string; //
      const ProviderToken: string; //
      const StartParameter: string; //
      const Currency: string; //
      const Prices: TArray<TtdLabeledPrice>; //
      const MaxTipAmount: Integer = 0; //
      const SuggestedTipAmounts: TArray<Integer> = []; //
      const ProviderData: string = ''; //
      const PhotoUrl: string = ''; //
      const PhotoSize: Int64 = 0; //
      const PhotoWidth: Int64 = 0; //
      const PhotoHeight: Int64 = 0; //
      const NeedName: Boolean = False; //
      const NeedPhoneNumber: Boolean = False; //
      const NeedEmail: Boolean = False; //
      const NeedShippingAddress: Boolean = False; //
      const SendPhoneNumberToProvider: Boolean = False; //
      const SendRmailToProvider: Boolean = False; //
      const IsFlexible: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// If you sent an invoice requesting a shipping address and the
    /// parameter is_flexible was specified, the Bot API will send an Update
    /// with a shipping_query field to the bot. Use this method to reply to
    /// shipping queries. On success, True is returned.
    /// </summary>
    /// <param name="ShippingQueryId">
    /// Unique identifier for the query to be answered
    /// </param>
    /// <param name="Ok">
    /// Specify True if delivery to the specified address is possible and
    /// False if there are any problems (for example, if delivery to the
    /// specified address is not possible)
    /// </param>
    /// <param name="ShippingOptions">
    /// Required if <c>ok</c> is <c>True</c>. A JSON-serialized array of
    /// available shipping options.
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains why it is impossible to complete the
    /// order (e.g. "Sorry, delivery to your desired address is
    /// unavailable'). Telegram will display this message to the user.
    /// </param>
    /// <seealso href="https://core.telegram.org/bots/api#answershippingquery" />
    function AnswerShippingQueryGood( //
      const ShippingQueryId: string; //
      const ShippingOptions: TArray<TtdShippingOption>): Boolean;
    function AnswerShippingQueryBad( //
      const ShippingQueryId: string; //
      const ErrorMessage: string): Boolean;
    /// <summary>
    /// Once the user has confirmed their payment and shipping details, the
    /// Bot API sends the final confirmation in the form of an <see cref="TInjectTelegram.Types|TtdUpdate">
    /// Update</see> with the field PreCheckoutQueryId. Use this method to
    /// respond to such pre-checkout queries.
    /// </summary>
    /// <param name="PreCheckoutQueryId">
    /// Unique identifier for the query to be answered
    /// </param>
    /// <param name="Ok">
    /// Specify <c>True</c> if everything is alright (goods are available,
    /// etc.) and the bot is ready to proceed with the order. Use False if
    /// there are any problems.
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains the reason for failure to proceed with
    /// the checkout (e.g. "Sorry, somebody just bought the last of our
    /// amazing black T-shirts while you were busy filling out your payment
    /// details. Please choose a different color or garment!"). Telegram will
    /// display this message to the user.
    /// </param>
    /// <returns>
    /// On success, True is returned.
    /// </returns>
    /// <remarks>
    /// <b>Note</b>: The Bot API must receive an answer within 10 seconds
    /// after the pre-checkout query was sent.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#answerprecheckoutquery" />
    function AnswerPreCheckoutQueryGood( //
      const PreCheckoutQueryId: string): Boolean;
    function AnswerPreCheckoutQueryBad( //
      const PreCheckoutQueryId: string; //
      const ErrorMessage: string): Boolean;
    function AnswerPreCheckoutQuery( //
      const PreCheckoutQueryId: string; //
      const OK: Boolean;
      const ErrorMessage: string): Boolean;
{$ENDREGION}
{$REGION 'Telegram Passport'}
    /// <summary>
    /// Informs a user that some of the Telegram Passport elements they provided
    /// contains errors. The user will not be able to re-submit their Passport to
    /// you until the errors are fixed (the contents of the field for which you
    /// returned the error must change).
    /// Use this if the data submitted by the user doesn't satisfy the standards
    /// your service requires for any reason. For example, if a birthday date
    /// seems invalid, a submitted document is blurry, a scan shows evidence of
    /// tampering, etc. Supply some details in the error message to make sure the
    /// user knows how to correct the issues.
    /// </summary>
    /// <param name="UserId">
    /// User identifier <br />
    /// </param>
    /// <param name="Errors">
    /// A JSON-serialized array describing the errors
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#setPassportDataErrors" />
    function SetPassportDataErrors( //
      const UserId: Int64; //
      const Errors: TArray<TtdEncryptedPassportElement>): Boolean;
{$ENDREGION 'Telegram Passport'}
{$REGION 'Games'}
    /// <summary>
    /// Use this method to send a game.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat <br />
    /// </param>
    /// <param name="GameShortName">
    /// Short name of the game, serves as the unique identifier for the game.
    /// Set up your games via Botfather. <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. If empty, one ‘Play
    /// game_title’ button will be shown. If not empty, the first button must
    /// launch the game. <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#sendgame" />
    function SendGame( //
      const ChatId: Int64; //
      const GameShortName: string; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to set the score of the specified user in a game.
    /// </summary>
    /// <param name="UserId">
    /// User identifier <br />
    /// </param>
    /// <param name="Score">
    /// New score, must be non-negative <br />
    /// </param>
    /// <param name="Force">
    /// Pass True, if the high score is allowed to decrease. This can be
    /// useful when fixing mistakes or banning cheaters <br />
    /// </param>
    /// <param name="DisableEditMessage">
    /// Pass True, if the game message should not be automatically edited to
    /// include the current scoreboard <br />
    /// </param>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for <br />
    /// the target chat <br />
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Identifier of the <br />
    /// sent message <br />
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of the
    /// inline message <br />
    /// </param>
    /// <returns>
    /// On success, if the message was sent by the bot, returns the edited
    /// Message, otherwise returns True. Returns an error, if the new score
    /// is not greater than the user's current score in the chat and force is
    /// False.
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#setgamescore" />
    function SetGameScore( //
      const UserId: Int64; //
      const Score: Int64; //
      const InlineMessageId: string; //
      const Force: Boolean = False; //
      const DisableEditMessage: Boolean = False): ItdMessage; overload;
    function SetGameScore( //
      const UserId: Int64; //
      const Score: Int64; //
      const ChatId: Int64; //
      const MessageId: Int64; //
      const Force: Boolean = False; //
      const DisableEditMessage: Boolean = False): ItdMessage; overload;
    /// <summary>
    /// Use this method to get data for high score tables. Will return the
    /// score of the specified user and several of his neighbors in a game.
    /// </summary>
    /// <param name="UserId">
    /// Target user id <br />
    /// </param>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for <br />
    /// the target chat <br />
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Identifier of the <br />
    /// sent message <br />
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of <br />
    /// the inline message <br />
    /// </param>
    /// <returns>
    /// On success, returns an Array of <see cref="TInjectTelegram.Types|TtdGameHighScore">
    /// GameHighScore</see> objects.
    /// </returns>
    /// <remarks>
    /// This method will currently return scores for the target user, plus
    /// two of his closest neighbors on each side. Will also return the top
    /// three users if the user and his neighbors are not among them. Please
    /// note that this behavior is subject to change.
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#getgamehighscores">
    /// Official API
    /// </seealso>
    function GetGameHighScores( //
      const UserId: Int64; //
      const InlineMessageId: string = ''): TArray<ItdGameHighScore>; overload;
    function GetGameHighScores( //
      const UserId: Int64; //
      const ChatId: Int64 = 0; //
      const MessageId: Int64 = 0): TArray<ItdGameHighScore>; overload;
{$ENDREGION}
{$REGION 'Manage groups and channels'}
    /// <summary>
    /// Use this method to delete a chat photo.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>)
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// Photos can't be changed for private chats. The bot must be an
    /// administrator in the chat for this to work and must have the
    /// appropriate admin rights.
    /// </remarks>
    function DeleteChatPhoto(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to export an invite link to a supergroup or a
    /// channel.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>)
    /// </param>
    /// <returns>
    /// Returns exported invite link as String on success.
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the chat for this to work and
    /// must have the appropriate admin rights.
    /// </remarks>
    function ExportChatInviteLink(const ChatId: TtdUserLink): string;
    /// <summary>
    /// Use this method to pin a message in a supergroup. The bot must be an
    /// administrator in the chat for this to work and must have the
    /// appropriate admin rights.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <param name="MessageId">
    /// Identifier of a message to pin <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Pass True, if it is not necessary to send a notification to all group
    /// members about the new pinned message
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function PinChatMessage( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False): Boolean;
    /// <summary>
    /// Use this method to change the description of a supergroup or a
    /// channel. The bot must be an administrator in the chat for this to
    /// work and must have the appropriate admin rights.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>)
    /// </param>
    /// <param name="Description">
    /// New chat description, 0-255 characters
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function SetChatDescription(const ChatId: TtdUserLink;
      const Description: string): Boolean;
    /// <summary>
    /// Use this method to set a new profile photo for the chat. Photos can't
    /// be changed for private chats.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>)
    /// </param>
    /// <param name="Photo">
    /// New chat photo, uploaded using multipart/form-data
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the chat for this to work and
    /// must have the appropriate admin rights.
    /// </remarks>
    function SetChatPhoto(const ChatId: TtdUserLink;
      const Photo: TtdFileToSend): Boolean;
    /// <summary>
    /// Use this method to change the title of a chat. Titles can't be
    /// changed for private chats. The bot must be an administrator in the
    /// chat for this to work and must have the appropriate admin rights.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>)
    /// </param>
    /// <param name="Title">
    /// New chat title, 1-255 characters
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// Note: In regular groups (non-supergroups), this method will only work
    /// if the ‘All Members Are Admins’ setting is off in the target group.
    /// </remarks>
    function SetChatTitle(const ChatId: TtdUserLink;
      const title: string): Boolean;
    /// <summary>
    /// Use this method to unpin a message in a supergroup chat. The bot must
    /// be an administrator in the chat for this to work and must have the
    /// appropriate admin rights.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function UnPinChatMessage(
      const ChatId: TtdUserLink; //
      const MessageId: Int64 ): Boolean;
    /// <summary>
    /// Use this method to clear the list of pinned messages in a chat.
    /// If the chat is not a private chat, the bot must be an administrator in
    /// the chat for this to work and must have the 'can_pin_messages' admin
    /// right in a supergroup or 'can_edit_messages' admin right in a channel..
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function UnPinAllChatMessages(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    ///  CopyMessage
    /// Use this method to copy messages of any kind. The method is analogous
    /// to the method forwardMessages, but the copied message doesn't have a
    /// link to the original message.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <param name="FromChatId">
    /// Unique identifier for the chat where the original message was sent
    /// (or channel username in the format @channelusername)
    /// </param>
    /// <param name="MessageId">
    /// Message identifier in the chat specified in from_chat_id
    /// </param>
    /// <param name="Caption">
    /// New caption for media, 0-1024 characters after entities parsing.
    /// If not specified, the original caption is kept
    /// </param>
    /// <param name="ParseMode">
    /// Modo para analisar entidades no texto da mensagem. Veja as opções de
    /// formatação para mais detalhes.
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Desativa visualizações de link para links nesta mensagem
    /// </param>
    /// <param name="DisableNotification">
    /// Envia a mensagem silenciosamente . Os usuários receberão uma notificação
    /// sem som.
    /// </param>
    /// <param name="ReplyToMessageId">
    /// Se a mensagem for uma resposta, o ID da mensagem original
    /// </param>
    /// <param name="AllowSendingWithoutReply">
    /// Pass True, if the message should be sent even if the specified
    /// replied-to message is not found
    /// </param>
    /// <param name="ReplyMarkup">
    /// InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or
    /// ForceReply. Opções de interface adicionais. Um objeto serializado JSON
    /// para um teclado embutido , teclado de resposta personalizado , instruções
    /// para remover o teclado de resposta ou forçar uma resposta do usuário.
    /// </param>
    /// <returns>
    /// Returns the MessageId of the sent message on success.
    /// <a href="https://core.telegram.org/bots/api#sendmessage">copyMessage</a>
    /// </returns>
    function CopyMessage( //
      const ChatId: TtdUserLink; //
      const FromChatId: TtdUserLink; //
      const MessageId: Int64;//
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const CaptionEntities: TArray<TtdMessageEntity> = [];
      const DisableWebPagePreview: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): Int64;
    /// <summary>
    /// banChatSenderChat
    /// Use this method to ban a channel chat in a supergroup or a channel. Until
    /// the chat is unbanned, the owner of the banned chat won't be able to send
    /// messages on behalf of any of their channels. The bot must be an administrator
    /// in the supergroup or channel for this to work and must have the appropriate
    /// administrator rights.
    /// to the method forwardMessages, but the copied message doesn't have a
    /// link to the original message.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <param name="SenderChatId">
    /// Unique identifier of the target sender chat
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// <a href="https://core.telegram.org/bots/api#banchatsenderchat">banChatSenderChat</a>
    /// </returns>
    function banChatSenderChat(const ChatId: TtdUserLink; //
      const SenderChatId: Int64): boolean;
    /// <summary>
    /// banChatSenderChat
    /// Use this method to ban a channel chat in a supergroup or a channel. Until
    /// the chat is unbanned, the owner of the banned chat won't be able to send
    /// messages on behalf of any of their channels. The bot must be an administrator
    /// in the supergroup or channel for this to work and must have the appropriate
    /// administrator rights.
    /// to the method forwardMessages, but the copied message doesn't have a
    /// link to the original message.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <param name="SenderChatId">
    /// Unique identifier of the target sender chat
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// <a href="https://core.telegram.org/bots/api#unbanchatsenderchat">unbanChatSenderChat</a>
    /// </returns>
    function unbanChatSenderChat(const ChatId: TtdUserLink; //
      const SenderChatId: Int64): boolean;

{$ENDREGION}
{$REGION 'Manage users and admins'}
    /// <summary>
    /// Use this method to restrict a user in a supergroup. The bot must be
    /// an administrator in the supergroup for this to work and must have the
    /// appropriate admin rights. Pass True for all boolean parameters to
    /// lift restrictions from a user.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user
    /// </param>
    /// <param name="UntilDate">
    /// Date when restrictions will be lifted for the user, unix time. If
    /// user is restricted for more than 366 days or less than 30 seconds
    /// from the current time, they are considered to be restricted forever
    /// </param>
    /// <param name="CanSendMessages">
    /// Pass True, if the user can send text messages, contacts, locations
    /// and venues
    /// </param>
    /// <param name="CanSendMediaMessages">
    /// Pass True, if the user can send audios, documents, photos, videos,
    /// video notes and voice notes, implies CanSendMessages <br />
    /// </param>
    /// <param name="CanSendOtherMessages">
    /// Pass True, if the user can send animations, games, stickers and use
    /// inline bots, implies CanSendMediaMessages <br />
    /// </param>
    /// <param name="CanAddWebPagePreviews">
    /// Pass True, if the user may add web page previews to their messages,
    /// implies CanSendMediaMessages <br />
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function RestrictChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const UntilDate: TDateTime = 0; //
      const CanSendMessages: Boolean = False; //
      const CanSendMediaMessages: Boolean = False; //
      const CanSendOtherMessages: Boolean = False; //
      const CanAddWebPagePreviews: Boolean = False): Boolean;
    /// <summary>
    /// Use this method to restrict a user in a supergroup. The bot must be
    /// an administrator in the supergroup for this to work and must have the
    /// appropriate admin rights. Pass True for all boolean parameters to
    /// lift restrictions from a user.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user
    /// </param>
    /// <param name="IsAnonymous">
    ///  Optional
    /// Pass True, if the administrator's presence in the chat is hidden
    /// </param>
    /// <param name="CanChangeInfo">
    /// Pass True, if the administrator can change chat title, photo and
    /// other settings
    /// </param>
    /// <param name="CanPostMessages">
    /// Pass True, if the administrator can create channel posts, channels
    /// only
    /// </param>
    /// <param name="CanEditMessages">
    /// Pass True, if the administrator can edit messages of other users,
    /// channels only
    /// </param>
    /// <param name="CanDeleteMessages">
    /// Pass True, if the administrator can delete messages of other users
    /// </param>
    /// <param name="CanInviteUsers">
    /// Pass True, if the administrator can invite new users to the chat
    /// </param>
    /// <param name="CanRestrictMembers">
    /// Pass True, if the administrator can restrict, ban or unban chat
    /// members
    /// </param>
    /// <param name="CanPinMessages">
    /// Pass True, if the administrator can pin messages, supergroups only
    /// </param>
    /// <param name="CanPromoteMembers">
    /// Pass True, if the administrator can add new administrators with a
    /// subset of his own privileges or demote administrators that he has
    /// promoted, directly or indirectly (promoted by administrators that
    /// were appointed by him)
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    ///
    function PromoteChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const IsAnonymous: Boolean = False;
      const CanManageChat: Boolean = False;
      const CanPostMessages: Boolean = False; //
      const CanEditMessages: Boolean = False; //
      const CanDeleteMessages: Boolean = False; //
      const CanManageVoiceChats: Boolean = False;
      const CanRestrictMembers: Boolean = False; //
      const CanPromoteMembers: Boolean = False;
      const CanChangeInfo: Boolean = False; //
      const CanInviteUsers: Boolean = False; //
      const CanPinMessages: Boolean = False): Boolean;
{$ENDREGION}
{$REGION 'Strickers'}
    /// <summary>
    /// Use this method to send .webp stickers.
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br />
    /// </param>
    /// <param name="Sticker">
    /// Sticker to send. You can either pass a file_id as String to resend a
    /// sticker that is already on the Telegram servers, or upload a new
    /// sticker using multipart/form-data. <br />
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br />
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br />
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function SendSticker( //
      const ChatId: TtdUserLink; //
      const Sticker: TtdFileToSend; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    /// <summary>
    /// Use this method to get a sticker set.
    /// </summary>
    /// <param name="name">
    /// Name of the sticker set
    /// </param>
    /// <returns>
    /// On success, a <see cref="TInjectTelegram.Types|TtdStickerSet">StickerSet</see>
    /// object is returned.
    /// </returns>
    function getStickerSet(const Name: string): ItdStickerSet;
    /// <summary>
    /// Use this method to upload a .png file with a sticker for later use in
    /// <see cref="TInjectTelegram.Bot|TInjectTelegramBot.createNewStickerSet(Int64,string,string,TValue,string,Boolean,TtdMaskPosition)">
    /// createNewStickerSet</see> and <see cref="TInjectTelegram.Bot|TInjectTelegramBot.addStickerToSet(Int64,string,TValue,string,TtdMaskPosition)">
    /// addStickerToSet</see> methods (can be used multiple times). <br />
    /// </summary>
    /// <param name="UserId">
    /// User identifier of sticker file owner <br />
    /// </param>
    /// <param name="PngSticker">
    /// Png image with the sticker, must be up to 512 kilobytes in size,
    /// dimensions must not exceed 512px, and either width or height must be
    /// exactly 512px. <br />
    /// </param>
    /// <returns>
    /// Returns the uploaded <see cref="TInjectTelegram.Types|TtdFile">File</see> on
    /// success.
    /// </returns>
    function uploadStickerFile(const UserId: Int64;
      const PngSticker: TtdFileToSend): ItdFile;
    /// <summary>
    /// Use this method to create new sticker set owned by a user. The bot
    /// will be able to edit the created sticker set.
    /// </summary>
    /// <param name="UserId">
    /// User identifier of created sticker set owner <br />
    /// </param>
    /// <param name="Name">
    /// Short name of sticker set, to be used in t.me/addstickers/ URLs
    /// (e.g., animals). Can contain only english letters, digits and
    /// underscores. Must begin with a letter, can't contain consecutive
    /// underscores and must end in by “__&lt;bot username&gt;”.
    /// &lt;bot_username&gt; is case insensitive. 1-64 characters. <br />
    /// </param>
    /// <param name="Title">
    /// Sticker set title, 1-64 characters <br />
    /// </param>
    /// <param name="PngSticker">
    /// Png image with the sticker, must be up to 512 kilobytes in size,
    /// dimensions must not exceed 512px, and either width or height must be
    /// exactly 512px. Pass a file_id as a String to send a file that already
    /// exists on the Telegram servers, pass an HTTP URL as a String for
    /// Telegram to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files » <br />
    /// </param>
    /// <param name="TgsSticker">
    /// TGS animation with the sticker, uploaded using multipart/form-data.
    /// See https://core.telegram.org/animated_stickers#technical-requirements
    /// for technical requirements  »  <br />
    /// </param>
    /// <param name="Emojis">
    /// One or more emoji corresponding to the sticker <br />
    /// </param>
    /// <param name="ContainsMasks">
    /// Pass True, if a set of mask stickers should be created <br />
    /// </param>
    /// <param name="MaskPosition">
    /// A JSON-serialized object for position where the mask should be placed
    /// on faces <br />
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function createNewStickerSet( //
      const UserId: Int64; //
      const Name, title: string; //
      const PngSticker: TtdFileToSend; //
      const TgsSticker: TtdFileToSend; //
      const Emojis: string; //
      const ContainsMasks: Boolean = False; //
      const MaskPosition: ItdMaskPosition = nil): Boolean;
    /// <summary>
    /// Use this method to add a new sticker to a set created by the bot.
    /// </summary>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function addStickerToSet( //
      const UserId: Int64; //
      const Name: string; //
      const PngSticker: TtdFileToSend; //
      const TgsSticker: TtdFileToSend; //
      const Emojis: string; //
      const MaskPosition: ItdMaskPosition = nil): Boolean;
    /// <summary>
    /// Use this method to move a sticker in a set created by the bot to a
    /// specific position.
    /// </summary>
    /// <param name="Sticker">
    /// File identifier of the sticker
    /// </param>
    /// <param name="Position">
    /// New sticker position in the set, zero-based
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function setStickerPositionInSet(const Sticker: string;
      const Position: Int64): Boolean;
    /// <summary>
    /// Use this method to delete a sticker from a set created by the bot.
    /// </summary>
    /// <param name="Sticker">
    /// File identifier of the sticker
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function deleteStickerFromSet(const Sticker: string): Boolean;
    /// <summary>
    /// Use this method to set a new group sticker set for a supergroup.
    /// </summary>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the chat for this to work and
    /// must have the appropriate admin rights. Use the field <see cref="TInjectTelegram.Types|TtdChat.CanSetStickerSet">
    /// CanSetStickerSet</see> optionally returned in <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetChat(TValue)">
    /// getChat</see> requests to check if the bot can use this method.
    /// </remarks>
    function setChatStickerSet(const ChatId: TtdUserLink;
      const StickerSetName: string): Boolean;
    /// <summary>
    /// Use this method to delete a group sticker set from a supergroup.
    /// </summary>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the chat for this to work and
    /// must have the appropriate admin rights. Use the field <see cref="TInjectTelegram.Types|TtdChat.CanSetStickerSet">
    /// CanSetStickerSet</see> optionally returned in <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetChat(TValue)">
    /// getChat</see> requests to check if the bot can use this method.
    /// </remarks>
    function deleteChatStickerSet(const ChatId: TtdUserLink): Boolean;

    function sendMediaGroup( //
      const ChatId: TtdUserLink; //
      const AMedia: TArray<TtdInputMedia>; //
      const ADisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0;
      const AllowSendingWithoutReply:	Boolean = False): TArray<ItdMessage>;
{$ENDREGION}
    property Token: string read GetToken write SetToken;
    property Logger: ILogger read GetLogger write SetLogger;
    property HttpCore: IcuHttpClient read GetHttpCore write SetHttpCore;
  end;
Implementation
End.




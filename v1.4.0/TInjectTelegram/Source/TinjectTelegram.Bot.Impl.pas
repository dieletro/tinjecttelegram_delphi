unit TInjectTelegram.Bot.Impl;
{$I ..\Source\config.inc}
interface
uses
  Vcl.Dialogs,
  System.Classes,
  System.TypInfo,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  TinjectTelegram.Core,
  TinjectTelegram.Base,
  TinjectTelegram.Bot,
  TinjectTelegram.Types,
  TinjectTelegram.Types.Impl,
  TinjectTelegram.Types.Enums,
  TinjectTelegram.Types.ReplyMarkups,
  TinjectTelegram.Types.InlineQueryResults,
  TinjectTelegram.Logger,
  TinjectTelegram.Types.Passport,
  TinjectTelegram.Utils.JSON,
  CrossUrl.HttpClient,
  System.RegularExpressions;
type
  TtdOnReceiveRawData = procedure(ASender: TObject; const AData: string) of object;
  TtdOnSendData = procedure(ASender: TObject; const AUrl, AData: string) of object;
  TtdOnDisconect = procedure(ASender: TObject; const AErrorCode: string) of object;
  {TInjectTelegramBotBase}
  TInjectTelegramBotBase = class(TInjectTelegramAbstractComponent)
  strict private
    FLog: ILogger;
    FRequest: ItdRequestAPI;
    FOnRawData: TtdOnReceiveRawData;
    FOnSendData: TtdOnSendData;
    FOnDisconect: TtdOnDisconect;
  private
    FIsBusy: Boolean;
    function GetLogger: ILogger;
    procedure SetLogger(const Value: ILogger);
    function GetHttpCore: IcuHttpClient;
    procedure SetHttpCore(const Value: IcuHttpClient);
    function GetUrlAPI: string;
    procedure SetUrlAPI(const Value: string);
  protected
    function GetRequest: ItdRequestAPI;
    procedure DoInitApiCore; virtual;
    // Returns TJSONArray as method request result
    function GetJSONArrayFromMethod(const AValue: string): TJSONArray;
    // Returns response JSON from server as result of request
    function GetArrayFromMethod<TI: IInterface>(const TdClass: TBaseJsonClass;
      const AValue: string): TArray<TI>;
  public
    constructor Create(AOwner: TComponent); override;
    {$REGION 'Propriedades|Property|Свойства'}
    property Logger: ILogger read GetLogger write SetLogger;
    property HttpCore: IcuHttpClient read GetHttpCore write SetHttpCore;
    property UrlAPI: string read GetUrlAPI write SetUrlAPI;
    property IsBusy: Boolean read FIsBusy write FIsBusy;
    {$ENDREGION}
    {$REGION 'Eventos|Events|События'}
    property OnReceiveRawData: TtdOnReceiveRawData read FOnRawData write FOnRawData;
    property OnSendData: TtdOnSendData read FOnSendData write FOnSendData;
    property OnDisconect: TtdOnDisconect read FOnDisconect write FOnDisconect;
    {$ENDREGION}
  end;
  {TInjectTelegramBot}
  TInjectTelegramBot = class(TInjectTelegramBotBase, IInjectTelegramBot)
  private
    FToken: string;
    function GetToken: string;
    procedure SetToken(const Value: string);
  protected
    procedure DoInitApiCore; override;
  public
    procedure AssignTo(Dest: TPersistent); override;
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(const AToken: string); reintroduce; overload;
    constructor Create(const AToken: string; ACore: IcuHttpClient); reintroduce; overload;
{$REGION 'Getting updates'}
    /// <summary>
    /// <param>
    /// Use this method to receive incoming updates using long polling.<br/>
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
    /// updates will forgotten.<br/>
    /// </param>
    /// <param name="Limit">
    /// The number of updates that can come in one request.
    /// Valid value is from 1 to 100. The default is 100. Limits the number
    /// of updates to be retrieved. Values between 1—100 are accepted.
    /// Defaults to 100. <br/>
    /// </param>
    /// <param name="Timeout">
    /// Timeout in seconds for long polling. Defaults to 0, i.e. usual short
    /// polling <br/>
    /// </param>
    /// <param name="AllowedUpdates">
    /// List the types of updates you want your bot to receive. For example,
    /// specify [“message”, “edited_channel_post”, “callback_query”] to only
    /// receive updates of these types. See Update for a complete list of
    /// available update types. Specify an empty list to receive all updates
    /// regardless of type (default). If not specified, the previous setting
    /// will be used. <br /><br />Please note that this parameter doesn't
    /// affect updates created before the call to the getUpdates, so unwanted
    /// updates may be received for a short period of time.<br/>
    /// </param>
    /// <returns>
    /// An Array of Update objects is returned.<br/>
    /// </returns>
    /// <remarks>
    /// 1. This method will not work if an outgoing webhook is set up. 2. In
    /// order to avoid getting duplicate updates, recalculate offset after
    /// each server response.<br/>
    /// </remarks>
    function GetUpdates( //
      const Offset: Int64 = 0; //
      const Limit: Int64 = 100; //
      const Timeout: Int64 = 0; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL): TArray<
      ItdUpdate>; overload;
    /// <summary>
    /// <param>
    /// Use this method to receive incoming updates using long polling.<br/>
    /// </param>
    /// </summary>
    /// <param name="JSON">
    /// A JSON-serialized list of getUpdates method parameters.<br/>
    /// </param>
    /// <returns>
    /// An Array of Update objects is returned.<br/>
    /// </returns>
    /// <remarks>
    /// 1. This method will not work if an outgoing webhook is set up. 2. In
    /// order to avoid getting duplicate updates, recalculate offset after
    /// each server response.<br/>
    /// </remarks>
    function GetUpdates( //
      const JSON: string): TArray<ItdUpdate>; overload;
    /// <summary>
    /// Use this method to specify a url and receive incoming updates via an
    /// outgoing webhook. Whenever there is an update for the bot, we will
    /// send an HTTPS POST request to the specified url, containing a
    /// JSON-serialized Update. In case of an unsuccessful request, we will
    /// give up after a reasonable amount of attempts. <br/>
    /// </summary>
    /// <param name="Url">
    /// HTTPS url to send updates to. Use an empty string to remove webhook
    /// integration <br/>
    /// </param>
    /// <param name="Certificate">
    /// Upload your public key certificate so that the root certificate in
    /// use can be checked. See our self-signed guide for details. <br/>
    /// </param>
    /// <param name="ip_address">
    /// <b>NEW!</b>Optional	The fixed IP address which will be used to send webhook
    /// requests instead of the IP address resolved through DNS.
    /// please check out this <see href="https://core.telegram.org/bots/webhooks">
    /// amazing guide to SetWebhooks</see>.<br/>
    /// </param>
    /// <param name="MaxConnections">
    /// Maximum allowed number of simultaneous HTTPS connections to the
    /// webhook for update delivery, 1-100. Defaults to 40. Use lower values
    /// to limit the load on your bot‘s server, and higher values to increase
    /// your bot’s throughput. <br/>
    /// </param>
    /// <param name="AllowedUpdates">
    /// List the types of updates you want your bot to receive. For example,
    /// specify [“message”, “edited_channel_post”, “callback_query”] to only
    /// receive updates of these types. See Update for a complete list of
    /// available update types. Specify an empty list to receive all updates
    /// regardless of type (default). If not specified, the previous setting
    /// will be used. <br /><br />Please note that this parameter doesn't
    /// affect updates created before the call to the setWebhook, so unwanted
    /// updates may be received for a short period of time. <br/>
    /// </param>
    /// </param>
    /// <param name="drop_pending_updates">
    /// <b>NEW!</b>Optional	Pass True to drop all pending updates
    /// please check out this <see href="https://core.telegram.org/bots/webhooks">
    /// amazing guide to SetWebhooks</see>. <br/>
    /// </param>
    /// <remarks>
    /// <param>
    /// Notes
    /// </param>
    /// <param>
    /// 1. You will not be able to receive updates using <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetUpdates(Int64,Int64,Int64,TAllowedUpdates)">
    /// getUpdates</see> for as long as an outgoing webhook is set up. <br/>
    /// </param>
    /// <param>
    /// 2. To use a self-signed certificate, you need to upload your <see href="https://core.telegram.org/bots/self-signed">
    /// public key certificate</see> using <c>certificate</c> parameter.
    /// Please upload as InputFile, sending a String will not work. <br/>
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
    /// back to getUpdates. <br/>
    /// <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetUpdates(Int64,Int64,Int64,TAllowedUpdates)">
    /// getUpdates</see>.<br/>
    /// </summary>
    /// <param name="drop_pending_updates">
    /// </param>
    /// <returns>
    /// Returns <c>True</c> on success.
    /// </returns>
    function DeleteWebhook(
      const DropPendingUpdates:	Boolean = False): Boolean;
    /// <summary>
    /// Use this method to get current webhook status.<br/>
    /// </summary>
    /// <returns>
    /// On success, returns a <see cref="TInjectTelegram.Types|TtdWebhookInfo">
    /// WebhookInfo</see> object <br/>
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
    /// A simple method for testing your bot's authentication token. <br/>
    /// </para>
    /// </summary>
    /// <para>
    /// Requires no parameters.<br/>
    /// </para>
    /// <returns>
    /// <para>
    /// Returns basic information about the bot in form of a User object. <see cref="TInjectTelegram.Types|TtdUser">
    /// User</see> object.
    /// </para>
    /// </returns>
    function GetMe: ItdUser;
    /// <summary>
    /// Use this method to send text messages.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Int64 or String. Unique identifier for the target chat or username of
    /// the target channel (in the format <c>@channelusername</c> ).<br/>
    /// </param>
    /// <param name="Text">
    /// Text of the message to be sent, 1-4096 characters after analyzing the
    /// entities. <br/>
    /// </param>
    /// <param name="ParseMode">
    /// Mode for analyzing entities in message text. See the options for
    /// formatting for more details. <br/>
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Disables link views for links in this message. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Send the message silently. Users will receive a notification
    /// no sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, the original message ID. <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or
    /// ForceReply. Additional interface options. A serialized JSON object
    /// for a built-in keyboard, custom response keyboard, instructions
    /// to remove keyboard response or force a response from the user. <br/>
    /// </param>
    /// <param name="ProtectContent">
    ///  Protects the contents of the sent message from forwarding and saving. <br/>
    /// </param>
    /// <returns>
    /// In case of success, the sent message is returned.
    /// <see><a href="https://core.telegram.org/bots/api#sendmessage">SendMessage</a>
    /// </returns>
    function SendMessage( //
      const ChatId: TtdUserLink; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    ///<summary >
    /// Use this method to forward messages of any kind.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="FromChatId">
    /// Unique identifier for the chat where the original message was sent
    /// (or channel username in the format @channelusername) <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="MessageId">
    /// Unique message identifier <br/>
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function ForwardMessage( //
      const ChatId, FromChatId: TtdUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send photos.<br/>
    /// </summary>
    /// <param name='ChatId'>
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Photo">
    /// Photo to send. You can either pass a file_id as String to resend a
    /// photo that is already on the Telegram servers, or upload a new photo
    /// using multipart/form-data. <br/>
    /// </param>
    /// <param name="Caption">
    /// Photo caption (may also be used when resending photos by file_id),
    /// 0-200 characters <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br />
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to remove reply
    /// keyboard or to force a reply from the user. <br/>
    /// </param>
    /// <param name="ProtectContent">
    ///  Protects the contents of the sent message from forwarding and saving. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|TtdMessage">Message</see>
    /// is returned.<br/>
    /// </returns>
    /// <example>
    /// <c/>Example:<br/>
    /// <code lang="Delphi">
    /// var <br/>
    /// LMessage: TtdMessage;<br/>
    /// Begin<br/>
    /// //If the file ID is not known<br/>
    /// LMessage := sendPhoto(chatId, TtdFileToSend.Create('The path to the file'), nil);<br/>
    /// //If the file ID is known<br/>
    /// LMessage := sendPhoto(chatId, 'File ID');<br/>
    /// ...<br/>
    /// LMessage.Free;<br/>
    /// End;<br/>
    /// </code>
    /// </example>
    function SendPhoto( //
      const ChatId: TtdUserLink; //
      const Photo: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to
    /// display them in the music player. Your audio must be in the .mp3
    /// format.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Audio">
    /// Audio file to send. You can either pass a file_id as String to resend
    /// an audio that is already on the Telegram servers, or upload a new
    /// audio file using multipart/form-data. <br/>
    /// </param>
    /// <param name="Duration">
    /// Duration of the audio in seconds <br/>
    /// </param>
    /// <param name="Performer">
    /// Performer <br/>
    /// </param>
    /// <param name="Title">
    /// Track name <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <param name="ProtectContent">
    ///  Protects the contents of the sent message from forwarding and saving. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.<br/>
    /// </returns>
    /// <remarks>
    /// Bots can currently send audio files of up to 50 MB in size, this
    /// limit may be changed in the future. For sending voice messages, use
    /// the <see cref="TInjectTelegram.Bot|TInjectTelegramBot.SendAudio(TValue,TValue,Int64,Boolean,Int64,IReplyMarkup)">
    /// SendAudio</see> method instead.
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send general files.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Document">
    /// File to send. You can either pass a file_id as String to resend a
    /// file that is already on the Telegram servers, or upload a new file
    /// using multipart/form-data. <br/>
    /// </param>
    /// <param name="Thumb">
    /// Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format
    /// and less than 200 kB in size. A thumbnail's width and height should not
    /// exceed 320. Ignored if the file is not uploaded using multipart/form-data.
    /// Thumbnails can't be reused and can be only uploaded as a new file, so you
    /// can pass “attach://<file_attach_name>” if the thumbnail was uploaded using
    /// multipart/form-data under <file_attach_name>. More info on Sending Files ».
    /// <br/>
    /// </param>
    /// <param name="Caption">
    /// Document caption (may also be used when resending documents by
    /// file_id), 0-200 characters <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.<br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send video files, Telegram clients support mp4
    /// videos (other formats may be sent as Document).<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Video">
    /// Video to send. You can either pass a file_id as String to resend a
    /// video that is already on the Telegram servers, or upload a new video
    /// file using multipart/form-data. <br/>
    /// </param>
    /// <param name="Duration">
    /// Duration of sent video in seconds <br/>
    /// </param>
    /// <param name="Width">
    /// Video width <br/>
    /// </param>
    /// <param name="Height">
    /// Video height <br/>
    /// </param>
    /// <param name="Caption">
    /// Video caption (may also be used when resending videos by file_id),
    /// 0-200 characters <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    ///Use this method to send animation files (GIF or H.264/MPEG-4 AVC video
    ///without sound). On success, the sent Message is returned. Bots can currently
    ///send animation files of up to 50 MB in size, this limit may be changed in the future.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Animation">
    /// Animation to send. Pass a file_id as String to send an animation that
    /// exists on the Telegram servers (recommended), pass an HTTP URL as a
    /// String for Telegram to get an animation from the Internet, or upload a
    /// new animation using multipart/form-data. More info on Sending Files » <br/>
    /// </param>
    /// <param name="Duration">
    /// Duration of sent video in seconds <br/>
    /// </param>
    /// <param name="Width">
    /// Video width <br/>
    /// </param>
    /// <param name="Height">
    /// Video height <br/>
    /// </param>
    /// <param name="Thumb">
    /// Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG
    /// format and less than 200 kB in size. A thumbnail‘s width and height
    /// should not exceed 320. Ignored if the file is not uploaded using
    /// multipart/form-data. Thumbnails can’t be reused and can be only uploaded
    /// as a new file, so you can pass “attach://<file_attach_name>” if the
    /// thumbnail was uploaded using multipart/form-data under <file_attach_name>.
    /// More info on Sending Files » <br/>
    /// </param>
    /// <param name="Caption">
    /// Video caption (may also be used when resending videos by file_id),
    /// 0-200 characters <br/>
    /// </param>
    /// <param name="Parse_mode">
    /// Mode for parsing entities in the animation caption. See formatting
    /// options for more details. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.<br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to
    /// display the file as a playable voice message. For this to work, your
    /// audio must be in an .ogg file encoded with OPUS (other formats may be
    /// sent as Audio or Document).<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Voice">
    /// Audio file to send. You can either pass a file_id as String to resend
    /// an audio that is already on the Telegram servers, or upload a new
    /// audio file using multipart/form-data. <br/>
    /// </param>
    /// <param name="Duration">
    /// Duration of sent audio in seconds <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// As of <see href="https://telegram.org/blog/video-messages-and-telescope">
    /// v.4.0</see>, Telegram clients support rounded square mp4 videos of up
    /// to 1 minute long.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="VideoNote">
    /// Video note to send. Pass a file_id as String to send a video note
    /// that exists on the Telegram servers (recommended) or upload a new
    /// video using multipart/form-data. More info on Sending Files ».
    /// Sending video notes by a URL is currently unsupported <br/>
    /// </param>
    /// <param name="Duration">
    /// Duration of sent video in seconds <br/>
    /// </param>
    /// <param name="Length">
    /// Video width and height <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to remove reply
    /// keyboard or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send point on the map. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Location">
    /// Latitude and Longitude of location
    /// This object represents a point on the map. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <param name="AllowSendingWithoutReply">
    ///  Pass True, if the message should be sent even if the specified
    ///  replied-to message is not found. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send information about a venue.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Venue">
    /// Latitude and Longitude of the venue <br/>
    /// </param>
    /// </param>
    /// <param name="title">
    /// Name of the venue. <br/>
    /// </param>
    /// <param name="address">
    /// Address of the venue. <br/>
    /// </param>
    /// <param name="foursquare_id">
    /// Foursquare identifier of the venue. <br/>
    /// </param>
    /// <param name="foursquare_type">
    /// String	Optional	Foursquare type of the venue, if known.
    /// (For example, “arts_entertainment/default”,
    /// “arts_entertainment/aquarium” or “food/icecream”.). <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function SendVenue( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const Location: ItdLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send information about a venue.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Venue">
    ///  venue Data. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to send phone contacts.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Contact">
    /// Contact's phone number, first name, last name
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message.<br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide keyboard or to
    /// force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage">Message</see>
    /// is returned.<br/>
    /// </returns>
    /// <see also href="https://core.telegram.org/bots/api#sendcontact" />
    function SendContact( //
      const ChatId: TtdUserLink; //
      const Contact: ItdContact; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// sendPoll
    /// Use this method to send a native poll.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="question">
    /// String	Yes	Poll question, 1-255 characters. <br/>
    /// </param>
    /// <param name="options">
    /// Array of String	Yes	A JSON-serialized list of answer options,
    /// 2-10 strings 1-100 characters each. <br/>
    /// </param>
    /// <param name="is_anonymous">
    /// Boolean	Optional	True, if the poll needs to be anonymous, defaults to True. <br/>
    /// </param>
    /// <param name="type">
    /// String	Optional	Poll type, “quiz” or “regular”, defaults to “regular”. <br/>
    /// </param>
    /// <param name="allows_multiple_answers">
    /// Boolean	Optional	True, if the poll allows multiple answers,
    /// ignored for polls in quiz mode, defaults to False. <br/>
    /// </param>
    /// <param name="correct_option_id">
    /// Integer	Optional	0-based
    /// identifier of the correct answer option, required for polls in quiz mode. <br/>
    /// </param>
    /// <param name="explanation">
    /// Text that is shown when a user chooses an incorrect answer or taps on
    /// the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line
    /// feeds after entities parsing. <br/>
    /// </param>
    /// <param name="explanation_parse_mode">
    /// Mode for parsing entities in the explanation. See formatting options
    /// for more details.<br/>
    /// </param>
    /// <param name="open_period">
    /// Amount of time in seconds the poll will be active after creation,
    /// 5-600. Can't be used together with close_date.<br/>
    /// </param>
    /// <param name="close_date">
    /// Point in time (Unix timestamp) when the poll will be automatically
    /// closed. Must be at least 5 and no more than 600 seconds in the future.
    /// Can't be used together with open_period.<br/>
    /// </param>
    /// <param name="is_closed">
    /// Boolean	Optional	Pass True,
    /// if the poll needs to be immediately closed. This can be useful for poll preview. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent Message is returned.
    /// </returns>
    function SendPoll(
      const ChatId: TtdUserLink; //
      const Question: String; //Poll question, 1-255 characters
      const Options: Array of String; //
      const Is_Anonymous: Boolean = True; //
      const &type: TtdQuizType = TtdQuizType.qtRegular;//String = '{"regular"}'; //
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// sendDice
    /// Use this method to send a dice, which will have a random value from 1 to 6.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// <param name="DisableNotification">
    /// Sends the message <see href="https://telegram.org/blog/channels-2-0#silent-messages">
    /// silently</see>. iOS users will not receive a notification, Android
    /// users will receive a notification with no sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
    /// </param>
    /// <returns>
    ///  On success, the sent Message is returned. (Yes, we're aware of the
    ///  “proper” singular of die. But it's awkward, and we decided to help
    ///  it change. One dice at a time!)
    /// </returns>
    function SendDice(
      const ChatId: TtdUserLink; //
      const Emoji: TtdEmojiType = TtdEmojiType.etDado;//
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method when you need to tell the user that something is
    /// happening on the bot's side. The status is set for 5 seconds or less
    /// (when a message arrives from your bot, Telegram clients clear its
    /// typing status).<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Action">
    /// Type of action to broadcast. Choose one, depending on what the user
    /// is about to receive: typing for text messages, upload_photo for
    /// photos, record_video or upload_video for videos, record_audio or
    /// upload_audio for audio files, upload_document for general files,
    /// find_location for location data <br/>
    /// </param>
    /// <remarks>
    /// We only recommend using this method when a response from the bot will
    /// take a noticeable amount of time to arrive. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#sendchataction" />
    function SendChatAction( //
      const ChatId: TtdUserLink; //
      const Action: TtdSendChatAction): Boolean;
    /// <summary>
    /// Use this method to send a group of photos, videos, documents or audios as an album.
    /// Documents and audio files can be only grouped in an album with messages of the same type.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier of the target user <br/>
    /// </param>
    /// <param name="AMedia">
    /// Array of InputMediaAudio, InputMediaDocument,
    /// InputMediaPhoto and InputMediaVideo.
    /// A JSON-serialized array describing messages to be sent, must include 2-10 items. <br/>
    /// </param>
    /// <param name="ADisableNotification">
    /// Sends messages silently. Users will receive a notification with no sound.. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the messages are a reply, ID of the original message. <br/>
    /// </param>
    /// <param name="AllowSendingWithoutReply">
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found. <br/>
    /// </param>
    /// <param name="ProtectContent">
    /// Protects the contents of the sent messages from forwarding and saving. <br/>
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|ItdMessage">
    /// Message</see> object.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#sendmediagroup" />
    function sendMediaGroup( //
      const ChatId: TtdUserLink; //
      const AMedia: TArray<TtdInputMedia>; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0;
      const AllowSendingWithoutReply:	Boolean = False;
      const ProtectContent: Boolean = False): TArray<ItdMessage>;
    /// <summary>
    /// Use this method to get a list of profile pictures for a user.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier of the target user <br/>
    /// </param>
    /// <param name="Offset">
    /// Sequential number of the first photo to be returned. By default, all
    /// photos are returned. <br/>
    /// </param>
    /// <param name="Limit">
    /// Limits the number of photos to be retrieved. Values between 1—100 are
    /// accepted. Defaults to 100. <br/>
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|TtdUserProfilePhotos">
    /// UserProfilePhotos</see> object.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getuserprofilephotos" />
    function GetUserProfilePhotos( //
      const ChatId: TtdUserLink; //
      const Offset: Int64; //
      const Limit: Int64 = 100): ItdUserProfilePhotos;
    /// <summary>
    /// Use this method to get basic info about a file and prepare it for
    /// downloading. For the moment, bots can download files of up to 20MB in
    /// size. <br/>
    /// </summary>
    /// <param name="FileId">
    /// File identifier to get info about <br/>
    /// </param>
    /// <returns>
    /// On success, a <see cref="TInjectTelegram.Types|TtdFile">File</see> object is
    /// returned. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getfile" />
    function GetFile(const FileId: string): ItdFile;
    /// <summary>
    /// Use this method to kick a user from a group, a supergroup or a
    /// channel. In the case of supergroups and channels, the user will not
    /// be able to return to the group on their own using invite links, etc.,
    /// unless unbanned first. The bot must be an administrator in the chat
    /// for this to work and must have the appropriate admin rights.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user <br/>
    /// </param>
    /// <param name="UntilDate">
    /// Date when the user will be unbanned, unix time. If user is banned for
    /// more than 366 days or less than 30 seconds from the current time they
    /// are considered to be banned forever unbanChatMember <br/>
    /// </param>
    /// <param name="RevokeMessages">
    /// Pass True to delete all messages from the chat for the user that is
    /// being removed. If False, the user will be able to see messages in the
    /// group that were sent before the user was removed. Always True for
    /// supergroups and channels. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <remarks>
    /// Note: In regular groups (non-supergroups), this method will only work
    /// if the ‘All Members Are Admins’ setting is off in the target group.
    /// Otherwise members may only be removed by the group's creator or by
    /// the member that added them. <br/>
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
    /// to join via link, etc.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the group for this to work. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#unbanchatmember" />
    function UnbanChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64;
      const OnlyIfBanned:	Boolean): Boolean;
    /// <summary>
    /// Use this method for your bot to leave a group, supergroup or channel. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#leavechat" />
    function LeaveChat(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to get up to date information about the chat (current
    /// name of the user for one-on-one conversations, current username of a
    /// user, group or channel, etc.) <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup or channel (in the format @channelusername) <br/>
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|TtdChat">Chat</see> object on
    /// success.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchat" />
    function GetChat(const ChatId: TtdUserLink): ItdChat;
    /// <summary>
    /// Use this method to get a list of administrators in a chat.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup or channel (in the format @channelusername). <br/>
    /// </param>
    /// <returns>
    /// On success, returns an Array of <see cref="TInjectTelegram.Types|TtdChatMember">
    /// ChatMember</see> objects that contains information about all chat
    /// administrators except other bots. If the chat is a group or a
    /// supergroup and no administrators were appointed, only the creator
    /// will be returned.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchatadministrators" />
    function GetChatAdministrators(const ChatId: TtdUserLink): TArray<ItdChatMember>;
    /// <summary>
    /// Use this method to get the number of members in a chat. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup or channel (in the format @channelusername) <br/>
    /// </param>
    /// <returns>
    /// Returns Int64 on success. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchatmemberscount" />
    function GetChatMemberCount(const ChatId: TtdUserLink): Int64;
    /// <summary>
    /// Use this method to get information about a member of a chat.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target group or username of the target
    /// supergroup (in the format @supergroupusername) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user <br/>
    /// </param>
    /// <returns>
    /// Returns a <see cref="TInjectTelegram.Types|TtdChatMember">ChatMember</see>
    /// object on success. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getchatmember" />
    function GetChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64): ItdChatMember;
    /// <summary>
    /// Use this method to send answers to callback queries sent from inline
    /// keyboards. The answer will be displayed to the user as a notification
    /// at the top of the chat screen or as an alert.<br/>
    /// </summary>
    /// <param name="CallbackQueryId">
    /// Unique identifier for the query to be answered <br/>
    /// </param>
    /// <param name="Text">
    /// Text of the notification. If not specified, nothing will be shown to
    /// the user <br/>
    /// </param>
    /// <param name="ShowAlert">
    /// If true, an alert will be shown by the client instead of a
    /// notification at the top of the chat screen. Defaults to false. <br/>
    /// </param>
    /// <returns>
    /// On success, True is returned. <br/>
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
    ///  about bot commands.<br/>
    /// </summary>
    /// <param name="commands" type="Array of BotCommand" require="YES">
    /// A JSON-serialized list of bot commands to be set as the list of the
    /// bot's commands. At most 100 commands can be specified. <br/>
    /// </param>
    /// <param name="scope" type="TtdBotCommandScope" require="OPTIONAL">
    /// A JSON-serialized object, describing scope of users for which the
    /// commands are relevant. Defaults to BotCommandScopeDefault. <br/>
    /// </param>
    /// <param name="language_code" type="String" require="OPTIONAL">
    /// A two-letter ISO 639-1 language code. If empty, commands will be applied
    /// to all users from the given scope, for whose language there are no
    /// dedicated commands. <br/>
    /// </param>
    /// <returns>
    /// On success, True is returned. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#setmycommands" />
    function SetMyCommands(
        const Command: TArray<TtdBotCommand>;
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''): Boolean;
    /// <summary>
    ///  getMyCommands
    ///  Use this method to get the current list of the bot's commands.
    ///  Requires no parameters.<br/>
    /// </summary>
    /// <param name="scope" type="TtdBotCommandScope" require="OPTIONAL">
    /// A JSON-serialized object, describing scope of users for which the
    /// commands are relevant. Defaults to BotCommandScopeDefault. <br/>
    /// </param>
    /// <param name="language_code" type="String" require="OPTIONAL">
    /// A two-letter ISO 639-1 language code. If empty, commands will be applied
    /// to all users from the given scope, for whose language there are no
    /// dedicated commands. <br/>
    /// </param>
    /// <returns>
    /// On success, Returns Array of BotCommand.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#getmycommands" />
    function GetMyCommands(
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''): TArray<ItdBotCommand>;
    /// <summary>
    ///  deleteMyCommands
    ///  Use this method to delete the list of the bot's commands for the given
    ///  scope and user language. After deletion, higher level commands will be
    ///  shown to affected users.<br/>
    /// </summary>
    /// <param name="scope" type="TtdBotCommandScope" require="OPTIONAL">
    /// A JSON-serialized object, describing scope of users for which the
    /// commands are relevant. Defaults to BotCommandScopeDefault. <br/>
    /// </param>
    /// <param name="language_code" type="String" require="OPTIONAL">
    /// A two-letter ISO 639-1 language code. If empty, commands will be applied
    /// to all users from the given scope, for whose language there are no
    /// dedicated commands. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success..
    /// </returns>
    function DeleteMyCommands(
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''): Boolean;
    /// <summary>
    ///  LogOut
    ///  Use this method to log out from the cloud Bot API server before
    ///  launching the bot locally. You must log out the bot before running
    ///  it locally, otherwise there is no guarantee that the bot will receive
    ///  updates. After a successful call, you can immediately log in on a local
    ///  server, but will not be able to log in back to the cloud Bot API
    ///  server for 10 minutes. <br/>
    /// </summary>
    /// <returns>
    ///  Returns True on success. Requires no parameters. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#logOut" />
    function LogOut: Boolean;
    /// <summary>
    ///  Close
    ///  Use this method to close the bot instance before moving it from one
    ///  local server to another. You need to delete the webhook before calling
    ///  this method to ensure that the bot isn't launched again after server
    ///  restart. The method will return error 429 in the first 10 minutes after
    ///  the bot is launched. <br/>
    /// </summary>
    /// <returns>
    ///  Returns True on success. Requires no parameters.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#logOut" />
    function Close: Boolean;
{$ENDREGION 'BotCommands'}

{$REGION 'Updating messages'}
    /// <summary>
    /// Use this method to edit text messages sent by the bot or via the bot
    /// (for inline bots).<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Unique identifier of
    /// the sent message <br/>
    /// </param>
    /// <param name="Text">
    /// New text of the message <br/>
    /// </param>
    /// <param name="ParseMode">
    /// Send Markdown or HTML, if you want Telegram apps to show bold,
    /// italic, fixed-width text or inline URLs in your bot's message. <br/>
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Disables link previews for links in this message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br/>
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editmessagetext" />
    function EditMessageText( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    /// <summary>
    /// Use this method to edit text messages sent by the bot or via the bot
    /// (for inline bots).<br/>
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified. Identifier of
    /// the inline message <br/>
    /// </param>
    /// <param name="Text">
    /// New text of the message <br/>
    /// </param>
    /// <param name="ParseMode">
    /// Send Markdown or HTML, if you want Telegram apps to show bold,
    /// italic, fixed-width text or inline URLs in your bot's message. <br/>
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Disables link previews for links in this message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br/>
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editmessagetext" />
    function EditMessageText( //
      const InlineMessageId: string; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    /// <summary>
    /// Use this method to edit captions of messages sent by the bot or via
    /// the bot (for inline bots).<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Unique identifier of <br />
    /// the sent message <br/>
    /// </param>
    /// <param name="Caption">
    /// New caption of the message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br/>
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editmessagereplymarkup" />
    function EditMessageCaption( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    /// <summary>
    /// Use this method to edit captions of messages sent by the bot or via
    /// the bot (for inline bots).<br/>
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of the
    /// inline message <br/>
    /// </param>
    /// <param name="Caption">
    /// New caption of the message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br/>
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.<br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editmessagereplymarkup" />
    function EditMessageCaption( //
      const InlineMessageId: string; //
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function EditMessageMedia(
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Media: TtdInputMedia; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;

    function EditMessageMedia(
      const InlineMessageId: string; //
      const Media: TtdInputMedia; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;

    /// <summary>
    /// Use this method to edit live location messages sent by the bot or via
    /// the bot (for inline bots). A location can be edited until its
    /// live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Identifier of the
    /// sent message <br/>
    /// </param>
    /// <param name="Location">
    /// new location
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard. <br/>
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
    /// stopMessageLiveLocation. <br/>
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified.
    /// Identifier of the inline message sent message  <br/>
    /// </param>
    /// <param name="Location">
    /// new location
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard. <br/>
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
    /// bot or via the bot (for inline bots) before live_period expires. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// equired if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)<br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if inline_message_id is not specified. Identifier of the
    /// sent message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard. <br/>
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
    /// bot or via the bot (for inline bots) before live_period expires. <br/>
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if chat_id and message_id are not specified.
    /// Identifier of the inline message sent message  <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for a new inline keyboard. <br/>
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
    /// bot or via the bot (for inline bots). <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for <br />
    /// the target chat or username of the target channel (in the format <br />
    /// @channelusername) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Unique identifier of <br />
    /// the sent message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br/>
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
    /// bot or via the bot (for inline bots).<br/>
    /// </summary>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of <br/>
    /// the inline message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. <br/>
    /// </param>
    /// <returns>
    /// On success, if edited message is sent by the bot, the edited Message
    /// is returned, otherwise True is returned.
    /// </returns>
    function EditMessageReplyMarkup( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    /// <summary>
    /// Use this method to delete a message. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Identifier of the message to delete <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <remarks>
    /// A message can only be deleted if it was sent less than 48 hours ago.
    /// Any such recently sent outgoing message may be deleted. Additionally,
    /// if the bot is an administrator in a group chat, it can delete any
    /// message. If the bot is an administrator in a supergroup, it can
    /// delete messages from any other user and service messages about people
    /// joining or leaving the group (other types of service messages may
    /// only be removed by the group creator). In channels, bots can only
    /// remove their own messages. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#deletemessage" />
    function DeleteMessage( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64): Boolean;
    /// <summary>
    ///  CopyMessage
    /// Use this method to copy messages of any kind. The method is analogous
    /// to the method forwardMessages, but the copied message doesn't have a
    /// link to the original message.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <param name="FromChatId">
    /// Unique identifier for the chat where the original message was sent
    /// (or channel username in the format @channelusername) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Message identifier in the chat specified in from_chat_id <br/>
    /// </param>
    /// <param name="Caption">
    /// New caption for media, 0-1024 characters after entities parsing.
    /// If not specified, the original caption is kept <br/>
    /// </param>
    /// <param name="ParseMode">
    /// Modo para analisar entidades no texto da mensagem. Veja as opções de
    /// formatação para mais detalhes. <br/>
    /// </param>
    /// <param name="DisableWebPagePreview">
    /// Desativa visualizações de link para links nesta mensagem  <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Envia a mensagem silenciosamente . Os usuários receberão uma notificação
    /// sem som. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// Se a mensagem for uma resposta, o ID da mensagem original <br/>
    /// </param>
    /// <param name="AllowSendingWithoutReply">
    /// Pass True, if the message should be sent even if the specified
    /// replied-to message is not found <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// InlineKeyboardMarkup or ReplyKeyboardMarkup or ReplyKeyboardHide or
    /// ForceReply. Opções de interface adicionais. Um objeto serializado JSON
    /// para um teclado embutido , teclado de resposta personalizado , instruções
    /// para remover o teclado de resposta ou forçar uma resposta do usuário. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): Int64;
{$ENDREGION}

{$REGION 'ChatInviteLink'}
    /// <summary>
    /// Use this method to create an additional invite link for a chat.
    /// The bot must be an administrator in the chat for this to work and must
    /// have the appropriate administrator rights. The link can be revoked using
    /// the method revokeChatInviteLink.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target channel
    /// (in the format @channelusername) <br/>
    /// </param>
    /// <param name="name">
    /// Invite link name; 0-32 characters <br/>
    /// </param>
    /// <param name="expire_date">
    /// Point in time (Unix timestamp) when the link will expire <br/>
    /// </param>
    /// <param name="member_limit">
    /// Maximum number of users that can be members of the chat simultaneously
    /// after joining the chat via this invite link; 1-99999. <br/>
    /// </param>
    /// <param name="creates_join_request">
    /// True, if users joining the chat via the link need to be approved by chat
    /// administrators. If True, member_limit can't be specified <br/>
    /// </param>
    /// <returns>
    /// Returns the new invite link as ChatInviteLink object.. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#createchatinvitelink" />
    function createChatInviteLink( //
      const ChatId: TtdUserLink; //
      const name: String;  //Invite link name; 0-32 characters
      const expire_date: TDateTime;
      const member_limit: Integer = 0;
      const creates_join_request: boolean = false): ItdChatInviteLink;
    /// <summary>
    /// Use this method to edit a non-primary invite link created by the bot.
    /// The bot must be an administrator in the chat for this to work and must
    /// have the appropriate administrator rights.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target channel
    /// (in the format @channelusername) <br/>
    /// </param>
    /// <param name="expire_date">
    /// Point in time (Unix timestamp) when the link will expire <br/>
    /// </param>
    /// <param name="invite_link">
    /// The invite link to edit. <br/>
    /// </param>
    /// <param name="name">
    /// Invite link name; 0-32 characters <br/>
    /// </param>
    /// <param name="member_limit">
    /// Maximum number of users that can be members of the chat simultaneously
    /// after joining the chat via this invite link; 1-99999. <br/>
    /// </param>
    /// <param name="creates_join_request">
    /// True, if users joining the chat via the link need to be approved by chat
    /// administrators. If True, member_limit can't be specified <br/>
    /// </param>
    /// <returns>
    /// Returns the edited invite link as a ChatInviteLink object. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#editchatinvitelink" />
    function editChatInviteLink( //
      const ChatId: TtdUserLink; //
      const expire_date: TDateTime;
      const invite_link: String = '';
      const name: String = '';  //Invite link name; 0-32 characters
      const member_limit: Integer = 0;
      const creates_join_request: boolean = false): ItdChatInviteLink;
    /// <summary>
    /// Use this method to revoke an invite link created by the bot.
    /// If the primary link is revoked, a new link is automatically generated.
    /// The bot must be an administrator in the chat for this to work and must
    /// have the appropriate administrator rights.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target channel
    /// (in the format @channelusername) <br/>
    /// </param>
    /// <param name="invite_link">
    /// The invite link to edit. <br/>
    /// </param>
    /// <returns>
    /// Returns the revoked invite link as ChatInviteLink object. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#revokechatinvitelink" />
    function revokeChatInviteLink( //
      const ChatId: TtdUserLink; //
      const invite_link: String = ''): ItdChatInviteLink;
    /// <summary>
    /// Use this method to approve a chat join request.
    /// The bot must be an administrator in the chat for this to work and must
    /// have the can_invite_users administrator right.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target channel
    /// (in the format @channelusername) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#approvechatjoinrequest" />
    function approveChatJoinRequest(
      const ChatId: TtdUserLink; //
      const UserId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to decline a chat join request.
    /// The bot must be an administrator in the chat for this to work and must
    /// have the can_invite_users administrator right.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target channel
    /// (in the format @channelusername) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#declinechatjoinrequest" />
    function declineChatJoinRequest(
      const ChatId: TtdUserLink; //
      const UserId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to generate a new primary invite link for a chat;
    /// any previously generated primary link is revoked. The bot must be an
    /// administrator in the chat for this to work and must have the appropriate
    /// administrator rights.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target channel
    /// (in the format @channelusername) <br/>
    /// </param>
    /// <returns>
    /// Returns the new invite link as String on success. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#exportchatinvitelink" />
    function ExportChatInviteLink(const ChatId: TtdUserLink): string;
{$ENDREGION 'ChatInviteLink'}

{$REGION 'Inline mode'}
    /// <summary>
    /// Use this method to send answers to an inline query.<br/>
    /// </summary>
    /// <param name="InlineQueryId">
    /// Unique identifier for the answered query <br/>
    /// </param>
    /// <param name="Results">
    /// A JSON-serialized array of results for the inline query <br/>
    /// </param>
    /// <param name="CacheTime">
    /// The maximum amount of time in seconds that the result of the inline
    /// query may be cached on the server. Defaults to 300. <br/>
    /// </param>
    /// <param name="IsPersonal">
    /// Pass True, if results may be cached on the server side only for the user
    /// that sent the query. By default, results may be returned to any user who
    /// sends the same query <br/>
    /// </param>
    /// <param name="NextOffset">
    /// Pass the offset that a client should send in the next query with the same
    /// text to receive more results. Pass an empty string if there are no more
    /// results or if you don't support pagination.
    /// Offset length can't exceed 64 bytes. <br/>
    /// </param>
    /// <param name="SwitchPmText">
    /// If passed, clients will display a button with specified text that switches
    /// the user to a private chat with the bot and sends the bot a start message
    /// with the parameter switch_pm_parameter <br/>
    /// </param>
    /// <param name="SwitchPmParameter">
    /// Deep-linking parameter for the /start message sent to the bot when user
    /// presses the switch button. 1-64 characters, only A-Z, a-z, 0-9, _ and - are
    /// allowed. <br/>
    /// <b>Example:</b> <br/>
    /// An inline bot that sends YouTube videos can ask the user to connect the
    /// bot to their YouTube account to adapt search results accordingly.
    /// To do this, it displays a 'Connect your YouTube account' button above the
    /// results, or even before showing any. The user presses the button, switches
    /// to a private chat with the bot and, in doing so, passes a start parameter
    /// that instructs the bot to return an OAuth link. Once done, the bot can
    /// offer a switch_inline button so that the user can easily return to the
    /// chat where they wanted to use the bot's inline capabilities. <br/>
    /// </param>
    /// <returns>
    /// On success, True is returned. No more than 50 results per query are allowed. <br/>
    /// </returns>
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
    /// Use this method to send invoices.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target private chat <br/>
    /// </param>
    /// <param name="Title">
    /// Product name<br/>
    /// </param>
    /// <param name="Description">
    /// Product description<br/>
    /// </param>
    /// <param name="Payload">
    /// Bot-defined invoice payload, 1-128 bytes. This will not be displayed
    /// to the user, use for your internal processes. <br/>
    /// </param>
    /// <param name="ProviderToken">
    /// Payments provider token, obtained via Botfather <br/>
    /// </param>
    /// <param name="StartParameter">
    /// Unique deep-linking parameter that can be used to generate this
    /// invoice when used as a start parameter<br/>
    /// </param>
    /// <param name="Currency">
    /// Three-letter ISO 4217 currency code, see more on currencies <br/>
    /// </param>
    /// <param name="Prices">
    /// Price breakdown, a list of components (e.g. product price, tax,
    /// discount, delivery cost, delivery tax, bonus, etc.) <br/>
    /// </param>
    /// <param name="max_tip_amount">
    ///   Optional. The maximum accepted amount for tips in
    ///   the smallest units of the currency (integer, not
    ///   float/double). For example, for a maximum tip of
    ///   US$ 1.45 pass max_tip_amount = 145. See the exp
    ///   parameter in currencies.json, it shows the number
    ///   of digits past the decimal point for each currency
    ///   (2 for the majority of currencies). Defaults to 0 <br/>
    /// </param>
    /// <param name="suggested_tip_amounts">
    ///   Optional. A JSON-serialized array of suggested
    ///   amounts of tip in the smallest units of the
    ///   currency (integer, not float/double). At most 4
    ///   suggested tip amounts can be specified. The
    ///   suggested tip amounts must be positive, passed in
    ///   a strictly increased order and must not exceed
    ///   max_tip_amount.<br/>
    /// </param>
    /// <param name="PhotoUrl">
    /// URL of the product photo for the invoice. Can be a photo of the goods
    /// or a marketing image for a service.<br/>
    /// </param>
    /// <param name="PhotoSize">
    /// Photo size <br/>
    /// </param>
    /// <param name="PhotoWidth">
    /// Photo width <br/>
    /// </param>
    /// <param name="PhotoHeight">
    /// Photo height<br/>
    /// </param>
    /// <param name="NeedName">
    /// Pass True, if you require the user's full name to complete the order <br/>
    /// </param>
    /// <param name="NeedPhoneNumber">
    /// Pass True, if you require the user's phone number to complete the
    /// order <br/>
    /// </param>
    /// <param name="NeedEmail">
    /// Pass True, if you require the user's email to complete the order <br/>
    /// </param>
    /// <param name="NeedShippingAddress">
    /// Pass True, if you require the user's shipping address to complete the
    /// order  <br/>
    /// </param>
    /// <param name="IsFlexible">
    /// Pass True, if the final price depends on the shipping method <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound.<br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for a custom
    /// reply keyboard, instructions to hide keyboard or to force a reply
    /// from the user. <br/>
    /// </param>
    /// <returns>
    /// On success, the sent <see cref="TInjectTelegram.Types|ItdMessage" /> is
    /// returned. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#sendinvoice" />
    function SendInvoice( //
      const ChatId: Int64; //
      const Title: string; //
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// If you sent an invoice requesting a shipping address and the
    /// parameter is_flexible was specified, the Bot API will send an Update
    /// with a shipping_query field to the bot. Use this method to reply to
    /// shipping queries. On success, True is returned.<br/>
    /// </summary>
    /// <param name="ShippingQueryId">
    /// Unique identifier for the query to be answered <br/>
    /// </param>
    /// <param name="ShippingOptions">
    /// Required if <c>ok</c> is <c>True</c>. A JSON-serialized array of
    /// available shipping options.<br/>
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains why it is impossible to complete the
    /// order (e.g. "Sorry, delivery to your desired address is
    /// unavailable'). Telegram will display this message to the user.<br/>
    /// </param>
    /// <seealso href="https://core.telegram.org/bots/api#answershippingquery" />
    function AnswerShippingQueryGood( //
      const ShippingQueryId: string; //
      const ShippingOptions: TArray<TtdShippingOption>): Boolean;
    /// <summary>
    /// Once the user has confirmed their payment and shipping details, the
    /// Bot API sends the final confirmation in the form of an <see cref="TInjectTelegram.Types|TtdUpdate">
    /// Update</see> with the field PreCheckoutQueryId. Use this method to
    /// respond to such pre-checkout queries.<br/>
    /// </summary>
    /// <param name="PreCheckoutQueryId">
    /// Unique identifier for the query to be answered   <br/>
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains the reason for failure to proceed with
    /// the checkout (e.g. "Sorry, somebody just bought the last of our
    /// amazing black T-shirts while you were busy filling out your payment
    /// details. Please choose a different color or garment!"). Telegram will
    /// display this message to the user. <br/>
    /// </param>
    /// <returns>
    /// On success, True is returned. <br/>
    /// </returns>
    /// <remarks>
    /// <b>Note</b>: The Bot API must receive an answer within 10 seconds
    /// after the pre-checkout query was sent. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#answerprecheckoutquery" />
    function AnswerShippingQueryBad( //
      const ShippingQueryId: string; //
      const ErrorMessage: string): Boolean;
    /// <summary>
    /// Once the user has confirmed their payment and shipping details, the
    /// Bot API sends the final confirmation in the form of an <see cref="TInjectTelegram.Types|TtdUpdate">
    /// Update</see> with the field PreCheckoutQueryId. Use this method to
    /// respond to such pre-checkout queries.<br/>
    /// </summary>
    /// <param name="PreCheckoutQueryId">
    /// Unique identifier for the query to be answered <br/>
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains the reason for failure to proceed with
    /// the checkout (e.g. "Sorry, somebody just bought the last of our
    /// amazing black T-shirts while you were busy filling out your payment
    /// details. Please choose a different color or garment!"). Telegram will
    /// display this message to the user. <br/>
    /// </param>
    /// <returns>
    /// On success, True is returned. <br/>
    /// </returns>
    /// <remarks>
    /// <b>Note</b>: The Bot API must receive an answer within 10 seconds
    /// after the pre-checkout query was sent. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#answerprecheckoutquery" />
    function AnswerPreCheckoutQueryGood( //
      const PreCheckoutQueryId: string): Boolean;
    /// <summary>
    /// Once the user has confirmed their payment and shipping details, the
    /// Bot API sends the final confirmation in the form of an <see cref="TInjectTelegram.Types|TtdUpdate">
    /// Update</see> with the field PreCheckoutQueryId. Use this method to
    /// respond to such pre-checkout queries. <br/>
    /// </summary>
    /// <param name="PreCheckoutQueryId">
    /// Unique identifier for the query to be answered<br/>
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains the reason for failure to proceed with
    /// the checkout (e.g. "Sorry, somebody just bought the last of our
    /// amazing black T-shirts while you were busy filling out your payment
    /// details. Please choose a different color or garment!"). Telegram will
    /// display this message to the user.<br/>
    /// </param>
    /// <returns>
    /// On success, True is returned. <br/>
    /// </returns>
    /// <remarks>
    /// <b>Note</b>: The Bot API must receive an answer within 10 seconds
    /// after the pre-checkout query was sent. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#answerprecheckoutquery" />
    function AnswerPreCheckoutQueryBad( //
      const PreCheckoutQueryId: string; //
      const ErrorMessage: string): Boolean;
    /// <summary>
    /// Once the user has confirmed their payment and shipping details, the
    /// Bot API sends the final confirmation in the form of an <see cref="TInjectTelegram.Types|TtdUpdate">
    /// Update</see> with the field PreCheckoutQueryId. Use this method to
    /// respond to such pre-checkout queries. <br/>
    /// </summary>
    /// <param name="PreCheckoutQueryId">
    /// Unique identifier for the query to be answered <br/>
    /// </param>
    /// <param name="Ok">
    /// Specify <c>True</c> if everything is alright (goods are available,
    /// etc.) and the bot is ready to proceed with the order. Use False if
    /// there are any problems.<br/>
    /// </param>
    /// <param name="ErrorMessage">
    /// Required if <c>ok</c> is <c>False</c>. Error message in human
    /// readable form that explains the reason for failure to proceed with
    /// the checkout (e.g. "Sorry, somebody just bought the last of our
    /// amazing black T-shirts while you were busy filling out your payment
    /// details. Please choose a different color or garment!"). Telegram will
    /// display this message to the user.<br/>
    /// </param>
    /// <returns>
    /// On success, True is returned.<br/>
    /// </returns>
    /// <remarks>
    /// <b>Note</b>: The Bot API must receive an answer within 10 seconds
    /// after the pre-checkout query was sent.<br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#answerprecheckoutquery" />
    function AnswerPreCheckoutQuery( //
      const PreCheckoutQueryId: string; //
      const OK: Boolean;
      const ErrorMessage: string = ''): Boolean;
{$ENDREGION}

{$REGION 'Telegram Passport'}
    /// <summary>
    /// Informs a user that some of the Telegram Passport elements they provided
    /// contains errors. The user will not be able to re-submit their Passport to
    /// you until the errors are fixed (the contents of the field for which you
    /// returned the error must change).<br/>
    /// Use this if the data submitted by the user doesn't satisfy the standards
    /// your service requires for any reason. For example, if a birthday date
    /// seems invalid, a submitted document is blurry, a scan shows evidence of
    /// tampering, etc. Supply some details in the error message to make sure the
    /// user knows how to correct the issues. <br/>
    /// </summary>
    /// <param name="UserId">
    /// User identifier <br/>
    /// </param>
    /// <param name="Errors">
    /// A JSON-serialized array describing the errors. <br/>
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
    /// Use this method to send a game. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat <br/>
    /// </param>
    /// <param name="GameShortName">
    /// Short name of the game, serves as the unique identifier for the game.
    /// Set up your games via Botfather. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// A JSON-serialized object for an inline keyboard. If empty, one ‘Play
    /// game_title’ button will be shown. If not empty, the first button must
    /// launch the game. <br/>
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;
    /// <summary>
    /// Use this method to set the score of the specified user in a game.<br/>
    /// </summary>
    /// <param name="UserId">
    /// User identifier <br/>
    /// </param>
    /// <param name="Score">
    /// New score, must be non-negative <br/>
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of the
    /// inline message <br/>
    /// </param>
    /// <param name="Force">
    /// Pass True, if the high score is allowed to decrease. This can be
    /// useful when fixing mistakes or banning cheaters <br/>
    /// </param>
    /// <returns>
    /// On success, if the message was sent by the bot, returns the edited
    /// Message, otherwise returns True. Returns an error, if the new score
    /// is not greater than the user's current score in the chat and force is
    /// False. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#setgamescore" />
    function SetGameScore( //
      const UserId: Int64; //
      const Score: Int64; //
      const InlineMessageId: string; //
      const Force: Boolean = False; //
      const DisableEditMessage: Boolean = False): ItdMessage; overload;
    /// <summary>
    /// Use this method to set the score of the specified user in a game. <br/>
    /// </summary>
    /// <param name="UserId">
    /// User identifier <br/>
    /// </param>
    /// <param name="Score">
    /// New score, must be non-negative <br/>
    /// </param>
    /// <param name="DisableEditMessage">
    /// Pass True, if the game message should not be automatically edited to
    /// include the current scoreboard <br/>
    /// </param>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for <br/>
    /// the target chat <br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Identifier of the <br/>
    /// sent message <br/>
    /// </param>
    /// <param name="Force">
    /// Pass True, if the high score is allowed to decrease. This can be
    /// useful when fixing mistakes or banning cheaters <br/>
    /// </param>
    /// <returns>
    /// On success, if the message was sent by the bot, returns the edited
    /// Message, otherwise returns True. Returns an error, if the new score
    /// is not greater than the user's current score in the chat and force is
    /// False. <br/>
    /// </returns>
    /// <seealso href="https://core.telegram.org/bots/api#setgamescore" />
    function SetGameScore( //
      const UserId: Int64; //
      const Score: Int64; //
      const ChatId: Int64; //
      const MessageId: Int64; //
      const Force: Boolean = False; //
      const DisableEditMessage: Boolean = False): ItdMessage; overload;
    /// <summary>
    /// Use this method to get data for high score tables. Will return the
    /// score of the specified user and several of his neighbors in a game. <br/>
    /// </summary>
    /// <param name="UserId">
    /// Target user id <br/>
    /// </param>
    /// <param name="InlineMessageId">
    /// Required if ChatId and MessageId are not specified. Identifier of <br />
    /// the inline message <br/>
    /// </param>
    /// <returns>
    /// On success, returns an Array of <see cref="TInjectTelegram.Types|TtdGameHighScore">
    /// GameHighScore</see> objects. <br/>
    /// </returns>
    /// <remarks>
    /// This method will currently return scores for the target user, plus
    /// two of his closest neighbors on each side. Will also return the top
    /// three users if the user and his neighbors are not among them. Please
    /// note that this behavior is subject to change. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#getgamehighscores">
    /// Official API
    /// </seealso>
    function GetGameHighScores( //
      const UserId: Int64; //
      const InlineMessageId: string = ''): TArray<ItdGameHighScore>; overload;
    /// <summary>
    /// Use this method to get data for high score tables. Will return the
    /// score of the specified user and several of his neighbors in a game. <br/>
    /// </summary>
    /// <param name="UserId">
    /// Target user id <br/>
    /// </param>
    /// <param name="ChatId">
    /// Required if InlineMessageId is not specified. Unique identifier for <br/>
    /// the target chat <br/>
    /// </param>
    /// <param name="MessageId">
    /// Required if InlineMessageId is not specified. Identifier of the <br/>
    /// sent message <br/>
    /// </param>
    /// <returns>
    /// On success, returns an Array of <see cref="TInjectTelegram.Types|TtdGameHighScore">
    /// GameHighScore</see> objects. <br/>
    /// </returns>
    /// <remarks>
    /// This method will currently return scores for the target user, plus
    /// two of his closest neighbors on each side. Will also return the top
    /// three users if the user and his neighbors are not among them. Please
    /// note that this behavior is subject to change. <br/>
    /// </remarks>
    /// <seealso href="https://core.telegram.org/bots/api#getgamehighscores">
    /// Official API
    /// </seealso>
    function GetGameHighScores( //
      const UserId: Int64; //
      const ChatId: Int64 = 0; //
      const MessageId: Int64 = 0): TArray<ItdGameHighScore>; overload;
{$ENDREGION}

{$REGION 'Manage groups and channels'}
    /// <summary>
    /// Use this method to delete a chat photo. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>) <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <remarks>
    /// Photos can't be changed for private chats. The bot must be an
    /// administrator in the chat for this to work and must have the
    /// appropriate admin rights.
    /// </remarks>
    function DeleteChatPhoto(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to pin a message in a supergroup. The bot must be an
    /// administrator in the chat for this to work and must have the
    /// appropriate admin rights.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <param name="MessageId">
    /// Identifier of a message to pin <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Pass True, if it is not necessary to send a notification to all group
    /// members about the new pinned message  <br/>
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
    /// work and must have the appropriate admin rights. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>) <br/>
    /// </param>
    /// <param name="Description">
    /// New chat description, 0-255 characters <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function SetChatDescription(const ChatId: TtdUserLink; const Description:
      string): Boolean;
    /// <summary>
    /// Use this method to set a new profile photo for the chat. Photos can't
    /// be changed for private chats. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>) <br/>
    /// </param>
    /// <param name="Photo">
    /// New chat photo, uploaded using multipart/form-data  <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the chat for this to work and
    /// must have the appropriate admin rights.
    /// </remarks>
    function SetChatPhoto(const ChatId: TtdUserLink; const Photo: TtdFileToSend): Boolean;
    /// <summary>
    /// Use this method to change the title of a chat. Titles can't be
    /// changed for private chats. The bot must be an administrator in the
    /// chat for this to work and must have the appropriate admin rights. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format <c>@channelusername</c>) <br/>
    /// </param>
    /// <param name="Title">
    /// New chat title, 1-255 characters <br/>
    /// </param>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>
    /// <remarks>
    /// Note: In regular groups (non-supergroups), this method will only work
    /// if the ‘All Members Are Admins’ setting is off in the target group.
    /// </remarks>
    function SetChatTitle(const ChatId: TtdUserLink; const Title: string): Boolean;
    /// <summary>
    /// Use this method to unpin a message in a supergroup chat. The bot must
    /// be an administrator in the chat for this to work and must have the
    /// appropriate admin rights.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>)<br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function UnPinChatMessage(const ChatId: TtdUserLink; //
      const MessageId: Int64 = 0 ): Boolean;
    /// <summary>
    /// Use this method to clear the list of pinned messages in a chat.
    /// If the chat is not a private chat, the bot must be an administrator in
    /// the chat for this to work and must have the 'can_pin_messages' admin
    /// right in a supergroup or 'can_edit_messages' admin right in a channel.. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function UnPinAllChatMessages(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    /// banChatSenderChat
    /// Use this method to ban a channel chat in a supergroup or a channel. Until
    /// the chat is unbanned, the owner of the banned chat won't be able to send
    /// messages on behalf of any of their channels. The bot must be an administrator
    /// in the supergroup or channel for this to work and must have the appropriate
    /// administrator rights. <br/>
    /// to the method forwardMessages, but the copied message doesn't have a
    /// link to the original message. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <param name="SenderChatId">
    /// Unique identifier of the target sender chat <br/>
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
    /// administrator rights.<br/>
    /// to the method forwardMessages, but the copied message doesn't have a
    /// link to the original message.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <param name="SenderChatId">
    /// Unique identifier of the target sender chat <br/>
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
    /// lift restrictions from a user. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user  <br/>
    /// </param>
    /// <param name="UntilDate">
    /// Date when restrictions will be lifted for the user, unix time. If
    /// user is restricted for more than 366 days or less than 30 seconds
    /// from the current time, they are considered to be restricted forever <br/>
    /// </param>
    /// <param name="CanSendMessages">
    /// Pass True, if the user can send text messages, contacts, locations
    /// and venues  <br/>
    /// </param>
    /// <param name="CanSendMediaMessages">
    /// Pass True, if the user can send audios, documents, photos, videos,
    /// video notes and voice notes, implies CanSendMessages <br/>
    /// </param>
    /// <param name="CanSendOtherMessages">
    /// Pass True, if the user can send animations, games, stickers and use
    /// inline bots, implies CanSendMediaMessages <br/>
    /// </param>
    /// <param name="CanAddWebPagePreviews">
    /// Pass True, if the user may add web page previews to their messages,
    /// implies CanSendMediaMessages <br/>
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
    /// lift restrictions from a user.<br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// supergroup (in the format <c>@supergroupusername</c>) <br/>
    /// </param>
    /// <param name="UserId">
    /// Unique identifier of the target user  <br/>
    /// </param>
    /// <param name="IsAnonymous">
    ///  Optional
    /// Pass True, if the administrator's presence in the chat is hidden <br/>
    /// </param>
    /// <param name="CanChangeInfo">
    /// Pass True, if the administrator can change chat title, photo and
    /// other settings <br/>
    /// </param>
    /// <param name="CanPostMessages">
    /// Pass True, if the administrator can create channel posts, channels
    /// only <br/>
    /// </param>
    /// <param name="CanEditMessages">
    /// Pass True, if the administrator can edit messages of other users,
    /// channels only <br/>
    /// </param>
    /// <param name="CanDeleteMessages">
    /// Pass True, if the administrator can delete messages of other users <br/>
    /// </param>
    /// <param name="CanInviteUsers">
    /// Pass True, if the administrator can invite new users to the chat <br/>
    /// </param>
    /// <param name="CanRestrictMembers">
    /// Pass True, if the administrator can restrict, ban or unban chat
    /// members <br/>
    /// </param>
    /// <param name="CanPinMessages">
    /// Pass True, if the administrator can pin messages, supergroups only <br/>
    /// </param>
    /// <param name="CanPromoteMembers">
    /// Pass True, if the administrator can add new administrators with a
    /// subset of his own privileges or demote administrators that he has
    /// promoted, directly or indirectly (promoted by administrators that
    /// were appointed by him)  <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function PromoteChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const IsAnonymous: Boolean = False;
      const CanManageChat: Boolean = False;
      const CanPostMessages: Boolean = False; //
      const CanEditMessages: Boolean = False; //
      const CanDeleteMessages: Boolean = False; //
      const CanManageVideoChats: Boolean = False;
      const CanRestrictMembers: Boolean = False; //
      const CanPromoteMembers: Boolean = False;
      const CanChangeInfo: Boolean = False; //
      const CanInviteUsers: Boolean = False; //
      const CanPinMessages: Boolean = False): Boolean;
{$ENDREGION}

{$REGION 'Strickers'}
    /// <summary>
    /// Use this method to send .webp stickers. <br/>
    /// </summary>
    /// <param name="ChatId">
    /// Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername) <br/>
    /// </param>
    /// <param name="Sticker">
    /// Sticker to send. You can either pass a file_id as String to resend a
    /// sticker that is already on the Telegram servers, or upload a new
    /// sticker using multipart/form-data. <br/>
    /// </param>
    /// <param name="DisableNotification">
    /// Sends the message silently. iOS users will not receive a
    /// notification, Android users will receive a notification with no
    /// sound. <br/>
    /// </param>
    /// <param name="ReplyToMessageId">
    /// If the message is a reply, ID of the original message <br/>
    /// </param>
    /// <param name="ReplyMarkup">
    /// Additional interface options. A JSON-serialized object for an inline
    /// keyboard, custom reply keyboard, instructions to hide reply keyboard
    /// or to force a reply from the user. <br/>
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
    /// Use this method to get a sticker set.<br/>
    /// </summary>
    /// <param name="name">
    /// Name of the sticker set.<br/>
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
    /// addStickerToSet</see> methods (can be used multiple times). <br/>
    /// </summary>
    /// <param name="UserId">
    /// User identifier of sticker file owner <br/>
    /// </param>
    /// <param name="PngSticker">
    /// Png image with the sticker, must be up to 512 kilobytes in size,
    /// dimensions must not exceed 512px, and either width or height must be
    /// exactly 512px. <br/>
    /// </param>
    /// <returns>
    /// Returns the uploaded <see cref="TInjectTelegram.Types|TtdFile">File</see> on
    /// success.
    /// </returns>
    function uploadStickerFile(const UserId: Int64; const PngSticker:
      TtdFileToSend): ItdFile;
    /// <summary>
    /// Use this method to create new sticker set owned by a user. The bot
    /// will be able to edit the created sticker set.
    /// </summary>
    /// <param name="UserId">
    /// User identifier of created sticker set owner <br/>
    /// </param>
    /// <param name="Name">
    /// Short name of sticker set, to be used in t.me/addstickers/ URLs
    /// (e.g., animals). Can contain only english letters, digits and
    /// underscores. Must begin with a letter, can't contain consecutive
    /// underscores and must end in by “__&lt;bot username&gt;”.
    /// &lt;bot_username&gt; is case insensitive. 1-64 characters. <br/>
    /// </param>
    /// <param name="Title">
    /// Sticker set title, 1-64 characters <br/>
    /// </param>
    /// <param name="PngSticker">
    /// Png image with the sticker, must be up to 512 kilobytes in size,
    /// dimensions must not exceed 512px, and either width or height must be
    /// exactly 512px. Pass a file_id as a String to send a file that already
    /// exists on the Telegram servers, pass an HTTP URL as a String for
    /// Telegram to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files » <br/>
    /// </param>
    /// <param name="TgsSticker">
    /// TGS animation with the sticker, uploaded using multipart/form-data.
    /// See https://core.telegram.org/animated_stickers#technical-requirements
    /// for technical requirements  »  <br/>
    /// </param>
    /// <param name="Emojis">
    /// One or more emoji corresponding to the sticker <br/>
    /// </param>
    /// <param name="ContainsMasks">
    /// Pass True, if a set of mask stickers should be created <br/>
    /// </param>
    /// <param name="MaskPosition">
    /// A JSON-serialized object for position where the mask should be placed
    /// on faces <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function createNewStickerSet( //
      const UserId: Int64; //
      const Name, Title: string; //
      const PngSticker: TtdFileToSend; //
      const TgsSticker: TtdFileToSend; //
      const Webm_sticker: TtdFileToSend; //
      const Emojis: string; //
      const ContainsMasks: Boolean = False; //
      const MaskPosition: ItdMaskPosition = nil): Boolean;
    /// <summary>
    /// Use this method to add a new sticker to a set created by the bot. <br/>
    /// </summary>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function addStickerToSet( //
      const UserId: Int64; //
      const Name: string; //
      const PngSticker: TtdFileToSend; //
      const TgsSticker: TtdFileToSend; //
      const Webm_sticker: TtdFileToSend; //
      const Emojis: string; //
      const MaskPosition: ItdMaskPosition = nil): Boolean;
    /// <summary>
    /// Use this method to move a sticker in a set created by the bot to a
    /// specific position.<br/>
    /// </summary>
    /// <param name="Sticker">
    /// File identifier of the sticker. <br/>
    /// </param>
    /// <param name="Position">
    /// New sticker position in the set, zero-based. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function setStickerPositionInSet(const Sticker: string; const Position:
      Int64): Boolean;
    /// <summary>
    /// Use this method to delete a sticker from a set created by the bot.<br/>
    /// </summary>
    /// <param name="Sticker">
    /// File identifier of the sticker. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function deleteStickerFromSet(const Sticker: string): Boolean;
    /// <summary>
    /// Use this method to set a new group sticker set for a supergroup. <br/>
    /// </summary>
    /// <returns>
    /// Returns True on success.<br/>
    /// </returns>
    /// <remarks>
    /// The bot must be an administrator in the chat for this to work and
    /// must have the appropriate admin rights. Use the field <see cref="TInjectTelegram.Types|TtdChat.CanSetStickerSet">
    /// CanSetStickerSet</see> optionally returned in <see cref="TInjectTelegram.Bot|TInjectTelegramBot.GetChat(TValue)">
    /// getChat</see> requests to check if the bot can use this method.
    /// </remarks>
    function setChatStickerSet(const ChatId: TtdUserLink; const StickerSetName:
      string): Boolean;
    /// <summary>
    /// Use this method to delete a group sticker set from a supergroup. <br/>
    /// </summary>
    /// <returns>
    /// Returns True on success. <br/>
    /// </returns>

    function deleteChatStickerSet(const ChatId: TtdUserLink): Boolean;
    /// <summary>
    /// Use this method to set the thumbnail of a sticker set.
    /// Animated thumbnails can be set for animated sticker sets only.  <br/>
    /// </summary>
    /// <param name="Name">
    /// Sticker set name <br/>
    /// </param>
    /// <param name="UserId">
    /// User identifier of the sticker set owner  <br/>
    /// </param>
    /// <param name="Thumb">
    /// A PNG image with the thumbnail, must be up to 128 kilobytes in size and
    /// have width and height exactly 100px, or a TGS animation with the thumbnail
    /// up to 32 kilobytes in size; <br/>
    /// see https://core.telegram.org/animated_stickers#technical-requirements
    /// for animated sticker technical requirements. Pass a file_id as a String
    /// to send a file that already exists on the Telegram servers, pass an HTTP
    /// URL as a String for Telegram to get a file from the Internet, or upload
    /// a new one using multipart/form-data. More info on Sending Files ».
    /// Animated sticker set thumbnail can't be uploaded via HTTP URL. <br/>
    /// </param>
    /// <returns>
    /// Returns True on success.
    /// </returns>
    function setStickerSetThumb(
        const Name: string;
        const UserId: Int64;
        const Thumb: string): Boolean;
{$ENDREGION}

{$REGION 'WebApp'}
    function answerWebAppQuery( //
    const web_app_query_id: string = '';
    const AResult: TtdInlineQueryResult = nil): ItdSentWebAppMessage;
    function setChatMenuButton( //
      const chat_id: TtdUserLink;
      const url: String = ''; Text: String = '';
      const ButtonType: TtdMenuButtonType = TtdMenuButtonType.MenuButtonDefault): Boolean;
    function getChatMenuButton( //
      const chat_id: TtdUserLink): ItdMenuButton;
    function setMyDefaultAdministratorRights( //
      const rights: TtdChatAdministratorRights;
      const for_channels: Boolean): Boolean;
    function getMyDefaultAdministratorRights( //
      const for_channels: Boolean): ItdChatAdministratorRights;
{$ENDREGION}

  published
    {$REGION 'Propriedades|Property|Свойства'}
    property Logger;
    property HttpCore;
    property Token: string read GetToken write SetToken;
    property IsBusy;
    {$ENDREGION}
    {$REGION 'Eventos|Events|События'}
    property OnReceiveRawData;
    property OnSendData;
    property OnDisconect;
    {$ENDREGION}
  end;
  TTelegramBotHelper = class helper for TInjectTelegramBot
    function IsValidToken: Boolean;
  end;
implementation
uses
  REST.JSON,
  TInjectTelegram.Helpers;
constructor TInjectTelegramBotBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DoInitApiCore;
end;
procedure TInjectTelegramBotBase.DoInitApiCore;
var
  StrCodeError: String;
begin
  FRequest := TtdCoreApi.Create;
  GetRequest.OnError :=
    procedure(E: Exception)
    begin
      if Assigned(E) then
      Begin
        StrCodeError := Copy(E.ToString, POS('(', E.ToString)+1, 5);
        if (StrCodeError = '12007') or (StrCodeError = '12002') or (StrCodeError = '12030') then
          if Assigned(OnDisconect) then
            OnDisconect(Self, StrCodeError);
      End;
      Logger.Error('TInjectTelegramRequestAPI', E);
    end;
  GetRequest.OnReceive :=
    procedure(AData: string)
    begin
      if Assigned(OnReceiveRawData) then
        OnReceiveRawData(Self, AData);
    end;
  GetRequest.OnSend :=
    procedure(AUrl, AData: string)
    begin
      IsBusy := True;
      if Assigned(OnSendData) then
        OnSendData(Self, AUrl, AData);
    end;
  GetRequest.DataExtractor :=
    function(AInput: string): string
    var
      LJSON: TJSONObject;
      LExcCode: Integer;
      LExcDesc: string;
    begin
      Result := '';
      if AInput.IsEmpty or AInput.StartsWith('<html') then
        Exit;
      LJSON := TJSONObject.ParseJSONValue(AInput) as TJSONObject;
      try
        if LJSON.GetValue('ok') is TJSONFalse then
        begin
          LExcCode := (LJSON.GetValue('error_code') as TJSONNumber).AsInt;
          LExcDesc := (LJSON.GetValue('description') as TJSONString).Value;
          Logger.Error('%d - %S', [LExcCode, LExcDesc]);
        end
        else begin
          Result := LJSON.GetValue('result').ToString;
          IsBusy := False;
        end;
      finally
        LJSON.Free;
      end;
    end;
end;
function TInjectTelegramBotBase.GetArrayFromMethod<TI>(const TdClass: TBaseJsonClass;
  const AValue: string): TArray<TI>;
var
  LJsonArr: TJSONArray;
  I: Integer;
  GUID: TGUID;
  LException: Exception;
begin
  GUID := GetTypeData(TypeInfo(TI))^.GUID;
  // check for TI interface support
  if TdClass.GetInterfaceEntry(GUID) = nil then
  begin
    Logger.Fatal('GetArrayFromMethod: unsupported interface for ' + TdClass.ClassName);
  end;
  // stage 2: proceed data
  LJsonArr := GetJSONArrayFromMethod(AValue);
  if (not Assigned(LJsonArr)) or LJsonArr.Null then
    Exit(nil);
  try
    SetLength(Result, LJsonArr.Count);
    for I := 0 to High(Result) do
      TdClass.GetTdClass.Create(LJsonArr.Items[I].ToString).GetInterface(GUID, Result[I]);
  finally
    LJsonArr.Free;
  end;
end;
function TInjectTelegramBotBase.GetHttpCore: IcuHttpClient;
begin
  Result := GetRequest.HttpCore;
end;
function TInjectTelegramBotBase.GetJSONArrayFromMethod(const AValue: string): TJSONArray;
begin
  Result := TJSONObject.ParseJSONValue(AValue) as TJSONArray;
end;
function TInjectTelegramBotBase.GetLogger: ILogger;
begin
  if csDestroying in ComponentState then
    Exit(nil);
  if FLog = nil then
    FLog := TLogEmpty.Create(nil);
  Result := FLog;
end;
function TInjectTelegramBotBase.GetRequest: ItdRequestAPI;
begin
  Result := FRequest;
end;
function TInjectTelegramBotBase.GetUrlAPI: string;
begin
  Result := GetRequest.UrlAPI;
end;
procedure TInjectTelegramBotBase.SetHttpCore(const Value: IcuHttpClient);
begin
  GetRequest.HttpCore := Value;
end;
procedure TInjectTelegramBotBase.SetLogger(const Value: ILogger);
begin
  FLog := Value;
end;
procedure TInjectTelegramBotBase.SetUrlAPI(const Value: string);
begin
  GetRequest.UrlAPI := Value;
end;
{ TInjectTelegramBot }
{$REGION 'Core'}
procedure TInjectTelegramBot.AssignTo(Dest: TPersistent);
begin
  if not (Assigned(Dest) or (Dest is TInjectTelegramBot)) then
    Exit;
  (Dest as TInjectTelegramBot).Token := Self.Token;
  (Dest as TInjectTelegramBot).HttpCore := Self.HttpCore;
  (Dest as TInjectTelegramBot).Logger := Self.Logger;
  (Dest as TInjectTelegramBot).OnReceiveRawData := Self.OnReceiveRawData;
  (Dest as TInjectTelegramBot).OnSendData := Self.OnSendData;
  (Dest as TInjectTelegramBot).OnDisconect := Self.OnDisconect;
  // inherited AssignTo(Dest);
end;
constructor TInjectTelegramBot.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
constructor TInjectTelegramBot.Create(const AToken: string; ACore: IcuHttpClient);
begin
  inherited Create(nil);
  Token := AToken;
  HttpCore := ACore;
end;
constructor TInjectTelegramBot.Create(const AToken: string);
begin
  inherited Create(nil);
  SetToken(AToken);
end;
function TInjectTelegramBot.GetToken: string;
begin
  Result := FToken;
end;
procedure TInjectTelegramBot.SetToken(const Value: string);
begin
  FToken := Value;
  GetRequest.SetToken(Token);
end;
{$ENDREGION}
{$REGION 'Getting updates'}
function TInjectTelegramBot.SetWebhook(
  const Url: string;
  const Certificate: TtdFileToSend;
  const IpAddress: String;
  const MaxConnections: Int64;
  const AllowedUpdates: TAllowedUpdates;
  const DropPendingUpdates:	Boolean): Boolean;
begin
  Logger.Enter(Self, 'SetWebhook');
  Result := GetRequest.SetMethod('setWebhook') //
    .AddParameter('url', Url, '', True) //
    .AddParameter('certificate', Certificate, nil, False) //
    .AddParameter('ip_address', IpAddress, '', False) //
    .AddParameter('max_connections', MaxConnections, 0, False) //
    .AddParameter('allowed_updates', AllowedUpdates.ToString, '[]', False) //
    .AddParameter('drop_pending_updates', DropPendingUpdates, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetWebhook');
end;
function TInjectTelegramBot.GetWebhookInfo: ItdWebhookInfo;
begin
  Logger.Enter(Self, 'GetWebhookInfo');
  Result := TtdWebhookInfo.Create(GetRequest.SetMethod('getWebhookInfo').Execute);
  Logger.Leave(Self, 'GetWebhookInfo');
end;
function TInjectTelegramBot.GetUpdates(const Offset, Limit, Timeout: Int64; const
  AllowedUpdates: TAllowedUpdates): TArray<ItdUpdate>;
begin
  Result := GetArrayFromMethod<ItdUpdate>(TtdUpdate, GetRequest.SetMethod('getUpdates') //
    .AddParameter('offset', Offset, 0, False) //
    .AddParameter('limit', Limit, 100, False) //
    .AddParameter('timeout', Timeout, 0, False) //
    .AddParameter('allowed_updates', AllowedUpdates.ToString, '[]', False) //
    .Execute);
end;
function TInjectTelegramBot.GetUpdates(const JSON: string): TArray<ItdUpdate>;
begin
  Logger.Enter(Self, 'GetUpdates');
  Result := GetArrayFromMethod<ItdUpdate>(TtdUpdate, JSON);
  Logger.Leave(Self, 'GetUpdates');
end;
function TInjectTelegramBot.DeleteWebhook(const DropPendingUpdates:	Boolean): Boolean;
begin
  Logger.Enter(Self, 'DeleteWebhook');
  Result := GetRequest.SetMethod('deleteWebhook')
  .AddParameter('drop_pending_updates', DropPendingUpdates, False, False) //
  .ExecuteAsBool;
  Logger.Leave(Self, 'DeleteWebhook');
end;
procedure TInjectTelegramBot.DoInitApiCore;
const
  SERVER = 'https://api.telegram.org/bot';
begin
  inherited;
  GetRequest.UrlAPI := SERVER;
end;
function TInjectTelegramBot.createChatInviteLink(const ChatId: TtdUserLink;
  const name: String; const expire_date: TDateTime; const member_limit: Integer;
  const creates_join_request: boolean): ItdChatInviteLink;
begin
  Logger.Enter(Self, 'createChatInviteLink');

  if creates_join_request = false then
  Begin
    Result := TtdChatInviteLink.Create(GetRequest.SetMethod('createChatInviteLink') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('name', name, '', False) //
    .AddParameter('expire_date', expire_date, 0, False) //
    .AddParameter('member_limit', member_limit, 0, False) //
    .AddParameter('creates_join_request', creates_join_request, False, False) //
    .Execute);
  End
  Else
  Begin
    Result := TtdChatInviteLink.Create(GetRequest.SetMethod('createChatInviteLink') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('name', name, '', False) //
    .AddParameter('expire_date', expire_date, 0, False) //
    .AddParameter('creates_join_request', creates_join_request, False, False) //
    .Execute);
  End;

  Logger.Leave(Self, 'createChatInviteLink');
end;
function TInjectTelegramBot.editChatInviteLink(const ChatId: TtdUserLink;
  const expire_date: TDateTime; const invite_link: String;
  const name: String; const member_limit: Integer;
  const creates_join_request: boolean): ItdChatInviteLink;
begin
  Logger.Enter(Self, 'editChatInviteLink');
  Result := TtdChatInviteLink.Create(GetRequest.SetMethod('editChatInviteLink') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('expire_date', expire_date, 0, False) //
    .AddParameter('invite_link', invite_link, '', False) //
    .AddParameter('name', name, '', False) //
    .AddParameter('member_limit', member_limit, 0, False) //
    .AddParameter('creates_join_request', creates_join_request, False, False) //
    .Execute);
  Logger.Leave(Self, 'editChatInviteLink');
end;
function TInjectTelegramBot.revokeChatInviteLink(const ChatId: TtdUserLink;
  const invite_link: String): ItdChatInviteLink;
begin
  Logger.Enter(Self, 'revokeChatInviteLink');
  Result := TtdChatInviteLink.Create(GetRequest.SetMethod('revokeChatInviteLink') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('invite_link', invite_link, '', False) //
    .Execute);
  Logger.Leave(Self, 'revokeChatInviteLink');
end;

function TInjectTelegramBot.answerWebAppQuery(
  const web_app_query_id: string;
  const AResult: TtdInlineQueryResult): ItdSentWebAppMessage;
begin
  Logger.Enter(Self, 'AnswerWebAppQuery');
  Result := TtdSentWebAppMessage.Create(GetRequest.SetMethod('answerWebAppQuery') //
    .AddParameter('web_app_query_id', web_app_query_id, '', True) //
    .AddParameter('result', TInterfacedObject(AResult), nil, True) //
    .Execute);
  Logger.Leave(Self, 'AnswerWebAppQuery');
end;

function TInjectTelegramBot.setChatMenuButton(const chat_id: TtdUserLink;
  const url: String; Text: String;
  const ButtonType: TtdMenuButtonType): Boolean;
var
  menubuttonJson: String;
begin
  if ButtonType <> TtdMenuButtonType.MenuButtonWebApp then
    menubuttonJson := '{"type":"'+ButtonType.ToString+'"}'
  else
    menubuttonJson := '{"type":"'+ButtonType.ToString+'","text":"'+Text+'","web_app":{"url":"'+url+'"}}';

  Logger.Enter(Self, 'SetChatMenuButton');
  Result := GetRequest.SetMethod('setChatMenuButton') //
    .AddParameter('chat_id', chat_id, 0, False) //
    .AddParameter('menu_button', menubuttonJson, '{}', False)
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatMenuButton');

end;

function TInjectTelegramBot.getChatMenuButton(
  const chat_id: TtdUserLink): ItdMenuButton;
begin
  Logger.Enter(Self, 'GetChatMenuButton');
  Result := TtdMenuButtonWebApp.Create(GetRequest.SetMethod('getChatMenuButton') //
    .AddParameter('chat_id', chat_id, 0, False) //
    .Execute);
  Logger.Leave(Self, 'GetChatMenuButton');
end;

function TInjectTelegramBot.setMyDefaultAdministratorRights(
  const rights: TtdChatAdministratorRights;
  const for_channels: Boolean): Boolean;
begin
  Logger.Enter(Self, 'SetMyDefaultAdministratorRights');
  Result := GetRequest.SetMethod('setMyDefaultAdministratorRights') //
    .AddParameter('rights', rights.ToJsonObject, '{}', False) //
    .AddParameter('for_channels', for_channels, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetMyDefaultAdministratorRights');
end;

function TInjectTelegramBot.getMyDefaultAdministratorRights(
  const for_channels: Boolean): ItdChatAdministratorRights;
begin
  Logger.Enter(Self, 'GetMyDefaultAdministratorRights');
  Result := TtdChatAdministratorRights.Create(GetRequest.SetMethod('getMyDefaultAdministratorRights') //
    .AddParameter('for_channels', for_channels, False, False) //
    .Execute);
  Logger.Leave(Self, 'GetMyDefaultAdministratorRights');
end;

function TInjectTelegramBot.approveChatJoinRequest(const ChatId,
  UserId: TtdUserLink): Boolean;
begin
  Logger.Enter(Self, 'ApproveChatJoinRequest');
  Result := GetRequest.SetMethod('approveChatJoinRequest') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'ApproveChatJoinRequest');
end;
function TInjectTelegramBot.declineChatJoinRequest(const ChatId,
  UserId: TtdUserLink): Boolean;
begin
  Logger.Enter(Self, 'DeclineChatJoinRequest');
  Result := GetRequest.SetMethod('declineChatJoinRequest') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'DeclineChatJoinRequest');
end;
function TInjectTelegramBot.ExportChatInviteLink(const ChatId: TtdUserLink): string;
begin
  Logger.Enter(Self, 'ExportChatInviteLink');
  Result := GetRequest.SetMethod('exportChatInviteLink') //
    .AddParameter('chat_id', ChatId, 0, True).ExecuteAndReadValue;
  Logger.Leave(Self, 'ExportChatInviteLink');
end;
{$ENDREGION}
{$REGION 'Basic methods'}
function TInjectTelegramBot.stopMessageLiveLocation(const ChatId: TtdUserLink; const
  MessageId: Int64; ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'stopMessageLiveLocation');
  Result := GetRequest.SetMethod('stopMessageLiveLocation') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'stopMessageLiveLocation');
end;
function TInjectTelegramBot.stopMessageLiveLocation(const InlineMessageId: string;
  ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'stopMessageLiveLocation');
  Result := GetRequest.SetMethod('stopMessageLiveLocation') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'stopMessageLiveLocation');
end;
function TInjectTelegramBot.UnbanChatMember(const ChatId: TtdUserLink; const UserId:
  Int64; const OnlyIfBanned:	Boolean): Boolean;
begin
  Logger.Enter(Self, 'UnbanChatMember');
  Result := GetRequest.SetMethod('unbanChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('only_if_banned', OnlyIfBanned, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'UnbanChatMember');
end;
function TInjectTelegramBot.unbanChatSenderChat(const ChatId: TtdUserLink;
  const SenderChatId: Int64): boolean;
begin
  Logger.Enter(Self, 'UnbanChatSenderChat');
  Result := GetRequest.SetMethod('unbanChatSenderChat') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('sender_chat_id', SenderChatId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'UnbanChatSenderChat');
end;

function TInjectTelegramBot.SendLocation(
  const ChatId: TtdUserLink;
  const Location: ItdLocation;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply: Boolean;
  ReplyMarkup: IReplyMarkup;
  const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendLocation');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendLocation') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('latitude', TtdLocation(Location).Latitude, 0, True) //
    .AddParameter('longitude', TtdLocation(Location).Longitude, 0, True) //
    .AddParameter('live_period', TtdLocation(Location).LivePeriod, 0, False) //
    .AddParameter('horizontal_accuracy', TtdLocation(Location).HorizontalAccuracy, 0.0, False) //
    .AddParameter('heading', TtdLocation(Location).Heading, 0, False) //
    .AddParameter('proximity_alert_radius', TtdLocation(Location).ProximityAlertRadius, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .Execute);
  Logger.Leave(Self, 'SendLocation');
end;
function TInjectTelegramBot.sendMediaGroup(const ChatId: TtdUserLink;
  const AMedia: TArray<TtdInputMedia>;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  const ProtectContent: Boolean): TArray<ItdMessage>;
var
  LRequest: ItdRequestAPI;
  LMedia: TtdInputMedia;
  LTmpJson: string;
begin
  Logger.Enter(Self, 'SendMediaGroup');
  LTmpJson := TJsonUtils.ArrayToJString<TtdInputMedia>(AMedia);
  LRequest := GetRequest.SetMethod('sendMediaGroup') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('media', LTmpJson, '[]', True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False)
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False); //
  for LMedia in AMedia do
  begin
    case LMedia.GetFileToSend.Tag of
      TtdFileToSendTag.FromFile:
        LRequest.AddRawFile(ExtractFileName(LMedia.GetFileToSend.Data), LMedia.GetFileToSend.Data);
      TtdFileToSendTag.FromStream:
        LRequest.AddRawStream(LMedia.GetFileToSend.Data, LMedia.GetFileToSend.Content,
          LMedia.GetFileToSend.Data);
    end;
  end;
  Result := GetArrayFromMethod<ItdMessage>(TtdMessage, LRequest.Execute);
  Logger.Leave(Self, 'SendMediaGroup');
end;
function TInjectTelegramBot.SendPhoto(
  const ChatId: TtdUserLink;
  const Photo: TtdFileToSend;
  const Caption: string;
  const ParseMode: TtdParseMode;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup;
  const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendPhoto');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendPhoto') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('photo', Photo, nil, True) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendPhoto');
end;
//Add By Ruan Diego Lacerda Menezes 13/04/2020
function TInjectTelegramBot.SendPoll( ////Add By Ruan Diego Lacerda Menezes 13/04/2020
  const ChatId: TtdUserLink; //
  const Question: String; //Poll question, 1-255 characters
  const Options: Array of String; //
  const Is_Anonymous: Boolean; //
  const &type: TtdQuizType;// {String = '{"regular"}'}; //
  const Allows_Multiple_Answers: Boolean; //
  const Correct_Option_Id: Integer;
  const Explanation: String; //
  const Explanation_parse_mode: TtdParseMode; //
  const Open_period : Integer; //
  const Close_date: Integer; //
  const Is_Closed: Boolean; //
  const DisableNotification: Boolean; //
  const ReplyToMessageId: Int64; //
  const AllowSendingWithoutReply:	Boolean;
    ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
var
  LTmpJson: string;
begin
  Logger.Enter(Self, 'SendPoll');
  LTmpJson := TJsonUtils.ArrayStringToJString(Options);
  Result := TtdMessage.Create(GetRequest.SetMethod('sendPoll') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('question', Question, '', True) //
    .AddParameter('options', LTmpJson, '[]', True) //
    .AddParameter('is_anonymous', Is_Anonymous, True, False) //
    .AddParameter('type', &type.ToString, 'regular', True) //
    .AddParameter('allows_multiple_answers', Allows_Multiple_Answers, False, False) //
    .AddParameter('correct_option_id', Correct_Option_Id, 0, False) //
    .AddParameter('explanation', Explanation, '', False) //
    .AddParameter('explanation_parse_mode', Explanation_parse_mode.ToString, '', False) //
    .AddParameter('open_period', Open_period, 0, False) //
    .AddParameter('close_date', Close_date, 0, False) //
    .AddParameter('is_closed', Is_Closed, False, False) //
     .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendPoll');
end;
function TInjectTelegramBot.SendMessage(const ChatId: TtdUserLink; const Text: string;
  const ParseMode: TtdParseMode; const DisableWebPagePreview,
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup:
  IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendMessage');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, Not DisableWebPagePreview, False) //
    .AddParameter('disable_notification', DisableNotification, Not DisableNotification, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup',TInterfacedObject(ReplyMarkup), nil, False) //nil
    .Execute);
  Logger.Leave(Self, 'SendMessage');
end;

function TInjectTelegramBot.SendVenue(const ChatId: TtdUserLink; const Venue: ItdVenue;
  const Location: ItdLocation; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendVenue');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendVenue') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('latitude', TtdLocation(Location).Latitude, 0, True) //
    .AddParameter('longitude', TtdLocation(Location).Longitude, 0, True) //
    .AddParameter('title', TtdVenue(Venue).sTitle, '', True) //
    .AddParameter('address', TtdVenue(Venue).sAddress, '', True) //
    .AddParameter('foursquare_id', TtdVenue(Venue).sFoursquareId, '', False) //
    .AddParameter('foursquare_type', TtdVenue(Venue).sFoursquareType, '', False) //Add By Ruan Diego
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVenue');
end;
//Add Nova Função com a localização como propriedade do TtdVenue - By Ruan Diego
function TInjectTelegramBot.SendVenue2(const ChatId: TtdUserLink;
  const Venue: ItdVenue; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;const AllowSendingWithoutReply:	Boolean;
   ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendVenue');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendVenue') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('latitude', TtdVenue(Venue).sLatitude, 0, True) //
    .AddParameter('longitude', TtdVenue(Venue).sLongitude, 0, True) //
    .AddParameter('title', TtdVenue(Venue).sTitle, '', True) //
    .AddParameter('address', TtdVenue(Venue).sAddress, '', True) //
    .AddParameter('foursquare_id', TtdVenue(Venue).sFoursquareId, '', False) //
    .AddParameter('foursquare_type', TtdVenue(Venue).sFoursquareType, '', False) //Add By Ruan Diego
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVenue');
end;
function TInjectTelegramBot.SendVideo(const ChatId: TtdUserLink; const Video:
  TtdFileToSend; const Caption: string; const ParseMode: TtdParseMode; const
  SupportsStreaming: Boolean; const Duration, Width, Height: Int64; const
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup;
  const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendVideo');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendVideo') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('video', Video, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('width', Width, 0, False) //
    .AddParameter('height', Height, 0, False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('supports_streaming', SupportsStreaming, False, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //'
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVideo');
end;
function TInjectTelegramBot.SendVideoNote(const ChatId: TtdUserLink; const VideoNote:
  TtdFileToSend; const Duration, Length: Int64; const DisableNotification:
  Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup;
      const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendVideoNote');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendVideoNote') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('video_note', VideoNote, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('length', Length, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //'
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVideoNote');
end;
function TInjectTelegramBot.SendVoice(const ChatId: TtdUserLink; const Voice:
  TtdFileToSend; const Caption: string; const ParseMode: TtdParseMode; const
  Duration: Int64; const DisableNotification: Boolean; const ReplyToMessageId:
  Int64; const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendVoice');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendVoice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('voice', Voice, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVoice');
end;
//Novo Metodo Add - By Ruan Diego
function TInjectTelegramBot.SendAnimation( //
  const ChatId: TtdUserLink; //
  const Animation: TtdFileToSend; //
  const Duration: Int64; //
  const Width: Int64; //
  const Height: Int64; //
  const Thumb: TtdFileToSend; //
  const Caption: string; //
  const ParseMode: TtdParseMode; //
  const DisableNotification: Boolean; //
  const ReplyToMessageId: Int64; //
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup;
  const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendAnimation');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendAnimation') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('animation', Animation, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('width', Width, 0, False) //
    .AddParameter('height', Height, 0, False) //
    .AddParameter('thumb', Thumb, nil, True) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //'
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendAnimation');
end;
function TInjectTelegramBot.SendAudio(const ChatId: TtdUserLink; const Audio:
  TtdFileToSend; const Caption: string; const ParseMode: TtdParseMode; const
  Duration: Int64; const Performer: string; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64; const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendAudio');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendAudio') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('audio', Audio, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('performer', Performer, '', False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendAudio');
end;
function TInjectTelegramBot.SendChatAction(const ChatId: TtdUserLink; const Action:
  TtdSendChatAction): Boolean;
begin
  Logger.Enter(Self, 'SendChatAction');
  Result := GetRequest.SetMethod('sendChatAction') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('action', Action.ToJsonString, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SendChatAction');
end;
function TInjectTelegramBot.SendContact(const ChatId: TtdUserLink; const Contact:
  ItdContact; const DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendContact');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendContact') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('phone_number', Contact.PhoneNumber, '', True) //
    .AddParameter('first_name', Contact.FirstName, '', True) //
    .AddParameter('last_name', Contact.LastName, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendContact');
end;

function TInjectTelegramBot.SendDice(
  const ChatId: TtdUserLink; //
  const Emoji: TtdEmojiType = TtdEmojiType.etDado;//
  const DisableNotification: Boolean = False; //
  const ReplyToMessageId: Int64 = 0; //
  const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil; const ProtectContent: Boolean = False): ItdMessage;
begin
  Logger.Enter(Self, 'SendDice');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendDice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('emoji', Emoji.ToString, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendDice');
end;
function TInjectTelegramBot.SendDocument(
  const ChatId: TtdUserLink;
  const Document: TtdFileToSend;
  const Thumb: TtdFileToSend; //
  const Caption: string;
  const ParseMode: TtdParseMode;
  const CaptionEntities: TArray<TtdMessageEntity>;
  const DisableContentTypeDetection: Boolean;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
var
  LTmpJson: String;
begin
  Logger.Enter(Self, 'SendDocument');
  LTmpJson := TJsonUtils.ArrayToJString<TtdMessageEntity>(CaptionEntities);
  Result := TtdMessage.Create(GetRequest.SetMethod('sendDocument') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('document', Document, nil, True) //
{ TODO 5 -oRuan Diego -csendDocument : Bug Fix 00123 }
//    .AddParameter('thumb', Thumb, nil, False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('caption_entities', LTmpJson, '[]', False) //
    .AddParameter('disable_content_type_detection', DisableContentTypeDetection, False, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendDocument');
end;
function TInjectTelegramBot.banChatMember(const ChatId: TtdUserLink; const UserId:
  Int64; const UntilDate: TDateTime; const RevokeMessages: Boolean): Boolean;
begin
  Logger.Enter(Self, 'BanChatMember');
  Result := GetRequest.SetMethod('banChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('until_date', UntilDate, 0, False) //
    .AddParameter('revoke_messages', RevokeMessages, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'BanChatMember');
end;
function TInjectTelegramBot.banChatSenderChat(const ChatId: TtdUserLink;
  const SenderChatId: Int64): boolean;
begin
  Logger.Enter(Self, 'BanChatSenderChat');
  Result := GetRequest.SetMethod('banChatSenderChat') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('sender_chat_id', SenderChatId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'BanChatSenderChat');
end;

function TInjectTelegramBot.LeaveChat(const ChatId: TtdUserLink): Boolean;
begin
  Logger.Enter(Self, 'LeaveChat');
  Result := GetRequest.SetMethod('leaveChat') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'LeaveChat');
end;
function TInjectTelegramBot.GetUserProfilePhotos(const ChatId: TtdUserLink; const
  Offset, Limit: Int64): ItdUserProfilePhotos;
begin
  Logger.Enter(Self, 'GetUserProfilePhotos');
  Result := TtdUserProfilePhotos.Create(GetRequest.SetMethod('getUserProfilePhotos') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('offset', Offset, 0, True) //
    .AddParameter('limit', Limit, 100, False) //
    .Execute);
  Logger.Leave(Self, 'GetUserProfilePhotos');
end;
function TInjectTelegramBot.GetMe: ItdUser;
begin
  Logger.Enter(Self, 'GetMe');
  Result := TtdUser.Create(GetRequest.SetMethod('getMe').Execute);
  Logger.Leave(Self, 'GetMe');
end;
function TInjectTelegramBot.SetMyCommands(
    const Command: TArray<TtdBotCommand>;
    const scope: TtdBotCommandScope;
    const language_code: string): Boolean;
Var
  LTmpJson: String;
begin
  LTmpJson := TJsonUtils.ArrayCommandsToJString<TtdBotCommand>(Command);
  Logger.Enter(Self, 'SetMyCommands');
  Result := GetRequest.SetMethod('setMyCommands') //
    .AddParameter('commands', LTmpJson, '[]', True)
    .AddParameter('scope', scope.ToJsonObject, '{}', False)
    .AddParameter('language_code', language_code, '', False)
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetMyCommands');
end;

function TInjectTelegramBot.GetMyCommands(
    const scope: TtdBotCommandScope;
    const language_code: string
    ): TArray<ItdBotCommand>;
begin
  Logger.Enter(Self, 'GetMyCommands');
  Result := GetArrayFromMethod<ItdBotCommand>(TtdBotCommand,
    GetRequest.SetMethod('getMyCommands')
    .AddParameter('scope', scope.ToJsonObject, '{"type":"default"}', False)
    .AddParameter('language_code', language_code, '', False)
    .Execute);
  Logger.Leave(Self, 'GetMyCommands');
end;
function TInjectTelegramBot.DeleteMyCommands(
        const scope: TtdBotCommandScope;
        const language_code: string
    ): Boolean;
Begin
  Logger.Enter(Self, 'DeleteMyCommands');
  Result := GetRequest.SetMethod('deleteMyCommands') //
    .AddParameter('scope', scope.ToJsonObject, '{"type":"default"}', False)
    .AddParameter('language_code', language_code, '', False)
    .ExecuteAsBool;
  Logger.Leave(Self, 'DeleteMyCommands');
End;
function TInjectTelegramBot.Close: Boolean;
begin
  Logger.Enter(Self, 'Close');
  Result := GetRequest.SetMethod('close').ExecuteAsBool;
  Logger.Leave(Self, 'Close');
end;
function TInjectTelegramBot.CopyMessage(const ChatId, FromChatId: TtdUserLink;
  const MessageId: Int64; const Caption: string; const ParseMode: TtdParseMode;
  const CaptionEntities: TArray<TtdMessageEntity>; const DisableWebPagePreview,
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply: Boolean; ReplyMarkup: IReplyMarkup;
  const ProtectContent: Boolean): Int64;
Var
  LTmpJson: String;
begin
  Logger.Enter(Self, 'CopyMessage');
  LTmpJson := TJsonUtils.ArrayToJString<TtdMessageEntity>(CaptionEntities);
  Result := GetRequest.SetMethod('copyMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('from_chat_id', FromChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('caption_entities', LTmpJson, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, False, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute.ToInt64;
  Logger.Leave(Self, 'CopyMessage');
end;
function TInjectTelegramBot.LogOut: Boolean;
begin
  Logger.Enter(Self, 'LogOut');
  Result := GetRequest.SetMethod('logOut').ExecuteAsBool;
  Logger.Leave(Self, 'LogOut');
end;
function TInjectTelegramBot.SetPassportDataErrors(const UserId: Int64;
  const Errors: TArray<TtdEncryptedPassportElement>): Boolean;
Var
  LTmpJson: String;
begin
  LTmpJson := TJsonUtils.ArrayToJString<TtdEncryptedPassportElement>(Errors);
  Logger.Enter(Self, 'SetPassportDataErrors');
  Result := GetRequest.SetMethod('setPassportDataErrors') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('errors', LTmpJson, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetPassportDataErrors');
end;
function TInjectTelegramBot.ForwardMessage(const ChatId, FromChatId: TtdUserLink;
  const MessageId: Int64; const DisableNotification: Boolean; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'ForwardMessage');
  Result := TtdMessage.Create(GetRequest.SetMethod('forwardMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('from_chat_id', FromChatId, 0, True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('message_id', MessageId, 0, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .Execute);
  Logger.Leave(Self, 'ForwardMessage');
end;
function TInjectTelegramBot.GetChat(const ChatId: TtdUserLink): ItdChat;
begin
  Logger.Enter(Self, 'GetChat');
  Result := TtdChat.Create(GetRequest.SetMethod('getChat').//
    AddParameter('chat_id', ChatId, 0, True).Execute);
  Logger.Leave(Self, 'GetChat');
end;
function TInjectTelegramBot.GetChatAdministrators(const ChatId: TtdUserLink): TArray<
  ItdChatMember>;
begin
  Logger.Enter(Self, 'GetChatAdministrators');
  Result := GetArrayFromMethod<ItdChatMember>(TtdChatMember, GetRequest.SetMethod
    ('getChatAdministrators').AddParameter('chat_id', ChatId, 0, True).Execute);
  Logger.Leave(Self, 'GetChatAdministrators');
end;
function TInjectTelegramBot.GetChatMember(const ChatId: TtdUserLink; const UserId:
  Int64): ItdChatMember;
begin
  Logger.Enter(Self, 'GetChatMember');
  Result := TtdChatMember.Create(GetRequest.SetMethod('getChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'GetChatMember');
end;
function TInjectTelegramBot.GetChatMemberCount(const ChatId: TtdUserLink): Int64;
var
  LJSON: TJSONValue;
begin
  Logger.Enter(Self, 'GetChatMemberCount');
  LJSON := TJSONObject.ParseJSONValue(GetRequest.SetMethod('getChatMemberCount') //
    .AddParameter('chat_id', ChatId, 0, True).Execute);
  try
    if not LJSON.TryGetValue<Int64>(Result) then
      Result := 0;
  finally
    LJSON.Free;
  end;
  Logger.Leave(Self, 'GetChatMemberCount');
end;

function TInjectTelegramBot.GetFile(const FileId: string): ItdFile;
begin
  Logger.Enter(Self, 'GetFile');
  Result := TtdFile.Create(GetRequest.SetMethod('getFile') //
    .AddParameter('file_id', FileId, '', True).Execute);
  Logger.Leave(Self, 'GetFile');
end;
function TInjectTelegramBot.AnswerCallbackQuery(const CallbackQueryId, Text: string;
  const ShowAlert: Boolean; const Url: string; const CacheTime: Int64): Boolean;
begin
  Logger.Enter(Self, 'AnswerCallbackQuery');
  Result := GetRequest.SetMethod('answerCallbackQuery') //
    .AddParameter('callback_query_id', CallbackQueryId, '', True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('show_alert', ShowAlert, False, False) //
    .AddParameter('url', Url, '', False) //
    .AddParameter('cache_time', CacheTime, 0, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerCallbackQuery');
end;
{$ENDREGION}
{$REGION 'Updating messages'}
function TInjectTelegramBot.EditMessageText(const InlineMessageId, Text: string; const
  ParseMode: TtdParseMode; const DisableWebPagePreview: Boolean; ReplyMarkup:
  IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'EditMessageText');
  Result := TtdMessage.Create(GetRequest.SetMethod('editMessageText') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageText');
end;
function TInjectTelegramBot.EditMessageText(const ChatId: TtdUserLink; const MessageId:
  Int64; const Text: string; const ParseMode: TtdParseMode; const
  DisableWebPagePreview: Boolean; ReplyMarkup: IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'EditMessageText');
  Result := TtdMessage.Create(GetRequest.SetMethod('editMessageText') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageText');
end;
function TInjectTelegramBot.DeleteMessage(const ChatId: TtdUserLink; const MessageId:
  Int64): Boolean;
begin
  Logger.Enter(Self, 'DeleteMessage');
  Result := GetRequest.SetMethod('deleteMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'DeleteMessage');
end;
function TInjectTelegramBot.EditMessageCaption(const ChatId: TtdUserLink; const
  MessageId: Int64; const Caption: string; const ParseMode: TtdParseMode;
  ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'EditMessageCaption');
  Result := GetRequest.SetMethod('editMessageText') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('caption', Caption, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'EditMessageCaption');
end;
function TInjectTelegramBot.EditMessageCaption(const InlineMessageId, Caption: string;
  const ParseMode: TtdParseMode; ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'EditMessageCaption');
  Result := GetRequest.SetMethod('editMessageCaption') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('caption', Caption, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'EditMessageCaption');
end;
//Corrigido - By Ruan Diego
function TInjectTelegramBot.editMessageLiveLocation(const ChatId: TtdUserLink; const
  MessageId: Int64; const Location: ItdLocation; ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'editMessageLiveLocation');
  Result := GetRequest.SetMethod('editMessageLiveLocation') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('latitude', TtdLocation(Location).Latitude, 0, True) //
    .AddParameter('longitude', TtdLocation(Location).Longitude, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'editMessageLiveLocation');
end;
function TInjectTelegramBot.editMessageLiveLocation(const InlineMessageId: string;
  const Location: ItdLocation; ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'editMessageLiveLocation');
  Result := GetRequest.SetMethod('editMessageLiveLocation') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('latitude', TtdLocation(Location).Latitude, 0, False) //
    .AddParameter('longitude', TtdLocation(Location).Longitude, 0, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'editMessageLiveLocation');
end;
function TInjectTelegramBot.EditMessageReplyMarkup(const ChatId: TtdUserLink; const
  MessageId: Int64; ReplyMarkup: IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'EditMessageReplyMarkup');
  Result := TtdMessage.Create(GetRequest.SetMethod('editMessageReplyMarkup') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageReplyMarkup');
end;
function TInjectTelegramBot.EditMessageMedia(
  const InlineMessageId: string;
  const Media: TtdInputMedia; ReplyMarkup: IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'EditMessageMedia');
  Result := TtdMessage.Create(GetRequest.SetMethod('editMessageMedia') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('media', Media.GetFileToSend, Nil, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageMedia');
end;

function TInjectTelegramBot.EditMessageMedia(const ChatId: TtdUserLink;
  const MessageId: Int64; const Media: TtdInputMedia;
  ReplyMarkup: IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'EditMessageMedia');
  Result := TtdMessage.Create(GetRequest.SetMethod('editMessageMedia') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('media', Media.GetFileToSend, Nil, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageMedia');
end;

function TInjectTelegramBot.EditMessageReplyMarkup(const InlineMessageId: string;
  ReplyMarkup: IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'EditMessageReplyMarkup');
  Result := TtdMessage.Create(GetRequest.SetMethod('editMessageReplyMarkup') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageReplyMarkup');
end;
{$ENDREGION}
{$REGION 'Manage groups and channels'}
function TInjectTelegramBot.DeleteChatPhoto(const ChatId: TtdUserLink): Boolean;
begin
  Logger.Enter(Self, 'DeleteChatPhoto');
  Result := GetRequest.SetMethod('deleteChatPhoto') //
    .AddParameter('chat_id', ChatId, 0, True).ExecuteAsBool;
  Logger.Leave(Self, 'DeleteChatPhoto');
end;
function TInjectTelegramBot.deleteChatStickerSet(const ChatId: TtdUserLink): Boolean;
begin
  Logger.Enter(Self, 'deleteChatStickerSet');
  Result := GetRequest.SetMethod('deleteChatStickerSet') //
    .AddParameter('chat_id', ChatId, 0, True)
    .ExecuteAsBool;
  Logger.Leave(Self, 'deleteChatStickerSet');
end;
function TInjectTelegramBot.PinChatMessage(const ChatId: TtdUserLink; const MessageId:
  Int64; const DisableNotification: Boolean): Boolean;
begin
  Logger.Enter(Self, 'PinChatMessage');
  Result := GetRequest.SetMethod('pinChatMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'PinChatMessage');
end;
function TInjectTelegramBot.SetChatDescription(const ChatId: TtdUserLink; const
  Description: string): Boolean;
begin
  Logger.Enter(Self, 'SetChatDescription');
  Result := GetRequest.SetMethod('setChatDescription') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('description', Description, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatDescription');
end;

function TInjectTelegramBot.SetChatPhoto(const ChatId: TtdUserLink; const Photo:
  TtdFileToSend): Boolean;
begin
  Logger.Enter(Self, 'SetChatPhoto');
  Result := GetRequest.SetMethod('setChatDescription') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('photo', Photo, nil, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatPhoto');
end;
function TInjectTelegramBot.setChatStickerSet(const ChatId: TtdUserLink; const
  StickerSetName: string): Boolean;
begin
  Logger.Enter(Self, 'setChatStickerSet');
  Result := GetRequest.SetMethod('setChatStickerSet') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('sticker_set_name', StickerSetName, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'setChatStickerSet');
end;
function TInjectTelegramBot.SetChatTitle(const ChatId: TtdUserLink; const Title:
  string): Boolean;
begin
  Logger.Enter(Self, 'SetChatTitle');
  Result := GetRequest.SetMethod('setChatTitle') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('title', Title, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatTitle');
end;
function TInjectTelegramBot.UnPinAllChatMessages(
  const ChatId: TtdUserLink): Boolean;
begin
  Logger.Enter(Self, 'UnPinAllChatMessages');
  Result := GetRequest.SetMethod('unpinAllChatMessages')
    .AddParameter('chat_id', ChatId, 0, True)
    .ExecuteAsBool;
  Logger.Leave(Self, 'UnPinAllChatMessages');
end;
function TInjectTelegramBot.UnPinChatMessage(const ChatId: TtdUserLink;
  const MessageId: Int64): Boolean;
begin
  Logger.Enter(Self, 'UnpinChatMessage');
  Result := GetRequest.SetMethod('unpinChatMessage') //
    .AddParameter('chat_id', ChatId, 0, True)
    .AddParameter('message_id', MessageId, 0, False)
    .ExecuteAsBool;
  Logger.Leave(Self, 'UnpinChatMessage');
end;
{$ENDREGION}
{$REGION 'Manage users and admins'}
function TInjectTelegramBot.PromoteChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const IsAnonymous: Boolean = False;
      const CanManageChat: Boolean = False;
      const CanPostMessages: Boolean = False; //
      const CanEditMessages: Boolean = False; //
      const CanDeleteMessages: Boolean = False; //
      const CanManageVideoChats: Boolean = False;
      const CanRestrictMembers: Boolean = False; //
      const CanPromoteMembers: Boolean = False;
      const CanChangeInfo: Boolean = False; //
      const CanInviteUsers: Boolean = False; //
      const CanPinMessages: Boolean = False): Boolean;
begin
  Logger.Enter(Self, 'PromoteChatMember');
  Result := GetRequest.SetMethod('promoteChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('is_anonymous', IsAnonymous, False, False) //
    .AddParameter('can_manage_chat', CanManageChat, False, False) //
    .AddParameter('can_post_messages', CanPostMessages, False, False) //
    .AddParameter('can_edit_messages', CanEditMessages, False, False) //
    .AddParameter('can_delete_messages', CanDeleteMessages, False, False) //
    .AddParameter('can_manage_video_chats ', CanManageVideoChats, False, False) //
    .AddParameter('can_restrict_members', CanRestrictMembers, False, False) //
    .AddParameter('can_promote_members', CanPromoteMembers, False, False) //
    .AddParameter('can_change_info', CanChangeInfo, False, False) //
    .AddParameter('can_invite_users', CanInviteUsers, False, False) //
    .AddParameter('can_pin_messages', CanPinMessages, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'PromoteChatMember');
end;
function TInjectTelegramBot.RestrictChatMember(const ChatId: TtdUserLink; const UserId:
  Int64; const UntilDate: TDateTime; const CanSendMessages, CanSendMediaMessages,
  CanSendOtherMessages, CanAddWebPagePreviews: Boolean): Boolean;
begin
  Logger.Enter(Self, 'RestrictChatMember');
  Result := GetRequest.SetMethod('restrictChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('until_date', UntilDate, 0, False) //
    .AddParameter('can_send_messages', CanSendMessages, False, False) //
    .AddParameter('can_send_media_messages', CanSendMediaMessages, False, False)   //
    .AddParameter('can_send_other_messages', CanSendOtherMessages, False, False)   //
    .AddParameter('can_add_web_page_previews', CanAddWebPagePreviews, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'RestrictChatMember');
end;
{$ENDREGION}
{$REGION 'Stickers'}
function TInjectTelegramBot.addStickerToSet(const UserId: Int64; const Name: string;
  const PngSticker: TtdFileToSend; const TgsSticker: TtdFileToSend;
  const Webm_sticker: TtdFileToSend; //
  const Emojis: string; const MaskPosition:
  ItdMaskPosition): Boolean;
begin
  Logger.Enter(Self, 'addStickerToSet');
  Result := GetRequest.SetMethod('addStickerToSet') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('name', Name, '', False) //
    .AddParameter('png_sticker', PngSticker, nil, False) //
    .AddParameter('tgs_sticker', TgsSticker, nil, False) //
    .AddParameter('webm_sticker', Webm_sticker, nil, False) //
    .AddParameter('emojis', Emojis, '', False) //
    .AddParameter('mask_position', TtdMaskPosition(MaskPosition), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'addStickerToSet');
end;
function TInjectTelegramBot.createNewStickerSet(const UserId: Int64; const Name, Title:
  string; const PngSticker: TtdFileToSend; const TgsSticker: TtdFileToSend;
  const Webm_sticker: TtdFileToSend;
  const Emojis: string; const ContainsMasks: Boolean;
  const MaskPosition: ItdMaskPosition): Boolean;
begin
  Logger.Enter(Self, 'createNewStickerSet');
  Result := GetRequest.SetMethod('createNewStickerSet') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('name', Name, '', False) //
    .AddParameter('title', Title, '', False) //
    .AddParameter('png_sticker', PngSticker, nil, False) //
    .AddParameter('tgs_sticker', TgsSticker, nil, False) //
    .AddParameter('webm_sticker', Webm_sticker, nil, False) //
    .AddParameter('emojis', Emojis, '', False) //
    .AddParameter('contains_masks', ContainsMasks, False, False) //
    .AddParameter('mask_position', TtdMaskPosition(MaskPosition), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'createNewStickerSet');
end;
function TInjectTelegramBot.deleteStickerFromSet(const Sticker: string): Boolean;
begin
  Logger.Enter(Self, 'deleteStickerFromSet');
  Result := GetRequest.SetMethod('deleteStickerFromSet') //
    .AddParameter('sticker', Sticker, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'deleteStickerFromSet');
end;

function TInjectTelegramBot.getStickerSet(const Name: string): ItdStickerSet;
begin
  Logger.Enter(Self, 'getStickerSet');
  Result := TtdStickerSet.Create(GetRequest.SetMethod('getStickerSet') //
    .AddParameter('name', Name, '', True).Execute);
  Logger.Leave(Self, 'getStickerSet');
end;
function TInjectTelegramBot.SendSticker(const ChatId: TtdUserLink; const Sticker:
  TtdFileToSend; const DisableNotification: Boolean; const ReplyToMessageId:
  Int64; ReplyMarkup: IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'SendSticker');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendSticker') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('sticker', Sticker, nil, True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendSticker');
end;
function TInjectTelegramBot.setStickerPositionInSet(const Sticker: string; const
  Position: Int64): Boolean;
begin
  Logger.Enter(Self, 'setStickerPositionInSet');
  Result := GetRequest.SetMethod('deleteStickerFromSet') //
    .AddParameter('sticker', Sticker, '', True) //
    .AddParameter('position', Position, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'setStickerPositionInSet');
end;
function TInjectTelegramBot.setStickerSetThumb(const Name: string;
  const UserId: Int64; const Thumb: string): Boolean;
begin
  Logger.Enter(Self, 'SetStickerSetThumb');
  Result := GetRequest.SetMethod('setStickerSetThumb') //
    .AddParameter('name	', Name, '', True)
    .AddParameter('user_id', UserId, 0, True)
    .AddParameter('thumb', Thumb, '', False).ExecuteAsBool;
  Logger.Leave(Self, 'SetStickerSetThumb');
end;
function TInjectTelegramBot.uploadStickerFile(const UserId: Int64; const PngSticker:
  TtdFileToSend): ItdFile;
begin
  Logger.Enter(Self, 'uploadStickerFile');
  Result := TtdFile.Create(GetRequest.SetMethod('uploadStickerFile') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('png_sticker', PngSticker, nil, True) //
    .Execute);
  Logger.Leave(Self, 'uploadStickerFile');
end;
{$ENDREGION}
{$REGION 'Inline mode'}
function TInjectTelegramBot.AnswerInlineQuery(const InlineQueryId: string; const
  Results: TArray<TtdInlineQueryResult>; const CacheTime: Int64; const
  IsPersonal: Boolean; const NextOffset, SwitchPmText, SwitchPmParameter: string):
  Boolean;
begin
  Logger.Enter(Self, 'AnswerInlineQuery');
  Result := GetRequest.SetMethod('answerInlineQuery') //
    .AddParameter('inline_query_id', InlineQueryId, '', True) //
    .AddParameter('results', TJsonUtils.ArrayToJString<TtdInlineQueryResult>(Results),
    '[]', True) //
    .AddParameter('cache_time', CacheTime, 0, False) //
    .AddParameter('is_personal', IsPersonal, False, False) //
    .AddParameter('next_offset', NextOffset, '', False) //
    .AddParameter('switch_pm_text', SwitchPmText, '', False) //
    .AddParameter('switch_pm_parameter', SwitchPmParameter, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerInlineQuery');
end;
{$ENDREGION}
{$REGION 'Payments'}
function TInjectTelegramBot.SendInvoice(
  const ChatId: Int64;
  const Title: string;
  const Description: string;
  const Payload: string;
  const ProviderToken: string;
  const StartParameter: string;
  const Currency: string;
  const Prices: TArray<TtdLabeledPrice>;
  const MaxTipAmount: Integer;
  const SuggestedTipAmounts: TArray<Integer>;
  const ProviderData: string;
  const PhotoUrl: string;
  const PhotoSize: Int64;
  const PhotoWidth: Int64;
  const PhotoHeight: Int64;
  const NeedName: Boolean;
  const NeedPhoneNumber: Boolean;
  const NeedEmail: Boolean;
  const NeedShippingAddress: Boolean;
  const SendPhoneNumberToProvider: Boolean;
  const SendRmailToProvider: Boolean;
  const IsFlexible: Boolean;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64; ReplyMarkup:
  IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
Var
  LabeledPriceJson,
  SuggestedTipAmountsJson : string;
begin
  LabeledPriceJson := TJsonUtils.ArrayToJString<TtdLabeledPrice>(Prices);
  SuggestedTipAmountsJson := TJsonUtils.ArrayIntToJString(SuggestedTipAmounts);
  Logger.Enter(Self, 'SendInvoice');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendInvoice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('title', Title, '', True) //
    .AddParameter('description', Description, '', True) //
    .AddParameter('payload', Payload, '', True) //
    .AddParameter('provider_token', ProviderToken, '', True) //
    .AddParameter('start_parameter', StartParameter, '', False) //now is Optional in API 5.2
    .AddParameter('currency', Currency, '', True) //
    .AddParameter('prices', LabeledPriceJson, '[{"label":"null","amount":"0"}]', True) //
    .AddParameter('max_tip_amount', MaxTipAmount, 0, False) //
    .AddParameter('suggested_tip_amounts', SuggestedTipAmountsJson, '[]', False) //
    .AddParameter('provider_data', ProviderData, '', False) //
    .AddParameter('photo_url', PhotoUrl, '', False) //
    .AddParameter('photo_size', PhotoSize, 0, False) //
    .AddParameter('photo_width', PhotoWidth, 0, False) //
    .AddParameter('photo_height', PhotoHeight, 0, False) //
    .AddParameter('need_name', NeedName, False, False) //
    .AddParameter('need_phone_number', NeedPhoneNumber, False, False) //
    .AddParameter('need_email', NeedEmail, False, False) //
    .AddParameter('need_shipping_address', NeedShippingAddress, False, False) //
    .AddParameter('send_phone_number_to_provider', SendPhoneNumberToProvider, False, False) //
    .AddParameter('send_email_to_provider', SendRmailToProvider, False, False) //
    .AddParameter('is_flexible', IsFlexible, False, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendInvoice');
end;
function TInjectTelegramBot.AnswerPreCheckoutQuery(
  const PreCheckoutQueryId: string;
  const OK: Boolean;
  const ErrorMessage: string): Boolean;
var
  DefaultBool : Boolean;
begin
  DefaultBool := Not OK;
  Logger.Enter(Self, 'AnswerPreCheckoutQuery');
  Result := GetRequest.SetMethod('answerPreCheckoutQuery') //
    .AddParameter('pre_checkout_query_id', PreCheckoutQueryId, '0', True) //
    .AddParameter('ok', Ok , DefaultBool, True) //
    .AddParameter('error_message', ErrorMessage, 'null', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQuery');
end;
function TInjectTelegramBot.AnswerPreCheckoutQueryBad(const PreCheckoutQueryId,
  ErrorMessage: string): Boolean;
begin
  Logger.Enter(Self, 'AnswerPreCheckoutQueryBad');
  Result := GetRequest.SetMethod('answerPreCheckoutQuery') //
    .AddParameter('pre_checkout_query_id', PreCheckoutQueryId, 0, True) //
    .AddParameter('ok', False, True, True) //
    .AddParameter('error_message', ErrorMessage, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQueryBad');
end;
function TInjectTelegramBot.AnswerPreCheckoutQueryGood(const PreCheckoutQueryId:
  string): Boolean;
begin
  Logger.Enter(Self, 'AnswerPreCheckoutQueryGood');
  Result := GetRequest.SetMethod('answerPreCheckoutQuery') //
    .AddParameter('pre_checkout_query_id', PreCheckoutQueryId, 0, True) //
    .AddParameter('ok',True, False, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQueryGood');
end;
function TInjectTelegramBot.AnswerShippingQueryBad(const ShippingQueryId, ErrorMessage:
  string): Boolean;
begin
  Logger.Enter(Self, 'AnswerShippingQueryBad');
  Result := GetRequest.SetMethod('answerShippingQuery') //
    .AddParameter('Shipping_query_id', ShippingQueryId, 0, True) //
    .AddParameter('ok',False, True, False) //
    .AddParameter('error_message', ErrorMessage, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerShippingQueryBad');
end;
function TInjectTelegramBot.AnswerShippingQueryGood(const ShippingQueryId: string;
  const ShippingOptions: TArray<TtdShippingOption>): Boolean;
begin
  Logger.Enter(Self, 'AnswerShippingQueryGood');
  Result := GetRequest.SetMethod('answerShippingQuery') //
    .AddParameter('Shipping_query_id', ShippingQueryId, 0, True) //
    .AddParameter('ok', True, False, False) //
    .AddParameter('Shipping_options', TJsonUtils.ArrayToJString<
    TtdShippingOption>(ShippingOptions), '[]', True)    //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerShippingQueryGood');
end;
{$ENDREGION}
{$REGION 'Games'}
function TInjectTelegramBot.GetGameHighScores(const UserId: Int64; const
  InlineMessageId: string): TArray<ItdGameHighScore>;
begin
  Logger.Enter(Self, 'GetGameHighScores');
  Result := GetArrayFromMethod<ItdGameHighScore>(TtdGameHighScore, GetRequest.SetMethod
    ('getGameHighScores') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'GetGameHighScores');
end;
function TInjectTelegramBot.GetGameHighScores(const UserId, ChatId, MessageId: Int64):
  TArray<ItdGameHighScore>;
begin
  Logger.Enter(Self, 'GetGameHighScores');
  Result := GetArrayFromMethod<ItdGameHighScore>(TtdGameHighScore, GetRequest.SetMethod
    ('getGameHighScores') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'GetGameHighScores');
end;
function TInjectTelegramBot.SendGame(const ChatId: Int64; const GameShortName: string;
  const DisableNotification: Boolean; const ReplyToMessageId: Int64; ReplyMarkup:
  IReplyMarkup; const ProtectContent: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SendGame');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendGame') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('game_short_name', GameShortName, '', True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('protect_content ', ProtectContent, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendGame');
end;
function TInjectTelegramBot.SetGameScore(const UserId, Score: Int64; const
  InlineMessageId: string; const Force, DisableEditMessage: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SetGameScore');
  Result := TtdMessage.Create(GetRequest.SetMethod('setGameScore') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('score', Score, 0, True) //
    .AddParameter('force', Force, False, False) //
    .AddParameter('disable_edit_message', DisableEditMessage, False, False) //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'SetGameScore');
end;
function TInjectTelegramBot.SetGameScore(const UserId, Score, ChatId, MessageId: Int64;
  const Force, DisableEditMessage: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'SetGameScore');
  Result := TtdMessage.Create(GetRequest.SetMethod('setGameScore') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('score', Score, 0, True) //
    .AddParameter('force', Force, False, False) //
    .AddParameter('disable_edit_message', DisableEditMessage, False, False) //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'SetGameScore');
end;
{$ENDREGION}
{ TTelegramBotHelper }

function TTelegramBotHelper.IsValidToken: Boolean;
const
  TOKEN_CORRECT = '/\d*:[\w\d-_]{35}/';
begin
  Result := TRegEx.IsMatch(Token, TOKEN_CORRECT, [roIgnoreCase]);
end; //1749861487:AAH61zWbmCsJNUhVTuSMbKzieictVcaT4Qo
end.

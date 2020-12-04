{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N-,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$MINSTACKSIZE $00004000}
{$MAXSTACKSIZE $00100000}
{$IMAGEBASE $00400000}
{$APPTYPE GUI}
{$WARN SYMBOL_DEPRECATED ON}
{$WARN SYMBOL_LIBRARY ON}
{$WARN SYMBOL_PLATFORM ON}
{$WARN SYMBOL_EXPERIMENTAL ON}
{$WARN UNIT_LIBRARY ON}
{$WARN UNIT_PLATFORM ON}
{$WARN UNIT_DEPRECATED ON}
{$WARN UNIT_EXPERIMENTAL ON}
{$WARN HRESULT_COMPAT ON}
{$WARN HIDING_MEMBER ON}
{$WARN HIDDEN_VIRTUAL ON}
{$WARN GARBAGE ON}
{$WARN BOUNDS_ERROR ON}
{$WARN ZERO_NIL_COMPAT ON}
{$WARN STRING_CONST_TRUNCED ON}
{$WARN FOR_LOOP_VAR_VARPAR ON}
{$WARN TYPED_CONST_VARPAR ON}
{$WARN ASG_TO_TYPED_CONST ON}
{$WARN CASE_LABEL_RANGE ON}
{$WARN FOR_VARIABLE ON}
{$WARN CONSTRUCTING_ABSTRACT ON}
{$WARN COMPARISON_FALSE ON}
{$WARN COMPARISON_TRUE ON}
{$WARN COMPARING_SIGNED_UNSIGNED ON}
{$WARN COMBINING_SIGNED_UNSIGNED ON}
{$WARN UNSUPPORTED_CONSTRUCT ON}
{$WARN FILE_OPEN ON}
{$WARN FILE_OPEN_UNITSRC ON}
{$WARN BAD_GLOBAL_SYMBOL ON}
{$WARN DUPLICATE_CTOR_DTOR ON}
{$WARN INVALID_DIRECTIVE ON}
{$WARN PACKAGE_NO_LINK ON}
{$WARN PACKAGED_THREADVAR ON}
{$WARN IMPLICIT_IMPORT ON}
{$WARN HPPEMIT_IGNORED ON}
{$WARN NO_RETVAL ON}
{$WARN USE_BEFORE_DEF ON}
{$WARN FOR_LOOP_VAR_UNDEF ON}
{$WARN UNIT_NAME_MISMATCH ON}
{$WARN NO_CFG_FILE_FOUND ON}
{$WARN IMPLICIT_VARIANTS ON}
{$WARN UNICODE_TO_LOCALE ON}
{$WARN LOCALE_TO_UNICODE ON}
{$WARN IMAGEBASE_MULTIPLE ON}
{$WARN SUSPICIOUS_TYPECAST ON}
{$WARN PRIVATE_PROPACCESSOR ON}
{$WARN UNSAFE_TYPE OFF}
{$WARN UNSAFE_CODE OFF}
{$WARN UNSAFE_CAST OFF}
{$WARN OPTION_TRUNCATED ON}
{$WARN WIDECHAR_REDUCED ON}
{$WARN DUPLICATES_IGNORED ON}
{$WARN UNIT_INIT_SEQ ON}
{$WARN LOCAL_PINVOKE ON}
{$WARN MESSAGE_DIRECTIVE ON}
{$WARN TYPEINFO_IMPLICITLY_ADDED ON}
{$WARN RLINK_WARNING ON}
{$WARN IMPLICIT_STRING_CAST ON}
{$WARN IMPLICIT_STRING_CAST_LOSS ON}
{$WARN EXPLICIT_STRING_CAST OFF}
{$WARN EXPLICIT_STRING_CAST_LOSS OFF}
{$WARN CVT_WCHAR_TO_ACHAR ON}
{$WARN CVT_NARROWING_STRING_LOST ON}
{$WARN CVT_ACHAR_TO_WCHAR ON}
{$WARN CVT_WIDENING_STRING_LOST ON}
{$WARN NON_PORTABLE_TYPECAST ON}
{$WARN XML_WHITESPACE_NOT_ALLOWED ON}
{$WARN XML_UNKNOWN_ENTITY ON}
{$WARN XML_INVALID_NAME_START ON}
{$WARN XML_INVALID_NAME ON}
{$WARN XML_EXPECTED_CHARACTER ON}
{$WARN XML_CREF_NO_RESOLVE ON}
{$WARN XML_NO_PARM ON}
{$WARN XML_NO_MATCHING_PARM ON}
{$WARN IMMUTABLE_STRINGS OFF}
unit TelegAPI.Bot.Impl;

{$I ..\Source\config.inc}

interface

uses
  Vcl.Dialogs,
  CoreAPI,
  CrossUrl.HttpClient,
  System.Classes,
  System.TypInfo,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  TelegAPI.Base,
  TelegAPI.Bot,
  TelegAPI.Types,
  TelegAPI.Types.Impl,
  TelegAPI.Types.Enums,
  TelegAPI.Types.ReplyMarkups,
  TelegAPI.Types.InlineQueryResults,
  TelegAPI.Logger,
  TelegAPI.Types.Passport,
  TelegAPI.Utils.JSON;

type
  TtgOnReceiveRawData = procedure(ASender: TObject; const AData: string) of object;

  TtgOnSendData = procedure(ASender: TObject; const AUrl, AData: string) of object;

  {TInjectTelegramBotBase}
  TInjectTelegramBotBase = class(TInjectTelegramAbstractComponent)
  strict private
    FLog: ILogger;
    FRequest: ItgRequestAPI;
    FOnRawData: TtgOnReceiveRawData;
    FOnSendData: TtgOnSendData;
  private
    function GetLogger: ILogger;
    procedure SetLogger(const Value: ILogger);
    function GetHttpCore: IcuHttpClient;
    procedure SetHttpCore(const Value: IcuHttpClient);
    function GetUrlAPI: string;
    procedure SetUrlAPI(const Value: string);
  protected
    function GetRequest: ItgRequestAPI;
    procedure DoInitApiCore; virtual;
    // Returns TJSONArray as method request result
    function GetJSONArrayFromMethod(const AValue: string): TJSONArray;
    // Returns response JSON from server as result of request
    function GetArrayFromMethod<TI: IInterface>(const TgClass: TBaseJsonClass;
      const AValue: string): TArray<TI>;
  public
    constructor Create(AOwner: TComponent); override;
    {$REGION 'Propriedades|Property|Свойства'}
    property Logger: ILogger read GetLogger write SetLogger;
    property HttpCore: IcuHttpClient read GetHttpCore write SetHttpCore;
    property UrlAPI: string read GetUrlAPI write SetUrlAPI;
    {$ENDREGION}

    {$REGION 'Eventos|Events|События'}
    property OnReceiveRawData: TtgOnReceiveRawData read FOnRawData write FOnRawData;
    property OnSendData: TtgOnSendData read FOnSendData write FOnSendData;
    {$ENDREGION}
  end;

  {TInjectTelegram}
  TInjectTelegram = class(TInjectTelegramBotBase, IInjectTelegramBot)
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
    function GetUpdates( //
      const Offset: Int64 = 0; //
      const Limit: Int64 = 100; //
      const Timeout: Int64 = 0; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL): TArray<
      ItgUpdate>; overload;

    function GetUpdates( //
      const JSON: string): TArray<ItgUpdate>; overload;

    function SetWebhook( //
      const Url: string; //
      const Certificate: TtgFileToSend = nil; //
      const IpAddress: String = '';
      const MaxConnections: Int64 = 40; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL;
      const DropPendingUpdates:	Boolean = False): Boolean;

    function DeleteWebhook(
      const DropPendingUpdates:	Boolean = False): Boolean;

    function GetWebhookInfo: ItgWebhookInfo;
{$ENDREGION}

{$REGION 'Basic methods'}
    function GetMe: ItgUser;

    function SendMessage( //
      const ChatId: TtgUserLink; //
      const Text: string; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function ForwardMessage( //
      const ChatId, FromChatId: TtgUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False): ITgMessage;

    function SendPhoto( //
      const ChatId: TtgUserLink; //
      const Photo: TtgFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendAudio( //
      const ChatId: TtgUserLink; //
      const Audio: TtgFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const Duration: Int64 = 0; //
      const Performer: string = ''; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendDocument( //
      const ChatId: TtgUserLink; //
      const Document: TtgFileToSend; //
      const Thumb: TtgFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const CaptionEntities: TArray<TtgMessageEntity> = [];
      const DisableContentTypeDetection: Boolean = False;
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendVideo( //
      const ChatId: TtgUserLink; //
      const Video: TtgFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const SupportsStreaming: Boolean = True; //
      const Duration: Int64 = 0; //
      const Width: Int64 = 0; //
      const Height: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendAnimation( //
      const ChatId: TtgUserLink; //
      const Animation: TtgFileToSend; //
      const Duration: Int64 = 0; //
      const Width: Int64 = 0; //
      const Height: Int64 = 0; //
      const Thumb: TtgFileToSend = nil; //
      const Caption: string = ''; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendVoice( //
      const ChatId: TtgUserLink; //
      const Voice: TtgFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const Duration: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendVideoNote( //
      const ChatId: TtgUserLink; //
      const VideoNote: TtgFileToSend; //
      const Duration: Int64 = 0; //
      const Length: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendLocation( //
      const ChatId: TtgUserLink; //
      const Location: TtgLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply: Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendVenue( //
      const ChatId: TtgUserLink; //
      const Venue: TtgVenue; //
      const Location: TtgLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendVenue2( //
      const ChatId: TtgUserLink; //
      const Venue: TtgVenue; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendContact( //
      const ChatId: TtgUserLink; //
      const Contact: TtgContact; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendPoll( ////Add By Ruan Diego Lacerda Menezes 13/04/2020
      const ChatId: TtgUserLink; //
      const Question: String; //Poll question, 1-255 characters
      const Options: Array of String; //
      const Is_Anonymous: Boolean = True; //
      const &type: TtgQuizType = TtgQuizType.qtRegular;//String = '{"regular"}'; //
      const Allows_Multiple_Answers: Boolean = False; //
      const Correct_Option_Id: Integer = 0;
      const Explanation: String = ''; //
      const Explanation_parse_mode: TtgParseMode = TtgParseMode.Default; //
      const Open_period : Integer = 0; //
      const Close_date: Integer= 0; //
      const Is_Closed: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendDice( ////Add By Ruan Diego Lacerda Menezes 13/04/2020
      const ChatId: TtgUserLink; //
      const Emoji: TtgEmojiType = TtgEmojiType.etDado;//
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SendChatAction( //
      const ChatId: TtgUserLink; //
      const Action: TtgSendChatAction): Boolean;

    function sendMediaGroup( //
      const ChatId: TtgUserLink; //
      const AMedia: TArray<TtgInputMedia>; //
      const ADisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0;
      const AllowSendingWithoutReply:	Boolean = False): TArray<ITgMessage>;

    function GetUserProfilePhotos( //
      const ChatId: TtgUserLink; //
      const Offset: Int64; //
      const Limit: Int64 = 100): ItgUserProfilePhotos;

    function GetFile(const FileId: string): ItgFile;

    function KickChatMember( //
      const ChatId: TtgUserLink; //
      const UserId: Int64; //
      const UntilDate: TDateTime = 0): Boolean;

    function UnbanChatMember( //
      const ChatId: TtgUserLink; //
      const UserId: Int64;
      const OnlyIfBanned:	Boolean): Boolean;

    function LeaveChat(const ChatId: TtgUserLink): Boolean;

    function GetChat(const ChatId: TtgUserLink): ItgChat;

    function GetChatAdministrators(const ChatId: TtgUserLink): TArray<ItgChatMember>;

    function GetChatMembersCount(const ChatId: TtgUserLink): Int64;

    function GetChatMember( //
      const ChatId: TtgUserLink; //
      const UserId: Int64): ItgChatMember;

    function AnswerCallbackQuery( //
      const CallbackQueryId: string; //
      const Text: string = ''; //
      const ShowAlert: Boolean = False; //
      const Url: string = ''; //
      const CacheTime: Int64 = 0): Boolean;
{$ENDREGION}

{$REGION 'BotCommands'}
    function SetMyCommands(Command: TArray<TtgBotCommand>): Boolean;
    function GetMyCommands: TArray<TtgBotCommand>;
    function LogOut: Boolean;
    function Close: Boolean;
{$ENDREGION 'BotCommands'}

{$REGION 'Updating messages'}
    function EditMessageText( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64; //
      const Text: string; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      ReplyMarkup: IReplyMarkup = nil): ITgMessage; overload;

    function EditMessageText( //
      const InlineMessageId: string; //
      const Text: string; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      ReplyMarkup: IReplyMarkup = nil): ITgMessage; overload;

    function EditMessageCaption( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64; //
      const Caption: string; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function EditMessageCaption( //
      const InlineMessageId: string; //
      const Caption: string; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function editMessageLiveLocation( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64; //
      const Location: TtgLocation; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function editMessageLiveLocation( //
      const InlineMessageId: string; //
      const Location: TtgLocation; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function stopMessageLiveLocation( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function stopMessageLiveLocation( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;

    function EditMessageReplyMarkup( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64; //
      ReplyMarkup: IReplyMarkup = nil): ITgMessage; overload;

    function EditMessageReplyMarkup( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): ITgMessage; overload;

    function DeleteMessage( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64): Boolean;
{$ENDREGION}

{$REGION 'Inline mode'}
    function AnswerInlineQuery( //
      const InlineQueryId: string; //
      const Results: TArray<TtgInlineQueryResult>; //
      const CacheTime: Int64 = 300; //
      const IsPersonal: Boolean = False; //
      const NextOffset: string = ''; //
      const SwitchPmText: string = ''; //
      const SwitchPmParameter: string = ''): Boolean;
{$ENDREGION}

{$REGION 'Payments'}
    function SendInvoice( //
      const ChatId: Int64; //
      const Title: string; //
      const Description: string; //
      const Payload: string; //
      const ProviderToken: string; //
      const StartParameter: string; //
      const Currency: string; //
      const Prices: TArray<TtgLabeledPrice>; //
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
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function AnswerShippingQueryGood( //
      const ShippingQueryId: string; //
      const ShippingOptions: TArray<TtgShippingOption>): Boolean;

    function AnswerShippingQueryBad( //
      const ShippingQueryId: string; //
      const ErrorMessage: string): Boolean;

    function AnswerPreCheckoutQueryGood( //
      const PreCheckoutQueryId: string): Boolean;

    function AnswerPreCheckoutQueryBad( //
      const PreCheckoutQueryId: string; //
      const ErrorMessage: string): Boolean;

    function AnswerPreCheckoutQuery( //
      const PreCheckoutQueryId: string; //
      const OK: Boolean;
      const ErrorMessage: string = ''): Boolean;

{$ENDREGION}

{$REGION 'Telegram Passport'}
    function SetPassportDataErrors( //
      const UserId: Int64; //
      const Errors: TArray<TtgEncryptedPassportElement>): Boolean;
{$ENDREGION 'Telegram Passport'}

{$REGION 'Games'}
    function SendGame( //
      const ChatId: Int64; //
      const GameShortName: string; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function SetGameScore( //
      const UserId: Int64; //
      const Score: Int64; //
      const InlineMessageId: string; //
      const Force: Boolean = False; //
      const DisableEditMessage: Boolean = False): ITgMessage; overload;

    function SetGameScore( //
      const UserId: Int64; //
      const Score: Int64; //
      const ChatId: Int64; //
      const MessageId: Int64; //
      const Force: Boolean = False; //
      const DisableEditMessage: Boolean = False): ITgMessage; overload;

    function GetGameHighScores( //
      const UserId: Int64; //
      const InlineMessageId: string = ''): TArray<ItgGameHighScore>; overload;

    function GetGameHighScores( //
      const UserId: Int64; //
      const ChatId: Int64 = 0; //
      const MessageId: Int64 = 0): TArray<ItgGameHighScore>; overload;
{$ENDREGION}

{$REGION 'Manage groups and channels'}
    function DeleteChatPhoto(const ChatId: TtgUserLink): Boolean;

    function ExportChatInviteLink(const ChatId: TtgUserLink): string;

    function PinChatMessage( //
      const ChatId: TtgUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False): Boolean;

    function SetChatDescription(const ChatId: TtgUserLink; const Description:
      string): Boolean;

    function SetChatPhoto(const ChatId: TtgUserLink; const Photo: TtgFileToSend): Boolean;

    function SetChatTitle(const ChatId: TtgUserLink; const Title: string): Boolean;

    function UnPinChatMessage(const ChatId: TtgUserLink; //
      const MessageId: Int64 = 0 ): Boolean;

    function UnPinAllChatMessages(const ChatId: TtgUserLink): Boolean;

    function CopyMessage( //
      const ChatId: TtgUserLink; //
      const FromChatId: TtgUserLink; //
      const MessageId: Int64;//
      const Caption: string; //
      const ParseMode: TtgParseMode = TtgParseMode.Default; //
      const CaptionEntities: TArray<TtgMessageEntity> = [];
      const DisableWebPagePreview: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): Int64;
{$ENDREGION}

{$REGION 'Manage users and admins'}
    function RestrictChatMember( //
      const ChatId: TtgUserLink; //
      const UserId: Int64; //
      const UntilDate: TDateTime = 0; //
      const CanSendMessages: Boolean = False; //
      const CanSendMediaMessages: Boolean = False; //
      const CanSendOtherMessages: Boolean = False; //
      const CanAddWebPagePreviews: Boolean = False): Boolean;

    function PromoteChatMember( //
      const ChatId: TtgUserLink; //
      const UserId: Int64; //
      const IsAnonymous: Boolean = False;
      const CanChangeInfo: Boolean = False; //
      const CanPostMessages: Boolean = False; //
      const CanEditMessages: Boolean = False; //
      const CanDeleteMessages: Boolean = False; //
      const CanInviteUsers: Boolean = False; //
      const CanRestrictMembers: Boolean = False; //
      const CanPinMessages: Boolean = False; //
      const CanPromoteMembers: Boolean = False): Boolean;
{$ENDREGION}

{$REGION 'Strickers'}
    function SendSticker( //
      const ChatId: TtgUserLink; //
      const Sticker: TtgFileToSend; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;

    function getStickerSet(const Name: string): TtgStickerSet;

    function uploadStickerFile(const UserId: Int64; const PngSticker:
      TtgFileToSend): ItgFile;

    function createNewStickerSet( //
      const UserId: Int64; //
      const Name, Title: string; //
      const PngSticker: TtgFileToSend; //
      const TgsSticker: TtgFileToSend; //
      const Emojis: string; //
      const ContainsMasks: Boolean = False; //
      const MaskPosition: TtgMaskPosition = nil): Boolean;

    function addStickerToSet( //
      const UserId: Int64; //
      const Name: string; //
      const PngSticker: TtgFileToSend; //
      const TgsSticker: TtgFileToSend; //
      const Emojis: string; //
      const MaskPosition: TtgMaskPosition = nil): Boolean;

    function setStickerPositionInSet(const Sticker: string; const Position:
      Int64): Boolean;

    function deleteStickerFromSet(const Sticker: string): Boolean;

    function setChatStickerSet(const ChatId: TtgUserLink; const StickerSetName:
      string): Boolean;

    function deleteChatStickerSet(const ChatId: TtgUserLink): Boolean;

    function setStickerSetThumb(
        const Name: string;
        const UserId: Int64;
        const Thumb: string): Boolean;

{$ENDREGION}
  published
    {$REGION 'Propriedades|Property|Свойства'}
    property Logger;
    property HttpCore;
    property Token: string read GetToken write SetToken;
    {$ENDREGION}

    {$REGION 'Eventos|Events|События'}
    property OnReceiveRawData;
    property OnSendData;
    {$ENDREGION}
  end;


implementation

uses
  REST.JSON,
  TelegAPI.Helpers;

constructor TInjectTelegramBotBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DoInitApiCore;
end;

procedure TInjectTelegramBotBase.DoInitApiCore;
begin
  FRequest := TtgCoreApi.Create;
  GetRequest.OnError :=
    procedure(E: Exception)
    begin
      Logger.Error('RequestAPI', E);
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
        else
          Result := LJSON.GetValue('result').ToString;
      finally
        LJSON.Free;
      end;
    end;
end;

function TInjectTelegramBotBase.GetArrayFromMethod<TI>(const TgClass: TBaseJsonClass;
  const AValue: string): TArray<TI>;
var
  LJsonArr: TJSONArray;
  I: Integer;
  GUID: TGUID;
  LException: Exception;
begin
  GUID := GetTypeData(TypeInfo(TI))^.GUID;
  // check for TI interface support
  if TgClass.GetInterfaceEntry(GUID) = nil then
  begin
    Logger.Fatal('GetArrayFromMethod: unsupported interface for ' + TgClass.ClassName);
  end;
  // stage 2: proceed data
  LJsonArr := GetJSONArrayFromMethod(AValue);
  if (not Assigned(LJsonArr)) or LJsonArr.Null then
    Exit(nil);
  try
    SetLength(Result, LJsonArr.Count);
    for I := 0 to High(Result) do
      TgClass.GetTgClass.Create(LJsonArr.Items[I].ToString).GetInterface(GUID, Result[I]);
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

function TInjectTelegramBotBase.GetRequest: ItgRequestAPI;
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

{ TInjectTelegram }

{$REGION 'Core'}

procedure TInjectTelegram.AssignTo(Dest: TPersistent);
begin
  if not (Assigned(Dest) or (Dest is TInjectTelegram)) then
    Exit;
  (Dest as TInjectTelegram).Token := Self.Token;
  (Dest as TInjectTelegram).HttpCore := Self.HttpCore;
  (Dest as TInjectTelegram).Logger := Self.Logger;
  (Dest as TInjectTelegram).OnReceiveRawData := Self.OnReceiveRawData;
  (Dest as TInjectTelegram).OnSendData := Self.OnSendData;
  // inherited AssignTo(Dest);
end;

constructor TInjectTelegram.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor TInjectTelegram.Create(const AToken: string; ACore: IcuHttpClient);
begin
  inherited Create(nil);
  Token := AToken;
  HttpCore := ACore;
end;

constructor TInjectTelegram.Create(const AToken: string);
begin
  inherited Create(nil);
  SetToken(AToken);
end;

function TInjectTelegram.GetToken: string;
begin
  Result := FToken;
end;

procedure TInjectTelegram.SetToken(const Value: string);
begin
  FToken := Value;
  GetRequest.SetToken(Token);
end;

{$ENDREGION}

{$REGION 'Getting updates'}

function TInjectTelegram.SetWebhook(
  const Url: string;
  const Certificate: TtgFileToSend;
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

function TInjectTelegram.GetWebhookInfo: ItgWebhookInfo;
begin
  Logger.Enter(Self, 'GetWebhookInfo');
  Result := TtgWebhookInfo.Create(GetRequest.SetMethod('getWebhookInfo').Execute);
  Logger.Leave(Self, 'GetWebhookInfo');
end;

function TInjectTelegram.GetUpdates(const Offset, Limit, Timeout: Int64; const
  AllowedUpdates: TAllowedUpdates): TArray<ItgUpdate>;
begin
  Result := GetArrayFromMethod<ItgUpdate>(TtgUpdate, GetRequest.SetMethod('getUpdates') //
    .AddParameter('offset', Offset, 0, False) //
    .AddParameter('limit', Limit, 100, False) //
    .AddParameter('timeout', Timeout, 0, False) //
    .AddParameter('allowed_updates', AllowedUpdates.ToString, '[]', False) //
    .Execute);
end;

function TInjectTelegram.GetUpdates(const JSON: string): TArray<ItgUpdate>;
begin
  Logger.Enter(Self, 'GetUpdates');
  Result := GetArrayFromMethod<ItgUpdate>(TtgUpdate, JSON);
  Logger.Leave(Self, 'GetUpdates');
end;

function TInjectTelegram.DeleteWebhook(const DropPendingUpdates:	Boolean): Boolean;
begin
  Logger.Enter(Self, 'DeleteWebhook');
  Result := GetRequest.SetMethod('deleteWebhook')
  .AddParameter('drop_pending_updates', DropPendingUpdates, False, False) //
  .ExecuteAsBool;
  Logger.Leave(Self, 'DeleteWebhook');
end;

procedure TInjectTelegram.DoInitApiCore;
const
  SERVER = 'https://api.telegram.org/bot';
begin
  inherited;
  GetRequest.UrlAPI := SERVER;
end;

{$ENDREGION}

{$REGION 'Basic methods'}

function TInjectTelegram.stopMessageLiveLocation(const ChatId: TtgUserLink; const
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

function TInjectTelegram.stopMessageLiveLocation(const InlineMessageId: string;
  ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'stopMessageLiveLocation');
  Result := GetRequest.SetMethod('stopMessageLiveLocation') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'stopMessageLiveLocation');
end;

function TInjectTelegram.UnbanChatMember(const ChatId: TtgUserLink; const UserId:
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

function TInjectTelegram.SendLocation(
  const ChatId: TtgUserLink;
  const Location: TtgLocation;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply: Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendLocation');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendLocation') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('latitude', Location.Latitude, 0, True) //
    .AddParameter('longitude', Location.Longitude, 0, True) //
    .AddParameter('live_period', Location.LivePeriod, 0, False) //
    .AddParameter('horizontal_accuracy', Location.HorizontalAccuracy, 0.0, False) //
    .AddParameter('heading', Location.Heading, 0, False) //
    .AddParameter('proximity_alert_radius', Location.ProximityAlertRadius, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendLocation');
end;

function TInjectTelegram.sendMediaGroup(const ChatId: TtgUserLink; const AMedia:
  TArray<TtgInputMedia>; const ADisableNotification: Boolean; const
  ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean): TArray<ITgMessage>;
var
  LRequest: ItgRequestAPI;
  LMedia: TtgInputMedia;
  LTmpJson: string;
begin
  Logger.Enter(Self, 'SendMediaGroup');
  LTmpJson := TJsonUtils.ArrayToJString<TtgInputMedia>(AMedia);
  LRequest := GetRequest.SetMethod('sendMediaGroup') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('media', LTmpJson, '[]', True) //
    .AddParameter('disable_notification', ADisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False)
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False); //

  for LMedia in AMedia do
  begin
    case LMedia.GetFileToSend.Tag of
      TtgFileToSendTag.FromFile:
        LRequest.AddRawFile(ExtractFileName(LMedia.GetFileToSend.Data), LMedia.GetFileToSend.Data);
      TtgFileToSendTag.FromStream:
        LRequest.AddRawStream(LMedia.GetFileToSend.Data, LMedia.GetFileToSend.Content,
          LMedia.GetFileToSend.Data);
    end;
  end;
  Result := GetArrayFromMethod<ITgMessage>(TTgMessage, LRequest.Execute);
  Logger.Leave(Self, 'SendMediaGroup');
end;

function TInjectTelegram.SendPhoto(
  const ChatId: TtgUserLink;
  const Photo: TtgFileToSend;
  const Caption: string;
  const ParseMode: TtgParseMode;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendPhoto');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendPhoto') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('photo', Photo, nil, True) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendPhoto');
end;

//Add By Ruan Diego Lacerda Menezes 13/04/2020
function TInjectTelegram.SendPoll( ////Add By Ruan Diego Lacerda Menezes 13/04/2020
  const ChatId: TtgUserLink; //
  const Question: String; //Poll question, 1-255 characters
  const Options: Array of String; //
  const Is_Anonymous: Boolean; //
  const &type: TtgQuizType;// {String = '{"regular"}'}; //
  const Allows_Multiple_Answers: Boolean; //
  const Correct_Option_Id: Integer;
  const Explanation: String; //
  const Explanation_parse_mode: TtgParseMode; //
  const Open_period : Integer; //
  const Close_date: Integer; //
  const Is_Closed: Boolean; //
  const DisableNotification: Boolean; //
  const ReplyToMessageId: Int64; //
  const AllowSendingWithoutReply:	Boolean;
    ReplyMarkup: IReplyMarkup): ITgMessage;
var
  LTmpJson: string;
begin

  Logger.Enter(Self, 'SendPoll');
  LTmpJson := TJsonUtils.ArrayStringToJString(Options);
  Result := TTgMessage.Create(GetRequest.SetMethod('sendPoll') //
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendPoll');
end;

function TInjectTelegram.SendMessage(const ChatId: TtgUserLink; const Text: string;
  const ParseMode: TtgParseMode; const DisableWebPagePreview,
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup:
  IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendMessage');

  Result := TTgMessage.Create(GetRequest.SetMethod('sendMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, False, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendMessage');
end;

//Corrigido erro de envio e falha nas coordenadas - atualizada em 03/05/2020 - by Ruan Diego
function TInjectTelegram.SendVenue(const ChatId: TtgUserLink; const Venue: TtgVenue;
  const Location: TtgLocation; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup): ITgMessage;
begin

  Logger.Enter(Self, 'SendVenue');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendVenue') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('latitude', Location.Latitude, 0, True) //
    .AddParameter('longitude', Location.Longitude, 0, True) //
    .AddParameter('title', Venue.sTitle, '', True) //
    .AddParameter('address', Venue.sAddress, '', True) //
    .AddParameter('foursquare_id', Venue.sFoursquareId, '', False) //
    .AddParameter('foursquare_type', Venue.sFoursquareType, '', False) //Add By Ruan Diego
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVenue');
end;

//Add Nova Função com a localização como propriedade do TtgVenue - By Ruan Diego
function TInjectTelegram.SendVenue2(const ChatId: TtgUserLink;
  const Venue: TtgVenue; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;const AllowSendingWithoutReply:	Boolean;
   ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendVenue');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendVenue') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('latitude', Venue.sLatitude, 0, True) //
    .AddParameter('longitude', Venue.sLongitude, 0, True) //
    .AddParameter('title', Venue.sTitle, '', True) //
    .AddParameter('address', Venue.sAddress, '', True) //
    .AddParameter('foursquare_id', Venue.sFoursquareId, '', False) //
    .AddParameter('foursquare_type', Venue.sFoursquareType, '', False) //Add By Ruan Diego
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVenue');
end;

function TInjectTelegram.SendVideo(const ChatId: TtgUserLink; const Video:
  TtgFileToSend; const Caption: string; const ParseMode: TtgParseMode; const
  SupportsStreaming: Boolean; const Duration, Width, Height: Int64; const
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendVideo');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendVideo') //
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVideo');
end;

function TInjectTelegram.SendVideoNote(const ChatId: TtgUserLink; const VideoNote:
  TtgFileToSend; const Duration, Length: Int64; const DisableNotification:
  Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendVideoNote');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendVideoNote') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('video_note', VideoNote, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('length', Length, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVideoNote');
end;

function TInjectTelegram.SendVoice(const ChatId: TtgUserLink; const Voice:
  TtgFileToSend; const Caption: string; const ParseMode: TtgParseMode; const
  Duration: Int64; const DisableNotification: Boolean; const ReplyToMessageId:
  Int64; const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendVoice');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendVoice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('voice', Voice, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVoice');
end;

//Novo Metodo Add - By Ruan Diego
function TInjectTelegram.SendAnimation( //
  const ChatId: TtgUserLink; //
  const Animation: TtgFileToSend; //
  const Duration: Int64; //
  const Width: Int64; //
  const Height: Int64; //
  const Thumb: TtgFileToSend; //
  const Caption: string; //
  const ParseMode: TtgParseMode; //
  const DisableNotification: Boolean; //
  const ReplyToMessageId: Int64; //
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendAnimation');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendAnimation') //
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendAnimation');
end;

function TInjectTelegram.SendAudio(const ChatId: TtgUserLink; const Audio:
  TtgFileToSend; const Caption: string; const ParseMode: TtgParseMode; const
  Duration: Int64; const Performer: string; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64; const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendAudio');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendAudio') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('audio', Audio, nil, True) //
    .AddParameter('duration', Duration, 0, False) //
    .AddParameter('performer', Performer, '', False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendAudio');
end;

function TInjectTelegram.SendChatAction(const ChatId: TtgUserLink; const Action:
  TtgSendChatAction): Boolean;
begin
  Logger.Enter(Self, 'SendChatAction');
  Result := GetRequest.SetMethod('sendChatAction') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('action', Action.ToString, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SendChatAction');
end;

function TInjectTelegram.SendContact(const ChatId: TtgUserLink; const Contact:
  TtgContact; const DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendContact');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendContact') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('phone_number', Contact.PhoneNumber, '', True) //
    .AddParameter('first_name', Contact.FirstName, '', True) //
    .AddParameter('last_name', Contact.LastName, '', False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendContact');
end;

//Add By Ruan Diego Lacerda Menezes 13/04/2020
function TInjectTelegram.SendDice(
  const ChatId: TtgUserLink; //
  const Emoji: TtgEmojiType = TtgEmojiType.etDado;//
  const DisableNotification: Boolean = False; //
  const ReplyToMessageId: Int64 = 0; //
  const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ITgMessage;
begin
  Logger.Enter(Self, 'SendDice');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendDice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('emoji', Emoji.ToString, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendDice');
end;

function TInjectTelegram.SendDocument(
  const ChatId: TtgUserLink;
  const Document: TtgFileToSend;
  const Thumb: TtgFileToSend; //
  const Caption: string;
  const ParseMode: TtgParseMode;
  const CaptionEntities: TArray<TtgMessageEntity>;
  const DisableContentTypeDetection: Boolean;
  const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ITgMessage;
var
  LTmpJson: String;
begin
  Logger.Enter(Self, 'SendDocument');
  LTmpJson := TJsonUtils.ArrayToJString<TtgMessageEntity>(CaptionEntities);
  Result := TTgMessage.Create(GetRequest.SetMethod('sendDocument') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('document', Document, nil, True) //
    .AddParameter('thumb', Thumb, nil, False) //
    .AddParameter('caption', Caption, '', False) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('caption_entities', LTmpJson, '[]', False) //
    .AddParameter('disable_content_type_detection', DisableContentTypeDetection, False, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendDocument');
end;

function TInjectTelegram.KickChatMember(const ChatId: TtgUserLink; const UserId:
  Int64; const UntilDate: TDateTime): Boolean;
begin
  Logger.Enter(Self, 'KickChatMember');
  Result := GetRequest.SetMethod('kickChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('until_date', UntilDate, 0, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'KickChatMember');
end;

function TInjectTelegram.LeaveChat(const ChatId: TtgUserLink): Boolean;
begin
  Logger.Enter(Self, 'LeaveChat');
  Result := GetRequest.SetMethod('leaveChat') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'LeaveChat');
end;

function TInjectTelegram.GetUserProfilePhotos(const ChatId: TtgUserLink; const
  Offset, Limit: Int64): ItgUserProfilePhotos;
begin
  Logger.Enter(Self, 'GetUserProfilePhotos');
  Result := TtgUserProfilePhotos.Create(GetRequest.SetMethod('getUserProfilePhotos') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('offset', Offset, 0, True) //
    .AddParameter('limit', Limit, 100, False) //
    .Execute);
  Logger.Leave(Self, 'GetUserProfilePhotos');
end;

function TInjectTelegram.GetMe: ItgUser;
begin
  Logger.Enter(Self, 'GetMe');
  Result := TtgUser.Create(GetRequest.SetMethod('getMe').Execute);
  Logger.Leave(Self, 'GetMe');
end;


function TInjectTelegram.SetMyCommands(Command: TArray<TtgBotCommand>): Boolean;
Var
  LTmpJson: String;
begin
  LTmpJson := TJsonUtils.ArrayToJString<TtgBotCommand>(Command);
  Logger.Enter(Self, 'SetMyCommands');
  Result := GetRequest.SetMethod('setMyCommands') //
    .AddParameter('command', LTmpJson, '[]', True).ExecuteAsBool;
  Logger.Leave(Self, 'SetMyCommands');
end;

function TInjectTelegram.GetMyCommands: TArray<TtgBotCommand>;
begin
  Logger.Enter(Self, 'GetMyCommands');
  Result := GetArrayFromMethod<TtgBotCommand>(TtgBotCommand,
    GetRequest.SetMethod('getMyCommands').Execute);
  Logger.Leave(Self, 'GetMyCommands');
end;

function TInjectTelegram.Close: Boolean;
begin
  Logger.Enter(Self, 'Close');
  Result := GetRequest.SetMethod('close').ExecuteAsBool;
  Logger.Leave(Self, 'Close');
end;

function TInjectTelegram.CopyMessage(const ChatId, FromChatId: TtgUserLink;
  const MessageId: Int64; const Caption: string; const ParseMode: TtgParseMode;
  const CaptionEntities: TArray<TtgMessageEntity>; const DisableWebPagePreview,
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply: Boolean; ReplyMarkup: IReplyMarkup): Int64;
Var
  LTmpJson: String;
begin

  Logger.Enter(Self, 'CopyMessage');

  LTmpJson := TJsonUtils.ArrayToJString<TtgMessageEntity>(CaptionEntities);

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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute.ToInt64;
  Logger.Leave(Self, 'CopyMessage');
end;

function TInjectTelegram.LogOut: Boolean;
begin
  Logger.Enter(Self, 'LogOut');
  Result := GetRequest.SetMethod('logOut').ExecuteAsBool;
  Logger.Leave(Self, 'LogOut');
end;

function TInjectTelegram.SetPassportDataErrors(const UserId: Int64;
  const Errors: TArray<TtgEncryptedPassportElement>): Boolean;
Var
  LTmpJson: String;
begin
  LTmpJson := TJsonUtils.ArrayToJString<TtgEncryptedPassportElement>(Errors);
  Logger.Enter(Self, 'SetPassportDataErrors');
  Result := GetRequest.SetMethod('setPassportDataErrors') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('errors', LTmpJson, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetPassportDataErrors');
end;

function TInjectTelegram.ForwardMessage(const ChatId, FromChatId: TtgUserLink;
  const MessageId: Int64; const DisableNotification: Boolean): ITgMessage;
begin
  Logger.Enter(Self, 'ForwardMessage');
  Result := TTgMessage.Create(GetRequest.SetMethod('forwardMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('from_chat_id', FromChatId, 0, True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('message_id', MessageId, 0, False) //
    .Execute);
  Logger.Leave(Self, 'ForwardMessage');
end;

function TInjectTelegram.GetChat(const ChatId: TtgUserLink): ItgChat;
begin
  Logger.Enter(Self, 'GetChat');
  Result := TtgChat.Create(GetRequest.SetMethod('getChat').//
    AddParameter('chat_id', ChatId, 0, True).Execute);
  Logger.Leave(Self, 'GetChat');
end;

function TInjectTelegram.GetChatAdministrators(const ChatId: TtgUserLink): TArray<
  ItgChatMember>;
begin
  Logger.Enter(Self, 'GetChatAdministrators');
  Result := GetArrayFromMethod<ItgChatMember>(TtgChatMember, GetRequest.SetMethod
    ('getChatAdministrators').AddParameter('chat_id', ChatId, 0, True).Execute);
  Logger.Leave(Self, 'GetChatAdministrators');
end;

function TInjectTelegram.GetChatMember(const ChatId: TtgUserLink; const UserId:
  Int64): ItgChatMember;
begin
  Logger.Enter(Self, 'GetChatMember');
  Result := TtgChatMember.Create(GetRequest.SetMethod('getChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'GetChatMember');
end;

function TInjectTelegram.GetChatMembersCount(const ChatId: TtgUserLink): Int64;
var
  LJSON: TJSONValue;
begin
  Logger.Enter(Self, 'GetChatMembersCount');
  LJSON := TJSONObject.ParseJSONValue(GetRequest.SetMethod('getChatMembersCount') //
    .AddParameter('chat_id', ChatId, 0, True).Execute);
  try
    if not LJSON.TryGetValue<Int64>(Result) then
      Result := 0;
  finally
    LJSON.Free;
  end;
  Logger.Leave(Self, 'GetChatMembersCount');
end;

function TInjectTelegram.GetFile(const FileId: string): ItgFile;
begin
  Logger.Enter(Self, 'GetFile');
  Result := TtgFile.Create(GetRequest.SetMethod('getFile') //
    .AddParameter('file_id', FileId, '', True).Execute);
  Logger.Leave(Self, 'GetFile');
end;

function TInjectTelegram.AnswerCallbackQuery(const CallbackQueryId, Text: string;
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

function TInjectTelegram.EditMessageText(const InlineMessageId, Text: string; const
  ParseMode: TtgParseMode; const DisableWebPagePreview: Boolean; ReplyMarkup:
  IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'EditMessageText');
  Result := TTgMessage.Create(GetRequest.SetMethod('editMessageText') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageText');
end;

function TInjectTelegram.EditMessageText(const ChatId: TtgUserLink; const MessageId:
  Int64; const Text: string; const ParseMode: TtgParseMode; const
  DisableWebPagePreview: Boolean; ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'EditMessageText');
  Result := TTgMessage.Create(GetRequest.SetMethod('editMessageText') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('text', Text, '', True) //
    .AddParameter('parse_mode', ParseMode.ToString, '', False) //
    .AddParameter('disable_web_page_preview', DisableWebPagePreview, False, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageText');
end;

function TInjectTelegram.DeleteMessage(const ChatId: TtgUserLink; const MessageId:
  Int64): Boolean;
begin
  Logger.Enter(Self, 'DeleteMessage');
  Result := GetRequest.SetMethod('deleteMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'DeleteMessage');
end;

function TInjectTelegram.EditMessageCaption(const ChatId: TtgUserLink; const
  MessageId: Int64; const Caption: string; const ParseMode: TtgParseMode;
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

function TInjectTelegram.EditMessageCaption(const InlineMessageId, Caption: string;
  const ParseMode: TtgParseMode; ReplyMarkup: IReplyMarkup): Boolean;
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
function TInjectTelegram.editMessageLiveLocation(const ChatId: TtgUserLink; const
  MessageId: Int64; const Location: TtgLocation; ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'editMessageLiveLocation');
  Result := GetRequest.SetMethod('editMessageLiveLocation') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('latitude', Location.Latitude, 0, True) //
    .AddParameter('longitude', Location.Longitude, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'editMessageLiveLocation');
end;

function TInjectTelegram.editMessageLiveLocation(const InlineMessageId: string;
  const Location: TtgLocation; ReplyMarkup: IReplyMarkup): Boolean;
begin
  Logger.Enter(Self, 'editMessageLiveLocation');
  Result := GetRequest.SetMethod('editMessageLiveLocation') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('latitude', Location.Latitude, 0, False) //
    .AddParameter('longitude', Location.Longitude, 0, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'editMessageLiveLocation');
end;

function TInjectTelegram.EditMessageReplyMarkup(const ChatId: TtgUserLink; const
  MessageId: Int64; ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'EditMessageReplyMarkup');
  Result := TTgMessage.Create(GetRequest.SetMethod('editMessageReplyMarkup') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageReplyMarkup');
end;

function TInjectTelegram.EditMessageReplyMarkup(const InlineMessageId: string;
  ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'EditMessageReplyMarkup');
  Result := TTgMessage.Create(GetRequest.SetMethod('editMessageReplyMarkup') //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'EditMessageReplyMarkup');
end;
{$ENDREGION}

{$REGION 'Manage groups and channels'}

function TInjectTelegram.DeleteChatPhoto(const ChatId: TtgUserLink): Boolean;
begin
  Logger.Enter(Self, 'DeleteChatPhoto');
  Result := GetRequest.SetMethod('deleteChatPhoto') //
    .AddParameter('chat_id', ChatId, 0, True).ExecuteAsBool;
  Logger.Leave(Self, 'DeleteChatPhoto');
end;

function TInjectTelegram.deleteChatStickerSet(const ChatId: TtgUserLink): Boolean;
begin
  Logger.Enter(Self, 'deleteChatStickerSet');
  Result := GetRequest.SetMethod('deleteChatStickerSet') //
    .AddParameter('chat_id', ChatId, 0, True)
    .ExecuteAsBool;
  Logger.Leave(Self, 'deleteChatStickerSet');
end;

function TInjectTelegram.ExportChatInviteLink(const ChatId: TtgUserLink): string;
begin
  Logger.Enter(Self, 'ExportChatInviteLink');
  Result := GetRequest.SetMethod('deleteChatStickerSet') //
    .AddParameter('chat_id', ChatId, 0, True).ExecuteAndReadValue;
  Logger.Leave(Self, 'ExportChatInviteLink');
end;

function TInjectTelegram.PinChatMessage(const ChatId: TtgUserLink; const MessageId:
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

function TInjectTelegram.SetChatDescription(const ChatId: TtgUserLink; const
  Description: string): Boolean;
begin
  Logger.Enter(Self, 'SetChatDescription');
  Result := GetRequest.SetMethod('setChatDescription') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('description', Description, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatDescription');
end;

function TInjectTelegram.SetChatPhoto(const ChatId: TtgUserLink; const Photo:
  TtgFileToSend): Boolean;
begin
  Logger.Enter(Self, 'SetChatPhoto');
  Result := GetRequest.SetMethod('setChatDescription') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('photo', Photo, nil, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatPhoto');
end;

function TInjectTelegram.setChatStickerSet(const ChatId: TtgUserLink; const
  StickerSetName: string): Boolean;
begin
  Logger.Enter(Self, 'setChatStickerSet');
  Result := GetRequest.SetMethod('setChatStickerSet') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('sticker_set_name', StickerSetName, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'setChatStickerSet');
end;

function TInjectTelegram.SetChatTitle(const ChatId: TtgUserLink; const Title:
  string): Boolean;
begin
  Logger.Enter(Self, 'SetChatTitle');
  Result := GetRequest.SetMethod('setChatTitle') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('title', Title, '', True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'SetChatTitle');
end;

function TInjectTelegram.UnPinAllChatMessages(
  const ChatId: TtgUserLink): Boolean;
begin
  Logger.Enter(Self, 'UnPinAllChatMessages');
  Result := GetRequest.SetMethod('unpinAllChatMessages')
    .AddParameter('chat_id', ChatId, 0, True)
    .ExecuteAsBool;
  Logger.Leave(Self, 'UnPinAllChatMessages');
end;

function TInjectTelegram.UnPinChatMessage(const ChatId: TtgUserLink;
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

function TInjectTelegram.PromoteChatMember( //
      const ChatId: TtgUserLink; //
      const UserId: Int64; //
      const IsAnonymous: Boolean;
      const CanChangeInfo: Boolean; //
      const CanPostMessages: Boolean; //
      const CanEditMessages: Boolean; //
      const CanDeleteMessages: Boolean; //
      const CanInviteUsers: Boolean; //
      const CanRestrictMembers: Boolean; //
      const CanPinMessages: Boolean; //
      const CanPromoteMembers: Boolean): Boolean;
begin
  Logger.Enter(Self, 'PromoteChatMember');
  Result := GetRequest.SetMethod('promoteChatMember') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('is_anonymous', IsAnonymous, False, False) //
    .AddParameter('can_change_info', CanChangeInfo, False, False) //
    .AddParameter('can_post_messages', CanPostMessages, False, False) //
    .AddParameter('can_edit_messages', CanEditMessages, False, False) //
    .AddParameter('can_delete_messages', CanDeleteMessages, False, False) //
    .AddParameter('can_invite_users', CanInviteUsers, False, False) //
    .AddParameter('can_restrict_members', CanRestrictMembers, False, False) //
    .AddParameter('can_pin_messages', CanPinMessages, False, False) //
    .AddParameter('can_promote_members', CanPromoteMembers, False, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'PromoteChatMember');
end;

function TInjectTelegram.RestrictChatMember(const ChatId: TtgUserLink; const UserId:
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

function TInjectTelegram.addStickerToSet(const UserId: Int64; const Name: string;
  const PngSticker: TtgFileToSend;const TgsSticker: TtgFileToSend; const Emojis: string; const MaskPosition:
  TtgMaskPosition): Boolean;
begin
  Logger.Enter(Self, 'addStickerToSet');
  Result := GetRequest.SetMethod('addStickerToSet') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('name', Name, '', False) //
    .AddParameter('png_sticker', PngSticker, nil, False) //
    .AddParameter('emojis', Emojis, '', False) //
    .AddParameter('mask_position', MaskPosition, nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'addStickerToSet');
end;

function TInjectTelegram.createNewStickerSet(const UserId: Int64; const Name, Title:
  string; const PngSticker: TtgFileToSend; const TgsSticker: TtgFileToSend; const Emojis: string; const
  ContainsMasks: Boolean; const MaskPosition: TtgMaskPosition): Boolean;
begin
  Logger.Enter(Self, 'createNewStickerSet');
  Result := GetRequest.SetMethod('createNewStickerSet') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('name', Name, '', False) //
    .AddParameter('title', Title, '', False) //
    .AddParameter('png_sticker', PngSticker, nil, False) //
    .AddParameter('emojis', Emojis, '', False) //
    .AddParameter('contains_masks', ContainsMasks, False, False) //
    .AddParameter('mask_position', MaskPosition, nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'createNewStickerSet');
end;

function TInjectTelegram.deleteStickerFromSet(const Sticker: string): Boolean;
begin
  Logger.Enter(Self, 'deleteStickerFromSet');
  Result := GetRequest.SetMethod('deleteStickerFromSet') //
    .AddParameter('sticker', Sticker, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'deleteStickerFromSet');
end;

function TInjectTelegram.getStickerSet(const Name: string): TtgStickerSet;
begin
  Logger.Enter(Self, 'getStickerSet');
  Result := TtgStickerSet.Create(GetRequest.SetMethod('getStickerSet') //
    .AddParameter('name', Name, '', True).Execute);
  Logger.Leave(Self, 'getStickerSet');
end;

function TInjectTelegram.SendSticker(const ChatId: TtgUserLink; const Sticker:
  TtgFileToSend; const DisableNotification: Boolean; const ReplyToMessageId:
  Int64; ReplyMarkup: IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendSticker');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendSticker') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('sticker', Sticker, nil, True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendSticker');
end;

function TInjectTelegram.setStickerPositionInSet(const Sticker: string; const
  Position: Int64): Boolean;
begin
  Logger.Enter(Self, 'setStickerPositionInSet');
  Result := GetRequest.SetMethod('deleteStickerFromSet') //
    .AddParameter('sticker', Sticker, '', True) //
    .AddParameter('position', Position, 0, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'setStickerPositionInSet');
end;

function TInjectTelegram.setStickerSetThumb(const Name: string;
  const UserId: Int64; const Thumb: string): Boolean;
begin
  Logger.Enter(Self, 'SetStickerSetThumb');
  Result := GetRequest.SetMethod('setStickerSetThumb') //
    .AddParameter('name	', Name, '', True)
    .AddParameter('user_id', UserId, 0, True)
    .AddParameter('thumb', Thumb, '', False).ExecuteAsBool;
  Logger.Leave(Self, 'SetStickerSetThumb');
end;

function TInjectTelegram.uploadStickerFile(const UserId: Int64; const PngSticker:
  TtgFileToSend): ItgFile;
begin
  Logger.Enter(Self, 'uploadStickerFile');
  Result := TtgFile.Create(GetRequest.SetMethod('uploadStickerFile') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('png_sticker', PngSticker, nil, True) //
    .Execute);
  Logger.Leave(Self, 'uploadStickerFile');
end;
{$ENDREGION}

{$REGION 'Inline mode'}

function TInjectTelegram.AnswerInlineQuery(const InlineQueryId: string; const
  Results: TArray<TtgInlineQueryResult>; const CacheTime: Int64; const
  IsPersonal: Boolean; const NextOffset, SwitchPmText, SwitchPmParameter: string):
  Boolean;
begin
  Logger.Enter(Self, 'AnswerInlineQuery');
  Result := GetRequest.SetMethod('answerInlineQuery') //
    .AddParameter('inline_query_id', InlineQueryId, '', True) //
    .AddParameter('results', TJsonUtils.ArrayToJString<TtgInlineQueryResult>(Results),
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

function TInjectTelegram.SendInvoice(const ChatId: Int64; const Title: string;
  const Description: string; const Payload: string; const ProviderToken: string;
  const StartParameter: string; const Currency: string; const Prices: TArray<
  TtgLabeledPrice>; const ProviderData: string; const PhotoUrl: string; const
  PhotoSize: Int64; const PhotoWidth: Int64; const PhotoHeight: Int64; const
  NeedName: Boolean; const NeedPhoneNumber: Boolean; const NeedEmail: Boolean;
  const NeedShippingAddress: Boolean; const SendPhoneNumberToProvider: Boolean;
      const SendRmailToProvider: Boolean; const IsFlexible: Boolean; const
  DisableNotification: Boolean; const ReplyToMessageId: Int64; ReplyMarkup:
  IReplyMarkup): ITgMessage;
Var
  LTmpJson : string;
begin
  LTmpJson := TJsonUtils.ArrayToJString<TtgLabeledPrice>(Prices);
 // LTmpJson := TJsonUtils.ArrayLebeledPriceToJString<TtgLabeledPrice>(Prices);

  Logger.Enter(Self, 'SendInvoice');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendInvoice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('title', Title, '', True) //
    .AddParameter('description', Description, '', True) //
    .AddParameter('payload', Payload, '', True) //
    .AddParameter('provider_token', ProviderToken, '', True) //
    .AddParameter('start_parameter', StartParameter, '', True) //
    .AddParameter('currency', Currency, '', True) //
    .AddParameter('prices', LTmpJson, '[{"label":"null","amount":"0"}]', True) //
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendInvoice');
end;

function TInjectTelegram.AnswerPreCheckoutQuery(
  const PreCheckoutQueryId: string;
  const OK: Boolean;
  const ErrorMessage: string): Boolean;
  var
    DefaultBol : Boolean;
begin
  DefaultBol := Not OK;
  Logger.Enter(Self, 'AnswerPreCheckoutQuery');
  Result := GetRequest.SetMethod('answerPreCheckoutQuery') //
    .AddParameter('pre_checkout_query_id', PreCheckoutQueryId, '0', True) //
    .AddParameter('ok', OK, DefaultBol, True) //
    .AddParameter('error_message', ErrorMessage, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQuery');
end;

function TInjectTelegram.AnswerPreCheckoutQueryBad(const PreCheckoutQueryId,
  ErrorMessage: string): Boolean;
begin
  Logger.Enter(Self, 'AnswerPreCheckoutQueryBad');
  Result := GetRequest.SetMethod('answerPreCheckoutQuery') //
    .AddParameter('pre_checkout_query_id', PreCheckoutQueryId, 0, True) //
    .AddParameter('ok', True, True, True) //
    .AddParameter('error_message', ErrorMessage, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQueryBad');
end;

function TInjectTelegram.AnswerPreCheckoutQueryGood(const PreCheckoutQueryId:
  string): Boolean;
begin
  Logger.Enter(Self, 'AnswerPreCheckoutQueryGood');
  Result := GetRequest.SetMethod('answerPreCheckoutQuery') //
    .AddParameter('pre_checkout_query_id', PreCheckoutQueryId, 0, True) //
    .AddParameter('ok', True, False, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQueryGood');
end;

function TInjectTelegram.AnswerShippingQueryBad(const ShippingQueryId, ErrorMessage:
  string): Boolean;
begin
  Logger.Enter(Self, 'AnswerShippingQueryBad');
  Result := GetRequest.SetMethod('answerShippingQuery') //
    .AddParameter('Shipping_query_id', ShippingQueryId, 0, True) //
    .AddParameter('ok', False, False, False) //
    .AddParameter('error_message', ErrorMessage, '', False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerShippingQueryBad');
end;

function TInjectTelegram.AnswerShippingQueryGood(const ShippingQueryId: string;
  const ShippingOptions: TArray<TtgShippingOption>): Boolean;
begin
  Logger.Enter(Self, 'AnswerShippingQueryGood');
  Result := GetRequest.SetMethod('answerShippingQuery') //
    .AddParameter('Shipping_query_id', ShippingQueryId, 0, True) //
    .AddParameter('ok', True, False, False) //
    .AddParameter('Shipping_options', TJsonUtils.ArrayToJString<
    TtgShippingOption>(ShippingOptions), '[]', True)    //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerShippingQueryGood');
end;

{$ENDREGION}

{$REGION 'Games'}

function TInjectTelegram.GetGameHighScores(const UserId: Int64; const
  InlineMessageId: string): TArray<ItgGameHighScore>;
begin
  Logger.Enter(Self, 'GetGameHighScores');
  Result := GetArrayFromMethod<ItgGameHighScore>(TtgGameHighScore, GetRequest.SetMethod
    ('getGameHighScores') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'GetGameHighScores');
end;

function TInjectTelegram.GetGameHighScores(const UserId, ChatId, MessageId: Int64):
  TArray<ItgGameHighScore>;
begin
  Logger.Enter(Self, 'GetGameHighScores');
  Result := GetArrayFromMethod<ItgGameHighScore>(TtgGameHighScore, GetRequest.SetMethod
    ('getGameHighScores') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('message_id', MessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'GetGameHighScores');
end;

function TInjectTelegram.SendGame(const ChatId: Int64; const GameShortName: string;
  const DisableNotification: Boolean; const ReplyToMessageId: Int64; ReplyMarkup:
  IReplyMarkup): ITgMessage;
begin
  Logger.Enter(Self, 'SendGame');
  Result := TTgMessage.Create(GetRequest.SetMethod('sendGame') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('game_short_name', GameShortName, '', True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendGame');
end;

function TInjectTelegram.SetGameScore(const UserId, Score: Int64; const
  InlineMessageId: string; const Force, DisableEditMessage: Boolean): ITgMessage;
begin
  Logger.Enter(Self, 'SetGameScore');
  Result := TTgMessage.Create(GetRequest.SetMethod('setGameScore') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('score', Score, 0, True) //
    .AddParameter('force', Force, False, False) //
    .AddParameter('disable_edit_message', DisableEditMessage, False, False) //
    .AddParameter('inline_message_id', InlineMessageId, 0, True) //
    .Execute);
  Logger.Leave(Self, 'SetGameScore');
end;

function TInjectTelegram.SetGameScore(const UserId, Score, ChatId, MessageId: Int64;
  const Force, DisableEditMessage: Boolean): ITgMessage;
begin
  Logger.Enter(Self, 'SetGameScore');
  Result := TTgMessage.Create(GetRequest.SetMethod('setGameScore') //
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

end.


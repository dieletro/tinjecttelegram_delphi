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
    function GetUpdates( //
      const Offset: Int64 = 0; //
      const Limit: Int64 = 100; //
      const Timeout: Int64 = 0; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL): TArray<
      ItdUpdate>; overload;
    function GetUpdates( //
      const JSON: string): TArray<ItdUpdate>; overload;
    function SetWebhook( //
      const Url: string; //
      const Certificate: TtdFileToSend = nil; //
      const IpAddress: String = '';
      const MaxConnections: Int64 = 40; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL;
      const DropPendingUpdates:	Boolean = False): Boolean;
    function DeleteWebhook(
      const DropPendingUpdates:	Boolean = False): Boolean;
    function GetWebhookInfo: ItdWebhookInfo;
{$ENDREGION}
{$REGION 'Basic methods'}
    function GetMe: ItdUser;
    function SendMessage( //
      const ChatId: TtdUserLink; //
      const Text: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableWebPagePreview: Boolean = False; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function ForwardMessage( //
      const ChatId, FromChatId: TtdUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False): ItdMessage;
    function SendPhoto( //
      const ChatId: TtdUserLink; //
      const Photo: TtdFileToSend; //
      const Caption: string = ''; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
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
    function SendVideoNote( //
      const ChatId: TtdUserLink; //
      const VideoNote: TtdFileToSend; //
      const Duration: Int64 = 0; //
      const Length: Int64 = 0; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendLocation( //
      const ChatId: TtdUserLink; //
      const Location: ItdLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply: Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendVenue( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const Location: ItdLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendVenue2( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendContact( //
      const ChatId: TtdUserLink; //
      const Contact: ItdContact; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendPoll( ////Add By Ruan Diego Lacerda Menezes 13/04/2020
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
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendDice( ////Add By Ruan Diego Lacerda Menezes 13/04/2020
      const ChatId: TtdUserLink; //
      const Emoji: TtdEmojiType = TtdEmojiType.etDado;//
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function SendChatAction( //
      const ChatId: TtdUserLink; //
      const Action: TtdSendChatAction): Boolean;
    function sendMediaGroup( //
      const ChatId: TtdUserLink; //
      const AMedia: TArray<TtdInputMedia>; //
      const ADisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0;
      const AllowSendingWithoutReply:	Boolean = False): TArray<ItdMessage>;
    function GetUserProfilePhotos( //
      const ChatId: TtdUserLink; //
      const Offset: Int64; //
      const Limit: Int64 = 100): ItdUserProfilePhotos;
    function GetFile(const FileId: string): ItdFile;
    function banChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const UntilDate: TDateTime = 0;
      const RevokeMessages: Boolean = False): Boolean;
    function UnbanChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64;
      const OnlyIfBanned:	Boolean): Boolean;
    function LeaveChat(const ChatId: TtdUserLink): Boolean;
    function GetChat(const ChatId: TtdUserLink): ItdChat;
    function GetChatAdministrators(const ChatId: TtdUserLink): TArray<ItdChatMember>;
    function GetChatMemberCount(const ChatId: TtdUserLink): Int64;
    function GetChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64): ItdChatMember;
    function AnswerCallbackQuery( //
      const CallbackQueryId: string; //
      const Text: string = ''; //
      const ShowAlert: Boolean = False; //
      const Url: string = ''; //
      const CacheTime: Int64 = 0): Boolean;
{$ENDREGION}
{$REGION 'BotCommands'}
    function SetMyCommands(
        const Command: TArray<TtdBotCommand>;
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''
    ): Boolean;
    function GetMyCommands(
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''
    ): TArray<ItdBotCommand>;
    function DeleteMyCommands(
        const scope: TtdBotCommandScope = TtdBotCommandScope.BotCommandScopeDefault;
        const language_code: string = ''
    ): Boolean;
    function LogOut: Boolean;
    function Close: Boolean;
{$ENDREGION 'BotCommands'}
{$REGION 'Updating messages'}
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
    function EditMessageCaption( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    function EditMessageCaption( //
      const InlineMessageId: string; //
      const Caption: string; //
      const ParseMode: TtdParseMode = TtdParseMode.Default; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    function editMessageLiveLocation( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const Location: ItdLocation; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    function editMessageLiveLocation( //
      const InlineMessageId: string; //
      const Location: ItdLocation; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    function stopMessageLiveLocation( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    function stopMessageLiveLocation( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): Boolean; overload;
    function EditMessageReplyMarkup( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
    function EditMessageReplyMarkup( //
      const InlineMessageId: string; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage; overload;
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
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function AnswerShippingQueryGood( //
      const ShippingQueryId: string; //
      const ShippingOptions: TArray<TtdShippingOption>): Boolean;
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
      const Errors: TArray<TtdEncryptedPassportElement>): Boolean;
{$ENDREGION 'Telegram Passport'}
{$REGION 'Games'}
    function SendGame( //
      const ChatId: Int64; //
      const GameShortName: string; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
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
    function GetGameHighScores( //
      const UserId: Int64; //
      const InlineMessageId: string = ''): TArray<ItdGameHighScore>; overload;
    function GetGameHighScores( //
      const UserId: Int64; //
      const ChatId: Int64 = 0; //
      const MessageId: Int64 = 0): TArray<ItdGameHighScore>; overload;
{$ENDREGION}
{$REGION 'Manage groups and channels'}
    function DeleteChatPhoto(const ChatId: TtdUserLink): Boolean;
    function ExportChatInviteLink(const ChatId: TtdUserLink): string;
    function PinChatMessage( //
      const ChatId: TtdUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False): Boolean;
    function SetChatDescription(const ChatId: TtdUserLink; const Description:
      string): Boolean;
    function SetChatPhoto(const ChatId: TtdUserLink; const Photo: TtdFileToSend): Boolean;
    function SetChatTitle(const ChatId: TtdUserLink; const Title: string): Boolean;
    function UnPinChatMessage(const ChatId: TtdUserLink; //
      const MessageId: Int64 = 0 ): Boolean;
    function UnPinAllChatMessages(const ChatId: TtdUserLink): Boolean;
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
    function banChatSenderChat(const ChatId: TtdUserLink; //
      const SenderChatId: Int64): boolean;
    function unbanChatSenderChat(const ChatId: TtdUserLink; //
      const SenderChatId: Int64): boolean;
{$ENDREGION}
{$REGION 'Manage users and admins'}
    function RestrictChatMember( //
      const ChatId: TtdUserLink; //
      const UserId: Int64; //
      const UntilDate: TDateTime = 0; //
      const CanSendMessages: Boolean = False; //
      const CanSendMediaMessages: Boolean = False; //
      const CanSendOtherMessages: Boolean = False; //
      const CanAddWebPagePreviews: Boolean = False): Boolean;
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
    function SendSticker( //
      const ChatId: TtdUserLink; //
      const Sticker: TtdFileToSend; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
    function getStickerSet(const Name: string): ItdStickerSet;
    function uploadStickerFile(const UserId: Int64; const PngSticker:
      TtdFileToSend): ItdFile;
    function createNewStickerSet( //
      const UserId: Int64; //
      const Name, Title: string; //
      const PngSticker: TtdFileToSend; //
      const TgsSticker: TtdFileToSend; //
      const Emojis: string; //
      const ContainsMasks: Boolean = False; //
      const MaskPosition: ItdMaskPosition = nil): Boolean;
    function addStickerToSet( //
      const UserId: Int64; //
      const Name: string; //
      const PngSticker: TtdFileToSend; //
      const TgsSticker: TtdFileToSend; //
      const Emojis: string; //
      const MaskPosition: ItdMaskPosition = nil): Boolean;
    function setStickerPositionInSet(const Sticker: string; const Position:
      Int64): Boolean;
    function deleteStickerFromSet(const Sticker: string): Boolean;
    function setChatStickerSet(const ChatId: TtdUserLink; const StickerSetName:
      string): Boolean;
    function deleteChatStickerSet(const ChatId: TtdUserLink): Boolean;
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
    .AddParameter('creates_join_request', creates_join_request.ToJSONBool, '', False) //
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
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .Execute);
  Logger.Leave(Self, 'SendLocation');
end;
function TInjectTelegramBot.sendMediaGroup(const ChatId: TtdUserLink; const AMedia:
  TArray<TtdInputMedia>; const ADisableNotification: Boolean; const
  ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean): TArray<ItdMessage>;
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
    .AddParameter('disable_notification', ADisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False)
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False); //
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
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
    ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendPoll');
end;
function TInjectTelegramBot.SendMessage(const ChatId: TtdUserLink; const Text: string;
  const ParseMode: TtdParseMode; const DisableWebPagePreview,
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup:
  IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'SendMessage');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendMessage') //
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
function TInjectTelegramBot.SendVenue(const ChatId: TtdUserLink; const Venue: ItdVenue;
  const Location: ItdLocation; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVenue');
end;
//Add Nova Função com a localização como propriedade do TtdVenue - By Ruan Diego
function TInjectTelegramBot.SendVenue2(const ChatId: TtdUserLink;
  const Venue: ItdVenue; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64;const AllowSendingWithoutReply:	Boolean;
   ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVenue');
end;
function TInjectTelegramBot.SendVideo(const ChatId: TtdUserLink; const Video:
  TtdFileToSend; const Caption: string; const ParseMode: TtdParseMode; const
  SupportsStreaming: Boolean; const Duration, Width, Height: Int64; const
  DisableNotification: Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVideo');
end;
function TInjectTelegramBot.SendVideoNote(const ChatId: TtdUserLink; const VideoNote:
  TtdFileToSend; const Duration, Length: Int64; const DisableNotification:
  Boolean; const ReplyToMessageId: Int64;
  const AllowSendingWithoutReply:	Boolean; ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendVideoNote');
end;
function TInjectTelegramBot.SendVoice(const ChatId: TtdUserLink; const Voice:
  TtdFileToSend; const Caption: string; const ParseMode: TtdParseMode; const
  Duration: Int64; const DisableNotification: Boolean; const ReplyToMessageId:
  Int64; const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendAnimation');
end;
function TInjectTelegramBot.SendAudio(const ChatId: TtdUserLink; const Audio:
  TtdFileToSend; const Caption: string; const ParseMode: TtdParseMode; const
  Duration: Int64; const Performer: string; const DisableNotification: Boolean;
  const ReplyToMessageId: Int64; const AllowSendingWithoutReply:	Boolean;
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendContact');
end;
//Add By Ruan Diego Lacerda Menezes 13/04/2020
function TInjectTelegramBot.SendDice(
  const ChatId: TtdUserLink; //
  const Emoji: TtdEmojiType = TtdEmojiType.etDado;//
  const DisableNotification: Boolean = False; //
  const ReplyToMessageId: Int64 = 0; //
  const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil): ItdMessage;
begin
  Logger.Enter(Self, 'SendDice');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendDice') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('emoji', Emoji.ToString, 0, False) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('allow_sending_without_reply', AllowSendingWithoutReply, False, False) //
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
  ReplyMarkup: IReplyMarkup): ItdMessage;
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
    .AddParameter('revoke_messages', RevokeMessages.ToJSONBool, 'False', False) //
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
  const AllowSendingWithoutReply: Boolean; ReplyMarkup: IReplyMarkup): Int64;
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
  const MessageId: Int64; const DisableNotification: Boolean): ItdMessage;
begin
  Logger.Enter(Self, 'ForwardMessage');
  Result := TtdMessage.Create(GetRequest.SetMethod('forwardMessage') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('from_chat_id', FromChatId, 0, True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('message_id', MessageId, 0, False) //
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
function TInjectTelegramBot.ExportChatInviteLink(const ChatId: TtdUserLink): string;
begin
  Logger.Enter(Self, 'ExportChatInviteLink');
  Result := GetRequest.SetMethod('deleteChatStickerSet') //
    .AddParameter('chat_id', ChatId, 0, True).ExecuteAndReadValue;
  Logger.Leave(Self, 'ExportChatInviteLink');
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
      const CanManageVoiceChats: Boolean = False;
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
    .AddParameter('can_manage_voice_chats', CanManageVoiceChats, False, False) //
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
  const Emojis: string; const MaskPosition:
  ItdMaskPosition): Boolean;
begin
  Logger.Enter(Self, 'addStickerToSet');
  Result := GetRequest.SetMethod('addStickerToSet') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('name', Name, '', False) //
    .AddParameter('png_sticker', PngSticker, nil, False) //
    .AddParameter('emojis', Emojis, '', False) //
    .AddParameter('mask_position', TtdMaskPosition(MaskPosition), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'addStickerToSet');
end;
function TInjectTelegramBot.createChatInviteLink(const ChatId: TtdUserLink;
  const name: String; const expire_date: TDateTime; const member_limit: Integer;
  const creates_join_request: boolean): ItdChatInviteLink;
begin
  Logger.Enter(Self, 'createChatInviteLink');
  Result := TtdChatInviteLink.Create(GetRequest.SetMethod('createChatInviteLink') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('name', name, '', False) //
    .AddParameter('expire_date', expire_date, 0, False) //
    .AddParameter('member_limit', member_limit, 0, False) //
    .AddParameter('creates_join_request', creates_join_request.ToJSONBool, '', False) //
    .Execute);
  Logger.Leave(Self, 'createChatInviteLink');
end;
function TInjectTelegramBot.createNewStickerSet(const UserId: Int64; const Name, Title:
  string; const PngSticker: TtdFileToSend; const TgsSticker: TtdFileToSend;
  const Emojis: string; const ContainsMasks: Boolean;
  const MaskPosition: ItdMaskPosition): Boolean;
begin
  Logger.Enter(Self, 'createNewStickerSet');
  Result := GetRequest.SetMethod('createNewStickerSet') //
    .AddParameter('user_id', UserId, 0, True) //
    .AddParameter('name', Name, '', False) //
    .AddParameter('title', Title, '', False) //
    .AddParameter('png_sticker', PngSticker, nil, False) //
    .AddParameter('emojis', Emojis, '', False) //
    .AddParameter('contains_masks', ContainsMasks, False, False) //
    .AddParameter('mask_position', TtdMaskPosition(MaskPosition), nil, False) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'createNewStickerSet');
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
  IReplyMarkup): ItdMessage;
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
    .AddParameter('need_name', NeedName.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('need_phone_number', NeedPhoneNumber.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('need_email', NeedEmail.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('need_shipping_address', NeedShippingAddress.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('send_phone_number_to_provider', SendPhoneNumberToProvider.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('send_email_to_provider', SendRmailToProvider.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('is_flexible', IsFlexible.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('disable_notification', DisableNotification.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
    .AddParameter('reply_markup', TInterfacedObject(ReplyMarkup), nil, False) //
    .Execute);
  Logger.Leave(Self, 'SendInvoice');
end;
function TInjectTelegramBot.AnswerPreCheckoutQuery(
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
    .AddParameter('ok', Ok.ToJSONBool , DefaultBol.ToJSONBool, True) //
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
    .AddParameter('ok', False.ToJSONBool, True.ToJSONBool, True) //
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
    .AddParameter('ok',True.ToJSONBool, False.ToJSONBool, True) //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerPreCheckoutQueryGood');
end;
function TInjectTelegramBot.AnswerShippingQueryBad(const ShippingQueryId, ErrorMessage:
  string): Boolean;
begin
  Logger.Enter(Self, 'AnswerShippingQueryBad');
  Result := GetRequest.SetMethod('answerShippingQuery') //
    .AddParameter('Shipping_query_id', ShippingQueryId, 0, True) //
    .AddParameter('ok',False.ToJSONBool, True.ToJSONBool, False) //
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
    .AddParameter('ok', True.ToJSONBool, False.ToJSONBool, False) //
    .AddParameter('Shipping_options', TJsonUtils.ArrayToJString<
    TtdShippingOption>(ShippingOptions), '[]', True)    //
    .ExecuteAsBool;
  Logger.Leave(Self, 'AnswerShippingQueryGood');
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
  IReplyMarkup): ItdMessage;
begin
  Logger.Enter(Self, 'SendGame');
  Result := TtdMessage.Create(GetRequest.SetMethod('sendGame') //
    .AddParameter('chat_id', ChatId, 0, True) //
    .AddParameter('game_short_name', GameShortName, '', True) //
    .AddParameter('disable_notification', DisableNotification, False, False) //
    .AddParameter('reply_to_message_id', ReplyToMessageId, 0, False) //
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
  TOKEN_CORRECT = '\d*:[\w\d-_]{35}';
begin
  Result := TRegEx.IsMatch(Token, TOKEN_CORRECT, [roIgnoreCase]);
end;
end.

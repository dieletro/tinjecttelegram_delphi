unit TinjectTelegram.Bot;
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
    function GetUpdates( //
      const Offset: Int64 = 0; //
      const Limit: Int64 = 100; //
      const Timeout: Int64 = 0; //
      const AllowedUpdates: TAllowedUpdates = UPDATES_ALLOWED_ALL)
      : TArray<ItdUpdate>; overload;
    function GetUpdates(const JSON: string): TArray<ItdUpdate>; overload;

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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

    function ForwardMessage( //
      const ChatId, FromChatId: TtdUserLink; //
      const MessageId: Int64; //
      const DisableNotification: Boolean = False;
      const ProtectContent: Boolean = False): ItdMessage;

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

    function SendLocation( //
      const ChatId: TtdUserLink; //
      const Location: ItdLocation; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply: Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

    function SendVenue( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const Location: ItdLocation; //Add Para Testes
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

    function SendVenue2( //
      const ChatId: TtdUserLink; //
      const Venue: ItdVenue; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

    function SendContact( //
      const ChatId: TtdUserLink; //
      const Contact: ItdContact; //
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

    function SendDice( //
      const ChatId: TtdUserLink; //
      const Emoji: TtdEmojiType = TtdEmojiType.etDado;//
      const DisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0; //
      const AllowSendingWithoutReply:	Boolean = False;
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

    function SendChatAction( //
      const ChatId: TtdUserLink; //
      const Action: TtdSendChatAction): Boolean;

    function sendMediaGroup( //
      const ChatId: TtdUserLink; //
      const AMedia: TArray<TtdInputMedia>; //
      const ADisableNotification: Boolean = False; //
      const ReplyToMessageId: Int64 = 0;
      const AllowSendingWithoutReply:	Boolean = False;
      const ProtectContent: Boolean = False): TArray<ItdMessage>;

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

    function GetChatAdministrators(const ChatId: TtdUserLink)
      : TArray<ItdChatMember>;

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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

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
      const ErrorMessage: string): Boolean;
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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): ItdMessage;

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

    function SetChatDescription(const ChatId: TtdUserLink;
      const Description: string): Boolean;

    function SetChatPhoto(const ChatId: TtdUserLink;
      const Photo: TtdFileToSend): Boolean;

    function SetChatTitle(const ChatId: TtdUserLink;
      const title: string): Boolean;

    function UnPinChatMessage(
      const ChatId: TtdUserLink; //
      const MessageId: Int64 ): Boolean;

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
      ReplyMarkup: IReplyMarkup = nil;
      const ProtectContent: Boolean = False): Int64;

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

    function uploadStickerFile(const UserId: Int64;
      const PngSticker: TtdFileToSend): ItdFile;

    function createNewStickerSet( //
      const UserId: Int64; //
      const Name, title: string; //
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

    function setStickerPositionInSet(const Sticker: string;
      const Position: Int64): Boolean;

    function deleteStickerFromSet(const Sticker: string): Boolean;

    function setChatStickerSet(const ChatId: TtdUserLink;
      const StickerSetName: string): Boolean;

    function deleteChatStickerSet(const ChatId: TtdUserLink): Boolean;

    function setStickerSetThumb(
        const Name: string;
        const UserId: Int64;
        const Thumb: string): Boolean;
{$ENDREGION}
    property Token: string read GetToken write SetToken;
    property Logger: ILogger read GetLogger write SetLogger;
    property HttpCore: IcuHttpClient read GetHttpCore write SetHttpCore;
  end;
Implementation
End.




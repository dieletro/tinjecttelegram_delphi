unit TInjectTelegram.Types;
interface
uses
  REST.Json.Types,
  System.Classes,
  TinjectTelegram.Types.Enums,
  TinjectTelegram.Types.Passport, Vcl.Graphics;
type
  ItdUser = interface
    ['{EEE1275B-F21B-476F-9F0C-768C702FF34B}']
    function ID: Int64;
    function IsBot: Boolean;
    function FirstName: string;
    function LastName: string;
    function Username: string;
    function LanguageCode: string;
    function isPremium: Boolean;
    function AddedToAttachmentMenu: string;
    function CanJoinGroups: Boolean;           //can_join_groups	Boolean	                Optional. True, if the bot can be invited to groups. Returned only in getMe.
    function CanReadAllGroupMessages: Boolean; //can_read_all_group_messages	Boolean	    Optional. True, if privacy mode is disabled for the bot. Returned only in getMe.
    function SupportsInlineQueries: Boolean;   //supports_inline_queries	Boolean	        Optional. True, if the bot supports inline queries. Returned only in
  end;

  ItdChatMember = interface
    ['{BE073F97-DA34-43E6-A15E-14A2B90CAB7E}']
  end;

  ItdChatPhoto = interface
    ['{011E7CC4-8777-4E0F-95A6-6E5C87461DCD}']
    function SmallFileId: string;
    function SmallFileUniqueId: string;
    function BigFileId: string;
    function BigFileUniqueId: string;
  end;
  ItdMessage = interface;
  ItdLocation = interface;
  ItdChatLocation = interface
    ['{718CA534-E831-41F8-A976-68501F6DCA02}']
    function Location: ItdLocation;
    function Address:	String; //Limit of a 64 character
  end;
  ItdChatPermissions = interface;
  ItdChat = interface
    ['{5CE94B3E-312E-48FA-98A4-4C34E16A5DC7}']
    function ID: Int64;
    function TypeChat: TtdChatType;
    function Title: string;
    function Username: string;
    function FirstName: string;
    function LastName: string;
    function AllMembersAreAdministrators: Boolean;
    function Photo: ItdChatPhoto;
    function Bio:	String;
    function HasPrivateForwards: Boolean;
    function JoinToSendMessages: Boolean; //New
    function JoinByRequest: Boolean;      //New
    function Description: string;
    function InviteLink: string;
    function PinnedMessage: ItdMessage;
    function Permissions: ItdChatPermissions;
    function SlowModeDelay:	Integer;
    function MessageAutoDeleteTime: integer;
    function HasProtectedContent: boolean;
    function StickerSetName: string;
    function CanSetStickerSet: Boolean;
    function LinkedChatId:	Integer;
    function location: ItdChatLocation;
    function IsGroup: Boolean;
    function ToJSonStr: String;
    function ToString: String;
  end;
  ItdMessageEntity = interface
    ['{0F510BB7-8436-426E-8ECC-46742E3183E1}']
    function TypeMessage: TtdMessageEntityType;
    function Offset: Int64;
    function Length: Int64;
    function Url: string;
    function User: ItdUser;
    function language: string;
  end;
  ItdFile = interface
    ['{7A0DE9B9-939C-4079-B6A5-997AEA9497C9}']
    function FileId: string;
    function FileUniqueId: string; //new
    function FileSize: Int64;
    function FilePath: string;
    function CanDownload: Boolean;
    function GetFileUrl(const AToken: string): string;
  end;
  ItdPhotoSize = interface(ItdFile)
    ['{FF71291C-4E00-483E-8363-AF160CE78A4F}']
    function Width: Int64;
    function Height: Int64;
  end;
  ItdAudio = interface(ItdFile)
    ['{8220DE57-2A5E-4B77-8B62-A3268E15D938}']
    function Duration: Int64;
    function Performer: string;
    function Title: string;
    function FileName: string;
    function MimeType: string;
    function Thumb: ItdPhotoSize;
  end;
  ItdDocument = interface(ItdFile)
    ['{2B4DF418-FE55-490B-B119-46B9CB846609}']
    function Thumb: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  ItdMaskPosition = interface
    ['{D74500FF-8332-4BDF-BC26-9854A2D10529}']
    function Point: TtdMaskPositionPoint;
    function XShift: Single;
    function YShift: Single;
    function Scale: Single;
  end;
  ItdSticker = interface(ItdFile)
    ['{C2598C8D-506F-4208-80AA-ED2731C92192}']
    function Width: Int64;
    function Height: Int64;
    function is_animated:	Boolean;
    function is_video:	Boolean;
    function Thumb: ItdPhotoSize;
    function Emoji: string;
    function SetName: string;
    function PremiumAnimation: ItdFile;
    function MaskPosition: ItdMaskPosition;
  end;
  ItdStickerSet = interface
    ['{FCE66210-3EFF-4D97-9077-473AAFE9FC97}']
    function Name: string;
    function Title: string;
    function is_animated:	Boolean;
    function is_video:	Boolean;
    function ContainsMasks: Boolean;
    function Stickers: TArray<ItdSticker>;
    function Thumb: ItdPhotoSize;
  end;
  ItdVideo = interface(ItdFile)
    ['{520EB672-788A-4B7B-9BD9-1A569FD7C417}']
    function Width: Int64;
    function Height: Int64;
    function Duration: Int64;
    function Thumb: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  ItdVideoNote = interface(ItdFile)
    ['{D15B034D-9C4E-459A-9735-E63973813C6F}']
    function Length: Int64;
    function Duration: Int64;
    function Thumb: ItdPhotoSize;
  end;
  ItdVoice = interface(ItdFile)
    ['{99D91D3C-FC16-40CA-BA72-EFA8F5D0F5F9}']
    function Duration: Int64;
    function MimeType: string;
  end;
  ItdContact = interface
    ['{57113A43-41E0-4846-9CBA-A355400E3938}']
    function PhoneNumber: string;
    function FirstName: string;
    function LastName: string;
    function UserId: Int64;
  end;
  ItdPollOption = interface
    ['{2D275027-A366-4D2E-A211-176A17DF2880}']
    function text : String;
    function voter_count: String;
  end;
  ItdPollAnswer = interface
    ['{E9FDBD08-6728-44AC-B9F8-31FAF9CD8669}']
    function poll_id: String;
    function user: ItdUser;
    function option_ids: TArray<Integer>;
  end;
  ItdPoll = interface
    ['{6FD83DB0-02CA-4840-9A40-CB257589EC3B}']
    function id : String;
    function question: String;
    function options: TArray<ItdPollOption>;
    function total_voter_count: Integer;
    function is_closed: Boolean;
    function is_anonymous: Boolean;
    function &type: String;
    function allows_multiple_answers: Boolean;
    function correct_option_id: Integer;
  end;
  ItdDice = interface
    ['{2B88A5D6-F4B6-40D5-A324-52B2B7CE999C}']
    function Emoji:	String; //	Emoji on which the dice throw animation is based
    function value: Integer;
  end;
  ItdLocation = interface
    ['{6FE14ED9-0C53-4C24-8033-390A5F31B414}']
    //
    function GetLongitude: Single;
    function GetLatitude: Single;
    procedure SetLatitude(const Value: Single);
    procedure SetLongitude(const Value: Single);
    //New in API 5.0
    function GetHorizontalAccuracy: Single;
    procedure SetHorizontalAccuracy(const Value: Single);
    function GetLivePeriod: Integer;
    procedure SetLivePeriod(const Value: Integer);
    function GetHeading: Integer;
    procedure SetHeading(const Value: Integer);
    function GetProximityAlertRadius: Integer;
    procedure SetProximityAlertRadius(const Value: Integer);
    //
    property Longitude: Single read GetLongitude write SetLongitude;
    property Latitude: Single read GetLatitude write SetLatitude;
    //New in API 5.0
    property horizontal_accuracy: Single read GetHorizontalAccuracy write SetHorizontalAccuracy;
    property live_period: Integer read GetLivePeriod write SetLivePeriod;
    property heading: Integer read GetHeading write SetHeading;
    property proximity_alert_radius: Integer read GetProximityAlertRadius write SetProximityAlertRadius;
  end;
  //Atualizado para versão 4.8
  ItdVenue = interface
    ['{26E74395-EAA1-4668-BB6A-A2B8F61DE6BF}']
    function Location: ItdLocation;
    function Title: string;
    function Address: string;
    function FoursquareId: string;
    function FoursquareType: string;
    //New in API 5.0
    function google_place_id: string;
    function google_place_type: string;
  end;
  //New in API 5.0
  ItdProximityAlertTriggered = Interface
    ['{6D51B8A0-575C-491C-A5A0-E77AEAD44952}']
    function traveler: ItdUser;
    function watcher: ItdUser;
    function distance: Integer;
  End;
  ItdAnimation = interface
    ['{A0C6E374-590C-469B-AC76-F91135899FC5}']
    function FileId: string;
    function Thumb: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
    function FileSize: Int64;
  end;
  ItdGameHighScore = interface
    ['{19B46591-74A9-425F-BD3E-8342CE0B61C9}']
    function Position: Int64;
    function User: ItdUser;
    function Score: Int64;
  end;
  ItdGame = interface
    ['{29F4A7BE-07AB-4F9C-B7AE-1058B65F3AAD}']
    function Title: string;
    function Description: string;
    function Photo: TArray<ItdPhotoSize>;
    function Text: string;
    function TextEntities: TArray<ItdMessageEntity>;
    function Animation: ItdAnimation;
  end;
  ItdInvoice = interface
    ['{1D8923E1-068C-4747-84DE-A1B3B4674FD3}']
    function Title: string;
    function Description: string;
    function StartParameter: string;
    function Currency: string;
    function TotalAmount: Int64;
  end;
  ItdOrderInfo = interface;
  ItdSuccessfulPayment = interface
    ['{B2BE36C2-61F9-4D4B-AB9D-75BB524661AB}']
    function Currency: string;
    function TotalAmount: Int64;
    function InvoicePayload: string;
    function ShippingOptionId: string;
    function OrderInfo: ItdOrderInfo;
    function TelegramPaymentChargeId: string;
    function ProviderPaymentChargeId: string;
  end;
  ItdChatInviteLink = Interface //New in API 5.1
    ['{0F5B2D9E-8372-496E-9D30-7454D67D5F29}']
    function invite_link:	String;
    function creator:	ItdUser;
    function creates_join_request: Boolean;
    function is_primary:	Boolean;
    function is_revoked:	Boolean;
    function name: String;
    function expire_date:	{Integer}TDateTime;
    function member_limit:	Integer;
    function pending_join_request_count: Integer;
  End;
  //New Methodo in de version 5.0.1
  ItdChatPermissions = interface
    ['{D6EDBDCF-30DE-4597-B39B-5E31FFBF8E68}']
    function CanSendMessages:	Boolean;
    function CanSendMediaMessages: Boolean;
    function CanSendPolls:	Boolean;
    function CanSendOtherMessages: Boolean;
    function CanAddWebPagePreviews:	Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers:	Boolean;
    function CanPinMessages:	Boolean;
  end;
  ItdChatJoinRequest = interface //New in API 5.4
    ['{1C15162D-4CB0-4F06-A1ED-A5987EF9C85A}']
    function chat:	ItdChat;
    function from:	ItdUser;
    function date:	TDateTime; {Integer Unix Time}
    function bio:	String;
    function invite_link:	ItdChatInviteLink;
  end;
  ItdChatMemberUpdated = Interface //New in API 5.1
    ['{C88B26D2-29F1-4EB9-B812-7FF7A4E73212}']
    function chat:	ItdChat;
    function from:	ItdUser;
    function date:	{Integer Unix Time}TDateTime;
    function old_chat_member:	ItdChatMember;
    function new_chat_member:	ItdChatMember;
    function invite_link:	ItdChatInviteLink;
  End;
  ItdVideoChatScheduled = Interface //New in API 5.2
    ['{94AF9767-8E9E-4FE8-96AC-BC27A0853E2A}']
    function start_date:	TDateTime; //Point in time (Unix timestamp) when the voice chat is supposed to be started by a chat administrator
  End;
  ItdVideoChatStarted = Interface //New in API 5.1
    ['{9877BC33-72C7-4BC9-B462-C1D5E90EF902}']
  End;
  ItdVideoChatEnded = Interface //New in API 5.1
    ['{B769F63E-11FA-42D0-9DAF-6AC9B41FB5E5}']
    function duration:	Integer;
  End;
  ItdVideoChatParticipantsInvited = Interface //New in API 5.1
    ['{7F82D50A-0FED-4E80-882B-16125D169627}']
    function Users:	TArray<ItdUser>;
  End;
  ItdMessageAutoDeleteTimerChanged = Interface
    ['{DC738F55-8786-4DB2-B3EC-2EEEBA369665}']
    function message_auto_delete_time: TDateTime;
  End;
  IReplyMarkup = interface
    ['{4DCF23BA-8A37-46EF-A832-F325532B509A}']
  end;

  ItdInlineKeyboardMarkup = interface
    ['{62153B8C-D895-418A-BB2A-F82C36BFD276}']
  end;

  ItdWebAppData = interface;

  ItdMessage = interface
    ['{66BC2558-00C0-4BDD-BDDE-E83249787B30}']
    function MessageId: Int64;
    function From: ItdUser;
      function SenderChat: ItdChat;
    function Date: TDateTime;
    function Chat: ItdChat;
    function ForwardFrom: ItdUser;
    function ForwardFromChat: ItdChat;
    function ForwardFromMessageId: Int64;
    function ForwardSignature: string;
    function ForwardSenderName: String;
    function ForwardDate: TDateTime;
    function IsAutomaticForward: boolean;
    function ReplyToMessage: ItdMessage;
    function ViaBot : ItdUser;
    function EditDate: TDateTime;
    function HasProtectedContent: boolean;
    function MediaGroupId: string;
    function AuthorSignature: string;
    function Text: string;
    function Entities: TArray<ItdMessageEntity>;
    function Animation : ItdAnimation;
    function Audio: ItdAudio;
    function Document: ItdDocument;
    function Photo: TArray<ItdPhotoSize>;
    function Sticker: ItdSticker;
    function Video: ItdVideo;
    function VideoNote: ItdVideoNote;
    function Voice: ItdVoice;
    function Caption: string;
    function CaptionEntities: TArray<ItdMessageEntity>;
    function Contact: ItdContact;
    function Dice: ItdDice;
    function Game: ItdGame;
    function Poll: ItdPoll;
    function Venue: ItdVenue;
    function Location: ItdLocation;
    function NewChatMembers: TArray<ItdUser>;
    function LeftChatMember: ItdUser;
    function NewChatTitle: string;
    function NewChatPhoto: TArray<ItdPhotoSize>;
    function DeleteChatPhoto: Boolean;
    function GroupChatCreated: Boolean;
    function SupergroupChatCreated: Boolean;
    function ChannelChatCreated: Boolean;
    function MessageAutoDeleteTimerChanged: ItdMessageAutoDeleteTimerChanged;
    function MigrateToChatId: Int64;
    function MigrateFromChatId: Int64;
    function PinnedMessage: ItdMessage;
    function Invoice: ItdInvoice;
    function SuccessfulPayment: ItdSuccessfulPayment;
    function ConnectedWebsite: string;
    function PassportData: ItdPassportData;
    function ProximityAlertTriggered: ItdProximityAlertTriggered;
    function VideoChatScheduled: ItdVideoChatScheduled;
    function VideoChatStarted: ItdVideoChatStarted;
    function VideoChatEnded: ItdVideoChatEnded;
    function VideoChatParticipantsInvited: ItdVideoChatParticipantsInvited;
    function WebAppData: ItdWebAppData;
    function ReplyMarkup : IReplyMarkup;
    function NewChatMember: ItdUser;  //Resource...
    function &Type: TtdMessageType;   //Resource...
    function IsCommand(const AValue: string): Boolean;  //Resource...
  end;
  ItdMessageID = interface
    ['{8F988303-9873-47DF-969E-E6F72391E214}']
    function MessageId: Int64;
  end;
  ItdUserProfilePhotos = interface
    ['{DD667B04-15A3-47B1-A729-C75ED5BFE719}']
    function TotalCount: Int64;
    function Photos: TArray<TArray<ItdPhotoSize>>;
  end;
  ItdResponseParameters = interface
    ['{24701677-9BEB-42ED-8400-F465E4B2AECA}']
    function MigrateToChatId: Int64;
    function RetryAfter: Int64;
  end;
  ItdInlineQuery = interface
    ['{5DDE73CE-ABDF-47CE-8989-B62DF0543B02}']
    function ID: string;
    function From: ItdUser;
    function Query: string;
    function Offset: string;
    function chat_type:	TtdChatType; //	Optional. Type of the chat, from which the inline query was sent. Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”. The chat type should be always known for requests sent from official clients and most third-party clients, unless the request was sent from a secret chat
    function location:	ItdLocation; //Optional. Sender location, only for bots that request user location
  end;
  ItdChosenInlineResult = interface
    ['{0A293C7F-922D-4D9A-9CED-046942A20377}']
    function ResultId: string;
    function From: ItdUser;
    function Location: ItdLocation;
    function InlineMessageId: string;
    function Query: string;
  end;
  ItdCallbackQuery = interface
    ['{83D9BF94-033A-44BA-8AD5-DCE25937A7B3}']
    function ID: string;
    function From: ItdUser;
    function message: ItdMessage;
    function InlineMessageId: string;
    function Data: string;
    function GameShortName: string;
  end;
  ItdShippingAddress = interface
    ['{7AE45A81-A19B-4A7C-AB2B-DEC68F1498BF}']
    function CountryCode: string;
    function State: string;
    function City: string;
    function StreetLine1: string;
    function StreetLine2: string;
    function PostCode: string;
  end;
  ItdShippingQuery = interface
    ['{09C65D9A-6323-455C-9B16-37FB7C542394}']
    function ID: string;
    function From: ItdUser;
    function InvoicePayload: string;
    function ShippingAddress: ItdShippingAddress;
  end;
  ItdOrderInfo = interface
    ['{BE2FEF98-2DCD-489D-862C-A88EB1A60913}']
    function Name: string;
    function PhoneNumber: string;
    function Email: string;
    function ShippingAddress: ItdShippingAddress;
  end;
  ItdPreCheckoutQuery = interface
    ['{BB511CA3-3E28-4B30-A5FB-87FBFC07A599}']
    function ID: string;
    function From: ItdUser;
    function Currency: string;
    function TotalAmount: Int64;
    function InvoicePayload: string;
    function ShippingOptionId: string;
    function OrderInfo: ItdOrderInfo;
  end;
  ItdLabeledPrice = interface
    ['{3EB70EDB-1D5D-42E4-AACD-A225316482E3}']
    function &label: string;
    function amount: Int64;
  end;
  ItdShippingOption = interface
    ['{1E1BCD22-8F26-4EA7-BDB6-770250DF5BF6}']
    function ID: string;
    function Title: string;
    function Prices: TArray<ItdLabeledPrice>;
  end;
  ItdAnswerShippingQuery = Interface
  ['{D040E5D4-6CAA-48A0-BBDD-0B6E645D1018}']
    function ShippingQueryId : string;
    function Ok : Boolean;
    function ShippingOptions : TArray<ItdShippingOption>;
    function ErrorMessage : string;
  End;
  ItdAnswerPreCheckoutQuery = interface
   ['{1258425C-A0BA-4F6B-9EEE-1D775D6F34C7}']
     function PreCheckoutQueryId : string;
     function Ok : Boolean;
     function ErrorMessage : string;
  end;
  ItdUpdate = interface
    ['{5D001F9B-B0BC-4A44-85E3-E0586DAAABD2}']
    function ID: Int64;
    function &message: ItdMessage;
    function EditedMessage: ItdMessage;
    function ChannelPost: ItdMessage;
    function EditedChannelPost: ItdMessage;
    function InlineQuery: ItdInlineQuery;
    function ChosenInlineResult: ItdChosenInlineResult;
    function CallbackQuery: ItdCallbackQuery;
    function ShippingQuery: ItdShippingQuery;
    function PreCheckoutQuery: ItdPreCheckoutQuery;
    function PollState: ItdPoll;
    function PollAnswer: ItdPollAnswer;
    function MyChatMember: ItdChatMemberUpdated;
    function ChatMember: ItdChatMemberUpdated;
    function ChatJoinRequest: ItdChatJoinRequest;
    function &Type: TtdUpdateType;
  end;
  ItdWebhookInfo = interface
    ['{C77FA5C3-EF01-4571-AA1B-2BE80724BE3B}']
    function Url: string;
    function HasCustomCertificate: Boolean;
    function PendingUpdateCount: Int64;
    function IpAddress: String;
    function LastErrorDate: TDateTime;
    function LastErrorMessage: string;
    function last_synchronization_error_date: TDateTime;
    function MaxConnections: Int64;
    function AllowedUpdates: TArray<string>;
  end;
  ItdLoginURL = Interface
    ['{DC372234-7B40-4EED-8FD6-362977BCDEE8}']
      function URL: String; //
      function ForwardText: String; //
      function BotUserName: String;
      function RequestWriteAccess: Boolean;
  End;
  ItdBotCommand = interface
    ['{D8F751A3-BEAF-4565-875D-1F5B5D78CA7C}']
    function Command: String;
    function Description: String;
  end;
  ItdWebAppInfo = interface
    ['{D03A303A-4C29-46C9-AAA6-65051C9F43D2}']
    function url: String;
  end;
  ItdWebAppData = interface
    ['{78571DEF-6B98-4141-8FD6-C1B6D3FFFC7D}']
    function data: String;
    function button_text: String;
  end;
  ItdSentWebAppMessage = Interface
    ['{692F487E-2724-44B0-AA57-DD3AA6FFE609}']
    function inline_message_id: String;
  End;
  ItdMenuButton = Interface
    ['{7D216A5D-3B0B-43D5-9AEF-DAC0231DD49E}']
  End;
  ItdChatAdministratorRights = Interface
    ['{1DBB2D74-BB40-4C25-9F6F-5D0739551F03}']
    function is_anonymous: Boolean;
    function can_manage_chat: Boolean;
    function can_delete_messages: Boolean;
    function can_manage_video_chats: Boolean;
    function can_restrict_members: Boolean;
    function can_promote_members: Boolean;
    function can_change_info: Boolean;
    function can_invite_users: Boolean;
    function can_post_messages: Boolean;
    function can_edit_messages: Boolean;
    function can_pin_messages: Boolean;
  End;

  ItdThemeParams = Interface
    ['{0EA0EC1C-CF18-4A32-92B0-02594AF4C565}']
    function Getbg_color: TColor;
    function Gettext_color: TColor;
    function Gethint_color: TColor;
    function Getlink_color: TColor;
    function Getbutton_color: TColor;
    function Getbutton_text_color: TColor;
    function Getsecondary_bg_color: TColor;
  End;

  ItdMainButton = Interface
    ['{BB9280C0-6E35-402A-8966-4C686E5DA5D3}']
  End;

  {$SCOPEDENUMS ON}
  TtdFileToSendTag = (ERROR = 254, ID = 0, FromURL = 1, FromFile = 2, FromStream = 3);
{$SCOPEDENUMS OFF}
  TtdFileToSend = class
  public
    Data: string;
    Content: TStream;
    Tag: TtdFileToSendTag;
    constructor Create(const ATag: TtdFileToSendTag = TtdFileToSendTag.ERROR;
      const AData: string = ''; AContent: TStream = nil);
    class function FromFile(const AFileName: string): TtdFileToSend;
    class function FromID(const AID: string): TtdFileToSend;
    class function FromURL(const AURL: string): TtdFileToSend;
    class function FromStream(const AContent: TStream; const AFileName: string):
      TtdFileToSend;
    class function Empty: TtdFileToSend;
    function IsEmpty: Boolean;
  end;
  TtdInputMedia = class
  private
    FType: string;
    FMedia: string;
    FCaption: string;
    FParseMode: string;
    [JSONMarshalled(False)]
    FFileToSend: TtdFileToSend;
    FCaptionEntities: TArray<ItdMessageEntity>;
    FThumb: TtdFileToSend;  public
    function GetFileToSend: TtdFileToSend;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = ''); overload;  virtual;
    constructor Create(AType: String; AMedia: TtdFileToSend; const ACaption: string = ''); overload;
    [JsonName('type')]
    property &Type: string read FType write FType;
    [JsonName('media')]
    property Media: string read FMedia write FMedia;
    [JsonName('thumb')]
    property Thumb: TtdFileToSend read FThumb write FThumb;
    [JsonName('caption')]
    property Caption: string read FCaption write FCaption;
    [JsonName('parse_mode')]
    property ParseMode: string read FParseMode write FParseMode;
    [JsonName('caption_entities')]
    property CaptionEntities: TArray<ItdMessageEntity> read FCaptionEntities write FCaptionEntities;
  end;
  TtdInputMediaPhoto = class(TtdInputMedia)
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = ''); override;
  end;
  TtdInputMediaVideo = class(TtdInputMedia)
  private
    FWidth: Integer;
    FHeight: Integer;
    FDuration: Integer;
    FSupportsStreaming: Boolean;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = '';
      AWidth: Integer = 0; AHeight: Integer = 0; ADuration: Integer = 0;
      ASupportsStreaming: Boolean = True); reintroduce;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property Duration: Integer read FDuration write FDuration;
    [JsonName('supports_streaming')]
    property SupportsStreaming: Boolean read FSupportsStreaming write FSupportsStreaming;
  end;
  TtdUserLink = record
    ID: Int64;
    Username: string;
    class function FromID(const AID: Int64): TtdUserLink; static;
    class function FromUserName(const AUsername: string): TtdUserLink; static;
    class operator Implicit(AID: Int64): TtdUserLink;
    class operator Implicit(AUsername: string): TtdUserLink;
    function ToString: string;
    function IsIDEmpty: Boolean;
    function IsUsernameEmpty: Boolean;
  end;
implementation
uses
  System.SysUtils;
{ TtdInputMedia }
constructor TtdInputMedia.Create(AMedia: TtdFileToSend; const ACaption: string);
begin
  FCaption := ACaption;
  FFileToSend := AMedia;
  case AMedia.Tag of
    TtdFileToSendTag.ID, TtdFileToSendTag.FromURL:
      FMedia := ExtractFileName(AMedia.Data);
    TtdFileToSendTag.FromFile, TtdFileToSendTag.FromStream:
      FMedia := 'attach://' + ExtractFileName(AMedia.Data);
  end;
end;
constructor TtdInputMedia.Create(AType: String; AMedia: TtdFileToSend;
  const ACaption: string);
begin
  Self.Create(AMedia, ACaption);
  FType := AType;
end;
function TtdInputMedia.GetFileToSend: TtdFileToSend;
begin
  Result := FFileToSend;
end;
{ TtdInputMediaPhoto }
constructor TtdInputMediaPhoto.Create(AMedia: TtdFileToSend; const ACaption: string);
begin
  inherited Create(AMedia, ACaption);
  FType := 'photo';
end;
{ TtdInputMediaVideo }
constructor TtdInputMediaVideo.Create(AMedia: TtdFileToSend; const ACaption:
  string; AWidth, AHeight, ADuration: Integer; ASupportsStreaming: Boolean);
begin
  inherited Create(AMedia, ACaption);
  FType := 'video';
  FWidth := AWidth;
  FHeight := AHeight;
  FDuration := ADuration;
  Self.FSupportsStreaming := ASupportsStreaming;
end;
{ TtdFileToSend }
constructor TtdFileToSend.Create(const ATag: TtdFileToSendTag; const AData:
  string; AContent: TStream);
begin
  Tag := ATag;
  Data := AData;
  Content := AContent;
end;
class function TtdFileToSend.Empty: TtdFileToSend;
begin
  Result := TtdFileToSend.Create();
end;
class function TtdFileToSend.FromFile(const AFileName: string): TtdFileToSend;
begin
  if not FileExists(AFileName) then
    raise EFileNotFoundException.CreateFmt('File %S not found!', [AFileName]);
  Result := TtdFileToSend.Create(TtdFileToSendTag.FromFile, AFileName, nil);
end;
class function TtdFileToSend.FromID(const AID: string): TtdFileToSend;
begin
  Result := TtdFileToSend.Create(TtdFileToSendTag.ID, AID, nil);
end;
class function TtdFileToSend.FromStream(const AContent: TStream; const AFileName:
  string): TtdFileToSend;
begin
    // I guess, in most cases, AFilename param should contain a non-empty string.
    // It is odd to receive a file with filename and
    // extension which both are not connected with its content.
  if AFileName.IsEmpty then
    raise Exception.Create('TtdFileToSend: Filename is empty!');
  if not Assigned(AContent) then
    raise EStreamError.Create('Stream not assigned!');
  Result := TtdFileToSend.Create(TtdFileToSendTag.FromStream, AFileName, AContent);
end;
class function TtdFileToSend.FromURL(const AURL: string): TtdFileToSend;
begin
  Result := TtdFileToSend.Create(TtdFileToSendTag.FromURL, AURL, nil);
end;
function TtdFileToSend.IsEmpty: Boolean;
begin
  Result := Data.IsEmpty and not Assigned(Content);
end;
{ TtdUserLink }
class function TtdUserLink.FromID(const AID: Int64): TtdUserLink;
begin
  Result.ID := AID;
end;
class function TtdUserLink.FromUserName(const AUsername: string): TtdUserLink;
begin
  Result.Username := AUsername;
end;
class operator TtdUserLink.Implicit(AUsername: string): TtdUserLink;
begin
  Result := TtdUserLink.FromUserName(AUsername);
end;
function TtdUserLink.IsIDEmpty: Boolean;
begin
  if ID = 0 then
    result := True
  Else
    result := False;
end;
function TtdUserLink.IsUsernameEmpty: Boolean;
begin
  if Username = '' then
    Result := True
  Else
    Result := False;
end;
function TtdUserLink.ToString: string;
begin
  if Username.IsEmpty then
    Result := ID.ToString
  else
    Result := Username;
end;
class operator TtdUserLink.Implicit(AID: Int64): TtdUserLink;
begin
  Result := TtdUserLink.FromID(AID);
end;
End.

unit TinjectTelegram.Types.Impl;
interface
{$I ..\Source\config.inc}
uses
  System.SysUtils,
  System.Classes,
  TinjectTelegram.Utils.JSON,
  TinjectTelegram.Types,
  TinjectTelegram.Helpers,
  TinjectTelegram.Types.Enums,
  TinjectTelegram.Types.Passport;
type
  TtdUser = class(TBaseJson, ItdUser)
  public
    function ID: Int64;
    function IsBot: Boolean;
    function FirstName: string;
    function LastName: string;
    function Username: string;
    function LanguageCode: string;
    function CanJoinGroups: Boolean;
    function CanReadAllGroupMessages: Boolean;
    function SupportsInlineQueries: Boolean;
    function ToJSonStr: String;
  end;

(*
{ TtdChatMember }
function TtdChatMember.CanAddWebPagePreviews: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_add_web_page_previews');
end;
function TtdChatMember.CanBeEdited: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_change_info');
end;
function TtdChatMember.CanChangeInfo: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_change_info');
end;
function TtdChatMember.CanDeleteMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_delete_messages');
end;
function TtdChatMember.CanEditMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_edit_messages');
end;
function TtdChatMember.CanInviteUsers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_invite_users');
end;
function TtdChatMember.CanManageChat: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_chat');
end;

function TtdChatMember.CanManageVoiceChats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_voice_chats');
end;

function TtdChatMember.CanPinMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;
function TtdChatMember.CanPostMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_post_messages');
end;
function TtdChatMember.CanPromoteMembers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_promote_members');
end;
function TtdChatMember.CanRestrictMembers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_restrict_members');
end;
function TtdChatMember.CanSendMediaMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_media_messages');
end;
function TtdChatMember.CanSendMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_messages');
end;
function TtdChatMember.CanSendOtherMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_other_messages');
end;
function TtdChatMember.CanSendPolls: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_polls');
end;

function TtdChatMember.CustomTitle: String;
begin
  Result := ReadToSimpleType<String>('custom_title');
end;

function TtdChatMember.IsAnonymous: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_anonymous');
end;

function TtdChatMember.IsMember: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_member');
end;

function TtdChatMember.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;
end;
function TtdChatMember.UntilDate: TDateTime;
begin
  Result := ReadToDateTime('until_date');
end;
function TtdChatMember.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;
*)

  TtdChatMemberOwner = class(TBaseJson, ItdChatMember)
  public
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
    function CustomTitle: String;
    function IsAnonymous : Boolean;
  end;

  TtdChatMemberAdministrator = class(TBaseJson, ItdChatMember)
  public
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
    function CustomTitle: String;
    function IsAnonymous : Boolean;
    function CanBeEdited: Boolean;
    function CanManageChat: Boolean;
    function CanPostMessages: Boolean;
    function CanEditMessages: Boolean;
    function CanDeleteMessages: Boolean;
    function CanManageVoiceChats: Boolean;
    function CanRestrictMembers:	Boolean;
    function CanPromoteMembers:	Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers: Boolean;
    function CanPinMessages: Boolean;
  end;

  TtdChatMemberMember = class(TBaseJson, ItdChatMember)
  public
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
  end;

  TtdChatMemberRestricted = class(TBaseJson, ItdChatMember)
  public
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
    function IsMember:	Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers: Boolean;
    function CanPinMessages: Boolean;
    function CanSendMessages: Boolean;
    function CanSendMediaMessages: Boolean;
    function CanSendPolls: Boolean;
    function CanSendOtherMessages: Boolean;
    function CanAddWebPagePreviews: Boolean;
    function UntilDate: TDateTime;
  end;

  TtdChatMemberLeft = class(TBaseJson, ItdChatMember)
  public
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
  end;

  TtdChatMemberBanned = class(TBaseJson, ItdChatMember)
  public
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
    function UntilDate: TDateTime;
  end;
  TtdChatMemberUpdated = class(TBaseJson, ItdChatMemberUpdated) //New in API 5.1
    public
    function Chat:	ItdChat;
    function From:	ItdUser;
    function Date:	{Integer Unix Time}TDateTime;
    function old_chat_member:	ItdChatMember;
    function new_chat_member:	ItdChatMember;
    function invite_link:	ItdChatInviteLink;
  End;

//  TtdChatMemberUpdated = class(TBaseJson, ItdChatMember)
//  public
//    function chat: ItdChat;
//    function from: ItdUser;
//    function date: TDateTime;
//    function old_chat_member: ItdChatMember;
//    function new_chat_member: ItdChatMember;
//    function invite_link: ItdChatInviteLink;
//  end;

  TtdChatMember = class(TBaseJson, ItdChatMember)
  public
    function ChatMemberOwner: TtdChatMemberOwner;
    function ChatMemberAdministrator : TtdChatMemberAdministrator;
    function ChatMemberMember :TtdChatMemberMember;
    function ChatMemberRestricted : TtdChatMemberRestricted;
    function ChatMemberLeft : TtdChatMemberLeft;
    function ChatMemberBanned : TtdChatMemberBanned;
    (*
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
    function CustomTitle: String;
    function IsAnonymous : Boolean;
    function CanBeEdited: Boolean;
    function CanManageChat: Boolean;
    function CanPostMessages: Boolean;
    function CanEditMessages: Boolean;
    function CanDeleteMessages: Boolean;
    function CanManageVoiceChats: Boolean;
    function CanRestrictMembers:	Boolean;
    function CanPromoteMembers:	Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers: Boolean;
    function CanPinMessages: Boolean;
    function IsMember:	Boolean;
    function CanSendMessages: Boolean;
    function CanSendMediaMessages: Boolean;
    function CanSendPolls: Boolean;
    function CanSendOtherMessages: Boolean;
    function CanAddWebPagePreviews: Boolean;
    function UntilDate: TDateTime;
    *)
  end;
  TtdChatPhoto = class(TBaseJson, ItdChatPhoto)
    function SmallFileId: string;
    function SmallFileUniqueId: string;
    function BigFileId: string;
    function BigFileUniqueId: string;
  end;
  TtdChatPermissions = class(TBaseJson, ItdChatPermissions)
  public
    function CanSendMessages:	Boolean;
    function CanSendMediaMessages: Boolean;
    function CanSendPolls:	Boolean;
    function CanSendOtherMessages: Boolean;
    function CanAddWebPagePreviews:	Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers:	Boolean;
    function CanPinMessages:	Boolean;
  end;
  TtdChatLocation = class(TBaseJson, ItdChatLocation)
  public
    function Location: ItdLocation;
    function Address:	String; //Limit of a 64 character
  end;
  TtdChat = class(TBaseJson, ItdChat)
  public
    function ID: Int64;
    function TypeChat: TtdChatType;
    function Title: string;
    function Username: string;
    function FirstName: string;
    function LastName: string;
    function AllMembersAreAdministrators: Boolean;
    function Photo: ItdChatPhoto;
    function Bio:	String;
    function Description: string;
    function InviteLink: string;
    function PinnedMessage: ItdMessage;
    function Permissions: ItdChatPermissions;
    function SlowModeDelay:	Integer;
    function StickerSetName: string;
    function CanSetStickerSet: Boolean;
    function LinkedChatId:	Integer;
    function location: ItdChatLocation;
    function IsGroup: Boolean;
    function ToJSonStr: String;
    function ToString: String; override;
  end;
  TtdMessageEntity = class(TBaseJson, ItdMessageEntity)
  public
    function TypeMessage: TtdMessageEntityType;
    function Offset: Int64;
    function Length: Int64;
    function Url: string;
    function User: ItdUser;
  end;
  TtdFile = class(TBaseJson, ItdFile)
  public
    function FileId: string;
    function FileUniqueId: string; //new
    function FileSize: Int64;
    function FilePath: string;
    function CanDownload: Boolean;
    function GetFileUrl(const AToken: string): string;
  end;
  TtdAudio = class(TtdFile, ItdAudio)
  public
    function Duration: Int64;
    function Performer: string;
    function Title: string;
    function FileName: string;
    function MimeType: string;
    function Thumb: ItdPhotoSize;
  end;
  TtdPhotoSize = class(TtdFile, ItdPhotoSize)
  public
    function Width: Int64;
    function Height: Int64;
  end;
  TtdDocument = class(TtdFile, ItdDocument)
  public
    function Thumb: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  TtdMaskPosition = class(TBaseJson, ItdMaskPosition)
    function Point: TtdMaskPositionPoint;
    function XShift: Single;
    function YShift: Single;
    function Scale: Single;
  end;
  TtdSticker = class(TtdFile, ItdSticker)
  public
    function Width: Int64;
    function Height: Int64;
    function Thumb: ItdPhotoSize;
    function Emoji: string;
    function SetName: string;
    function MaskPosition: ItdMaskPosition;
  end;
  TtdStickerSet = class(TBaseJson, ItdStickerSet)
  public
    function Name: string;
    function Title: string;
    function ContainsMasks: Boolean;
    function Stickers: TArray<ItdSticker>;
  end;
  TtdVideo = class(TtdFile, ItdVideo)
  public
    function Width: Int64;
    function Height: Int64;
    function Duration: Int64;
    function Thumb: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  TtdVideoNote = class(TtdFile, ItdVideoNote)
  public
    function FileId: string;
    function Length: Int64;
    function Duration: Int64;
    function Thumb: ItdPhotoSize;
    function FileSize: Int64;
  end;
  TtdVoice = class(TtdFile, ItdVoice)
  public
    function Duration: Int64;
    function MimeType: string;
  end;
  TtdContact = class(TBaseJson, ItdContact)
  private
    FJson : String;
    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetPhoneNumber(const Value: string);
  public
    constructor Create(const ANumeroTelelefone, APrimeiroNome, UltimoNome: String); reintroduce; overload;
    constructor Create(const AJson: string); overload; override;
    function PhoneNumber: string;
    function FirstName: string;
    function LastName: string;
    function UserId: Int64;
  end;
  TtdPollOption = class(TBaseJson, ItdPollOption)
  public
    function text : String;
    function voter_count: String;
  end;
  TtdPollAnswer = class(TBaseJson, ItdPollAnswer)
    function poll_id: String;
    function user: ItdUser;
    function option_ids: TArray<Integer>;
  end;
  TtdPoll = class(TBaseJson, ItdPoll)
    function Id : String;
    function Question: String;
    function options: TArray<ItdPollOption>;
    function total_voter_count: Integer;
    function is_closed: Boolean;
    function is_anonymous: Boolean;
    function &type: String;
    function allows_multiple_answers: Boolean;
    function correct_option_id: Integer;
  end;
  TtdDice = class(TBaseJson, ItdDice)
    public
      function Emoji:	String; //	Emoji on which the dice throw animation is based
      function value: Integer;
  end;
  //New in API 5.0
  TtdProximityAlertTriggered = class(TBaseJson, ItdProximityAlertTriggered)
  public
    function traveler:	ItdUser;  //	User that triggered the alert
    function watcher:	  ItdUser;  //	User that set the alert
    function distance:	Integer;  //	The distance between the users
  end;
  TtdLocation = class(TBaseJson, ItdLocation)
  private
    FLat: Single;
    FLng: Single;
    FHorizontalAccuracy: Single;
    FLivePeriod: Integer;
    FHeading: Integer;
    FProximityAlertRadius: Integer;
    procedure SetLatitude(const Value: Single);
    procedure SetLongitude(const Value: Single);
    function GetLongitude: Single;
    function GetLatitude: Single;
    //New in API 5.0
    function GetHeading: Integer;
    function GetHorizontalAccuracy: Single;
    function GetLivePeriod: Integer;
    function GetProximityAlertRadius: Integer;
    procedure SetHeading(const Value: Integer);
    procedure SetHorizontalAccuracy(const Value: Single);
    procedure SetLivePeriod(const Value: Integer);
    procedure SetProximityAlertRadius(const Value: Integer);
  public
    constructor Create(const ALatitude, ALongitude: Single); reintroduce; overload;
    constructor Create(const AJson: string); overload; override;
    property Latitude: Single read FLat write SetLatitude;
    property Longitude: Single read FLng write SetLongitude;
    //New in API 5.0
    property HorizontalAccuracy: Single read GetHorizontalAccuracy write SetHorizontalAccuracy;
    property LivePeriod: Integer read GetLivePeriod write SetLivePeriod;
    property Heading: Integer read GetHeading write SetHeading;
    property ProximityAlertRadius: Integer read GetProximityAlertRadius write SetProximityAlertRadius;
  end;
  TtdVenue = class(TBaseJson, ItdVenue)
  private
    FLocation: ItdLocation;
    FTitle: String;
    FFoursquareId: string;
    FFoursquareType: String;
    FAddress: string;
    FLatitude : Single;
    FLongitude: Single;
    FGooglePlaceId: string;
    FGooglePlaceType: String;
    procedure SetLatitude(const Value: Single);
    procedure SetLongitude(const Value: Single);
    procedure SetTitle(const Value: String);
    procedure SetAddress(const Value: String);
    procedure SetFoursquareId(const Value: String);
    procedure SetFoursquareType(const Value: String);
    procedure SetLocation(const Value: ItdLocation);
    procedure SetGooglePlaceId(const Value: string);
    procedure SetGooglePlaceType(const Value: String);
  public
    function Location: ItdLocation;
    function Title: string;
    function Address: string;
    function FoursquareId: string;
    function FoursquareType: string;
    function google_place_id: string;
    function google_place_type: string;
    property sLocation      : ItdLocation read FLocation        write SetLocation;
    property sLatitude      : Single      read FLatitude        write SetLatitude;
    property sLongitude     : single      read FLongitude       write SetLongitude;
    property sTitle         : String      read FTitle           write SetTitle;
    property sAddress       : string      read FAddress         write SetAddress;
    property sFoursquareId  : string      read FFoursquareId    write SetFoursquareId;
    property sFoursquareType: String      read FFoursquareType  write SetFoursquareType;
    property sGooglePlaceId  : string      read FGooglePlaceId    write SetGooglePlaceId;
    property sGooglePlaceType: String      read FGooglePlaceType  write SetGooglePlaceType;
    constructor Create(const ALocation: ItdLocation; ATitle, AAddress,
      AFoursquareId, AFoursquareType : String); reintroduce; overload;
    constructor Create(const ALatitude, ALongitude: Single; ATitle, AAddress,
      AFoursquareId, AFoursquareType : String); reintroduce; overload;
    constructor Create(const ALatitude, ALongitude: Single; ATitle, AAddress,
      AFoursquareId, AFoursquareType, AGooglePlaceId, AGooglePlaceType : String); reintroduce; overload;
    constructor Create(const AJson: string); overload; override;
    destructor Destroy; override;
  end;
  TtdAnimation = class(TBaseJson, ItdAnimation)
  public
    function FileId: string;
    function Thumb: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
    function FileSize: Int64;
  end;
  TtdGameHighScore = class(TBaseJson, ItdGameHighScore)
  public
    function Position: Int64;
    function User: ItdUser;
    function Score: Int64;
  end;
  TtdGame = class(TBaseJson, ItdGame)
  public
    function Title: string;
    function Description: string;
    function Photo: TArray<ItdPhotoSize>;
    function Text: string;
    function TextEntities: TArray<ItdMessageEntity>;
    function Animation: ItdAnimation;
  end;
  TtdChatInviteLink = class(TBaseJson, ItdChatInviteLink) //New in API 5.1
  public
    function invite_link:	String;
    function creator:	ItdUser;
    function is_primary:	Boolean;
    function is_revoked:	Boolean;
    function expire_date:	{Integer}TDateTime;
    function member_limit:	Integer;
  End;

  TtdVoiceChatScheduled = class(TBaseJson, ItdVoiceChatScheduled) //New in API 5.2
  public
    function start_date:	TDateTime; //Point in time (Unix timestamp) when the voice chat is supposed to be started by a chat administrator
  End;
  TtdVoiceChatStarted = class(TBaseJson, ItdVoiceChatStarted); //New in API 5.1
  TtdVoiceChatEnded = class(TBaseJson, ItdVoiceChatEnded) //New in API 5.1
  public
    function duration:	Integer;
  End;
  TtdVoiceChatParticipantsInvited = class(TBaseJson, ItdVoiceChatParticipantsInvited) //New in API 5.1
  public
    function Users:	TArray<ItdUser>;
  End;
  TtdMessageAutoDeleteTimerChanged = class(TBaseJson, ItdMessageAutoDeleteTimerChanged) //New in API 5.1
  public
    function message_auto_delete_time: TDateTime;
  End;
  TtdMessage = class(TBaseJson, ItdMessage)
  public
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
    function ReplyToMessage: ItdMessage;
    function ViaBot : ItdUser;
    function EditDate: TDateTime;
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
    function MigrateToChatId: Int64;
    function MessageAutoDeleteTimerChanged: ItdMessageAutoDeleteTimerChanged;
    function MigrateFromChatId: Int64;
    function PinnedMessage: ItdMessage;
    function Invoice: ItdInvoice;
    function SuccessfulPayment: ItdSuccessfulPayment;
    function ConnectedWebsite: string;
    function PassportData: ItdPassportData;
    function ProximityAlertTriggered: ItdProximityAlertTriggered;
    function VoiceChatScheduled: ItdVoiceChatScheduled;
    function VoiceChatStarted: ItdVoiceChatStarted;
    function VoiceChatEnded: ItdVoiceChatEnded;
    function VoiceChatParticipantsInvited: ItdVoiceChatParticipantsInvited;
    function ReplyMarkup : IReplyMarkup;
    function NewChatMember: ItdUser;
    function &Type: TtdMessageType;
    function IsCommand(const AValue: string): Boolean;
 end;
  TtdUserProfilePhotos = class(TBaseJson, ItdUserProfilePhotos)
  public
    function TotalCount: Int64;
    function Photos: TArray<TArray<ItdPhotoSize>>;
  end;
  TtdCallbackGame = class
  end;
  TtdResponseParameters = class(TBaseJson, ItdResponseParameters)
  public
    function MigrateToChatId: Int64;
    function RetryAfter: Int64;
  end;
  TtdInlineQuery = class(TBaseJson, ItdInlineQuery)
  public
    function ID: string;
    function From: ItdUser;
    function Query: string;
    function Offset: string;
    function chat_type:	TtdChatType; //	Optional. Type of the chat, from which the inline query was sent. Can be either “sender” for a private chat with the inline query sender, “private”, “group”, “supergroup”, or “channel”. The chat type should be always known for requests sent from official clients and most third-party clients, unless the request was sent from a secret chat
    function location:	ItdLocation; //Optional. Sender location, only for bots that request user location
  end;
  TtdChosenInlineResult = class(TBaseJson, ItdChosenInlineResult)
  public
    function ResultId: string;
    function From: ItdUser;
    function Location: ItdLocation;
    function InlineMessageId: string;
    function Query: string;
  end;
  TtdCallbackQuery = class(TBaseJson, ItdCallbackQuery)
  public
    function ID: string;
    function From: ItdUser;
    function Message: ItdMessage;
    function InlineMessageId: string;
    function Data: string;
    function GameShortName: string;
  end;
{$REGION 'Payments'}
  TtdInvoice = class(TBaseJson, ItdInvoice)
  private
    FTitle : string;
    FStartParameter: string;
    FDescription: string;
    FCurrency: string;
    FTotalAmount: Int64;
  public
    function Title: string;
    function Description: string;
    function StartParameter: string;
    function Currency: string;
    function TotalAmount: Int64;
    property sTitle: string read Title write FTitle;
    property sDescription: string read Description write FDescription;
    property sStartParameter: string read StartParameter write FStartParameter;
    property sCurrency: string read Currency write FCurrency;
    property sTotalAmount: Int64 read TotalAmount write FTotalAmount;
    constructor Create(const ATitle, ADescription, AStartParameter, Currency: string; ATotalAmount: Int64);
  end;
  TtdLabeledPrice = class(TBaseJson, ItdLabeledPrice)
  private
    AJSon : String;
    [JSonName('amount')]
    FAmount: Int64;
    [JSonName('label')]
    FLabel: String;
  public
    function &label: string;
    function amount: Int64;
    constructor Create(const ALabel: string; AAmount: Int64); reintroduce; overload;
    constructor Create(const AJson: string); overload; override;
    property sLabel: String read &label write FLabel;
    property sAmount: Int64 read amount write FAmount;
  end;
  /// <summary>
  /// This object represents a shipping address.
  /// </summary>
  TtdShippingAddress = class(TBaseJson, ItdShippingAddress)
  public
    function CountryCode: string;
    function State: string;
    function City: string;
    function StreetLine1: string;
    function StreetLine2: string;
    function PostCode: string;
  end;
  TtdOrderInfo = class(TBaseJson, ItdOrderInfo)
  public
    function Name: string;
    function PhoneNumber: string;
    function Email: string;
    function ShippingAddress: ItdShippingAddress;
  end;
  TtdPreCheckoutQuery = class(TBaseJson, ItdPreCheckoutQuery)
  public
    function ID: string;
    function From: ItdUser;
    function Currency: string;
    function TotalAmount: Int64;
    function InvoicePayload: string;
    function ShippingOptionId: string;
    function OrderInfo: ItdOrderInfo;
  end;
  TtdShippingOption = class(TBaseJson, ItdShippingOption)
  public
    function ID: string;
    function Title: string;
    function Prices: TArray<ItdLabeledPrice>;
  end;
  //Novo...
  TtdAnswerShippingQuery = class(TBaseJson, ItdAnswerShippingQuery)
    function ShippingQueryId : string;
    function Ok : Boolean;
    function ShippingOptions : TArray<ItdShippingOption>;
    function ErrorMessage : string;
  End;
  //Novo
  TtdAnswerPreCheckoutQuery = class(TBaseJson, ItdAnswerPreCheckoutQuery)
     function PreCheckoutQueryId : string;
     function Ok : Boolean;
     function ErrorMessage : string;
  end;
  TtdShippingQuery = class(TBaseJson, ItdShippingQuery)
  public
    function ID: string;
    function From: ItdUser;
    function InvoicePayload: string;
    function ShippingAddress: ItdShippingAddress;
  end;
  TtdSuccessfulPayment = class(TBaseJson, ItdSuccessfulPayment)
  public
    function Currency: string;
    function TotalAmount: Int64;
    function InvoicePayload: string;
    function ShippingOptionId: string;
    function OrderInfo: ItdOrderInfo;
    function TelegramPaymentChargeId: string;
    function ProviderPaymentChargeId: string;
  end;
  TtdPassportFile = class(TBaseJson, ItdPassportFile)
    function file_id: string;
    function file_unique_id: string;
    function file_size: Integer;
    function file_date: Integer;
  end;
  TtdEncryptedPassportElement = class(TBaseJson, ItdEncryptedPassportElement)
    function &type : string;
    function data: string;
    function phone_number: string;
    function email: string;
    function files: TArray<ItdPassportFile>;
    function front_side: ItdPassportFile;
    function reverse_side: ItdPassportFile;
    function selfie: ItdPassportFile;
    function translation: TArray<ItdPassportFile>;
    function hash: string;
  end;
  TtdEncryptedCredentials = class(TBaseJson, ItdEncryptedCredentials)
    function Data: String;
    function Hash: String;
    function Secret: String;
  end;
  TtdPassportData = class(TBaseJson, ItdPassportData)
    function Data: TArray<ItdEncryptedPassportElement>;
    function Credentials : ItdEncryptedCredentials;
  end;
{$ENDREGION}
  TtdUpdate = class(TBaseJson, ItdUpdate)
  public
    function ID: Int64;
    function &Message: ItdMessage;
    function EditedMessage: ItdMessage;
    function InlineQuery: ItdInlineQuery;
    function ChosenInlineResult: ItdChosenInlineResult;
    function CallbackQuery: ItdCallbackQuery;
    function ChannelPost: ItdMessage;
    function EditedChannelPost: ItdMessage;
    function ShippingQuery: ItdShippingQuery;
    function PreCheckoutQuery: ItdPreCheckoutQuery;
    function PollState: ItdPoll;
    function PollAnswer: ItdPollAnswer;
    function MyChatMember: ItdChatMemberUpdated;
    function ChatMember: ItdChatMemberUpdated;
    function &Type: TtdUpdateType;
  end;
  TtdWebhookInfo = class(TBaseJson, ItdWebhookInfo)
  public
    function Url: string;
    function HasCustomCertificate: Boolean;
    function PendingUpdateCount: Int64;
    function IpAddress: String;
    function LastErrorDate: TDateTime;
    function LastErrorMessage: string;
    function MaxConnections: Int64;
    function AllowedUpdates: TArray<string>;
  end;
  TtdLoginURL = class(TBaseJson, ItdLoginURL)
  private
    FRequestWriteAccess: Boolean;
    FURL: String;
    FBotUserName: String;
    FForwardText: String;

    function URL: String; //
    function ForwardText: String; //
    function BotUserName: String;
    function RequestWriteAccess: Boolean;
  public
//    constructor Create(const AJson: String); reintroduce; overload;
    constructor Create(const AUrl: String;const AForwardText: String = '';
     const ABotUserName: String = '';const ARequestWriteAccess: Boolean = False); overload;

    property sUrl: String read URL write FURL;
    property sForwardText: String read ForwardText write FForwardText;
    property sBotUserName: String read BotUserName write FBotUserName;
    property sRequestWriteAccess: Boolean read RequestWriteAccess write FRequestWriteAccess;
  end;
  TtdBotCommand = class(TBaseJson, ItdBotCommand)
  private
    [JsonName('command')]
    FDesc: String;
    [JsonName('description')]
    FCMD: String;
  published
    constructor Create(const ACommand: String = ''; ADescription: String = ''); reintroduce; overload;
    function Command: String;
    function Description: String;
    property CMD: String read FCMD write FCMD;
    property Desc: String read FDesc write FDesc;
  end;
implementation
uses
  System.JSON,
  System.TypInfo,
  TinjectTelegram.Types.ReplyMarkups;
{ TtdAnimation }
function TtdAnimation.FileId: string;
begin
  Result := ReadToSimpleType<string>('file_id');
end;
function TtdAnimation.FileName: string;
begin
  Result := ReadToSimpleType<string>('file_name');
end;
function TtdAnimation.FileSize: Int64;
begin
  Result := ReadToSimpleType<Int64>('file_size');
end;
function TtdAnimation.MimeType: string;
begin
  Result := ReadToSimpleType<string>('mime_type');
end;
function TtdAnimation.Thumb: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
{ TtdCallbackQuery }
function TtdCallbackQuery.Data: string;
begin
  Result := ReadToSimpleType<string>('data');
end;
function TtdCallbackQuery.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdCallbackQuery.GameShortName: string;
begin
  Result := ReadToSimpleType<string>('game_short_name');
end;
function TtdCallbackQuery.ID: string;
begin
  Result := ReadToSimpleType<string>('id');
end;
function TtdCallbackQuery.InlineMessageId: string;
begin
  Result := ReadToSimpleType<string>('inline_message_id');
end;
function TtdCallbackQuery.Message: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('message');
end;
{ TtdDocument }
function TtdDocument.FileName: string;
begin
  Result := ReadToSimpleType<string>('file_name');
end;
function TtdDocument.MimeType: string;
begin
  Result := ReadToSimpleType<string>('mime_type');
end;
function TtdDocument.Thumb: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
{ TtdFile }
function TtdFile.CanDownload: Boolean;
begin
  Result := not FilePath.IsEmpty;
end;
function TtdFile.FileId: string;
begin
  Result := ReadToSimpleType<string>('file_id');
end;
function TtdFile.FilePath: string;
begin
  Result := ReadToSimpleType<string>('file_path');
end;
function TtdFile.FileSize: Int64;
begin
  Result := ReadToSimpleType<Int64>('file_size');
end;
function TtdFile.FileUniqueId: string;
begin
  Result := ReadToSimpleType<string>('file_unique_id');
end;

function TtdFile.GetFileUrl(const AToken: string): string;
begin
  Result := 'https://api.telegram.org/file/bot' + AToken + '/' + FilePath;
end;
function TtdGameHighScore.Position: Int64;
begin
  Result := ReadToSimpleType<Int64>('position');
end;
function TtdGameHighScore.Score: Int64;
begin
  Result := ReadToSimpleType<Int64>('score');
end;
function TtdGameHighScore.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;
{ TtdMessage }
function TtdMessage.Document: ItdDocument;
begin
  Result := ReadToClass<TtdDocument>('document');
end;
function TtdMessage.EditDate: TDateTime;
begin
  Result := ReadToDateTime('edit_date');
end;
function TtdMessage.ForwardDate: TDateTime;
begin
  Result := ReadToDateTime('forward_date');
end;
function TtdMessage.ForwardFrom: ItdUser;
begin
  Result := ReadToClass<TtdUser>('forward_from');
end;
function TtdMessage.ForwardFromChat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('forward_from_chat');
end;
function TtdMessage.ForwardFromMessageId: Int64;
begin
  Result := ReadToSimpleType<Int64>('forward_from_message_id');
end;
function TtdMessage.ForwardSenderName: String;
begin
  Result := ReadToSimpleType<string>('forward_sender_name');
end;

function TtdMessage.ForwardSignature: string;
begin
  Result := ReadToSimpleType<string>('forward_signature');
end;
function TtdMessage.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdMessage.Game: ItdGame;
begin
  Result := ReadToClass<TtdGame>('game');
end;
function TtdMessage.GroupChatCreated: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('group_chat_created');
end;
function TtdMessage.Invoice: ItdInvoice;
begin
  Result := ReadToClass<TtdInvoice>('invoice');
end;
function TtdMessage.IsCommand(const AValue: string): Boolean;
var
  LEnt: ItdMessageEntity;
begin
  Result := False;
  if Self.Entities = nil then
    Exit;
  for LEnt in Self.Entities do
    if (LEnt.TypeMessage = TtdMessageEntityType.bot_command) then
      if Text.Substring(LEnt.Offset, LEnt.Length).StartsWith(AValue, True) then
        Exit(True);
end;
function TtdMessage.LeftChatMember: ItdUser;
begin
  Result := ReadToClass<TtdUser>('left_chat_member');
end;
function TtdMessage.Location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;
function TtdMessage.MessageAutoDeleteTimerChanged: ItdMessageAutoDeleteTimerChanged;
begin
  Result := ReadToClass<TtdMessageAutoDeleteTimerChanged>('message_auto_delete_timer_changed');
end;

function TtdMessage.MessageId: Int64;
begin
  Result := ReadToSimpleType<Int64>('message_id');
end;
function TtdMessage.MigrateFromChatId: Int64;
begin
  Result := ReadToSimpleType<Int64>('migrate_from_chat_id');
end;
function TtdMessage.MigrateToChatId: Int64;
begin
  Result := ReadToSimpleType<Int64>('migrate_to_chat_id');
end;
function TtdMessage.NewChatMember: ItdUser;
begin
  Result := ReadToClass<TtdUser>('new_chat_member');
end;
function TtdMessage.NewChatMembers: TArray<ItdUser>;
var
  LValue: string;
  LJsonArray: TJSONArray;
  I: Integer;
begin
  Result := nil;
  if FJSON.TryGetValue<string>('new_chat_members', LValue) then
  begin
    LJsonArray := TJSONObject.ParseJSONValue(LValue) as TJSONArray;
    try
      SetLength(Result, LJsonArray.Count);
      for I := 0 to LJsonArray.Count - 1 do
        Result[I] := ReadToClass<TtdUser>('new_chat_members');
    finally
      LJsonArray.Free;
    end;
  end;
end;
function TtdMessage.NewChatPhoto: TArray<ItdPhotoSize>;
var
  LValue: string;
  LJsonArray: TJSONArray;
  I: Integer;
begin
  Result := nil;
  if FJSON.TryGetValue<string>('new_chat_photo', LValue) then
  begin
    LJsonArray := TJSONObject.ParseJSONValue(LValue) as TJSONArray;
    try
      SetLength(Result, LJsonArray.Count);
      for I := 0 to LJsonArray.Count - 1 do
        Result[I] := ReadToClass<TtdPhotoSize>('new_chat_photo');
    finally
      LJsonArray.Free;
    end;
  end;
end;
function TtdMessage.NewChatTitle: string;
begin
  Result := ReadToSimpleType<string>('new_chat_title');
end;
function TtdMessage.Entities: TArray<ItdMessageEntity>;
var
  LJsonArray: TJSONArray;
  I: Integer;
begin
  LJsonArray := FJSON.GetValue('entities') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := TtdMessageEntity.Create(LJsonArray.Items[I].ToString);
end;
function TtdMessage.PassportData: ItdPassportData;
begin
  Result := ReadToClass<TtdPassportData>('passport_data');
end;

function TtdMessage.Photo: TArray<ItdPhotoSize>;
begin
  Result := ReadToArray<ItdPhotoSize>(TtdPhotoSize, 'photo');
end;
function TtdMessage.PinnedMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('pinned_message');
end;
function TtdMessage.Poll: ItdPoll;
begin
  Result := ReadToClass<TtdPoll>('poll');
end;

function TtdMessage.ProximityAlertTriggered: ItdProximityAlertTriggered;
begin
  Result := ReadToClass<TtdProximityAlertTriggered>('proximity_alert_triggered');
end;

function TtdMessage.ReplyMarkup: IReplyMarkup;
begin
  Result := ReadToClass<TtdReplyMarkup>('reply_markup');
end;

function TtdMessage.ReplyToMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('reply_to_message');
end;

function TtdMessage.SenderChat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('sender_chat');
end;

function TtdMessage.Sticker: ItdSticker;
begin
  Result := ReadToClass<TtdSticker>('sticker');
end;
function TtdMessage.SuccessfulPayment: ItdSuccessfulPayment;
begin
  Result := ReadToClass<TtdSuccessfulPayment>('successful_payment');
end;
function TtdMessage.SupergroupChatCreated: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('supergroup_chat_created');
end;
function TtdMessage.Text: string;
begin
  Result := ReadToSimpleType<string>('text');
end;
function TtdMessage.&Type: TtdMessageType;
begin
  if Audio <> nil then
    Exit(TtdMessageType.AudioMessage);
  if Contact <> nil then
    Exit(TtdMessageType.ContactMessage);
  if Document <> nil then
    Exit(TtdMessageType.DocumentMessage);
  if Game <> nil then
    Exit(TtdMessageType.GameMessage);
  if (Location <> nil) then
    Exit(TtdMessageType.LocationMessage);
  if (NewChatMember <> nil) or (LeftChatMember <> nil) or ((NewChatPhoto <> nil) and (Length(NewChatPhoto) > 0)) or ((NewChatMembers <> nil) and (Length(NewChatMembers) > 0)) or (not NewChatTitle.IsEmpty) or DeleteChatPhoto or GroupChatCreated or SupergroupChatCreated or ChannelChatCreated or (MigrateToChatId <> 0) or (MigrateFromChatId <> 0) or (PinnedMessage <> nil) then
    Exit(TtdMessageType.ServiceMessage);
  if (Photo <> nil) and (Length(Photo) > 0) then
    Exit(TtdMessageType.PhotoMessage);
  if (Sticker <> nil) then
    Exit(TtdMessageType.StickerMessage);
  if (Dice <> nil) then
    Exit(TtdMessageType.DiceMessage);
  if (Poll <> nil) then
    Exit(TtdMessageType.PollMessage);
  if (Venue <> nil) then
    Exit(TtdMessageType.VenueMessage);
  if (Video <> nil) then
    Exit(TtdMessageType.VideoMessage);
  if (VideoNote <> nil) then
    Exit(TtdMessageType.VideoNoteMessage);
  if (Voice <> nil) then
    Exit(TtdMessageType.VoiceMessage);
  if (Animation <> nil) then
    Exit(TtdMessageType.AnimatoinMessage);
  if (Invoice <> nil) then
    Exit(TtdMessageType.InvoiceMessage);
  if (PassportData <> nil) then
    Exit(TtdMessageType.PassportDataMessage);
  if not Text.IsEmpty then
    Exit(TtdMessageType.TextMessage);
  Result := TtdMessageType.UnknownMessage;
end;
function TtdMessage.Animation: ItdAnimation;
begin
  Result := ReadToClass<TtdAnimation>('animation');
end;

function TtdMessage.Audio: ItdAudio;
begin
  Result := ReadToClass<TtdAudio>('audio');
end;
function TtdMessage.AuthorSignature: string;
begin
  Result := ReadToSimpleType<string>('author_signature');
end;
function TtdMessage.Caption: string;
begin
  Result := ReadToSimpleType<string>('caption');
end;
function TtdMessage.CaptionEntities: TArray<ItdMessageEntity>;
begin
  Result := ReadToArray<ItdMessageEntity>(TtdMessageEntity, 'caption_entities');
end;
function TtdMessage.ChannelChatCreated: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('channel_chat_created');
end;
function TtdMessage.Chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;
function TtdMessage.ConnectedWebsite: string;
begin
  Result := ReadToSimpleType<string>('connected_website');
end;
function TtdMessage.Contact: ItdContact;
begin
  Result := ReadToClass<TtdContact>('contact');
end;
function TtdMessage.Date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;
function TtdMessage.DeleteChatPhoto: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('delete_chat_photo');
end;
function TtdMessage.Dice: ItdDice;
begin
  Result := ReadToClass<TtdDice>('dice');
end;

function TtdMessage.Venue: ItdVenue;
begin
  Result := ReadToClass<TtdVenue>('venue');
end;
function TtdMessage.ViaBot: ItdUser;
begin
  Result := ReadToClass<TtdUser>('via_bot');
end;

function TtdMessage.Video: ItdVideo;
begin
  Result := ReadToClass<TtdVideo>('video');
end;
function TtdMessage.VideoNote: ItdVideoNote;
begin
  Result := ReadToClass<TtdVideoNote>('video_note');
end;
function TtdMessage.Voice: ItdVoice;
begin
  Result := ReadToClass<TtdVoice>('voice');
end;
function TtdMessage.VoiceChatParticipantsInvited: ItdVoiceChatParticipantsInvited;
begin
  Result := ReadToClass<TtdVoiceChatParticipantsInvited>('voice_chat_participants_invited');
end;

function TtdMessage.VoiceChatScheduled: ItdVoiceChatScheduled;
begin
  Result := ReadToClass<TtdVoiceChatScheduled>('voice_chat_scheduled');
end;

function TtdMessage.VoiceChatStarted: ItdVoiceChatStarted;
begin
  Result := ReadToClass<TtdVoiceChatStarted>('voice_chat_started');
end;

function TtdMessage.VoiceChatEnded: ItdVoiceChatEnded;
begin
  Result := ReadToClass<TtdVoiceChatEnded>('voice_chat_ended');
end;

{ TtdShippingOption }
function TtdShippingOption.ID: string;
begin
  Result := ReadToSimpleType<string>('id');
end;
function TtdShippingOption.Prices: TArray<ItdLabeledPrice>;
begin
  Result := ReadToArray<ItdLabeledPrice>(TtdLabeledPrice, 'prices');
end;
function TtdShippingOption.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
{ TtdUpdate }
function TtdUpdate.CallbackQuery: ItdCallbackQuery;
begin
  Result := ReadToClass<TtdCallbackQuery>('callback_query');
end;
function TtdUpdate.ChannelPost: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('channel_post');
end;
function TtdUpdate.ChatMember: ItdChatMemberUpdated;
begin
  Result := ReadToClass<TtdChatMemberUpdated>('chat_member');
end;

function TtdUpdate.ChosenInlineResult: ItdChosenInlineResult;
begin
  Result := ReadToClass<TtdChosenInlineResult>('chosen_inline_result');
end;
function TtdUpdate.EditedChannelPost: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('edited_channel_post');
end;
function TtdUpdate.EditedMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('edited_message');
end;
function TtdUpdate.ID: Int64;
begin
  Result := ReadToSimpleType<Int64>('update_id');
end;
function TtdUpdate.InlineQuery: ItdInlineQuery;
begin
  Result := ReadToClass<TtdInlineQuery>('inline_query');
end;
function TtdUpdate.&Message: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('message');
end;
function TtdUpdate.MyChatMember: ItdChatMemberUpdated;
begin
  Result := ReadToClass<TtdChatMemberUpdated>('my_chat_member');
end;

function TtdUpdate.PollAnswer: ItdPollAnswer;
begin
  Result := ReadToClass<TtdPollAnswer>('poll_answer');
end;

function TtdUpdate.PollState: ItdPoll;
begin
  Result := ReadToClass<TtdPoll>('poll');
end;

function TtdUpdate.PreCheckoutQuery: ItdPreCheckoutQuery;
begin
  Result := ReadToClass<TtdPreCheckoutQuery>('pre_checkout_query');
end;
function TtdUpdate.ShippingQuery: ItdShippingQuery;
begin
  Result := ReadToClass<TtdShippingQuery>('shipping_query');
end;
function TtdUpdate.&Type: TtdUpdateType;
begin
  if CallbackQuery <> nil then
    Result := TtdUpdateType.CallbackQueryUpdate
  else if ChannelPost <> nil then
    Result := (TtdUpdateType.ChannelPost)
  else if ChosenInlineResult <> nil then
    Result := (TtdUpdateType.ChosenInlineResultUpdate)
  else if EditedChannelPost <> nil then
    Result := (TtdUpdateType.EditedChannelPost)
  else if EditedMessage <> nil then
    Result := (TtdUpdateType.EditedMessage)
  else if InlineQuery <> nil then
    Result := (TtdUpdateType.InlineQueryUpdate)
  else if Message <> nil then
    Result := (TtdUpdateType.MessageUpdate)
  else if PreCheckoutQuery <> nil then
    Result := (TtdUpdateType.PreCheckoutQueryUpdate)
  else if ShippingQuery <> nil then
    Result := (TtdUpdateType.ShippingQueryUpdate)
  else
    Result := TtdUpdateType.UnknownUpdate;
end;
{ TtdLocation }
constructor TtdLocation.Create(const ALatitude, ALongitude: Single);
var AJson: String;
begin
{ TODO 5 -oDieletro -cTypes : Preciso Fazer esta passagem dos paramentros nesse metodo }
//    FHorizontalAccuracy: Single;
//    FLivePeriod: Integer;
//    FHeading: Integer;
//    FProximityAlertRadius: Integer;
  SetLongitude(ALongitude);
  SetLatitude(ALatitude);
  AJson := '{ "latitude":'+ALatitude.ToString+'",';
  AJson := AJson + '"longitude":'+ALongitude.ToString+'}';
  Create(AJson);
end;
constructor TtdLocation.Create(const AJson: string);
begin
  inherited Create(AJson);
end;
function TtdLocation.GetHeading: Integer;
begin
  Result := ReadToSimpleType<Integer>('heading');
  FHeading := Result;
end;

function TtdLocation.GetHorizontalAccuracy: Single;
begin
  Result := ReadToSimpleType<Single>('horizontal_accuracy');
  FHorizontalAccuracy := Result;
end;

function TtdLocation.GetLatitude: Single;
begin
  Result := ReadToSimpleType<Single>('latitude');
  FLat := Result;
end;
function TtdLocation.GetLivePeriod: Integer;
begin
  Result := ReadToSimpleType<Integer>('live_period');
  FLivePeriod := Result;
end;

function TtdLocation.GetLongitude: Single;
begin
  Result := ReadToSimpleType<Single>('longitude');
  FLng := Result;
end;
function TtdLocation.GetProximityAlertRadius: Integer;
begin
  Result := ReadToSimpleType<Integer>('proximity_alert_radius');
  FProximityAlertRadius := Result;
end;

procedure TtdLocation.SetHeading(const Value: Integer);
begin

end;

procedure TtdLocation.SetHorizontalAccuracy(const Value: Single);
begin

end;

procedure TtdLocation.SetLatitude(const Value: Single);
begin
  FLat := Value;
//  FJSON.AddPair('latitude', TJSONNumber.Create(Value));
end;
procedure TtdLocation.SetLivePeriod(const Value: Integer);
begin

end;

procedure TtdLocation.SetLongitude(const Value: Single);
begin
 FLng := Value;
 // FJSON.AddPair('longitude', TJSONNumber.Create(Value));
end;
{ TtdStickerSet }
procedure TtdLocation.SetProximityAlertRadius(const Value: Integer);
begin
  FProximityAlertRadius := Value;
end;

function TtdStickerSet.ContainsMasks: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('contains_masks');
end;
function TtdStickerSet.Name: string;
begin
  Result := ReadToSimpleType<string>('name');
end;
function TtdStickerSet.Stickers: TArray<ItdSticker>;
begin
  Result := ReadToArray<ItdSticker>(TtdSticker, 'stickers');
end;
function TtdStickerSet.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
{ TtdLabeledPrice }
//UPDated By Ruan Diego Lacerda Menezes
constructor TtdLabeledPrice.Create(const ALabel: string; AAmount: Int64);
begin
  FLabel   := ALabel;
  FAmount := AAmount;

  FJSON := TJSONObject.Create;
  FJSON.AddPair('label', TJSONString.Create(ALabel));
  FJSON.AddPair('amount', TJSONNumber.Create(AAmount));

  AJSon := '{"'+FJSON.ToString+'"}';

  inherited Create(AJSon);
end;

constructor TtdLabeledPrice.Create(const AJson: string);
begin
 inherited Create(AJson);
end;
function TtdLabeledPrice.amount: Int64;
begin
  FAmount := ReadToSimpleType<Int64>('amount');
  Result := FAmount;
end;

function TtdLabeledPrice.&label: string;
begin
  FLabel := ReadToSimpleType<string>('label');
  Result := FLabel;
end;
{ TtdResponseParameters }
function TtdResponseParameters.MigrateToChatId: Int64;
begin
  Result := ReadToSimpleType<Int64>('migrate_to_chat_id');
end;
function TtdResponseParameters.RetryAfter: Int64;
begin
  Result := ReadToSimpleType<Int64>('retry_after');
end;
{ TtdUser }
function TtdUser.CanJoinGroups: Boolean;
begin
  Result := ReadToSimpleType<boolean>('can_join_groups');
end;

function TtdUser.CanReadAllGroupMessages: Boolean;
begin
  Result := ReadToSimpleType<boolean>('can_read_all_group_messages');
end;

function TtdUser.SupportsInlineQueries: Boolean;
begin
  Result := ReadToSimpleType<boolean>('supports_inline_queries');
end;

function TtdUser.FirstName: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;
function TtdUser.ID: Int64;
begin
  Result := ReadToSimpleType<Int64>('id');
end;
function TtdUser.IsBot: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_bot');
end;
function TtdUser.ToJSonStr: String;
begin
 Result := TJsonUtils.ObjectToJString(Self);
// '{"'+ID.ToJsonString+'","'+IsBot.ToJsonString+'","'+FirstName+'",'+
// '"'+LastName+'","'+LanguageCode+'","'+CanJoinGroups.ToJsonString+'",'+
// '"'+CanReadAllGroupMessages.ToJsonString+'","'+SupportsInlineQueries.ToJsonString+'"}';
end;

function TtdUser.LanguageCode: string;
begin
  Result := ReadToSimpleType<string>('language_code');
end;
function TtdUser.LastName: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;

function TtdUser.Username: string;
begin
  Result := ReadToSimpleType<string>('username');
end;
{ TtdInlineQuery }
function TtdInlineQuery.chat_type: TtdChatType;
var
  OutStr: String;
begin
  OutStr := ReadToSimpleType<string>('chat_type');

  if OutStr = TtdChatType.private.ToString then
    Result := TtdChatType.private
  else
  if OutStr = TtdChatType.Group.ToString then
    Result := TtdChatType.Group
  else
  if OutStr = TtdChatType.Channel.ToString then
    Result := TtdChatType.Channel
  else
  if OutStr = TtdChatType.Supergroup.ToString then
    Result := TtdChatType.Supergroup;
end;

function TtdInlineQuery.location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;

function TtdInlineQuery.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdInlineQuery.ID: string;
begin
  Result := ReadToSimpleType<string>('id');
end;

function TtdInlineQuery.Offset: string;
begin
  Result := ReadToSimpleType<string>('offset');
end;
function TtdInlineQuery.Query: string;
begin
  Result := ReadToSimpleType<string>('query');
end;
{ TtdChosenInlineResult }
function TtdChosenInlineResult.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdChosenInlineResult.InlineMessageId: string;
begin
  Result := ReadToSimpleType<string>('inline_message_id');
end;
function TtdChosenInlineResult.Location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;
function TtdChosenInlineResult.Query: string;
begin
  Result := ReadToSimpleType<string>('query');
end;
function TtdChosenInlineResult.ResultId: string;
begin
  Result := ReadToSimpleType<string>('result_id');
end;
{ TtdPreCheckoutQuery }
function TtdPreCheckoutQuery.Currency: string;
begin
  Result := ReadToSimpleType<string>('currency');
end;
function TtdPreCheckoutQuery.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdPreCheckoutQuery.ID: string;
begin
  Result := ReadToSimpleType<string>('id');
end;
function TtdPreCheckoutQuery.InvoicePayload: string;
begin
  Result := ReadToSimpleType<string>('invoice_payload');
end;
function TtdPreCheckoutQuery.OrderInfo: ItdOrderInfo;
begin
  Result := ReadToClass<TtdOrderInfo>('order_info');
end;
function TtdPreCheckoutQuery.ShippingOptionId: string;
begin
  Result := ReadToSimpleType<string>('shipping_option_id');
end;
function TtdPreCheckoutQuery.TotalAmount: Int64;
begin
  Result := ReadToSimpleType<Int64>('total_amount');
end;
{ TtdShippingQuery }
function TtdShippingQuery.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdShippingQuery.ID: string;
begin
  Result := ReadToSimpleType<string>('id');
end;
function TtdShippingQuery.InvoicePayload: string;
begin
  Result := ReadToSimpleType<string>('invoice_payload');
end;
function TtdShippingQuery.ShippingAddress: ItdShippingAddress;
begin
  Result := ReadToClass<TtdShippingAddress>('shipping_address');
end;
{ TtdChatPhoto }
function TtdChatPhoto.BigFileId: string;
begin
  Result := ReadToSimpleType<string>('big_file_id');
end;
function TtdChatPhoto.BigFileUniqueId: string;
begin
  Result := ReadToSimpleType<string>('big_file_unique_id');
end;

function TtdChatPhoto.SmallFileId: string;
begin
  Result := ReadToSimpleType<string>('small_file_id');
end;

function TtdChatPhoto.SmallFileUniqueId: string;
begin
  Result := ReadToSimpleType<string>('small_file_unique_id');
end;

{ TtdChat }
function TtdChat.AllMembersAreAdministrators: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('all_members_are_administrators');
end;
function TtdChat.Bio: String;
begin
  Result := ReadToSimpleType<String>('bio');
end;

function TtdChat.CanSetStickerSet: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_set_sticker_set');
end;
function TtdChat.Description: string;
begin
  Result := ReadToSimpleType<string>('description');
end;
function TtdChat.FirstName: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;
function TtdChat.ID: Int64;
begin
  Result := ReadToSimpleType<Int64>('id');
end;
function TtdChat.InviteLink: string;
begin
  Result := ReadToSimpleType<string>('invite_link');
end;
function TtdChat.IsGroup: Boolean;
var
  LValue: string;
begin
  LValue := ReadToSimpleType<string>('type');
  result := (LValue = 'group');
end;

function TtdChat.LastName: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;
function TtdChat.LinkedChatId: Integer;
begin
  Result := ReadToSimpleType<Integer>('linked_chat_id');
end;

function TtdChat.location: ItdChatLocation;
begin
  Result := ReadToClass<TtdChatLocation>('location');
end;

function TtdChat.Permissions: ItdChatPermissions;
begin
  Result := ReadToClass<TtdChatPermissions>('ChatPermissions');
end;

function TtdChat.Photo: ItdChatPhoto;
begin
  Result := ReadToClass<TtdChatPhoto>('photo');
end;
function TtdChat.PinnedMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('pinned_message');
end;
function TtdChat.SlowModeDelay: Integer;
begin
  Result := ReadToSimpleType<Integer>('slow_mode_delay');
end;

function TtdChat.StickerSetName: string;
begin
  Result := ReadToSimpleType<string>('sticker_set_name');
end;
function TtdChat.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
function TtdChat.ToJSonStr: String;
var
  LValue: string;
  Saida : Boolean;
begin
  LValue := ReadToSimpleType<string>('type');
  Saida := (LValue = 'group');

 Result := TJsonUtils.ObjectToJString(Self);


// '[{'+
// '"id":'+ReadToSimpleType<Int64>('id').ToString+sLineBreak+
// '","type":"'+ReadToSimpleType<string>('type')+sLineBreak+
// '","title":"'+ReadToSimpleType<string>('title')+sLineBreak+
// '","username":"'+ReadToSimpleType<string>('username')+sLineBreak+
// '","first_name":"'+ReadToSimpleType<string>('first_name')+sLineBreak+
// '","last_name":"'+ReadToSimpleType<string>('last_name')+sLineBreak+
// '","all_members_are_administrators":"'+ReadToSimpleType<Boolean>('all_members_are_administrators').ToJsonString + sLineBreak+
// '","photo":"'+ReadToSimpleType<string>('photo')+sLineBreak+
// '","description":"'+ReadToSimpleType<string>('description')+sLineBreak+
// '","invite_link":"'+ReadToSimpleType<string>('invite_link')+sLineBreak+
// '","pinned_message":"'+ReadToSimpleType<string>('pinned_message')+sLineBreak+
// '","sticker_set_name":"'+ReadToSimpleType<string>('sticker_set_name')+sLineBreak+
// '","can_set_sticker_set":"'+ReadToSimpleType<Boolean>('can_set_sticker_set').ToString+sLineBreak+
// '","is_group":"'+Saida.ToString+'"}]';
end;

function TtdChat.ToString: String;
var
  LValue: string;
  Saida : Boolean;
begin
  LValue := ReadToSimpleType<string>('type');
  Saida := (LValue = 'group');

 Result := TJsonUtils.ObjectToJString(Self);
// '[id='+ReadToSimpleType<Int64>('id').ToString+sLineBreak+
// 'type='+ReadToSimpleType<string>('type')+sLineBreak+
// 'title='+ReadToSimpleType<string>('title')+sLineBreak+
// 'username='+ReadToSimpleType<string>('username')+sLineBreak+
// 'first_name='+ReadToSimpleType<string>('first_name')+sLineBreak+
// 'last_name='+ReadToSimpleType<string>('last_name')+sLineBreak+
// 'all_members_are_administrators='+ ReadToSimpleType<Boolean>('all_members_are_administrators').ToJsonString + sLineBreak+
// 'photo='+ReadToSimpleType<string>('photo')+sLineBreak+
// 'description='+ReadToSimpleType<string>('description')+sLineBreak+
// 'invite_link='+ReadToSimpleType<string>('invite_link')+sLineBreak+
// 'pinned_message='+ReadToSimpleType<string>('pinned_message')+sLineBreak+
// 'sticker_set_name='+ReadToSimpleType<string>('sticker_set_name')+sLineBreak+
// 'can_set_sticker_set='+ReadToSimpleType<Boolean>('can_set_sticker_set').ToString+sLineBreak+
// 'is_group='+Saida.ToJsonString+']';

end;

function TtdChat.TypeChat: TtdChatType;
var
  LValue: string;
begin
  LValue := ReadToSimpleType<string>('type');
  Result := TtdChatType.&private;
  if LValue = 'private' then
    Result := TtdChatType.&private
  else if LValue = 'group' then
    Result := TtdChatType.Group
  else if LValue = 'channel' then
    Result := TtdChatType.Channel
  else if LValue = 'supergroup' then
    Result := TtdChatType.Supergroup
  else
    UnSupported;
end;
function TtdChat.Username: string;
begin
  Result := ReadToSimpleType<string>('username');
end;
{ TtdSuccessfulPayment }
function TtdSuccessfulPayment.Currency: string;
begin
  Result := ReadToSimpleType<string>('currency');
end;
function TtdSuccessfulPayment.InvoicePayload: string;
begin
  Result := ReadToSimpleType<string>('invoice_payload');
end;
function TtdSuccessfulPayment.OrderInfo: ItdOrderInfo;
begin
  Result := ReadToClass<TtdOrderInfo>('order_info');
end;
function TtdSuccessfulPayment.ProviderPaymentChargeId: string;
begin
  Result := ReadToSimpleType<string>('provider_payment_charge_id');
end;
function TtdSuccessfulPayment.ShippingOptionId: string;
begin
  Result := ReadToSimpleType<string>('shipping_option_id');
end;
function TtdSuccessfulPayment.TelegramPaymentChargeId: string;
begin
  Result := ReadToSimpleType<string>('telegram_payment_charge_id');
end;
function TtdSuccessfulPayment.TotalAmount: Int64;
begin
  Result := ReadToSimpleType<Int64>('total_amount');
end;
{ TtdWebhookInfo }
function TtdWebhookInfo.AllowedUpdates: TArray<string>;
var
  LJsonArray: TJSONArray;
  I: Integer;
begin
  LJsonArray := FJSON.GetValue('allowed_updates') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := ReadToSimpleType<string>(LJsonArray.Items[I].ToString);
end;
function TtdWebhookInfo.HasCustomCertificate: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_custom_certificate');
end;
function TtdWebhookInfo.IpAddress: String;
begin
  Result := ReadToSimpleType<String>('ip_address');
end;

function TtdWebhookInfo.LastErrorDate: TDateTime;
begin
  Result := ReadToDateTime('last_error_date');
end;
function TtdWebhookInfo.LastErrorMessage: string;
begin
  Result := ReadToSimpleType<string>('last_error_message');
end;
function TtdWebhookInfo.MaxConnections: Int64;
begin
  Result := ReadToSimpleType<Int64>('max_connections');
end;
function TtdWebhookInfo.PendingUpdateCount: Int64;
begin
  Result := ReadToSimpleType<Int64>('pending_update_count');
end;
function TtdWebhookInfo.Url: string;
begin
  Result := ReadToSimpleType<string>('url');
end;
{ TtdMessageEntity }
function TtdMessageEntity.Length: Int64;
begin
  Result := ReadToSimpleType<Int64>('length');
end;
function TtdMessageEntity.Offset: Int64;
begin
  Result := ReadToSimpleType<Int64>('offset');
end;
function TtdMessageEntity.TypeMessage: TtdMessageEntityType;
var
  LValue: string;
begin
  LValue := ReadToSimpleType<string>('type');
  Result := TtdMessageEntityType.N_A;
  if LValue = 'mention' then
    Result := TtdMessageEntityType.mention
  else if LValue = 'hashtag' then
    Result := TtdMessageEntityType.hashtag
  else if LValue = 'bot_command' then
    Result := TtdMessageEntityType.bot_command
  else if LValue = 'url' then
    Result := TtdMessageEntityType.Url
  else if LValue = 'bold' then
    Result := TtdMessageEntityType.bold
  else if LValue = 'italic' then
    Result := TtdMessageEntityType.italic
  else if LValue = 'code' then
    Result := TtdMessageEntityType.code
  else if LValue = 'pre' then
    Result := TtdMessageEntityType.pre
  else if LValue = 'text_link' then
    Result := TtdMessageEntityType.text_link
  else if LValue = 'text_mention' then
    Result := TtdMessageEntityType.text_mention
end;
function TtdMessageEntity.Url: string;
begin
  Result := ReadToSimpleType<string>('url');
end;
function TtdMessageEntity.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;
{ TtdAudio }
function TtdAudio.Duration: Int64;
begin
  Result := ReadToSimpleType<Int64>('duration');
end;
function TtdAudio.FileName: string;
begin
  Result := ReadToSimpleType<string>('file_name');
end;

function TtdAudio.MimeType: string;
begin
  Result := ReadToSimpleType<string>('mime_type');
end;
function TtdAudio.Performer: string;
begin
  Result := ReadToSimpleType<string>('performer');
end;
function TtdAudio.Thumb: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;

function TtdAudio.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
{ TtdPhotoSize }
function TtdPhotoSize.Height: Int64;
begin
  Result := ReadToSimpleType<Int64>('height');
end;
function TtdPhotoSize.Width: Int64;
begin
  Result := ReadToSimpleType<Int64>('width');
end;
{ TtdMaskPosition }
function TtdMaskPosition.Point: TtdMaskPositionPoint;
var
  LValue: string;
begin
  LValue := ReadToSimpleType<string>('point');
  Result := TtdMaskPositionPoint.forehead;
  if LValue = 'forehead' then
    Result := TtdMaskPositionPoint.forehead
  else if LValue = 'eyes' then
    Result := TtdMaskPositionPoint.eyes
  else if LValue = 'mouth' then
    Result := TtdMaskPositionPoint.mouth
  else if LValue = 'chin' then
    Result := TtdMaskPositionPoint.chin
  else
    UnSupported;
end;
function TtdMaskPosition.Scale: Single;
begin
  Result := ReadToSimpleType<Single>('scale');
end;
function TtdMaskPosition.XShift: Single;
begin
  Result := ReadToSimpleType<Single>('x_shift');
end;
function TtdMaskPosition.YShift: Single;
begin
  Result := ReadToSimpleType<Single>('y_shift');
end;
{ TtdSticker }
function TtdSticker.Emoji: string;
begin
  Result := ReadToSimpleType<string>('emoji');
end;
function TtdSticker.Height: Int64;
begin
  Result := ReadToSimpleType<Int64>('height');
end;
function TtdSticker.MaskPosition: ItdMaskPosition;
begin
  Result := ReadToClass<TtdMaskPosition>('mask_position');
end;
function TtdSticker.SetName: string;
begin
  Result := ReadToSimpleType<string>('set_name');
end;
function TtdSticker.Thumb: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
function TtdSticker.Width: Int64;
begin
  Result := ReadToSimpleType<Int64>('width');
end;
{ TtdGame }
function TtdGame.Animation: ItdAnimation;
begin
  Result := ReadToClass<TtdAnimation>('animation');
end;
function TtdGame.Description: string;
begin
  Result := ReadToSimpleType<string>('description');
end;
function TtdGame.Photo: TArray<ItdPhotoSize>;
begin
  Result := ReadToArray<ItdPhotoSize>(TtdPhotoSize, 'photo');
end;
function TtdGame.Text: string;
begin
  Result := ReadToSimpleType<string>('text');
end;
function TtdGame.TextEntities: TArray<ItdMessageEntity>;
begin
  Result := ReadToArray<ItdMessageEntity>(TtdMessageEntity, 'text_entities');
end;
function TtdGame.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
{ TtdInvoice }
constructor TtdInvoice.Create(const ATitle, ADescription, AStartParameter,
  Currency: string; ATotalAmount: Int64);
begin
  FTitle := ATitle;
  FDescription := ADescription;
  FStartParameter := AStartParameter;
  FCurrency := Currency;
  FTotalAmount := ATotalAmount;
end;

function TtdInvoice.Currency: string;
begin
  //Result := ReadToSimpleType<string>('currency');
  FCurrency := ReadToSimpleType<string>('currency');
  Result := FCurrency;
end;
function TtdInvoice.Description: string;
begin
  //Result := ReadToSimpleType<string>('description');
  FDescription := ReadToSimpleType<string>('description');
  Result := FDescription;
end;
function TtdInvoice.StartParameter: string;
begin
  //Result := ReadToSimpleType<string>('start_parameter');
  FStartParameter := ReadToSimpleType<string>('start_parameter');
  Result := FStartParameter;
end;
function TtdInvoice.Title: string;
begin
 // Result := ReadToSimpleType<string>('title');
  FTitle := ReadToSimpleType<string>('title');
  Result := FTitle;
end;
function TtdInvoice.TotalAmount: Int64;
begin
  //Result := ReadToSimpleType<Int64>('total_amount');
  FTotalAmount := ReadToSimpleType<Int64>('total_amount');
  Result := FTotalAmount;
end;
{ TtdVideo }
function TtdVideo.Duration: Int64;
begin
  Result := ReadToSimpleType<Int64>('duration');
end;
function TtdVideo.FileName: string;
begin
  Result := ReadToSimpleType<string>('file_name');
end;

function TtdVideo.Height: Int64;
begin
  Result := ReadToSimpleType<Int64>('height');
end;
function TtdVideo.MimeType: string;
begin
  Result := ReadToSimpleType<string>('mime_type');
end;
function TtdVideo.Thumb: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
function TtdVideo.Width: Int64;
begin
  Result := ReadToSimpleType<Int64>('width');
end;
{ TtdContact }
constructor TtdContact.Create(const AJson: string);
begin
  inherited Create(AJson);
end;

constructor TtdContact.Create(const ANumeroTelelefone, APrimeiroNome, UltimoNome: String);
begin
  SetPhoneNumber(ANumeroTelelefone);
  SetFirstName(APrimeiroNome);
  SetLastName(UltimoNome);
  inherited Create(FJson);
end;

procedure TtdContact.SetFirstName(const Value: string);
begin
  FJson := FJson + ' "first_name":"'+Value+'",';
//  FJSON.AddPair('first_name', TJSONString.Create(Value));
end;

procedure TtdContact.SetLastName(const Value: string);
begin
  FJson := FJson + ' "last_name":"'+Value+'"}';
//  FJSON.AddPair('last_name', TJSONString.Create(Value));
end;

procedure TtdContact.SetPhoneNumber(const Value: string);
begin
  FJson := '{"phone_number":"'+Value+'",';
 // FJSON.AddPair('phone_number', TJSONString.Create(Value));
end;

function TtdContact.FirstName: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;
function TtdContact.LastName: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;
function TtdContact.PhoneNumber: string;
begin
  Result := ReadToSimpleType<string>('phone_number');
end;
function TtdContact.UserId: Int64;
begin
  Result := ReadToSimpleType<Int64>('user_id');
end;
{ TtdVenue }
constructor TtdVenue.Create(const ALocation: ItdLocation; ATitle, AAddress,
  AFoursquareId, AFoursquareType: String);
begin
  SetLocation(ALocation);
  SetTitle(ATitle);
  SetAddress(AAddress);
  SetFoursquareId(AFoursquareId);
  SetFoursquareType(AFoursquareType);
end;

function TtdVenue.Address: string;
begin
  Result := ReadToSimpleType<string>('address');
end;
function TtdVenue.FoursquareId: string;
begin
  Result := ReadToSimpleType<string>('foursquare_id');
end;
function TtdVenue.FoursquareType: string;
begin
  Result := ReadToSimpleType<string>('foursquare_type');
end;
function TtdVenue.google_place_id: string;
begin
  Result := ReadToSimpleType<string>('google_place_id');
end;

function TtdVenue.google_place_type: string;
begin
  Result := ReadToSimpleType<string>('google_place_type');
end;

function TtdVenue.Location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;
function TtdVenue.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;

constructor TtdVenue.Create(const AJson: string);
begin
  inherited Create(AJson);
end;

constructor TtdVenue.Create(const ALatitude, ALongitude: Single; ATitle,
  AAddress, AFoursquareId, AFoursquareType, AGooglePlaceId,
  AGooglePlaceType: String);
begin
  SetLongitude(ALongitude);
  SetLatitude(ALatitude);
  SetTitle(ATitle);
  SetAddress(AAddress);
  SetFoursquareId(AFoursquareId);
  SetFoursquareType(AFoursquareType);
  SetGooglePlaceId(AGooglePlaceId);
  SetGooglePlaceType(AGooglePlaceType);

  if Not Assigned(FLocation) then
    FLocation := TtdLocation.Create(ALatitude, ALongitude);
end;

destructor TtdVenue.Destroy;
begin
  {$IF NOT DEFINE DELPHI14_UP}
  if Assigned(FLocation) then
    FreeAndNil(FLocation);
  {$ENDIF DELPHI14_UP}
  Inherited Destroy;
end;

constructor TtdVenue.Create(const ALatitude, ALongitude: Single; ATitle,
  AAddress, AFoursquareId, AFoursquareType: String);
begin
  SetLongitude(ALongitude);
  SetLatitude(ALatitude);
  SetTitle(ATitle);
  SetAddress(AAddress);
  SetFoursquareId(AFoursquareId);
  SetFoursquareType(AFoursquareType);

  if Not Assigned(FLocation) then
    FLocation := TtdLocation.Create(ALatitude, ALongitude);
end;
procedure TtdVenue.SetLatitude(const Value: Single);
begin
  FLatitude := Value;
end;

procedure TtdVenue.SetLocation(const Value: ItdLocation);
begin
  FLocation := Value;
  SetLatitude(Value.Latitude);
  SetLongitude(Value.Longitude);
end;

procedure TtdVenue.SetLongitude(const Value: Single);
begin
  FLongitude := Value;
end;

procedure TtdVenue.SetTitle(const Value: String);
begin
  FTitle := Value;
end;
procedure TtdVenue.SetAddress(const Value: String);
begin
  FAddress := Value;
end;

procedure TtdVenue.SetFoursquareId(const Value: String);
begin
  FFoursquareId := Value;
end;

procedure TtdVenue.SetFoursquareType(const Value: String);
begin
  FFoursquareType := Value;
end;

procedure TtdVenue.SetGooglePlaceId(const Value: string);
begin
  FGooglePlaceId := Value;
end;

procedure TtdVenue.SetGooglePlaceType(const Value: String);
begin
  FGooglePlaceType := Value;
end;

{TtdVideoNote}
function TtdVideoNote.Duration: Int64;
begin
  Result := ReadToSimpleType<Int64>('duration');
end;
function TtdVideoNote.FileId: string;
begin
  Result := ReadToSimpleType<string>('file_id');
end;
function TtdVideoNote.FileSize: Int64;
begin
  Result := ReadToSimpleType<Int64>('file_size');
end;
function TtdVideoNote.Length: Int64;
begin
  Result := ReadToSimpleType<Int64>('length');
end;
function TtdVideoNote.Thumb: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
{ TtdVoice }
function TtdVoice.Duration: Int64;
begin
  Result := ReadToSimpleType<Int64>('duration');
end;
function TtdVoice.MimeType: string;
begin
  Result := ReadToSimpleType<string>('mime_type');
end;
{ TtdOrderInfo }
function TtdOrderInfo.Email: string;
begin
  Result := ReadToSimpleType<string>('email');
end;
function TtdOrderInfo.Name: string;
begin
  Result := ReadToSimpleType<string>('name');
end;
function TtdOrderInfo.PhoneNumber: string;
begin
  Result := ReadToSimpleType<string>('phone_number');
end;
function TtdOrderInfo.ShippingAddress: ItdShippingAddress;
begin
  Result := ReadToClass<TtdShippingAddress>('shipping_address');
end;
{ TtdShippingAddress }
function TtdShippingAddress.City: string;
begin
  Result := ReadToSimpleType<string>('city');
end;
function TtdShippingAddress.CountryCode: string;
begin
  Result := ReadToSimpleType<string>('country_code');
end;
function TtdShippingAddress.PostCode: string;
begin
  Result := ReadToSimpleType<string>('post_code');
end;
function TtdShippingAddress.State: string;
begin
  Result := ReadToSimpleType<string>('state');
end;
function TtdShippingAddress.StreetLine1: string;
begin
  Result := ReadToSimpleType<string>('street_line1');
end;
function TtdShippingAddress.StreetLine2: string;
begin
  Result := ReadToSimpleType<string>('street_line2');
end;
{ TtdUserProfilePhotos }
function TtdUserProfilePhotos.Photos: TArray<TArray<ItdPhotoSize>>;
var
  PhotoArr, SizeArr: TJSONArray;
  PhotoIndex, ResultPhotoIndex: Integer;
  SizeIndex: Integer;
  GUID: TGUID;
begin
  Result := nil;
  PhotoArr := FJSON.GetValue('photos') as TJSONArray;
  if (not Assigned(PhotoArr)) or PhotoArr.Null then
    Exit;
  GUID := GetTypeData(TypeInfo(ItdPhotoSize))^.GUID;
  SetLength(Result, PhotoArr.Count);
  //Some photos could be empty(?), so we should
  //use separated counter instead of copy of the FOR-loop variable value.
  ResultPhotoIndex := 0;
  for PhotoIndex := 0 to High(Result) do
  begin
    //get array of photoSizes from photoArr[i]
    SizeArr := PhotoArr.Items[PhotoIndex] as TJSONArray;
    //check for empty photo
    if (not Assigned(SizeArr)) or SizeArr.Null then
      Continue;
    //set length of photoSize array
    SetLength(Result[ResultPhotoIndex], SizeArr.Count);
    //fills the result[RealIndex] with array of sizes
    for SizeIndex := 0 to High(Result[ResultPhotoIndex]) do
      GetTdClass.Create(SizeArr.Items[SizeIndex].ToString).GetInterface(GUID, Result[ResultPhotoIndex, SizeIndex]);
    //inc counter of processed photos
    Inc(ResultPhotoIndex);
  end;
  //Set real length of the result array. length = zero based index + 1;
  SetLength(Result, ResultPhotoIndex + 1);
end;
function TtdUserProfilePhotos.TotalCount: Int64;
begin
  Result := ReadToSimpleType<Int64>('total_count');
end;
{ TtdPollOption }

function TtdPollOption.text: String;
begin
  Result := ReadToSimpleType<String>('text');
end;

function TtdPollOption.voter_count: String;
begin
  Result := ReadToSimpleType<String>('voter_count');
end;

{ TtdPollAnswer }

function TtdPollAnswer.option_ids: TArray<Integer>;
var
  LJsonArray: TJSONArray;
  I: Integer;
begin
  LJsonArray := FJSON.GetValue('option_ids') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := ReadToSimpleType<integer>(LJsonArray.Items[I].ToString);
end;

function TtdPollAnswer.poll_id: String;
begin
  Result := ReadToSimpleType<String>('poll_id');
end;

function TtdPollAnswer.user: ItdUser;
begin
  Result := ReadToSimpleType<ItdUser>('user');
end;

{ TtdPoll }

function TtdPoll.allows_multiple_answers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allows_multiple_answers');
end;

function TtdPoll.correct_option_id: Integer;
begin
  Result := ReadToSimpleType<Integer>('correct_option_id');
end;

function TtdPoll.Id: String;
begin
  Result := ReadToSimpleType<String>('Id');
end;

function TtdPoll.is_anonymous: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_anonymous');
end;

function TtdPoll.is_closed: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_closed');
end;

function TtdPoll.options: TArray<ItdPollOption>;
begin
  Result := ReadToArray<ItdPollOption>(TtdPollOption, 'options');
end;

function TtdPoll.question: String;
begin
  Result := ReadToSimpleType<String>('question');
end;

function TtdPoll.total_voter_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('total_voter_count');
end;

function TtdPoll.&type: String;
begin
  Result := ReadToSimpleType<String>('type');
end;

{ TtdDice }

function TtdDice.Emoji: String;
begin
  Result := ReadToSimpleType<String>('emoji');
end;

function TtdDice.value: Integer;
begin
  Result := ReadToSimpleType<Integer>('value');
end;


{ TtdLoginURL }

function TtdLoginURL.BotUserName: String;
begin
  Result := ReadToSimpleType<String>('bot_username');
end;

//constructor TtdLoginURL.Create(AJson: String);
//begin
//  inherited Create(AJson);
//end;

constructor TtdLoginURL.Create(const AUrl: String;const AForwardText: String = '';
     const ABotUserName: String = '';const ARequestWriteAccess: Boolean = False);
  var
  AJson: String;
begin
  FRequestWriteAccess := ARequestWriteAccess;
  FUrl := AUrl;
  FForwardText := AForwardText;
  FBotUserName := ABotUserName;

//  FJson.AddPair('url',TJSONString(FUrl));
//  FJson.AddPair('forward_text',TJSONString(FForwardText));
//  FJson.AddPair('bot_username',TJSONString(FBotUserName));
//  FJson.AddPair('request_write_access',TJSONBool(FRequestWriteAccess));


  AJson :=
  '{"url":"'+FUrl+
  '","forward_text":"'+FForwardText+
  '","bot_username":"'+FBotUserName+
  '","request_write_access":"'+FRequestWriteAccess.ToJSONBool+'"}';
  inherited Create(AJson);
end;

function TtdLoginURL.ForwardText: String;
begin
  Result := ReadToSimpleType<String>('forward_text');
end;

function TtdLoginURL.RequestWriteAccess: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('request_write_access');
end;

function TtdLoginURL.URL: String;
begin
  Result := ReadToSimpleType<String>('url');
end;

{ TtdBotCommand }

function TtdBotCommand.Command: String;
begin
  Result := ReadToSimpleType<String>('command');
end;

constructor TtdBotCommand.Create(const ACommand: String; ADescription: String);
var
  AJson: String;
begin

  AJson := '{"command":"'+ACommand+'","description":"'+ADescription+'"}';

  FDesc := ADescription;
  FCMD := ACommand;

  inherited Create(AJson);
end;

function TtdBotCommand.Description: String;
begin
  Result := ReadToSimpleType<String>('description');
end;

{ TtdAnswerPreCheckoutQuery }

function TtdAnswerPreCheckoutQuery.ErrorMessage: string;
begin
  Result := ReadToSimpleType<string>('error_message');
end;

function TtdAnswerPreCheckoutQuery.Ok: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('ok');
end;

function TtdAnswerPreCheckoutQuery.PreCheckoutQueryId: string;
begin
  Result := ReadToSimpleType<string>('pre_checkout_query_id');
end;

{ TtdAnswerShippingQuery }

function TtdAnswerShippingQuery.ErrorMessage: string;
begin
  Result := ReadToSimpleType<string>('error_message');
end;

function TtdAnswerShippingQuery.Ok: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('ok');
end;

function TtdAnswerShippingQuery.ShippingOptions: TArray<ItdShippingOption>;
begin
  Result := ReadToArray<ItdShippingOption>(TtdShippingOption, 'shipping_options');
end;

function TtdAnswerShippingQuery.ShippingQueryId: string;
begin
  Result := ReadToSimpleType<string>('shipping_query_id');
end;

{ TtdPassportFile }

function TtdPassportFile.file_date: Integer;
begin
  Result := ReadToSimpleType<Integer>('file_date');
end;

function TtdPassportFile.file_id: string;
begin
  Result := ReadToSimpleType<string>('file_id');
end;

function TtdPassportFile.file_size: Integer;
begin
  Result := ReadToSimpleType<Integer>('file_size');
end;

function TtdPassportFile.file_unique_id: string;
begin
  Result := ReadToSimpleType<string>('file_unique_id');
end;

{ TtdEncryptedPassportElement }

function TtdEncryptedPassportElement.data: string;
begin
  Result := ReadToSimpleType<string>('data');
end;

function TtdEncryptedPassportElement.email: string;
begin
  Result := ReadToSimpleType<string>('email');
end;

function TtdEncryptedPassportElement.files: TArray<ItdPassportFile>;
begin
  Result := ReadToArray<ItdPassportFile>(TtdPassportFile, 'files');
end;

function TtdEncryptedPassportElement.front_side: ItdPassportFile;
begin
  Result := ReadToClass<TtdPassportFile>('front_side');
end;

function TtdEncryptedPassportElement.hash: string;
begin
  Result := ReadToSimpleType<string>('hash');
end;

function TtdEncryptedPassportElement.phone_number: string;
begin
  Result := ReadToSimpleType<string>('phone_number');
end;

function TtdEncryptedPassportElement.reverse_side: ItdPassportFile;
begin
  Result := ReadToClass<TtdPassportFile>('reverse_side');
end;

function TtdEncryptedPassportElement.selfie: ItdPassportFile;
begin
  Result := ReadToClass<TtdPassportFile>('selfie');
end;

function TtdEncryptedPassportElement.translation: TArray<ItdPassportFile>;
begin
  Result := ReadToArray<ItdPassportFile>(TtdPassportFile, 'translation');
end;

function TtdEncryptedPassportElement.&type: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdEncryptedCredentials }

function TtdEncryptedCredentials.Data: String;
begin
  Result := ReadToSimpleType<string>('data');
end;

function TtdEncryptedCredentials.Hash: String;
begin
  Result := ReadToSimpleType<string>('hash');
end;

function TtdEncryptedCredentials.Secret: String;
begin
  Result := ReadToSimpleType<string>('secret');
end;

{ TtdPassportData }

function TtdPassportData.Credentials: ItdEncryptedCredentials;
begin
  Result := ReadToClass<TtdEncryptedCredentials>('credentials');
end;

function TtdPassportData.Data: TArray<ItdEncryptedPassportElement>;
begin
  Result := ReadToArray<ItdEncryptedPassportElement>(TtdEncryptedPassportElement, 'data');
end;

{ TtdProximityAlertTriggered }

function TtdProximityAlertTriggered.distance: Integer;
begin
  Result := ReadToSimpleType<Integer>('distance');
end;

function TtdProximityAlertTriggered.traveler: ItdUser;
begin
  Result := ReadToClass<TtdUser>('traveler');
end;

function TtdProximityAlertTriggered.watcher: ItdUser;
begin
  Result := ReadToClass<TtdUser>('watcher');
end;

{ TtdChatPermissions }

function TtdChatPermissions.CanAddWebPagePreviews: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_add_web_page_previews');
end;

function TtdChatPermissions.CanChangeInfo: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_change_info');
end;

function TtdChatPermissions.CanInviteUsers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_invite_users');
end;

function TtdChatPermissions.CanPinMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;

function TtdChatPermissions.CanSendMediaMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_media_messages');
end;

function TtdChatPermissions.CanSendMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_messages');
end;

function TtdChatPermissions.CanSendOtherMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_other_messages');
end;

function TtdChatPermissions.CanSendPolls: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_polls');
end;

{ TtdChatLocation }

function TtdChatLocation.Address: String;
begin
  Result := ReadToSimpleType<String>('address');
end;

function TtdChatLocation.Location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;

{ TtdChatInviteLink }

function TtdChatInviteLink.creator: ItdUser;
begin
  Result := ReadToClass<TtdUser>('creator');
end;

function TtdChatInviteLink.expire_date: TDateTime;
begin
  Result := ReadToDateTime('expire_date');
end;

function TtdChatInviteLink.invite_link: String;
begin
  Result := ReadToSimpleType<String>('invite_link');
end;

function TtdChatInviteLink.is_primary: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_primary');
end;

function TtdChatInviteLink.is_revoked: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_revoked');
end;

function TtdChatInviteLink.member_limit: Integer;
begin
  Result := ReadToSimpleType<Integer>('member_limit');
end;

{ TtdChatMemberUpdated }

function TtdChatMemberUpdated.Chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdChatMemberUpdated.Date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;

function TtdChatMemberUpdated.From: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;

function TtdChatMemberUpdated.invite_link: ItdChatInviteLink;
begin
  Result := ReadToClass<TtdChatInviteLink>('invite_link');
end;

function TtdChatMemberUpdated.new_chat_member: ItdChatMember;
begin
  Result := ReadToClass<TtdChatMember>('new_chat_member');
end;

function TtdChatMemberUpdated.old_chat_member: ItdChatMember;
begin
  Result := ReadToClass<TtdChatMember>('old_chat_member');
end;

{ TtdVoiceChatEnded }

function TtdVoiceChatEnded.duration: Integer;
begin
  Result := ReadToSimpleType<Integer>('duration');
end;

{ TtdVoiceChatParticipantsInvited }

function TtdVoiceChatParticipantsInvited.Users: TArray<ItdUser>;
begin
  Result := ReadToArray<ItdUser>(TtdUser, 'users');
end;

{ TtdMessageAutoDeleteTimerChanged }

function TtdMessageAutoDeleteTimerChanged.message_auto_delete_time: TDateTime;
begin
  Result := ReadToDateTime('message_auto_delete_time');
end;

{ TtdVoiceChatScheduled }

function TtdVoiceChatScheduled.start_date: TDateTime;
begin
  Result := ReadToDateTime('start_date');
end;

{ TtdChatMember }

function TtdChatMember.ChatMemberAdministrator: TtdChatMemberAdministrator;
begin
  Result := ReadToClass<TtdChatMemberAdministrator>('ChatMemberAdministrator');
end;

function TtdChatMember.ChatMemberBanned: TtdChatMemberBanned;
begin
  Result := ReadToClass<TtdChatMemberBanned>('ChatMemberBanned');
end;

function TtdChatMember.ChatMemberLeft: TtdChatMemberLeft;
begin
  Result := ReadToClass<TtdChatMemberLeft>('ChatMemberLeft');
end;

function TtdChatMember.ChatMemberMember: TtdChatMemberMember;
begin
  Result := ReadToClass<TtdChatMemberMember>('ChatMemberMember');
end;

function TtdChatMember.ChatMemberOwner: TtdChatMemberOwner;
begin
  Result := ReadToClass<TtdChatMemberOwner>('ChatMemberOwner');
end;

function TtdChatMember.ChatMemberRestricted: TtdChatMemberRestricted;
begin

end;

{ TtdChatMemberOwner }

function TtdChatMemberOwner.CustomTitle: String;
begin
  Result := ReadToSimpleType<String>('custom_title');
end;

function TtdChatMemberOwner.IsAnonymous: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_anonymous');
end;

function TtdChatMemberOwner.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;
end;

function TtdChatMemberOwner.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdChatMemberAdministrator }

function TtdChatMemberAdministrator.CanBeEdited: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_be_edited');
end;

function TtdChatMemberAdministrator.CanChangeInfo: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_change_info');
end;

function TtdChatMemberAdministrator.CanDeleteMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_delete_messages');
end;

function TtdChatMemberAdministrator.CanEditMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_edit_messages');
end;

function TtdChatMemberAdministrator.CanInviteUsers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_invite_users');
end;

function TtdChatMemberAdministrator.CanManageChat: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_chat');
end;

function TtdChatMemberAdministrator.CanManageVoiceChats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_voice_chats');
end;

function TtdChatMemberAdministrator.CanPinMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;

function TtdChatMemberAdministrator.CanPostMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_post_messages');
end;

function TtdChatMemberAdministrator.CanPromoteMembers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_promote_members');
end;

function TtdChatMemberAdministrator.CanRestrictMembers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_restrict_members');
end;

function TtdChatMemberAdministrator.CustomTitle: String;
begin
  Result := ReadToSimpleType<String>('custom_title');
end;

function TtdChatMemberAdministrator.IsAnonymous: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_anonymous');
end;

function TtdChatMemberAdministrator.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;

end;

function TtdChatMemberAdministrator.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdChatMemberMember }

function TtdChatMemberMember.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;

end;

function TtdChatMemberMember.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdChatMemberRestricted }

function TtdChatMemberRestricted.CanAddWebPagePreviews: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_add_web_page_previews');
end;

function TtdChatMemberRestricted.CanChangeInfo: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_change_info');
end;

function TtdChatMemberRestricted.CanInviteUsers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_invite_users');
end;

function TtdChatMemberRestricted.CanPinMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;

function TtdChatMemberRestricted.CanSendMediaMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_media_messages');
end;

function TtdChatMemberRestricted.CanSendMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_messages');
end;

function TtdChatMemberRestricted.CanSendOtherMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_other_messages');
end;

function TtdChatMemberRestricted.CanSendPolls: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_polls');
end;

function TtdChatMemberRestricted.IsMember: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_member');
end;

function TtdChatMemberRestricted.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;

end;

function TtdChatMemberRestricted.UntilDate: TDateTime;
begin
  Result := ReadToDateTime('until_date');
end;

function TtdChatMemberRestricted.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdChatMemberLeft }

function TtdChatMemberLeft.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;

end;

function TtdChatMemberLeft.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdChatMemberBanned }

function TtdChatMemberBanned.Status: TtdChatMemberStatus;
var
  LStatus: string;
begin
  Result := TtdChatMemberStatus.Member;
  LStatus := ReadToSimpleType<string>('status');
  if LStatus = 'creator' then
    Result := TtdChatMemberStatus.Creator
  else if LStatus = 'administrator' then
    Result := TtdChatMemberStatus.Administrator
  else if LStatus = 'member' then
    Result := TtdChatMemberStatus.Member
  else if LStatus = 'restricted' then
    Result := TtdChatMemberStatus.Restricted
  else if LStatus = 'left' then
    Result := TtdChatMemberStatus.Left
  else if LStatus = 'kicked' then
    Result := TtdChatMemberStatus.Kicked
  else
    TBaseJson.UnSupported;

end;

function TtdChatMemberBanned.UntilDate: TDateTime;
begin
  Result := ReadToDateTime('until_date');
end;

function TtdChatMemberBanned.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

End.


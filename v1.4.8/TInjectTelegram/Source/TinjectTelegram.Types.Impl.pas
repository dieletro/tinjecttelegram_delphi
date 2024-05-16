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
  TinjectTelegram.Types.Passport, Vcl.Graphics, Winapi.Windows;
type
  TtdUser = class(TBaseJson, ItdUser)
  public
    function ID: Int64;
    function IsBot: Boolean;
    function FirstName: string;
    function LastName: string;
    function Username: string;
    function LanguageCode: string;
    function isPremium: Boolean;
    function AddedToAttachmentMenu: string;
    function CanJoinGroups: Boolean;
    function CanReadAllGroupMessages: Boolean;
    function SupportsInlineQueries: Boolean;
    function CanConnectToBusiness: Boolean;
    function ToJSonStr: String;
  end;

  TtdChatMember = class(TBaseJson, ItdChatMember)
    function User: ItdUser;
    function Status: TtdChatMemberStatus;
  End;

  TtdChatMemberOwner = class(TtdChatMember)
  public
    function CustomTitle: String;
    function IsAnonymous : Boolean;
  end;

  TtdChatMemberAdministrator = class(TtdChatMember)
  public
    function CanBeEdited: Boolean;
    function IsAnonymous : Boolean;
    function CanManageChat: Boolean;
    function CanDeleteMessages: Boolean;
    function CanManageVideoChats: Boolean;
    function CanRestrictMembers:	Boolean;
    function CanPromoteMembers:	Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers: Boolean;
    function CanPostMessages: Boolean;
    function CanEditMessages: Boolean;
    function CanPinMessages: Boolean;
    function CanPostStories: Boolean;
    function CanEditStories: Boolean;
    function CanDeleteStories: Boolean;
    function CanManageTopics: Boolean;
    function CustomTitle: String;
  end;

  TtdChatMemberMember = class(TtdChatMember)
  public
  end;

  TtdChatMemberRestricted = class(TtdChatMember)
  public
    function IsMember:	Boolean;
    function CanSendMessages: Boolean;
    function CanSendAudios: Boolean;
    function CanSendDocuments: Boolean;
    function CanSendPhotos: Boolean;
    function CanSendVideos: Boolean;
    function CanSendVideoNotes: Boolean;
    function CanSendVoiceNotes: Boolean;
    function CanSendPolls: Boolean;
    function CanSendOtherMessages: Boolean;
    function CanAddWebPagePreviews: Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers: Boolean;
    function CanPinMessages: Boolean;
    function CanManageTopics: Boolean;
    function UntilDate: TDateTime;
  end;

  TtdChatMemberLeft = class(TtdChatMember)
  public
  end;

  TtdChatMemberBanned = class(TtdChatMember)
  public
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
    function via_join_request: Boolean;
    function via_chat_folder_invite_link: Boolean;
  End;


  TtdChatPhoto = class(TBaseJson, ItdChatPhoto)
    function SmallFileId: string;
    function SmallFileUniqueId: string;
    function BigFileId: string;
    function BigFileUniqueId: string;
  end;

  TtdChatPermissions = class(TBaseJson, ItdChatPermissions)
  public
    function CanSendMessages: Boolean;
    function CanSendAudios: Boolean;
    function CanSendDocuments: Boolean;
    function CanSendPhotos: Boolean;
    function CanSendVideos: Boolean;
    function CanSendVideoNotes: Boolean;
    function CanSendVoiceNotes: Boolean;
    function CanSendPolls: Boolean;
    function CanSendOtherMessages: Boolean;
    function CanAddWebPagePreviews: Boolean;
    function CanChangeInfo:	Boolean;
    function CanInviteUsers: Boolean;
    function CanPinMessages: Boolean;
    function CanManageTopics: Boolean;
  end;
  TtdChatLocation = class(TBaseJson, ItdChatLocation)
  public
    function Location: ItdLocation;
    function Address:	String; //Limit of a 64 character
  end;

  TtdBirthdate = class(TBaseJson, ItdBirthdate)
  public
    function day: Integer;
    function month: Integer;
    function year: Integer;
  end;

  TtdBusinessIntro = class(TBaseJson, ItdBusinessIntro)
  public
    function title: String;
    function message_: String;
    function sticker: ItdSticker;
  end;

  TtdBusinessLocation = class(TBaseJson, ItdBusinessLocation)
  public
    function address: String;
    function location: ItdLocation;
  end;

  TtdBusinessOpeningHoursInterval = class(TBaseJson, ItdBusinessOpeningHoursInterval)
  public
    function opening_minute: integer;
    function closing_minute: integer;
  end;

  TtdBusinessOpeningHours = class(TBaseJson, ItdBusinessOpeningHours)
  public
    function time_zone_name: string;
    function opening_hours: TArray<TtdBusinessOpeningHoursInterval>;
  end;

  TtdChat = class(TBaseJson, ItdChat)
  public
    function ID: Int64;
    function TypeChat: TtdChatType;
    function Title: string;
    function Username: string;
    function FirstName: string;
    function LastName: string;
    function is_forum: boolean;
  end;

  TtdChatFullInfo = class(TBaseJson, ItdChatFullInfo)
  private
    function IsGroup: Boolean;
  public
    function ID: Int64;
    function TypeChat: TtdChatType;
    function Title: string;
    function Username: string;
    function FirstName: string;
    function LastName: string;
    function is_forum: boolean;
    function accent_color_id: integer;
    function max_reaction_count: integer;
    function Photo: ItdChatPhoto;
    function active_usernames: Tarray<string>;
    function birthdate: ItdBirthdate;
    function business_intro: ItdBusinessIntro;
    function business_location: ItdBusinessLocation;
    function business_opening_hours: ItdBusinessOpeningHours;
    function personal_chat: ItdChat;
    function available_reactions: TArray<ItdReactionType>;
    function background_custom_emoji_id: string;
    function profile_accent_color_id: Integer;
    function profile_background_custom_emoji_id: string;
    function emoji_status_custom_emoji_id: string;
    function emoji_status_expiration_date: Integer;
    function Bio:	String;
    function HasPrivateForwards: Boolean;
    function has_restricted_voice_and_video_messages: boolean;
    function JoinToSendMessages: Boolean; //New
    function JoinByRequest: Boolean;      //New
    function Description: string;
    function InviteLink: string;
    function PinnedMessage: ItdMessage;
    function Permissions: ItdChatPermissions;
    function SlowModeDelay:	Integer;
    function UnrestrictBoostCount: Integer;
    function MessageAutoDeleteTime: integer;
    function has_aggressive_anti_spam_enabled: Boolean;
    function has_hidden_members: Boolean;
    function HasProtectedContent: boolean;
    function HasVisibleHistory: boolean;
    function StickerSetName: string;
    function CanSetStickerSet: Boolean;
    function CustomEmojiStickerSetName: String;
    function LinkedChatId:	Integer;
    function location: ItdChatLocation;
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
    function language: string;
    function custom_emoji_id: string;
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
    function Thumbnail: ItdPhotoSize;
  end;
  TtdPhotoSize = class(TtdFile, ItdPhotoSize)
  public
    function Width: Int64;
    function Height: Int64;
  end;
  TtdDocument = class(TtdFile, ItdDocument)
  public
    function Thumbnail: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  TtdMaskPosition = class(TBaseJson, ItdMaskPosition)
    function Point: TtdMaskPositionPoint;
    function XShift: Single;
    function YShift: Single;
    function Scale: Single;
  end;

  TtdInputSticker = class(TBaseJson, ItdInputSticker)
  public
    function sticker: string;
    function format: string;
    function emoji_list: TArray<string>;
    function mask_position: ItdMaskPosition;
    function keywords: TArray<string>;
  end;

  TtdSharedUser = class(TBaseJson, ItdSharedUser)
  public
    function user_id: int64;
    function first_name: string;
    function last_name: string;
    function username: string;
    function photo: TArray<ItdPhotosize>;
  end;

  TtdUsersShared = class(TBaseJson, ItdUsersShared)
  public
    function request_id: integer;
    function users: TArray<ItdSharedUser>;
  end;

  TtdChatShared = class(TBaseJson, ItdChatShared)
  public
    function request_id: integer;
    function chat_id: integer;
    function title: string;
    function username: string;
    function photo: TArray<ItdPhotosize>;
  end;

  TtdSticker = class(TtdFile, ItdSticker)
  public
    function type_: string;
    function Width: Int64;
    function Height: Int64;
    function is_animated:	Boolean;
    function is_video:	Boolean;
    function Thumbnail: ItdPhotoSize;
    function Emoji: string;
    function SetName: string;
    function PremiumAnimation: ItdFile;
    function MaskPosition: ItdMaskPosition;
    function CustomEmojiId: Int64;
    function NeedsRepainting: boolean;
  end;

  TtdStory = class(TBaseJson, ItdStory)
  public
    function id: Int64;
    function chat: ItdChat;
  end;

  TtdStickerSet = class(TBaseJson, ItdStickerSet)
  public
    function Name: string;
    function Title: string;
    function StickerType: TtdStickerType;
    function ContainsMasks: Boolean;
    function Stickers: TArray<ItdSticker>;
    function Thumbnail: ItdPhotoSize;
  end;
  TtdVideo = class(TtdFile, ItdVideo)
  public
    function Width: Int64;
    function Height: Int64;
    function Duration: Int64;
    function Thumbnail: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  TtdVideoNote = class(TtdFile, ItdVideoNote)
  public
    function FileId: string;
    function Length: Int64;
    function Duration: Int64;
    function Thumbnail: ItdPhotoSize;
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
    FPhoneNumber: string;
    FLastName: string;
    FUserId: Int64;
    FVCard: string;
    FFirstName: string;
    function getPhoneNumber: string;
    function getFirstName: string;
    function getLastName: string;
    function getUserId: Int64;
    function getVCard: string;
  public
    constructor Create(const ANumeroTelelefone, APrimeiroNome, UltimoNome, AVCard: String; AUserId: Int64); reintroduce; overload;
    constructor Create(const AJson: string); overload; override;
  published
    property PhoneNumber: string read FPhoneNumber write FPhoneNumber;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property UserId: Int64 read FUserId write FUserId;
    property VCard: string read FVCard write FVCard;
  end;
  TtdPollOption = class(TBaseJson, ItdPollOption)
  public
    function text : String;
    function text_entities: TArray<ItdMEssageEntity>;
    function voter_count: String;
  end;
  TtdInputPollOption = class(TBaseJson, ItdInputPollOption)
  public
    function text : String;
    function text_parse_mode: String;
    function text_entities: TArray<ItdMEssageEntity>;
  end;
  TtdPollAnswer = class(TBaseJson, ItdPollAnswer)
    function poll_id: String;
    function voter_chat: ItdChat;
    function user: ItdUser;
    function option_ids: TArray<Integer>;
  end;
  TtdPoll = class(TBaseJson, ItdPoll)
    function Id : String;
    function Question: String;
    function QuestionEntities: TArray<ItdMessageEntity>;
    function options: TArray<ItdPollOption>;
    function total_voter_count: Integer;
    function is_closed: Boolean;
    function is_anonymous: Boolean;
    function &type: String;
    function allows_multiple_answers: Boolean;
    function correct_option_id: Integer;
    function explanation: string;
    function explanation_entities: TArray<ItdMessageEntity>;
    function open_period: Integer;
    function close_date: TDateTime;
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
    function Thumbnail: ItdPhotoSize;
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
    function creates_join_request: Boolean;
    function is_primary:	Boolean;
    function is_revoked:	Boolean;
    function name: String;
    function expire_date:	{Integer}TDateTime;
    function member_limit:	Integer;
    function pending_join_request_count: Integer;
  End;
  /// <summary>
  /// Represents a join request sent to a chat..<br/>
  /// </summary>
  /// <param name="chat">
  /// Chat to which the request was sent.<br/>
  /// </param>
  /// <param name="from">
  /// User that sent the join request.<br/>
  /// </param>
  /// <param name="user_chat_id">
  /// Identifier of a private chat with the user who sent the join request.
  /// This number may have more than 32 significant bits and some programming
  /// languages may have difficulty/silent defects in interpreting it. But it
  /// has at most 52 significant bits, so a 64-bit integer or double-precision
  /// float type are safe for storing this identifier. The bot can use this
  /// identifier for 24 hours to send messages until the join request is processed,
  /// assuming no other administrator contacted the user.<br/>
  /// </param>
  /// <param name="date">
  /// Date the request was sent in Unix time.<br/>
  /// </param>
  /// <param name="bio">
  /// Optional. Bio of the user..<br/>
  /// </param>
  /// <param name="invite_link">
  /// Optional. Chat invite link that was used by the user to send the join request.<br/>
  /// </param>
  TtdChatJoinRequest = class(TBaseJson, ItdChatJoinRequest) //New in API 5.4
    ['{1C15162D-4CB0-4F06-A1ED-A5987EF9C85A}']
    function chat:	ItdChat;
    function from:	ItdUser;
    function user_chat_id: Integer;
    function date:	TDateTime; {Integer Unix Time}
    function bio:	String;
    function invite_link:	ItdChatInviteLink;
  end;
  TtdVideoChatScheduled = class(TBaseJson, ItdVideoChatScheduled) //New in API 5.2
  public
    function start_date:	TDateTime; //Point in time (Unix timestamp) when the voice chat is supposed to be started by a chat administrator
  End;
  TtdVideoChatStarted = class(TBaseJson, ItdVideoChatStarted); //New in API 5.1
  TtdVideoChatEnded = class(TBaseJson, ItdVideoChatEnded) //New in API 5.1
  public
    function duration:	Integer;
  End;
  TtdVideoChatParticipantsInvited = class(TBaseJson, ItdVideoChatParticipantsInvited) //New in API 5.1
  public
    function Users:	TArray<ItdUser>;
  End;
  TtdMessageAutoDeleteTimerChanged = class(TBaseJson, ItdMessageAutoDeleteTimerChanged) //New in API 5.1
  public
    function message_auto_delete_time: TDateTime;
  End;

  TtdWriteAccessAllowed = class(TBaseJson, ItdWriteAccessAllowed)
  public
    function web_app_name: string;
  end;

  TtdForumTopic = class(TBaseJson, ItdForumTopic)
    function message_thread_id: int64;
    function name: string;
    function icon_color: integer;
    function icon_custom_emoji_id: string;
  end;

  TtdForumTopicCreated = class(TBaseJson, ItdForumTopicCreated)
    function name: string;
    function icon_color: integer;
    function icon_custom_emoji_id: string;
  end;

  TtdForumTopicClosed = class(TBaseJson, ItdForumTopicClosed)
  end;

  TtdForumTopicEdited = class(TBaseJson, ItdForumTopicEdited)
    function name: string;
    function icon_custom_emoji_id: string;
  end;

  TtdForumTopicReopened = class(TBaseJson, ItdForumTopicReopened)
  end;

  TtdGeneralForumTopicHidden = class(TBaseJson, ItdGeneralForumTopicHidden)
  end;

  TtdGeneralForumTopicUnhidden = class(TBaseJson, ItdGeneralForumTopicUnhidden)
  end;

  TtdGiveaway = class(TBaseJson, ItdGiveaway)
  public
    function chats: TArray<ItdChat>;
    function winners_selection_date: TDateTime;
    function winner_count: Integer;
    function only_new_members: Boolean;
    function has_public_winners: Boolean;
    function prize_description: String;
    function country_codes: TArray<String>;
    function premium_subscription_month_count: Integer;
  End;
  TtdGiveawayWinners = class(TBaseJson, ItdGiveawayWinners)
  public
    function chat: ItdChat;
    function giveaway_message_id: Int64;
    function winners_selection_date: TDateTime;
    function winner_count: Integer;
    function winners: TArray<ItdUser>;
    function additional_chat_count: Integer;
    function premium_subscription_month_count: Integer;
    function unclaimed_prize_count: Integer;
    function only_new_members: Boolean;
    function was_refunded: Boolean;
    function prize_description: String;
  End;
  TtdGiveawayCompleted = class(TBaseJson, ItdGiveawayCompleted)
  public
    function winner_count: Integer;
    function unclaimed_prize_count: Integer;
    function giveaway_message: ItdMessage;
  End;

  TtdGiveawayCreated = class(TBaseJson, ItdGiveawayCreated);

  TtdLinkPreviewOptions = class(TBaseJson, ItdLinkPreviewOptions)
  private
    Fprefer_large_media: Boolean;
    Fis_disabled: Boolean;
    Fprefer_small_media: Boolean;
    Fshow_above_text: Boolean;
    Furl: String;
  public
    function getis_disabled: Boolean;
    function geturl: String;
    function getprefer_small_media: Boolean;
    function getprefer_large_media: Boolean;
    function getshow_above_text: Boolean;

    property is_disabled: Boolean read Fis_disabled write Fis_disabled;
    property url: String read Furl write Furl;
    property prefer_small_media: Boolean read Fprefer_small_media write Fprefer_small_media;
    property prefer_large_media: Boolean read Fprefer_large_media write Fprefer_large_media;
    property show_above_text: Boolean read Fshow_above_text write Fshow_above_text;
    constructor Create(const AJson: string); overload;
    constructor Create(const AIsDisabled: Boolean; FUrl: String; FPreferSmallMedia, FPreferLargeMedia, FShowAboveText: Boolean); overload;
  end;

  TtdExternalReplyInfo = class(TBaseJson, ItdExternalReplyInfo)
  public
    function Origin: ItdMessageOrigin;
    function chat: ItdChat;
    function message_id: Integer;
    function link_preview_options: ItdLinkPreviewOptions;
    function animation: ItdAnimation;
    function audio: ItdAudio;
    function document: ItdDocument;
    function photo: TArray<ItdPhotoSize>;
    function sticker: Itdsticker;
    function story: Itdstory;
    function video: Itdvideo;
    function video_note: ItdVideoNote;
    function voice: ItdVoice;
    function has_media_spoiler: Boolean;
    function contact: Itdcontact;
    function dice: Itddice;
    function game: Itdgame;
    function giveaway: Itdgiveaway;
    function giveaway_winners: ItdGiveawayWinners;
    function invoice: Itdinvoice;
    function location: Itdlocation;
    function poll: Itdpoll;
    function venue: Itdvenue;
  End;
  TtdReplyParameters = class(TBaseJson, ItdReplyParameters)
  private
    Fquote: String;
    Fallow_sending_without_reply: Boolean;
    Fmessage_id: Integer;
    Fquote_entities: TArray<ItdMessageEntity>;
    Fchat_id: string;
    Fquote_parse_mode: String;
    Fquote_position: Integer;
  public
    function getmessage_id: Integer;
    function getchat_id: string;
    function getallow_sending_without_reply: Boolean;
    function getquote: String;
    function getquote_parse_mode: String;
    function getquote_entities: TArray<ItdMessageEntity>;
    function getquote_position: Integer;

    property message_id: Integer read Fmessage_id write Fmessage_id;
    property chat_id: string read Fchat_id write Fchat_id;
    property allow_sending_without_reply: Boolean read Fallow_sending_without_reply write Fallow_sending_without_reply;
    property quote: String read Fquote write Fquote;
    property quote_parse_mode: String read Fquote_parse_mode write Fquote_parse_mode;
    property quote_entities: TArray<ItdMessageEntity> read Fquote_entities write Fquote_entities;
    property quote_position: Integer read Fquote_position write Fquote_position;
    constructor Create(const AJson: String); overload; override;
    constructor Create; overload;
  End;

  TtdTextQuote = class(TBaseJson, ItdTextQuote)
  public
    function Text: string;
    function Entity: TArray<TtdMessageEntity>;
    function position: Integer;
    function is_manual: Boolean;
  end;

  TtdMessage = class(TBaseJson, ItdMessage)
  public
    function MessageId: Int64;
    function MessageThreadId: Int64;
    function From: ItdUser;
    function SenderChat: ItdChat;
    function SenderBoostCount: Integer;
    function SenderBusinessBot: ItdUser;
    function Date: TDateTime;
    function BusinessConnectionId: string;
    function Chat: ItdChat;
    function ForwardOrigin: ItdMessageOrigin; //
    function IsTopicMessage : Boolean;
    function IsAutomaticForward: boolean;
    function ReplyToMessage: ItdMessage;
    function ExternalReply: ItdExternalReplyInfo;
    function Quote: ItdTextQuote;
    function ReplyToStory: ItdStory;
    function ViaBot : ItdUser;
    function EditDate: TDateTime;
    function HasProtectedContent: boolean;
    function IsFromOffline: boolean;
    function MediaGroupId: string;
    function AuthorSignature: string;
    function Text: string;
    function Entities: TArray<ItdMessageEntity>;
    function LinkPreviewOptions: ItdLinkPreviewOptions;
    function Animation : ItdAnimation;
    function Audio: ItdAudio;
    function Document: ItdDocument;
    function Photo: TArray<ItdPhotoSize>;
    function Sticker: ItdSticker;
    function Story: ItdStory;
    function Video: ItdVideo;
    function VideoNote: ItdVideoNote;
    function Voice: ItdVoice;
    function Caption: string;
    function CaptionEntities: TArray<ItdMessageEntity>;
    function HasMediaSpoiler: Boolean;
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
    function PinnedMessage: ItdMaybeInaccessibleMessage_;
    function Invoice: ItdInvoice;
    function SuccessfulPayment: ItdSuccessfulPayment;
    function UsersShared: ItdUsersShared;
    function ChatShared: ItdChatShared;
    function ConnectedWebsite: string;
    function WriteAccessAllowed: ItdWriteAccessAllowed;
    function PassportData: ItdPassportData;
    function ProximityAlertTriggered: ItdProximityAlertTriggered;
    function BoostAdded: ItdChatBoostAdded;
    function ChatBackgroundSet: ItdChatBackground;
    function ForumTopicCreated: ItdForumTopicCreated;
    function ForumTopicClosed: ItdForumTopicClosed;
    function ForumTopicEdited: ItdForumTopicEdited;
    function ForumTopicReopened: ItdForumTopicReopened;
    function GeneralForumTopicHidden: ItdGeneralForumTopicHidden;
    function GeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden;
    function GiveawayCreated: ItdGiveawayCreated;
    function Giveaway: ItdGiveaway;
    function GiveawayWinners: ItdGiveawayWinners;
    function GiveawayCompleted: ItdGiveawayCompleted;
    function VideoChatScheduled: ItdVideoChatScheduled;
    function VideoChatStarted: ItdVideoChatStarted;
    function VideoChatEnded: ItdVideoChatEnded;
    function VideoChatParticipantsInvited: ItdVideoChatParticipantsInvited;
    function WebAppData: ItdWebAppData;
    function ReplyMarkup : IReplyMarkup;
    function NewChatMember: ItdUser;
    function &Type: TtdMessageType;
    function IsCommand(const AValue: string): Boolean;
  end;
  TtdMessageID = class(TBaseJson, ItdMessageID)
    function MessageId: Int64;
  end;
  TtdMessageOrigin = class(TBaseJson, ItdMessageOrigin)
  public
    function type_ : String;
    function date: TDateTime;
  End;
  TtdMessageOriginUser = class(TBaseJson, ItdMessageOrigin)
  public
    function sender_user: TtdUser;
  end;
  TtdMessageOriginHiddenUser = class(TBaseJson, ItdMessageOrigin)
  public
    function sender_user_name: String;
  end;
  TtdMessageOriginChat = class(TBaseJson, ItdMessageOrigin)
  public
    function sender_chat: TtdChat;
    function author_signature: String;
  end;
  TtdMessageOriginChannel = class(TBaseJson, ItdMessageOrigin)
  public
    function chat: TtdChat;
    function message_id: Integer;
    function author_signature: String;
  end;
  TtdUserProfilePhotos = class(TBaseJson, ItdUserProfilePhotos)
  public
    function TotalCount: Int64;
    function Photos: TArray<TArray<ItdPhotoSize>>;
  end;
  TtdCallbackGame = class
  end;

  TtdChatBoostSource = class(TBaseJson, ItdChatBoostSource)
  public
    function source: string;
    function user: TtdUser;
  end;

  TtdChatBoostSourcePremium = class(TtdChatBoostSource);

  TtdChatBoostSourceGiftCode = class(TtdChatBoostSource);

  TtdChatBoostSourceGiveaway = class(TtdChatBoostSource)
  public
    function giveaway_message_id: integer;
    function is_unclaimed: boolean;
  end;

  TtdChatBoost = class(TBaseJson, ItdChatBoost)
  public
    function boost_id: integer;
    function add_date: TDateTime;
    function expiration_date: TDateTime;
    function source: ItdChatBoostSource;
  End;

  TtdChatBoostUpdated = class(TBaseJson, ItdChatBoostUpdated)
  public
    function chat: ItdChat;
    function boost: ItdChatBoost;
  End;

  TtdChatBoostRemoved = class(TBaseJson, ItdChatBoostRemoved)
  public
    function chat: ItdChat;
    function boost_id: integer;
    function remove_date: TDateTime;
    function source: ItdChatBoostSource;
  End;

  TtdUserChatBoosts = class(TBaseJson, ItdUserChatBoosts)
  public
    function boosts: Tarray<ItdChatBoost>;
  End;

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
  TtdSwitchInlineQueryChosenChat = class(TBaseJson, ItdSwitchInlineQueryChosenChat)
  public
    function query: string;
    function allow_user_chats: Boolean;
    function allow_bot_chats: Boolean;
    function allow_group_chats: Boolean;
    function allow_channel_chats: Boolean;
  end;

  TtdInaccessibleMessage = class(TBaseJson, ItdMaybeInaccessibleMessage_)
  public
    function chat: ItdChat;
    function message_id: Integer;
    function date: TDateTime;
  End;

  TtdMaybeInaccessibleMessage = class(TBaseJson, ItdMaybeInaccessibleMessage)
  public
    function Message_ : ItdMessage;
    function InaccessibleMessage: TtdInaccessibleMessage;
  End;

  TtdCallbackQuery = class(TBaseJson, ItdCallbackQuery)
  public
    function ID: string;
    function From: ItdUser;
    function Message_: ItdMaybeInaccessibleMessage_;
    function ChatInstance: string; //
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

  TtdBusinessConnection = class(TBaseJson, ItdBusinessConnection)
  public
    function id: string;
    function user: Itduser;
    function user_chat_id: Int64;
    function date: TDateTime;
    function can_reply: Boolean;
    function is_enabled: Boolean;
  end;

  TtdBusinessMessagesDeleted = class(TBaseJson, ItdBusinessMessagesDeleted)
  public
    function business_connection_id: string;
    function chat: ItdChat;
    function message_ids: TArray<Integer>;
  end;


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
    function BusinessConnection: ItdBusinessConnection;
    function BusinessMessage: ItdMessage;
    function EditedBusinessMessage: ItdMessage;
    function DeletedBusinessMessages: ItdBusinessMessagesDeleted;
    function MessageReaction: ItdReaction;
    function MessageReactionCount: ItdReactionCount;
    function ShippingQuery: ItdShippingQuery;
    function PreCheckoutQuery: ItdPreCheckoutQuery;
    function PollState: ItdPoll;
    function PollAnswer: ItdPollAnswer;
    function MyChatMember: ItdChatMemberUpdated;
    function ChatMember: ItdChatMemberUpdated;
    function ChatJoinRequest: ItdChatJoinRequest;
    function ChatBoost: ItdChatBoostUpdated;
    function ChatBoostRemoved: ItdChatBoostRemoved;
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
    function last_synchronization_error_date: TDateTime;
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
    property sUrl: String read FURL write FURL;
    property sForwardText: String read FForwardText write FForwardText;
    property sBotUserName: String read FBotUserName write FBotUserName;
    property sRequestWriteAccess: Boolean read FRequestWriteAccess write FRequestWriteAccess;
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
  TtdWebAppInfo = class(TBaseJson, ItdWebAppInfo)
  private
    [JsonName('url')]
    Furl: string;
  public
    function url: String;
  published
    constructor Create(const Aurl: string); reintroduce; overload;
    property surl:   string        read Furl    write Furl;
  end;
  TtdWebAppData = class(TBaseJson, ItdWebAppData)
  public
    function data: String;
    function button_text: String;
  end;
  TtdSentWebAppMessage = class(TBaseJson, ItdSentWebAppMessage)
  public
    function inline_message_id: String;
  End;

  TtdMenuButton = class(TBaseJson, ItdMenuButton)
  private
    FMenuButtonType: TtdMenuButtonType;
    procedure SetMenuButtonType(const Value: TtdMenuButtonType);
  published
    constructor Create(const AMenuButtonType: TtdMenuButtonType = TtdMenuButtonType.MenuButtonDefault); reintroduce; overload;
    property MenuButtonType: TtdMenuButtonType read FMenuButtonType write SetMenuButtonType;
  End;
  TtdMenuButtonCommands = class(TBaseJson, ItdMenuButton)
  private
    Ftype_: string;
  public
    [JSONName('type')]
    function &type: String;
  published
    constructor Create(const AMenuButtonType: TtdMenuButtonType = TtdMenuButtonType.MenuButtonDefault); reintroduce; overload;
    property stype_:   string        read &type    write Ftype_;
  End;
  TtdMenuButtonWebApp = class(TBaseJson, ItdMenuButton)
  private
    Ftype: String;
    Ftext: string;
    Fweb_app: ItdWebAppInfo;
  public
    function &type: String;
    function text: String;
    function web_app: ItdWebAppInfo;
  published
    constructor Create(const AMenuButtonType: TtdMenuButtonType = TtdMenuButtonType.MenuButtonDefault; AText: String = ''; AWebApp: ItdWebAppInfo = nil); reintroduce; overload;
    [JSONName('type')]
    property stype:   String     read Ftype    write Ftype;
    [JSONName('text')]
    property stext:    string        read Ftext     write Ftext;
    [JSONName('web_app')]
    property sweb_app: ItdWebAppInfo read Fweb_app  write Fweb_app;
  End;
  TtdMenuButtonDefault = class(TBaseJson, ItdMenuButton)
  private
    Ftype_: string;
  public
    function &type: String;
  published
    constructor Create(const AMenuButtonType: TtdMenuButtonType = TtdMenuButtonType.MenuButtonDefault); reintroduce; overload;
    property stype_:   string        read &type    write Ftype_;
  End;
  TtdChatAdministratorRights = class(TBaseJson, ItdChatAdministratorRights)
  private
    FCanChangeInfo: Boolean;
    FCanPromoteMembers: Boolean;
    FCanManageChat: Boolean;
    FCanManageVideoChats: Boolean;
    FCanPostMessages: Boolean;
    FCanRestrictMembers: Boolean;
    FIsAnonymous: Boolean;
    FCanDeleteMessages: Boolean;
    FCanEditMessages: Boolean;
    FCanPinMessages: Boolean;
    FCanInviteUsers: Boolean;
    FCanDeleteStories: Boolean;
    FCanEditStories: Boolean;
    FCanManageTopics: Boolean;
    FCanPostStories: Boolean;
  public
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
    function can_post_stories: Boolean;
    function can_edit_stories: Boolean;
    function can_delete_stories: Boolean;
    function can_manage_topics: Boolean;
  published
    constructor Create; reintroduce; overload;
    function ToJsonObject: string;
    property IsAnonymous: Boolean read FIsAnonymous write FIsAnonymous;
    property CanManageChat: Boolean read FCanManageChat write FCanManageChat;
    property CanDeleteMessages: Boolean read FCanDeleteMessages write FCanDeleteMessages;
    property CanManageVideoChats: Boolean read FCanManageVideoChats write FCanManageVideoChats;
    property CanRestrictMembers: Boolean read FCanRestrictMembers write FCanRestrictMembers;
    property CanPromoteMembers: Boolean read FCanPromoteMembers write FCanPromoteMembers;
    property CanChangeInfo: Boolean read FCanChangeInfo write FCanChangeInfo;
    property CanInviteUsers: Boolean read FCanInviteUsers write FCanInviteUsers;
    property CanPostMessages: Boolean read FCanPostMessages write FCanPostMessages;
    property CanEditMessages: Boolean read FCanEditMessages write FCanEditMessages;
    property CanPinMessages: Boolean read FCanPinMessages write FCanPinMessages;
    property CanPostStories: Boolean read FCanPostStories write FCanPostStories;
    property CanEditStories: Boolean read FCanEditStories write FCanEditStories;
    property CanDeleteStories: Boolean read FCanDeleteStories write FCanDeleteStories;
    property CanManageTopics: Boolean read FCanManageTopics write FCanManageTopics;
  End;

  TtdThemeParams = class(TBaseJson, ItdThemeParams)
  private
    Fhint_color: TColor;
    Fbutton_color: TColor;
    Flink_color: TColor;
    Fbutton_text_color: TColor;
    Fbg_color: TColor;
    Ftext_color: TColor;
    Fsecondary_bg_color: TColor;
  public
    function Getbg_color: TColor;
    function Gettext_color: TColor;
    function Gethint_color: TColor;
    function Getlink_color: TColor;
    function Getbutton_color: TColor;
    function Getbutton_text_color: TColor;
    function Getsecondary_bg_color: TColor;
  published
    [JSONName('bg_color')]
    property bg_color: TColor read Getbg_color write Fbg_color;
    [JSONName('text_color')]
    property text_color: TColor read Gettext_color write Ftext_color;
    [JSONName('hint_color')]
    property hint_color: TColor read Gethint_color write Fhint_color;
    [JSONName('link_color')]
    property link_color: TColor read Getlink_color write Flink_color;
    [JSONName('button_color')]
    property button_color: TColor read Getbutton_color write Fbutton_color;
    [JSONName('button_text_color')]
    property button_text_color: TColor read Getbutton_text_color write Fbutton_text_color;
    [JSONName('secondary_bg_color')]
    property secondary_bg_color: TColor read Getsecondary_bg_color write Fsecondary_bg_color;
  End;

  TtdMainButton = class(TBaseJson, ItdMainButton)
  public
//    function text_:	String;
//    function color:	String;
//    function textColor:	String;
//    function isVisible:	Boolean;
//    function isActive:	Boolean;
//    function isProgressVisible:	Boolean;
  End;

  TtdBotName = class(TBaseJson, ItdBotName)
  public
    function name: string;
  end;

  [JsonName('BotCommandScope')]
  TtdBotCommandScope = class(TBaseJson, ItdBotCommandScope)
  end;

  [JsonName('BotCommandScopeDefault')]
  TtdBotCommandScopeDefault = class(TtdBotCommandScope)
  private
    Ftype_p: string;
  public
    [JsonName('type')]
    function type_: string;

    property type_p: string read Ftype_p write Ftype_p;
  published
    constructor Create(const AType: TtdBotCommandScopeType); reintroduce; overload;
    function ToJsonObject: string;
  end;

  [JsonName('BotCommandScopeAllPrivateChats')]
  TtdBotCommandScopeAllPrivateChats = class(TtdBotCommandScopeDefault);
  [JsonName('BotCommandScopeAllGroupChats')]
  TtdBotCommandScopeAllGroupChats = class(TtdBotCommandScopeDefault);
  [JsonName('BotCommandScopeAllChatAdministrators')]
  TtdBotCommandScopeAllChatAdministrators = class(TtdBotCommandScopeDefault);
  [JsonName('BotCommandScopeChat')]
  TtdBotCommandScopeChat = class(TtdBotCommandScopeDefault)
  public
    function chat_id: string;
  end;
  [JsonName('BotCommandScopeChatAdministrators')]
  TtdBotCommandScopeChatAdministrators = class(TtdBotCommandScopeChat);
  [JsonName('BotCommandScopeChatMember')]
  TtdBotCommandScopeChatMember = class(TtdBotCommandScopeChat)
  public
    function user_id: integer;
  end;

  TtdBotDescription = class(TBaseJson, ItdBotDescription)
  public
    function description: string;
  end;

  TtdBotShortDescription = class(TBaseJson, ItdBotShortDescription)
  public
    function short_description: string;
  end;

  TtdReactionTypeEmoji = class(TBaseJson, ItdReactionType)
  public
    function type_ : string;
    function emoji : string;
  end;

  TtdReactionTypeCustomEmoji = class(TBaseJson, ItdReactionType)
  public
    function type_ : string;
    function custom_emoji_id : string;
  end;

  TtdReaction= class(TBaseJson, ItdReaction);

  TtdReactionType = class(TBaseJson, ItdReactionType)
  public
    function ReactionTypeEmoji : TtdReactionTypeEmoji;
    function ReactionTypeCustomEmoji : TtdReactionTypeCustomEmoji;
  end;

  TtdReactionCount = class(TBaseJson, ItdReactionCount)
  public
    function ReactionType : ItdReactionType;
    function total_count : Integer;
  end;

  TtdMessageReactionUpdated = class(TBaseJson, ItdReaction)
  public
    function chat         : TtdChat;
    function message_id   : int64;
    function user         : TtdUser;
    function actor_chat   : TtdChat;
    function date         : TDateTime;
    function old_reaction : TArray<ItdReactionType>;
    function new_reaction : TArray<ItdReactionType>;
  end;

  TtdMessageReactionCountUpdated = class(TBaseJson, ItdReactionCount)
  public
    function chat         : TtdChat;
    function message_id   : int64;
    function date         : TDateTime;
    function reaction     : TArray<TtdReactionCount>;
  end;

  TtdChatBoostAdded = class(TBaseJson, ItdChatBoostAdded)
  public
    function boost_count: Integer;
  end;

  TtdBackgroundFill = class(TBaseJson, ItdBackgroundFill);

  TtdBackgroundFillSolid = class(TBaseJson, ItdBackgroundFillSolid)
  public
    function type_: string;
    function color: Integer;
  end;

  TtdBackgroundFillGradient = class(TBaseJson, ItdBackgroundFillGradient)   //Type of the background fill, always “gradient”
  public
    function type_: string;
    function top_color: Integer;       //Top color of the gradient in the RGB24 format
    function bottom_color: Integer;    //Bottom color of the gradient in the RGB24 format
    function rotation_angle: Integer;  //Clockwise rotation angle of the background fill in degrees; 0-359
  end;

  TtdBackgroundFillFreeformGradient = class(TBaseJson, ItdBackgroundFillFreeformGradient)
  public
    function type_: string;
    function colors: TArray<integer>;  //A list of the 3 or 4 base colors that are used to generate the freeform gradient in the RGB24 format
  end;

  TtdBackgroundType = class(TBaseJson, ItdBackgroundType);

  TtdBackgroundTypeFill = class(TBaseJson, ItdBackgroundTypeFill)  //	Type of the background, always “fill”
  public
    function type_: string;
    function fill: ItdBackgroundFill;      //The background fill
    function dark_theme_dimming: Integer;  //Dimming of the background in dark themes, as a percentage; 0-100
  end;

  TtdBackgroundTypeWallpaper = class(TBaseJson, ItdBackgroundTypeWallpaper)
  public
    function type_: string;
    function document: ItdDocument;
    function dark_theme_dimming: Integer;  //Dimming of the background in dark themes, as a percentage; 0-100
    function is_blurred: Boolean;          //Optional. True, if the wallpaper is downscaled to fit in a 450x450 square and then box-blurred with radius 12
    function is_moving: Boolean;           //Optional. True, if the background moves slightly when the device is tilted
  end;

  TtdBackgroundTypePattern = class(TBaseJson, ItdBackgroundTypePattern)
  public
    function type_: string;
    function document: ItdDocument;
    function fill: ItdBackgroundFill;      //The background fill
    function intensity: Integer;
    function is_inverted: Boolean;
    function is_moving: Boolean;
  end;

  TtdBackgroundTypeChatTheme = class(TBaseJson, ItdBackgroundTypeChatTheme) //Type of the background, always “chat_theme”
  public
    function type_: string;
    function theme_name: string; //Name of the chat theme, which is usually an emoji
  end;

  TtdChatBackground = class(TBaseJson, ItdChatBackground)
  public
    function type_: ItdBackgroundType;
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
function TtdAnimation.Thumbnail: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
{ TtdCallbackQuery }
function TtdCallbackQuery.ChatInstance: string;
begin
  Result := ReadToSimpleType<string>('chat_instance');
end;

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
function TtdCallbackQuery.Message_: ItdMaybeInaccessibleMessage_;
var
  FOUT : TtdMaybeInaccessibleMessage;
begin
  FOUT := ReadToClass<TtdMaybeInaccessibleMessage>('message');

  if Assigned((FOUT.Message_)as TtdMessage) then
    Result := FOUT.Message_
  else if Assigned((FOUT.InaccessibleMessage) as TtdInaccessibleMessage) then
    Result := FOUT.InaccessibleMessage;
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
function TtdDocument.Thumbnail: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumbnail');
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
function TtdMessage.ForumTopicClosed: ItdForumTopicClosed;
begin
  Result := ReadToClass<TtdForumTopicClosed>('forum_topic_closed');
end;

function TtdMessage.ForumTopicCreated: ItdForumTopicCreated;
begin
  Result := ReadToClass<TtdForumTopicCreated>('forum_topic_created');
end;

function TtdMessage.ForumTopicEdited: ItdForumTopicEdited;
begin
  Result := ReadToClass<TtdForumTopicEdited>('forum_topic_edited');
end;

function TtdMessage.ForumTopicReopened: ItdForumTopicReopened;
begin
  Result := ReadToClass<TtdForumTopicReopened>('forum_topic_reopened');
end;

function TtdMessage.ForwardOrigin: ItdMessageOrigin;
begin
  Result := ReadToClass<TtdMessageOrigin>('forward_origin');
end;

function TtdMessage.GeneralForumTopicHidden: ItdGeneralForumTopicHidden;
begin
  Result := ReadToClass<TtdGeneralForumTopicHidden>('general_forum_topic_hidden');
end;

function TtdMessage.GeneralForumTopicUnhidden: ItdGeneralForumTopicUnhidden;
begin
  Result := ReadToClass<TtdGeneralForumTopicUnhidden>('general_forum_topic_unhidden');
end;

function TtdMessage.Giveaway: ItdGiveaway;
begin
  Result := ReadToClass<TtdGiveaway>('giveaway');
end;

function TtdMessage.GiveawayCompleted: ItdGiveawayCompleted;
begin
  Result := ReadToClass<TtdGiveawayCompleted>('giveaway_completed');
end;

function TtdMessage.GiveawayCreated: ItdGiveawayCreated;
begin
  Result := ReadToClass<TtdGiveawayCreated>('giveaway_created');
end;

function TtdMessage.GiveawayWinners: ItdGiveawayWinners;
begin
  Result := ReadToClass<TtdGiveawayWinners>('giveaway_winners');
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
function TtdMessage.HasMediaSpoiler: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_media_spoiler');
end;

function TtdMessage.HasProtectedContent: boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_protected_content');
end;

function TtdMessage.Invoice: ItdInvoice;
begin
  Result := ReadToClass<TtdInvoice>('invoice');
end;
function TtdMessage.IsAutomaticForward: boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_automatic_forward');
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
function TtdMessage.IsFromOffline: boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_from_offline');
end;

function TtdMessage.IsTopicMessage: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_topic_message');
end;

function TtdMessage.LeftChatMember: ItdUser;
begin
  Result := ReadToClass<TtdUser>('left_chat_member');
end;
function TtdMessage.LinkPreviewOptions: ItdLinkPreviewOptions;
begin
  Result := ReadToClass<TtdLinkPreviewOptions>('link_preview_options');
end;

function TtdMessage.Location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;
function TtdMessage.MediaGroupId: string;
begin
  Result := ReadToSimpleType<string>('media_group_id');
end;

function TtdMessage.MessageAutoDeleteTimerChanged: ItdMessageAutoDeleteTimerChanged;
begin
  Result := ReadToClass<TtdMessageAutoDeleteTimerChanged>('message_auto_delete_timer_changed');
end;
function TtdMessage.MessageId: Int64;
begin
  Result := ReadToSimpleType<Int64>('message_id');
end;
function TtdMessage.MessageThreadId: Int64;
begin
  Result := ReadToSimpleType<Int64>('message_thread_id');
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

function TtdMessage.ExternalReply: ItdExternalReplyInfo;
begin
  Result := ReadToClass<TtdExternalReplyInfo>('external_reply');
end;

function TtdMessage.PassportData: ItdPassportData;
begin
  Result := ReadToClass<TtdPassportData>('passport_data');
end;
function TtdMessage.Photo: TArray<ItdPhotoSize>;
begin
  Result := ReadToInterfaceArray<ItdPhotoSize>(TtdPhotoSize, 'photo');
end;
function TtdMessage.PinnedMessage: ItdMaybeInaccessibleMessage_;
var
  FOUT : TtdMaybeInaccessibleMessage;
begin
  FOUT := ReadToClass<TtdMaybeInaccessibleMessage>('pinned_message');

  if Assigned((FOUT.Message_) as TtdMessage) then
    Result := FOUT.Message_
  else if Assigned((FOUT.InaccessibleMessage) as TtdInaccessibleMessage) then
    Result := FOUT.InaccessibleMessage;
end;
function TtdMessage.Poll: ItdPoll;
begin
  Result := ReadToClass<TtdPoll>('poll');
end;
function TtdMessage.ProximityAlertTriggered: ItdProximityAlertTriggered;
begin
  Result := ReadToClass<TtdProximityAlertTriggered>('proximity_alert_triggered');
end;

function TtdMessage.Quote: ItdTextQuote;
begin
  Result := ReadToClass<TtdTextQuote>('quote');
end;

function TtdMessage.ReplyMarkup: IReplyMarkup;
begin
  Result := ReadToClass<TtdInlineKeyboardMarkup>('reply_markup');
end;
function TtdMessage.ReplyToMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('reply_to_message');
end;

function TtdMessage.ReplyToStory: ItdStory;
begin
  Result := ReadToClass<TtdStory>('reply_to_story');
end;

function TtdMessage.SenderBoostCount: Integer;
begin
 Result := ReadToSimpleType<Integer>('sender_boost_count');
end;

function TtdMessage.SenderBusinessBot: ItdUser;
begin
  Result := ReadToClass<TtdUser>('sender_business_bot');
end;

function TtdMessage.SenderChat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('sender_chat');
end;
function TtdMessage.Sticker: ItdSticker;
begin
  Result := ReadToClass<TtdSticker>('sticker');
end;
function TtdMessage.Story: ItdStory;
begin
  Result := ReadToClass<TtdStory>('story');
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
  if not Text.IsEmpty then
    Exit(TtdMessageType.TextMessage);
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
//  if (NewChatMember <> nil) or (LeftChatMember <> nil) or
// ((NewChatPhoto <> nil) and (Length(NewChatPhoto) > 0)) or
// ((NewChatMembers <> nil) and (Length(NewChatMembers) > 0)) or
// (not NewChatTitle.IsEmpty) or DeleteChatPhoto or GroupChatCreated or
// SupergroupChatCreated or ChannelChatCreated or (MigrateToChatId <> 0) or
// (MigrateFromChatId <> 0) or (PinnedMessage <> nil) then
//    Exit(TtdMessageType.ServiceMessage);
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
  Result := TtdMessageType.UnknownMessage;
end;
function TtdMessage.UsersShared: ItdUsersShared;
begin
  Result := ReadToClass<TtdUsersShared>('users_shared');
end;
function TtdMessage.ChatShared: ItdChatShared;
begin
  Result := ReadToClass<TtdChatShared>('chat_shared');
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
function TtdMessage.BoostAdded: ItdChatBoostAdded;
begin
  Result := ReadToClass<TtdChatBoostAdded>('boost_added');
end;

function TtdMessage.BusinessConnectionId: string;
begin
  Result := ReadToSimpleType<string>('business_connection_id');
end;

function TtdMessage.Caption: string;
begin
  Result := ReadToSimpleType<string>('caption');
end;
function TtdMessage.CaptionEntities: TArray<ItdMessageEntity>;
begin
  Result := ReadToInterfaceArray<ItdMessageEntity>(TtdMessageEntity, 'caption_entities');
end;
function TtdMessage.ChannelChatCreated: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('channel_chat_created');
end;
function TtdMessage.Chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;
function TtdMessage.ChatBackgroundSet: ItdChatBackground;
begin
  Result := ReadToClass<TtdChatBackground>('chat_background_set');
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
function TtdMessage.VideoChatParticipantsInvited: ItdVideoChatParticipantsInvited;
begin
  Result := ReadToClass<TtdVideoChatParticipantsInvited>('video_chat_participants_invited');
end;
function TtdMessage.VideoChatScheduled: ItdVideoChatScheduled;
begin
  Result := ReadToClass<TtdVideoChatScheduled>('video_chat_scheduled');
end;
function TtdMessage.VideoChatStarted: ItdVideoChatStarted;
begin
  Result := ReadToClass<TtdVideoChatStarted>('video_chat_started');
end;
function TtdMessage.WebAppData: ItdWebAppData;
begin
  Result := ReadToClass<TtdWebAppData>('web_app_data');
end;

function TtdMessage.WriteAccessAllowed: ItdWriteAccessAllowed;
begin
    Result := ReadToClass<TtdWriteAccessAllowed>('write_access_allowed');
end;

function TtdMessage.VideoChatEnded: ItdVideoChatEnded;
begin
  Result := ReadToClass<TtdVideoChatEnded>('video_chat_ended');
end;
{ TtdShippingOption }
function TtdShippingOption.ID: string;
begin
  Result := ReadToSimpleType<string>('id');
end;
function TtdShippingOption.Prices: TArray<ItdLabeledPrice>;
begin
  Result := ReadToInterfaceArray<ItdLabeledPrice>(TtdLabeledPrice, 'prices');
end;
function TtdShippingOption.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
{ TtdUpdate }
function TtdUpdate.BusinessConnection: ItdBusinessConnection;
begin
  Result := ReadToClass<TtdBusinessConnection>('business_connection');
end;

function TtdUpdate.BusinessMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('business_message');
end;

function TtdUpdate.CallbackQuery: ItdCallbackQuery;
begin
  Result := ReadToClass<TtdCallbackQuery>('callback_query');
end;
function TtdUpdate.ChannelPost: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('channel_post');
end;
function TtdUpdate.ChatBoost: ItdChatBoostUpdated;
begin
  Result := ReadToClass<TtdChatBoostUpdated>('chat_boost');
end;

function TtdUpdate.ChatBoostRemoved: ItdChatBoostRemoved;
begin
  Result := ReadToClass<TtdChatBoostRemoved>('removed_chat_boost');
end;

function TtdUpdate.ChatJoinRequest: ItdChatJoinRequest;
begin
  Result := ReadToClass<TtdChatJoinRequest>('chat_join_request');
end;
function TtdUpdate.ChatMember: ItdChatMemberUpdated;
begin
  Result := ReadToClass<TtdChatMemberUpdated>('chat_member');
end;
function TtdUpdate.ChosenInlineResult: ItdChosenInlineResult;
begin
  Result := ReadToClass<TtdChosenInlineResult>('chosen_inline_result');
end;
function TtdUpdate.DeletedBusinessMessages: ItdBusinessMessagesDeleted;
begin
  Result := ReadToClass<TtdBusinessMessagesDeleted>('deleted_business_messages');
end;

function TtdUpdate.EditedBusinessMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('edited_business_message');
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
function TtdUpdate.MessageReaction: ItdReaction;
begin
  Result := ReadToClass<TtdReaction>('message_reaction');
end;

function TtdUpdate.MessageReactionCount: ItdReactionCount;
begin
  Result := ReadToClass<TtdReactionCount>('message_reaction_count');
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
  Result := ReadToInterfaceArray<ItdSticker>(TtdSticker, 'stickers');
end;
function TtdStickerSet.StickerType: TtdStickerType;
var
  stickerout: string;
begin
  stickerout := ReadToSimpleType<string>('sticker_type');

  if stickerout = TtdStickerType.regular.ToString then
    Result := TtdStickerType.regular;
  if stickerout = TtdStickerType.mask.ToString then
    Result := TtdStickerType.mask;
  if stickerout = TtdStickerType.custom_emoji.ToString then
    Result := TtdStickerType.custom_emoji;
end;

function TtdStickerSet.Thumbnail: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
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
function TtdUser.AddedToAttachmentMenu: string;
begin
  Result := ReadToSimpleType<string>('added_to_attachment_menu');
end;

function TtdUser.CanConnectToBusiness: Boolean;
begin
  Result := ReadToSimpleType<boolean>('can_connect_to_business');
end;

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
function TtdUser.isPremium: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_premium');
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

{ TtdChatFullInfo }
function TtdChatFullInfo.accent_color_id: integer;
begin
  Result := ReadToSimpleType<integer>('accent_color_id');
end;

function TtdChatFullInfo.active_usernames: Tarray<string>;
var
  LJsonArray: TJSONArray;
  I: Integer;
begin
  LJsonArray := FJSON.GetValue('active_usernames') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := ReadToSimpleType<string>(LJsonArray.Items[I].ToString);
end;

function TtdChatFullInfo.available_reactions: TArray<ItdReactionType>;
var
  LJsonArray: TJSONArray;
  I: Integer;
begin
  LJsonArray := FJSON.GetValue('available_reactions') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := ReadToClass<TtdReactionType>(LJsonArray.Items[I].ToString);
end;

function TtdChatFullInfo.background_custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('background_custom_emoji_id');
end;

function TtdChatFullInfo.Bio: String;
begin
  Result := ReadToSimpleType<String>('bio');
end;
function TtdChatFullInfo.birthdate: ItdBirthdate;
begin
  Result := ReadToClass<TtdBirthdate>('birthdate');
end;

function TtdChatFullInfo.business_intro: ItdBusinessIntro;
begin
  Result := ReadToClass<TtdBusinessIntro>('business_intro');
end;

function TtdChatFullInfo.business_location: ItdBusinessLocation;
begin
  Result := ReadToClass<TtdBusinessLocation>('business_location');
end;

function TtdChatFullInfo.business_opening_hours: ItdBusinessOpeningHours;
begin
  Result := ReadToClass<TtdBusinessOpeningHours>('business_opening_hours');
end;

function TtdChatFullInfo.CanSetStickerSet: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_set_sticker_set');
end;
function TtdChatFullInfo.CustomEmojiStickerSetName: String;
begin
  Result := ReadToSimpleType<string>('custom_emoji_sticker_set_name');
end;

function TtdChatFullInfo.Description: string;
begin
  Result := ReadToSimpleType<string>('description');
end;
function TtdChatFullInfo.emoji_status_custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('emoji_status_custom_emoji_id');
end;

function TtdChatFullInfo.emoji_status_expiration_date: Integer;
begin
  Result := ReadToSimpleType<Integer>('emoji_status_expiration_date');
end;

function TtdChatFullInfo.FirstName: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;
function TtdChatFullInfo.HasPrivateForwards: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_private_forwards');
end;

function TtdChatFullInfo.HasProtectedContent: boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_protected_content');
end;

function TtdChatFullInfo.HasVisibleHistory: boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_visible_history');
end;

function TtdChatFullInfo.has_aggressive_anti_spam_enabled: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_aggressive_anti_spam_enabled');
end;

function TtdChatFullInfo.has_hidden_members: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_hidden_members');
end;

function TtdChatFullInfo.has_restricted_voice_and_video_messages: boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_restricted_voice_and_video_messages');
end;

function TtdChatFullInfo.ID: Int64;
begin
  Result := ReadToSimpleType<Int64>('id');
end;
function TtdChatFullInfo.InviteLink: string;
begin
  Result := ReadToSimpleType<string>('invite_link');
end;
function TtdChatFullInfo.IsGroup: Boolean;
var
  LValue: string;
begin
  LValue := ReadToSimpleType<string>('type');
  result := (LValue = 'group');
end;
function TtdChatFullInfo.is_forum: boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_forum');
end;

function TtdChatFullInfo.JoinByRequest: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('join_by_request');
end;

function TtdChatFullInfo.JoinToSendMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('join_to_send_messages');
end;

function TtdChatFullInfo.LastName: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;
function TtdChatFullInfo.LinkedChatId: Integer;
begin
  Result := ReadToSimpleType<Integer>('linked_chat_id');
end;
function TtdChatFullInfo.location: ItdChatLocation;
begin
  Result := ReadToClass<TtdChatLocation>('location');
end;
function TtdChatFullInfo.max_reaction_count: integer;
begin

end;

function TtdChatFullInfo.MessageAutoDeleteTime: integer;
begin
  Result := ReadToSimpleType<Integer>('message_auto_delete_time');
end;

function TtdChatFullInfo.Permissions: ItdChatPermissions;
begin
  Result := ReadToClass<TtdChatPermissions>('ChatPermissions');
end;
function TtdChatFullInfo.personal_chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('personal_chat');
end;

function TtdChatFullInfo.Photo: ItdChatPhoto;
begin
  Result := ReadToClass<TtdChatPhoto>('photo');
end;
function TtdChatFullInfo.PinnedMessage: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('pinned_message');
end;
function TtdChatFullInfo.profile_accent_color_id: Integer;
begin
  Result := ReadToSimpleType<Integer>('profile_accent_color_id');
end;

function TtdChatFullInfo.profile_background_custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('profile_background_custom_emoji_id');
end;

function TtdChatFullInfo.SlowModeDelay: Integer;
begin
  Result := ReadToSimpleType<Integer>('slow_mode_delay');
end;
function TtdChatFullInfo.StickerSetName: string;
begin
  Result := ReadToSimpleType<string>('sticker_set_name');
end;
function TtdChatFullInfo.Title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;
function TtdChatFullInfo.ToJSonStr: String;
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
function TtdChatFullInfo.ToString: String;
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
function TtdChatFullInfo.TypeChat: TtdChatType;
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
function TtdChatFullInfo.UnrestrictBoostCount: Integer;
begin
  Result := ReadToSimpleType<Integer>('unrestrict_boost_count');
end;

function TtdChatFullInfo.Username: string;
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
function TtdWebhookInfo.last_synchronization_error_date: TDateTime;
begin
  Result := ReadToDateTime('last_synchronization_error_date');
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
function TtdMessageEntity.custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('custom_emoji_id');
end;

function TtdMessageEntity.language: string;
begin
  Result := ReadToSimpleType<string>('language');
end;
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
function TtdAudio.Thumbnail: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumbnail');
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
function TtdSticker.CustomEmojiId: Int64;
begin
  Result := ReadToSimpleType<Int64>('custom_emoji_id');
end;

function TtdSticker.Emoji: string;
begin
  Result := ReadToSimpleType<string>('emoji');
end;
function TtdSticker.Height: Int64;
begin
  Result := ReadToSimpleType<Int64>('height');
end;
function TtdSticker.is_animated: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_animated');
end;

function TtdSticker.is_video: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_video');
end;

function TtdSticker.MaskPosition: ItdMaskPosition;
begin
  Result := ReadToClass<TtdMaskPosition>('mask_position');
end;
function TtdSticker.NeedsRepainting: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('needs_repainting');
end;

function TtdSticker.PremiumAnimation: ItdFile;
begin
  Result := ReadToClass<TtdFile>('premium_animation');
end;

function TtdSticker.SetName: string;
begin
  Result := ReadToSimpleType<string>('set_name');
end;
function TtdSticker.Thumbnail: ItdPhotoSize;
begin
  Result := ReadToClass<TtdPhotoSize>('thumb');
end;
function TtdSticker.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
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
  Result := ReadToInterfaceArray<ItdPhotoSize>(TtdPhotoSize, 'photo');
end;
function TtdGame.Text: string;
begin
  Result := ReadToSimpleType<string>('text');
end;
function TtdGame.TextEntities: TArray<ItdMessageEntity>;
begin
  Result := ReadToInterfaceArray<ItdMessageEntity>(TtdMessageEntity, 'text_entities');
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
function TtdVideo.Thumbnail: ItdPhotoSize;
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
constructor TtdContact.Create(const ANumeroTelelefone, APrimeiroNome, UltimoNome, AVCard: String; AUserId: Int64);
begin
  FPhoneNumber := ANumeroTelelefone;
  FFirstName :=  APrimeiroNome;
  FLastName :=  UltimoNome;
  FVCard := AVCard;
  FUserId := AUserId;

  FJson := '{"phone_number":"'+ANumeroTelelefone+'",'+
           '"first_name":"'+APrimeiroNome+'",'+
           '"last_name":"'+UltimoNome+'",'+
           '"user_id":"'+UltimoNome+'",'+
           '"vacard":"'+AVCard+'"}';

  inherited Create(FJson);
end;
function TtdContact.getFirstName: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;
function TtdContact.getLastName: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;
function TtdContact.getPhoneNumber: string;
begin
  Result := ReadToSimpleType<string>('phone_number');
end;
function TtdContact.getUserId: Int64;
begin
  Result := ReadToSimpleType<Int64>('user_id');
end;
function TtdContact.getVCard: string;
begin
  Result := ReadToSimpleType<string>('vcard');
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
function TtdVideoNote.Thumbnail: ItdPhotoSize;
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
function TtdPollOption.text_entities: TArray<ItdMEssageEntity>;
begin
  Result := ReadToInterfaceArray<ItdMEssageEntity>(TtdMEssageEntity,'text_entities');
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
  Result := ReadToArraySimpleType<integer>('option_ids');
{
  LJsonArray := FJSON.GetValue('option_ids') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := ReadToSimpleType<integer>(LJsonArray.Items[I].ToString);
}
end;
function TtdPollAnswer.poll_id: String;
begin
  Result := ReadToSimpleType<String>('poll_id');
end;
function TtdPollAnswer.user: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;
function TtdPollAnswer.voter_chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('voter_chat');
end;

{ TtdPoll }
function TtdPoll.allows_multiple_answers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allows_multiple_answers');
end;

function TtdPoll.close_date: TDateTime;
begin
  Result := ReadToDateTime('close_date');
end;

function TtdPoll.explanation: string;
begin
  Result := ReadToSimpleType<string>('explanation');
end;

function TtdPoll.explanation_entities: TArray<ItdMessageEntity>;
var
  LJsonArray: TJSONArray;
  I: Integer;
begin
  LJsonArray := FJSON.GetValue('explanation_entities') as TJSONArray;
  if (not Assigned(LJsonArray)) or LJsonArray.Null then
    Exit(nil);
  SetLength(Result, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
    Result[I] := ReadToClass<TtdMessageEntity>(LJsonArray.Items[I].ToString);

end;

function TtdPoll.open_period: Integer;
begin
  Result := ReadToSimpleType<Integer>('open_period');
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
  Result := ReadToInterfaceArray<ItdPollOption>(TtdPollOption, 'options');
end;
function TtdPoll.question: String;
begin
  Result := ReadToSimpleType<String>('question');
end;
function TtdPoll.QuestionEntities: TArray<ItdMessageEntity>;
begin
  Result := ReadToInterfaceArray<ItdMessageEntity>(TtdMessageEntity, 'question_entities');
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
  I, X : Integer;
begin

  for I := 1 to Length(ACommand) do
  Begin
    If ACommand[I] in ['A'..'Z'] then
    Begin
    //if ACommand[I] = CharUpper(ACommand[I]) then
      raise Exception.Create('Error: Uppercase letters Not allowed in the register of commands!');
      Break;
    End;
  End;

  if Length(ACommand) > 32 then
  Begin
      raise Exception.Create('Error: The Command Field is limited to 32 characters!');
    Exit;
  End;

  if Length(ADescription) > 256 then
  Begin
      raise Exception.Create('Error: The Description Field is limited to 256 characters!');
    Exit;
  End;

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
  Result := ReadToInterfaceArray<ItdShippingOption>(TtdShippingOption, 'shipping_options');
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
  Result := ReadToInterfaceArray<ItdPassportFile>(TtdPassportFile, 'files');
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
  Result := ReadToInterfaceArray<ItdPassportFile>(TtdPassportFile, 'translation');
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
  Result := ReadToInterfaceArray<ItdEncryptedPassportElement>(TtdEncryptedPassportElement, 'data');
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
function TtdChatPermissions.CanManageTopics: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_topics');
end;

function TtdChatPermissions.CanPinMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;
function TtdChatPermissions.CanSendAudios: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_audios');
end;

function TtdChatPermissions.CanSendDocuments: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_documents');
end;

function TtdChatPermissions.CanSendMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_messages');
end;
function TtdChatPermissions.CanSendOtherMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_other_messages');
end;
function TtdChatPermissions.CanSendPhotos: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_photos');
end;

function TtdChatPermissions.CanSendPolls: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_polls');
end;
function TtdChatPermissions.CanSendVideoNotes: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_video_notes');
end;

function TtdChatPermissions.CanSendVideos: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_videos');
end;

function TtdChatPermissions.CanSendVoiceNotes: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_voice_notes');
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
function TtdChatInviteLink.creates_join_request: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('creates_join_request');
end;
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
function TtdChatInviteLink.name: String;
begin
  Result := ReadToSimpleType<String>('name');
end;
function TtdChatInviteLink.pending_join_request_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('pending_join_request_count');
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
function TtdChatMemberUpdated.via_chat_folder_invite_link: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('via_chat_folder_invite_link');
end;

function TtdChatMemberUpdated.via_join_request: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('via_join_request');
end;

{ TtdVoiceChatEnded }
function TtdVideoChatEnded.duration: Integer;
begin
  Result := ReadToSimpleType<Integer>('duration');
end;
{ TtdVoiceChatParticipantsInvited }
function TtdVideoChatParticipantsInvited.Users: TArray<ItdUser>;
begin
  Result := ReadToInterfaceArray<ItdUser>(TtdUser, 'users');
end;
{ TtdMessageAutoDeleteTimerChanged }
function TtdMessageAutoDeleteTimerChanged.message_auto_delete_time: TDateTime;
begin
  Result := ReadToDateTime('message_auto_delete_time');
end;
{ TtdVoiceChatScheduled }
function TtdVideoChatScheduled.start_date: TDateTime;
begin
  Result := ReadToDateTime('start_date');
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

function TtdChatMemberAdministrator.CanDeleteStories: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_delete_stories');
end;

function TtdChatMemberAdministrator.CanEditStories: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_edit_stories');
end;

function TtdChatMemberAdministrator.CanPostStories: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_post_stories');
end;

function TtdChatMemberAdministrator.CanManageTopics: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_topics');
end;

function TtdChatMemberAdministrator.CanInviteUsers: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_invite_users');
end;
function TtdChatMemberAdministrator.CanManageChat: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_chat');
end;

function TtdChatMemberAdministrator.CanManageVideoChats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_video_chats ');
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
function TtdChatMemberRestricted.CanManageTopics: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_topics');
end;

function TtdChatMemberRestricted.CanPinMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;
function TtdChatMemberRestricted.CanSendAudios: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_audios');
end;

function TtdChatMemberRestricted.CanSendDocuments: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_documents');
end;

function TtdChatMemberRestricted.CanSendMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_messages');
end;
function TtdChatMemberRestricted.CanSendOtherMessages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_other_messages');
end;
function TtdChatMemberRestricted.CanSendPhotos: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_photos');
end;

function TtdChatMemberRestricted.CanSendPolls: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_polls');
end;
function TtdChatMemberRestricted.CanSendVideoNotes: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_video_notes');
end;

function TtdChatMemberRestricted.CanSendVideos: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_videos');
end;

function TtdChatMemberRestricted.CanSendVoiceNotes: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_send_voice_notes');
end;

function TtdChatMemberRestricted.IsMember: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_member');
end;

function TtdChatMemberRestricted.UntilDate: TDateTime;
begin
  Result := ReadToDateTime('until_date');
end;

{ TtdChatMemberBanned }
function TtdChatMemberBanned.UntilDate: TDateTime;
begin
  Result := ReadToDateTime('until_date');
end;
{ TtdChatJoinRequest }
function TtdChatJoinRequest.bio: String;
begin
  Result := ReadToSimpleType<String>('bio');
end;
function TtdChatJoinRequest.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;
function TtdChatJoinRequest.date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;
function TtdChatJoinRequest.from: ItdUser;
begin
  Result := ReadToClass<TtdUser>('from');
end;
function TtdChatJoinRequest.invite_link: ItdChatInviteLink;
begin
  Result := ReadToClass<TtdChatInviteLink>('invite_link');
end;
function TtdChatJoinRequest.user_chat_id: Integer;
begin
  Result := ReadToSimpleType<Integer>('user_chat_id');
end;

{ TtdMessageID }

function TtdMessageID.MessageId: Int64;
begin
  Result := ReadToSimpleType<Int64>('message_id');
end;

{ TtdWebAppInfo }

constructor TtdWebAppInfo.Create(const Aurl: string);
var
  AJson: String;
begin
  surl := Aurl;
  AJson := '{"url":"'+Aurl+'"}';
  inherited Create(AJson);
end;

function TtdWebAppInfo.url: String;
begin
  Result := ReadToSimpleType<string>('url');
end;

{ TtdSentWebAppMessage }

function TtdSentWebAppMessage.inline_message_id: String;
begin
  Result := ReadToSimpleType<string>('inline_message_id');
end;

{ TtdWebAppData }

function TtdWebAppData.button_text: String;
begin
  Result := ReadToSimpleType<string>('button_text');
end;

function TtdWebAppData.data: String;
begin
  Result := ReadToSimpleType<string>('data');
end;

{ TtdMenuButtonCommands }

constructor TtdMenuButtonCommands.Create(
  const AMenuButtonType: TtdMenuButtonType);
var
  AJson: String;
begin
  AJson := '{"type":"'+AMenuButtonType.ToString+'"}';
  //Ftype_ := AMenuButtonType.ToString;
  inherited Create(AJson);
end;

function TtdMenuButtonCommands.&type: String;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdMenuButtonWebApp }

constructor TtdMenuButtonWebApp.Create(
  const AMenuButtonType: TtdMenuButtonType; AText: String; AWebApp: ItdWebAppInfo);
var
  AJson: String;
begin
  Ftype := AMenuButtonType.ToString;
  Ftext := AText;
  Fweb_app := AWebApp;
  AJson := '{"type":"'+AMenuButtonType.ToString+
           ',"text":"'+AText+'","web_app":"{"url":"'+TtdWebAppInfo(AWebApp).url+'"}}';
  inherited Create(AJson);
end;

function TtdMenuButtonWebApp.text: String;
begin
  Result := ReadToSimpleType<string>('text');
end;

function TtdMenuButtonWebApp.&type: String;
begin
  Result := ReadToSimpleType<string>('type');

{if VType = TtdMenuButtonType.MenuButtonCommands then
  Result := TtdMenuButtonType.MenuButtonCommands
  Else
  if VType = TtdMenuButtonType.MenuButtonWebApp then
    Result := TtdMenuButtonType.MenuButtonWebApp
    Else
    if VType = TtdMenuButtonType.MenuButtonDefault then
      Result := TtdMenuButtonType.MenuButtonDefault;}

end;

function TtdMenuButtonWebApp.web_app: ItdWebAppInfo;
begin
  Result := ReadToClass<TtdWebAppInfo>('web_app');
end;

{ TtdMenuButtonDefault }

constructor TtdMenuButtonDefault.Create(
  const AMenuButtonType: TtdMenuButtonType);
var
  AJson: String;
begin
  AJson := '{"type":"'+AMenuButtonType.ToString+'"}';
//  Ftype_ := AMenuButtonType.ToString;
  inherited Create(AJson);
end;

function TtdMenuButtonDefault.&type: String;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdChatAdministratorRights }

function TtdChatAdministratorRights.can_change_info: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_change_info');
end;

function TtdChatAdministratorRights.can_delete_messages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_delete_messages');
end;

function TtdChatAdministratorRights.can_delete_stories: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_delete_stories');
end;

function TtdChatAdministratorRights.can_edit_messages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_edit_messages');
end;

function TtdChatAdministratorRights.can_edit_stories: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_edit_stories');
end;

function TtdChatAdministratorRights.can_invite_users: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_invite_users');
end;

function TtdChatAdministratorRights.can_manage_chat: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_chat');
end;

function TtdChatAdministratorRights.can_manage_topics: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_topics');
end;

function TtdChatAdministratorRights.can_manage_video_chats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_manage_video_chats');
end;

function TtdChatAdministratorRights.can_pin_messages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_pin_messages');
end;

function TtdChatAdministratorRights.can_post_messages: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_post_messages');
end;

function TtdChatAdministratorRights.can_post_stories: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_post_stories');
end;

function TtdChatAdministratorRights.can_promote_members: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_promote_members');
end;

function TtdChatAdministratorRights.can_restrict_members: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_restrict_members');
end;

constructor TtdChatAdministratorRights.Create;
var
  AJson: String;
begin
  AJson := '{"is_anonymous":"'+FIsAnonymous.ToJSONBool+'",'+
           '"can_manage_chat":"'+FCanManageChat.ToJSONBool+'",'+
           '"can_delete_messages":"'+FCanDeleteMessages.ToJSONBool+'",'+
           '"can_manage_video_chats":"'+FCanManageVideoChats.ToJSONBool+'",'+
           '"can_restrict_members":"'+FCanRestrictMembers.ToJSONBool+'",'+
           '"can_promote_members":"'+FCanPromoteMembers.ToJSONBool+'",'+
           '"can_change_info":"'+FCanChangeInfo.ToJSONBool+'",'+
           '"can_invite_users":"'+FCanInviteUsers.ToJSONBool+'",'+
           '"can_post_messages":"'+FCanPostMessages.ToJSONBool+'",'+
           '"can_edit_messages":"'+FCanEditMessages.ToJSONBool+'",'+
           '"can_pin_messages":"'+FCanPinMessages.ToJSONBool+'"}';

  inherited Create(AJson);
end;

function TtdChatAdministratorRights.is_anonymous: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_anonymous');
end;

function TtdChatAdministratorRights.ToJsonObject: string;
begin
  Result := '{"is_anonymous":'+FIsAnonymous.ToJSONBool+','+
            '"can_manage_chat":'+FCanManageChat.ToJSONBool+','+
            '"can_delete_messages":'+FCanDeleteMessages.ToJSONBool+','+
            '"can_manage_video_chats":'+FCanManageVideoChats.ToJSONBool+','+
            '"can_restrict_members":'+FCanRestrictMembers.ToJSONBool+','+
            '"can_promote_members":'+FCanPromoteMembers.ToJSONBool+','+
            '"can_change_info":'+FCanChangeInfo.ToJSONBool+','+
            '"can_invite_users":'+FCanInviteUsers.ToJSONBool+','+
            '"can_post_messages":'+FCanPostMessages.ToJSONBool+','+
            '"can_edit_messages":'+FCanEditMessages.ToJSONBool+','+
            '"can_pin_messages":'+FCanPinMessages.ToJSONBool+','+
            '"can_post_stories":'+FCanPostStories.ToJSONBool+','+
            '"can_edit_stories":'+FCanEditStories.ToJSONBool+','+
            '"can_delete_stories":'+FCanDeleteStories.ToJSONBool+','+
            '"can_manage_topics":'+FCanManageTopics.ToJSONBool+'}';
end;

{ TtdThemeParams }

function TtdThemeParams.Getbg_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('bg_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

{
function TColorToHex(Color : TColor) : string;
begin
   Result :=
     IntToHex(GetRValue(ColorToRGB(Color)), 2) +
     IntToHex(GetGValue(ColorToRGB(Color)), 2) +
     IntToHex(GetBValue(ColorToRGB(Color)), 2) ;
end;

     RGB(
       StrToInt('$'+Copy(sColor, 1, 2)),
       StrToInt('$'+Copy(sColor, 3, 2)),
       StrToInt('$'+Copy(sColor, 5, 2))
     ) ;
}

end;

function TtdThemeParams.Getbutton_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('button_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

end;

function TtdThemeParams.Getbutton_text_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('button_text_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

end;

function TtdThemeParams.Gethint_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('hint_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

end;

function TtdThemeParams.Getlink_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('link_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

end;

function TtdThemeParams.Getsecondary_bg_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('secondary_bg_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

end;

function TtdThemeParams.Gettext_color: TColor;
var
 StrColor : String;
begin
  StrColor := ReadToSimpleType<string>('text_color');

  Result := RGB(
       StrToInt('$'+Copy(StrColor, 1, 2)),
       StrToInt('$'+Copy(StrColor, 3, 2)),
       StrToInt('$'+Copy(StrColor, 5, 2))
     ) ;

end;

{ TtdMenuButton }

constructor TtdMenuButton.Create(const AMenuButtonType: TtdMenuButtonType);
var
  AJson: String;
begin
  AJson := '{"type":"'+AMenuButtonType.ToString+'"}';
  FMenuButtonType := AMenuButtonType;
  inherited Create(AJson);
end;

procedure TtdMenuButton.SetMenuButtonType(const Value: TtdMenuButtonType);
begin
  FMenuButtonType := Value;
end;

{ TtdForumTopicCreated }

function TtdForumTopicCreated.icon_color: integer;
begin
  Result := ReadToSimpleType<integer>('icon_color');
end;

function TtdForumTopicCreated.icon_custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('icon_custom_emoji_id');
end;

function TtdForumTopicCreated.name: string;
begin
  Result := ReadToSimpleType<string>('name');
end;

{ TtdForumTopicEdited }

function TtdForumTopicEdited.icon_custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('icon_custom_emoji_id');
end;

function TtdForumTopicEdited.name: string;
begin
  Result := ReadToSimpleType<string>('name');
end;

{ TtdForumTopic }

function TtdForumTopic.icon_color: integer;
begin
  Result := ReadToSimpleType<integer>('icon_color');
end;

function TtdForumTopic.icon_custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('icon_custom_emoji_id');
end;

function TtdForumTopic.message_thread_id: int64;
begin
  Result := ReadToSimpleType<int64>('message_thread_id');
end;

function TtdForumTopic.name: string;
begin
  Result := ReadToSimpleType<string>('name');
end;

{ TtdBotDescription }

function TtdBotDescription.description: string;
begin
  Result := ReadToSimpleType<string>('description');
end;

{ TtdBotShortDescription }

function TtdBotShortDescription.short_description: string;
begin
  Result := ReadToSimpleType<string>('short_description');
end;

{ TtdInputSticker }

function TtdInputSticker.emoji_list: TArray<string>;
begin
  Result := ReadToTArrayString('emoji_list');
end;

function TtdInputSticker.format: string;
begin
  Result := ReadToSimpleType<string>('format');
end;

function TtdInputSticker.keywords: TArray<string>;
begin
  Result := ReadToTArrayString('keywords');
end;

function TtdInputSticker.mask_position: ItdMaskPosition;
begin
  Result := ReadToClass<TtdMaskPosition>('mask_position');
end;

function TtdInputSticker.sticker: string;
begin
  Result := ReadToSimpleType<string>('sticker');
end;

{ TtdWriteAccessAllowed }

function TtdWriteAccessAllowed.web_app_name: string;
begin
  Result := ReadToSimpleType<string>('web_app_name');
end;

{ TtdSwitchInlineQueryChosenChat }

function TtdSwitchInlineQueryChosenChat.allow_bot_chats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allow_bot_chats');
end;

function TtdSwitchInlineQueryChosenChat.allow_channel_chats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allow_channel_chats');
end;

function TtdSwitchInlineQueryChosenChat.allow_group_chats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allow_group_chats');
end;

function TtdSwitchInlineQueryChosenChat.allow_user_chats: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allow_user_chats');
end;

function TtdSwitchInlineQueryChosenChat.query: string;
begin
  Result := ReadToSimpleType<string>('query');
end;

{ TtdtdBotName }

function TtdBotName.name: string;
begin
  Result := ReadToSimpleType<string>('name');
end;

{ TODO 5 -oDiego -cTipos de Dados : Promover a Integração do metodo de leitura de lista de classes para correção deste tipo de dado }
{ TtdBotCommandScope }

constructor TtdBotCommandScopeDefault.Create(const AType: TtdBotCommandScopeType);
var
  AJson: String;
begin
  AJson := AType.ToJsonObject;

  inherited Create(AJson);

end;


function TtdBotCommandScopeDefault.ToJsonObject: string;
begin

end;

function TtdBotCommandScopeDefault.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBotCommandScopeChat }

function TtdBotCommandScopeChat.chat_id: string;
begin
  Result := ReadToSimpleType<string>('chat_id');
end;

{ TtdBotCommandScopeChatMember }

function TtdBotCommandScopeChatMember.user_id: integer;
begin
  Result := ReadToSimpleType<integer>('user_id');
end;

{ TtdChatMember }

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

function TtdChatMember.User: ItdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdReactionTypeEmoji }

function TtdReactionTypeEmoji.emoji: string;
begin
  Result := ReadToSimpleType<string>('emoji');
end;

function TtdReactionTypeEmoji.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdReactionTypeCustomEmoji }

function TtdReactionTypeCustomEmoji.custom_emoji_id: string;
begin
  Result := ReadToSimpleType<string>('custom_emoji_id');
end;

function TtdReactionTypeCustomEmoji.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdReactionType }

function TtdReactionType.ReactionTypeCustomEmoji: TtdReactionTypeCustomEmoji;
begin
  Result := ReadToClass<TtdReactionTypeCustomEmoji>('reaction_type_custom_emoji');
end;

function TtdReactionType.ReactionTypeEmoji: TtdReactionTypeEmoji;
begin
  Result := ReadToClass<TtdReactionTypeEmoji>('reaction_type_emoji');
end;

{ TtdReactionCount }

function TtdReactionCount.ReactionType: ItdReactionType;
begin
  Result := ReadToClass<TtdReactionType>('reaction_type');
end;

function TtdReactionCount.total_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('total_count');
end;

{ TtdMessageReactionUpdated }

function TtdMessageReactionUpdated.actor_chat: TtdChat;
begin

end;

function TtdMessageReactionUpdated.chat: TtdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdMessageReactionUpdated.date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;

function TtdMessageReactionUpdated.message_id: int64;
begin
  Result := ReadToSimpleType<int64>('message_id');
end;

function TtdMessageReactionUpdated.new_reaction: TArray<ItdReactionType>;
begin
  Result := ReadToInterfaceArray<ItdReactionType>(TtdReactionType,'new_reaction');
end;

function TtdMessageReactionUpdated.old_reaction: TArray<ItdReactionType>;
begin
  Result := ReadToInterfaceArray<ItdReactionType>(TtdReactionType, 'new_reaction');
end;

function TtdMessageReactionUpdated.user: TtdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdMessageReactionCountUpdated }

function TtdMessageReactionCountUpdated.chat: TtdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdMessageReactionCountUpdated.date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;

function TtdMessageReactionCountUpdated.message_id: int64;
begin
  Result := ReadToSimpleType<int64>('message_id');
end;

function TtdMessageReactionCountUpdated.reaction: TArray<TtdReactionCount>;
begin
  Result := ReadToClassArray<TtdReactionCount>('reaction');
end;

{ TtdMessageOrigin }

function TtdMessageOrigin.date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;

function TtdMessageOrigin.type_: String;
begin
  Result := ReadToSimpleType<String>('type');
end;

{ TtdMessageOriginUser }

function TtdMessageOriginUser.sender_user: TtdUser;
begin
  Result := ReadToClass<TtdUser>('sender_user');
end;

{ TtdMessageOriginHiddenUser }

function TtdMessageOriginHiddenUser.sender_user_name: String;
begin
  Result := ReadToSimpleType<String>('sender_user_name');
end;

{ TtdMessageOriginChat }

function TtdMessageOriginChat.author_signature: String;
begin
  Result := ReadToSimpleType<String>('author_signature');
end;

function TtdMessageOriginChat.sender_chat: TtdChat;
begin
  Result := ReadToClass<TtdChat>('sender_chat');
end;

{ TtdMessageOriginChannel }

function TtdMessageOriginChannel.author_signature: String;
begin
  Result := ReadToSimpleType<String>('author_signature');
end;

function TtdMessageOriginChannel.chat: TtdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdMessageOriginChannel.message_id: Integer;
begin
  Result := ReadToSimpleType<Integer>('message_id');
end;

{ TtdGiveaway }

function TtdGiveaway.chats: TArray<ItdChat>;
begin
  Result := ReadToInterfaceArray<ItdChat>(TtdChat, 'chats');
end;

function TtdGiveaway.country_codes: TArray<String>;
begin
  Result := ReadToTArrayString('chats');
end;

function TtdGiveaway.has_public_winners: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_public_winners');
end;

function TtdGiveaway.only_new_members: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('only_new_members');
end;

function TtdGiveaway.premium_subscription_month_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('premium_subscription_month_count');
end;

function TtdGiveaway.prize_description: String;
begin
  Result := ReadToSimpleType<String>('prize_description');
end;

function TtdGiveaway.winners_selection_date: TDateTime;
begin
  Result := ReadToDateTime('winners_selection_date');
end;

function TtdGiveaway.winner_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('winner_count');
end;

{ TtdGiveawayWinners }

function TtdGiveawayWinners.additional_chat_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('additional_chat_count');
end;

function TtdGiveawayWinners.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdGiveawayWinners.giveaway_message_id: Int64;
begin
  Result := ReadToSimpleType<Int64>('giveaway_message_id');
end;

function TtdGiveawayWinners.only_new_members: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('only_new_members');
end;

function TtdGiveawayWinners.premium_subscription_month_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('premium_subscription_month_count');
end;

function TtdGiveawayWinners.prize_description: String;
begin
  Result := ReadToSimpleType<String>('prize_description');
end;

function TtdGiveawayWinners.unclaimed_prize_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('unclaimed_prize_count');
end;

function TtdGiveawayWinners.was_refunded: Boolean;
begin
   Result := ReadToSimpleType<Boolean>('was_refunded');
end;

function TtdGiveawayWinners.winners: TArray<ItdUser>;
begin
   Result := ReadToInterfaceArray<ItdUser>(TtdUser, 'winners');
end;

function TtdGiveawayWinners.winners_selection_date: TDateTime;
begin
   Result := ReadToDateTime('winners_selection_date');
end;

function TtdGiveawayWinners.winner_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('winner_count');
end;

{ TtdGiveawayCompleted }

function TtdGiveawayCompleted.giveaway_message: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('giveaway_message');
end;

function TtdGiveawayCompleted.unclaimed_prize_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('unclaimed_prize_count');
end;

function TtdGiveawayCompleted.winner_count: Integer;
begin
  Result := ReadToSimpleType<Integer>('winner_count');
end;

{ TtdLinkPreviewOptions }

constructor TtdLinkPreviewOptions.Create(const AJson: string);
begin
  inherited Create(AJson);

end;

constructor TtdLinkPreviewOptions.Create(const AIsDisabled: Boolean; FUrl: String;
  FPreferSmallMedia, FPreferLargeMedia, FShowAboveText: Boolean);
begin
{ TODO 5 -oDiego -cLinkPreviewOptions : Teste de Funcionamento }
  is_disabled         := AIsDisabled;
  url                 := FUrl;
  prefer_small_media  := FPreferSmallMedia;
  prefer_large_media  := FPreferLargeMedia;
  show_above_text     := FShowAboveText;

  inherited Create('LinkPreviewOptions:{is_disabled:'+is_disabled.ToJSONBool+
  ', url:'+url+
  ', prefer_small_media:'+prefer_small_media.ToJSONBool+
  ', prefer_large_media:'+prefer_large_media.ToJSONBool+
  ', show_above_text:'+show_above_text.ToJSONBool+'}');
end;

function TtdLinkPreviewOptions.getis_disabled: Boolean;
begin
   Result := ReadToSimpleType<Boolean>('is_disabled');
end;

function TtdLinkPreviewOptions.getprefer_large_media: Boolean;
begin
   Result := ReadToSimpleType<Boolean>('prefer_large_media');
end;

function TtdLinkPreviewOptions.getprefer_small_media: Boolean;
begin
   Result := ReadToSimpleType<Boolean>('prefer_small_media');
end;

function TtdLinkPreviewOptions.getshow_above_text: Boolean;
begin
   Result := ReadToSimpleType<Boolean>('show_above_text');
end;

function TtdLinkPreviewOptions.geturl: String;
begin
   Result := ReadToSimpleType<String>('url');
end;

{ TtdExternalReplyInfo }

function TtdExternalReplyInfo.animation: ItdAnimation;
begin
  Result := ReadToClass<TtdAnimation>('animation');
end;

function TtdExternalReplyInfo.audio: ItdAudio;
begin
  Result := ReadToClass<TtdAudio>('audio');
end;

function TtdExternalReplyInfo.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdExternalReplyInfo.contact: Itdcontact;
begin
  Result := ReadToClass<Ttdcontact>('contact');
end;

function TtdExternalReplyInfo.dice: Itddice;
begin
  Result := ReadToClass<TtdDice>('dice');
end;

function TtdExternalReplyInfo.document: ItdDocument;
begin
  Result := ReadToClass<TtdDocument>('document');
end;

function TtdExternalReplyInfo.game: ItdGame;
begin
  Result := ReadToClass<TtdGame>('game');
end;

function TtdExternalReplyInfo.giveaway: ItdGiveaway;
begin
  Result := ReadToClass<TtdGiveaway>('giveaway');
end;

function TtdExternalReplyInfo.giveaway_winners: ItdGiveawayWinners;
begin
  Result := ReadToClass<TtdGiveawayWinners>('giveaway_winners');
end;

function TtdExternalReplyInfo.has_media_spoiler: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('has_media_spoiler');
end;

function TtdExternalReplyInfo.invoice: Itdinvoice;
begin
  Result := ReadToClass<TtdInvoice>('invoice');
end;

function TtdExternalReplyInfo.link_preview_options: ItdLinkPreviewOptions;
begin
  Result := ReadToClass<TtdLinkPreviewOptions>('link_preview_options');
end;

function TtdExternalReplyInfo.location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;

function TtdExternalReplyInfo.message_id: Integer;
begin
  Result := ReadToSimpleType<Integer>('message_id');
end;

function TtdExternalReplyInfo.Origin: ItdMessageOrigin;
begin
  Result := ReadToClass<TtdMessageOrigin>('Origin');
end;

function TtdExternalReplyInfo.photo: TArray<ItdPhotoSize>;
begin
  Result := ReadToInterfaceArray<ItdPhotoSize>(TtdPhotoSize, 'photo');
end;

function TtdExternalReplyInfo.poll: ItdPoll;
begin
  Result := ReadToClass<TtdPoll>('poll');
end;

function TtdExternalReplyInfo.sticker: ItdSticker;
begin
  Result := ReadToClass<TtdSticker>('sticker');
end;

function TtdExternalReplyInfo.story: ItdStory;
begin
  Result := ReadToClass<TtdStory>('story');
end;

function TtdExternalReplyInfo.venue: ItdVenue;
begin
  Result := ReadToClass<TtdVenue>('venue');
end;

function TtdExternalReplyInfo.video: ItdVideo;
begin
  Result := ReadToClass<TtdVideo>('video');
end;

function TtdExternalReplyInfo.video_note: ItdVideoNote;
begin
  Result := ReadToClass<TtdVideoNote>('video_note');
end;

function TtdExternalReplyInfo.voice: ItdVoice;
begin
  Result := ReadToClass<TtdVoice>('voice');
end;

{ TtdReplyParameters }

constructor TtdReplyParameters.Create;
var
  FJson: String;
begin
  FJson := TJsonUtils.ObjectToJString(Self);
  Create(FJson);
end;

constructor TtdReplyParameters.Create(const AJson: String);
begin
  inherited Create(AJson);
end;

function TtdReplyParameters.getallow_sending_without_reply: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('allow_sending_without_reply');
end;

function TtdReplyParameters.getchat_id: string;
begin
  Result := ReadToSimpleType<string>('chat_id');
end;

function TtdReplyParameters.getmessage_id: Integer;
begin
  Result := ReadToSimpleType<Integer>('message_id');
end;

function TtdReplyParameters.getquote: String;
begin
  Result := ReadToSimpleType<string>('quote');
end;

function TtdReplyParameters.getquote_entities: TArray<ItdMessageEntity>;
begin
  Result := ReadToInterfaceArray<ItdMessageEntity>(TtdMessageEntity, 'quote_entities');
end;

function TtdReplyParameters.getquote_parse_mode: String;
begin
  Result := ReadToSimpleType<string>('quote_parse_mode');
end;

function TtdReplyParameters.getquote_position: Integer;
begin
  Result := ReadToSimpleType<Integer>('quote_position');
end;

{ TtdChatBoostSource }

function TtdChatBoostSource.source: string;
begin
  Result := ReadToSimpleType<string>('source');
end;

function TtdChatBoostSource.user: TtdUser;
begin
  Result := ReadToClass<TtdUser>('user');
end;

{ TtdChatBoostSourceGiveaway }

function TtdChatBoostSourceGiveaway.giveaway_message_id: integer;
begin
  Result := ReadToSimpleType<integer>('giveaway_message_id');
end;

function TtdChatBoostSourceGiveaway.is_unclaimed: boolean;
begin
  Result := ReadToSimpleType<boolean>('is_unclaimed');
end;

{ TtdChatBoost }

function TtdChatBoost.add_date: TDateTime;
begin
  Result := ReadToDateTime('add_date');
end;

function TtdChatBoost.boost_id: integer;
begin
  Result := ReadToSimpleType<integer>('boost_id');
end;

function TtdChatBoost.expiration_date: TDateTime;
begin
  Result := ReadToDateTime('expiration_date');
end;

function TtdChatBoost.source: ItdChatBoostSource;
begin
  Result := ReadToClass<TtdChatBoostSource>('source');
end;

{ TtdChatBoostUpdated }

function TtdChatBoostUpdated.boost: ItdChatBoost;
begin
  Result := ReadToClass<TtdChatBoost>('boost');
end;

function TtdChatBoostUpdated.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

{ TtdChatBoostRemoved }

function TtdChatBoostRemoved.boost_id: integer;
begin
  Result := ReadToSimpleType<integer>('boost_id');
end;

function TtdChatBoostRemoved.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdChatBoostRemoved.remove_date: TDateTime;
begin
  Result := ReadToDateTime('remove_date');
end;

function TtdChatBoostRemoved.source: ItdChatBoostSource;
begin
  Result := ReadToClass<TtdChatBoostSource>('source');
end;

{ TtdUserChatBoosts }

function TtdUserChatBoosts.boosts: Tarray<ItdChatBoost>;
begin
  Result := ReadToInterfaceArray<ItdChatBoost>(TtdChatBoost, 'boosts');
end;

{ TtdMaybeInaccessibleMessage }

function TtdMaybeInaccessibleMessage.InaccessibleMessage: TtdInaccessibleMessage;
begin
  Result := ReadToClass<TtdInaccessibleMessage>('InaccessibleMessage');
end;

function TtdMaybeInaccessibleMessage.Message_: ItdMessage;
begin
  Result := ReadToClass<TtdMessage>('Message');
end;

{ TtdInaccessibleMessage }

function TtdInaccessibleMessage.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdInaccessibleMessage.date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;

function TtdInaccessibleMessage.message_id: Integer;
begin
  Result := ReadToSimpleType<integer>('message_id');
end;

{ TtdChatBoostAdded }

function TtdChatBoostAdded.boost_count: Integer;
begin
  Result := ReadToSimpleType<integer>('boost_count');
end;

{ TtdBackgroundFillSolid }

function TtdBackgroundFillSolid.color: Integer;
begin
  Result := ReadToSimpleType<integer>('color');
end;

function TtdBackgroundFillSolid.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBackgroundFillGradient }

function TtdBackgroundFillGradient.bottom_color: Integer;
begin
  Result := ReadToSimpleType<integer>('bottom_color');
end;

function TtdBackgroundFillGradient.rotation_angle: Integer;
begin
  Result := ReadToSimpleType<integer>('rotation_angle');
end;

function TtdBackgroundFillGradient.top_color: Integer;
begin
  Result := ReadToSimpleType<integer>('top_color');
end;

function TtdBackgroundFillGradient.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBackgroundFillFreeformGradient }

function TtdBackgroundFillFreeformGradient.colors: TArray<integer>;
begin
  Result := ReadToArraySimpleType<integer>('colors');
end;

function TtdBackgroundFillFreeformGradient.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBackgroundTypeFill }

function TtdBackgroundTypeFill.dark_theme_dimming: Integer;
begin
  Result := ReadToSimpleType<integer>('dark_theme_dimming');
end;

function TtdBackgroundTypeFill.fill: ItdBackgroundFill;
begin
  Result := ReadToClass<TtdBackgroundFill>('fill');
end;

function TtdBackgroundTypeFill.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBackgroundTypeWallpaper }

function TtdBackgroundTypeWallpaper.dark_theme_dimming: Integer;
begin
  Result := ReadToSimpleType<integer>('dark_theme_dimming');
end;

function TtdBackgroundTypeWallpaper.document: ItdDocument;
begin
  Result := ReadToClass<TtdDocument>('document');
end;

function TtdBackgroundTypeWallpaper.is_blurred: Boolean;
begin
  Result := ReadToSimpleType<boolean>('is_blurred');
end;

function TtdBackgroundTypeWallpaper.is_moving: Boolean;
begin
  Result := ReadToSimpleType<boolean>('is_moving');
end;

function TtdBackgroundTypeWallpaper.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBackgroundTypePattern }

function TtdBackgroundTypePattern.document: ItdDocument;
begin
  Result := ReadToClass<TtdDocument>('document');
end;

function TtdBackgroundTypePattern.fill: ItdBackgroundFill;
begin
  Result := ReadToClass<TtdBackgroundFill>('fill');
end;

function TtdBackgroundTypePattern.intensity: Integer;
begin
  Result := ReadToSimpleType<integer>('intensity');
end;

function TtdBackgroundTypePattern.is_inverted: Boolean;
begin
  Result := ReadToSimpleType<boolean>('is_inverted');
end;

function TtdBackgroundTypePattern.is_moving: Boolean;
begin
  Result := ReadToSimpleType<boolean>('is_moving');
end;

function TtdBackgroundTypePattern.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdBackgroundTypeChatTheme }

function TtdBackgroundTypeChatTheme.theme_name: string;
begin
  Result := ReadToSimpleType<string>('theme_name');
end;

function TtdBackgroundTypeChatTheme.type_: string;
begin
  Result := ReadToSimpleType<string>('type');
end;

{ TtdChatBackground }

function TtdChatBackground.type_: ItdBackgroundType;
begin
  Result := ReadToClass<TtdBackgroundType>('type');
end;

{ TtdTextQuote }

function TtdTextQuote.Entity: TArray<TtdMessageEntity>;
begin
  Result := ReadToClassArray<TtdMessageEntity>('entity');
end;

function TtdTextQuote.is_manual: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_manual');
end;

function TtdTextQuote.position: Integer;
begin
  Result := ReadToSimpleType<Integer>('position');
end;

function TtdTextQuote.Text: string;
begin
  Result := ReadToSimpleType<string>('text');
end;

{ TtdStory }

function TtdStory.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdStory.id: Int64;
begin
  Result := ReadToSimpleType<Int64>('id');
end;

{ TtdChat }

function TtdChat.FirstName: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;

function TtdChat.ID: Int64;
begin
  Result := ReadToSimpleType<Int64>('id');
end;

function TtdChat.is_forum: boolean;
begin
  Result := ReadToSimpleType<boolean>('is_forum');
end;

function TtdChat.LastName: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;

function TtdChat.Title: string;
begin
  Result := ReadToSimpleType<string>('first_name');
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
  Result := ReadToSimpleType<string>('user_name');
end;

{ TtdBusinessConnection }

function TtdBusinessConnection.can_reply: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('can_reply');
end;

function TtdBusinessConnection.date: TDateTime;
begin
  Result := ReadToDateTime('date');
end;

function TtdBusinessConnection.id: string;
begin
  Result := ReadToSimpleType<string>('id');
end;

function TtdBusinessConnection.is_enabled: Boolean;
begin
  Result := ReadToSimpleType<Boolean>('is_enabled');
end;

function TtdBusinessConnection.user: Itduser;
begin
  Result := ReadToClass<Ttduser>('user');
end;

function TtdBusinessConnection.user_chat_id: Int64;
begin
  Result := ReadToSimpleType<Int64>('user_chat_id');
end;

{ TtdBusinessMessagesDeleted }

function TtdBusinessMessagesDeleted.business_connection_id: string;
begin
  Result := ReadToSimpleType<string>('business_connection_id');
end;

function TtdBusinessMessagesDeleted.chat: ItdChat;
begin
  Result := ReadToClass<TtdChat>('chat');
end;

function TtdBusinessMessagesDeleted.message_ids: TArray<Integer>;
begin
  Result := ReadToArraySimpleType<Integer>('message_ids');
end;

{ TtdBirthdate }

function TtdBirthdate.day: Integer;
begin
  Result := ReadToSimpleType<Integer>('day');
end;

function TtdBirthdate.month: Integer;
begin
  Result := ReadToSimpleType<Integer>('month');
end;

function TtdBirthdate.year: Integer;
begin
  Result := ReadToSimpleType<Integer>('year');
end;

{ TtdBusinessIntro }

function TtdBusinessIntro.message_: String;
begin
  Result := ReadToSimpleType<string>('message');
end;

function TtdBusinessIntro.sticker: ItdSticker;
begin
  Result := ReadToClass<TtdSticker>('sticker');
end;

function TtdBusinessIntro.title: String;
begin
  Result := ReadToSimpleType<string>('title');
end;

{ TtdBusinessLocation }

function TtdBusinessLocation.address: String;
begin
  Result := ReadToSimpleType<string>('address');
end;

function TtdBusinessLocation.location: ItdLocation;
begin
  Result := ReadToClass<TtdLocation>('location');
end;

{ TtdBusinessOpeningHoursInterval }

function TtdBusinessOpeningHoursInterval.closing_minute: integer;
begin
  Result := ReadToSimpleType<Integer>('closing_minute');
end;

function TtdBusinessOpeningHoursInterval.opening_minute: integer;
begin
  Result := ReadToSimpleType<Integer>('opening_minute');
end;

{ TtdBusinessOpeningHours }

function TtdBusinessOpeningHours.opening_hours: TArray<TtdBusinessOpeningHoursInterval>;
begin
  Result := ReadToClassArray<TtdBusinessOpeningHoursInterval>('opening_hours');
end;

function TtdBusinessOpeningHours.time_zone_name: string;
begin
  Result := ReadToSimpleType<string>('time_zone_name');
end;

{ TtdSharedUser }

function TtdSharedUser.first_name: string;
begin
  Result := ReadToSimpleType<string>('first_name');
end;

function TtdSharedUser.last_name: string;
begin
  Result := ReadToSimpleType<string>('last_name');
end;

function TtdSharedUser.photo: TArray<ItdPhotosize>;
begin
  Result := ReadToInterfaceArray<ItdPhotosize>(TtdPhotosize, 'photo');
end;

function TtdSharedUser.username: string;
begin
  Result := ReadToSimpleType<string>('username');
end;

function TtdSharedUser.user_id: int64;
begin
  Result := ReadToSimpleType<int64>('user_id');
end;

{ TtdUsersShared }

function TtdUsersShared.request_id: integer;
begin
  Result := ReadToSimpleType<integer>('request_id');
end;

function TtdUsersShared.users: TArray<ItdSharedUser>;
begin
  Result := ReadToInterfaceArray<ItdSharedUser>(TtdSharedUser, 'users');
end;

{ TtdChatShared }

function TtdChatShared.chat_id: integer;
begin
  Result := ReadToSimpleType<integer>('chat_id');
end;

function TtdChatShared.photo: TArray<ItdPhotosize>;
begin
  Result := ReadToInterfaceArray<ItdPhotosize>(TtdPhotosize, 'photo');
end;

function TtdChatShared.request_id: integer;
begin
  Result := ReadToSimpleType<integer>('request_id');
end;

function TtdChatShared.title: string;
begin
  Result := ReadToSimpleType<string>('title');
end;

function TtdChatShared.username: string;
begin
  Result := ReadToSimpleType<string>('username');
end;

{ TtdInputPollOption }

function TtdInputPollOption.text: String;
begin
  Result := ReadToSimpleType<string>('text');
end;

function TtdInputPollOption.text_entities: TArray<ItdMEssageEntity>;
begin
  Result := ReadToInterfaceArray<ItdMEssageEntity>(TtdMEssageEntity, 'text_entities');
end;

function TtdInputPollOption.text_parse_mode: String;
begin
  Result := ReadToSimpleType<string>('text_parse_mode');
end;

End.

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
    function CanConnectToBusiness: Boolean;
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

  ItdReactionType = interface;

  ItdSticker = interface;

  ItdBirthdate = interface
    ['{56EC0001-BFFA-4F5F-9F6B-3DD3C8EC25A5}']
    function day: Integer;
    function month: Integer;
    function year: Integer;
  end;

  ItdBusinessIntro = interface
    ['{5D79B64B-514F-464A-B6BA-39DA2759F41F}']
    function title: String;
    function message_: String;
    function sticker: ItdSticker;
  end;

  ItdBusinessLocation = interface
    ['{ECD12907-42BA-4488-B599-46FAC200C237}']
    function address: String;
    function location: ItdLocation;
  end;

  ItdBusinessOpeningHoursInterval = interface
    ['{3B07A229-69CD-4F7F-BD37-610D3A4355EE}']
    function opening_minute: integer;
    function closing_minute: integer;
  end;

  ItdBusinessOpeningHours = interface
    ['{F5A95C8E-625C-4E68-9972-729CEE6803CC}']
  end;

  ItdChat = interface
    ['{E565BBA8-DA68-4C72-ABD1-C7FAA2EDBA5A}']
    function ID: Int64;
    function TypeChat: TtdChatType;
    function Title: string;
    function Username: string;
    function FirstName: string;
    function LastName: string;
    function is_forum: boolean;
  end;

  ItdChatFullInfo = interface
    ['{5CE94B3E-312E-48FA-98A4-4C34E16A5DC7}']
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
    function JoinToSendMessages: Boolean;
    function JoinByRequest: Boolean;
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
    function HasVisibleHistory: boolean; //has_visible_history
    function StickerSetName: string;
    function CanSetStickerSet: Boolean;
    function CustomEmojiStickerSetName: String;
    function LinkedChatId:	Integer;
    function location: ItdChatLocation;
    function ToJSonStr: String;
    function ToString: String;
  end;
  ItdMessageOrigin = Interface
    ['{1DA86AA1-CFE3-41D8-8D71-3EE2AB118125}']
  End;


  ItdMessageEntity = interface
    ['{0F510BB7-8436-426E-8ECC-46742E3183E1}']
    function TypeMessage: TtdMessageEntityType;
    function Offset: Int64;
    function Length: Int64;
    function Url: string;
    function User: ItdUser;
    function language: string;
    function custom_emoji_id: string;
  end;
  ItdTextQuote = interface
    ['{2EB19616-B489-4944-8A7A-061073148519}']
//    function Text: string;
//    function Entity: TArray<ItdMessageEntity>;
//    function position: Integer;
//    function is_manual: Boolean;
  end;

  ItdFile = interface
    ['{7A0DE9B9-939C-4079-B6A5-997AEA9497C9}']
    function FileId: string;
    function FileUniqueId: string;
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
    function Thumbnail: ItdPhotoSize;
  end;
  ItdDocument = interface(ItdFile)
    ['{2B4DF418-FE55-490B-B119-46B9CB846609}']
    function Thumbnail: ItdPhotoSize;
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

  ItdInputSticker = interface
    ['{DEC1AB4F-2377-4251-82D1-A67BE27D9892}']
    function sticker: string;
    function format: string;
    function emoji_list: TArray<string>;
    function mask_position: ItdMaskPosition;
    function keywords: TArray<string>;
  end;

  ItdSharedUser = interface
    ['{CD2E65F0-B882-430C-B785-57B78A7CFEF1}']
    function user_id: int64;
    function first_name: string;
    function last_name: string;
    function username: string;
    function photo: TArray<ItdPhotosize>;
  end;

  ItdUsersShared = interface
    ['{F6F13E0F-5417-48B3-A8D4-E434BBA808F1}']
    function request_id: integer;
    function users: TArray<ItdSharedUser>;
  end;

  ItdChatShared = interface
    ['{47BF23A6-C7D2-4656-B54E-E3C946602506}']
    function request_id: integer;
    function chat_id: integer;
    function title: string;
    function username: string;
    function photo: TArray<ItdPhotosize>;
  end;


  ItdSticker = interface(ItdFile)
    ['{C2598C8D-506F-4208-80AA-ED2731C92192}']
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
  ItdStickerSet = interface
    ['{FCE66210-3EFF-4D97-9077-473AAFE9FC97}']
    function Name: string;
    function Title: string;
    function StickerType: TtdStickerType;
    function Stickers: TArray<ItdSticker>;
    function Thumbnail: ItdPhotoSize;
  end;
  ItdStory = Interface
    ['{F936A7EF-9D8B-48F4-9563-30B041288884}']
  End;
  ItdVideo = interface(ItdFile)
    ['{520EB672-788A-4B7B-9BD9-1A569FD7C417}']
    function Width: Int64;
    function Height: Int64;
    function Duration: Int64;
    function Thumbnail: ItdPhotoSize;
    function FileName: string;
    function MimeType: string;
  end;
  ItdVideoNote = interface(ItdFile)
    ['{D15B034D-9C4E-459A-9735-E63973813C6F}']
    function Length: Int64;
    function Duration: Int64;
    function Thumbnail: ItdPhotoSize;
  end;
  ItdVoice = interface(ItdFile)
    ['{99D91D3C-FC16-40CA-BA72-EFA8F5D0F5F9}']
    function Duration: Int64;
    function MimeType: string;
  end;
  ItdContact = interface
    ['{57113A43-41E0-4846-9CBA-A355400E3938}']
    function getPhoneNumber: string;
    function getFirstName: string;
    function getLastName: string;
    function getUserId: Int64;
    function getVCard: string;
  end;
  ItdPollOption = interface
    ['{2D275027-A366-4D2E-A211-176A17DF2880}']
    function text : String;
    function text_entities: TArray<ItdMEssageEntity>;
    function voter_count: String;
  end;
  ItdInputPollOption = interface
    ['{AD41A8C9-615F-47DC-975E-595434C1677B}']
    function text : String;
    function text_parse_mode: String;
    function text_entities: TArray<ItdMEssageEntity>;
  end;
  ItdPollAnswer = interface
    ['{E9FDBD08-6728-44AC-B9F8-31FAF9CD8669}']
    function poll_id: String;
    function voter_chat: ItdChat;
    function user: ItdUser;
    function option_ids: TArray<Integer>;
  end;
  ItdPoll = interface
    ['{6FD83DB0-02CA-4840-9A40-CB257589EC3B}']
    function id : String;
    function question: String;
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
    function Thumbnail: ItdPhotoSize;
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
  ItdChatJoinRequest = interface //New in API 5.4
    ['{1C15162D-4CB0-4F06-A1ED-A5987EF9C85A}']
    function chat:	ItdChat;
    function from:	ItdUser;
    function user_chat_id: Integer;
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
    function via_join_request: Boolean;
    function via_chat_folder_invite_link: Boolean;
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
  ItdGiveawayCreated = Interface
    ['{8AA134E7-3B66-4D32-BBB8-835E2B462C87}']
  End;
  ItdGiveaway = Interface
    ['{75D84F8A-4CCF-4416-BFFF-C1F5EB1DB5B8}']
    function chats: TArray<ItdChat>;
    function winners_selection_date: TDateTime;
    function winner_count: Integer;
    function only_new_members: Boolean;
    function has_public_winners: Boolean;
    function prize_description: String;
    function country_codes: TArray<String>;
    function premium_subscription_month_count: Integer;
  End;
  ItdGiveawayWinners = Interface
    ['{917E3335-9C8C-4502-B8A1-6172357CD657}']
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
  ItdGiveawayCompleted = Interface
    ['{0B440A02-3AC6-4A14-BD64-6B37F9A30A3B}']
    function winner_count: Integer;
    function unclaimed_prize_count: Integer;
    function giveaway_message: ItdMessage;
  End;
  ItdLinkPreviewOptions = interface
    ['{68A75F14-D89B-45B4-A1AD-94E2A9B41E99}']
    function getis_disabled: Boolean;
    function geturl: String;
    function getprefer_small_media: Boolean;
    function getprefer_large_media: Boolean;
    function getshow_above_text: Boolean;
  end;

  ItdExternalReplyInfo = Interface
    ['{8AE35976-63B1-4308-9A69-0703EBD1A78C}']
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
  ItdReplyParameters = Interface
    ['{17B9AA96-6032-456D-983F-43282B9EE24C}']
    function getmessage_id: Integer;
    function getchat_id: string;
    function getallow_sending_without_reply: Boolean;
    function getquote: String;
    function getquote_parse_mode: String;
    function getquote_entities: TArray<ItdMessageEntity>;
    function getquote_position: Integer;
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

  ItdWriteAccessAllowed = interface
  ['{6D9779F7-356F-4ACB-AC51-B48ED3ACAC8B}']
    function web_app_name: string;
  end;

  ItdForumTopic = interface
    ['{5043B054-7881-48CD-A370-218F3E7A45AC}']
    function message_thread_id: int64;
    function name: string;
    function icon_color: integer;
    function icon_custom_emoji_id: string;
  end;

  ItdForumTopicCreated = interface
    ['{4271D7D3-93F6-4A54-917A-45F0ECAB2EC5}']
    function name: string;
    function icon_color: integer;
    function icon_custom_emoji_id: string;
  end;

  ItdForumTopicClosed = interface
    ['{46763DBB-1D31-45E4-9A0A-B690FB4D5A3D}']
  end;

  ItdForumTopicEdited = interface
    ['{5284D187-B7D8-48B6-BCED-9FCAF77F5CE0}']
    function name: string;
    function icon_custom_emoji_id: string;
  end;

  ItdForumTopicReopened = interface
    ['{0158DEF3-A221-42C0-AD0F-F69E726157EB}']
  end;

  ItdGeneralForumTopicHidden = interface
    ['{DB0916EC-020E-4E14-ADD2-18F7B5AFA852}']
  end;

  ItdGeneralForumTopicUnhidden = interface
    ['{91AEC975-5CFF-4FD0-B8F6-EDB6C3DE0151}']
  end;

  ItdMaybeInaccessibleMessage_ = Interface
    ['{DABBAA94-5686-4D4E-8802-C79CF5340710}']
  End;

  ItdChatBoostAdded = interface;

  ItdChatBackground = interface;

  ItdMessage = interface(ItdMaybeInaccessibleMessage_)
    ['{66BC2558-00C0-4BDD-BDDE-E83249787B30}']
    function MessageId: Int64;
    function MessageThreadId: Int64;
    function From: ItdUser;
    function SenderChat: ItdChat;
    function SenderBoostCount: Integer;
    function SenderBusinessBot: ItdUser;
    function Date: TDateTime;
    function BusinessConnectionId: string;
    function Chat: ItdChat;
    function ForwardOrigin: ItdMessageOrigin; //forward_origin
    function IsTopicMessage: Boolean;
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
    function MessageAutoDeleteTimerChanged: ItdMessageAutoDeleteTimerChanged;
    function MigrateToChatId: Int64;
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
    function NewChatMember: ItdUser;  //Resource...
    function &Type: TtdMessageType;   //Resource...
    function IsCommand(const AValue: string): Boolean;  //Resource...
  end;
  ItdMessageID = interface
    ['{8F988303-9873-47DF-969E-E6F72391E214}']
    function MessageId: Int64;
  end;

  ItdInaccessibleMessage = Interface(ItdMaybeInaccessibleMessage_)
    ['{3BBCE0BA-2E49-49FA-B752-623446DC7AD1}']
    function chat: ItdChat;
    function message_id: Integer;
    function date: TDateTime;
  End;

  ItdMaybeInaccessibleMessage = Interface
    ['{00928A00-0443-46B2-A852-F15F01468168}']
  End;

  ItdUserProfilePhotos = interface
    ['{DD667B04-15A3-47B1-A729-C75ED5BFE719}']
    function TotalCount: Int64;
    function Photos: TArray<TArray<ItdPhotoSize>>;
  end;

  ItdChatBoostSource = Interface
    ['{9B5348F5-D2B7-449F-A977-17510DAA0792}']
  End;

  ItdChatBoost = Interface
    ['{5AC1122C-81AC-4147-895C-9BB02780ADA2}']
    function boost_id: integer;
    function add_date: TDateTime;
    function expiration_date: TDateTime;
    function source: ItdChatBoostSource;
  End;

  ItdChatBoostUpdated = Interface
    ['{E61CD4BF-4A20-4C9E-AF85-C9F50DFFFE12}']
    function chat: ItdChat;
    function boost: ItdChatBoost;
  End;

  ItdChatBoostRemoved = Interface
    ['{04CAC7A3-E0E3-4E39-ABCC-0F6E0BC507EA}']
    function chat: ItdChat;
    function boost_id: integer;
    function remove_date: TDateTime;
    function source: ItdChatBoostSource;
  End;

  ItdUserChatBoosts = Interface
    ['{FE2B58A9-1394-43D2-8B83-99BEDE2163D0}']
    function boosts: Tarray<ItdChatBoost>;
  End;

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
  ItdSwitchInlineQueryChosenChat = interface
    ['{697ADCB7-45C2-4E9F-A19B-9DF2AFC84246}']
    function query: string;
    function allow_user_chats: Boolean;
    function allow_bot_chats: Boolean;
    function allow_group_chats: Boolean;
    function allow_channel_chats: Boolean;
  end;

  ItdCallbackQuery = interface
    ['{83D9BF94-033A-44BA-8AD5-DCE25937A7B3}']
    function ID: string;
    function From: ItdUser;
    function Message_: ItdMaybeInaccessibleMessage_;
    function ChatInstance: string;
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


  ItdReaction = interface
    ['{12B2F2B4-65BE-49EF-AACE-59955A120483}']
  end;

  ItdReactionType = interface
    ['{19E9FC7C-A831-4931-8D5C-0F52FDE3E76A}']
  end;

  ItdReactionCount = interface
    ['{64FE7669-C268-4684-9B18-AAF2E5A0EFB5}']
  end;

  ItdBusinessConnection = interface
    ['{B2ED1EC6-BE1E-4550-8958-E485C0148539}']
    function id: string;
    function user: Itduser;
    function user_chat_id: Int64;
    function date: TDateTime;
    function can_reply: Boolean;
    function is_enabled: Boolean;
  end;

  ItdBusinessMessagesDeleted = interface
    ['{F639E6BC-5006-4C8E-B352-911F53CECCDF}']
    function business_connection_id: string;
    function chat: ItdChat;
    function message_ids: TArray<Integer>;
  end;

  ItdUpdate = interface
    ['{5D001F9B-B0BC-4A44-85E3-E0586DAAABD2}']
    function ID: Int64;
    function &message: ItdMessage;
    function EditedMessage: ItdMessage;
    function ChannelPost: ItdMessage;
    function EditedChannelPost: ItdMessage;
    function BusinessConnection: ItdBusinessConnection;
    function BusinessMessage: ItdMessage;
    function EditedBusinessMessage: ItdMessage;
    function DeletedBusinessMessages: ItdBusinessMessagesDeleted;
    function MessageReaction: ItdReaction;
    function MessageReactionCount: ItdReactionCount;
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
    function ChatBoost: ItdChatBoostUpdated;
    function ChatBoostRemoved: ItdChatBoostRemoved;
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
    function can_post_stories: Boolean;
    function can_edit_stories: Boolean;
    function can_delete_stories: Boolean;
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

  ItdBotCommandScope = interface
    ['{29D8983A-5596-461F-B7F3-6E05F703C5E2}']
  end;

  ItdBotName = interface
    ['{D1412E29-64D8-4920-89FA-EABB99A1049D}']
    function name: string;
  end;

  ItdBotDescription = interface
    ['{B81B2985-8086-430D-A59E-A6C1CE728886}']
    function description: string;
  end;

  ItdBotShortDescription = interface
    ['{15B54686-7F4E-4198-925B-ED29A7E757E5}']
    function short_description: string;
  end;

  ItdInputMessageContent = Interface
    ['{4E4312C8-93A5-44A4-ADE6-BCD479CF3932}']
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
{
This object represents the content of a media message to be sent. It should be one of

InputMediaAnimation
InputMediaDocument
InputMediaAudio
InputMediaPhoto
InputMediaVideo
}
  TtdInputMedia = class
  private
    FType: string;
    FMedia: string;
    FCaption: string;
    FParseMode: string;
    [JSONMarshalled(False)]
    FFileToSend: TtdFileToSend;
    FCaptionEntities: TArray<ItdMessageEntity>;
  public
    function GetFileToSend: TtdFileToSend;
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = ''); overload;  virtual;
    constructor Create(AType: String; AMedia: TtdFileToSend; const ACaption: string = ''); overload;
    constructor Create(AType: String; AMedia: TtdFileToSend; const ACaption: string = '';
      AParseMode: String = ''; const ACaptionEntities: TArray<ItdMessageEntity> = []); overload;
    [JsonName('type')]
    property &Type: string read FType write FType;
    [JsonName('media')]
    property Media: string read FMedia write FMedia;
    [JsonName('caption')]
    property Caption: string read FCaption write FCaption;
    [JsonName('parse_mode')]
    property ParseMode: string read FParseMode write FParseMode;
    [JsonName('caption_entities')]
    property CaptionEntities: TArray<ItdMessageEntity> read FCaptionEntities write FCaptionEntities;
  end;

  TtdInputMediaPhoto = class(TtdInputMedia)
  private
    FHasSpoiler: boolean;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = '');  override;
    [JsonName('has_spoiler')]
    property HasSpoiler: boolean read FHasSpoiler write FHasSpoiler;
  end;

  TtdInputMediaVideo = class(TtdInputMedia)
  private
    FWidth: Integer;
    FHeight: Integer;
    FDuration: Integer;
    FSupportsStreaming: Boolean;
    FHasSpoiler: boolean;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = '';
      AWidth: Integer = 0; AHeight: Integer = 0; ADuration: Integer = 0;
      ASupportsStreaming: Boolean = True; AHasSpoiler: Boolean = False); reintroduce;
    [JsonName('width')]
    property Width: Integer read FWidth write FWidth;
    [JsonName('height')]
    property Height: Integer read FHeight write FHeight;
    [JsonName('duration')]
    property Duration: Integer read FDuration write FDuration;
    [JsonName('has_spoiler')]
    property HasSpoiler: boolean read FHasSpoiler write FHasSpoiler;
    [JsonName('supports_streaming')]
    property SupportsStreaming: Boolean read FSupportsStreaming write FSupportsStreaming;
  end;

  TtdInputMediaAnimation = class(TtdInputMedia)
  private
    FDuration: Integer;
    FThumbnail: TtdFileToSend;
    FHasSpoiler: boolean;
    FWidth: Integer;
    FHeight: Integer;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = ''; ADuration: Integer = 0; APerformer: String = ''; ATitle: String = ''); reintroduce;
    [JsonName('width')]
    property Width: Integer read FWidth write FWidth;
    [JsonName('height')]
    property Height: Integer read FHeight write FHeight;
    [JsonName('duration')]
    property Duration: Integer read FDuration write FDuration;
    [JsonName('thumbnail')]
    property Thumbnail: TtdFileToSend read FThumbnail write FThumbnail;
    [JsonName('has_spoiler')]
    property HasSpoiler: boolean read FHasSpoiler write FHasSpoiler;
  end;

  TtdInputMediaAudio = class(TtdInputMedia)
  private
    FHasSpoiler: boolean;
    FTitle: string;
    FPerformer: string;
    FDuration: Integer;
    FThumbnail: TtdFileToSend;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = ''; AType: String = '';
      AParseMode: String = ''; const ACaptionEntities: TArray<ItdMessageEntity> = [];
      ADuration: Integer = 0; APerformer: String = ''; ATitle: String = ''); reintroduce;
    [JsonName('thumbnail')]
    property Thumbnail: TtdFileToSend read FThumbnail write FThumbnail;
    [JsonName('duration')]
    property Duration: Integer read FDuration write FDuration;
    [JsonName('performer')]
    property Performer: string read FPerformer write FPerformer;
    [JsonName('title')]
    property Title: string read FTitle write FTitle;
  end;

  TtdInputMediaDocument  = class(TtdInputMedia)
  private
    FDisableContentTypeDetection: Boolean;
  public
    constructor Create(AMedia: TtdFileToSend; const ACaption: string = ''; ADisableContentTypeDetection: Boolean = False); reintroduce;
    [JsonName('disable_content_type_detection')]
    property DisableContentTypeDetection: Boolean read FDisableContentTypeDetection write FDisableContentTypeDetection;
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

  ItdChatBoostAdded = interface
    ['{8FAB1B03-5CB4-47A2-99E8-38A24CC7FBA9}']
    function boost_count: Integer;
  end;

  ItdBackgroundFill = interface
    ['{E8234281-5B6B-496B-AD42-D5CBD4402536}']
  end;

  ItdBackgroundFillSolid = interface(ItdBackgroundFill)
    ['{4429BD27-1AEF-4BFC-8BE3-8143FCE29D47}']
    function type_: string;
    function color: Integer;
  end;

  ItdBackgroundFillGradient = interface(ItdBackgroundFill)   //Type of the background fill, always “gradient”
    ['{4429BD27-1AEF-4BFC-8BE3-8143FCE29D47}']
    function type_: string;
    function top_color: Integer;       //Top color of the gradient in the RGB24 format
    function bottom_color: Integer;    //Bottom color of the gradient in the RGB24 format
    function rotation_angle: Integer;  //Clockwise rotation angle of the background fill in degrees; 0-359
  end;

  ItdBackgroundFillFreeformGradient = interface(ItdBackgroundFill)
    ['{4429BD27-1AEF-4BFC-8BE3-8143FCE29D47}']
    function type_: string;
    function colors: TArray<integer>;  //A list of the 3 or 4 base colors that are used to generate the freeform gradient in the RGB24 format
  end;

  ItdBackgroundType = interface
    ['{0EB504E3-2FC6-499C-8BF2-DD32B1D58313}']
  end;

  ItdBackgroundTypeFill = interface(ItdBackgroundType)   //	Type of the background, always “fill”
    ['{8EC92BCA-6E45-424F-80EC-200DFCE6E66F}']
    function type_: string;
    function fill: ItdBackgroundFill;      //The background fill
    function dark_theme_dimming: Integer;  //Dimming of the background in dark themes, as a percentage; 0-100
  end;

  ItdBackgroundTypeWallpaper = interface(ItdBackgroundType)
    ['{8EC92BCA-6E45-424F-80EC-200DFCE6E66F}']
    function type_: string;
    function document: ItdDocument;
    function dark_theme_dimming: Integer;  //Dimming of the background in dark themes, as a percentage; 0-100
    function is_blurred: Boolean;          //Optional. True, if the wallpaper is downscaled to fit in a 450x450 square and then box-blurred with radius 12
    function is_moving: Boolean;           //Optional. True, if the background moves slightly when the device is tilted
  end;

  ItdBackgroundTypePattern = interface(ItdBackgroundType)
    ['{8EC92BCA-6E45-424F-80EC-200DFCE6E66F}']
    function type_: string;
    function document: ItdDocument;
    function fill: ItdBackgroundFill;      //The background fill
    function intensity: Integer;
    function is_inverted: Boolean;
    function is_moving: Boolean;
  end;

  ItdBackgroundTypeChatTheme = interface(ItdBackgroundType) //Type of the background, always “chat_theme”
    ['{8EC92BCA-6E45-424F-80EC-200DFCE6E66F}']
    function type_: string;
    function theme_name: string; //Name of the chat theme, which is usually an emoji
  end;

  ItdChatBackground = interface
    ['{DCFA1E6D-3238-4F48-8454-E2E5DD0784C0}']
    function type_: ItdBackgroundType;
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
constructor TtdInputMedia.Create(AType: String; AMedia: TtdFileToSend;
  const ACaption: string; AParseMode: String;
  const ACaptionEntities: TArray<ItdMessageEntity>);
begin
  Self.Create(AMedia, ACaption);
  FType := AType;
  FCaption := ACaption;
  FParseMode := AParseMode;
  FCaptionEntities := ACaptionEntities;
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
  string; AWidth, AHeight, ADuration: Integer; ASupportsStreaming: Boolean;
  AHasSpoiler: Boolean);
begin
  inherited Create(AMedia, ACaption);
  FType := 'video';
  FWidth := AWidth;
  FHeight := AHeight;
  FDuration := ADuration;
  FHasSpoiler := AHasSpoiler;
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
{ TtdInputMediaAnimation }

constructor TtdInputMediaAnimation.Create(AMedia: TtdFileToSend;
  const ACaption: string; ADuration: Integer; APerformer: String; ATitle: String);
begin
  inherited Create(AMedia, ACaption);
  FDuration := ADuration;
end;

{ TtdInputMediaDocument }

constructor TtdInputMediaDocument.Create(AMedia: TtdFileToSend;
  const ACaption: string; ADisableContentTypeDetection: Boolean);
begin
  inherited Create(AMedia, ACaption);
  FDisableContentTypeDetection := ADisableContentTypeDetection;
end;

{ TtdInputMediaAudio }

constructor TtdInputMediaAudio.Create(AMedia: TtdFileToSend; const ACaption: string;
      AType: String; AParseMode: String; const ACaptionEntities: TArray<ItdMessageEntity>;
      ADuration: Integer; APerformer: String; ATitle: String);
begin
  inherited Create(AType, AMedia, ACaption, AParseMode, ACaptionEntities);
  FDuration := ADuration;
  FPerformer := APerformer;
  FTitle := ATitle;
end;

End.

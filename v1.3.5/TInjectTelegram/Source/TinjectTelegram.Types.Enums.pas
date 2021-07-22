unit TinjectTelegram.Types.Enums;
interface
type
{$SCOPEDENUMS ON}
  /// <summary>
  ///   Type of action to broadcast.
  /// </summary>
  /// <remarks>
  ///   We only recommend using this method when a response from the bot will
  ///   take a noticeable amount of time to arrive.
  /// </remarks>
  /// <example>
  ///   Example: The ImageBot needs some time to process a request and upload
  ///   the image. Instead of sending a text message along the lines of
  ///   “Retrieving image, please wait…”, the bot may use sendChatAction with
  ///   action = upload_photo. The user will see a “sending photo” status for
  ///   the bot.
  /// </example>
  TtdSendChatAction = (
    /// <summary>
    ///   for text messages
    /// </summary>
    Typing,
    /// <summary>
    ///   for photos
    /// </summary>
    UploadPhoto,
    /// <summary>
    ///   for videos
    /// </summary>
    Record_video,
    /// <summary>
    ///   for videos
    /// </summary>
    UploadVideo,
    /// <summary>
    ///   for audio files
    /// </summary>
    Record_audio,
    /// <summary>
    ///   for audio files
    /// </summary>
    Upload_audio,
    /// <summary>
    ///   for general files
    /// </summary>
    Upload_document,
    /// <summary>
    ///   for location data
    /// </summary>
    Find_location,
    /// <summary>
    ///   for video notes
    /// </summary>
    Record_video_note,
    /// <summary>
    ///   for video notes
    /// </summary>
    Upload_video_note);
  /// <summary>
  ///   ChatMember status
  /// </summary>
  TtdChatMemberStatus = (
    /// <summary>
    ///   Creator of the <see cref="Chat" />
    /// </summary>
    Creator,
    /// <summary>
    ///   Administrator of the <see cref="Chat" />
    /// </summary>
    Administrator,
    /// <summary>
    ///   Normal member of the <see cref="Chat" />
    /// </summary>
    Member, Restricted,
    /// <summary>
    ///   A <see cref="User" /> who left the <see cref="Chat" />
    /// </summary>
    Left,
    /// <summary>
    ///   A <see cref="User" /> who was kicked from the <see cref="Chat" />
    /// </summary>
    Kicked);
  /// <summary>
  ///   Type of a <see cref="Chat" />
  /// </summary>
  ///
  /// Criado por Ruan Diego Lacerda Menezes
  TtdQuizType = (
    /// <summary>
    ///   Define o modo regular <see cref="Pool" />
    /// </summary>
  qtPadrao,
    /// <summary>
    ///   Define o modo regular <see cref="Pool" />
    /// </summary>
  qtRegular,
    /// <summary>
    ///   Define o modo quiz <see cref="Pool" />
    /// </summary>
  qtQuiz);
  /// Criado por Ruan Diego Lacerda Menezes
  { TODO 3 -oRuan Diego -cEmojis :
adicionar os novos
⚰️ 🎃 🧛‍♀️ 🧟‍♂️ 🦇 🕷 🕸 🌜 🌛 or 🗿 }
  TtdEmojiType = (
    /// <summary>
    ///   Define o emoji dice <see cref="Dice" />
    /// </summary>
  etDado,
    /// <summary>
    ///   Define o emoji darts <see cref="Dice" />
    /// </summary>
  etDardo,
    /// <summary>
    ///   Define o emoji BascketBoll <see cref="Dice" />
    /// </summary>
  etBasquete,
    /// <summary>
    ///   Define o emoji FootBall <see cref="Dice" />
    /// </summary>
  etFootball,
    /// <summary>
    ///   Define o emoji Slot Machine <see cref="Dice" />
    /// </summary>
  etSlotMachine,
    /// <summary>
    ///   Define o emoji Bowling <see cref="Dice" />
    /// </summary>
  etBowling);

  TtdChatType = (
    /// <summary>
    ///   Normal one to one <see cref="Chat" />
    /// </summary>
    private,
    /// <summary>
    ///   Normal groupchat
    /// </summary>
    Group,
    /// <summary>
    ///   A channel
    /// </summary>
    Channel,
    /// <summary>
    ///   A supergroup
    /// </summary>
    Supergroup);
  /// <summary>
  ///   Type of a <see cref="FileToSend" />
  /// </summary>
  TtdFileType = (
    /// <summary>
    ///   Unknown FileType
    /// </summary>
    Unknown,
    /// <summary>
    ///   FileStream
    /// </summary>
    Stream,
    /// <summary>
    ///   FileId
    /// </summary>
    Id,
    /// <summary>
    ///   File Url
    /// </summary>
    Url);
  /// <summary>
  ///   The type of a Message
  /// </summary>
  TtdMessageType = (UnknownMessage = 0, TextMessage, PhotoMessage, AudioMessage,
    VideoMessage, VideoNoteMessage, VoiceMessage, DocumentMessage,
    StickerMessage, GameMessage, LocationMessage, ContactMessage, ServiceMessage,
    VenueMessage, DiceMessage, PollMessage, AnimatoinMessage, InvoiceMessage,
    PassportDataMessage);

  /// <summary>
  ///   Text parsing mode
  /// </summary>
  /// <example>
  ///   <para>
  ///     Markdown style
  ///   </para>
  ///   <para>
  ///     *bold text* <br />_italic text_ <br />
  ///     [text](http://www.example.com/) <br />`inline fixed-width code` <br />
  ///      ```text <br />pre-formatted fixed-width code block <br />```
  ///   </para>
  ///   <para>
  ///     Html:
  ///   </para>
  ///   <para>
  ///     &lt;b&gt;bold&lt;/b&gt;, &lt;strong&gt;bold&lt;/strong&gt; <br />
  ///     &lt;i&gt;italic&lt;/i&gt;, &lt;em&gt;italic&lt;/em&gt; <br />&lt;a
  ///     href="http://www.example.com/"&gt;inline URL&lt;/a&gt; <br />
  ///     &lt;code&gt;inline fixed-width code&lt;/code&gt; <br />
  ///     &lt;pre&gt;pre-formatted fixed-width code block&lt;/pre&gt; <br /><br />
  ///   </para>
  /// </example>
  TtdParseMode = (default = 0,
    /// <summary>
    ///   To use this mode, pass Markdown in the parse_mode field when using
    ///   sendMessage
    /// </summary>
    Markdown,
    /// <summary>
    ///   To use this mode, pass MarkdownV2 in the parse_mode field when using
    ///   sendMessage
    /// </summary>
    MarkdownV2,
    /// <summary>
    ///   To use this mode, pass HTML in the parse_mode field when using
    ///   sendMessage
    /// </summary>
    Html);
  /// <summary>
  ///   The type of an Update
  /// </summary>
  TtdUpdateType = (
    /// <summary>
    ///   Update Type is unknown
    /// </summary>
    UnknownUpdate = 0,
    /// <summary>
    ///   The <see cref="Update" /> contains a <see cref="Message" />.
    /// </summary>
    MessageUpdate,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="InlineQuery" />.
    /// </summary>
    InlineQueryUpdate,
    /// <summary>
    ///   The <see cref="Update" /> contains a <see cref="ChosenInlineResult" />
    ///    .
    /// </summary>
    ChosenInlineResultUpdate,
    /// <summary>
    ///   The <see cref="Update" /> contins a <see cref="CallbackQuery" />
    /// </summary>
    CallbackQueryUpdate,
    /// <summary>
    ///   The <see cref="Update" /> contains an edited <see cref="Message" />
    /// </summary>
    EditedMessage,
    /// <summary>
    ///   The <see cref="Update" /> contains a channel post <see cref="Message" />
    /// </summary>
    ChannelPost,
    /// <summary>
    ///   The <see cref="Update" /> contains an edited channel post <see cref="Message" />
    /// </summary>
    EditedChannelPost,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="ShippingQueryUpdate" />
    /// </summary>
    ShippingQueryUpdate,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="PreCheckoutQueryUpdate" />
    /// </summary>
    PreCheckoutQueryUpdate,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="Poll" />
    /// </summary>
    PollState,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="PollAnswer" />
    /// </summary>
    PollAnswer,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="my_chat_member" />
    /// </summary>
    MyChatMember,
    /// <summary>
    ///   The <see cref="Update" /> contains an <see cref="chat_member" />
    /// </summary>
    ChatMember,
    /// <summary>
    ///   Receive all <see cref="Update" /> Types
    /// </summary>
    All = 255);
  /// <summary>
  ///   The type of an EncryptedPassportElement
  /// </summary>
TtdEncryptedPassportElementType = (
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="personal_details" />
    /// </summary>
  personal_details,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="passport" />
    /// </summary>
  passport,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="driver_license" />
    /// </summary>
  driver_license,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="identity_card" />
    /// </summary>
  identity_card,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="internal_passport" />
    /// </summary>
  internal_passport,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="address" />
    /// </summary>
  address,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="utility_bill" />
    /// </summary>
  utility_bill,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="bank_statement" />
    /// </summary>
  bank_statement,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="rental_agreement" />
    /// </summary>
  rental_agreement,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="passport_registration" />
    /// </summary>
  passport_registration,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="temporary_registration" />
    /// </summary>
  temporary_registration,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="phone_number" />
    /// </summary>
  phone_number,
    /// <summary>
    ///   The <see cref="passportdata" /> contains an <see cref="email" />
    /// </summary>
  email);

  /// <summary>
  ///   Type of a <see cref="MessageEntity" />
  /// </summary>
  TtdMessageEntityType = (
    /// <summary>
    ///   A mentioned <see cref="User" />
    /// </summary>
    mention,
    /// <summary>
    ///   A searchable Hashtag
    /// </summary>
    hashtag,
    /// <summary>
    ///   A cashtag
    /// </summary>
    cashtag,
    /// <summary>
    ///   A Bot command
    /// </summary>
    bot_command,
    /// <summary>
    ///   An url
    /// </summary>
    url,
    /// <summary>
    ///   An email
    /// </summary>
    email,
    /// <summary>
    ///   phone_number
    /// </summary>
    phone_number,
    /// <summary>
    ///   Bold text
    /// </summary>
    bold,
    /// <summary>
    ///   Italic text
    /// </summary>
    italic,
    /// <summary>
    ///   underline
    /// </summary>
    underline,
    /// <summary>
    ///   strikethrough
    /// </summary>
    strikethrough,
    /// <summary>
    ///   Monowidth string
    /// </summary>
    code,
    /// <summary>
    ///   Monowidth block
    /// </summary>
    pre,
    /// <summary>
    ///   Clickable text urls
    /// </summary>
    text_link,
    /// <summary>
    ///   Mentions for a <see cref="User" /> without <see cref="User.Username" />
    /// </summary>
    text_mention, N_A);
  /// <summary>
  ///   The part of the face relative to which the mask should be placed. One
  ///   of “forehead”, “eyes”, “mouth”, or “chin”.
  /// </summary>
  TtdMaskPositionPoint = (
    /// <summary>
    ///   The forehead
    /// </summary>
    forehead,
    /// <summary>
    ///   The eyes
    /// </summary>
    eyes,
    /// <summary>
    ///   The mouth
    /// </summary>
    mouth,
    /// <summary>
    ///   The chin
    chin);
  TtdBotCommandScope = (
    /// <summary>
    ///   Represents the default scope of bot commands. Default commands
    ///   are used if no commands with a narrower scope are specified for the user.
    ///   Scope type, must be default
    /// </summary>
    BotCommandScopeDefault,
    /// <summary>
    ///   Represents the scope of bot commands, covering all private chats.
    ///   Scope type, must be all_private_chats
    /// </summary>
    BotCommandScopeAllPrivateChats,
    /// <summary>
    ///   Represents the scope of bot commands, covering all group and
    ///   supergroup chats.
    ///   Scope type, must be all_group_chats
    /// </summary>
    BotCommandScopeAllGroupChats,
    /// <summary>
    ///   Represents the scope of bot commands, covering all group and
    ///   supergroup chat administrators.
    ///   Scope type, must be all_chat_administrators
    /// </summary>
    BotCommandScopeAllChatAdministrators,
    /// <summary>
    ///   Represents the scope of bot commands, covering a specific chat.
    ///   Scope type, must be chat
    /// </summary>
    BotCommandScopeChat,
    /// <summary>
    ///   Represents the scope of bot commands, covering all administrators of
    ///   a specific group or supergroup chat.
    ///   Scope type, must be chat_administrators
    /// </summary>
    BotCommandScopeChatAdministrators,
    /// <summary>
    ///   Scope type, must be chat_member
    ///   Represents the scope of bot commands, covering a
    ///   specific member of a group or supergroup chat.
    /// </summary>
    BotCommandScopeChatMember
  );
  TtdGender = (Male, Female);
  TtdPassportAvaibleData = (PersonalDetails, Passport, InternalPassport,
    DriverLicense, IdentityCard, IdDocument, IdSelfie, Address, UtilityBill,
    BankStatement, RentalAgreement, PassportRegistration, TemporaryRegistration,
    AdressDocument, PhoneNumber, Email);
  TAllowedUpdate = (Message,
    Edited_message, Channel_post, Edited_channel_post,
    Inline_query, Chosen_inline_result, Callback_query,
    ShippingQuery, PreCheckoutQuery, PollState, PollAnswer,
    MyChatMember, ChatMember);
  TAllowedUpdates = set of TAllowedUpdate;
const
  UPDATES_ALLOWED_ALL = [Low(TAllowedUpdate)..High(TAllowedUpdate)];
implementation
end.

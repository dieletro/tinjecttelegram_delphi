unit TinjectTelegram.Types.InlineQueryResults;

interface

uses
  REST.Json.Types,
  TInjectTelegram.Types.ReplyMarkups,
  TInjectTelegram.Types.InputMessageContents,
  TInjectTelegram.Types.Enums;

type

  /// <summary>
  ///   This object represents one result of an inline query. Telegram clients
  ///   currently support results of the following 20 types ///
  /// </summary>
  TtdInlineQueryResult = class abstract
  public
    /// <summary>
    ///   Unique identifier for this result, 1-64 bytes
    /// </summary>
    [JSONName('id')]
    ID: string;
    /// <summary>
    ///   Type of the result
    /// </summary>
    [JSONName('type')]
    &Type: string;
    /// <summary>
    ///   Title of the result
    /// </summary>
    [JSonName('title')]
    Title: String;
    /// <summary>
    /// Optional. Mode for parsing entities in the caption.
    /// See formatting options for more details.
    /// </summary>
    [JSonName('parse_mode')]
    ParseMode: TtdParseMode;
    /// <summary>
    ///   Optional. Inline keyboard attached to the message
    /// </summary>
    [JSonName('input_message_content')]
    InputMessageContent: TtdInputMessageContent;
    /// <summary>
    ///   Optional. Inline keyboard attached to the message
    /// </summary>
    [JSonName('reply_markup')]
    ReplyMarkup: TtdInlineKeyboardMarkup;
    constructor Create;
    destructor Destroy; override;
  end;

  TtdInlineQueryResultNew = class(TtdInlineQueryResult)
  public
    /// <summary>
    ///   Optional. Url of the thumbnail for the result
    /// </summary>
    [JSONName('thumb_url')]
    ThumbUrl: string;
    /// <summary>
    ///   Optional. Thumbnail width
    /// </summary>
    [JSONName('thumb_width')]
    ThumbWidth: Integer;
    /// <summary>
    ///   Optional. Thumbnail height
    /// </summary>
    [JSONName('thumb_height')]
    ThumbHeight: Integer;
  end;

  /// <summary>
  ///   Represents a link to an article or web page.
  /// </summary>
  [JSONName('InlineQueryResultArticle')]
  TtdInlineQueryResultArticle = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   Optional. URL of the result
    /// </summary>
    [JSONName('url')]
    Url: string;
    /// <summary>
    ///   Optional. Pass True, if you don't want the URL to be shown in the
    ///   message
    /// </summary>
    [JSONName('hide_url')]
    HideUrl: Boolean;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to an mp3 audio file. By default, this audio file
  ///   will be sent by the user. Alternatively, you can use
  ///   input_message_content to send a message with the specified content
  ///   instead of the audio.
  /// </summary>
  [JSONName('InlineQueryResultAudio')]
  TtdInlineQueryResultAudio = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   A valid file identifier for the audio file
    /// </summary>
    [JSONName('audio_file_id')]
    FileId: string;
    /// <summary>
    ///   A valid URL for the audio file
    /// </summary>
    [JSONName('audio_url')]
    Url: string;
    /// <summary>
    ///   Optional. Performer
    /// </summary>
    [JSONName('performer')]
    Performer: string;
    /// <summary>
    ///   Optional. Audio duration in seconds
    /// </summary>
    [JSONName('audio_duration')]
    Duration: Integer;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a result stored on the Telegram servers. By
  ///   default, this result will be sent by the user with an optional caption.
  ///   Alternatively, you can use input_message_content to send a message with
  ///   the specified content instead of the photo.
  /// </summary>
  TtdInlineQueryResultCached = class(TtdInlineQueryResult)
    /// <summary>
    ///   Optional. Caption of the result to be sent, 0-200 characters
    /// </summary>
    [JSONName('caption')]
    Caption: string;
  end;

  /// <summary>
  ///   Represents a link to an mp3 audio file stored on the Telegram servers.
  ///   By default, this audio file will be sent by the user. Alternatively,
  ///   you can use input_message_content to send a message with the specified
  ///   content instead of the audio.
  /// </summary>
  [JSONName('InlineQueryResultCachedAudio')]
  TtdInlineQueryResultCachedAudio = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier for the audio file
    /// </summary>
    [JSONName('audio_file_id')]
    FileId: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a file stored on the Telegram servers. By default,
  ///   this file will be sent by the user with an optional caption.
  ///   Alternatively, you can use input_message_content to send a message with
  ///   the specified content instead of the file. Currently, only pdf-files
  ///   and zip archives can be sent using this method.
  /// </summary>
  [JSONName('InlineQueryResultCachedDocument')]
  TTgInlineQueryResultCachedDocument = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier for the file
    /// </summary>
    [JSONName('document_file_id')]
    FileId: string;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to an animated GIF file stored on the Telegram
  ///   servers. By default, this animated GIF file will be sent by the user
  ///   with an optional caption. Alternatively, you can use
  ///   input_message_content to send a message with specified content instead
  ///   of the animation.
  /// </summary>
  [JSONName('InlineQueryResultCachedGif')]
  TtdInlineQueryResultCachedGif = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier for the GIF file
    /// </summary>
    [JSONName('gif_file_id')]
    FileId: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a video animation (H.264/MPEG-4 AVC video without
  ///   sound) stored on the Telegram servers. By default, this animated MPEG-4
  ///   file will be sent by the user with an optional caption. Alternatively,
  ///   you can use input_message_content to send a message with the specified
  ///   content instead of the animation.
  /// </summary>
  [JSONName('InlineQueryResultCachedMpeg4Gif')]
  TtdInlineQueryResultCachedMpeg4Gif = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier for the MP4 file
    /// </summary>
    [JSONName('mpeg4_file_id')]
    FileId: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a photo stored on the Telegram servers. By
  ///   default, this photo will be sent by the user with an optional caption.
  ///   Alternatively, you can use input_message_content to send a message with
  ///   the specified content instead of the photo.
  /// </summary>
  [JSONName('InlineQueryResultCachedPhoto')]
  TtdInlineQueryResultCachedPhoto = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier of the photo
    /// </summary>
    [JSONName('photo_file_id')]
    FileId: string;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a sticker stored on the Telegram servers. By
  ///   default, this sticker will be sent by the user. Alternatively, you can
  ///   use input_message_content to send a message with the specified content
  ///   instead of the sticker.
  /// </summary>
  [JSONName('InlineQueryResultCachedSticker')]
  TtdInlineQueryResultCachedSticker = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier of the sticker
    /// </summary>
    [JSONName('sticker_file_id')]
    FileId: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a video file stored on the Telegram servers. By
  ///   default, this video file will be sent by the user with an optional
  ///   caption. Alternatively, you can use input_message_content to send a
  ///   message with the specified content instead of the video.
  /// </summary>
  [JSONName('InlineQueryResultCachedVideo')]
  TtdInlineQueryResultCachedVideo = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier for the video
    /// </summary>
    [JSONName('video_file_id')]
    FileId: string;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a voice message stored on the Telegram servers. By
  ///   default, this voice message will be sent by the user. Alternatively,
  ///   you can use input_message_content to send a message with the specified
  ///   content instead of the voice message.
  /// </summary>
  [JSONName('InlineQueryResultCachedVoice')]
  TtdInlineQueryResultCachedVoice = class(TtdInlineQueryResultCached)
  public
    /// <summary>
    ///   A valid file identifier for the voice message
    /// </summary>
    [JSONName('voice_file_id')]
    FileId: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a contact with a phone number. By default, this contact will
  ///   be sent by the user. Alternatively, you can use input_message_content
  ///   to send a message with the specified content instead of the contact.
  /// </summary>
  [JSONName('InlineQueryResultContact')]
  TtdInlineQueryResultContact = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   Contact's phone number
    /// </summary>
    [JSONName('phone_number')]
    PhoneNumber: string;
    /// <summary>
    ///   Contact's first name
    /// </summary>
    [JSONName('first_name')]
    FirstName: string;
    /// <summary>
    ///   Optional. Contact's last name
    /// </summary>
    [JSONName('last_name')]
    LastName: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a file. By default, this file will be sent by the
  ///   user with an optional caption. Alternatively, you can use
  ///   input_message_content to send a message with the specified content
  ///   instead of the file. Currently, only .PDF and .ZIP files can be sent
  ///   using this method.
  /// </summary>
  [JSONName('InlineQueryResultDocument')]
  TtdInlineQueryResultDocument = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   Optional. Caption of the document to be sent, 0-200 characters
    /// </summary>
    [JSONName('caption')]
    Caption: string;
    /// <summary>
    ///   A valid URL for the file
    /// </summary>
    [JSONName('document_url')]
    Url: string;
    /// <summary>
    ///   Mime type of the content of the file, either �application/pdf� or
    ///   �application/zip�
    /// </summary>
    [JSONName('mime_type')]
    MimeType: string;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    constructor Create;
  end;

  TtdInlineQueryResultGame = class
  public
    /// <summary>
    /// Type of the result, must be game
    /// </summary>
    [JSONName('type')]
    &type: String;
    /// <summary>
    /// Unique identifier for this result, 1-64 bytes
    /// </summary>
    [JSONName('id')]
    id: String;
    /// <summary>
    ///   Short name of the game.
    /// </summary>
    [JSONName('game_short_name')]
    GameShortName: String;
    /// <summary>
    /// Optional. Inline keyboard attached to the message
    /// </summary>
    [JSONName('reply_markup')]
    reply_markup: TtdInlineKeyboardMarkup;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to an animated GIF file. By default, this animated
  ///   GIF file will be sent by the user with optional caption. Alternatively,
  ///   you can use input_message_content to send a message with the specified
  ///   content instead of the animation.
  /// </summary>
  [JSONName('InlineQueryResultGif')]
  TtdInlineQueryResultGif = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   A valid URL for the GIF file. File size must not exceed 1MB
    /// </summary>
    [JSONName('gif_url')]
    Url: string;
    /// <summary>
    ///   Optional. Width of the GIF
    /// </summary>
    [JSONName('gif_width')]
    Width: Integer;
    /// <summary>
    ///   Optional. Height of the GIF
    /// </summary>
    [JSONName('gif_height')]
    Height: Integer;
    /// <summary>
    ///   Optional. Duration of the GIF
    /// </summary>
    [JSONName('gif_duration')]
    Duration: Integer;
    /// <summary>
    ///   Optional. Caption of the GIF file to be sent, 0-200 characters
    /// </summary>
    [JSONName('caption')]
    Caption: string;
    /// <summary>
    ///   URL of the static thumbnail for the result (jpeg or gif)
    /// </summary>
    [JSONName('thumb_url')]
    ThumbUrl: string;
    /// <summary>
    /// Optional. MIME type of the thumbnail, must be one of
    /// �image/jpeg�, �image/gif�, or �video/mp4�.
    /// Defaults to �image/jpeg�
    /// </summary>
    [JSONName('thumb_mime_type')]
    ThumbMimeType: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a location on a map. By default, the location will be sent
  ///   by the user. Alternatively, you can use input_message_content to send a
  ///   message with the specified content instead of the location.
  /// </summary>
  [JSONName('InlineQueryResultLocation')]
  TtdInlineQueryResultLocation = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   Location latitude in degrees
    /// </summary>
    [JSONName('latitude')]
    Latitude: Single;
    /// <summary>
    ///   Location longitude in degrees
    /// </summary>
    [JSONName('longitude')]
    Longitude: Single;
    /// <summary>
    ///   The direction in which user is moving, in degrees; 1-360.
    ///   For active live locations only.
    /// </summary>
    [JSONName('heading')]
    Heading : Integer;
    /// <summary>
    ///   The radius of uncertainty for the location, measured in meters; 0-1500
    /// </summary>
    [JSONName('horizontal_accuracy')]
    HorizontalAccuracy : Single;
    /// <summary>
    ///   Period in seconds for which the location can be updated,
    ///   should be between 60 and 86400.
    /// </summary>
    [JSONName('live_period')]
    LivePeriod : Integer;
    /// <summary>
    ///   For live locations, a maximum distance for proximity alerts about
    ///   approaching another chat member, in meters.
    ///   Must be between 1 and 100000 if specified.
    /// </summary>
    [JSONName('proximity_alert_radius')]
    ProximityAlertRadius : Integer;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a video animation (H.264/MPEG-4 AVC video without
  ///   sound). By default, this animated MPEG-4 file will be sent by the user
  ///   with optional caption. Alternatively, you can use input_message_content
  ///   to send a message with the specified content instead of the animation.
  /// </summary>
  [JSONName('InlineQueryResultMpeg4Gif')]
  TtdInlineQueryResultMpeg4Gif = class(TtdInlineQueryResult)
  public
    /// <summary>
    ///   A valid URL for the MP4 file. File size must not exceed 1MB
    /// </summary>
    [JSONName('mpeg4_url')]
    Url: string;
    /// <summary>
    ///   Optional. Video width
    /// </summary>
    [JSONName('mpeg4_width')]
    Width: Integer;
    /// <summary>
    ///   Optional. Video height
    /// </summary>
    [JSONName('mpeg4_height')]
    Height: Integer;
    /// <summary>
    ///   Optional. Video height
    /// </summary>
    [JSONName('mpeg4_duration')]
    Duration: Integer;
    /// <summary>
    /// Optional. MIME type of the thumbnail, must be one of
    /// �image/jpeg�, �image/gif�, or �video/mp4�.
    /// Defaults to �image/jpeg�
    /// </summary>
    [JSONName('thumb_mime_type')]
    ThumbMimeType: string;
    /// <summary>
    ///   Optional. Caption of the MPEG-4 file to be sent, 0-200 characters
    /// </summary>
    [JSONName('caption')]
    Caption: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a photo. By default, this photo will be sent by
  ///   the user with optional caption. Alternatively, you can use
  ///   input_message_content to send a message with the specified content
  ///   instead of the photo.
  /// </summary>
  [JSONName('InlineQueryResultPhoto')]
  TtdInlineQueryResultPhoto = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   A valid URL of the photo. Photo must be in jpeg format. Photo size
    ///   must not exceed 5MB
    /// </summary>
    [JSONName('photo_url')]
    Url: string;
    /// <summary>
    ///   Optional. Width of the photo
    /// </summary>
    [JSONName('photo_width')]
    Width: Integer;
    /// <summary>
    ///   Optional. Height of the photo
    /// </summary>
    [JSONName('photo_height')]
    Height: Integer;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    /// <summary>
    ///   Optional. Caption of the photo to be sent, 0-200 characters
    /// </summary>
    [JSONName('caption')]
    Caption: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a venue. By default, the venue will be sent by the user.
  ///   Alternatively, you can use input_message_content to send a message with
  ///   the specified content instead of the venue.
  /// </summary>
  [JSONName('InlineQueryResultVenue')]
  TtdInlineQueryResultVenue = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   Latitude of the venue location in degrees
    /// </summary>
    [JSONName('latitude')]
    Latitude: Single;
    /// <summary>
    ///   Longitude of the venue location in degrees
    /// </summary>
    [JSONName('longitude')]
    Longitude: Single;
    /// <summary>
    ///   Address of the venue
    /// </summary>
    [JSONName('address')]
    Address: string;
    /// <summary>
    ///   Optional. Foursquare identifier of the venue if known
    /// </summary>
    [JSONName('foursquare_id')]
    FoursquareId: string;
    /// <summary>
    ///   Optional. Google Place Id
    /// </summary>
    [JSONName('google_place_id')]
    GooglePlaceId: string;
    /// <summary>
    ///   Optional. Google Place Type
    /// </summary>
    [JSONName('google_place_type')]
    GooglePlaceType : string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a page containing an embedded video player or a
  ///   video file. By default, this video file will be sent by the user with
  ///   an optional caption. Alternatively, you can use input_message_content
  ///   to send a message with the specified content instead of the video.
  /// </summary>
  [JSONName('InlineQueryResultVideo')]
  TtdInlineQueryResultVideo = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   A valid URL for the embedded video player or video file
    /// </summary>
    [JSONName('video_url')]
    Url: string;
    /// <summary>
    ///   Mime type of the content of video url, �text/html� or �video/mp4�
    /// </summary>
    [JSONName('mime_type')]
    MimeType: string;
    /// <summary>
    ///   Optional. Video width
    /// </summary>
    [JSONName('video_width')]
    Width: Integer;
    /// <summary>
    ///   Optional. Video height
    /// </summary>
    [JSONName('video_height')]
    Height: Integer;
    /// <summary>
    ///   Optional. Video duration in seconds
    /// </summary>
    [JSONName('video_duration')]
    Duration: Integer;
    /// <summary>
    ///   Optional. Short description of the result
    /// </summary>
    [JSONName('description')]
    Description: string;
    /// <summary>
    ///   Optional. Caption of the video to be sent, 0-200 characters
    /// </summary>
    [JSONName('caption')]
    Caption: string;
    constructor Create;
  end;

  /// <summary>
  ///   Represents a link to a voice recording in an .ogg container encoded
  ///   with OPUS. By default, this voice recording will be sent by the user.
  ///   Alternatively, you can use input_message_content to send a message with
  ///   the specified content instead of the the voice message.
  /// </summary>
  [JSONName('InlineQueryResultVoice')]
  TtdInlineQueryResultVoice = class(TtdInlineQueryResultNew)
  public
    /// <summary>
    ///   A valid URL for the voice recording
    /// </summary>
    [JSONName('voice_url')]
    Url: string;
    /// <summary>
    ///   Optional. Recording duration in seconds
    /// </summary>
    [JSONName('voice_duration')]
    Duration: Integer;
    constructor Create;
  end;

implementation

uses
  System.SysUtils;

{ TtdInlineQueryResult }

constructor TtdInlineQueryResult.Create;
begin
  InputMessageContent := TtdInputMessageContent.Create;
  ReplyMarkup := TtdInlineKeyboardMarkup.Create;
end;

destructor TtdInlineQueryResult.Destroy;
begin
  FreeAndNil(ReplyMarkup);
  FreeAndNil(InputMessageContent);
  inherited;
end;

{ TtdInlineQueryResultArticle }

constructor TtdInlineQueryResultArticle.Create;
begin
  inherited;
  &Type := 'article';
end;

{ TtdInlineQueryResultAudio }

constructor TtdInlineQueryResultAudio.Create;
begin
  inherited;
  &Type := 'audio';
end;

{ TtdInlineQueryResultCachedAudio }

constructor TtdInlineQueryResultCachedAudio.Create;
begin
  inherited;
  &Type := 'audio';
end;

{ TTgInlineQueryResultCachedDocument }

constructor TTgInlineQueryResultCachedDocument.Create;
begin
  inherited;
  &Type := 'document';
end;

{ TtdInlineQueryResultCachedGif }

constructor TtdInlineQueryResultCachedGif.Create;
begin
  inherited;
  &Type := 'gif';
end;

{ TtdInlineQueryResultCachedMpeg4Gif }

constructor TtdInlineQueryResultCachedMpeg4Gif.Create;
begin
  inherited;
  &Type := 'mpeg4_gif';
end;

{ TtdInlineQueryResultCachedPhoto }

constructor TtdInlineQueryResultCachedPhoto.Create;
begin
  inherited;
  &Type := 'photo';
end;

{ TtdInlineQueryResultCachedSticker }

constructor TtdInlineQueryResultCachedSticker.Create;
begin
  inherited;
  &Type := 'sticker';
end;

{ TtdInlineQueryResultCachedVideo }

constructor TtdInlineQueryResultCachedVideo.Create;
begin
  inherited;
  &Type := 'video';
end;

{ TtdInlineQueryResultCachedVoice }

constructor TtdInlineQueryResultCachedVoice.Create;
begin
  inherited;
  &Type := 'voice';
end;

{ TtdInlineQueryResultContact }

constructor TtdInlineQueryResultContact.Create;
begin
  inherited;
  &Type := 'contact';
end;

{ TtdInlineQueryResultDocument }

constructor TtdInlineQueryResultDocument.Create;
begin
  inherited;
  &Type := 'document';
end;

{ TtdInlineQueryResultGame }

constructor TtdInlineQueryResultGame.Create;
begin
  inherited;
  &Type := 'document';
end;

{ TtdInlineQueryResultGif }

constructor TtdInlineQueryResultGif.Create;
begin
  inherited;
  &Type := 'gif';
end;

{ TtdInlineQueryResultLocation }

constructor TtdInlineQueryResultLocation.Create;
begin
  inherited;
  &Type := 'location';
end;

{ TtdInlineQueryResultMpeg4Gif }

constructor TtdInlineQueryResultMpeg4Gif.Create;
begin
  inherited;
  &Type := 'mpeg4_gif';
end;

{ TtdInlineQueryResultPhoto }

constructor TtdInlineQueryResultPhoto.Create;
begin
  inherited;
  &Type := 'photo';
end;

{ TtdInlineQueryResultVenue }

constructor TtdInlineQueryResultVenue.Create;
begin
  inherited;
  &Type := 'venue';
end;

{ TtdInlineQueryResultVideo }

constructor TtdInlineQueryResultVideo.Create;
begin
  inherited;
  &Type := 'video';
end;

{ TtdInlineQueryResultVoice }

constructor TtdInlineQueryResultVoice.Create;
begin
  inherited;
  &Type := 'voice';
end;

end.

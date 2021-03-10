unit TinjectTelegram.Types.InputMessageContents;

interface

uses
  REST.Json.Types;

type
  /// <summary>
  ///   This object represents the content of a message to be sent as a result
  ///   of an inline query.
  /// </summary>
  TtdInputMessageContent = class(TObject);

  /// <summary>
  ///   Represents the content of a contact message to be sent as the result of
  ///   an inline query.
  /// </summary>
  TtdInputContactMessageContent = class(TtdInputMessageContent)
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
    constructor Create(const APhoneNumber, AFirstName, ALastName: string);
  end;

  /// <summary>
  ///   Represents the content of a location message to be sent as the result
  ///   of an inline query.
  /// </summary>
  TtdInputLocationMessageContent = class(TtdInputMessageContent)
  public
    /// <summary>
    ///   Latitude of the location in degrees
    /// </summary>
    [JSONName('latitude')]
    Latitude: Single;
    /// <summary>
    ///   Longitude of the location in degrees
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
    constructor Create(ALatitude, ALongitude: Single);
  end;

  /// <summary>
  ///   Represents the content of a text message to be sent as the result of an
  ///   inline query.
  /// </summary>
  TtdInputTextMessageContent = class(TtdInputMessageContent)
  public
    /// <summary>
    ///   Text of the message to be sent, 1-4096 characters
    /// </summary>
    [JSONName('message_text')]
    MessageText: string;
    /// <summary>
    ///   Optional. Send Markdown or HTML, if you want Telegram apps to show
    ///   bold, italic, fixed-width text or inline URLs in your bot's message.
    /// </summary>
    [JSONName('parse_mode')]
    ParseMode: string;
    /// <summary>
    ///   Optional. Disables link previews for links in the sent message
    /// </summary>
    [JSONName('disable_web_page_preview')]
    DisableWebPagePreview: Boolean;
    constructor Create(const AMessageText, AParseMode: string;
      ADisableWebPagePreview: Boolean);
  end;

  /// <summary>
  ///   Represents the content of a venue message to be sent as the result of
  ///   an inline query.
  /// </summary>
  TtdInputVenueMessageContent = class(TtdInputMessageContent)
  public
    /// <summary>
    ///   Latitude of the venue in degrees
    /// </summary>
    [JSONName('latitude')]
    Latitude: Single;
    /// <summary>
    ///   Longitude of the venue in degrees
    /// </summary>
    [JSONName('longitude')]
    Longitude: Single;
    /// <summary>
    ///   Name of the venue
    /// </summary>
    [JSONName('title')]
    Title: string;
    /// <summary>
    ///   Address of the venue
    /// </summary>
    [JSONName('address')]
    Address: string;
    /// <summary>
    ///   Optional. Foursquare identifier of the venue, if known
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
    constructor Create(ALatitude, ALongitude: Single; const ATitle, AAddress,
      AFoursquareId: string);
  end;

implementation

{ TtdInputTextMessageContent }

constructor TtdInputTextMessageContent.Create(const AMessageText, AParseMode:
  string; ADisableWebPagePreview: Boolean);
begin
  inherited Create;
  MessageText := AMessageText;
  ParseMode := AParseMode;
  DisableWebPagePreview := ADisableWebPagePreview;
end;

{ TtdInputContactMessageContent }

constructor TtdInputContactMessageContent.Create(const APhoneNumber, AFirstName,
  ALastName: string);
begin
  inherited Create;
  PhoneNumber := APhoneNumber;
  FirstName := AFirstName;
  LastName := ALastName;
end;

{ TtdInputLocationMessageContent }

constructor TtdInputLocationMessageContent.Create(ALatitude, ALongitude: Single);
begin
  inherited Create;
  Latitude := ALatitude;
  Longitude := ALongitude;
end;

{ TtdInputVenueMessageContent }

constructor TtdInputVenueMessageContent.Create(ALatitude, ALongitude: Single;
  const ATitle, AAddress, AFoursquareId: string);
begin
  inherited Create;
  Latitude := ALatitude;
  Longitude := ALongitude;
  Title := ATitle;
  Address := AAddress;
  FoursquareId := AFoursquareId;
end;

end.


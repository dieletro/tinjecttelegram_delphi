unit TinjectTelegram.Types.InputMessageContents;
interface
uses
  REST.Json.Types,
  TinjectTelegram.Types;
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
    ///   Optional. entities
    /// </summary>
    [JSONName('entities')]
    Entities: TArray<ItdMessageEntity>;
    /// <summary>
    ///   Optional. link_preview_options
    /// </summary>
    [JSONName('link_preview_options')]
    link_preview_options: ItdLinkPreviewOptions;
    constructor Create(const AMessageText, AParseMode: string;
      AEntities: TArray<ItdMessageEntity>;
      link_preview_options: ItdLinkPreviewOptions);
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

  /// <summary>
  ///   Represents the content of an invoice message to be sent as the result
  ///   of an inline query.
  /// </summary>
  TtdInputInvoiceMessageContent = class(TtdInputMessageContent)
  public
    /// <summary>
    ///   Product name, 1-32 characters
    /// </summary>
    [JSONName('title')]
    Title:	String;

    /// <summary>
    ///   Product description, 1-255 characters
    /// </summary>
    [JSONName('description')]
    Description:	String;

    /// <summary>
    ///   Bot-defined invoice payload, 1-128 bytes.
    ///   This will not be displayed to the user, use for
    ///   your internal processes.
    /// </summary>
    [JSONName('payload')]
    Payload:	String;

    /// <summary>
    ///   Payment provider token, obtained via Botfather
    /// </summary>
    [JSONName('provider_token')]
    ProviderToken:	String;

    /// <summary>
    ///   Three-letter ISO 4217 currency code, see more on currencies
    ///   https://core.telegram.org/bots/payments#supported-currencies
    /// </summary>
    [JSONName('currency')]
    Currency:	String;

    /// <summary>
    ///   Price breakdown, a JSON-serialized list of
    ///   components (e.g. product price, tax, discount,
    ///   delivery cost, delivery tax, bonus, etc.)
    /// </summary>
    [JSONName('prices')]
    Prices:	TArray<ItdLabeledPrice>;

    /// <summary>
    ///   Optional. The maximum accepted amount for tips in
    ///   the smallest units of the currency (integer, not
    ///   float/double). For example, for a maximum tip of
    ///   US$ 1.45 pass max_tip_amount = 145. See the exp
    ///   parameter in currencies.json, it shows the number
    ///   of digits past the decimal point for each currency
    ///   (2 for the majority of currencies). Defaults to 0
    /// </summary>
    [JSONName('max_tip_amount')]
    MaxTipAmount:	Integer;

    /// <summary>
    ///   Optional. A JSON-serialized array of suggested
    ///   amounts of tip in the smallest units of the
    ///   currency (integer, not float/double). At most 4
    ///   suggested tip amounts can be specified. The
    ///   suggested tip amounts must be positive, passed in
    ///   a strictly increased order and must not exceed
    ///   max_tip_amount.
    /// </summary>
    [JSONName('suggested_tip_amounts')]
    SuggestedTipAmounts:	TArray<Integer>;

    /// <summary>
    ///   Optional. A JSON-serialized object for data about
    ///   the invoice, which will be shared with the payment
    ///   provider. A detailed description of the required
    ///   fields should be provided by the payment provider.
    /// </summary>
    [JSONName('provider_data')]
    ProviderData:	String;

    /// <summary>
    ///   Optional. URL of the product photo for the invoice.
    ///   Can be a photo of the goods or a marketing image for
    ///   a service. People like it better when they see what
    ///   they are paying for.
    /// </summary>
    [JSONName('photo_url')]
    PhotoUrl:	String;

    /// <summary>
    ///   Optional. Photo size.
    /// </summary>
    [JSONName('photo_size')]
    PhotoSize:	Integer;

    /// <summary>
    ///   Optional. Photo width.
    /// </summary>
    [JSONName('photo_width')]
    PhotoWidth:	Integer;

    /// <summary>
    ///   Optional. Photo height.
    /// </summary>
    [JSONName('photo_height')]
    PhotoHeight:	Integer;

    /// <summary>
    ///   Optional. Pass True, if you require the user's
    ///   full name to complete the order
    /// </summary>
    [JSONName('need_name')]
    NeedName:	Boolean;

    /// <summary>
    ///   Optional. Pass True, if you require the user's
    ///   phone number to complete the order
    /// </summary>
    [JSONName('need_phone_number')]
    NeedPhoneNumber:	Boolean;

    /// <summary>
    ///   Optional. Pass True, if you require the user's
    ///   email to complete the order
    /// </summary>
    [JSONName('need_email')]
    NeedEmail:	Boolean;

    /// <summary>
    ///   Optional. Pass True, if you require the user's
    ///   shipping address to complete the order
    /// </summary>
    [JSONName('need_shipping_address')]
    NeedShippingAddress:	Boolean;

    /// <summary>
    ///   Optional. Pass True, if user's phone number
    ///   should be sent to provider.
    /// </summary>
    [JSONName('send_phone_number_to_provider')]
    SendPhoneNumberToProvider:	Boolean;

    /// <summary>
    ///   Optional. Pass True, if user's email address
    ///   should be sent to provider.
    /// </summary>
    [JSONName('send_email_to_provider')]
    SendEmailToProvider:	Boolean;

    /// <summary>
    ///   Optional. Pass True, if the final price depends
    ///   on the shipping method.
    /// </summary>
    [JSONName('is_flexible')]
    IsFlexible:	Boolean;
  end;
implementation
{ TtdInputTextMessageContent }
constructor TtdInputTextMessageContent.Create(const AMessageText,
  AParseMode: string; AEntities: TArray<ItdMessageEntity>;
  link_preview_options: ItdLinkPreviewOptions);
begin
  inherited Create;
  MessageText := AMessageText;
  ParseMode := AParseMode;
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

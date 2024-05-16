unit CrossUrl.HttpClient;

interface

uses
  System.Classes,
  System.SysUtils;

type
  TcuProxy = record
  private
    FHost: string;
    FPort: Integer;
    FUserName: string;
    FPassword: string;
  public
    constructor Create(const AHost: string; APort: Integer; const AUserName:
      string = ''; const APassword: string = '');
    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
  end;

  IcuUri = interface
    ['{46DF4232-C572-45F8-8CAB-86096F32FA66}']
    function GetScheme: string;
    procedure SetScheme(const Value: string);
    property Scheme: string read GetScheme write SetScheme;
  end;

  IcuMultipartFormData = interface
    ['{C1FEF918-67B9-4503-B67F-AD942F16FEB3}']
    function GetStream: TStream;
    //
    procedure AddField(const AField, AValue: string);
    procedure AddFile(const AFieldName, AFilePath: string);
    /// <summary>
    /// Add a form data Stream
    /// </summary>
    /// <param name="AFieldName">
    /// Field Name
    /// </param>
    /// <param name="Data">
    /// Stream
    /// </param>
    /// <param name="AFileName">
    /// file name: "File.ext"
    /// </param>
    procedure AddStream(const AFieldName: string; Data: TStream; const AFileName:
      string = '');
    property Stream: TStream read GetStream;
  end;

  IcuHttpResponse = interface
    ['{44F74F9B-CCD2-475E-95E0-02DA30AC749D}']
    //private
    function GetStatusCode: Integer;
    function GetStatusText: string;
    function GetContentStream: TStream;
    //public
    property StatusText: string read GetStatusText;
    property StatusCode: Integer read GetStatusCode;
    property ContentStream: TStream read GetContentStream;
    function ContentAsString(const AnEncoding: TEncoding = nil): string;
  end;

  IcuHttpClient = interface
    ['{EB3348C4-5651-4BAB-988D-A28794FEB149}']
    function GetProxy: TcuProxy;
    procedure SetProxy(const AProxy: TcuProxy);
    //
    function CreateMultipartFormData: IcuMultipartFormData;
    function Get(const AUrl: string): IcuHttpResponse;
    function Post(const AURL: string; const ASource: IcuMultipartFormData):
      IcuHttpResponse;
    property Proxy: TcuProxy read GetProxy write SetProxy;
  end;

implementation

{ TcuProxy }

constructor TcuProxy.Create(const AHost: string; APort: Integer; const AUserName,
  APassword: string);
begin
  FHost := AHost;
  FPort := APort;
  FUserName := AUserName;
  FPassword := APassword;
end;

end.


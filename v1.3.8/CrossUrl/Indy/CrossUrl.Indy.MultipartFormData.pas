unit CrossUrl.Indy.MultipartFormData;

interface

uses
  IdMultipartFormData,
  CrossUrl.HttpClient,
  System.Classes;

type
  TcuMultipartFormDataIndy = class(TInterfacedObject, IcuMultipartFormData)
  private
    FFormData: TIdMultiPartFormDataStream;
  public
    function GetCore: TIdMultiPartFormDataStream;
    constructor Create;
    procedure AddField(const AField: string; const AValue: string);
    procedure AddFile(const AFieldName: string; const AFilePath: string);
    destructor Destroy; override;
    function GetStream: TStream;
    procedure AddStream(const AFieldName: string; Data: TStream; const AFileName:
      string = '');
  end;

implementation

uses
  System.IOUtils,
  System.SysUtils;

{ TcuMultipartFormDataSysNet }

procedure TcuMultipartFormDataIndy.AddField(const AField, AValue: string);
begin
  FFormData.AddFormField(AField, AValue);
end;

procedure TcuMultipartFormDataIndy.AddFile(const AFieldName, AFilePath: string);
begin
  FFormData.AddFile(AFieldName, AFilePath);
end;

procedure TcuMultipartFormDataIndy.AddStream(const AFieldName: string; Data:
  TStream; const AFileName: string);
var
  LFileStream: TFileStream;
  LTmpDir: string;
  LTmpFilename: string;
begin
    //get filename for tmp folder e.g. ..\AppData\local\temp\4F353A8AC6AB446D9F592A30B157291B
  LTmpDir := IncludeTrailingPathDelimiter(TPath.GetTempPath) + TPath.GetGUIDFileName
    (false);
  LTmpFilename := IncludeTrailingPathDelimiter(LTmpDir) + ExtractFileName(AFileName);
  try
    TDirectory.CreateDirectory(LTmpDir);
    try
      LFileStream := TFileStream.Create(LTmpFilename, fmCreate);
      try
        LFileStream.CopyFrom(Data, 0);
      finally
        LFileStream.Free;
      end;
      AddFile(AFieldName, LTmpFilename);
    finally
      TFile.Delete(LTmpFilename);
    end;
  finally
    TDirectory.Delete(LTmpDir);
  end;
end;

constructor TcuMultipartFormDataIndy.Create;
begin
  FFormData := TIdMultiPartFormDataStream.Create;
end;

destructor TcuMultipartFormDataIndy.Destroy;
begin
  FFormData.Free;
  inherited;
end;

function TcuMultipartFormDataIndy.GetCore: TIdMultiPartFormDataStream;
begin
  Result := FFormData;
end;

function TcuMultipartFormDataIndy.GetStream: TStream;
begin
  result := FFormData;
end;

end.


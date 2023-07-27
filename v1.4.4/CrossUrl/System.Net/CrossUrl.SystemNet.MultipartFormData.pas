unit CrossUrl.SystemNet.MultipartFormData;

interface

uses
  System.Net.Mime,
  CrossUrl.HttpClient,
  System.Classes;

type
  TcuMultipartFormDataSysNet = class(TInterfacedObject, IcuMultipartFormData)
  private
    FFormData: TMultipartFormData;
  public
    function GetCore: TMultipartFormData;
    constructor Create;
    procedure AddField(const AField: string; const AValue: string);
    procedure AddFile(const AFieldName: string; const AFilePath: string);
    destructor Destroy; override;
    procedure AddStream(const AFieldName: string; Data: TStream; const AFileName:
      string = '');
    function GetStream: TStream;
  end;

implementation

uses
  System.IOUtils,
  System.SysUtils;

{ TcuMultipartFormData }

procedure TcuMultipartFormDataSysNet.AddField(const AField, AValue: string);
begin
  FFormData.AddField(AField, AValue);
end;

procedure TcuMultipartFormDataSysNet.AddFile(const AFieldName, AFilePath: string);
begin
  FFormData.AddFile(AFieldName, AFilePath);
end;

procedure TcuMultipartFormDataSysNet.AddStream(const AFieldName: string; Data:
  TStream; const AFileName: string);
var
  LFileStream: TFileStream;
  LTmpDir: string;
  LTmpFilename: string;
begin
  // get filename for tmp folder e.g. ..\AppData\local\temp\4F353A8AC6AB446D9F592A30B157291B
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

constructor TcuMultipartFormDataSysNet.Create;
begin
  FFormData := TMultipartFormData.Create;
end;

destructor TcuMultipartFormDataSysNet.Destroy;
begin
  FFormData.Free;
  inherited;
end;

function TcuMultipartFormDataSysNet.GetCore: TMultipartFormData;
begin
  Result := FFormData;
end;

function TcuMultipartFormDataSysNet.GetStream: TStream;
begin
  Result := FFormData.Stream;
end;

end.


unit TelegAPI.Types.Passport;

interface

uses
  TelegaPi.Types.Enums;

type
  ItgPersonalDetails = interface
    ['{F77CD641-E826-40C2-B0C3-4EFBB6779555}']
    function FirstName: string;
    function LastName: string;
    function BirthDate: TDate;
    function Gender: TtgGender;
    function CountryCode: string;
    function ResidenceCountryCode: string;
  end;

  ItgResidentialAdress = interface
    ['{C7738CB9-9D6C-4635-9E78-657435238F76}']
    function StreetLine1: string;
    function StreetLine2: string;
    function City: string;
    function State: string;
    function CountryCode: string;
    function PostCode: string;
  end;

  ItgIdDocumentData = interface
    ['{DF2A60A9-7D1D-424F-9001-D7F9E6390D1F}']
    function DocumentNo: string;
    function ExpiryDate: TDate;
  end;

  ItgPassportFile = interface
    ['{17077F10-C8AE-462B-B11D-9C04B24D5327}']
    function file_id: string;
    function file_unique_id: string;
    function file_size: Integer;
    function file_date: Integer;
  end;

  ItgEncryptedPassportElement = interface
    ['{17D1FDC0-B494-40A8-AB94-0E72681F9EFB}']
    function &type : string;
    function data: string;
    function phone_number: string;
    function email: string;
    function files: TArray<ItgPassportFile>;
    function front_side: ItgPassportFile;
    function reverse_side: ItgPassportFile;
    function selfie: ItgPassportFile;
    function translation: TArray<ItgPassportFile>;
    function hash: string;
  end;

  ItgEncryptedCredentials = interface
    ['{48DD05EB-FD11-49C9-825B-75C8C3967A41}']
    function Data: String;
    function Hash: String;
    function Secret: String;
  end;

  ItgPassportData = interface
    ['{CB0B44FB-44D9-4BEC-9465-873C88DF9C67}']
    function Data: TArray<ItgEncryptedPassportElement>;
    function Credentials : ItgEncryptedCredentials;
  end;

  ItgPassportElementError = interface
    ['{7D48435F-5C65-40A1-B16E-309EEA297082}']
    function Source: String;
    function &Type: String;
    function message: String;
  end;

  ItgPassportElementErrorDataField = interface(ItgPassportElementError)
    ['{43CAAB75-E121-46E6-BC63-8714B87027B8}']
    function FieldName: String;
    function DataHash: String;
  end;

  ItgPassportElementErrorFrontSide = interface(ItgPassportElementError)
    ['{8C3C2F4A-4E81-455A-BBA7-A9D56F21F4C3}']
    function FileHash: String;
  end;

  ItgPassportElementErrorReverseSide = interface(ItgPassportElementError)
    ['{E487FE0E-5DBE-4D34-A91C-9EF40B4512ED}']
    function FileHash: String;
  end;

  ItgPassportElementErrorSelfie = interface(ItgPassportElementError)
    ['{B504BB81-ECAD-4402-844F-8B715A6C84C6}']
    function FileHash: String;
  end;

  ItgPassportElementErrorFile = interface(ItgPassportElementError)
    ['{EF409AF3-102E-4877-8066-98CBE5BDEA1B}']
    function FileHash: String;
  end;

  ItgPassportElementErrorFiles = interface(ItgPassportElementError)
    ['{5CE829D4-6FE0-45B7-95F8-30E5E763568E}']
    function FileHashes: TArray<String>;
  end;

  ItgPassportElementErrorTranslationFile = interface(ItgPassportElementError)
    ['{0CD91880-C6C5-42F8-8554-0343970A5EFC}']
    function FileHash: String;
  end;

  ItgPassportElementErrorTranslationFiles = interface(ItgPassportElementError)
    ['{0B94CFC6-F3AC-43D5-B8C3-E11DF85CCD31}']
    function FileHashes: TArray<String>;
  end;

  ItgPassportElementErrorUnspecified = interface(ItgPassportElementError)
    ['{8670B86C-A54D-4A14-A686-8E164C3A8D9E}']
    function ElementHash: String;
  end;

implementation

end.


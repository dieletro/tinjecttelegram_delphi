unit TinjectTelegram.Types.Passport;

interface

uses
  TInjectTelegram.Types.Enums;

type
  ItdPersonalDetails = interface
    ['{F77CD641-E826-40C2-B0C3-4EFBB6779555}']
    function FirstName: string;
    function LastName: string;
    function BirthDate: TDate;
    function Gender: TtdGender;
    function CountryCode: string;
    function ResidenceCountryCode: string;
  end;

  ItdResidentialAdress = interface
    ['{C7738CB9-9D6C-4635-9E78-657435238F76}']
    function StreetLine1: string;
    function StreetLine2: string;
    function City: string;
    function State: string;
    function CountryCode: string;
    function PostCode: string;
  end;

  ItdIdDocumentData = interface
    ['{DF2A60A9-7D1D-424F-9001-D7F9E6390D1F}']
    function DocumentNo: string;
    function ExpiryDate: TDate;
  end;

  ItdPassportFile = interface
    ['{17077F10-C8AE-462B-B11D-9C04B24D5327}']
    function file_id: string;
    function file_unique_id: string;
    function file_size: Integer;
    function file_date: Integer;
  end;

  ItdEncryptedPassportElement = interface
    ['{17D1FDC0-B494-40A8-AB94-0E72681F9EFB}']
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

  ItdEncryptedCredentials = interface
    ['{48DD05EB-FD11-49C9-825B-75C8C3967A41}']
    function Data: String;
    function Hash: String;
    function Secret: String;
  end;

  ItdPassportData = interface
    ['{CB0B44FB-44D9-4BEC-9465-873C88DF9C67}']
    function Data: TArray<ItdEncryptedPassportElement>;
    function Credentials : ItdEncryptedCredentials;
  end;

  ItdPassportElementError = interface
    ['{7D48435F-5C65-40A1-B16E-309EEA297082}']
    function Source: String;
    function &Type: String;
    function message: String;
  end;

  ItdPassportElementErrorDataField = interface(ItdPassportElementError)
    ['{43CAAB75-E121-46E6-BC63-8714B87027B8}']
    function FieldName: String;
    function DataHash: String;
  end;

  ItdPassportElementErrorFrontSide = interface(ItdPassportElementError)
    ['{8C3C2F4A-4E81-455A-BBA7-A9D56F21F4C3}']
    function FileHash: String;
  end;

  ItdPassportElementErrorReverseSide = interface(ItdPassportElementError)
    ['{E487FE0E-5DBE-4D34-A91C-9EF40B4512ED}']
    function FileHash: String;
  end;

  ItdPassportElementErrorSelfie = interface(ItdPassportElementError)
    ['{B504BB81-ECAD-4402-844F-8B715A6C84C6}']
    function FileHash: String;
  end;

  ItdPassportElementErrorFile = interface(ItdPassportElementError)
    ['{EF409AF3-102E-4877-8066-98CBE5BDEA1B}']
    function FileHash: String;
  end;

  ItdPassportElementErrorFiles = interface(ItdPassportElementError)
    ['{5CE829D4-6FE0-45B7-95F8-30E5E763568E}']
    function FileHashes: TArray<String>;
  end;

  ItdPassportElementErrorTranslationFile = interface(ItdPassportElementError)
    ['{0CD91880-C6C5-42F8-8554-0343970A5EFC}']
    function FileHash: String;
  end;

  ItdPassportElementErrorTranslationFiles = interface(ItdPassportElementError)
    ['{0B94CFC6-F3AC-43D5-B8C3-E11DF85CCD31}']
    function FileHashes: TArray<String>;
  end;

  ItdPassportElementErrorUnspecified = interface(ItdPassportElementError)
    ['{8670B86C-A54D-4A14-A686-8E164C3A8D9E}']
    function ElementHash: String;
  end;

implementation

end.


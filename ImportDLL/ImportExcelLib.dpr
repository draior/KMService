library ImportExcelLib;

uses
  ShareMem,
  SysUtils,
  Classes,
  Forms,
  mConnect,
  Dialogs,
  Windows,
  ImportExcelDataUnit,
  ExcelToImportDTUnit,
  MsgFormUnit in 'MsgFormUnit.pas' {fMsgForm},
  ExcelToImportDTUnit in 'ExcelToImportDTUnit.pas';

{$R *.RES}

exports
  ImportKMExcel, ImportKMExcel2;
  
end.

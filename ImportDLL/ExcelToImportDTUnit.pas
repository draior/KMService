unit ExcelToImportDTUnit;

interface

uses
  DBTables, Forms, Controls, {$IFNDEF D5}OleAuto, Variants{$ELSE}ComObj, ActiveX{$ENDIF}, ProgressUnit, Dialogs,
  RxMemDS, ImportDataFileUnit, Classes;

const
  TempFolder = 'C:\Temp\';

procedure ImportExcel(FName: String; qr: TQuery; T: TTable);


implementation

procedure ImportExcel(FName: String; qr: TQuery; T: TTable);
var
  Excel: OleVariant;
  L: TStringList;
  i, j: Integer;
  FList: TStringList;
  tbl: TRxMemoryData;
begin
  Screen.Cursor := crSQLWait;
  Excel := CreateOleObject('Excel.Application');
  FList := TStringList.Create;
  try
    //Excel.Visible := False;
    Excel.DisplayAlerts := False;
    ProgressIncrease(4, 'Обработка на данните');
    Excel.Workbooks.Open(FName);
    ProgressShow(1, Excel.Workbooks[1].Sheets.Count+1, 'Обработка на excel файл: '+ExtractFileName(FName), '', False, False, True);//Lang
    for i := 1 to Excel.Workbooks[1].Sheets.Count do begin
      FName := ChangeFileExt(ExtractFileName(Excel.Workbooks[1].WorkSheets[i].Name), '.REX');
      ProgressIncrease(1, FName);

      Excel.Workbooks[1].WorkSheets[i].Activate;
      ExcelSaveAsText(Excel, TempFolder, FName);
      FList.Add(FName);
    end;
    ProgressHide;
  except
    on E: Exception do begin
      ProgressHide;
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
  try
    for i := 1 to Excel.Workbooks.Count Do
      Excel.Workbooks[i].Close[True];
    Excel.Quit;
    Excel := Unassigned;
  except
    FreeAndNil(FList);
    raise Exception.Create('Не може да затвори excel!');
  end;
  L := TStringList.Create;
  tbl := TRxMemoryData.Create(nil);
  try
    for i := 0 to FList.Count-1 do begin
      L.LoadFromFile(TempFolder + FList[i]);
      for j := 0 to L.Count-1 do begin
        L[j] := StringReplace(L[j], '"', '', [rfReplaceAll, rfIgnoreCase]);
        L[j] := StringReplace(L[j], #13#10, '', [rfReplaceAll, rfIgnoreCase]);
      end;
      L.SaveToFile(TempFolder + FList[i]);
      ImportToDB(FList[i], qr, T, tbl);
    end;
  finally
    FreeAndNil(tbl);
    FreeAndNil(FList);
  end;
  Screen.Cursor := crDefault;
end;


end.

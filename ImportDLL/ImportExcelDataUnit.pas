unit ImportExcelDataUnit;

interface

uses
  DBTables, Forms, Controls, {$IFNDEF D5}OleAuto, Variants{$ELSE}ComObj, ActiveX{$ENDIF}, ProgressUnit, Dialogs,
  RxMemDS, ImportDataFileUnit, Classes;

const
  TempFolder = 'C:\Temp\';

  procedure ImportKMExcel2;
  procedure ImportKMExcel(FName: String; qr: TQuery; T: TTable);

implementation

uses
  SysUtils, SQLUnit, Windows, MsgFormUnit;

type
  FileFormat = (xlAddIn, xlCSV, xlCSVMac, xlCSVMSDOS, xlCSVWindows, xlDBF2,
                xlDBF3, xlDBF4, xlDIF, xlExcel2, xlExcel3, xlExcel4,
                xlExcel4Workbook, xlIntlAddIn, xlIntlMacro, xlNormal,
                xlSYLK, xlTemplate, xlText, xlTextMac, xlTextMSDOS,
                xlTextWindows, xlTextPrinter, xlWK1, xlWK3, xlWKS,
                xlWQ1, xlWK3FM3, xlWK1FMT, xlWK1ALL);

var
  fMsgForm: TfMsgForm;

function ExcelSaveAsText(Excel: Variant; OutFilePath, OutFileName: ShortString): Boolean;
var
  FullOutName, S: String;
  i, j, p, LastRow, LastCol: Integer;
begin
  Result := False;
  try
    if OutFilePath <> '' then begin
      if not (Copy(OutFilePath, Length(OutFilePath), 1) = '\') then begin
        OutFilePath := OutFilePath + '\';
      end;
    end;
    FullOutName := OutFilePath + OutFileName;
    if FileExists(FullOutName) then DeleteFile(PChar(FullOutName));

    LastRow := Excel.ActiveSheet.UsedRange.Rows.Count;
    LastCol := Excel.ActiveSheet.UsedRange.Columns.Count;

    for i := 1 to LastRow do begin
      for j := 1 to LastCol do begin
        if not VarIsEmpty(Excel.ActiveSheet.Cells[i, j]) then begin
          p := Pos(#$A, VarToStr(Excel.ActiveSheet.Cells[i, j]));
          if p <> 0 then
            Excel.ActiveSheet.Cells[i, j] := StringReplace(VarToStr(Excel.ActiveSheet.Cells[i, j]), #$A, '', [rfReplaceAll, rfIgnoreCase]);
        end;  
      end;
    end;

    Excel.ActiveSheet.SaveAs(FullOutName, xlTextMSDOS);
    Result := True;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOk], 0);
  end;
end;

procedure ImportToDB(FName: String; qr: TQuery; ImpTBL: TTable; tbl: TRxMemoryData);
var
  i: Integer;
  S, SHEET: String;
begin
  tbl.FieldDefs.Clear;
  if tbl.Active then
    tbl.Close;
  tbl.Open;
  try
    if not FileExists(TempFolder + FName) then
      raise Exception.Create('File not exists: ' + TempFolder + FName);

    ImportFileData(TempFolder + FName, tbl, False, TAB, True, 0, False);

    SetCommandText(qr, 'DELETE FROM IMPORTDATA', False);

    if ImpTBL.Active then
      ImpTBL.Close;
    ImpTBL.Open;
    ImpTBL.Database.StartTransaction;
    tbl.First;
    while not tbl.Eof do begin
      ImpTBL.Append;
      for i := 0 to tbl.FieldCount-1 do
        ImpTBL.Fields[i].AsString := tbl.Fields[i].AsString;
      ImpTBL.Post;
      tbl.Next;
    end;
    SHEET := ExtractFileName(FName);
    SetLength(SHEET, Pos('.', SHEET)-1);
    SetCommandText(qr, 'SELECT SQLSTRING FROM SYS_IMPORT WHERE UPPER(SHEET)=UPPER("'+SHEET+'")', True, True);
    if not qr.IsEmpty then begin
      S := qr.Fields[0].AsString;
      SetCommandText(qr, S, True, True);
      S := Trim(qr.Fields[0].AsString);
      if S <> '' then
        raise Exception.Create(S);
      SetCommandText(qr, 'SELECT CAST(MSG as VARCHAR(250)) MSG, DESCR FROM ERROR_TBL', True, True);
      if not qr.IsEmpty then begin
        if fMsgForm = nil then
          fMsgForm := TfMsgForm.Create(nil);
        fMsgForm.ShowQR(qr);
      end;
    end;
    ImpTBL.Database.Commit;

    //TODO AddToTransactionLog(DMTask.qrUpdate, str_ImportFile, str_resSuccess, ExtractFileName(FileName)+#13#10+IDocT);
  except
    on E: Exception do begin
      if ImpTBL.Database.InTransaction then
        ImpTBL.Database.Rollback;
      if Pos('A user transaction is already in progress', E.Message) <> 0 then begin
        if ImpTBL.Database.Connected then
          ImpTBL.Database.Connected := False;
        ImpTBL.DataBase.Open;
      end;
      ImpTBL.Cancel;
      //TODO AddError(str_ImportFile, Oper, ExtractFileName(FileName)+#13#10+E.Message);
      raise Exception.Create(E.Message);
    end;
  end;
  if ImpTBL.Active then
    ImpTBL.Close;

  if GetKeyState(VK_CONTROL) >= 0 then
    SetCommandText(qr, 'DELETE FROM IMPORTDATA', False);
end;

procedure ImportKMExcel(FName: String; qr: TQuery; T: TTable);
var
  Excel: OleVariant;
  L: TStringList;
  i, j: Integer;
  FList: TStringList;
  tbl: TRxMemoryData;
begin
  Screen.Cursor := crSQLWait;
      sHOWmESSAGE('2121S');
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

procedure ImportKMExcel2;
var
  D: TDatabase;
  Q: TQuery;
  T: TTable;
  O: TOpenDialog;
  FName: String;
begin
  D := TDatabase.Create(nil);
  D.DatabaseName := 'DB';
  D.AliasName := 'kmService';
  D.Params.Text := 'USER NAME=sysdba'#13#10'password=masterkey';
  D.LoginPrompt := False;
  Q := TQuery.Create(nil);
  Q.DatabaseName := D.DatabaseName;
  T := TTable.Create(nil);
  T.DatabaseName := D.DatabaseName;
  T.TableName := 'ImportData';
  O := TOpenDialog.Create(nil);
  O.Filter := 'All Microsoft Office Excel files|*.xls|All files|*.*';
  try
    D.Connected := true;

    if (not O.Execute) or (O.FileName = '') then
      Abort
    else
      FName := O.FileName;

    ImportKMExcel(FName, Q, T);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOk], 0);
  end;
  FreeAndNil(O);
  FreeAndNil(T);
  FreeAndNil(Q);
  FreeAndNil(D);
end;

initialization
  DecimalSeparator := '.';

finalization
  if Assigned(fMsgForm) then
    FreeAndNil(fMsgForm);
end.

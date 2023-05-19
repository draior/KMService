unit SelectorUtilities;

interface

uses Graphics, CommonUtilities, Classes, db, dbClient, Controls,
     SysUtils, Forms, Messages, Dialogs, ActnList, Mess, Variants;

type
  TOldOnChangeProcPointer = procedure(Sender: TField) of object;
  TProcPointer = procedure (Sender: TObject) of object;
  TValidateFunc = function (srField: TField; srFieldList: String; CompValues, defValues: OleVariant; Conditions: String): Variant;

  TShowOption = (so_Normal, so_SelectSingle, so_SelectMulty);

  TFilterOpt = (fo_PresentLotsOnly, fo_LotTotal, fo_InsertRecipe, fo_BGPresentOnly,
                fo_CompoundArticlesOnly, fo_NoCompoundArticles, fo_SelectNone,
                fo_ReusableArticles, fo_NoRecFound, fo_FromRequest, fo_Dimension);

  TFilterOption = set of TFilterOpt;

  TClientActionType = (claInsert, claModify, claDelete, claApply, claCancel, claNone);

  CFieldSet = record
    FieldName: String;
    FieldValue: Variant;
    cdsField: TField;
  end;

  TChangeFieldStruct = record
    Field: TField;
    OldProc: TOldOnChangeProcPointer;
    ExecAction: TAction;
  end;

  //COMPLEX SELECTOR TYPES
  TSelectionInfo = record
    srFieldList: String;
    lkFieldList: String;
    lkFieldValues: OleVariant;
    tgTable: TDataSet;
    tgFieldList: String;
  end;

  CRecordLine = array of CFieldSet;
  CSelectionList = array of CRecordLine;
  CSelectionArray = array [0..1] of CSelectionList;

  TSelectionListOperationPtr = procedure (var lcSelectionList: CSelectionList);


//resourcestring
  //que_ShowSelectorErr         = 'Невалидна стойност за полето!'#13#10'Желаете ли форма за избор?';
  //que_ShowSelectorMulti       = 'Неопределена стойност за полето!'#13#10'Желаете ли форма за избор?';
  //inf_NoRecFound              = 'Не са намерени записи отговарящи на зададения критерий.';

function ShowEntity(lcFormConstant: integer; lcFormClass: TFormClass; ShowOption: TShowOption; InputFilterList: OleVariant;
   var OutputIDList: CSelectionList; srSQLStatement_ID : integer; FilterOption: TFilterOption; srTableName: String = ''): TModalResult;

function InsertItems(lcFormConstant: integer; lcFormClass: TFormClass; lcInputFilterList: OleVariant;
   var lcSelectionList: CSelectionList; ShowOption: TShowOption;
   srTableName: String; srSQLStatement_ID: integer; FilterOption: TFilterOption): TModalResult;

function InsertItemEx(lcFormConstant: Integer; srFieldList, lkFieldList: String; lkFieldValues: OleVariant;
   tgTableName: TDataSet; tgFieldList: String; FilterOption: TFilterOption; ShowSelector: Boolean=True;
   ShowOption: TShowOption=so_SelectSingle): TModalResult;

function ValidateValue(srField: TField; srFieldList: String; CompValues, defValues: Variant; Conditions: String): Variant;

function FindInArray(srArray: CSelectionList; srFieldList: String; srFieldValues: Variant;
  var Found_i: Integer; ExactMatch: boolean=True): Boolean;

procedure DeleteCell(var srArray: CSelectionList; Pos: integer = 0);
procedure SetCRecLineFldValue(var CRecLine: CRecordLine; srFieldList: String; srFieldValues: Variant);
function GetCRecLineFldValue(var CRecLine: CRecordLine; FieldName: String): Variant;

var
  HaveRec: Boolean=True;

implementation

uses BaseEntity, DataModule, FormConstants,
  Utilities;

function GetData(FormConst: Integer; TableInfo: TSelectionInfo; FilterOption: TFilterOption; var RecLine: CRecordLine; var RecCount: Integer): Integer;
var
  i, lcSQL_ID, FieldsCount: Integer;
  lcReturnValues: OleVariant;
  lcField: TField;
  lcExactMatch: Boolean;
  lcFormClass: TFormClass;
  lcSourceTableName: String;
  lcSelectionListProc: TSelectionListOperationPtr;
begin
  if GetFormDetails( FormConst, FilterOption, lcFormClass, lcSourceTableName,
       TableInfo.lkFieldList, TableInfo.lkFieldValues,
       lcSQL_ID, lcSelectionListProc, lcExactMatch ) = -1 then
  begin
    Result := -1;
    Exit;
  end;

  RecCount := DM.ServerData.AppServer.GetValueEx( lcSQL_ID, TableInfo.lkFieldList,
    TableInfo.lkFieldValues, TableInfo.srFieldList, lcReturnValues, lcExactMatch );

  //vzemame po-malkoto ot dvete za lcRecLine
  //ako sme podali pove4e tgFieldList -> palnim gi s Null
  if GetFieldsCount( TableInfo.tgFieldList, ';' ) > GetFieldsCount( TableInfo.srFieldList, ';' ) then begin
    FieldsCount := GetFieldsCount( TableInfo.srFieldList, ';' );

    for i := FieldsCount to GetFieldsCount( TableInfo.tgFieldList, ';' ) do begin
      lcField := TableInfo.tgTable.FindField( GetField( TableInfo.tgFieldList, ';', i ) );

      if Assigned( lcField ) then
        lcField.Value := NULL;
    end;
  end
  else
    FieldsCount := GetFieldsCount( TableInfo.tgFieldList, ';' );

  for i := 1 to FieldsCount do begin
    lcField := TableInfo.tgTable.FindField( GetField( TableInfo.tgFieldList, ';', i ) );

    if Assigned( lcField ) then begin
      SetLength( RecLine, i );

      RecLine[i - 1].cdsField := lcField;
      RecLine[i - 1].FieldName := GetField( TableInfo.srFieldList, ';', i );

      if RecCount > 0 then // samo ako e nameril pravilniq zapis
        if FieldsCount = 1 then
          RecLine[i - 1].FieldValue := lcReturnValues
        else
          RecLine[i - 1].FieldValue := lcReturnValues[i - 1];
    end;
  end;

  Result := 0;
end;

function InsertItemEx(lcFormConstant: Integer; srFieldList, lkFieldList: String; lkFieldValues: OleVariant;
    tgTableName: TDataSet; tgFieldList: String; FilterOption: TFilterOption; ShowSelector: Boolean=True;
    ShowOption: TShowOption=so_SelectSingle): TModalResult;
var
  i, j, lcRecsOut, srSQLStatement_ID, FieldsCount: Integer;
  lcSearchValues, lcReturnValues, lc_varValues: OleVariant;
  lcField: TField;
  lcRecline: CRecordLine;
  lcSelectionList: CSelectionList;
  GetSearchValues, lcExactMatch: Boolean;
  lcFormClass: TFormClass;
  SelectionListProc: TSelectionListOperationPtr;
  lcDefaultQty: Double;
  srTableName, lc_strFields: String;
begin
  Screen.Cursor := crHourGlass;
  lcExactMatch := False;
  SelectionListProc := nil;

  //Ако е извикано след Validate (Exit от контрола) може да е натиснат Отказ
  // и Таргет таблицата да е в dsBrowse
  if not (tgTableName.State in dsWriteModes) then begin
    Result := mrCancel;
    Screen.Cursor := crDefault;
    Exit;
  end;

  //vzemame dannite za formata vav  lcFormClass, srTableName, srSQLStatement_ID
  if GetFormDetails(lcFormConstant, FilterOption,
                   lcFormClass, srTableName, lkFieldList,
                   lkFieldValues, srSQLStatement_ID,
                   SelectionListProc, lcExactMatch) = -1
  then begin
    Result := mrCancel;
    Screen.Cursor := crDefault;
    Exit;
  end;

  lc_strFields := lkFieldList;
  lc_varValues := lkFieldValues;


  lcRecsOut := DM.ServerData.AppServer.GetValueEx(srSQLStatement_ID, lkFieldList, lkFieldValues, srFieldList, lcReturnValues, lcExactMatch);

  GetSearchValues := (tgTableName.State in dsWriteModes);

  //vzemame po-malkoto ot dvete za lcRecLine
  //ako sme podali pove4e tgFieldList -> palnim gi s Null
  if GetFieldsCount(tgFieldList, ';') > GetFieldsCount(srFieldList, ';') then begin
    FieldsCount := GetFieldsCount(srFieldList, ';');
    for i := FieldsCount to GetFieldsCount(tgFieldList, ';') do begin
      lcField := tgTableName.FindField(GetField(tgFieldList, ';', i));
      if (lcField <> nil) and (lcField.DataSet.State in dsWriteModes) then
        lcField.Value := Null;
    end;
  end
  else FieldsCount := GetFieldsCount(tgFieldList, ';');

  for i := 1 to FieldsCount do begin
    lcField := tgTableName.FindField(GetField(tgFieldList, ';', i));
    if lcField <> nil then begin
      SetLength(lcRecLine, i);
      lcRecLine[i - 1].cdsField := lcField;
      lcRecLine[i - 1].FieldName := GetField(srFieldList, ';', i);
      if HaveRec and (lcRecsOut > 0) then // samo ako e nameril pravilniq zapis  //VER D2
        if FieldsCount = 1 then
          lcRecLine[i - 1].FieldValue := lcReturnValues
        else
          lcRecLine[i - 1].FieldValue := lcReturnValues[i - 1];
    end;
  end;

  SetLength(lcSelectionList, 1);
  lcSelectionList[0] := lcRecLine;

  Screen.Cursor := crDefault;
  if (ShowSelector) and (lcRecsOut = 1) then
    lcRecsOut := 2;
  case lcRecsOut of
    0,
    -1: begin //Zero records or exception
          if fo_NoRecFound in FilterOption then begin
            MessageDlg(err_NoRecFound, mtInformation, [mbOK], 0);
            Result := mrRetry;
          end
          else begin
            if false{TODO DRAGO(lcFormConstant = fc_ArticlesSelect)
            or (lcFormConstant = fc_ArticlesSelectTot)
            or (lcFormConstant = fc_ArticlesSelectFromArticle)} then begin
              lcSearchValues := VarArrayCreate([0, 0], varVariant);

              if GetSearchValues then
                for i := 0 to VarArrayHighBound(lkFieldValues, 1) - 1 do begin
                  if not VarIsNull(lkFieldValues[i]) then begin
                    VarArrayRedim(lcSearchValues, VarArrayHighBound(lcSearchValues, 1) + 1);
                    lcSearchValues[i] := VarArrayOf([GetField(lkFieldList, ';', i + 1), '=', VarToStr(lkFieldValues[i]) + '%', 'AND'])
                  end;
                end;

              if GetSearchValues and (not VarIsNull(lkFieldValues[VarArrayHighBound(lkFieldValues, 1)])) then begin
                VarArrayRedim(lcSearchValues, VarArrayHighBound(lcSearchValues, 1) + 1);
                lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1] :=
                  VarArrayOf([GetField(lkFieldList, ';', VarArrayHighBound(lkFieldValues, 1) + 1), '=', VarToStr(lkFieldValues[VarArrayHighBound(lkFieldValues, 1)]) + '%', ''])
              end;

              if VarArrayHighBound(lcSearchValues, 1) > 0 then
                if lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][3] = 'AND' then
                  lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1] :=
                       VarArrayOf([ VarToStr(lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][0]),
                                    VarToStr(lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][1]),
                                    VarToStr(lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][2]),
                                    '']);

              lcSearchValues[VarArrayHighBound(lcSearchValues, 1)] := VarArrayOf([';', ';', ';', ';']);
            end
            else
              lcSearchValues := VarArrayOf([VarArrayOf([';', ';', ';', ';'])]);

            Result := InsertItems(lcFormConstant, lcFormClass, lcSearchValues, lcSelectionList, ShowOption, srTableName, srSQLStatement_ID, FilterOption);
          end;
        end;
    1 : begin //One record found
          if Assigned(SelectionListProc) then
            SelectionListProc(lcSelectionList);

          lcDefaultQty := 1;

          if ShowOption <> so_SelectSingle then
            for i := 0 to High(lcSelectionList) do begin
              try
                if not (lcSelectionList[i][0].cdsField.DataSet.State in dsWriteModes) then
                  lcSelectionList[i][0].cdsField.DataSet.Insert;
                for j := 0 to High(lcSelectionList[i]) do
                  try
                    if ( lcSelectionList[i][j].cdsField.FieldName = 'QUANTITY' )
                    and( RoundUp( lcSelectionList[i][j].FieldValue, 3 ) <= 0 ) then
                      lcSelectionList[i][j].cdsField.Value := lcDefaultQty
                    else
                      lcSelectionList[i][j].cdsField.Value := lcSelectionList[i][j].FieldValue;
                  except
                    Abort;
                  end;
                if (lcSelectionList[i][0].cdsField.DataSet.State in dsWriteModes) then
                  lcSelectionList[i][0].cdsField.DataSet.Post;
              except
                if (lcSelectionList[i][0].cdsField.DataSet.State in dsWriteModes) then
                  lcSelectionList[i][0].cdsField.DataSet.Cancel;
              end;
            end
          else //mojem da vkarame samo 1 zapis
            for i := 0 to High(lcRecLine) do
              if lcRecLine[i].cdsField.DataSet.State in dsWriteModes then
                lcRecLine[i].cdsField.Value := lcRecLine[i].FieldValue;

          Result := mrOK;
        end
    else begin //> 1

      lcSearchValues := VarArrayCreate([0, 0], varVariant);

      if GetSearchValues then
        for i := 0 to VarArrayHighBound(lkFieldValues, 1) - 1 do begin
          if not VarIsNull(lkFieldValues[i]) then begin
            VarArrayRedim(lcSearchValues, VarArrayHighBound(lcSearchValues, 1) + 1);
            lcSearchValues[i] := VarArrayOf([GetField(lkFieldList, ';', i + 1), '=', VarToStr(lkFieldValues[i]) + '%', 'AND'])
          end;
        end;

      if GetSearchValues and (not VarIsNull(lkFieldValues[VarArrayHighBound(lkFieldValues, 1)])) then begin
        VarArrayRedim(lcSearchValues, VarArrayHighBound(lcSearchValues, 1) + 1);
        lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1] :=
          VarArrayOf([GetField(lkFieldList, ';', VarArrayHighBound(lkFieldValues, 1) + 1), '=', VarToStr(lkFieldValues[VarArrayHighBound(lkFieldValues, 1)]) + '%', ''])
      end;

      if VarArrayHighBound(lcSearchValues, 1) > 0 then
        if lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][3] = 'AND' then
          lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1] :=
               VarArrayOf([ VarToStr(lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][0]),
                            VarToStr(lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][1]),
                            VarToStr(lcSearchValues[VarArrayHighBound(lcSearchValues, 1) - 1][2]),
                            '']);

      lcSearchValues[VarArrayHighBound(lcSearchValues, 1)] := VarArrayOf([';', ';', ';', ';']);
      Result := InsertItems(lcFormConstant, lcFormClass, lcSearchValues, lcSelectionList, ShowOption, srTableName, srSQLStatement_ID, FilterOption);
    end;
  end; //case
end;

function InsertItems(lcFormConstant: Integer; lcFormClass: TFormClass; lcInputFilterList: OleVariant;
   var lcSelectionList: CSelectionList; ShowOption: TShowOption;
   srTableName: String; srSQLStatement_ID: integer; FilterOption: TFilterOption): TModalResult;
var
  i, j: integer;
  DS: TDataSet;
begin
  Result := ShowEntity(lcFormConstant, lcFormClass, ShowOption, lcInputFilterList,
    lcSelectionList, srSQLStatement_ID, FilterOption, srTableName);

  Application.ProcessMessages;

  DS := nil;

  if Result = mrOK then begin//Client Selected something
    try
      Screen.Cursor := crHourGlass;

      if High(lcSelectionList) >= 0 then
        DS := lcSelectionList[0][0].cdsField.DataSet;
      if DS <> nil then 
        DS.DisableControls;
      for i := 0 to High(lcSelectionList) do begin
        try
          if ShowOption <> so_SelectSingle then
            if not (lcSelectionList[i][0].cdsField.DataSet.State in dsWriteModes) then
              lcSelectionList[i][0].cdsField.DataSet.Insert;

          for j := 0 to High(lcSelectionList[i]) do
            try
              lcSelectionList[i][j].cdsField.Value := lcSelectionList[i][j].FieldValue;
            except
              Result := mrCancel;
            end;

          if (ShowOption <> so_SelectSingle) and (lcSelectionList[i][0].cdsField.DataSet.State in [dsEdit, dsInsert]) then
            lcSelectionList[i][0].cdsField.DataSet.Post;
        except
          Result := mrCancel;
          if ShowOption <> so_SelectSingle then
            lcSelectionList[i][0].cdsField.DataSet.Cancel;
        end;
      end;
    finally
      if DS <> nil then
        DS.EnableControls;
      Screen.Cursor := crDefault;
    end;
  end;
end;

function ShowEntity(lcFormConstant: Integer; lcFormClass: TFormClass; ShowOption: TShowOption; InputFilterList: OleVariant;
   var OutputIDList: CSelectionList; srSQLStatement_ID : integer; FilterOption: TFilterOption; srTableName: String = ''): TModalResult;
var
  SavedABI           : integer;
  SavedAAI           : integer;
  SavedABU           : integer;
  SavedAAU           : integer;
  SavedABD           : integer;
  SavedAAD           : integer;
  SavedNewDoc        : boolean;
  SavedAllowDblClick : boolean;
  SavedWithLink      : boolean;
begin
  Result := mrCancel;
  SavedWithLink := DM.WithLink;
  SavedABI := DM.ABeforeInsert;
  SavedAAI := DM.AAfterInsert;
  SavedABU := DM.ABeforeUpdate;
  SavedAAU := DM.AAfterUpdate;
  SavedABD := DM.ABeforeDelete;
  SavedAAD := DM.AAfterDelete;
  SavedNewDoc := DM.ANewDoc;
  SavedAllowDblClick := DM.AllowDBLClick;

  DM.WithLink := True;
  //calling a BaseEntity form

  if (lcFormClass.ClassParent = TfBaseEntity) then begin
    with (lcFormClass.Create(Screen.ActiveForm{Application}) as TfBaseEntity) do begin
      pblFormID := lcFormConstant;
      Result := ShowDataForm(ShowOption, InputFilterList, OutputIDList, srSQLStatement_ID, FilterOption);
      Free;
    end;
  end;

  DM.WithLink      := SavedWithLink;
  DM.ABeforeInsert := SavedABI;
  DM.AAfterInsert  := SavedAAI;
  DM.ABeforeUpdate := SavedABU;
  DM.AAfterUpdate  := SavedAAU;
  DM.ABeforeDelete := SavedABD;
  DM.AAfterDelete  := SavedAAD;
  DM.ANewDoc       := SavedNewDoc;
  DM.AllowDBLClick := SavedAllowDblClick;
end;

function ValidateValue(srField: TField; srFieldList: String;
         CompValues, defValues: Variant; Conditions: String): Variant;
var
  i : integer;
begin
  if Assigned(srField) then
  try
    Result := srField.Value;
  except
    Result := Null;
    Exit;
  end;
  //da se napravi proverka ako br. na podadenite poleta
  // e razli4en ot broia na podadenite stoinostti

  for i := 1 to GetFieldsCount(srFieldList, ';') do begin
    if srField.FieldName = GetField(srFieldList, ';', i) then begin
      if (GetField(Conditions, ';', i) = '<>') and (srField.Value <> CompValues[i - 1]) then Result := defValues[i - 1]
      else if (GetField(Conditions, ';', i) = '>') and (srField.Value > CompValues[i - 1]) then Result := defValues[i - 1]
      else if (GetField(Conditions, ';', i) = '<') and (srField.Value < CompValues[i- 1 ]) then Result := defValues[i - 1]
      else if (GetField(Conditions, ';', i) = '=') and (srField.Value = CompValues[i - 1]) then Result := defValues[i - 1]
      else if (GetField(Conditions, ';', i) = '>=') and (srField.Value >= CompValues[i - 1]) then Result := defValues[i - 1]
      else if (GetField(Conditions, ';', i) = '<=') and (srField.Value <= CompValues[i - 1]) then Result := defValues[i - 1]
    end;
  end;
end;

function FindInArray(srArray: CSelectionList; srFieldList: String; srFieldValues: Variant;
  var Found_i: Integer; ExactMatch: Boolean=True): Boolean;
var
  i, j, p, lcCount_i, lcCount_j: Integer;
  Found: boolean;
  lcVarArray: array of boolean;
  lcVarType: Variant;
begin
  Found := False;
  i := 0;
  lcCount_i := High(srArray);
  lcCount_j := High(srArray[0]);
  SetLength(lcVarArray, GetFieldsCount(srFieldList, ';'));

  while (not Found) and (i <= lcCount_i) do begin
    for p := 0 to High(lcVarArray) do
      lcVarArray[p] := False;
    // tarsim poleta s poso4enite stoinostti na poleta i ako namerim  then Function := true;
    for j := 0 to lcCount_j do
      for p := 1 to GetFieldsCount(srFieldList, ';') do
        if (srArray[i][j].FieldName = GetField(srFieldList, ';', p)) then begin
          try  // opitva se da cast-ne stoinostta na poleto i ako ne moje zna4i ne mojem i da gi sravniavame
            if VarIsNull( srArray[i][j].FieldValue ) or VarIsEmpty( srArray[i][j].FieldValue ) then
              VarClear(lcVarType)
            else
              VarCast(lcVarType, srArray[i][j].FieldValue, VarType(srFieldValues[p - 1]));
          except
            VarClear(lcVarType);
          end;  
          if (not VarIsEmpty(lcVarType)) and (lcVarType = srFieldValues[p - 1]) then
            lcVarArray[p - 1] := True;
        end;

    Found := lcVarArray[0];    //checking the condition
    if ExactMatch then begin
      for p := 1 to High(lcVarArray) do //DRAGO 09.03.16 беше от 1 до
        Found := Found and lcVarArray[p]
    end    
    else for p := 1 to High(lcVarArray) do
      Found := Found or lcVarArray[p];

    Inc(i);
  end;

  if Found then
    Found_i := i - 1;         //Return the i value
  Result := Found;
end;

procedure DeleteCell(var srArray : CSelectionList; Pos : integer = 0);
var
  i : integer;
begin
  if Pos > High(srArray) then Exit;

  if (Pos = High(srArray)) then SetLength(srArray, Length(srArray) - 1)
  else
  begin
    for i := Pos to High(srArray) - 1 do
      srArray[i] := srArray[i + 1];
    SetLength(srArray, Length(srArray) - 1);
  end;
end;

procedure SetCRecLineFldValue(var CRecLine : CRecordLine; srFieldList : String; srFieldValues : Variant);
var
  j, p: Integer;
begin
  for j := 0 to High(CRecLine) do begin
    for p := 1 to GetFieldsCount(srFieldList, ';') do
      if CRecLine[j].FieldName = GetField(srFieldList, ';', p) then
        CRecLine[j].FieldValue := srFieldValues[p - 1];
  end;
end;

function GetCRecLineFldValue(var CRecLine : CRecordLine; FieldName : String) : Variant;
var
  j: integer;
  Found: Boolean;
begin
  j := 0;
  Found := False;
  Result := Null;
  while (not Found) and (j <= High(CRecLine)) do begin
    if CRecLine[j].FieldName = FieldName then begin
      Found := True;
      Result := CRecLine[j].FieldValue;
    end;
    inc(j);
  end;
end;

end.

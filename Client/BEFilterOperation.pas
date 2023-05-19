unit BEFilterOperation;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, Mask, DBCtrls, ComCtrls, ToolWin, ExtCtrls, Buttons,
  db, ActnList, ImgList, Variants;

type
  TfBEFilterOperation = class(TForm)
    pDocumentName: TPanel;
    pnlMain: TPanel;
    lParams: TLabel;
    StatusBar1: TStatusBar;
    sbFilter: TScrollBox;
    cbFields: TComboBox;
    cbCondition: TComboBox;
    eValue: TEdit;
    cbLogicalCondition: TComboBox;
    alMain: TActionList;
    acExit: TAction;
    acApplyFilter: TAction;
    acNewGroup: TAction;
    acClear: TAction;
    dtpDateValue: TDateTimePicker;
    lbPositionDescription: TLabel;
    pnlToolBar: TPanel;
    tbMain: TToolBar;
    tbExit: TToolButton;
    tbApplyFilter: TToolButton;
    sp2: TToolButton;
    tbAdd: TToolButton;
    tbDelete: TToolButton;
    ilToolbar: TImageList;
    cbValue: TComboBox;
    procedure acNewGroupExecute(Sender: TObject);
    procedure acApplyFilterExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acClearExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbFieldsChange(Sender: TObject);
  private
    prFilterString: OleVariant;
    prFieldNames: TStringList;
    lastT, LastL: Integer;
    prLastLogCondIndex: Integer;
    prLastSearchGroup: Integer;
    prDataSet: TDataSet;
    prPutPercentBeforeFilter: Boolean;
    function BuildValidFieldName(lcOrigin: string): String;
  public
    procedure GetValidFields(dsList: TDataSource);
    procedure FillcbFields(Combo: TComboBox);
    procedure CreateSearchGroup;
    procedure ClearSearchGroups;
    procedure SetFirstCondition;
    procedure BuildInitialFilter;
    function ShowFilterForm(dsList: TDataSource; OldFilter: OleVariant; var NewFilter: OleVariant): TModalResult;
    function BuildFilter: Boolean;
    function GetFilterAsString: String;
  end;

implementation

uses
  DataModule, ULogUtils, CommonUtilities, Mess, SysUnit;

{$R *.DFM}

{ TfBEFilterOperation }

function TfBEFilterOperation.BuildFilter: Boolean;
var
  i, j, ffs, l: Integer;
  fn, lcFieldValue: String;
  ffn: TField;
  fv: Variant;
begin
  Result := False;
  try
    prFilterString := VarArrayCreate([0, prLastSearchGroup + 1], varVariant);
    j := 0;

    for i := 0 to prLastSearchGroup do begin
      fn := prFieldNames.Values[TComboBox(sbFilter.Controls[j]).Text];
      if fn = '' then begin
        prFilterString := VarArrayOf( [VarArrayOf( [';', ';', ';', ';'] )] );

        if TComboBox(sbFilter.Controls[j]).ItemIndex < 0 then
          raise Exception.Create('Не е избрано поле, по което да се изпълни филтъра!')
        else
          raise Exception.Create('Няма зададен ORIGIN за поле "' + TComboBox(sbFilter.Controls[j]).Text + '"!');
      end;

      //Tyrsy pole s dadeno FIELDNAME
      ffn := nil;

      for l := 0 to prDataSet.FieldCount - 1 do begin
        if Copy( prDataSet.Fields[l].Origin, pos('.', prDataSet.Fields[l].Origin) + 1, Length(prDataSet.Fields[l].Origin)) = fn then begin
          ffn := prDataSet.Fields[l];
          Break;
        end;//if
      end;//for i}

      //Ako go e namerilo vzima tipa na polto
      if ffn = nil then
        raise Exception.Create('Полето ' + fn + ' не може да бъде намерено!')
      else begin
        case ffn.DataType of
          ftString:
            begin
              if sbFilter.Controls[j + 5].Visible then
                lcFieldValue := TComboBox(sbFilter.Controls[j + 5]).Text
              else
                lcFieldValue := TComboBox(sbFilter.Controls[j + 2]).Text;
              ffs := ffn.Size;

              if Length(lcFieldValue) >= ffs then
                Delete(lcFieldValue, ffs + 1, Length(lcFieldValue) - ffs);

	      fv := lcFieldValue;
	      if prPutPercentBeforeFilter and (Length(lcFieldValue) > 0)  then
                if lcFieldValue[1]<>'%' then  fv := '%'+lcFieldValue;

            end;//ftString

          ftSmallint,
          ftInteger,
          ftWord:
            begin
              fv := StrToInt( TComboBox(sbFilter.Controls[j + 2]).Text );
            end;

          ftFloat,
          ftCurrency:
            begin
              fv := StrToFloat( TComboBox(sbFilter.Controls[j + 2]).Text );
            end;

          ftTime,
          ftDate,
          ftDateTime:
            begin
              fv := TDateTime(TDateTimePicker(sbFilter.Controls[j + 4]).Date);
            end;

          else fv :=  TComboBox(sbFilter.Controls[j + 2]).Text;
        end;//case
      end;//else

      //Popylva strukturata za filtyra
      prFilterString[i] := VarArrayOf([
         fn,                                            //field
         TComboBox(sbFilter.Controls[j + 1]).Text,      //cond.
         fv,                                            //value
         TComboBox(sbFilter.Controls[j + 3]).Text]);    //and/or

      j := j + 6;
    end;

    prFilterString[prLastSearchGroup + 1] := VarArrayOf([';', ';', ';', ';']);
    Result := True;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      prFilterString := VarArrayOf( [VarArrayOf( [';', ';', ';', ';'] )] );
      if not (E is Exception) then
        WriteToLog(E.Message, 'TfBEFilterOperation.BuildFilter');
    end;
  end;
end;

procedure TfBEFilterOperation.CreateSearchGroup;
var
  c1, c2, c3, c4: TComboBox;
  e1: TEdit;
  d1: TDateTimePicker;
begin
  try
    //FieldCombo
    c1 := TComboBox.Create(sbFilter);
    c1.Parent := sbFilter;
    c1.Width := cbFields.Width;
    c1.Top := LastT + 25 - sbFilter.VertScrollBar.Position;
    c1.Left := LastL;
    FillcbFields(c1);
    c1.Tag := cbFields.Tag;
    c1.Style := csDropDownList;
    c1.Visible := true;
    c1.ItemIndex := 0;
    c1.OnChange := cbFields.OnChange;

    //Condition combo
    c2 := TComboBox.Create(sbFilter);
    c2.Parent := sbFilter;
    c2.Width := cbCondition.Width;
    c2.Top := LastT + 25 - sbFilter.VertScrollBar.Position;
    c2.Left := cbCondition.Left;
    c2.Items := cbCondition.Items;
    c2.Tag := cbCondition.Tag;
    c2.Style := csDropDownList;
    c2.Visible := true;
    c2.ItemIndex := 0;

    //Value Edit box
    e1 := TEdit.Create(sbFilter);
    e1.Parent := sbFilter;
    e1.Width := eValue.Width;
    e1.Top := LastT + 25 - sbFilter.VertScrollBar.Position;
    e1.Left := eValue.Left;
    e1.Tag := eValue.Tag;
    e1.Visible := true;

    //cbLogicalCondition
    c3 := TComboBox.Create(sbFilter);
    c3.Parent := sbFilter;
    c3.Width := cbLogicalCondition.Width;
    c3.Top := LastT + 25 - sbFilter.VertScrollBar.Position;
    c3.Left := cbLogicalCondition.Left;
    c3.Items := cbLogicalCondition.Items;
    c3.Tag := cbLogicalCondition.Tag;
    c3.Style := csDropDownList;
    c3.Visible := False;
    c3.ItemIndex := -1;

    //Value Date Time Picker
    d1 := TDateTimePicker.Create(sbFilter);
    d1.Parent := sbFilter;
    d1.Width := eValue.Width;
    d1.Top := LastT + 25 - sbFilter.VertScrollBar.Position;
    d1.Left := eValue.Left;
    d1.Tag := eValue.Tag;
    d1.Visible := False;
    d1.Date := Date;
    d1.Time := dtpDateValue.Time;
    d1.Kind := dtpDateValue.Kind;

    //if Field is EXTRAFIELD
    c4 := TComboBox.Create(sbFilter);
    c4.Parent := sbFilter;
    c4.Width := eValue.Width;
    c4.Top := LastT + 25 - sbFilter.VertScrollBar.Position;
    c4.Left := eValue.Left;
    c4.Tag := eValue.Tag;;
    c4.Style := csDropDownList;
    c4.Visible := False;
    c4.ItemIndex := -1;

    sbFilter.Controls[prLastLogCondIndex].Visible := True;
    TComboBox(sbFilter.Controls[prLastLogCondIndex]).ItemIndex := 0;

    prLastLogCondIndex := c3.ComponentIndex + 6;

    //setting LastTop position
    LastT := LastT + 25;
    Inc(prLastSearchGroup);
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.CreateSearchGroup');
  end;
end;

procedure TfBEFilterOperation.FillcbFields(Combo: TComboBox);
var
  i: Integer;
begin
  try
    Combo.Items.Clear;
    for i := 0 to prFieldNames.Count-1 do
      Combo.Items.Add(prFieldNames.Names[i])
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.FillcbFields');
  end;
end;

procedure TfBEFilterOperation.GetValidFields(dsList: TDataSource);
var
  i, fc: Integer;
begin
  try
    //Gets valid fieldnames (excl .._ID fields and Sync and Hiden fields(tag = 1))
    with dsList.DataSet do begin
      fc := Fields.Count - 1;
      prFieldNames.Clear;

      for i := 0 to fc do begin
        if ((UpperCase(Copy(Fields[i].FieldName, Length(Fields[i].FieldName) - 1, 2)) <> 'ID' )
        or (UpperCase(Fields[i].FieldName ) = 'DOCSTATUS_ID' )
        or (UpperCase( Fields[i].FieldName ) = 'RECVSTATUS_ID' ))
        and (UpperCase( Fields[i].FieldName ) <> 'SYNC' )
        and (Fields[i].Tag <> 1 ) then
          prFieldNames.Add(Fields[i].DisplayLabel + '=' + BuildValidFieldName(Fields[i].Origin));
      end;
    end;
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.GetValidFields');
  end;
end;

function TfBEFilterOperation.ShowFilterForm(dsList: TDataSource; OldFilter: OleVariant; var NewFilter: OleVariant): TModalResult;
begin
  Result := mrCancel;
  try
    prDataSet := dsList.DataSet;
    GetValidFields(dsList);
    prFilterString := OldFilter;
    FillcbFields(cbFields);
    //ConfigureOldFilter(prFilterString);
    LastT := cbFields.Top;
    LastL := cbFields.Left;
    prLastSearchGroup := 0;
    prLastLogCondIndex := 3;
    Top := TForm(Owner).Top;
    Left := TForm(Owner).Left + TForm(Owner).Width - Width;
    SetFirstCondition;

    cbFieldsChange(cbFields);

    BuildInitialFilter;

    ShowModal;

    if ModalResult = mrOK then
      NewFilter := prFilterString
    else
      NewFilter := OldFilter;

    Result := ModalResult;
  except
    on E: Exception do 
      WriteToLog(E.Message, 'TfBEFilterOperation.ShowFilterForm');
  end;
end;

procedure TfBEFilterOperation.BuildInitialFilter;
var
  i, j, n: Integer;
  FldName, PickList: String;

  function GetNameOf(S: string): string;
  var k: Integer;
  begin
    try
      for k := 0 to prFieldNames.Count - 1 do
        if prFieldNames.Values[prFieldNames.Names[k]] = S then
          Result := prFieldNames.Names[k];
    except
      on E: Exception do
        WriteToLog(E.Message, 'TfBEFilterOperation.GetNamesOf');
    end;
  end;

begin
  try
    // This procedure Builds the initial filter if Any passed to procedure
    j := 0; //Additional counter
    //TODO: Remove -1
    n := VarArrayHighBound(prFilterString, 1) - 1;
    for i := 0 to n do begin
      FldName := prFilterString[i][0];
      PickList := '';
      if i = 0 then begin //FirstCondition is special
        cbFields.ItemIndex := cbFields.Items.IndexOf(GetNameOf(VarToStr(prFilterString[i][0])));
        cbCondition.ItemIndex := cbCondition.Items.IndexOf(VarToStr(prFilterString[i][1]));
        if VarType(prFilterString[i][2]) = varDate then begin
          eValue.Visible := False;
          dtpDateValue.Visible := True;
          dtpDateValue.Date := VarToDateTime(prFilterString[i][2]);
        end
        else begin
          eValue.Visible := True;
          dtpDateValue.Visible := False;
          eValue.Text := Trim(VarToStr(prFilterString[i][2]));
          eValue.Visible := PickList = '';
          if PickList <> '' then begin
            cbValue.Items.Text := PickList;
            cbValue.Visible := PickList <> '';
            cbValue.ItemIndex := cbValue.Items.IndexOf(eValue.Text);
          end;
        end;
        cbLogicalCondition.ItemIndex := cbLogicalCondition.Items.IndexOf(VarToStr(prFilterString[i][3]));
      end
      else begin //other lines
        j := j + 6;
        CreateSearchGroup;
        TComboBox(sbFilter.Controls[j - 3]).ItemIndex := TComboBox(sbFilter.Controls[j - 3]).Items.IndexOf(VarToStr(prFilterString[i - 1][3]));
        TComboBox(sbFilter.Controls[j]).ItemIndex := cbFields.Items.IndexOf(GetNameOf(VarToStr(prFilterString[i][0])));
        TComboBox(sbFilter.Controls[j + 1]).ItemIndex := cbCondition.Items.IndexOf(VarToStr(prFilterString[i][1]));
        if VarType(prFilterString[i][2]) = varDate then begin
          TEdit(sbFilter.Controls[j + 2]).Visible := False;
          TDateTimePicker(sbFilter.Controls[j + 4]).Visible := True;
          TDateTimePicker(sbFilter.Controls[j + 4]).Date := VarToDateTime(prFilterString[i][2]);
        end
        else begin
          TEdit(sbFilter.Controls[j + 2]).Visible := True;
          TDateTimePicker(sbFilter.Controls[j + 4]).Visible := False;
          TEdit(sbFilter.Controls[j + 2]).Text := VarToStr(prFilterString[i][2]);
          sbFilter.Controls[j + 2].Visible := PickList = '';
          if PickList <> '' then begin
            TComboBox(sbFilter.Controls[j + 5]).Items.Text := PickList;
            sbFilter.Controls[j + 5].Visible := PickList <> '';
            TComboBox(sbFilter.Controls[j + 5]).ItemIndex := TComboBox(sbFilter.Controls[j + 5]).Items.IndexOf(VarToStr(prFilterString[i][2]));
          end;
        end;
        TComboBox(sbFilter.Controls[j + 3]).ItemIndex := TComboBox(sbFilter.Controls[j + 3]).Items.IndexOf(VarToStr(prFilterString[i][3]));
      end;
    end;
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.BuildInitialFilter');
  end;
end;

procedure TfBEFilterOperation.acNewGroupExecute(Sender: TObject);
begin
  CreateSearchGroup;
end;

procedure TfBEFilterOperation.acApplyFilterExecute(Sender: TObject);
begin
  if BuildFilter then
    ModalResult := mrOK;
end;

procedure TfBEFilterOperation.acExitExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfBEFilterOperation.FormCreate(Sender: TObject);
begin
  try
    //Caption := sys_ClientVersion;
    prFieldNames := TStringList.Create;

    dtpDateValue.Top := eValue.Top;
    dtpDateValue.Left := eValue.Left;
    dtpDateValue.Visible := False;
    dtpDateValue.Date := Date;
    cbValue.Top := eValue.Top;
    cbValue.Left := eValue.Left;
    prPutPercentBeforeFilter := True; //TODO DRAGO GetOptionState(c_APP_ClientOptions, c_APP_UsePercentAtBegginingOfFilter, varBoolean);
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.FormCreate');
  end;
end;

procedure TfBEFilterOperation.SetFirstCondition;
begin
  try
    cbFields.ItemIndex := 0;
    cbCondition.ItemIndex := 0;
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.SetFirstCondition');
  end;
end;

procedure TfBEFilterOperation.ClearSearchGroups;
var i: integer;
begin
  try
    for i := sbFilter.ControlCount - 1 downto 6 do begin
      if (sbFilter.Controls[i] is TComboBox) then
        if Assigned(TComboBox(sbFilter.Controls[i]).OnChange) then
          TComboBox(sbFilter.Controls[i]).OnChange := nil;
      sbFilter.Controls[i].Destroy;
    end;

    cbLogicalCondition.Visible := False;
    cbLogicalCondition.ItemIndex := -1;
    LastT := cbFields.Top;
    LastL := cbFields.Left;
    prLastSearchGroup := 0;
    prLastLogCondIndex := 3;

    SetFirstCondition;
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.ClearSearchGroups');
  end;
end;

procedure TfBEFilterOperation.acClearExecute(Sender: TObject);
begin
  try
    ClearSearchGroups;
    cbFieldsChange(cbFields);
    eValue.Text := '';
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.acClearExecute');
  end;
end;

function TfBEFilterOperation.GetFilterAsString: string;
var
  i, n: Integer;
begin
  try
    Result := '';
    //TODO: da ne se zabrawi da se mahne -1 (kogat triabwa)
    n := VarArrayHighBound(prFilterString, 1) - 1;
    for i := 0 to n do
      Result := Result + prFilterString[i][0] + prFilterString[i][1] + '''' + prFilterString[i][2] + '''' + ' ' + prFilterString[i][3] + ' ';
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.GetFilterAsString');
  end;
end;


function TfBEFilterOperation.BuildValidFieldName(lcOrigin: string): string;//,lcFieldName
var
  lcPosition: Integer;
begin
  Result := '';
  try
    lcPosition := Pos( '.', lcOrigin );
    if lcPosition > 0 then
      Result := Copy(lcOrigin, lcPosition + 1, Length(lcOrigin));
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.BuildValidFieldName');
  end;
end;

procedure TfBEFilterOperation.FormKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if Key = #13 then acApplyFilter.Execute;
    if Key = #27 then acExit.Execute;
  except
    on E: Exception do
      WriteToLog(E.Message, 'TfBEFilterOperation.FormKeyPress');
  end;
end;

procedure TfBEFilterOperation.cbFieldsChange(Sender: TObject);
var
  fn, PickList: String;
  ffn: TField;
  i, j: Integer;
begin
  fn := prFieldNames.Values[TComboBox(Sender).Text];

  //Търси полето, чието име е избрано
  ffn := nil;
  for i := 0 to prDataSet.FieldCount - 1 do begin
    if Copy(prDataSet.Fields[i].Origin, pos('.', prDataSet.Fields[i].Origin) + 1, Length(prDataSet.Fields[i].Origin)) = fn then begin
      ffn := prDataSet.Fields[i];
      Break;
    end;
  end;

  j := -1;
  for i := 0 to sbFilter.ControlCount - 1 do
    if sbFilter.Controls[i] = Sender then begin
      j := i;
      Break;
    end;

  //Ако е намерено полето - взима типа му
  if (ffn <> nil) and (j > -1) then begin
    //VER( за допълнителните полета взимаме PickList стойностите
    PickList := '';
    //VER)
    sbFilter.Controls[j + 2].Visible := False; //TEdit;
    sbFilter.Controls[j + 4].Visible := False; //TDateTimePicker
    sbFilter.Controls[j + 5].Visible := False; //TComboBox
    case ffn.DataType of
      ftTime :
        begin
          TDateTimePicker(sbFilter.Controls[j + 4]).Kind := dtkTime;
          TDateTimePicker(sbFilter.Controls[j + 4]).Visible := True;
        end;
      ftDate ,
      ftDateTime:
        begin
          TDateTimePicker(sbFilter.Controls[j + 4]).Kind := dtkDate;
          TDateTimePicker(sbFilter.Controls[j + 4]).Visible := True;
        end;
      else
        begin
          if PickList <> '' then begin
            TComboBox(sbFilter.Controls[j + 5]).Items.Text := PickList;
            TComboBox(sbFilter.Controls[j + 5]).Text := '';
            TComboBox(sbFilter.Controls[j + 5]).Visible := True;
          end
          else begin
            TEdit(sbFilter.Controls[j + 2]).Visible := True;
            TEdit(sbFilter.Controls[j + 2]).Text := '';
          end;
        end;
    end;  //case
  end; //if
end;

end.

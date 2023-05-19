unit BaseEntity;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ImgList, Db, ComCtrls, ToolWin, ExtCtrls, DBCtrls,
  StdCtrls, Mask, Buttons, Menus, DBClient, SelectorUtilities,
  ActnList, FileCtrl, Variants, XPMenu, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.Ribbon,
  Vcl.ScreenTips, Vcl.RibbonLunaStyleActnCtrls;

const
  c_strSelectFieldNames = 'CODE;CODEEAN;CODEISO;CODESUPPLIER;NAME;NAME_LATIN';

type
  TfBaseEntity = class(TForm)
    dsList: TDataSource;
    dbgList: TDBGrid;
    pcList: TPageControl;
    tsInfo: TTabSheet;
    Label2: TLabel;
    Splitter2: TSplitter;
    pmList: TPopupMenu;
    miPrint: TMenuItem;
    miHelp: TMenuItem;
    miB1: TMenuItem;
    miFilter: TMenuItem;
    miResetFilter: TMenuItem;
    miB2: TMenuItem;
    miFirst: TMenuItem;
    miPrevious: TMenuItem;
    miNext: TMenuItem;
    miLast: TMenuItem;
    miFind: TMenuItem;
    miB3: TMenuItem;
    miAdd: TMenuItem;
    miEdit: TMenuItem;
    miDelete: TMenuItem;
    miB4: TMenuItem;
    miCancel: TMenuItem;
    miPost: TMenuItem;
    miB5: TMenuItem;
    miExit: TMenuItem;
    lbPositionDescription: TLabel;
    acList: TActionList;
    acSelect: TAction;
    acPrint: TAction;
    miRecSelectSep: TMenuItem;
    miRecSelect: TMenuItem;
    pMainCaptionHolder: TPanel;
    pList: TPanel;
    stFilterInfo: TStaticText;
    Image: TImage;
    sb: TStatusBar;
    acAdd: TAction;
    ImageList: TImageList;
    acHelp: TAction;
    acResetFilter: TAction;
    acFilter: TAction;
    acClose: TAction;
    acCancel: TAction;
    acRefresh: TAction;
    acPost: TAction;
    acDelete: TAction;
    acEdit: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbgListTitleClick(Column: TColumn);
    procedure dsListDataChange(Sender: TObject; Field: TField);
    procedure SetEditMode; virtual;
    procedure SetListMode; virtual;
    procedure tbPrintClick(Sender: TObject);
    procedure dbgListDblClick(Sender: TObject);virtual;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dsListStateChange(Sender: TObject);
    procedure acSelectExecute(Sender: TObject);
    procedure miFirstClick(Sender: TObject);
    procedure miPreviousClick(Sender: TObject);
    procedure miNextClick(Sender: TObject);
    procedure miLastClick(Sender: TObject);
    procedure acPrintExecute(Sender: TObject);
    procedure dbgListDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure acOptionsExecute(Sender: TObject);

    procedure spTextDblClick(Sender: TObject);
    procedure acAddExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acFilterExecute(Sender: TObject);
    procedure acResetFilterExecute(Sender: TObject);
    procedure acHelpExecute(Sender: TObject);
  private
    { Private declarations }
    FormShown: Boolean;
  protected
    { Protected declarations }
    sgList: TStringGrid;
    CDS: array of TClientDataSet;
    prSelectArticleFieldsIn: String;
    prSelectArticleFieldsOut: String;
    LN: Integer;
    procedure LinkToEntity(FormConstant: Integer; fLinkForm: TFormClass; EntityCaption: String; AFieldNames: array of String; AValues: Variant; Owner: TComponent);
    procedure LinkToOperation(FormConstant: Integer; fLinkForm: TFormClass; EntityCaption: String; Owner: TComponent);
    procedure CreatePrintParams; virtual;
    procedure MoveLinkedColumns(DbGrid: TDbGrid; FromIndex, ToIndex: Longint; Column, LinkedColumns: String);
    procedure ReadSqlAndExec(FileName : String);
    procedure ChangeSql(NumQuery : Integer; TblName, SqlAll : String);
    function CanDelete:Boolean; virtual;
    function CanSave:Boolean; virtual;
    function GetLinkField(dbGrid: TDBGrid; TableName: String; var LinkField, LinkValue: String): Integer;
    function Print(Dft: String = 'Default.rtm'): Boolean;
    function GetPrnCaseChrCode: String; virtual;
    function GetPrnCaseIntCode: Integer; virtual;
    function GetCustomTagValueForInvoice(const Tag: AnsiString; var Value: string): boolean;
  public
    { Public declarations }
    pblFormID: Integer;
    SavedABI: Integer;
    SavedAAI: Integer;
    SavedABU: Integer;
    SavedAAU: Integer;
    SavedABD: Integer;
    SavedAAD: Integer;
    SavedNewDoc: Boolean;
    SavedAllowDblClick: Boolean;
    SavedFilter: String;
    SavedWithLink: Boolean;
    LinkFieldNames: array of String;
    LinkKeyValues: Variant;
    OrderField: String;
    SavedFormFilter: String;
    pblHookIsSet: Boolean;
    pblFilterList: OleVariant;
    pblSelectedID: CSelectionList;
    pblDSelectedID: CSelectionList;
    prShowOption: TShowOption;
    prFilterOption: TFilterOption;
    ShowSelector: Boolean;
    AllowChange: Boolean;
    pblIsSelector: Boolean;
    ChangeFieldsArray: array of TChangeFieldStruct;

    {BarCode process Variables}
    lcgDetail: TCustomDBGrid;
    {***************************}

    procedure CallSelector(lcExecuteAction: TAction; var Key: Word);
    procedure SetChangeFields; virtual;
    procedure SetSelectorMode(ShowOption: TShowOption); virtual;
    procedure FieldOnChange(Sender: TField);
    procedure FL_SetToolbar;
    procedure SetPopupMenuItems;
    procedure ShowStockRep(CommonFields, ComFldNames, InfoField, QtyField,
      PriceField, TableName, WhereCls: String);
    procedure FreeStockRep;
    function ShowDataForm(ShowOption: TShowOption; InputFilterList: OleVariant;
             var OutputIDList: CSelectionList; srSQLStatement_ID: integer;
             FilterOption: TFilterOption): TModalResult;
  end;

var
  fBaseEntity: TfBaseEntity;

implementation

uses
  DataModule, ULogUtils, Mess, Utilities, GridOptions, CommonUtilities, UserMonitor,
  FormConstants, BEFilterOperation, uDbFreeReporter, ShellAPI, HTMLViewerUnit,
  SelectMsg, ToolsUnit, Offers;

{$R *.DFM}

procedure TfBaseEntity.FL_SetToolbar;
begin
  try
    if dsList.DataSet.State in [dsEdit, dsInsert] then begin
      SetEditMode;
      acSelect.Enabled := False;
      acEdit.Enabled := False;                                          // Edit
      miEdit.Enabled := False;
      acAdd.Enabled := False;                                           // Insert
      miAdd.Enabled := False;
      acDelete.Enabled := False;                                        // Delete
      miDelete.Enabled := False;
      acCancel.Enabled := True;                                         // Cancel
      miCancel.Enabled := True;
      acPost.Enabled := True;                                           // Post
      miPost.Enabled := True;
      acRefresh.Enabled := False;

      acPrint.Enabled := False;                                         // Print
      miPrint.Enabled := False;
      acFilter.Enabled := False;                                   // Filter
      miFilter.Enabled := False;
      acResetFilter.Enabled := False;                                   // Reset Filter
      miResetFilter.Enabled := False;
      miFirst.Enabled := False;
      miPrevious.Enabled := False;
      miNext.Enabled := False;
      miLast.Enabled := False;
      miFind.Enabled := False;
    end
    else begin
      SetSelectorMode( prShowOption );
      SetListMode;

      acPrint.Enabled := (dsList.DataSet.Active) and (dsList.DataSet.RecordCount > 0);
      miPrint.Enabled := acPrint.Enabled;
      acFilter.Enabled := True;
      miFilter.Enabled := True;
      acResetFilter.Enabled := True;
      miResetFilter.Enabled := True;
      miFirst.Enabled := acPrint.Enabled;
      miPrevious.Enabled    := acPrint.Enabled;
      miNext.Enabled := acPrint.Enabled;
      miLast.Enabled := acPrint.Enabled;
      miFind.Enabled := acPrint.Enabled;
      acAdd.Enabled := True;
      miAdd.Enabled := True;
      acEdit.Enabled := acPrint.Enabled;
      miEdit.Enabled := acPrint.Enabled;
      acDelete.Enabled := acPrint.Enabled;
      miDelete.Enabled := acPrint.Enabled;
      acCancel.Enabled := False;
      miCancel.Enabled := False;
      acPost.Enabled := False;
      miPost.Enabled := False;
      acRefresh.Enabled := True;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.FL_SetToolBar', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.SetEditMode;
var
  Cntr, i, j: Integer;
begin
  try
    for Cntr := 0 to pcList.PageCount - 1 do
      pcList.Pages[Cntr].Enabled := True;

    for Cntr := 0 to pcList.PageCount - 1 do begin
      for i := 0 to pcList.Pages[Cntr].ControlCount - 1 do begin
        if pcList.Pages[Cntr].Controls[i] is TDBGrid then
          TDBGrid(pcList.Pages[Cntr].Controls[i]).ReadOnly := pcList.Pages[Cntr].Controls[i].Tag <> 0
        else if pcList.Pages[Cntr].Controls[i] is TPageControl then begin
          for j := 0 to TPageControl(pcList.Pages[Cntr].Controls[i]).PageCOunt - 1 do
            TPageControl(pcList.Pages[Cntr].Controls[i]).Pages[j].Enabled := True;
        end
        else begin
          if pcList.Pages[Cntr].Controls[i] is TStringGrid then
            TStringGrid(pcList.Pages[Cntr].Controls[i]).Options := TStringGrid(pcList.Pages[Cntr].Controls[i]).Options + [goEditing]
          else
            pcList.Pages[Cntr].Controls[i].Enabled := True;
        end;
      end;
    end;

    if dsList.DataSet.State = dsInsert then
      pcList.ActivePageIndex := 0;

    SelectFirst;
    if Visible then
      SelectNext(ActiveControl, True, True);
    dbgList.Enabled  := False;
    DM.AllowDBLClick := True;
  except
    on E: Exception do begin
      DM.AllowDBLClick := TRUE;
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.SetEditMode', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.SetListMode;
var
  Cntr, i, j: Integer;
begin
  try
    for Cntr := 0 to pcList.PageCount - 1 do
      if pcList.Pages[Cntr].Tag <> 0 then
        pcList.Pages[Cntr].Enabled := True;

    dbgList.Enabled := True;
    if FormShown then dbgList.SetFocus;

    for Cntr := 0 to pcList.PageCount - 1 do begin
      if pcList.Pages[Cntr].Tag <> 0 then
        for i := 0 to pcList.Pages[Cntr].ControlCount - 1 do begin
          if pcList.Pages[Cntr].Controls[i] is TDBGrid then begin
            TDBGrid(pcList.Pages[Cntr].Controls[i]).ReadOnly := True
          end
          else begin
            if pcList.Pages[Cntr].Controls[i] is TPageControl then begin
              for j := 0 to TPageControl(pcList.Pages[Cntr].Controls[i]).PageCOunt - 1 do
                TPageControl(pcList.Pages[Cntr].Controls[i]).Pages[j].Enabled := False;
            end
            else begin
              if pcList.Pages[Cntr].Controls[i] is TStringGrid then    // Ivan 25.06.02
                 TStringGrid(pcList.Pages[Cntr].Controls[i]).Options :=
                   TStringGrid(pcList.Pages[Cntr].Controls[i]).Options - [goEditing]
              else begin
                if not (pcList.Pages[Cntr].Controls[i] is TGraphicControl) then
                  pcList.Pages[Cntr].Controls[i].Enabled := False;
                if (pcList.Pages[Cntr].Controls[i] is TSpeedButton) and
                  ((pcList.Pages[Cntr].Controls[i] as TSpeedButton).Tag <> 1)
                then
                  pcList.Pages[Cntr].Controls[i].Enabled := False;
              end;
            end;
          end;
      end;
    end;
    DM.AllowDBLClick := False;
  except
    on E: Exception do begin
      DM.AllowDBLClick := FALSE;
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.SetListMode', 'Form: ' + self.Name, '');
    end;
  end;
end;

// --------------------------------------------------------------------------------------

procedure TfBaseEntity.FormCreate(Sender: TObject);
var
  Cntr: Integer;
begin
  try
    pblIsSelector := FALSE;
    pblHookIsSet := FALSE;
    prSelectArticleFieldsIn := '';
    prSelectArticleFieldsOut := '';

    if DM.WithLink then begin
      SavedABI := DM.ABeforeInsert;
      SavedAAI := DM.AAfterInsert;
      SavedABU := DM.ABeforeUpdate;
      SavedAAU := DM.AAfterUpdate;
      SavedABD := DM.ABeforeDelete;
      SavedAAD := DM.AAfterDelete;
      SavedNewDoc := DM.ANewDoc;
      SavedWithLink := DM.WithLink;
      SavedAllowDblClick := DM.AllowDBLClick;
    end;
    SetSelectorMode(so_Normal);
    ShowSelector := True;
    AllowChange := True;
    SetChangeFields;

    DM.AllowDBLClick := False;
    Screen.Cursor := crHourGlass;

    Self.Color := clGradientActiveCaption;
    dbgList.FixedColor := clGradientActiveCaption;
    lcgDetail := FindComponent('dbgDetail') as TCustomDBGrid;
    if lcgDetail <> nil then
      TDBGrid(lcgDetail).FixedColor := clGradientActiveCaption;

    OrderField := '';//'ID';
    FormShown := False;

    for Cntr := 0 to ComponentCount - 1 do begin
      if Components[Cntr] is TDataSource then
        if TDataSource(Components[Cntr]).DataSet.Tag in [0, 5] then begin
          TDataSource(Components[Cntr]).DataSet.Open;
        end;

      if Components[Cntr] is TDBGrid then
        LoadGridProp(Application.ExeName, Self.ClassName, TDBGrid(Components[Cntr]));
    end;

    if {(DM.pblClientOptions.FilterDocuments) and} (not DM.WithLink) and (dsList.DataSet.Tag = 5) then
      stFilterInfo.Visible := False;

    SetLength(CDS, 1);
    CDS[0] := TClientDataSet(dsList.DataSet);

    DM.ABeforeInsert := ea_None;
    DM.AAfterInsert := ea_None;
    DM.ABeforeUpdate := ea_None;
    DM.AAfterUpdate := ea_None;
    DM.ABeforeDelete := ea_None;
    DM.AAfterDelete := ea_None;
    DM.ANewDoc := False;

    FL_SetToolbar;
    SetListMode;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.FormCreate', 'Form: ' + self.Name, '');
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TfBaseEntity.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Res: TModalResult;
begin
  try
    if dsList.DataSet.State in dsWriteModes then begin
      Res := MessageDlg('Документът е в режим на редактиране.'#13#10'Запис на промените?', mtConfirmation, [mbYes, mbNo, mbCancel], HelpContext);
      case Res of
        mrYes:
          begin
            acPost.Execute;
            if DM.BadSaving then
              CanClose := False;
          end;
        mrNo:
          acCancel.Execute;
        else
          CanClose := False;
      end;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message , mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.FormCloseQuery', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.FormDestroy(Sender: TObject);
var
  i, Cntr: Integer;
begin
  try
    for i := 0 to High(ChangeFieldsArray) do begin
      if ChangeFieldsArray[i].Field <> nil then
        ChangeFieldsArray[i].Field.OnChange := ChangeFieldsArray[i].OldProc;
    end;

    SetLength(ChangeFieldsArray, 0);

    Screen.Cursor := crHourGlass;

    for Cntr := 0 to ComponentCount - 1 do begin
      if (Components[Cntr] is TDataSource) and (TDataSource(Components[Cntr]).DataSet <> nil) then
        if TDataSource(Components[Cntr]).DataSet.Tag = 0 then
          TDataSource(Components[Cntr]).DataSet.Close;

      if Components[Cntr] is TDBGrid then
        SaveGridProp(Application.ExeName, Self.ClassName, TDBGrid(Components[Cntr]));
    end;

    DM.ABeforeInsert := ea_None;
    DM.AAfterInsert := ea_None;
    DM.ABeforeUpdate := ea_None;
    DM.AAfterUpdate := ea_None;
    DM.ABeforeDelete := ea_None;
    DM.AAfterDelete := ea_None;
    DM.ANewDoc := False;

    if DM.WithLink then begin
      DM.ABeforeInsert := SavedABI;
      DM.AAfterInsert := SavedAAI;
      DM.ABeforeUpdate := SavedABU;
      DM.AAfterUpdate := SavedAAU;
      DM.ABeforeDelete := SavedABD;
      DM.AAfterDelete := SavedAAD;
      DM.ANewDoc := SavedNewDoc;
      DM.AllowDBLClick := SavedAllowDblClick;
      DM.WithLink := SavedWithLink;
    end;

    if CDS[0].State in dsWriteModes then
      DM.ServerData.AppServer.CommitTrans;

    DM.cdsMiscQuery.Close;
    {TODO DRAGO
    DM.cdsMiscQuery2.Close;
    DM.cdsMiscQuery1.Close;
    DM.cdsMiscQueryEx.Close;
    DM.cdsMiscQuery.IndexFieldNames := '';
    DM.cdsMiscQuery2.IndexFieldNames := '';
    DM.cdsMiscQuery1.IndexFieldNames := '';
    DM.cdsMiscQueryEx.IndexFieldNames := '';}

  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.FormDestroy', 'Form: ' + self.Name, '');
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TfBaseEntity.FormKeyPress(Sender: TObject; var Key: Char);
var
  Grid : TDBGrid;
  Cntr : Integer;
begin
  try
    if Key = #13 then begin
      Key := #0;
      if ActiveControl is TDBGrid then begin
        Grid := ActiveControl as TDBGrid;
        Cntr := Grid.SelectedIndex;
        if Cntr = Grid.FieldCount - 1 then
          Grid.SelectedIndex := 0
        else begin
          repeat
            inc(Cntr);
            if(Cntr > Grid.FieldCount-1) then Cntr:=0;
          until (Grid.Columns[Cntr].Visible);
          Grid.SelectedIndex := Cntr;
        end;
        Exit;
      end;
      if ActiveControl is TDBLookupComboBox then
        (ActiveControl as TDBLookupComboBox).CloseUp(True);
      SelectNext(ActiveControl, True, True);
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.FormKeyPress', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.CreatePrintParams;
begin
  //Nothing to do in this time
end;

procedure TfBaseEntity.tbPrintClick(Sender: TObject);                           // Print
begin
  acPrint.Execute;
end;

function TfBaseEntity.CanDelete: Boolean;
begin
  Result := True;
end;

function TfBaseEntity.CanSave: Boolean;
begin
  Result := True;
end;

procedure TfBaseEntity.dbgListDblClick(Sender: TObject);
begin
  acEdit.Execute;
end;

procedure TfBaseEntity.dbgListTitleClick(Column: TColumn);
var
  PacketRec: Integer;
begin
  if (not Assigned(Column.Grid.DataSource.DataSet)) or (not Column.Grid.DataSource.DataSet.Active) then
    Exit;

  if Column.Grid.DataSource.DataSet.State in dsWriteModes then Exit;

  Column.Grid.DataSource.DataSet.DisableControls;
  Screen.Cursor := crHourGlass;
  PacketRec := TClientDataSet(Column.Grid.DataSource.DataSet).PacketRecords;

  try
    if Column.Field.FieldKind = fkData then begin
      TClientDataSet(Column.Grid.DataSource.DataSet).PacketRecords := 0;
      TClientDataSet(Column.Grid.DataSource.DataSet).IndexFieldNames := Column.FieldName;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.dbgListTitleClick', 'Form: ' + self.Name, '');
    end;
  end;
  Screen.Cursor := crDefault;
  TClientDataSet(Column.Grid.DataSource.DataSet).PacketRecords := PacketRec;
  Column.Grid.DataSource.DataSet.First;
  Column.Grid.DataSource.DataSet.EnableControls;
end;

procedure TfBaseEntity.dsListDataChange(Sender: TObject; Field: TField);
begin
  try
    if Visible and (dsList.State in [dsBrowse]) then FL_SetToolbar;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.dsListDataChange', 'Form: ' + self.Name, '');
    end;  
  end;
end;

procedure TfBaseEntity.LinkToEntity(FormConstant: Integer; fLinkForm: TFormClass;
  EntityCaption: String; AFieldNames: array of String; AValues: Variant; Owner: TComponent);
var
  I, J, K: Integer;
  LSavedFormFilter, LSavedFormIndex: TStringList;
  NewFilter: String;
begin
  try
    SavedABI := DM.ABeforeInsert;
    SavedAAI := DM.AAfterInsert;
    SavedABU := DM.ABeforeUpdate;
    SavedAAU := DM.AAfterUpdate;
    SavedABD := DM.ABeforeDelete;
    SavedAAD := DM.AAfterDelete;
    SavedNewDoc := DM.ANewDoc;
    SavedAllowDblClick := DM.AllowDBLClick;
    SavedWithLink := DM.WithLink;
    LSavedFormFilter := TStringList.Create;
    LSavedFormIndex := TStringList.Create;

    for I := 0 to ComponentCount - 1 do
      if Components[I] is TDataSource then begin
        LSavedFormFilter.Add((Components[I] as TDataSource).DataSet.Filter);
        LSavedFormIndex.Add(TClientDataSet(TDataSource(Components[I]).DataSet).IndexFieldNames);
      end;

    DM.WithLink := True;

    with fLinkForm.Create(Owner) as TFBaseEntity do begin
      Caption := sys_ClientVersion;
      pblFormID := FormConstant;
      pList.Caption := ' ' + EntityCaption;
      SetLength(LinkFieldNames,Length(AFieldNames));
      for I:= 0 to High(AFieldNames) do LinkFieldNames[I] := AFieldNames[I];
      LinkKeyValues := AValues;
      NewFilter := DM.ServerData.AppServer.GetFilter(TClientDataSet(dsList.DataSet).ProviderName);

      for I:= 0 to High(LinkFieldNames) do begin                             // Disable Key Controls
        //Ivan 20.02.2001
        if NewFilter <> '' then NewFilter := NewFilter + ' AND ' + LinkFieldNames[I] + '=''' + LinkKeyValues[I] + '''';
        NewFilter := LinkFieldNames[I] + '=''' + LinkKeyValues[I] + '''';
        for J := 0 to pcList.PageCount - 1 do
          for K := 0 to pcList.Pages[J].ControlCount - 1 do
            if dsList.DataSet.FieldByName(LinkFieldNames[I]).DisplayLabel = pcList.Pages[J].Controls[K].Hint then
              pcList.Pages[J].Controls[K].Enabled := False;
      end;

      DM.ServerData.AppServer.RequestDoc(TClientDataSet(dsList.DataSet).ProviderName, NewFilter);

      dsList.DataSet.Close;
      dsList.DataSet.Open;

      ShowModal;

      Free;
    end;

    J := 0;
    for I := 0 to ComponentCount - 1 do
      if Components[I] is TDataSource then begin
        if TDataSource(Components[I]).Dataset.Filter <> LSavedFormFilter[J] then
          TDataSource(Components[I]).Dataset.Filter := LSavedFormFilter[J];
        if TClientDataSet(TDataSource(Components[I]).Dataset).IndexFieldNames <> LSavedFormIndex[J] then
          TClientDataSet(TDataSource(Components[I]).Dataset).IndexFieldNames := LSavedFormIndex[J];
        Inc(J);
      end;

    LSavedFormFilter.Free;
    LSavedFormIndex.Free;
    DM.ABeforeInsert := SavedABI;
    DM.AAfterInsert := SavedAAI;
    DM.ABeforeUpdate := SavedABU;
    DM.AAfterUpdate := SavedAAU;
    DM.ABeforeDelete := SavedABD;
    DM.AAfterDelete := SavedAAD;
    DM.ANewDoc := SavedNewDoc;
    DM.WithLink := SavedWithLink;
    DM.AllowDBLClick := SavedAllowDblClick;

    FL_SetToolbar;

  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.LinkToEntity', 'Form: ' + self.Name, 'Link to form: ' + fLinkForm.ClassName);
      FL_SetToolBar;
    end;
  end;
end;

procedure TfBaseEntity.dsListStateChange(Sender: TObject);
begin
  try
    if (Sender is TClientDataSet) and (Sender as TClientDataSet).Active then
      FL_SetToolBar;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.dsListStateChange', 'Form: ' + self.Name, '');
    end;  
  end;
end;

procedure TfBaseEntity.LinkToOperation(FormConstant: Integer; fLinkForm: TFormClass;
  EntityCaption: String; Owner: TComponent);
var
  lc_strMasterID: String;
begin
  try
    lc_strMasterID := CDS[0].FieldByName('ID').AsString;

    SavedABI := DM.ABeforeInsert;
    SavedAAI := DM.AAfterInsert;
    SavedABU := DM.ABeforeUpdate;
    SavedAAU := DM.AAfterUpdate;
    SavedABD := DM.ABeforeDelete;
    SavedAAD := DM.AAfterDelete;
    SavedNewDoc := DM.ANewDoc;
    SavedWithLink := DM.WithLink;
    SavedAllowDblClick := DM.AllowDBLClick;

    DM.WithLink  := True;

    with fLinkForm.Create(Owner) as TFBaseEntity do begin
      Caption := sys_ClientVersion;

      CDS[0].DisableControls;
      DM.ReOpen( CDS[0] );
      CDS[0].EnableControls;

      pblFormID := FormConstant;
      pList.Caption := ' ' + EntityCaption;

      ShowModal;

      Free;
    end;

    //Added by PETER on 16.05.2002.
    //if the current form is used as a selector in the link form
    //then CDSs of the current form are closed,
    //because of the closure of all CDSs OnFormClose event.

    SavedFormFilter := UpperCase( CDS[0].ProviderName ) + '.ID = ' + QuotedStr( lc_strMasterID );
    acRefresh.Execute;

    DM.ABeforeInsert := SavedABI;
    DM.AAfterInsert := SavedAAI;
    DM.ABeforeUpdate := SavedABU;
    DM.AAfterUpdate := SavedAAU;
    DM.ABeforeDelete := SavedABD;
    DM.AAfterDelete := SavedAAD;
    DM.ANewDoc := SavedNewDoc;
    DM.WithLink := SavedWithLink;
    DM.AllowDBLClick := SavedAllowDblClick;

    FL_SetToolbar;

  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      FL_SetToolBar;
      WriteToLog(E.Message, 'BASEENTITY.LinkToOperation', 'Form: ' + self.Name, 'Link to form: ' + fLinkForm.ClassName);
    end;
  end;
end;

function TfBaseEntity.ShowDataForm(ShowOption: TShowOption; InputFilterList: OleVariant;
         var OutputIDList: CSelectionList; srSQLStatement_ID: integer;
         FilterOption: TFilterOption): TModalResult;
begin
  try
    //TODO DRAGO Caption := sys_ClientVersion;

    pblIsSelector := True;
    pblFilterList := InputFilterList;
    pblSelectedID := OutputIDList;
    SetSelectorMode(ShowOption);
    prShowOption := ShowOption;
    prFilterOption := FilterOption;

    DM.ServerData.AppServer.RequestDocEx(CDS[0].ProviderName, srSQLStatement_ID, pblFilterList, False);
    CDS[0].Close;
    CDS[0].Open;

    FL_SetToolBar;

    if ((VarArrayHighBound(pblFilterList, 1) = 1) and (pblFilterList[0][2] = '%')) or (VarArrayHighBound(pblFilterList, 1) = 0) then
      stFilterInfo.Visible := FALSE
    else
      stFilterInfo.Visible := TRUE;

    Result := ShowModal;

    OutputIDList := pblSelectedID;
  except
    on E: Exception do begin
      DM.WithLink := SavedWithLink;
      Result := mrCancel;
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.ShowDataForm', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.acSelectExecute(Sender: TObject);
var
  i, j: Integer;
begin
  try
    case prShowOption of
      so_SelectSingle:
        begin
          for i := 0 to High(pblSelectedID[0]) do
            pblSelectedID[0][i].FieldValue :=
              TClientDataSet(dbgList.DataSource.DataSet).FieldByName(pblSelectedID[0][i].FieldName).Value;
          ModalResult := mrOK;
        end;

      so_SelectMulty:
      begin
        dbgList.SelectedRows.CurrentRowSelected := TRUE;

        if dbgList.SelectedRows.Count > 0 then begin
          with TClientDataSet(dbgList.DataSource.DataSet) do begin
            SetLength(pblSelectedID, dbgList.SelectedRows.Count);

            //init pblSelectedID
            for i := 1 to High(pblSelectedID) do begin
              SetLength(pblSelectedID[i], Length(pblSelectedID[0]));
              for j:= 0 to High(pblSelectedID[0]) do begin
                pblSelectedID[i][j].cdsField := pblSelectedID[0][j].cdsField;
                pblSelectedID[i][j].FieldName := pblSelectedID[0][j].FieldName;
              end;
            end;

            //fill the data cells
            for i := 0 to dbgList.SelectedRows.Count - 1 do begin
              GotoBookmark(pointer(dbgList.SelectedRows.Items[i]));
              for j := 0 to High(pblSelectedID[i]) do
                pblSelectedID[i][j].FieldValue :=
                  TClientDataSet(dbgList.DataSource.DataSet).FieldByName(pblSelectedID[i][j].FieldName).Value;
            end;

          end;
          ModalResult := mrOK;
        end
        else begin
          pblSelectedID := nil;
          ModalResult := mrCancel;
        end;
      end;
    end; //case
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.acSelectExecute', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.SetSelectorMode(ShowOption: TShowOption);
begin
  try
    prShowOption := ShowOption;
    //Set database grid here
    case ShowOption of
      so_Normal : //Normal
        begin
          dbgList.Options := dbgList.Options - [dgMultiSelect, dgRowSelect];
          acSelect.Enabled := False;
          dbgList.OnDblClick := dbgListDblClick;
        end;
      so_SelectSingle : //SelectSingle CanInsert
        begin
          dbgList.Options := dbgList.Options - [dgMultiSelect] + [dgRowSelect];
          acSelect.Enabled := dsList.DataSet.RecordCount > 0;
          dbgList.OnDblClick := acSelectExecute;
        end;
      so_SelectMulty : //SelectMultiple CanInsert
        begin
          dbgList.Options := dbgList.Options + [dgMultiSelect, dgRowSelect];
          acSelect.Enabled := dsList.DataSet.RecordCount > 0;
          dbgList.OnDblClick := acSelectExecute;
        end;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.SetSelectorMode', 'Form: ' + Self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.CallSelector(lcExecuteAction: TAction;
  var Key: Word);
begin
  try
    if (GetKeyState(VK_CONTROL) and $80 > 0) and (Key = VK_RETURN) then begin
      Key := 0;
      lcExecuteAction.Execute;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.CallSelector', 'Form: ' + Self.Name, '');
    end;  
  end;
end;

procedure TfBaseEntity.FieldOnChange(Sender: TField);
var
  i: Integer;
begin
  if AllowChange then begin
    AllowChange := False;
    try
      for i := 0 to High(ChangeFieldsArray) do
        if (Sender as TField) = ChangeFieldsArray[i].Field then begin
          ShowSelector := False;
          ChangeFieldsArray[i].ExecAction.Execute;
          ShowSelector := True;

          if Assigned(ChangeFieldsArray[i].OldProc) then   //Викаме Default OnChange
            ChangeFieldsArray[i].OldProc(Sender);
        end;
    except
      on E: Exception do begin
        MessageDlg(E.Message, mtError, [mbOk], HelpContext);
        WriteToLog(E.Message, 'BASEENTITY.FieldOnChange', 'Form: ' + self.Name, '');
      end;
    end;
    AllowChange := True;
  end;
end;

procedure TfBaseEntity.miFirstClick(Sender: TObject);
begin
  try
    dsList.DataSet.First;
    SetPopupMenuItems;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.miFirstClick', 'Form: ' + self.Name, '');
    end;  
  end;
end;

procedure TfBaseEntity.miPreviousClick(Sender: TObject);
begin
  try
    dsList.DataSet.Prior;
    SetPopupMenuItems;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.miPreviousClick', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.miNextClick(Sender: TObject);
begin
  try
    dsList.DataSet.Next;
    SetPopupMenuItems;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.miNextClick', 'Form: ' + self.Name, '');
    end;  
  end;
end;

procedure TfBaseEntity.miLastClick(Sender: TObject);
begin
  try
    dsList.DataSet.Last;
    SetPopupMenuItems;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.miLastClick', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.SetPopupMenuItems;
begin
  try
    miFirst.Enabled := TRUE;
    miPrevious.Enabled := TRUE;
    miNext.Enabled := TRUE;
    miLast.Enabled := TRUE;

    if dsList.DataSet.Eof then begin
      miNext.Enabled := FALSE;
      miLast.Enabled := FALSE;
    end;

    if dsList.DataSet.Bof then begin
      miFirst.Enabled := FALSE;
      miPrevious.Enabled := FALSE;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.SetPopupMenuItems', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.acPrintExecute(Sender: TObject);
begin
  Print('Default.rtm');
end;

procedure TfBaseEntity.acRefreshExecute(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;

    if SavedFormFilter <> '' then
      DM.ServerData.AppServer.RequestDoc( (dsList.DataSet as TClientDataSet).ProviderName, SavedFormFilter, '', 0);

    DM.ReOpen(dsList.DataSet);
    FL_SetToolbar;
  except
    on E: Exception do begin
      MessageDlg('Грешка при актуализация!'#13#10 + E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.tbRefreshClick', 'Form: ' + self.Name, '');
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TfBaseEntity.acResetFilterExecute(Sender: TObject);
var
  lcOrder: String;
begin
  Screen.Cursor := crHourGlass;
  dsList.DataSet.DisableControls;
  try
    SavedFormFilter := '';

    DM.ServerData.AppServer.RequestDoc((dsList.DataSet as TClientDataSet).ProviderName, SavedFormFilter, lcOrder, 0);
    DM.ReOpen(dsList.DataSet);
    FL_SetToolBar;
  except
    on E: Exception do begin
      if Pos( 'midas.dll', E.Message ) > 0 then
        MessageDlg('Операцията не може да бъде изпълнена!', mtError, [mbOk], HelpContext)
      else
        MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.tbResetFilterClick', 'Form: ' + self.Name, '');
    end;
  end;
  dsList.DataSet.EnableControls;
  stFilterInfo.Visible := False;
  Screen.Cursor := crDefault;
end;

procedure TfBaseEntity.dbgListDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  {TODO DRAGO
  try
    if (not (gdSelected in State)) or (not dbgList.Focused and not (dgAlwaysShowSelection in (Sender as TDBGrid).Options)) then begin
      if dsList.DataSet.FindField('DOCSTATUS_ID') <> nil then begin
        case dsList.DataSet.FieldByName('DocStatus_ID').AsInteger of
         1: begin  //Неприключен
              dbgList.Canvas.Brush.Color := DM.cl_Actv_Doc;
            end;
         2: begin  //Приключен
              dbgList.Canvas.Brush.Color := DM.cl_Fnsh_Doc;
            end;
         3: begin  //Анулиран
              dbgList.Canvas.Brush.Color := DM.cl_Anul_Doc;
            end;
         4: begin  //Анулиращ
              dbgList.Canvas.Brush.Color := DM.cl_Annuling_Doc;
            end;
         5: begin  //Закрит
              dbgList.Canvas.Brush.Color := $00D6F5D3;
            end;
        end;//case
      end;

      case pblFormID of
        fc_Request :
          begin
            case DM.cdsRequest.FieldByName('RequestType_ID').AsInteger of
              1 : dbgList.Canvas.Font.Color := DM.cl_Req_Clnt;
              2 : dbgList.Canvas.Font.Color := DM.cl_Req_Dstr;
              3 : dbgList.Canvas.Font.Color := DM.cl_Req_Rglr;
              4 : dbgList.Canvas.Font.Color := DM.cl_Req_Month;
             end;
           end;//fc_Request

        fc_Sale :
          begin
            if ( DM.cdsSales.FieldByName('SALETYPE_ID').AsInteger in [0, 8] ) or
              (dsList.DataSet.FieldByName('DocStatus_ID').AsInteger > 2 )
            then
              dbgList.Canvas.Font.Color := clBlack
            else
              if ( RoundUp(DM.cdsSales.FieldByName('CurrencyValue').AsFloat) <=
                 RoundUp(DM.cdsSales.FieldByName('PayedCurrency').AsFloat) )
              then dbgList.Canvas.Font.Color := DM.cl_ReqPay
              else dbgList.Canvas.Font.Color := DM.cl_ReqPayNot;
          end;//fc_Sale

        fc_BlockStoreQuantity :
          begin
            if DM.cdsClientStore.FieldByName('ALLUNBLOCKED').AsInteger <> 0 then
              dbgList.Canvas.Brush.Color := DM.cl_Proc_Doc;
          end;//fc_BlockStoreQuantity

        fc_Credits :
          begin
            if RoundUp(DM.cdsCredits.FieldByName('TOTALSUM').AsFloat) <=
               RoundUp(DM.cdsCredits.FieldByName('PAYEDSUM').AsFloat)
            then dbgList.Canvas.Font.Color := DM.cl_ReqPay
            else dbgList.Canvas.Font.Color := DM.cl_ReqPayNot;
          end;

        else begin
          if (not (dgRowSelect in dbgList.Options)) or (dgMultiSelect in dbgList.Options) then
            dbgList.Canvas.Font.Color := clBlack;
        end;
      end;//case pblFormID
      dbgList.Canvas.FillRect(Rect);
    end;

    dbgList.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      dbgList.DefaultDrawColumnCell(Rect, DataCol, Column, State);
      WriteToLog(E.Message, 'BASEENTITY.', 'Form: ' + self.Name, '');
    end;
  end; }
end;

procedure TfBaseEntity.FormShow(Sender: TObject);
begin
  sb.Panels[0].Text := DM.CurrentUserName;
end;

function TfBaseEntity.GetCustomTagValueForInvoice(const Tag: AnsiString;
  var Value: string): boolean;
var
  r: Real;
begin
  Result := True;
  if Tag = 'PartTotal' then begin
    r := DM.cdsOffersDetail['Qty'] * DM.cdsOffersDetail['Price'];
    Value := FormatFloat('0.00', r);
  end 
  else if Tag= 'LN' then begin
    Value := IntToStr(LN);
    Inc(LN);
  end
  else
    Result := False;
end;

function TfBaseEntity.GetLinkField(dbGrid: TDBGrid; TableName: String; var LinkField, LinkValue: String): Integer;
var
  lcFN: String;
  lcFound: Boolean;
  lcCount, i: Integer;
begin
  try
    lcFN := '';

    if Assigned(dbGrid) then begin
      if Assigned(dbGrid.SelectedField) then begin
        lcFN := dbGrid.SelectedField.FieldName;
        LinkValue := dbGrid.SelectedField.AsString;
      end;

      if lcFN <> '' then begin
        lcCount := GetFieldsCount( prSelectArticleFieldsOut, ';' );
        i := 1;
        lcFound := False;

        while not lcFound and (i <= lcCount) do begin
          if lcFN = GetField(prSelectArticleFieldsOut, ';', i) then begin
            lcFound := True;
            lcFN := GetField(prSelectArticleFieldsIn, ';', i);
          end;
          Inc(i);
        end;

        if lcFound then begin
          lcCount := GetFieldsCount(c_strSelectFieldNames, ';');
          i := 1;
          lcFound := False;

          while not lcFound and (i <= lcCount) do begin
            if lcFN = GetField( c_strSelectFieldNames, ';', i) then begin
              lcFound := True;
              LinkField := UpperCase( TableName ) + '.' + lcFN;
            end;
            Inc(i);
          end;

          if not lcFound then Result := 1
          else Result := 0;
        end
        else Result := 1;
      end
      else Result := 1;

      if Result = 1 then begin
        Result  := 0;
        lcCount := GetFieldsCount(prSelectArticleFieldsOut, ';');
        i := 1;
        lcFound := False;

        while not lcFound and (i <= lcCount) do begin
          if 'ID' = GetField(prSelectArticleFieldsIn, ';', i) then begin
            lcFound := True;
            lcFN := GetField(prSelectArticleFieldsOut, ';', i);
          end;

          inc(i);
        end;

        LinkField := UpperCase( TableName ) + '.ID';

        if lcFound then
          LinkValue := dbGrid.DataSource.DataSet.FieldByName( lcFN ).AsString
        else
          LinkValue := '';
      end;
    end
    else begin
      Result := 0;
      LinkField := UpperCase(TableName) + '.ID';
      LinkValue := '';
    end;
  except
    on E: Exception do begin
      Result := -1;
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WritetoLog(E.Message, 'BASEENTITY.GetLinkField', '', ' Form: ' + self.ClassName);
    end;
  end;
end;

procedure TfBaseEntity.SetChangeFields;
begin
  // do nothing here
end;
 
procedure TfBaseEntity.FreeStockRep;
var
  Comp : TControl;
begin
  try
    dbgList.Enabled := True;
    ActiveControl := dbgList;
    if Assigned(sgList) then begin
      sgList.Free;
      sgList := nil;
    end;
    Comp := TControl(FindComponent('dbgDetail'));
    if Comp <> nil then
      Comp.Visible := True;
  except
  end;
end;

procedure TfBaseEntity.ShowStockRep(CommonFields, ComFldNames, InfoField,
  QtyField, PriceField, TableName, WhereCls: String);
var
  i, j, FldCount: Integer;
  Comp: TControl;
  slComp: TStringList;
  fOldQty, fOldPrice: Double;
  Found, lcFlag: Boolean;
  sTmp: String;
begin
  if dsList.State in dsWriteModes then Exit;
  slComp := TStringList.Create;
  try
    Comp := TControl(FindComponent('dbgDetail'));
    if Comp = nil then Abort;
    if Assigned(sgList) then Abort;
    dbgList.Enabled := False;
    sgList := TStringGrid.Create(Comp.Owner);
    sgList.Visible := False;
    sgList.Parent := Comp.Parent;
    sgList.Left := Comp.Left;
    sgList.Height := Comp.Height;
    sgList.Top := Comp.Top;
    sgList.Width := Comp.Width;
    sgList.Anchors := Comp.Anchors;

    sgList.Visible := True;
    Comp.Visible := False;
    ActiveControl := sgList;
    sgList.DefaultRowHeight := 18;
    sgList.FixedRows := 1;
    sgList.FixedCols := 0;
    //sgList.FixedColor := clInfoBk;
    sTmp := InfoField + ',' + CommonFields;
    FldCount := GetFieldsCount(sTmp, ',');
    sgList.RowCount := 2;
    sgList.ColCount := FldCount + 2;

    sgList.Options := sgList.Options + [goColSizing];
    DM.SetCommandText(DM.cdsMiscQuery, 'SELECT ' + CommonFields + ', ' +
      InfoField + ', SUM(' + QtyField + ' * ' + PriceField + ') PRICE , ' +
      'SUM(' + QtyField + ') QUANTITY FROM ' +
      TableName + ' WHERE ' + WhereCls +
      ' GROUP BY ' + CommonFields + ', ' + InfoField +
      ' ORDER BY ' + sTmp);

    if not DM.cdsMiscQuery.IsEmpty then begin
      DM.cdsMiscQuery.First;
      for i := 1 to GetFieldsCount(CommonFields, ',') do
        sgList.Cells[i - 1, 0] := GetField(ComFldNames, ',', i);
      // InfoField e samo edno
      sgList.Cells[FldCount - 1, 0] := DM.cdsMiscQuery.FieldByname(InfoField).AsString; // InfoField Value
      sgList.Cells[sgList.ColCount - 2, 0] := 'Броя';
      sgList.Cells[sgList.ColCount - 1, 0] := 'Сума';
      sgList.ColWidths[1] := 200;
      slComp.Clear;
      for i := 1 to GetFieldsCount(CommonFields, ',') do begin
        sgList.Cells[i - 1, 1] := DM.cdsMiscQuery.Fields[i - 1].AsString;
        slComp.Add(DM.cdsMiscQuery.Fields[i - 1].AsString);
      end;
      sgList.Cells[FldCount - 1, 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat); // QTY
      sgList.Cells[sgList.ColCount - 2, 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
      sgList.Cells[sgList.ColCount - 1, 1] := FormatFloat('0.00', DM.cdsMiscQuery.FieldByName('PRICE').AsFloat);

      DM.cdsMiscQuery.Next;
      while not DM.cdsMiscQuery.Eof do begin
        Found := False;
        lcFlag := True;
        for i := 1 to GetFieldsCount(CommonFields, ',') do
          lcFlag := lcFlag and (slComp[i - 1] = DM.cdsMiscQuery.Fields[i - 1].AsString);
        // ako obshtite koloni sa ravni - obhojdame i dobaviame nova kolona za razmer
        if lcFlag then begin
          for i := FldCount - 1 to sgList.ColCount - 3 do
            if sgList.Cells[i, 0] = DM.cdsMiscQuery.FieldByName(InfoField).AsString then begin
              if sgList.Cells[i, sgList.RowCount - 1] > '' then
                fOldQty := StrToFloat(sgList.Cells[i, sgList.RowCount - 1])
              else
                fOldQty := 0;
              sgList.Cells[i, sgList.RowCount - 1] := FormatFloat('0.', fOldQty + DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
              // kolona obshto Qty
              if sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] <> '' then
                fOldQty := StrToFloat(sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1])
              else
                fOldQty := 0;
              sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] := FormatFloat('0.00', fOldQty + DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
              // kolona price
              if sgList.Cells[sgList.ColCount - 1, sgList.RowCount - 1] <> '' then
                fOldPrice := StrToFloat(sgList.Cells[sgList.ColCount - 1, sgList.RowCount - 1])
              else
                fOldPrice := 0;
              sgList.Cells[sgList.ColCount - 1, sgList.RowCount - 1] := FormatFloat('0.00', fOldPrice + DM.cdsMiscQuery.FieldByName('PRICE').AsFloat);
              Found := True;
              Break;
            end;
          // ne e namerena kolona s takav razmer
          if not Found then begin
            sgList.ColCount := sgList.ColCount + 1;
            sgList.Cells[sgList.ColCount - 1, 0] := DM.cdsMiscQuery.FieldByName(InfoField).AsString;
            sgList.Cells[sgList.ColCount - 1, sgList.RowCount - 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
            // kolona price
            if sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] <> '' then
              fOldPrice := StrToFloat(sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1])
            else
              fOldPrice := 0;
            sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] := FormatFloat('0.00', fOldPrice + DM.cdsMiscQuery.FieldByName('PRICE').AsFloat);
            if sgList.Cells[sgList.ColCount - 3, sgList.RowCount - 1] <> '' then
              fOldQty := StrToFloat(sgList.Cells[sgList.ColCount - 3, sgList.RowCount - 1])
            else
              fOldQty := 0;
            sgList.Cells[sgList.ColCount - 3, sgList.RowCount - 1] := FormatFloat('0.', fOldQty + DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);

            slComp.Clear;
            slComp.Assign(sgList.Cols[sgList.ColCount - 1]);
            sgList.Cols[sgList.ColCount - 1] := sgList.Cols[sgList.ColCount - 2];
            sgList.Cols[sgList.ColCount - 2] := sgList.Cols[sgList.ColCount - 3];
            sgList.Cols[sgList.ColCount - 3] := slComp;
          end;
        end
        else begin
          sgList.RowCount := sgList.RowCount + 1;
          for i := 1 to GetFieldsCount(CommonFields, ',') do
            sgList.Cells[i - 1, sgList.RowCount - 1] := DM.cdsMiscQuery.Fields[i - 1].AsString;
          for i := 4 to sgList.ColCount - 3 do
            if sgList.Cells[i, 0] = DM.cdsMiscQuery.FieldByName(InfoField).AsString then begin
              sgList.Cells[i, sgList.RowCount - 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
              sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
              sgList.Cells[sgList.ColCount - 1, sgList.RowCount - 1] := FormatFloat('0.00', DM.cdsMiscQuery.FieldByName('PRICE').AsFloat);
              Found := True;
              Break;
            end;
          if not Found then begin
            sgList.ColCount := sgList.ColCount + 1;
            sgList.Cells[sgList.ColCount - 1, 0] := DM.cdsMiscQuery.FieldByName(InfoField).AsString;
            sgList.Cells[sgList.ColCount - 1, sgList.RowCount - 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);
            // kolona price
            sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] := FormatFloat('0.00', DM.cdsMiscQuery.FieldByName('PRICE').AsFloat);
            sgList.Cells[sgList.ColCount - 3, sgList.RowCount - 1] := FormatFloat('0.', DM.cdsMiscQuery.FieldByName('QUANTITY').AsFloat);

            slComp.Clear;
            slComp.Assign(sgList.Cols[sgList.ColCount - 1]);
            sgList.Cols[sgList.ColCount - 1] := sgList.Cols[sgList.ColCount - 2];
            sgList.Cols[sgList.ColCount - 2] := sgList.Cols[sgList.ColCount - 3];
            sgList.Cols[sgList.ColCount - 3] := slComp;
          end;
        end;

        slComp.Clear;
        for i := 1 to GetFieldsCount(CommonFields, ',') do
          slComp.Add(DM.cdsMiscQuery.Fields[i - 1].AsString);
        DM.cdsMiscQuery.Next;
      end;
      sgList.RowCount := sgList.RowCount + 2;
      for i := FldCount - 1 to sgList.ColCount - 3 do begin
        fOldQty := 0;
        for j := 1 to sgList.RowCount - 3 do begin
          if sgList.Cells[i, j] <> '' then
            fOldQty := fOldQty + StrToFloat(sgList.Cells[i, j]);
        end;
        sgList.Cells[i, sgList.RowCount - 1] := FormatFloat('0.', fOldQty);
      end;
      fOldPrice := 0;

      sgList.ColCount := sgList.ColCount + 1;
      sgList.Cells[sgList.ColCount - 1, 0] := 'Цена';

      for j := 1 to sgList.RowCount - 3 do begin
        if sgList.Cells[sgList.ColCount - 2, j] <> '' then begin
          fOldPrice := fOldPrice + StrToFloat(sgList.Cells[sgList.ColCount - 2, j]);

          if RoundUp( StrToFloat(sgList.Cells[sgList.ColCount - 3, j] ) ) = 0 then
            sgList.Cells[sgList.ColCount - 1, j] := '0'
          else
            sgList.Cells[sgList.ColCount - 1, j] :=
              FormatFloat('0.00', StrToFloat(sgList.Cells[sgList.ColCount - 2, j]) /
              StrToFloat(sgList.Cells[sgList.ColCount - 3, j]));
        end;
      end;
      sgList.Cells[sgList.ColCount - 2, sgList.RowCount - 1] := FormatFloat('0.00', fOldPrice);
      sgList.Cells[0, sgList.RowCount - 2] := 'Общо'
    end;
  except
    on E: EAbort do begin
      FreeStockRep;
      if Assigned(slComp) then slComp.Free;
    end;
    on E: Exception do begin
      FreeStockRep;
      if Assigned(slComp) then slComp.Free;
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
    end;
  end;
end;

procedure TfBaseEntity.MoveLinkedColumns(DbGrid: TDbGrid; FromIndex,
  ToIndex: Integer; Column, LinkedColumns: String);
var
  i, j, lc_intIndex: Integer;
begin
  try
    lc_intIndex := ToIndex;

    if DbGrid.Columns[ToIndex].FieldName = Column then
      for j := 1 to GetFieldsCount( LinkedColumns, ';' ) do
        for i := 0 to DbGrid.Columns.Count - 1 do
          if DbGrid.Columns[i].FieldName = GetField( LinkedColumns, ';', j ) then
          begin
            if DbGrid.Columns[i].Index > ToIndex then
              lc_intIndex := lc_intIndex + 1;

            DbGrid.Columns[i].Index := lc_intIndex;
          end;
  except
    on E: Exception do
    begin
      MessageDlg( E.Message, mtError, [mbOK], 0 );
      WriteToLog( E.Message, 'BaseEntity.MoveLinkedColumns', '', '' );
    end;
  end;
end;

procedure TfBaseEntity.acAddExecute(Sender: TObject);
begin
  try
    if ((Sender as TComponent).Tag = 14) and not CanDelete then
      raise Exception.Create('Записът не може да бъде изтрит!');

    if ((Sender as TComponent).Tag = 16) then begin
      SavedFormFilter := DM.ServerData.AppServer.GetFilter(TClientDataSet(dsList.DataSet).ProviderName);
      if not CanSave then
        raise Exception.Create('Невалиден документ. Не може да се съхрани!');
    end;

    DM.FL_ButtonClick(pmList, (Sender as TComponent).Tag, CDS);

    FL_SetToolbar;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.tbButtonClick', 'Form: ' + Self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.acCloseExecute(Sender: TObject);
begin
  try
    ModalResult := mrCancel; // was mrOK but changed by Ivan
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.tbCloseClick', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.acFilterExecute(Sender: TObject);
var
  lcSqlStatementID, i: Integer;
  lcModalResult: TModalResult;
begin
  try
    if pblFormID < 1 then begin
      MessageDlg('Филтърът не може да се изпълни! Формата няма константа!', mtError, [mbOK], 0 );
    end
    else begin
       lcSqlStatementID := GetFormSqlStatement(pblFormID);

      if lcSqlStatementID < 1 then
        MessageDlg('Филтърът не може да се изпълни! Формата няма заявка!', mtError, [mbOK], 0 )
      else
        with TfBEFilterOperation.Create( self ) do begin
          if VarIsEmpty( pblFilterList ) then
            pblFilterList := VarArrayOf( [VarArrayOf( [';',';',';',';'] )] );

          lcModalResult := ShowFilterForm(dsList, pblFilterList, pblFilterList);

          if lcModalResult = mrOK then begin
            Application.ProcessMessages;

            if lcSqlStatementID = sc_Mashine then
              for i := 0 to VarArrayHighBound(pblFilterList, 1) - 1 do begin
                if SameText(pblFilterList[i][0], 'CLIENT.NAME')
                or SameText(pblFilterList[i][0], 'MASHINESERIAL.SERIALNO')
                or SameText(pblFilterList[i][0], 'MASHINESERIAL.ENGINE') then
                  lcSqlStatementID := sc_MashineClient;
              end;

            if DM.ServerData.AppServer.FilterDocuments(
                (dsList.DataSet as TClientDataSet).ProviderName,
                lcSqlStatementID,
                pblFilterList,
                SavedFormFilter ) = 0 then
            begin
              Screen.Cursor := crHourGlass;

              DM.ReOpen(dsList.DataSet);

              stFilterInfo.Visible := True;
              FL_SetToolBar;
              if Assigned(dsList.DataSet.AfterScroll) then
                dsList.DataSet.AfterScroll(dsList.DataSet);
            end;
          end;

          Free;
        end;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.tbApplyFilterClick', 'Form: ' + self.Name, 'Filter: ' + SavedFormFilter);
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TfBaseEntity.acHelpExecute(Sender: TObject);
begin
  try
    Application.HelpContext(Screen.ActiveForm.HelpContext);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.tbHelpClick', 'Form: ' + self.Name, '');
    end;
  end;
end;

procedure TfBaseEntity.acOptionsExecute(Sender: TObject);
begin
  if ActiveControl is TDbGrid then
    ShowGridOptions(ActiveControl as TDbGrid);
end;

procedure TfBaseEntity.ReadSqlAndExec(FileName : String);
var
  lc_txtSqlFile: TextFile;
  lc_strCurRow, lc_strTblName, lc_strSqlAll: String;
  lc_first, lc_NumQuery: Integer;
begin
  AssignFile(lc_txtSqlFile, FileName);
  Reset(lc_txtSqlFile);
  ReadLn(lc_txtSqlFile, lc_strCurRow);
  lc_first := 1;
  lc_NumQuery := 0;

  while not Eof(lc_txtSqlFile) do begin
    if Copy(lc_strCurRow, 0, 3) = '<##' then begin
      if lc_first <> 1 then begin
        Inc(lc_NumQuery);
        ChangeSql(lc_NumQuery, lc_strTblName, lc_strSqlAll);
        lc_strSqlAll := '';
      end;
      lc_strTblName := Copy(lc_strCurRow, 4, Pos('##>', lc_strCurRow) - 4);
    end
    else
      lc_strSqlAll := lc_strSqlAll + lc_strCurRow;

    ReadLn(lc_txtSqlFile, lc_strCurRow);
    lc_first := lc_first + 1;
  end;

  Inc(lc_NumQuery);
  ChangeSql(lc_NumQuery, lc_strTblName, lc_strSqlAll);
  CloseFile(lc_txtSqlFile);
end;

procedure TfBaseEntity.ChangeSql(NumQuery : Integer; TblName, SqlAll : String);
var
  NewFilter, NewSqlWhere: String;
begin
  NewFilter := DM.ServerData.AppServer.GetFilter(TblName);
  if NewFilter <> '' then
    NewSqlWhere := SqlAll + ' WHERE ' + NewFilter + ';'
  else
    NewSqlWhere := SqlAll + ';';

  {TODO DRAGO
  case NumQuery of
    1 :
       begin
         DM.cdsPrint1.CommandText := NewSqlWhere;
         DM.ReOpen(DM.cdsPrint1);
       end;

    2 :
      begin
         DM.cdsPrint2.CommandText := NewSqlWhere;
         DM.ReOpen(DM.cdsPrint2);
       end;

    3 :
      begin
         DM.cdsPrint3.CommandText := NewSqlWhere;
         DM.ReOpen(DM.cdsPrint3);
       end;

    4 :
      begin
         DM.cdsPrint4.CommandText := NewSqlWhere;
         DM.ReOpen(DM.cdsPrint4);
       end;

    5 :
      begin
         DM.cdsPrint5.CommandText := NewSqlWhere;
         DM.ReOpen(DM.cdsPrint5);
       end;
  end;}
end;

function TfBaseEntity.Print(Dft: String = 'Default.rtm'): Boolean;
var
  TemplateName, OutputName, sTemplate: string;
  Reporter: TDbFreeReporter;
  i: Integer;
  L: TStringList;
  S, T: WideString;
begin
  Result := False;
  Screen.Cursor := crSQLWait;
  try
    sTemplate := Self.Name + '.html';
    Delete(sTemplate, 1, 1);
    L := GetFileList(ExtractFilePath(Application.ExeName) + 'PrintForms\', '*' + sTemplate, False, False, True);
    try
      TemplateName := SelectForm(L, 'Изберете бланка за печат', 'Бланка');
      if TemplateName = '' then
        Abort;
      TemplateName := ExtractFilePath(Application.ExeName) + 'PrintForms\' + TemplateName + '.html';
    finally
      FreeAndNil(L);
    end;
    if not FileExists(TemplateName) then begin
      TemplateName := ChangeFileExt(TemplateName, '.html');
      if not FileExists(TemplateName) then
        raise Exception.CreateFmt('файл %s не съществува', [TemplateName]);
      sTemplate := ExtractFileName(TemplateName);
    end;
    OutputName := TempFolder + FormatDateTime('yyyymmddhhnnss_', Now) + StringReplace(sTemplate, '.template.', '.', [rfIgnoreCase]);
    L := GetFileList(ExtractFilePath(Application.ExeName) + 'PrintForms\', '*.jpg', True, False, False);
    try
      for i := 0 to l.Count-1 do begin
        S := L[i];
        T := TempFolder + ExtractFileName(L[i]);
        CopyFile(Addr(S[1]), Addr(T[1]), True);
      end;
    finally
      FreeAndNil(L);
    end;

    Reporter := TDbFreeReporter.Create;

    Reporter.OnGetCustomTagValue := GetCustomTagValueForInvoice;

    for i := 0 to High(CDS) do
      Reporter.AddDataSet(CDS[i]);

    LN := 1;
    Reporter.CreateReport(TemplateName, OutputName);

    if SameText(ExtractFileExt(OutputName), '.html') then begin
      FreeAndNil(HTMLViewerForm);
      if Self is TfOffers then begin
        HTMLConfirmQuetion := True;
        HTMLPrinted := False;
      end;
      ShowHTML(OutputName, True, '', '', True);
      if (Self is TfOffers) and HTMLPrinted then begin
        DM.ServerData.AppServer.BeginTrans;
        if DM.ServerData.AppServer.SetFieldValue('OFFERS', dsList.DataSet.FieldByName('ID').AsString, 'PRINTED', '1', 0) = 0 then begin
          DM.ServerData.AppServer.CommitTrans;
          acRefresh.Execute;
        end
        else
          DM.ServerData.AppServer.RollbackTrans;
      end;

      HTMLConfirmQuetion := False;

      DeleteFile(OutputName);
    end
    else
      ShellExecute(Application.MainForm.Handle, pChar('Open'), pChar(OutputName), nil, nil, SW_MAXIMIZE);
    Result := True;
  except
    on E: EAbort do begin

    end;
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'TfBaseEntity.Print', 'Form: ' + Self.Name, '');
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TfBaseEntity.spTextDblClick(Sender: TObject);
begin
  try
    fUserMonitor.ShowUserMonitor;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'BASEENTITY.sbListDblClick', 'Form: ' + self.Name, '');
    end;
  end;
end;

function TfBaseEntity.GetPrnCaseChrCode: String;
begin
  Result := 'NULL';  //NULL is the empty value for CASE_CHRCODE;
end;

function TfBaseEntity.GetPrnCaseIntCode: Integer;
begin
  Result := 0; //0 = default value for CASE_INTCODE;
end;

end.

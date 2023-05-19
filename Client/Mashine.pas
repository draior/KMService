unit Mashine;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Grids, DBGrids, DBCtrls, Mask, ActnList, dbClient, Variants, DBGridShadow,
  Vcl.Buttons, XPMenu, Vcl.ScreenTips, Vcl.RibbonLunaStyleActnCtrls, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.Ribbon;

type
  TfMashine = class(TfBaseEntity)
    dsDetail: TDataSource;
    dbgDetail: TDBGrid;
    Label1: TLabel;
    acSelectArticles: TAction;
    dbgH: TDBGrid;
    dsSums: TDataSource;
    dbgBottom: TDBGridBottom;
    acOffer: TAction;
    Label3: TLabel;
    Label4: TLabel;
    dbeName: TDBEdit;
    dbeType: TDBEdit;
    Label6: TLabel;
    dbeProducer: TDBEdit;
    Label8: TLabel;
    sbClientSelect: TSpeedButton;
    acClientSelect: TAction;
    acClientSerial: TAction;
    XPMenu: TXPMenu;
    ActionManager: TActionManager;
    ScreenTipsManager: TScreenTipsManager;
    Ribbon: TRibbon;
    rpFilter: TRibbonPage;
    rgOffers: TRibbonGroup;
    rpOperation: TRibbonPage;
    rgFiles: TRibbonGroup;
    acUnsortDetail: TAction;
    procedure FormCreate(Sender: TObject);
    procedure dbgDetailDblClick(Sender: TObject);
    procedure dbgDetailKeyPress(Sender: TObject; var Key: Char);
    procedure acSelectArticlesExecute(Sender: TObject);
    procedure dsListStateChange(Sender: TObject);
    procedure dsListDataChange(Sender: TObject; Field: TField);
    procedure dbgHDblClick(Sender: TObject);
    procedure dbgBottomGetAssociateFields(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acOfferExecute(Sender: TObject);
    procedure acClientSelectExecute(Sender: TObject);
    procedure acClientSerialExecute(Sender: TObject);
    procedure acUnsortDetailExecute(Sender: TObject);
  private
    { Private declarations }
    LastID: Integer;

    procedure ChangeMashine;
    procedure MashineAfterScroll(DataSet: TDataSet);
  public
    procedure SetChangeFields; override;
  end;

var
  fMashine: TfMashine;

implementation

uses
  DataModule, Utilities, SelectorUtilities, FormConstants,
  ULogUtils, Mess, SelectMsg, Offers, ClientAndSerial;

{$R *.DFM}

procedure TfMashine.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;

  DM.MAfterScroll := nil;
end;

procedure TfMashine.FormCreate(Sender: TObject);
begin
  try
    inherited;

    SetLength(CDS, 2);
    CDS[1] := DM.cdsMashineDetail;
    OrderField := 'NAME';

    DM.MAfterScroll := MashineAfterScroll;
    ChangeMashine;
  except
    on E: Exception do WritetoLog(E.Message, 'TfMashine.FormCreate', '', '');
  end;
end;

procedure TfMashine.MashineAfterScroll(DataSet: TDataSet);
begin
  try
    if not dbgBottom.DataSource.DataSet.Active then
      dbgBottom.DataSource.DataSet.Open;
    if dbgBottom.DataSource.DataSet.Fieldcount <= 0 then
      Exit;
    if dbgBottom.DataSource.DataSet.State <> dsEdit then
      dbgBottom.DataSource.DataSet.Edit;
    dbgBottom.DataSource.DataSet.Fields[3].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_250').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[4].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_500').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[5].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_750').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[6].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_1000').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[7].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_1250').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[8].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_1500').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[9].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_1750').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[10].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_2000').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[11].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_2500').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[12].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_3000').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[13].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_4000').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[14].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_4500').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[15].AsString := FormatFloat('0.00', DM.cdsSumMashine.FieldByName('L_5000').AsFloat);
    dbgBottom.DataSource.DataSet.Fields[2].AsString := '0';
    dbgBottom.DataSource.DataSet.Post;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMashine.MashineAfterScroll');
    end;
  end;
end;

procedure TfMashine.dbgBottomGetAssociateFields(Sender: TObject);
begin
  inherited;

  ChangeMashine;
  MashineAfterScroll(DM.cdsMashine);
end;

procedure TfMashine.dbgDetailDblClick(Sender: TObject);
begin
  try
    if DM.AllowDBLClick then acSelectArticles.Execute;
  except
    on E: Exception do WritetoLog(E.Message, 'TfMashine.dbgDetailDblClick', '', '');
  end;
end;

procedure TfMashine.dbgDetailKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if Key = #10 then
      if GetKeyState(VK_CONTROL) and $80 > 0 then
        dbgDetailDblClick(dbgDetail);
  except
    on E: Exception do WritetoLog(E.Message, 'TfMashine.dbgDetailKeyPress', '', '');
  end;
end;

procedure TfMashine.dbgHDblClick(Sender: TObject);
begin
  try
    if DM.cdsMashine.State in [dsEdit, dsInsert] then
      dbgh.SelectedField.AsInteger := Abs(dbgh.SelectedField.AsInteger - 1);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMashine.dbgHDblClick', '', '');
    end;
  end;
end;

procedure TfMashine.acClientSelectExecute(Sender: TObject);
begin
  try
    AllowChange := False;
    InsertItemEx(fc_Client,
      'ID;NAME;',

      'CLIENT.NAME', VarArrayOf([dsList.DataSet.FieldByName('L_CLIENT_NAME').AsString]), dsList.DataSet,

      'CLIENT_ID;L_CLIENT_NAME',
      [],
      ShowSelector,
      so_SelectSingle);

    AllowChange := true;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'TfMashine.acClientSelectExecute');
    end;
  end;
end;

procedure TfMashine.acClientSerialExecute(Sender: TObject);
begin
  try
    DM.MashineID := dsList.DataSet.FieldByName('ID').AsInteger;
    DM.MashineName := dsList.DataSet.FieldByName('NAME').AsString;
    DM.ServerData.AppServer.RequestDoc('MashineSerial', 'MASHINESERIAL.MASHINE_ID = ' + IntToStr(DM.MashineID), '', 0);
    LinkToOperation(fc_MashineSerial, TfClientSerial, ' Клиенти и серийни номера за машина ['+DM.MashineName+']',  Self);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'TfMashine.acClientSerialExecute');
    end;
  end;
end;

procedure TfMashine.acOfferExecute(Sender: TObject);
var
  i, H, ID: Integer;
  lcResult: String;
  lcItems: TStringList;
begin
  lcItems := TStringList.Create;
  try
    for i := 0 to dbgH.Columns.Count-1 do begin
       if DM.cdsMashine.FieldByName(dbgH.Columns[i].FieldName).AsInteger = 1 then
         lcItems.Add(Trim(Copy(dbgH.Columns[i].FieldName, 2, 20))+' часа');
    end;

    lcResult := SelectForm(lcItems, 'Изберете период', 'За кой период иската да изготвите оферта?');
    if lcResult <> '' then begin
      H := StrToInt(Trim(Copy(lcResult, 1, 4)));
      DM.ServerData.AppServer.BeginTrans;

      if DM.ServerData.AppServer.MakeOffer(DM.cdsMashine.FieldByName('ID').AsInteger, H, ID) = 0 then begin
        DM.ServerData.AppServer.CommitTrans;

        DM.ServerData.AppServer.RequestDoc('OFFERS', 'OFFERS.ID = ' + IntToStr(ID), '', 1);
        LinkToOperation(fc_Offers, TfOffers, 'ОФЕРТА ЗА МАШИНА: '+DM.cdsMashine.FieldByName('NAME').AsString, Self);
      end
      else begin
        DM.ServerData.AppServer.RollbackTrans;
        MessageDlg('Грешка при създаване на оферта!', mtError, [mbOk], 0);
      end;
    end;
  except
    on E: Exception do begin
      DM.ServerData.AppServer.RollbackTrans;
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMashine.acOfferExecute');
    end;
  end;
  FreeAndNil(lcItems);
end;

procedure TfMashine.acSelectArticlesExecute(Sender: TObject);
var
  lcLinkField, lcLinkValue: String;
  lcSQL_ID: Integer;
  lcOption: TFilterOption;
begin
  try
    if Assigned(dbgDetail.SelectedField) then begin
      if not (dsDetail.DataSet.State in dsWriteModes) then dsDetail.DataSet.Edit;

      if GetLinkField( dbgDetail, 'ARTICLE', lcLinkField, lcLinkValue ) <> 0 then
        MessageDlg('Грешка при избор на артикули!', mtError, [mbOk], 0)
      else begin
        AllowChange := false;

        lcSQL_ID := fc_Article; //TODO DRAGO
        lcOption := [];

        InsertItemEx(
          lcSQL_ID,
          'ID;CODE;NAME',

          lcLinkField,
          VarArrayOf([lcLinkValue]),
          dsDetail.DataSet,

          'ARTICLE_ID;L_ARTICLE_CODE;L_ARTICLE_NAME',
          lcOption,
          ShowSelector,
          so_SelectMulty);

        AllowChange := true;
      end;
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMashine.acSelectArticlesExecute');
    end;
  end;
end;

procedure TfMashine.acUnsortDetailExecute(Sender: TObject);
begin
  try
    inherited;
    CDS[1].IndexFieldNames := 'ID';
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog( E.Message, 'TfMashine.tbUnsortDetailClick');
    end;
  end;
end;

procedure TfMashine.SetChangeFields;
begin
  try
    SetLength(ChangeFieldsArray, 2);

    ChangeFieldsArray[0].Field := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_CODE');
    ChangeFieldsArray[0].OldProc := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_CODE').OnChange;
    ChangeFieldsArray[0].ExecAction := acSelectArticles;
    dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_CODE').OnChange := FieldOnChange;

    ChangeFieldsArray[1].Field := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_NAME');
    ChangeFieldsArray[1].OldProc := dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_NAME').OnChange;
    ChangeFieldsArray[1].ExecAction := acSelectArticles;
    dbgDetail.DataSource.DataSet.FieldByName('L_ARTICLE_NAME').OnChange := FieldOnChange;

    {ChangeFieldsArray[2].Field := dsList.DataSet.FieldByName('L_CLIENT_NAME');
    ChangeFieldsArray[2].OldProc := dsList.DataSet.FieldByName('L_CLIENT_NAME').OnChange;
    ChangeFieldsArray[2].ExecAction := acClientSelect;
    dsList.DataSet.FieldByName('L_CLIENT_NAME').OnChange := FieldOnChange;}

  except
    on E: Exception do WritetoLog(E.Message, 'TfMashine.SetChangeFields', '', '');
  end;
end;

procedure TfMashine.ChangeMashine;
var
  i: Integer;
  S: String;
begin
  if (dsList.DataSet.State <> dsInsert) and (LastID <> dsList.DataSet.FieldByName('ID').AsInteger) then begin
    LastID := dsList.DataSet.FieldByName('ID').AsInteger;

    for i := 0 to dbgDetail.Columns.Count-1 do begin
      S := 'H'+Trim(Copy(dbgDetail.Columns[i].FieldName, 2, 20));
      if DM.cdsMashine.FindField(S) <> nil then
        dbgDetail.Columns[i].Visible := DM.cdsMashine.FieldByName(S).AsInteger = 1;
    end;
    dbgDetail.Realign;
  end;
end;

procedure TfMashine.dsListDataChange(Sender: TObject; Field: TField);
begin
  inherited;

  ChangeMashine;
end;

procedure TfMashine.dsListStateChange(Sender: TObject);
begin
  try
    inherited;
    acOffer.Enabled := not (dsList.State in dsWriteModes);
  except
    on E: Exception do WritetoLog(E.Message, 'TfMashine.dsListStateChange');
  end;
end;

end.

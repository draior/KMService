unit DataModule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ClientLib, kmClient_TLB, ActiveX, Datasnap.DBClient,
  Datasnap.Win.SConnect, Datasnap.Win.MConnect, Data.DB, Menus, Vcl.ToolWin, Vcl.ComCtrls;

const
  MaxEditOffers = 3;
  ea_None                          = 0;

type
  TDM = class(TDataModule)
    cdsMiscQuery: TClientDataSet;
    cdsArticle: TClientDataSet;
    cdsArticleID: TIntegerField;
    cdsArticleCODE: TStringField;
    cdsArticleNAME: TStringField;
    cdsArticlePRICE: TFloatField;
    cdsArticleUSED: TSmallintField;
    cdsArticleC_ACTIONDATETIME: TDateTimeField;
    cdsArticleC_USER_ID: TIntegerField;
    cdsUserName: TClientDataSet;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    SmallintField1: TSmallintField;
    DateTimeField1: TDateTimeField;
    cdsUserNamePASS: TStringField;
    cdsUserNameRIGHTS: TStringField;
    cdsMashine: TClientDataSet;
    cdsMashineDetail: TClientDataSet;
    cdsMashineID: TIntegerField;
    cdsMashineNAME: TStringField;
    cdsMashineH250: TSmallintField;
    cdsMashineH500: TSmallintField;
    cdsMashineH750: TSmallintField;
    cdsMashineH1000: TSmallintField;
    cdsMashineH1250: TSmallintField;
    cdsMashineH1500: TSmallintField;
    cdsMashineH1750: TSmallintField;
    cdsMashineH2000: TSmallintField;
    cdsMashineH3000: TSmallintField;
    cdsMashineH4000: TSmallintField;
    cdsMashineH4500: TSmallintField;
    cdsMashineH5000: TSmallintField;
    cdsMashineC_USER_ID: TIntegerField;
    cdsMashineC_ACTIONDATETIME: TDateTimeField;
    cdsMashineDetailID: TIntegerField;
    cdsMashineDetailMASHINE_ID: TIntegerField;
    cdsMashineDetailARTICLE_ID: TIntegerField;
    cdsMashineDetailQ250: TFloatField;
    cdsMashineDetailQ500: TFloatField;
    cdsMashineDetailQ750: TFloatField;
    cdsMashineDetailQ1000: TFloatField;
    cdsMashineDetailQ1250: TFloatField;
    cdsMashineDetailQ1500: TFloatField;
    cdsMashineDetailQ1750: TFloatField;
    cdsMashineDetailQ2000: TFloatField;
    cdsMashineDetailQ2500: TFloatField;
    cdsMashineDetailQ3000: TFloatField;
    cdsMashineDetailQ4000: TFloatField;
    cdsMashineDetailQ4500: TFloatField;
    cdsMashineDetailQ5000: TFloatField;
    cdsMashineDetailC_USER_ID: TSmallintField;
    cdsMashineDetailC_ACTIONDATETIME: TDateTimeField;
    cdsMashineDetailL_ARTICLE_CODE: TStringField;
    cdsMashineDetailL_ARTICLE_NAME: TStringField;
    cdsMashineH2500: TSmallintField;
    cdsMashineDetailL_ARTICLE_PRICE: TFloatField;
    cdsSumMashine: TClientDataSet;
    cdsSumMashineL_250: TFloatField;
    cdsSumMashineL_500: TFloatField;
    cdsSumMashineL_750: TFloatField;
    cdsSumMashineL_1000: TFloatField;
    cdsSumMashineL_1250: TFloatField;
    cdsSumMashineL_1500: TFloatField;
    cdsSumMashineL_1750: TFloatField;
    cdsSumMashineL_2000: TFloatField;
    cdsSumMashineL_2500: TFloatField;
    cdsSumMashineL_3000: TFloatField;
    cdsSumMashineL_4000: TFloatField;
    cdsSumMashineL_4500: TFloatField;
    cdsSumMashineL_5000: TFloatField;
    cdsOffers: TClientDataSet;
    cdsOffersDetail: TClientDataSet;
    cdsOffersID: TIntegerField;
    cdsOffersDOCDATE: TDateTimeField;
    cdsOffersOHOUR: TSmallintField;
    cdsOffersTOTAL: TFloatField;
    cdsOffersVAT: TFloatField;
    cdsOffersTOTALVAT: TFloatField;
    cdsOffersDISCOUNT: TFloatField;
    cdsOffersCOMMENT: TStringField;
    cdsOffersC_USER_ID: TIntegerField;
    cdsOffersC_ACTIONDATETIME: TDateTimeField;
    cdsOffersL_MASHINE_NAME: TStringField;
    cdsOffersL_USER_NAME: TStringField;
    cdsOffersDetailID: TIntegerField;
    cdsOffersDetailOFFERS_ID: TIntegerField;
    cdsOffersDetailARTICLE_ID: TIntegerField;
    cdsOffersDetailQTY: TFloatField;
    cdsOffersDetailPRICE: TFloatField;
    cdsOffersDetailC_USER_ID: TIntegerField;
    cdsOffersDetailC_ACTIONDATETIME: TDateTimeField;
    cdsOffersDetailL_ARTICLE_CODE: TStringField;
    cdsOffersDetailL_ARTICLE_NAME: TStringField;
    cdsOffersDetailL_USER_NAME: TStringField;
    cdsOffersL_TOTAL: TFloatField;
    cdsOffersL_VAT: TFloatField;
    cdsOffersL_TOTALVAT: TFloatField;
    cdsMashineMTYPE: TStringField;
    cdsMashinePRODUCER: TStringField;
    cdsOffersL_MASHINE_TYPE: TStringField;
    cdsOffersL_MASHINE_SERIALNO: TStringField;
    cdsOffersL_MASHINE_PRODUCER: TStringField;
    cdsTempCalc: TClientDataSet;
    cdsOffersL_CLIENT_NAME: TStringField;
    cdsOffersL_CLIENT_REGNO: TStringField;
    cdsOffersL_CLIENT_CONTACTPERSON: TStringField;
    cdsOffersL_CLIENT_PHONE: TStringField;
    cdsOffersL_CLIENT_ADDRESS: TStringField;
    cdsOffersL_CLIENT_EMAIL: TStringField;
    cdsClient: TClientDataSet;
    cdsClientID: TIntegerField;
    cdsClientNAME: TStringField;
    cdsClientREGNO: TStringField;
    cdsClientADDRESS: TStringField;
    cdsClientCONTACTPERSON: TStringField;
    cdsClientPHONE: TStringField;
    cdsClientEMAIL: TStringField;
    cdsClientC_USER_ID: TIntegerField;
    cdsClientC_ACTIONDATETIME: TDateTimeField;
    cdsArticleREPLCODE: TStringField;
    cdsArticleSUPPLYPRICE: TFloatField;
    cdsArticleDESCRIPTION: TStringField;
    cdsMashineSerial: TClientDataSet;
    cdsMashineSerialID: TIntegerField;
    cdsMashineSerialMASHINE_ID: TIntegerField;
    cdsMashineSerialENGINE: TStringField;
    cdsMashineSerialSERIALNO: TStringField;
    cdsMashineSerialCLIENT_ID: TIntegerField;
    cdsMashineSerialL_MASHINE_MTYPE: TStringField;
    cdsMashineSerialL_MASHINE_NAME: TStringField;
    cdsMashineSerialL_CLIENT_NAME: TStringField;
    cdsMashineSerialL_CLIENT_REGNO: TStringField;
    cdsMashineSerialL_CLIENT_ADDRESS: TStringField;
    cdsOffersMASHINESERIAL_ID: TIntegerField;
    cdsOffersMASHINE_ID: TIntegerField;
    cdsMashineL_CLIENT: TStringField;
    cdsMashineL_SERIALNO: TStringField;
    cdsMashineL_ENGINE: TStringField;
    cdsMashineL_CLIENT_ID: TIntegerField;
    cdsOffersPRINTED: TSmallintField;
    cdsOffersREV: TIntegerField;
    cdsOffersDetailREV: TStringField;
    cdsOffersDOCNO: TStringField;
    cdsOffersL_USER_EMAIL: TStringField;
    cdsOffersL_USER_MOBILE: TStringField;
    cdsOffersL_USER_PHONE: TStringField;
    cdsOffersL_USER_FAX: TStringField;
    cdsUserNameEMAIL: TStringField;
    cdsUserNameMOBILE: TStringField;
    cdsUserNamePHONE: TStringField;
    cdsUserNameFAX: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CDS_BeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
    procedure cdsUserNameAfterInsert(DataSet: TDataSet);
    procedure CDS_AfterGetRecords(Sender: TObject; var OwnerData: OleVariant);
    procedure cdsMashineAfterScroll(DataSet: TDataSet);
    procedure cdsMashineAfterInsert(DataSet: TDataSet);
    procedure cdsMashineGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsMashineDetailAfterInsert(DataSet: TDataSet);
    procedure cdsOffersAfterScroll(DataSet: TDataSet);
    procedure cdsOffersDetailAfterInsert(DataSet: TDataSet);
    procedure cdsMashineSerialAfterInsert(DataSet: TDataSet);
    procedure cdsOffersDetailBeforeDelete(DataSet: TDataSet);
    procedure cdsOffersAfterCancel(DataSet: TDataSet);
  private
    { Private declarations }
    prv_IndexFields: String;

    procedure SetFieldComponentFocus(const FieldCaption: String);
    function AddToTransactionLog(CDS: TClientDataSet; intOper: Integer): Boolean;
  public
    { Public declarations }
    FClient: TkmClient;
    ServerData: TDispatchConnection;
    CurrentUserID: String;
    CurrentUserName: String;
    CurrentUserRights: String;

    WithLink: Boolean;
    AllowDBLClick: Boolean;
    ANewDoc: Boolean;
    BadSaving: Boolean;
    UserOpen: Boolean;
    ABeforeInsert: Integer;
    AAfterInsert: Integer;
    ABeforeUpdate: Integer;
    AAfterUpdate: Integer;
    ABeforeDelete: Integer;
    AAfterDelete: Integer;
    MashineID: Integer;
    MashineName: String;

    MAfterScroll: TDataSetNotifyEvent;

    procedure FL_ButtonClick(PM: TPopupMenu; Op: Integer; CDS: Array of TClientDataSet);
    procedure SetCommandText(CDS: TCLientDataSet; const CmdStr: String; SetOpen: Boolean=True);
    procedure ReOpen(CDS: TDataSet);
    function SetUpRemoteConnection(bInitial: Boolean): Integer;
    function LogIn(bInitial: Boolean=True): Integer;
    function GetCDSByName(cdsName: String) : TClientDataSet;
  end;

var
  DM: TDM;

implementation

uses
  ComObj, ULogUtils, IniFiles, Mess, PasswordEnter, UITypes, HistoryLogConst,
  Utilities, BASEENTITY;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

function TDM.AddToTransactionLog(CDS: TClientDataSet;
  intOper: Integer): Boolean;
var
  i: Integer;
  lcOper, lcDescr: String;
begin
  try
    lcOper := GetOperationDesc(CDS.ProviderName, intOper);
    lcDescr := '';

    for i := 0 to CDS.FieldCount - 1 do
      if CDS.Fields[i].FieldName <> 'PASS' then
        lcDescr := lcDescr + CDS.Fields[i].FieldName + '=' + VarToStr( CDS.Fields[i].Value ) + #13#10;

    Result := ServerData.AppServer.AddToTransLog(NOW, lcOper, str_resSuccess, lcDescr) = 0;
  except
    on E: Exception do begin
      Result := FALSE;
      WriteToLog(E.Message, 'DM.AddToTransactionLog', '', '');
      MessageDlg(E.Message, mtError, [mbOk], 0);
    end;
  end;
end;

procedure TDM.cdsMashineSerialAfterInsert(DataSet: TDataSet);
begin
  try
    SetCommandText(cdsMiscQuery, 'SELECT MAX(ID)+1 FROM MASHINESERIAL');
    DataSet.FieldByName('ID').AsInteger := cdsMiscQuery.Fields[0].AsInteger;
    DataSet.FieldByName('MASHINE_ID').AsInteger := MashineID;
    DataSet.FieldByName('L_MASHINE_NAME').AsString := MashineName;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsCilientSerialAfterInsert');
    end;
  end;
end;

procedure TDM.cdsMashineAfterInsert(DataSet: TDataSet);
begin
  try
    SetCommandText(cdsMiscQuery, 'SELECT MAX(ID)+1 FROM MASHINE');
    DataSet.FieldByName('ID').AsInteger := cdsMiscQuery.Fields[0].AsInteger;
    DataSet.FieldValues['H250;H500;H750;H1000;H1250;H1500;H1750;H2000;H2500;H3000;H4000;H4500;H5000;C_USER_ID'] :=
      VarArrayOf([1,1,0,1,0,1,0,1,0,0,1,0,1,CurrentUserID]);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsMashineAfterInsert');
    end;
  end;
end;

procedure TDM.cdsMashineAfterScroll(DataSet: TDataSet);
begin
  try
    ServerData.AppServer.RequestDoc('MashineDetail', 'MASHINE_ID = ' + IntToStr(DataSet.FieldByName('ID').AsInteger), '', 0);
    ReOpen(cdsMashineDetail);

    ServerData.AppServer.RequestDoc('SumMashine', 'MASHINEDETAIL.MASHINE_ID = ' + IntToStr(DataSet.FieldByName('ID').AsInteger), '', 0);
    ReOpen(cdsSumMashine);

    if Assigned(MAfterScroll) then
      MAfterScroll(DataSet);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsMashineAfterScroll', '', '');
    end;
  end;
end;

procedure TDM.cdsMashineDetailAfterInsert(DataSet: TDataSet);
begin
  try
    DataSet.FieldByName('ID').AsInteger := ServerData.AppServer.GetNextID(TClientDataSet(DataSet).ProviderName);
    DataSet.FieldValues['MASHINE_ID;Q250;Q500;Q750;Q1000;Q1250;Q1500;Q1750;Q2000;Q2500;Q3000;Q4000;Q4500;Q5000;C_USER_ID'] :=
      VarArrayOf([cdsMashine.FieldByName('ID').AsInteger,
                  cdsMashine.FieldByName('H250').AsInteger,
                  cdsMashine.FieldByName('H500').AsInteger,
                  cdsMashine.FieldByName('H750').AsInteger,
                  cdsMashine.FieldByName('H1000').AsInteger,
                  cdsMashine.FieldByName('H1250').AsInteger,
                  cdsMashine.FieldByName('H1500').AsInteger,
                  cdsMashine.FieldByName('H1750').AsInteger,
                  cdsMashine.FieldByName('H2000').AsInteger,
                  cdsMashine.FieldByName('H2500').AsInteger,
                  cdsMashine.FieldByName('H3000').AsInteger,
                  cdsMashine.FieldByName('H4000').AsInteger,
                  cdsMashine.FieldByName('H4500').AsInteger,
                  cdsMashine.FieldByName('H5000').AsInteger,
                  CurrentUserID]);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsMashineDetailAfterInsert', '', '');
    end;
  end;
end;

procedure TDM.cdsMashineGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if Sender.Value = 1 then
    Text := 'v'
  else
    Text := ' ';
end;

procedure TDM.cdsOffersAfterCancel(DataSet: TDataSet);
begin
  try
    SetCommandText(cdsMiscQuery, 'UPDATE OFFERSDETAIL SET ID=-ID WHERE ID<0 AND OFFERS_ID=' + DataSet.FieldByName('ID').AsString, False);
    cdsOffersAfterScroll(DataSet);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsOffersAfterCancel');
    end;
  end;
end;

procedure TDM.cdsOffersAfterScroll(DataSet: TDataSet);
begin
  try
    ServerData.AppServer.RequestDoc('OffersDetail', 'OFFERSDETAIL.OFFERS_ID = ' + IntToStr(DataSet.FieldByName('ID').AsInteger) +
        'AND OFFERSDETAIL.ID > 0 AND (OFFERSDETAIL.REV LIKE "%;' + IntToStr(DataSet.FieldByName('REV').AsInteger) +
        ';%" OR OFFERSDETAIL.REV IS NULL)', '', 0);
    ReOpen(cdsOffersDetail);
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsOffersAfterScroll');
    end;
  end;
end;

procedure TDM.cdsOffersDetailAfterInsert(DataSet: TDataSet);
begin
  try
    DataSet.FieldByName('ID').AsInteger := ServerData.AppServer.GetNextID(TClientDataSet(DataSet).ProviderName);
    DataSet.FieldByName('OFFERS_ID').AsInteger := cdsOffers.FieldByName('ID').AsInteger;
    DataSet.FieldByName('C_USER_ID').AsString := CurrentUserID;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.cdsOffersDetailAfterInsert');
    end;
  end;
end;

procedure TDM.cdsOffersDetailBeforeDelete(DataSet: TDataSet);
begin
  ServerData.AppServer.SetFieldValue('OFFERSDETAIL', DataSet.FieldByName('ID').AsInteger, 'ID', -DataSet.FieldByName('ID').AsInteger, False);
  cdsOffersAfterScroll(cdsOffers);
  Abort;
end;

procedure TDM.cdsUserNameAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('USED').AsInteger := 1;
  DataSet.FieldByName('RIGHTS').AsString := '00000000000000000000000000000000000000000000000000';
end;

procedure TDM.CDS_AfterGetRecords(Sender: TObject; var OwnerData: OleVariant);
var
  PacketRec: Integer;
begin
  PacketRec := (Sender as TClientDataSet).PacketRecords;

  (Sender as TClientDataSet).DisableControls;
  try
    (Sender as TClientDataSet).PacketRecords := 0;
    if prv_IndexFields <> '' then
      (Sender as TClientDataSet).IndexFieldNames := prv_IndexFields;
  finally
    Screen.Cursor := crDefault;
    (Sender as TClientDataSet).PacketRecords := PacketRec;
    (Sender as TClientDataSet).EnableControls;
  end;
end;

procedure TDM.CDS_BeforeGetRecords(Sender: TObject; var OwnerData: OleVariant);
var
  PacketRec: Integer;
begin
  PacketRec := (Sender as TClientDataSet).PacketRecords;
  prv_IndexFields := (Sender as TClientDataSet).IndexFieldNames;

  try
    (Sender as TClientDataSet).PacketRecords := 0;
    (Sender as TClientDataSet).IndexFieldNames := '';
  finally
    Screen.Cursor := crDefault;
    (Sender as TClientDataSet).PacketRecords := PacketRec;
  end;
  Screen.Cursor := crHourGlass;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  lc_intRes: Integer;
  typelib: ITypeLib;
begin
  try
    OleCheck(LoadRegTypeLib(LIBID_kmClient, 1, 0, 0, typelib));
    FClient := TkmClient.Create;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.DataModuleCreate', 'TkmClient.Create', '');
      Exit;
    end;
  end;

  //Initializing Connection to server
  lc_intRes := 1;

  while lc_intRes = 1 do
    lc_intRes := SetUpRemoteConnection(True);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  try
    if (ServerData <> nil) and ServerData.Connected then
      FreeAndNil(ServerData);
  except
    on E: Exception do begin
      //MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'TDM.DataModuleDestroy');
    end;
  end;
end;

procedure TDM.FL_ButtonClick(PM: TPopupMenu; Op: Integer;
  CDS: array of TClientDataSet);
var
  Cntr: Integer;
  SavedID, lcID: String;
  CheckOk, EditMode: Boolean;
  SavedPosition: TBookmark;
begin
  SavedPosition := nil;
  case Op of
    12: try
          if (CurrentUserRights[Screen.ActiveForm.HelpContext] > '1')  then begin// and (not WithLink) removed by Ivan 15.02.2003
            ANewDoc := True; //Insert
            CDS[0].Insert;
            ServerData.AppServer.BeginTrans;
            CDS[0].FetchOnDemand := FALSE;
          end;
        except
          on E: Exception do begin
            CDS[0].FetchOnDemand := TRUE;
            //OLD MessageDlg('Грешка при добавяне!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);
            MessageDlg(E.Message, mtError, [mbOk], 0);
            WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Insert', '');
          end;
        end;

    13: try
          if (CDS[0].RecordCount > 0) and (CurrentUserRights[Screen.ActiveForm.HelpContext] > '1') then begin // Edit
            if (ServerData.AppServer.CanEnterEditMode(CDS[0].ProviderName, CDS[0].FieldByName('ID').AsString) = 0) then begin
              ANewDoc := False;
              CDS[0].Edit;
              ServerData.AppServer.BeginTrans;
              CDS[0].FetchOnDemand := FALSE;
            end
            else begin
              MessageDlg(err_No_Edit_Allowed, mtError, [mbOK], 0);
            end;
          end;
        except
          on E: Exception do begin
            CDS[0].FetchOnDemand := TRUE;
            //OLD MessageDlg('Грешка при редакция!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);
            MessageDlg(E.Message, mtError, [mbOk], 0);
            WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Edit', '');
          end;
        end;

    14: try
          if (CDS[0].RecordCount > 0) and (CurrentUserRights[Screen.ActiveForm.HelpContext] > '2') then // Delete
            if ServerData.AppServer.CanEnterEditMode(CDS[0].ProviderName, CDS[0].FieldByName('ID').AsString) <> 0 then begin
              MessageDlg( 'Не се разрешава изтриване! Документът е приключен!'#13#10 +
                'Моля, актуализирайте информацията.', mtError, [mbOK], 0 );
            end
            else if MessageDlg('Потвърдете изтриването на записа !', mtConfirmation, [mbYes, mbNo], 0) = mrYes then begin
              ServerData.AppServer.BeginTrans;
              Screen.Cursor := crHourGlass;
              {TODO DRAGO
              case ABeforeDelete of
                ea_BD_Lock:
                  begin
                    Screen.Cursor := crDefault;
                    MessageDlg('Забранено изтриването!', mtInformation, [mbOk], 0);
                    ServerData.AppServer.RollbackTrans;
                    Exit;
                  end;
                ea_BD_SysBusinessGroup :
                  if ServerData.AppServer.DeleteDocCounters(cdsSys_Businessgroup.FieldByName('BUSINESSGROUP_ID').AsString) <> 0 then Abort;
                ea_BD_ExpenseType :
                  if ServerData.AppServer.CanDeleteExpenseType( cdsExpenseType.FieldByName('ID').AsString ) <> 0 then Abort;
                ea_BD_GLPayment :
                  if CDS[0].FieldByName('DOCSTATUS_ID').AsInteger = 2 then begin
                    Screen.Cursor := crDefault;
                    MessageDlg('Приключено плащане не може да бъде изтрито!'#13#10'Ако желаете може да анулирате документа.', mtInformation, [mbOk], 0);
                    ServerData.AppServer.RollbackTrans;
                    Exit;
                  end;
                ea_BD_PS :
                  if CDS[0].FieldByName('DOCSTATUS_ID').AsInteger = 1 then
                    if ServerData.AppServer.DeletePSDetail(CDS[0].FieldByName('ID').AsString) <> 0 then Abort;
              end; // case}
              try
                Application.ProcessMessages;
                SavedPosition := CDS[0].GetBookmark;          //Ivan 22.03.2001  Za da ne minava na sledvasht red
                SavedID := CDS[0].FieldByName('ID').AsString;
                AddToTransactionLog(CDS[0], 3);
                CDS[0].Delete;
                if (CDS[0].ApplyUpdates(-1) <> 0) then Abort;
                ServerData.AppServer.DeleteRecord(CDS[0].ProviderName, SavedID);
                ServerData.AppServer.CommitTrans;
                Screen.Cursor := crDefault;
              except
                on E: Exception do begin
                  ServerData.AppServer.RollbackTrans;
                  Screen.Cursor := crDefault;
                  CDS[0].CancelUpdates;
                  if CDS[0].ChangeCount <> 0 then
                    try
                      Screen.Cursor := crHourGlass;
                      ReOpen( CDS[0] );
                    finally
                      Screen.Cursor := crDefault;
                    end;
                  CDS[0].GotoBookmark(SavedPosition);
                  WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Delete', '');
                end;
              end;//try clause
              CDS[0].FreeBookmark(SavedPosition);
              //ServerData.AppServer.RequestDoc(CDS[0].ProviderName, '', '' );
            end;
        except
          on E: EAbort do begin
            Screen.Cursor := crDefault;
            ServerData.AppServer.RollbackTrans;
          end;
          on E: Exception do begin
            Screen.Cursor := crDefault;
            //OLD MessageDlg('Грешка при изтриване!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);
            MessageDlg(E.Message, mtError, [mbOk], 0);
            WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Delete', '');
            ServerData.AppServer.RollbackTrans;
          end;
        end;

    15: try  // Cancel
          Screen.Cursor := crHourGlass;
          for Cntr := 0 to High(CDS) do
            if CDS[Cntr].Active then
              CDS[Cntr].CancelUpdates;
          ServerData.AppServer.RollbackTrans;
          Screen.Cursor := crDefault;
          CDS[0].FetchOnDemand := TRUE;
        except
          on E: Exception do begin
            Screen.Cursor := crDefault;
            //OLD MessageDlg('Грешка при отказ от промените!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);
            MessageDlg(E.Message, mtError, [mbOk], 0);
            WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Cancel', '');
            ServerData.AppServer.RollbackTrans;
          end;
        end;

    16: try   // Post
          BadSaving := false;
          Screen.Cursor := crHourGlass;
          EditMode := CDS[0].State in [dsEdit];

          if not ANewDoc and (ServerData.AppServer.CanEnterEditMode(CDS[0].ProviderName, CDS[0].FieldByName('ID').AsString) <> 0) then begin
            Screen.Cursor := crDefault;
            MessageDlg( 'Не се разрешава запис на промените! Документът е приключен!'#13#10 +
              'Моля, актуализирайте информацията.', mtError, [mbOK], 0 );
            BadSaving := TRUE;
            Exit;
          end;

          if CDS[0].FindField('ID') <> nil then
            lcID := CDS[0].FieldByName('ID').AsString;
          for Cntr := 0 to High(CDS) do
            if CDS[Cntr].State in [dsEdit, dsInsert] then
              try
                CDS[Cntr].Post;
              except
                on E: EDatabaseError do begin
                  if Pos('Key violation', E.Message) <> 0 then
                    MessageDlg('Дублиране на запис !', mtError, [mbOk], 0)
                  else
                    MessageDlg(E.Message, mtError, [mbOk], 0);
                    //OLD MessageDlg('Грешка при запис!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);

                  SetFieldComponentFocus(ExtractCaptionName(E.Message));
                  BadSaving := true;
                  Screen.Cursor := crDefault;

                  WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Post', '');
                  CDS[0].Edit;
                  Exit;
                end;

                on E: Exception do begin
                  Screen.Cursor := crDefault;
                  BadSaving := TRUE;
                  //OLD MessageDlg('Грешка при запис!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);
                  MessageDlg(E.Message, mtError, [mbOk], 0);
                  WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Post', '');
                  CDS[0].Edit;
                  Exit;
                end
              end;

          if EditMode then
            case ABeforeUpdate of
              0: CheckOk := True;
              else CheckOk := True;
            end
          else
            case ABeforeInsert of
              0: CheckOk := True;
              else CheckOk := True;
            end;

          if CheckOk then begin // Apply Updates for all tables
            for Cntr := 0 to High(CDS) do
              if CDS[Cntr].Active then
                CheckOk := CheckOk and (CDS[Cntr].ApplyUpdates(-1) = 0);

            if CheckOk then begin
              if EditMode or ANewDoc then begin
                if Screen.ActiveForm is TfBaseEntity then
                  (Screen.ActiveForm as TfBaseEntity).SavedFormFilter := UpperCase( CDS[0].ProviderName ) +
                                                                         '.ID = ' + CDS[0].FieldByName('ID').AsString;
              end;

              ServerData.AppServer.CloseQuery(CDS[0].ProviderName);
              ServerData.AppServer.CommitTrans;
              if lcID = '' then
                lcID := ServerData.AppServer.LastGenID(CDS[0].ProviderName);
              if (lcID <> '') then //and not SameText(Screen.ActiveForm.Name, 'fOffers') then
                (Screen.ActiveForm as TfBaseEntity).SavedFormFilter := CDS[0].ProviderName+'.ID = '+lcID;

              Screen.Cursor := crDefault;

              if Screen.ActiveForm is TfBaseEntity then
                ServerData.AppServer.RequestDoc(CDS[0].ProviderName,
                  (Screen.ActiveForm as TfBaseEntity).SavedFormFilter,
                  (Screen.ActiveForm as TfBaseEntity).OrderField );//+ ' DESC ');

              Reopen(CDS[0]);

              try
                ServerData.AppServer.BeginTrans;
                if ANewDoc then begin
                  if AddToTransactionLog( CDS[0], 1 ) then
                    ServerData.AppServer.CommitTrans
                  else
                    ServerData.AppServer.RollbackTrans
                end
                else if AddToTransactionLog( CDS[0], 2 ) then
                  ServerData.AppServer.CommitTrans
                else
                  ServerData.AppServer.RollbackTrans;
              except
                ServerData.AppServer.RollbackTrans;
              end;

              ANewDoc := False;
              end
            else begin
              CDS[0].Edit;
              BadSaving := true;
              Screen.Cursor := crDefault;
            end;
          end
          else begin
            Screen.Cursor := crDefault;
            CDS[0].Edit;
          end;

          Screen.Cursor := crDefault;
          CDS[0].FetchOnDemand := TRUE;
        except
          on E: Exception do begin
            Screen.Cursor := crDefault;
            //OLD MessageDlg('Грешка при запис!'#13#10#13#10 + E.Message, mtError, [mbOk], 0);
            MessageDlg(E.Message, mtError, [mbOk], 0);
            WriteToLog(E.Message, 'DM.FL_ButtonClick', 'Post', '');
            CDS[0].Edit;
          end;
        end;
  end;//case
end;

function TDM.GetCDSByName(cdsName: String): TClientDataSet;
var
  i : Integer;
begin
  Result := nil;
  try
    for i := 0 to ServerData.DataSetCount - 1 do
      if AnsiUpperCase(ServerData.DataSets[i].Name) = AnsiUpperCase(cdsName) then begin
        Result := (ServerData.DataSets[i] as TClientDataSet);
        Break;
      end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'TDM.GetCDSByName');
    end;
  end;
end;

function TDM.LogIn(bInitial: Boolean): Integer;
var
  lcParams: OleVariant;
begin
  try
    DM.ServerData.AppServer.CloseAllQueries;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'DM.Login', 'CloseQueries');
    end;
  end;

  try
    with TfPasswordEnter.Create(nil) do
      try
        //TODO DRAGO if Assigned(fSplash) then
        //TODO DRAGO   FreeAndNil(fSplash);

        if not bInitial then Panel1.Caption := ' Смяна на потребител';

        case ShowModal of
          mrCancel: Result := 1;
          mrOK:
            begin
              Result := ServerData.AppServer.Login(cbUser.Text, ePassword.Text, lcParams);
              if Result = 0 then begin
                CurrentUserID := lcParams[0];
                CurrentUserName := lcParams[1];
                CurrentUserRights := lcParams[2];

                //TODO DRAGO InitUserRights;
                //TODO DRAGO LoadUserOptions;
              end;
            end;
          else
            Result := -1;
        end;//case
      finally
        Free;
      end;//try-finally
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Result := 3;
      WriteToLog(E.Message, 'DM.Login', 'Login', '');
    end;
  end;
end;

procedure TDM.ReOpen(CDS: TDataSet);
begin
  try
    CDS.Close;//Za da preizchisli pravilno agregatite
    if (CDS is TClientDataSet) and ( TClientDataSet(CDS).IndexFieldNames <> '' ) then
      TClientDataSet(CDS).IndexFieldNames := '';
    CDS.Open;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'DM.ReOpen', CDS.Name);
    end;
  end;
end;

procedure TDM.SetCommandText(CDS: TCLientDataSet; const CmdStr: String;
  SetOpen: Boolean);
begin
  CDS.DisableControls;
  try
    if CDS.Active then CDS.Close;
    CDS.CommandText := CmdStr;
    if SetOpen then
      CDS.Active := True
    else
      CDS.Execute;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);

      if Assigned(CDS) then
        WriteToLog(E.Message, 'DM.SetCommandText', 'Provider: ' + CDS.ProviderName, 'SQL Statement: ' + CmdStr)
      else
        WriteToLog(E.Message, 'DM.SetCommandText', 'CDS not assigned', 'SQL Statement: ' + CmdStr);
    end;
  end;
  CDS.EnableControls;
end;

procedure TDM.SetFieldComponentFocus(const FieldCaption: String);
var  I, K, J: Integer;
begin
  if FieldCaption = '' then Exit;

  I := 0;

  try
    while (Screen.ActiveForm.Controls[I].Name <> 'pcList') and (I < (Screen.ActiveForm.ControlCount - 1)) do Inc(I);
    if (Screen.ActiveForm.Controls[I] as TPageControl).Enabled then
      for K := 0 to TPageControl(Screen.ActiveForm.Controls[I]).PageCount - 1 do
        with (Screen.ActiveForm.Controls[I] as TPageControl).Pages[K] do
          for J := 0 to ControlCount - 1 do
            if Controls[J].Hint = FieldCaption then begin
              TPageControl(Screen.ActiveForm.Controls[I]).ActivePageIndex := K;
              TWinControl(Controls[J]).SetFocus;
              Exit;
            end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WriteToLog(E.Message, 'DM.SetFieldComponentFocus', 'Поле: ' + FieldCaption, '');
    end;
  end;
end;

function TDM.SetUpRemoteConnection(bInitial: Boolean): Integer;
var
  Cntr, i: Integer;
  IniF: TMemIniFile;
begin
  Result := 0;
  IniF := TMemIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    if Assigned(ServerData) then
      FreeAndNil(ServerData);

    if IniF.ReadInteger('Connection', 'SocketConnection', 0) <> 0 then
      ServerData := TSocketConnection.Create(nil)
    else
      ServerData := TDCOMConnection.Create(nil);
    ServerData.ServerName := 'kmServer.kmServer';
    ServerData.ServerGUID := '{F0BBD428-77AA-4940-9B09-76499C399BD4}';
    if ServerData is TDCOMConnection then begin
      TDCOMConnection(ServerData).ComputerName := IniF.ReadString('Connection', 'Address', '127.0.0.1');
    end
    else begin
      TSocketConnection(ServerData).Address := IniF.ReadString('Connection', 'Address', '127.0.0.1');
      TSocketConnection(ServerData).Host := IniF.ReadString('Connection', 'Host', '');
      TSocketConnection(ServerData).Port := IniF.ReadInteger('Connection', 'Port', 211);
    end;

    for i := 0 to ComponentCount-1 do begin
      if Components[i] is TClientDataSet then
        TClientDataSet(Components[i]).RemoteServer := ServerData;
    end;

    try
      ServerData.Connected := True;
    except
      on E: Exception do
        raise Exception.Create(err_CantConnectToServer + #13#10 + E.Message);
    end;

    if (ServerData.AppServer.LoginInterface(IDispatch(DM.FClient)) <> 0) then
      raise Exception.Create('Достъпът до сървъра отказан!');

    if not bInitial then begin
      try
        for Cntr := 0 to ComponentCount - 1 do
          if Components[Cntr] is TClientDataSet then begin
            if (TClientDataSet(Components[Cntr]).Active)
            and (TClientDataSet(Components[Cntr]).ProviderName <> '') then begin
              TClientDataSet(Components[Cntr]).DisableControls;
              try
                TClientDataSet(Components[Cntr]).Close;
                TClientDataSet(Components[Cntr]).Open;
              finally
                TClientDataSet(Components[Cntr]).EnableControls;
              end;
            end;
          end;
      except
        on E: Exception do begin
          Result := -1;
          WriteToLog(E.Message, 'MessageForm.RefreshDataModule');
        end;
      end;
    end;
  except
    on E: Exception do begin
      Result := -1;
      MessageDlg(E.Message, mtError, [mbOK], 0);
      WriteToLog(E.Message, 'DM.SetupRemoteConnection');
      Application.Terminate;
    end;
  end;
end;

end.

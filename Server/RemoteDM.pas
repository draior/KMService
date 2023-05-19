unit RemoteDM;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, ComServ, ComObj, VCLCom, DataBkr,
  DBClient, kmServer_TLB, StdVcl, Bde.DBTables, Data.DB, Variants,
  Datasnap.Provider, Vcl.Forms, Vcl.AppEvnts, Vcl.Dialogs;

const
  sc_ArticlesSelect = 1;
  sc_UserName       = 2;
  sc_Mashine        = 3;
  sc_Offers         = 4;
  sc_Client         = 5;
  sc_ClientSerial   = 6;
  sc_MakeOffers     = 7;
  sc_MashineSerial  = 8;
  sc_MashineClent   = 9;
  MaxCountCycles    = 100;


type
  TkmServer = class(TRemoteDataModule, IkmServer)
    DB: TDatabase;
    DBIndex: TDatabase;
    Session: TSession;
    qUpd: TQuery;
    qUpd1: TQuery;
    qUpd2: TQuery;
    qUpd3: TQuery;
    MiscQuery: TDataSetProvider;
    qMiscQuery: TQuery;
    qrTemp: TQuery;
    tArticle: TQuery;
    Article: TDataSetProvider;
    tArticleCODE: TStringField;
    tArticleNAME: TStringField;
    tArticleID: TIntegerField;
    tArticlePRICE: TFloatField;
    tArticleC_USER_ID: TIntegerField;
    tArticleC_ACTIONDATETIME: TDateTimeField;
    tArticleUSED: TSmallintField;
    tUserName: TQuery;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    tUserNameUSED: TSmallintField;
    tUserNameC_ACTIONDATETIME: TDateTimeField;
    UserName: TDataSetProvider;
    tUserNamePASS: TStringField;
    tUserNameRIGHTS: TStringField;
    Mashine: TDataSetProvider;
    tMashine: TQuery;
    MashineDetail: TDataSetProvider;
    tMashineDetail: TQuery;
    tMashineID: TIntegerField;
    tMashineNAME: TStringField;
    tMashineH250: TSmallintField;
    tMashineH500: TSmallintField;
    tMashineH750: TSmallintField;
    tMashineH1000: TSmallintField;
    tMashineH1250: TSmallintField;
    tMashineH1500: TSmallintField;
    tMashineH1750: TSmallintField;
    tMashineH2000: TSmallintField;
    tMashineH3000: TSmallintField;
    tMashineH4000: TSmallintField;
    tMashineH4500: TSmallintField;
    tMashineH5000: TSmallintField;
    tMashineC_USER_ID: TIntegerField;
    tMashineC_ACTIONDATETIME: TDateTimeField;
    tMashineDetailID: TIntegerField;
    tMashineDetailMASHINE_ID: TIntegerField;
    tMashineDetailARTICLE_ID: TIntegerField;
    tMashineDetailQ250: TFloatField;
    tMashineDetailQ500: TFloatField;
    tMashineDetailQ750: TFloatField;
    tMashineDetailQ1000: TFloatField;
    tMashineDetailQ1250: TFloatField;
    tMashineDetailQ1500: TFloatField;
    tMashineDetailQ1750: TFloatField;
    tMashineDetailQ2000: TFloatField;
    tMashineDetailQ2500: TFloatField;
    tMashineDetailQ3000: TFloatField;
    tMashineDetailQ4000: TFloatField;
    tMashineDetailQ4500: TFloatField;
    tMashineDetailQ5000: TFloatField;
    tMashineDetailC_USER_ID: TSmallintField;
    tMashineDetailC_ACTIONDATETIME: TDateTimeField;
    tMashineDetailL_ARTICLE_CODE: TStringField;
    tMashineDetailL_ARTICLE_NAME: TStringField;
    qSearch: TQuery;
    tMashineH2500: TSmallintField;
    qrNewID: TQuery;
    qIndex: TQuery;
    tMashineDetailL_ARTICLE_PRICE: TFloatField;
    SumMashine: TDataSetProvider;
    qSumMashine: TQuery;
    qSumMashineL_250: TFloatField;
    qSumMashineL_500: TFloatField;
    qSumMashineL_750: TFloatField;
    qSumMashineL_1000: TFloatField;
    qSumMashineL_1250: TFloatField;
    qSumMashineL_1500: TFloatField;
    qSumMashineL_1750: TFloatField;
    qSumMashineL_2000: TFloatField;
    qSumMashineL_2500: TFloatField;
    qSumMashineL_3000: TFloatField;
    qSumMashineL_4000: TFloatField;
    qSumMashineL_4500: TFloatField;
    qSumMashineL_5000: TFloatField;
    Offers: TDataSetProvider;
    tOffers: TQuery;
    OffersDetail: TDataSetProvider;
    tOffersDetail: TQuery;
    tOffersID: TIntegerField;
    tOffersDOCDATE: TDateTimeField;
    tOffersOHOUR: TSmallintField;
    tOffersTOTAL: TFloatField;
    tOffersVAT: TFloatField;
    tOffersTOTALVAT: TFloatField;
    tOffersDISCOUNT: TFloatField;
    tOffersCOMMENT: TStringField;
    tOffersC_USER_ID: TIntegerField;
    tOffersC_ACTIONDATETIME: TDateTimeField;
    tOffersL_MASHINE_NAME: TStringField;
    tOffersL_USER_NAME: TStringField;
    tOffersDetailID: TIntegerField;
    tOffersDetailOFFERS_ID: TIntegerField;
    tOffersDetailARTICLE_ID: TIntegerField;
    tOffersDetailQTY: TFloatField;
    tOffersDetailPRICE: TFloatField;
    tOffersDetailC_USER_ID: TIntegerField;
    tOffersDetailC_ACTIONDATETIME: TDateTimeField;
    tOffersDetailL_ARTICLE_CODE: TStringField;
    tOffersDetailL_ARTICLE_NAME: TStringField;
    tOffersDetailL_USER_NAME: TStringField;
    tOffersL_TOTAL: TFloatField;
    tOffersL_VAT: TFloatField;
    tOffersL_TOTALVAT: TFloatField;
    tMashineMTYPE: TStringField;
    tMashinePRODUCER: TStringField;
    tOffersL_MASHINE_TYPE: TStringField;
    tOffersL_MASHINE_SERIALNO: TStringField;
    tOffersL_MASHINE_PRODUCER: TStringField;
    TempCalc: TDataSetProvider;
    qTempCalc: TQuery;
    qGetValue: TQuery;
    tClient: TQuery;
    Client: TDataSetProvider;
    tOffersL_CLIENT_NAME: TStringField;
    tOffersL_CLIENT_REGNO: TStringField;
    tOffersL_CLIENT_CONTACTPERSON: TStringField;
    tOffersL_CLIENT_PHONE: TStringField;
    tOffersL_CLIENT_ADDRESS: TStringField;
    tOffersL_CLIENT_EMAIL: TStringField;
    tClientID: TIntegerField;
    tClientNAME: TStringField;
    tClientREGNO: TStringField;
    tClientADDRESS: TStringField;
    tClientCONTACTPERSON: TStringField;
    tClientPHONE: TStringField;
    tClientEMAIL: TStringField;
    tClientC_USER_ID: TIntegerField;
    tClientC_ACTIONDATETIME: TDateTimeField;
    tArticleREPLCODE: TStringField;
    tArticleSUPPLYPRICE: TFloatField;
    tArticleDESCRIPTION: TStringField;
    MashineSerial: TDataSetProvider;
    tMashineSerial: TQuery;
    tMashineSerialID: TIntegerField;
    tMashineSerialMASHINE_ID: TIntegerField;
    tMashineSerialENGINE: TStringField;
    tMashineSerialSERIALNO: TStringField;
    tMashineSerialCLIENT_ID: TIntegerField;
    tMashineSerialL_MASHINE_MTYPE: TStringField;
    tMashineSerialL_MASHINE_NAME: TStringField;
    tMashineSerialL_CLIENT_NAME: TStringField;
    tMashineSerialL_CLIENT_REGNO: TStringField;
    tMashineSerialL_CLIENT_ADDRESS: TStringField;
    tOffersMASHINESERIAL_ID: TIntegerField;
    tOffersMASHINE_ID: TIntegerField;
    tMashineClient: TQuery;
    tMashineClientID: TIntegerField;
    tMashineClientMTYPE: TStringField;
    tMashineClientNAME: TStringField;
    tMashineClientPRODUCER: TStringField;
    tMashineClientH250: TSmallintField;
    tMashineClientH500: TSmallintField;
    tMashineClientH750: TSmallintField;
    tMashineClientH1000: TSmallintField;
    tMashineClientH1250: TSmallintField;
    tMashineClientH1500: TSmallintField;
    tMashineClientH1750: TSmallintField;
    tMashineClientH2000: TSmallintField;
    tMashineClientH2500: TSmallintField;
    tMashineClientH3000: TSmallintField;
    tMashineClientH4000: TSmallintField;
    tMashineClientH4500: TSmallintField;
    tMashineClientH5000: TSmallintField;
    tMashineClientC_USER_ID: TIntegerField;
    tMashineClientC_ACTIONDATETIME: TDateTimeField;
    tMashineClientL_CLIENT: TStringField;
    tMashineL_CLIENT: TStringField;
    tMashineClientL_SERIALNO: TStringField;
    tMashineClientL_ENGINE: TStringField;
    tMashineL_SERIALNO: TStringField;
    tMashineL_ENGINE: TStringField;
    tMashineL_CLIENT_ID: TIntegerField;
    tMashineClientL_CLIENT_ID: TIntegerField;
    tOffersPRINTED: TSmallintField;
    qrSetValue: TQuery;
    qrDocNo: TQuery;
    tOffersREV: TIntegerField;
    tOffersDetailREV: TStringField;
    tOffersDOCNO: TStringField;
    tUserNameEMAIL: TStringField;
    tUserNameMOBILE: TStringField;
    tUserNamePHONE: TStringField;
    tUserNameFAX: TStringField;
    tOffersL_USER_EMAIL: TStringField;
    tOffersL_USER_MOBILE: TStringField;
    tOffersL_USER_PHONE: TStringField;
    tOffersL_USER_FAX: TStringField;
    procedure RemoteDataModuleDestroy(Sender: TObject);
    procedure HandleUpdateError(Sender: TObject; DataSet: TCustomClientDataSet;
      E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
    procedure PR_BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind;
      var Applied: Boolean);
    procedure PR_AfterUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
  private
    { Private declarations }
    FCallBack: OleVariant;
    FCurrentUser: String;
    FCurrentUserName: String;
    LSQL: TStringList;

    function GetNextDocNo(TblID: Integer; const TblField: WideString; const TblName: WideString;
                          Digits: Integer): String;
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;

    procedure SendNotifyClient(Caption, Msg: String);
    procedure PassDBEngineError(Error: EDBEngineError; strSQL: String; var strMsg: String);
    procedure BeginTrans; safecall;
    procedure CommitTrans; safecall;
    procedure RollbackTrans; safecall;
    procedure RequestDoc(const TblName: WideString; const Cond: WideString; const Ord: WideString;
                         Actv: Shortint); safecall;
    procedure CloseQuery(const TblName: WideString); safecall;
    procedure DeleteRecord(const TblName: WideString; const ID: WideString); safecall;
    function LoginInterface(IClient: OleVariant): Integer; safecall;
    function LogIn(const UName: WideString; const Pass: WideString; out Params: OleVariant): Integer; safecall;
    function TranslateError(intCode: Integer; UpdateKind: TUpdateKind; var strMsg: String): Boolean;
    function SetCommandText(Qry: TQuery; const CmdStr: String; SetOpen : Boolean = True): Integer;
    function AddToTransLog(Date: OleVariant; const Operation: WideString;
                           const OperationResult: WideString; const Description: WideString): Integer; safecall;
    function CloseAllQueries: Integer; safecall;
    function CanEnterEditMode(const TblName: WideString; const TblID: WideString): Integer; safecall;
    function GetFilter(const ProviderName: WideString): WideString; safecall;
    function LastGenID(const ProvName: WideString): WideString; safecall;
    function GetValueEx(SqlID: Integer; const SearchFields: WideString; SearchValues: OleVariant;
                        const ReturnFields: WideString; out ReturnValues: OleVariant;
                        ExactMatch: WordBool): Integer; safecall;
    function GetSQLStatement(SqlID: Integer): WideString; safecall;
    function RequestDocEx(const TblName: WideString; SqlID: Integer; const SqlStr: OleVariant;
                          Actv: WordBool): Integer; safecall;
    function GetNextID(const TblName: WideString): OleVariant; safecall;
    function MakeOffer(MashSerialID: Integer; OHour: Integer; out ID: Integer): Integer; safecall;
    function FilterDocuments(const TblName: WideString; SqlID: Integer; const SqlStr: OleVariant;
                             var OutSql: WideString): Integer; safecall;
    function GetValue(const TblName: WideString; const SearchField: WideString;
                      const SearchValue: WideString; const ResultField: WideString): OleVariant; safecall;
    function CheckMashineSerial(MashID: Integer; const SerNo: WideString; out Range: WideString): Integer; safecall;
    function SetFieldValue(const TblName: WideString; const TblID: WideString;
                           const FldName: WideString; const FldValue: WideString; IsQuoted: Integer): Integer; safecall;
    function SetNextDocNo(TblID: Integer; const TblField: WideString; const TblName: WideString;
                          Digits: Integer): Integer; safecall;
  public
    { Public declarations }
    FLogin_ID: Integer;
  end;

implementation

{$R *.DFM}

uses
  UserMonitor, ULogUtils, HistoryLogConst, uBDEErrors, BDE, CommonUtilities,
  SysUnit;

const
  ErrCodeArr : array[1..2, 0..8] of string = (
     ('Грешка при актуализация',
      'Дублиране на ключово или уникално поле',
      'Невалидна минимална стойност',
      'Невалидна максимална стойност',
      'Не е въведена стойност за задължително поле',
      'Записът участва в документи',
      'Не се разрешава промяна или изтриване на записа',
      'Грешка при запис на промените',
      'Невалидна стойност за свързано поле'),
     ('Update error',
      'Key violation',
      'Min value check failed',
      'Max value check failed',
      'Field value required',
      'Record cannot be deleted because it is in use by other tables',
      'Cannot MODIFY or DELETE a master record with details',
      'Error appling updates',
      'Not a valid link field value detected')
    );

function TkmServer.LastGenID(const ProvName: WideString): WideString;
var
  GenName: String;
begin
  Result := '';
  try
    GenName := '';
    if SameText(ProvName, 'Article') then
      GenName := 'GEN_ARTICLE_ID'
    else if SameText(ProvName, 'TransactionLog') then
      GenName := 'GEN_TRANSACTIONLOG_ID'
    else if SameText(ProvName, 'UserName') then
      GenName := 'GEN_USERNAME_ID'
    else if SameText(ProvName, 'Client') then
      GenName := 'GEN_CLIENT_ID';

    if GenName = '' then
      SysUtils.Abort;

    if SetCommandText(qUpd, 'SELECT GEN_ID(' + GenName + ', 0) FROM RDB$DATABASE') <> 0 then
      SysUtils.Abort;

    if qUpd.RecordCount > 0 then
      Result := qUpd.Fields[0].AsString;
  except
    on E: Exception do begin
      SendNotifyClient( 'Грешка', 'Грешка: ' + E.Message );
      WriteToLog(E.Message, 'TkmServer.LastGenID', '', '');
    end;
  end;
end;

function TkmServer.LogIn(const UName, Pass: WideString;
  out Params: OleVariant): Integer;
var
  lcDesc, lcOperRes: String;
begin
  try
    Params := VarArrayCreate([0, 3], varVariant);
    lcOperRes := str_resSuccess;
    lcDesc := str_descSuccess;
    Result := 0;

    try
      FCurrentUserName := UName;

      Result := SetCommandText(qUpd, 'SELECT * FROM USERNAME WHERE NAME = ' + QuotedStr(String(FCurrentUserName)));
      if Result <> 0 then SysUtils.Abort;

      if qUpd.RecordCount < 1 then begin
        lcOperRes := str_resError;
        lcDesc := Format(str_descUserNotFound, [FCurrentUserName]);
        Result := -2;
        Exit;
      end;

      FCurrentUser :=  qUpd.FieldByName('ID').AsString;

      if qUpd.FieldByName('Pass').AsString <> Pass then begin
        lcOperRes := str_resError;
        lcDesc := Format(str_descWrongPassword, [FCurrentUserName, Pass] );
        Result := -4;
        Exit;
      end;

      Params[0] := FCurrentUser;
      Params[1] := FCurrentUserName;
      Params[2] := qUpd.FieldByName('RIGHTS').AsString;

      fUserMonitor.AddUser(FCurrentUserName, Now, FLogin_ID);
    except
      on E: EAbort do begin
        lcOperRes := str_resError;
        lcDesc := Format( str_descError, [': ' + E.Message] );
        Result := -5;
        WriteToLog(E.Message, 'RemoteDM.LogIn', '', '');
      end;
      on E: Exception do begin
        lcOperRes := str_resError;
        lcDesc := Format( str_descError, [': ' + E.Message] );
        Result := -5;
        SendNotifyClient('Грешка', E.Message );
        WriteToLog(E.Message, 'RemoteDM.LogIn', '', '');
        raise E;
      end;
    end;

    BeginTrans;
    try
      AddToTransLog(NOW, str_LogIn, lcOperRes, lcDesc);
      CommitTrans;
    except
      RollbackTrans;
    end;
  except
    on E: EAbort do begin
      Result := -5;
      WriteToLog(E.Message, 'RemoteDM.LogIn', '', '');
    end;
    on E: Exception do begin
      Result := -5;
      SendNotifyClient( 'Грешка', 'Грешка: ' + E.Message );
      WriteToLog(E.Message, 'LogIn', str_LogIn, lcDesc);
    end;
  end;
end;

function TkmServer.LoginInterface(IClient: OleVariant): Integer;
begin
  Result := 0;
  try
    LSQL := TStringList.Create;
    FLogin_ID := fUserMonitor.AddToIntfArray( IClient );
    FCallBack := IClient;

    if not fUserMonitor.CanLogOn then begin
      Result := -2;
      fUserMonitor.RemoveFromIntfArray(FLogin_ID);
      SendNotifyClient('Грешка при свързване', 'Не е разрешено свързването със сървъра поради извършване на системни операции!');
      Exit;
    end;


    DB.Open;
    DBIndex.Open;
  except
    on E: Exception do begin
      Result := -1;
      WriteToLog(E.Message, 'LoginInterface', '', '');
      if not (VarIsEmpty(FCallBack) or VarIsNull(FCallBack)) then
        SendNotifyClient('Грешка при свързване', 'Грешка:'#13#10 + E.Message);
    end;
  end;
end;

function TkmServer.MakeOffer(MashSerialID, OHour: Integer; out ID: Integer): Integer;
var
  DID, MashID: Integer;
  lcTOTAL, lcVAT, lcTOTALVAT: Double;
  lcDocNo, lcDesc: String;
begin
  Result := -1;
  try
    if SetCommandText(qUpd, 'SELECT MASHINE_ID FROM MASHINESERIAL WHERE ID='+IntToStr(MashSerialID)) <> 0 then
      SysUtils.Abort;
    if (qUpd.RecordCount <= 0) or (qUpd.Fields[0].AsInteger = 0) then begin
      SendNotifyClient('Грешка при изготвяне на оферта', 'Липсват запис в таблица MASHINESERIAL за ID='+IntToStr(MashSerialID)+'!');
      Exit;
    end;
    MashID := qUpd.Fields[0].AsInteger;

    ID := GetNextID('OFFERS');
    lcDocNo := GetNextDocNo(ID, 'DOCNO', 'OFFERS', 8);

    if SetCommandText(qUpd, 'INSERT INTO OFFERS (ID, DOCDATE, DOCNO, MASHINESERIAL_ID, OHOUR, C_USER_ID)'#13 +
         'VALUES ('+IntToStr(ID)+', "'+FormatDateTime('dd.mm.yyyy', NOW)+'", "'+lcDocNo+'",'+IntToStr(MashSerialID)+', '+IntToStr(OHour)+', '+FCurrentUser+')'
         , False) <> 0 then
      SysUtils.Abort;

    if SetCommandText(qUpd, 'SELECT md.ARTICLE_ID, md.Q'+IntToStr(OHour)+' as QTY, a.PRICE FROM MASHINEDETAIL md '#13+
           '  INNER JOIN ARTICLE a on md.ARTICLE_ID=a.ID WHERE md.MASHINE_ID='+IntToStr(MashID)+' and md.Q'+IntToStr(OHour)+'>0') <> 0 then
      SysUtils.Abort;

    if qUpd.RecordCount <= 0 then begin
      SendNotifyClient('Грешка при изготвяне на оферта', 'Липсват редове за избраната машина и период!');
      Exit;
    end;

    while not qUpd.Eof do begin
      DID := GetNextID('OFFERSDETAIL');
      if SetCommandText(qUpd1, 'INSERT INTO OFFERSDETAIL (ID, OFFERS_ID, ARTICLE_ID, QTY, PRICE, REV, C_USER_ID)'#13 +
             'VALUES ('+IntToStr(DID)+', '+IntToStr(ID)+', '+qUpd.FieldByName('ARTICLE_ID').AsString+' ,'+
                      FormatFloat('0.000', qUpd.FieldByName('QTY').AsFloat)+', '+
                      FormatFloat('0.00', qUpd.FieldByName('PRICE').AsFloat)+', ";1;", '+FCurrentUser+')', False) <> 0 then
        SysUtils.Abort;
      qUpd.Next;
    end;

    if SetCommandText(qUpd, 'SELECT SUM(QTY * PRICE) as TOTAL FROM OFFERSDETAIL WHERE OFFERS_ID='+IntToStr(ID)) <> 0 then
      SysUtils.Abort;

    lcTOTAL := qUpd.FieldByName('TOTAL').AsFloat;
    lcVAT := lcTOTAL * 0.2;
    lcTOTALVAT := lcTOTAL * lcVAT;

    if SetCommandText(qUpd, 'UPDATE OFFERS SET TOTAL='+FormatFloat('0.00', lcTOTAL)+', '+
                      'VAT='+FormatFloat('0.00', lcVAT)+', TOTALVAT='+FormatFloat('0.00', lcTOTALVAT)+
                      ' WHERE ID='+IntToStr(ID), False) <> 0 then
      SysUtils.Abort;

    lcDesc := 'ID='+IntToStr(ID)+#13#10+
              'DOCDATE='+FormatDateTime('dd.mm.yyyy', NOW)+#13#10+
              'MASHINE_ID='+IntToStr(MashID)+#13#10+
              'OHOUR='+IntToStr(OHour)+#13#10+
              'C_USER_ID='+FCurrentUser;
    AddToTransLog(NOW, str_MakeOffers, str_resSuccess, lcDesc);
    Result := 0;
  except
    on E: EAbort do
      WriteToLog(E.Message, 'TkmServer.MakeOffer');

    on E: Exception do begin
      SendNotifyClient('Грешка', 'Грешка: ' + E.Message);
      WriteToLog(E.Message, 'TkmServer.MakeOffer');
    end;
  end;
end;

function TkmServer.AddToTransLog(Date: OleVariant; const Operation,
  OperationResult, Description: WideString): Integer;
var
  lcCode, lcDesc, lcDate, lcTime: String;
begin
  try

    lcCode := Copy( Operation, 1, Pos( '_', Operation ) - 1 );
    lcDesc := Copy( Operation, Pos( '_', Operation ) + 1, Length( Operation ) );
    lcDate := FormatDateTime( 'dd.mm.yyyy 00:00:00', Date );
    lcTime := FormatDateTime( 'dd.mm.yyyy hh:nn:ss', Date );

    if SetCommandText(qrTemp, 'INSERT INTO TRANSACTIONLOG ' +
         '(C_USER_ID, OPERATIONDATE, C_ACTIONDATETIME, OPERATIONCODE, ' +
         'OPERATIONDESC, OPERATIONRESULT, DESCRIPTION) ' +
         'VALUES(' +
         QuotedStr( FCurrentUser ) + ' , ' +
         QuotedStr( lcDate ) + ' , ' +
         QuotedStr( lcTime ) + ' , ' +
         QuotedStr( lcCode ) + ' , ' +
         QuotedStr( lcDesc ) + ' , ' +
         QuotedStr( OperationResult ) + ' , ' +
         QuotedStr( Description ) + ' )', False ) <> 0
    then SysUtils.Abort;
  except
    on E: EAbort do
      WriteToLog(E.Message, 'AddToTransactionLog', '', '');

    on E: Exception do begin
      SendNotifyClient('Грешка', 'Грешка: ' + E.Message);
      WriteToLog(E.Message, 'AddToTransLog', '', '');
    end;
  end;
end;

procedure TkmServer.BeginTrans;
begin
  try
    if not DB.InTransaction then DB.StartTransaction;
  except
    on E: Exception do begin
      SendNotifyClient('Грешка', 'Грешка: ' + E.Message );
      WriteToLog(E.Message, 'BeginTrans', 'Стартиране на транзакция', '');
    end;
  end;
end;

function TkmServer.CanEnterEditMode(const TblName: WideString; const TblID: WideString): Integer;
begin
  Result := 0;
  try
    if SetCommandText(qUpd, 'SELECT * FROM ' + TblName + ' WHERE ID = ' + TblID) <> 0 then SysUtils.Abort;

    if qUpd.RecordCount <= 0 then begin
      Result := -1;
      SendNotifyClient( 'Грешка при проверка статуса на документ',
          'Документ, с посоченото ключово поле, не може да бъде намерен в базата данни.'#13#10'Моля, актуализирайте информацията.');
    end;
  except
    on E: EAbort do begin
      Result := -1;
      WriteToLog(E.Message, 'CanEnterEditMode', '', '');
    end;
    on E: Exception do begin
      Result := -1;
      SendNotifyClient('Грешка', E.Message);
      WriteToLog(E.Message, 'CanEnterEditMode', '', '');
    end;
  end;
end;

function TkmServer.CheckMashineSerial(MashID: Integer;
  const SerNo: WideString; out Range: WideString): Integer;
var
  i, j: Integer;
  DBSer, InSer, TmpSer: String;
begin
  Result := -1;
  try
    if SetCommandText(qUpd, 'SELECT FROMSERNO, TOSERNO FROM MASHINESERIALRANGE WHERE MASHINE_ID='+IntToStr(MashID)) <> 0 then
      SysUtils.Abort;
    if (qUpd.RecordCount < 0) or (qUpd.FieldByName('FROMSERNO').AsString = '') then begin
      Result := 0;
      Exit;
    end;
    Range := qUpd.FieldByName('FROMSERNO').AsString + ' - ' + qUpd.FieldByName('TOSERNO').AsString;

    DBSer := '';
    InSer := '';
    j := 1;
    for i := 1 to Length(SerNo) do begin
      if SerNo[i] in ['0'..'9'] then begin
        if Length(qUpd.FieldByName('FROMSERNO').AsString) >= i then begin
          if not (qUpd.FieldByName('FROMSERNO').AsString[i] in  ['0'..'9']) then
            Exit;
          DBSer := DBSer + qUpd.FieldByName('FROMSERNO').AsString[i];
        end;
        InSer := InSer + SerNo[i]
      end
      else if Length(qUpd.FieldByName('FROMSERNO').AsString) < i then
        Exit
      else if SerNo[i] <> qUpd.FieldByName('FROMSERNO').AsString[i] then
        Exit;
      j := i;
    end;
    TmpSer := IntToStr(StrToInt64Digi(qUpd.FieldByName('FROMSERNO').AsString));
    while j < Length(TmpSer) do begin
      DBSer := DBSer + TmpSer[j];
      Inc(j);
    end;
    if StrToInt64Digi(DBSer) > StrToInt64Digi(InSer) then
      Exit;

    if (qUpd.FieldByName('TOSERNO').AsString = '') or (qUpd.FieldByName('TOSERNO').AsString = '+') then begin
      Result := 0;
      Exit;
    end;

    DBSer := '';
    InSer := '';
    j := 1;
    for i := 1 to Length(SerNo) do begin
      if SerNo[i] in ['0'..'9'] then begin
        if Length(qUpd.FieldByName('TOSERNO').AsString) >= i then begin
          if not (qUpd.FieldByName('TOSERNO').AsString[i] in  ['0'..'9']) then
            Exit;
          DBSer := DBSer + qUpd.FieldByName('TOSERNO').AsString[i];
        end;
        InSer := InSer + SerNo[i]
      end
      else if Length(qUpd.FieldByName('TOSERNO').AsString) < i then
        Exit
      else if SerNo[i] <> qUpd.FieldByName('TOSERNO').AsString[i] then
        Exit;
      j := i;
    end;
    TmpSer := IntToStr(StrToInt64Digi(qUpd.FieldByName('FROMSERNO').AsString));
    while j < Length(TmpSer) do begin
      DBSer := DBSer + TmpSer[j];
      Inc(j);
    end;
    if StrToInt64Digi(DBSer) >= StrToInt64Digi(InSer) then
      Result := 0;
  except
    on E: Exception do begin
      Result := -1;
      SendNotifyClient('Грешка', E.Message);
      WriteToLog(E.Message, 'CheckMashineSerial');
    end;
  end;
end;

function TkmServer.CloseAllQueries: Integer;
var
  i: Integer;
begin
  try
    for i := 0 to ComponentCount - 1 do
      if Components[i] is TQuery then
      try
        (Components[i] as TQuery).Close;
      except
        on E: Exception do begin
          Result := -1;
          SendNotifyClient( 'Грешка', E.Message );
          WriteToLog(E.Message, 'CloseAllQueries', '', '');
        end;
      end;
    Result := 0;
  except
    on E: Exception do begin
      Result := -1;
      SendNotifyClient( 'Грешка', E.Message );
      WritetoLog( E.Message, 'CloseAllQueries', '', '' );
    end;
  end;
end;

procedure TkmServer.CloseQuery(const TblName: WideString);
begin
  try
    TQuery((Providers[TblName] as TDataSetProvider).DataSet).Close;
  except
    on E: Exception do begin
      SendNotifyClient( 'Грешка', E.Message );
      WriteToLog(E.Message, 'CloseQuery', '', '');
    end;
  end;
end;

procedure TkmServer.CommitTrans;
begin
  try
    if DB.InTransaction then
      DB.Commit;
  except
    on E: Exception do begin
      WriteToLog(E.Message, 'CommitTrans', 'Приключване на транзакция', '');
      SendNotifyClient('Грешка при приключване на транзакция', 'Грешка при приключване на транзакция.' + #13#10 + E.Message);
    end;
  end;
end;

procedure TkmServer.DeleteRecord(const TblName, ID: WideString);
begin
  try
    SetCommandText(qUpd, 'INSERT INTO DELETEDRECORD (TABLENAME, TABLEID, C_USER_ID) ' +
                         'VALUES ("' + String(TblName) + '", "' + String(ID) + '", "' + FCurrentUser + '" )', False);
  except
    on E: Exception do begin
      SendNotifyClient( 'Грешка', E.Message );
      WriteToLog(E.Message, 'DeleteRecord', 'Изтриване на запис', '');
    end;
  end;
end;

function TkmServer.FilterDocuments(const TblName: WideString; SqlID: Integer;
  const SqlStr: OleVariant; var OutSql: WideString): Integer;

var
  UpTblName, lcSQLString, lcCGroup, lcVal, lcMainSQLStatement, lcRestrictFilter, lcCond: String;
  i, n, lcIndex: Integer;
begin
  Result := -1;
  lcSQLString := '';
  lcRestrictFilter := '';
  UpTblName := UpperCase(TblName);
  try
    if VarIsArray(SQLStr) then begin
      //TODO: da se mahne -1 zashtoto sega e zaradi posledniia red "; ; ; ;"
      n := VarArrayHighBound(SQLStr, 1) - 1;
      for i := 0 to n do begin
        Application.ProcessMessages;

        lcCGroup := '' + VarToStr(SQLStr[i][0]) + ' ';

        FilterVarToStr(SqlStr[i][2], lcVal);

        lcCond := SQLStr[i][1];
        if (VarToStr(SQLStr[i][1]) = '=') and ((VarType(SqlStr[i][2]) = varString) or (VarType(SqlStr[i][2]) = varOleStr)) then
          lcCond := 'LIKE';

        lcSQLString := lcSQLString + ' ( ' + lcCGroup + lcCond + ' ' + lcVal + ' ) ' + VarToStr(SQLStr[i][3]) + ' ';
      end;

      (*lcRestrictFilter := CanAddRestrictFilter(UpperCase(TableName));
      if Length(lcRestrictFilter) > 0 then
        lcSQLString := lcRestrictFilter + ' AND ( ' + lcSQLString + ' ) ';*)

      OutSQL := lcSQLString;

      lcMainSQLStatement := GetSQLStatement(SqlID);

      lcIndex := Pos( 'GROUP BY', lcMainSQLStatement );
      if lcIndex = 0 then lcIndex := Length(lcMainSQLStatement) + 1;

      if Length( lcSQLString ) > 0 then
        Insert(' WHERE ' + lcSQLString + ' ', lcMainSQLStatement, lcIndex);

      with TQuery(TDataSetProvider(Providers[TblName]).DataSet) do begin
        Close;
        SQL.Clear;
        SQL.Add(lcMainSQLStatement);
        //ShowMessage(SQL.Text);
        Result := 0;
      end;
    end
    else
      SendNotifyClient( 'Грешка при изпълнение на филтър', 'Некоректен филтър!' );
  except
    on E: Exception do begin
      SendNotifyClient('Грешка при изпълнение на филтър', E.Message);
      WriteToLog(E.Message, 'FilterDocuments', '', 'TableName: ' + TblName + ', SQL_ID: ' + IntToStr(SqlID));
    end;
  end;
end;

function TkmServer.GetFilter(const ProviderName: WideString): WideString;
var
  SQLString: string;
  lc_oleProv: OleVariant;
  lc_index: Integer;
  lc_DSProv: TDataSetProvider;
begin
  Result := '';
  try
    //lc_DSProv := Providers[ProviderName] as TDataSetProvider;
    lc_oleProv := AS_GetProviderNames;
    for lc_index := 0 to VarArrayHighBound(lc_oleProv, 1) do begin
      if AnsiUpperCase(lc_oleProv[lc_index]) = AnsiUpperCase(ProviderName) then
        Break;
    end;
    lc_DSProv := Providers[lc_oleProv[lc_index]] as TDataSetProvider;

    //tova beshe v skobite (Providers[ProviderName] as TDataSetProvider)
    with TQuery(lc_DSProv.DataSet) do begin
      SQLString := SQL.Text;

      if (Pos('WHERE', SQLString) > 0) then
        if (Pos('ORDER BY', SQLString) = 0) then
          Result := System.Copy(SQLString, Pos('WHERE', SQLString) + 5, Length(SQLString) - Pos('WHERE', SQLString) - 1)
        else
          Result := System.Copy(SQLString, Pos('WHERE', SQLString) + 5, Pos('ORDER BY', SQLString) - Pos('WHERE', SQLString) - 5)
    end;
  except
    on E: Exception do
      WriteToLog(E.Message, 'GetFilter');
  end;
end;

function TkmServer.GetNextDocNo(TblID: Integer; const TblField,
  TblName: WideString; Digits: Integer): String;
var
  lcNextID: Longint;
begin
  Result := '';
  try
    if SetCommandText(qrDocNo, 'SELECT * FROM NOM_DOCNUMBERS WHERE UPPER(TABLENAME) = "' + UpperCase(TblName) + '"', True) <> 0 then
      SysUtils.Abort;

    if qrDocNo.RecordCount < 1 then begin
      SendNotifyClient( 'Грешка при задаване на номер на документа', 'Няма въведени граници за номер на документ в базата данни!' );
      SysUtils.Abort;
    end
    else if qrDocNo.RecordCount > 1 then begin
      SendNotifyClient( 'Грешка при задаване на номер на документа', 'Има въведени повече от една граница за номер на документ в базата данни!' );
      SysUtils.Abort;
    end;

    lcNextID := Round(qrDocNo.FieldByName('COUNTER').AsFloat ) + 1;
    Result := AlignRight(IntToStr(lcNextID), Digits, '0');

    if SetCommandText(qrDocNo, 'UPDATE NOM_DOCNUMBERS SET COUNTER = COUNTER + 1 WHERE UPPER(TABLENAME) = "' + UpperCase(TblName) + '"', False) <> 0 then
      SysUtils.Abort;
  except
    on E: EAbort do
      ;
    on E: Exception do begin
      WriteToLog(E.Message, 'SetNextDocNo', 'Задаване на номер на документ', '');
      SendNotifyClient( 'Грешка при задаване на номер на документа', 'Грешка при задаване на номер на документа.'#13#10 + E.Message);
    end;
  end;
end;

function TkmServer.GetNextID(const TblName: WideString): OleVariant;
var
  CountCycles, NewID: Integer;
  GoodID: Boolean;
begin
  CountCycles := 0;
  GoodID := False;
  Result := 0;

  try
    // do MaxCountCycles pati se opitva da vzeme ID, koeto ne se dublira s takova v bazata danni
    while (not GoodID) and (CountCycles <= MaxCountCycles) do begin
      {spGetNextID.ParamByName('NTABLE').AsString := TableName;
      spGetNextID.ExecProc;}
      if not DBIndex.Connected then
        DBIndex.Connected := True;
      if not DBIndex.InTransaction then DBIndex.StartTransaction;

      if SetCommandText(qIndex, 'UPDATE INDEXPREFIX SET INDEXCOUNT = INDEXCOUNT + 1 WHERE UPPER(TABLENAME) = "' + UpperCase(TblName) +'"', False) <> 0 then
        SysUtils.Abort;

      if DBIndex.InTransaction then DBIndex.Commit;

      if SetCommandText(qIndex, 'SELECT INDEXCOUNT FROM INDEXPREFIX WHERE UPPER(TABLENAME) = "' + UpperCase(TblName) + '"') <> 0 then
        SysUtils.Abort;

      if qIndex.RecordCount > 0 then begin
        NewID := qIndex.Fields[0].AsInteger;

        if SetCommandText(qrNewID, 'SELECT ID FROM ' + TblName + ' WHERE ID = ' + IntToStr(NewID)) <> 0 then
          SysUtils.Abort;;

        if qrNewID.RecordCount <= 0 then begin
          Result := NewID;
          GoodID := True;
        end
        else if CountCycles = MaxCountCycles then begin
          WriteToLog('BASIC_ID_EXCEPTION', 'GetNextID', 'Генериране на ID: ' + UpperCase(TblName), 'В таблицата вече има такъв идентификатор');
        end;
      end;
      Inc(CountCycles);
    end; //while
  except
    on E: Exception do begin
      SendNotifyClient('Грешка при генериране ID на документ', 'Не може да се генерира ID на документа.' + #13#10 + E.Message);
      WriteToLog(E.Message, 'GetNextID', 'Генериране на ID: ' + UpperCase(TblName), 'BASIC ID EXCEPTION');
    end;
  end;

  if Result = 0 then begin
    Randomize;
    Result := IntToStr(Random(10000)) + IntToStr(Random(5000)) ;
    WriteToLog('RANDOM GENERATED ID', 'GetNextID', 'Генериране на ID: ' + UpperCase(TblName), 'Null ID was returned by procedure');
  end;
end;

function TkmServer.GetSQLStatement(SqlID: Integer): WideString;
var
  p: Integer;
  S: String;
begin
  if LSQL = nil then
    LSQL := TStringList.Create;

  Result := Trim(LSQL.Values[IntToStr(SqlID)]);
  if Result = '' then begin
    case SqlID of
      sc_ArticlesSelect:
        begin
          Result := tArticle.SQL.Text;
        end;
      sc_UserName:
        begin
          Result := tUserName.SQL.Text;
        end;
      sc_Mashine:
        begin
          Result := tMashine.SQL.Text;
        end;
      sc_Offers:
        begin
          Result := tOffers.SQL.Text;
        end;
      sc_Client:
        begin
          Result := tClient.SQL.Text;
        end;
      sc_MashineSerial:
        begin
          Result := tMashineSerial.SQL.Text
        end;
      sc_MashineClent:
        begin
          Result := tMashineClient.SQL.Text;
        end;
    end;
    //ShowMessage('SSS'#13#10+ Result);
    S := Result;
    P := System.Pos('WHERE', S);
    if P <> 0 then
      SetLength(S, p-1);
    Result := S;

    LSQL.Values[IntToStr(SqlID)] := Result;
  end;
end;

function TkmServer.GetValue(const TblName, SearchField, SearchValue,
  ResultField: WideString): OleVariant;
var
  Cmdstr: String;
begin
  try
    CmdStr := 'SELECT ' + ResultField +
              ' FROM ' + TblName +
              ' WHERE ' + SearchField + ' = "' + SearchValue + '"';

    if SetCommandText(qGetValue, cmdstr) = 0 then
      if qGetValue.RecordCount > 0 then
        Result := qGetValue.Fields[0].AsVariant
      else
        Result := Null
    else
      Result := Null;
  except
    on E: Exception do begin
      Result := Null;
      WriteToLog(E.Message, 'TkmServer.GetValue', '', '[SQL] : ' + cmdstr);
    end;
  end;
end;

function TkmServer.GetValueEx(SqlID: Integer; const SearchFields: WideString;
  SearchValues: OleVariant; const ReturnFields: WideString;
  out ReturnValues: OleVariant; ExactMatch: WordBool): Integer;
var
  lcSQLString, lcSQLStringCond, lcColumns: String;
  i, n, lcIndex: Integer;
begin
  Result := -1;
  lcSQLStringCond := '';

  try
    n := VarArrayHighBound(SearchValues, 1);

    if (SqlID > 0) and (SearchFields <> '') and (n >= 0) then begin
      if n = (GetFieldsCount(SearchFields, ';') - 1) then begin
        inc(n);
        lcColumns := ChangeSeparator(SearchFields, ';', ',');

        lcSQLString := GetSQLStatement(SqlID);

        for i := 1 to n do begin
          if ExactMatch then
            lcSQLStringCond := lcSQLStringCond + GetField(lcColumns, ',', i) + '=' + QuotedStr(VarToStr(SearchValues[i - 1])) + ' AND '
          else
            lcSQLStringCond := lcSQLStringCond + GetField(lcColumns, ',', i) + ' LIKE ' + QuotedStr(VarToStr(SearchValues[i - 1]) + '%') + ' AND ';
          Application.ProcessMessages;
        end;

        //PROVERIAVAME ZA GROUP BY I ORDER BY CLAUZI ZA DA VMAKNEM WHERE PREDI TIAH
        lcIndex := Pos('GROUP BY', lcSQLString);
        if lcIndex = 0 then lcIndex := Pos('ORDER BY', lcSQLString);

        if lcIndex = 0 then lcIndex := Length(lcSQLString) + 1;

        if (Length(lcSQLStringCond) > 0) then begin
          SetLength(lcSQLStringCond, length(lcSQLStringCond) - 5);
          Insert(' WHERE ' + lcSQLStringCond + ' ', lcSQLString, lcIndex);
        end;

        with qSearch do begin
          if Active then Close;
          SQL.Clear;
          SQL.Add(lcSQLString);

          //WriteToLog('', 'GetValueEx', lcSQLString, '');
          Open;
          Next;
          if (not Bof) and Eof then        // samo 1 zapis
            Result := 1
          else if Bof and Eof then            // nito edin zapis
            Result := 0
          else
            Result := 2;                 // pove4e ot edin zapis

          ReturnValues := FieldValues[ReturnFields];

        end;
      end;
    end;
  except
    on E: Exception do begin
      Result := -1;
      SendNotifyClient('Грешка', E.Message );
      WriteToLog(E.Message, 'GetValueEx', '', '');
    end;
  end;
  qSearch.Close;
  qSearch.SQL.Clear;
end;

procedure TkmServer.HandleUpdateError(Sender: TObject; DataSet: TCustomClientDataSet;
      E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
var
  ErrText, lcOper: String;
  ECode: Integer;
begin
  try
    ErrText := E.Message;
    if not TranslateError(E.ErrorCode, UpdateKind, ErrText) then begin
      ECode := E.ErrorCode - 9728; //Ivan 01.04.2001 vadim starshia byte ot ErrorCode $2600
      case ECode of
           1: ErrText := ErrCodeArr[1, 1];
           2: ErrText := ErrCodeArr[1, 2];
           3: ErrText := ErrCodeArr[1, 3];
           4: ErrText := ErrCodeArr[1, 4];
           5: ErrText := ErrCodeArr[1, 5];
           6: ErrText := ErrCodeArr[1, 6]
         else ErrText := ErrCodeArr[1, 7];
      end; //case
    end;

    ErrText := 'Код на грешката: ' + IntToStr(E.ErrorCode) + ' -> ' + ErrText;

    SendNotifyClient(ErrCodeArr[1, 0], ErrText);

    case UpdateKind of
      ukInsert: lcOper := GetOperationDesc((Sender as TDataSetProvider).Name, 1);
      ukModify: lcOper := GetOperationDesc((Sender as TDataSetProvider).Name, 2);
      ukDelete: lcOper := GetOperationDesc((Sender as TDataSetProvider).Name, 3);
    end;

    AddToTransLog( NOW, lcOper, str_resError, E.Message );

    WriteToLog(E.Message, 'HandleUpdateError', lcOper, ErrText);
  except
    on E: Exception do WriteToLog(E.Message, 'HandleUpdateError', '', '');
  end;
end;

procedure TkmServer.RemoteDataModuleDestroy(Sender: TObject);
begin
  try
    FreeAndNil(LSQL);
    CloseAllQueries;

    if FLogin_ID <> -1 then fUserMonitor.RemoveUser( FLogin_ID );
  except
    on E: Exception do WriteToLog(E.Message, 'RemoteDataModuleDestroy', '', '');
  end;
end;

procedure TkmServer.RequestDoc(const TblName, Cond, Ord: WideString;
  Actv: Shortint);
var
  SQLString, sOrderCls, sWhereCls, sRestrict, sGroupCls: String;
  CopyCntr: Integer;
begin
  try
    with TQuery((Providers[TblName] as TDataSetProvider).DataSet) do begin
      SQLString := SQL.Text;

      if Pos('GROUP BY', SQLString) > 0 then begin
        if Pos('ORDER BY', SQLString) > 0 then
          CopyCntr := Pos('GROUP BY', SQLString) - Pos('ORDER BY', SQLString)
        else
          CopyCntr := Length(SQLString) - Pos('GROUP BY', SQLString) - 1;
        sGroupCls := ' ' + System.Copy(SQLString, Pos('GROUP BY', SQLString), CopyCntr);
      end;

      if Pos('ORDER BY', SQLString) > 0 then
        sOrderCls := ' ' + System.Copy(SQLString, Pos('ORDER BY', SQLString), Length(SQLString) - Pos('ORDER BY', SQLString) - 1);

      System.Delete(SQLString, Pos('ORDER BY', SQLString), Length(SQLString) - Pos('ORDER BY', SQLString) - 1);
      System.Delete(SQLString, Pos('WHERE', SQLString), Length(SQLString) - Pos('WHERE', SQLString) - 1);

      Close;
      SQL.Clear;
      SQL.Text := SQLString;

      sWhereCls := Cond;

      //TODO DRAGO за момента не ни трябва sRestrict := CanAddRestrictFilter(UpperCase(TblName));
      if Length(sRestrict) > 0 then begin
        if Length(sWhereCls) > 0 then
          sWhereCls := '( ' + sRestrict + ' ) AND ( ' + sWhereCls + ' ) '
        else
          sWhereCls := '( ' + sRestrict + ' ) ';
      end;
      //**********************************************************************//

      if sWhereCls <> '' then SQL.Add(' WHERE ' + sWhereCls);
      if sGroupCls <> '' then SQL.Add(sGroupCls);
      if Ord  <> '' then SQL.Add(' ORDER BY ' + Ord)
      else SQL.Add(sOrderCls);

      //ShowMessage(SQL.Text);
      if Actv = 1 then
        try
          Open;
        except
          Close;
        end;
    end;
  except
    on E: Exception do
      WriteToLog(E.Message, 'RequestDoc', '[TABLE]: ' + TblName + #13#10 + '[WHERE CLAUSE]: ' + Cond, '');
  end;
end;

function TkmServer.RequestDocEx(const TblName: WideString; SqlID: Integer;
  const SqlStr: OleVariant; Actv: WordBool): Integer;
var
  i, n, lcIndex: Integer;
  lcSQLString, lcCGroup, lcVal, lcMainSQLStatement: String;
begin
  lcSQLString := '';

  try
    //TODO: da se mahne -1 zashtoto sega e zaradi posledniia red "; ; ; ;"
    n := VarArrayHighBound(SqlStr, 1) - 1;
    for i := 0 to n do begin
      Application.ProcessMessages;
      lcCGroup := '' + VarToStr(SqlStr[i][0]) + ' ';

      if VarToStr(SqlStr[i][1]) = '=' then
        lcCGroup := lcCGroup + 'LIKE '
      else if VarToStr(SqlStr[i][1]) = '==' then //za sluchaite kogato ni trqbva =, a ne LIKE
        lcCGroup := lcCGroup + '= '
      else
        lcCGroup := lcCGroup + SqlStr[i][1];

      lcVal := VarToStr(SqlStr[i][2]);

      if UpperCase( VarToStr(SqlStr[i][1]) ) <> 'IN' then begin
        if UpperCase( VarToStr(SqlStr[i][1]) ) <> '==' then
          if (Length(lcVal) > 1) and (Pos('%', lcVal) <> Length(lcVal)) then // NO % at the end
             lcVal := lcVal + '%';

        lcCGroup := lcCGroup + QuotedStr(lcVal);
      end
      else
        lcCGroup := lcCGroup + lcVal;

      lcSQLString := lcSQLString + '(' + lcCGroup + ') ' + VarToStr(SqlStr[i][3]) + ' ';
    end;

    lcMainSQLStatement := GetSQLStatement(SqlID);

    lcIndex := Pos('GROUP BY', lcMainSQLStatement);
    if lcIndex = 0 then
      lcIndex := Length(lcMainSQLStatement) + 1;

    if Length(lcSQLString) > 0 then
      Insert(' WHERE ' + lcSQLString + ' ', lcMainSQLStatement, lcIndex);

    with TQuery(TDataSetProvider(Providers[TblName]).DataSet) do begin
      Close;
      SQL.Clear;
      SQL.Add(lcMainSQLStatement);
      if Actv then begin
        Open;
        Next;
        if (not Bof) and Eof then   // samo 1 zapis
          Result := 1
        else if Bof and Eof then       // nito edin zapis
          Result := -1
        else
          Result := 2;            // pove4e ot edin zapis
      end;
    end;
  except
    on E: Exception do begin
      Result := -1;
      SendNotifyClient('Грешка', E.Message);
      WriteToLog(E.Message, 'RequestDocEx', 'SQL Open', lcMainSQLStatement);
    end;
  end;
end;

procedure TkmServer.RollbackTrans;
begin
  try
    if DB.InTransaction then
      DB.Rollback;
  except
    on E: Exception do begin
      WriteToLog(E.Message, 'RollbackTrans', 'Отказ от запис на транзакция', '');
      SendNotifyClient('Отказ от запис на транзакция', 'Грешка при отказ от запис на транзакция.' + #13#10 + E.Message);
    end;
  end;
end;

function TkmServer.TranslateError(intCode: Integer; UpdateKind: TUpdateKind; var strMsg: String): Boolean;
var
  lc_strTmp, lc_strSQL, lc_strInteg: String;
  lc_intPos: Integer;
begin
  lc_strTmp := strMsg;

  if intCode = DBIERR_FORIEGNKEYERR then begin
    lc_intPos := Pos( 'INTEG', lc_strTmp );

    if lc_intPos > 0 then begin
      lc_strInteg := 'INTEG_';
      lc_intPos := lc_intPos + 6;

      while (lc_strTmp[lc_intPos] <> '"') and (Length(lc_strTmp) > lc_intPos) do begin
        lc_strInteg := lc_strInteg + lc_strTmp[lc_intPos];
        Inc( lc_intPos );
      end;

      lc_strSQL := 'SELECT SRC_NAME.CYRNAME L_SRC_NAME_CYRNAME, ' +
        '  SRC.RDB$RELATION_NAME OUT_SCRTBL, ' +
        '  RDB$INDEX_SEGMENTS.RDB$FIELD_NAME OUT_TRGFIERLD, ' +
        '  TRG.RDB$RELATION_NAME OUT_TRGTBL, ' +
        '  TRG_NAME.CYRNAME L_TRG_NAME_CYRNAME, ' +
        '  SYS_FIELDLIST.CAPTION ' +
        'FROM RDB$RELATION_CONSTRAINTS SRC ' +
        'INNER JOIN RDB$INDEX_SEGMENTS ON RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = SRC.RDB$INDEX_NAME ' +
        'INNER JOIN RDB$REF_CONSTRAINTS ON RDB$REF_CONSTRAINTS.RDB$CONSTRAINT_NAME = SRC.RDB$CONSTRAINT_NAME ' +
        'INNER JOIN RDB$RELATION_CONSTRAINTS TRG ON TRG.RDB$CONSTRAINT_NAME = RDB$REF_CONSTRAINTS.RDB$CONST_NAME_UQ ' +
        'INNER JOIN SYS_TABLELIST SRC_NAME ON SRC_NAME.NAME = SRC.RDB$RELATION_NAME ' +
        'INNER JOIN SYS_TABLELIST TRG_NAME ON TRG_NAME.NAME = TRG.RDB$RELATION_NAME ' +
        'INNER JOIN SYS_FIELDLIST ON SYS_FIELDLIST.TABLENAME = SRC.RDB$RELATION_NAME AND SYS_FIELDLIST.FIELDNAME = RDB$INDEX_SEGMENTS.RDB$FIELD_NAME ' +
        'WHERE SRC.RDB$CONSTRAINT_NAME = ' + QuotedStr( lc_strInteg );

      try
        if SetCommandText(qUpd3, lc_strSQL, TRUE ) <> 0 then SysUtils.Abort;

        Result := not qUpd3.IsEmpty;

        if Result then begin
          case UpdateKind of
            ukModify,
            ukInsert :
              strMsg := c_strErrorModify + ' '
                      + Format( c_strIncorrectValue, [qUpd3.FieldByName('CAPTION').AsString] ) + ' '#13#10
                      + Format( c_strRecordIntegrity, [qUpd3.FieldByName('L_SRC_NAME_CYRNAME').AsString, qUpd3.FieldByName('L_TRG_NAME_CYRNAME').AsString, qUpd3.FieldByName('CAPTION').AsString] );
            ukDelete :
              strMsg := c_strErrorDelete + ' '
                      + Format( c_strRecordIntegrity, [qUpd3.FieldByName('L_SRC_NAME_CYRNAME').AsString, qUpd3.FieldByName('L_TRG_NAME_CYRNAME').AsString, qUpd3.FieldByName('CAPTION').AsString] );
          end; //case
        end;
      except
        on E: Exception do begin
          Result := FALSE;
          WriteToLog(E.Message, 'TranslateError', '', '');
        end;
      end;
    end
    else
      Result := False;
  end
  else
    Result := GetErrorMsg(intCode, strMsg);
end;

procedure TkmServer.PassDBEngineError(Error: EDBEngineError; strSQL: String;
  var strMsg: String);
var
  lc_UpdateKind: TUpdateKind;
  lc_strTmp: String;
begin
  lc_UpdateKind := ukInsert;

  //if Pos( 'INSERT', Trim(strSQL) ) = 1 then lc_UpdateKind := ukInsert;
  if Pos( 'UPDATE', Trim(strSQL) ) = 1 then lc_UpdateKind := ukModify;
  if Pos( 'DELETE', Trim(strSQL) ) = 1 then lc_UpdateKind := ukDelete;

  lc_strTmp := Error.Message;
  TranslateError(Error.Errors[0].ErrorCode, lc_UpdateKind, lc_strTmp);

  strMsg := lc_strTmp;
end;

procedure TkmServer.PR_AfterUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind);
begin
 //
end;

procedure TkmServer.PR_BeforeUpdateRecord(Sender: TObject; SourceDS: TDataSet;
      DeltaDS: TCustomClientDataSet; UpdateKind: TUpdateKind; var Applied: Boolean);
var
  fUser, fModifyDateTime: TField;
  YY, MM, DD, HH, MN, SS, MS: word;
  i: integer;
begin
  with DeltaDS do begin
    fUser := FindField('C_USER_ID');
    fModifyDateTime := FindField('C_ACTIONDATETIME');

    Edit;
    try
      if fUser <> nil then fUser.AsString := FCurrentUser;
      if fModifyDateTime <> nil then begin
        DecodeDate(Now, YY, MM, DD);
        DecodeTime(Now, HH, MN, SS, MS);
        fModifyDateTime.AsDateTime := EncodeDate(YY, MM, DD) + EncodeTime(HH, MN, SS, 0);
      end;

      for i := 0 to FieldCount - 1 do begin
        //may be some other types should be included here... ftFloat, ftInteger etc...
        // da ne se dobavia ftMemo zashtoto trie stoinostta
        if (Fields[i].DataType in [ftString, ftWideString, ftFixedChar])
        and (not VarIsNull(Fields[i].Value)) and (Trim(Fields[i].AsString) = '') then
          Fields[i].Clear;
      end;

      Post;

    except
      on E: Exception do begin
        Cancel;
        SendNotifyClient('Грешка', E.Message);
        WriteToLog(E.Message, 'PR_BeforeUpdateRecord', '', '');
      end;
    end;
  end;
end;

procedure TkmServer.SendNotifyClient(Caption, Msg: String);
begin
  try
    FCallBack.NotifyClient(Caption , Msg);
  except
  end;
end;

function TkmServer.SetCommandText(Qry: TQuery; const CmdStr: String;
  SetOpen: Boolean): Integer;
var
  lc_strTmp: String;
begin
  Result := -1;
  try
    if Qry.Active then Qry.Close;

    Qry.SQL.Clear;
    Qry.SQL.Text := CmdStr;
    if SetOpen then begin
      Qry.Open;
      Qry.FetchAll;
      Qry.First;
    end
    else
      Qry.ExecSQL;

    Result := 0;
  except
    on E: EDBEngineError do begin
      lc_strTmp := E.Message;
      PassDBEngineError(E, CmdStr, lc_strTmp);
      SendNotifyClient('Грешка', 'Грешка при изпълнение на SQL заявка: '#13#10 + lc_strTmp);
      WriteToLog(E.Message, 'SetCommandText', 'Изпълнение на SQL заявка', '[SQL] : ' + CmdStr + #13#10'[Query] : ' + Qry.Name);
    end;
    on E: Exception do begin
      SendNotifyClient('Грешка', 'Грешка при изпълнение на SQL заявка: '#13#10 + E.Message);
      WriteToLog(E.Message, 'SetCommandText', 'Изпълнение на SQL заявка', '[SQL] : ' + CmdStr + #13#10'[Query] : ' + Qry.Name);
    end;
  end;
end;

function TkmServer.SetFieldValue(const TblName, TblID, FldName,
  FldValue: WideString; IsQuoted: Integer): Integer;
var
  CmdStr: String;
begin
  Result := -1;
  try
    with qrSetValue do begin
      SQL.Clear;
      if IsQuoted = 1 then
        CmdStr := 'UPDATE '+TblName+' SET '+FldName+' = "'+FldValue+'", C_USER_ID = "'+FCurrentUser+'", C_ACTIONDATETIME = "'+
            FormatDateTime('dd.mm.yyyy hh:nn:ss', Now)+'" WHERE ID = "'+TblID+'"'
      else
        CmdStr := 'UPDATE '+TblName+' SET '+FldName+' = '+FldValue+', C_USER_ID = "'+FCurrentUser+'", C_ACTIONDATETIME = "'+
            FormatDateTime('dd.mm.yyyy hh:nn:ss', Now)+'" WHERE ID = "'+TblID+'"';

      SQL.Text := CmdStr;

      ExecSQL;
      Close;

      Result := 0;
    end;
  except
    on E: Exception do begin
      WriteToLog(E.Message, 'SetFieldValue', '', '[SQL is] : ' + CmdStr);
      SendNotifyClient('Грешка ', 'Грешка в процедура SetFieldValue. ' + #13#10 + E.Message);
    end;
  end;
end;

function TkmServer.SetNextDocNo(TblID: Integer; const TblField,
  TblName: WideString; Digits: Integer): Integer;
var
  lcNextID: Longint;
begin
  Result := 0;
  try
    Result := SetCommandText(qrDocNo, 'SELECT * FROM NOM_DOCNUMBERS WHERE UPPER(TABLENAME) = "' + UpperCase(TblName) + '"', True);
    if Result <> 0 then SysUtils.Abort;

    if qrDocNo.RecordCount < 1 then begin
      SendNotifyClient( 'Грешка при задаване на номер на документа', 'Няма въведени граници за номер на документ в базата данни!' );
      SysUtils.Abort;
    end
    else if qrDocNo.RecordCount > 1 then begin
      SendNotifyClient( 'Грешка при задаване на номер на документа', 'Има въведени повече от една граница за номер на документ в базата данни!' );
      SysUtils.Abort;
    end;

    lcNextID := Round(qrDocNo.FieldByName('COUNTER').AsFloat ) + 1;
    Result := SetCommandText(qrDocNo, 'UPDATE ' + TblName + ' SET ' + TblField + ' = ''' + AlignRight(IntToStr(lcNextID), Digits, '0') + ''' WHERE ID = ' + IntToStr(TblID), False);
    if Result <> 0 then SysUtils.Abort;

    Result := SetCommandText(qrDocNo, 'UPDATE NOM_DOCNUMBERS SET COUNTER = COUNTER + 1 WHERE UPPER(TABLENAME) = "' + UpperCase(TblName) + '"', False);
    if Result <> 0 then SysUtils.Abort;
  except
    on E: EAbort do
      Result := -1;
    on E: Exception do begin
      Result := -1;
      WriteToLog(E.Message, 'SetNextDocNo', 'Задаване на номер на документ', '');
      SendNotifyClient( 'Грешка при задаване на номер на документа', 'Грешка при задаване на номер на документа.'#13#10 + E.Message);
    end;
  end;
end;

class procedure TkmServer.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TkmServer,
    Class_kmServer_, ciMultiInstance, tmSingle);
end.

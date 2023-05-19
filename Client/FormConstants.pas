unit FormConstants;

interface

uses Forms, SelectorUtilities, SysUtils, Messages, Mess;


const
  fc_Article                   = 601;
  fc_UserName                  = 602;
  fc_Mashine                   = 603;
  fc_Offers                    = 604;
  fc_Client                    = 605;
  fc_ClientSerial              = 606;
  fc_MakeOffers                = 607;
  fc_MashineSerial             = 608;

  sc_ArticlesSelect            = 1;
  sc_UserName                  = 2;
  sc_Mashine                   = 3;
  sc_Offers                    = 4;
  sc_Client                    = 5;
  sc_ClientSerial              = 6;
  sc_MakeOffers                = 7;
  sc_MashineSerial             = 8;
  sc_MashineClient             = 9;

function GetFormDetails(lcFormConstant: integer; lcFilterOption: TFilterOption;
  var lcFormClass: TFormClass;
  var srTableName: String; var lcFieldList: String;
  var lcFieldValues: OleVariant; var lcSQL_ID: integer;
  var SelectionListProc: TSelectionListOperationPtr;
  var lcExactMatch: boolean;
  IsDetail: Boolean = False): integer;

procedure BuildAdvFilter(lcFormConstant: integer; lcFilterOption: TFilterOption;
  var lcFieldList: String; var lcFieldValues: OleVariant; IsDetail : Boolean = False);
function GetPrintTemlatePath(lcFormConstant: Integer): String;
function GetPrintTemlatePathFull(lcFormConstant: Integer): String;
function GetFormSqlStatement(lcFormConstant: Integer): Integer;
function CanAddRestrictFilter(intFormConstant: Integer): Boolean;

var
  Hooker: OleVariant;
  BarCodeHookedCount: Integer;

implementation

uses
  Article, Client, Mashine;

function GetFormDetails(lcFormConstant: Integer; lcFilterOption: TFilterOption;
  var lcFormClass: TFormClass;
  var srTableName: String; var lcFieldList: String;
  var lcFieldValues: OleVariant; var lcSQL_ID: integer;
  var SelectionListProc: TSelectionListOperationPtr;
  var lcExactMatch: boolean;
  IsDetail: Boolean): integer;
begin
  case lcFormConstant of
    fc_Article:
      begin
        lcFormClass := TfArticle;
        srTableName := 'Article';
        lcSQL_ID := sc_ArticlesSelect;
        BuildAdvFilter(fc_Article, lcFilterOption, lcFieldList, lcFieldValues);
        lcExactMatch := False;
        Result := 0;
      end;

    fc_Client:
      begin
        lcFormClass := TfClient;
        srTableName := 'Client';
        lcSQL_ID := sc_Client;
        lcExactMatch := False;
        Result := 0;
      end;

    fc_Mashine:
      begin
        lcFormClass := TfMashine;
        srTableName := 'Mashine';
        lcSQL_ID := sc_Mashine;
        lcExactMatch := False;
        Result := 0;
      end;

    else Result := -1;
  end;
  (*TODO DRAGO
    fc_Article:
      begin
        lcFormClass  := TfArticle;
        srTableName  := 'Article';
        lcSQL_ID     := sc_Article;
        BuildAdvFilter(fc_Article, lcFilterOption, lcFieldList, lcFieldValues);
        lcExactMatch := False;
        if fo_InsertRecipe in lcFilterOption then SelectionListProc := InsertRecipe;
        Result       := 0;
      end;

    fc_ClientType:
      begin
        lcFormClass  := TfClientType;
        srTableName  := 'CLIENTTYPE';
        lcSQL_ID     := sc_ClientType;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ClientAgent:
      begin
        lcFormClass  := TfClientAgent;
        srTableName  := 'ClientAgent';
        lcSQL_ID     := sc_ClientAgent;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ArticlesSelectTot :
      begin
        lcFormClass := TfArticleSelect;
        srTableName := 'ArticleSelect';
        lcSQL_ID    := sc_ArticlesSelectTot;
        BuildAdvFilter(fc_ArticlesSelectTot, lcFilterOption, lcFieldList, lcFieldValues);
        lcExactMatch := False;
        if fo_InsertRecipe in lcFilterOption then SelectionListProc := InsertRecipe;
        Result       := 0;
      end;

    fc_SysBusinessGroup:
      begin
        lcFormClass  := TfSysBusinessGroup;
        srTableName  := 'SYS_BUSINESSGROUP';
        lcSQL_ID     := sc_SysBusinessGroup;
        lcExactMatch := True;
        Result       := 0;
      end;

    fc_Sale:
      begin
        lcFormClass  := TfSales;
        srTableName  := 'Sales';
        lcSQL_ID     := sc_Sale;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_BusinessGroup:
      begin
        lcFormClass  := TfBusinessGroup;
        srTableName  := 'BUSINESSGROUP';
        lcSQL_ID     := sc_BusinessGroup;
        lcExactMatch := True;
        Result       := 0;
      end;

    fc_Currency:
      begin
        lcFormClass  := TfCurrency;
        srTableName  := 'CURRENCY';
        lcSQL_ID     := sc_Currency;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Dimension:
      begin
        lcFormClass  := TfDimension;
        srTableName  := 'Dimension';
        lcSQL_ID     := sc_Dimension;
        lcExactMatch := True;
        Result       := 0;
      end;

    fc_Country:
      begin
        lcFormClass  := TfCountry;
        srTableName  := 'COUNTRY';
        lcSQL_ID     := sc_Country;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ExpenseType:
      begin
        lcFormClass  := TfExpenseType;
        srTableName  := 'EXPENSETYPE';
        lcSQL_ID     := sc_ExpenseType;
        lcExactMatch := False;
        Result       := 0;
       end;

    fc_CashDeskType:
      begin
        lcFormClass  := TfCashDeskType;
        srTableName  := 'CASHDESKTYPE';
        lcSQL_ID     := sc_CashDeskType;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_User:
      begin
        lcFormClass  := TfUser;
        srTableName  := 'USERNAME';
        lcSQL_ID     := sc_UserName;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Supplier:
      begin
        lcFormClass  := TfSupplier;
        srTableName  := 'SUPPLIER';
        lcSQL_ID     := sc_Supplier;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Order:
      begin
        lcFormClass  := TfOrder;
        srTableName  := 'ORDERTBL';
        lcSQL_ID     := sc_Order;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ArticlesSelectFromArticle :
      begin
        lcFormClass  := TfArticleSelect;
        srTableName  := 'ArticleSelect';
        lcSQL_ID     := sc_ArticlesSelectFromArticle;
        BuildAdvFilter(fc_ArticlesSelectFromArticle, lcFilterOption, lcFieldList, lcFieldValues);
        lcExactMatch := False;
        if fo_InsertRecipe in lcFilterOption then SelectionListProc := InsertRecipe;
        Result       := 0;
      end;

    fc_StyledText:
      begin
        lcFormClass  := TfStyledText;
        srTableName  := 'STYLEDTEXT';
        lcSQL_ID     := sc_StyledText;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Delivery:
      begin
        lcFormClass  := TfDelivery;
        srTableName  := 'DELIVERY';
        lcSQL_ID     := sc_Delivery;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Revision:
      begin
        lcFormClass  := TfRevision;
        srTableName  := 'REVISION';
        lcSQL_ID     := sc_Revision;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ArticleGroup:
      begin
        lcFormClass  := TfArticleGroup;
        srTableName  := 'ARTICLEGROUP';
        lcSQL_ID     := sc_ArticleGroup;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_CompoundGroup:
      begin
        lcFormClass  := TfCompoundGroup;
        srTableName  := 'COMPOUNDGROUP';
        lcSQL_ID     := sc_CompoundGroup;
        lcExactMatch := False;
        Result       := 0;
      end;

    {fc_RepGroupSelect:
      begin
        lcFormClass  := TfRepGroupSelect;
        srTableName  := 'ArticleSelect';
        lcSQL_ID     := sc_ArticlesSelect;
        lcExactMatch := True;
        Result       := 0;
      end;}

    fc_Department:
      begin
        lcFormClass  := TfDepartment;
        srTableName  := 'DEPARTMENT';
        lcSQL_ID     := sc_Department;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_UserGroup:
      begin
        lcFormClass  := TfUserGroup;
        srTableName  := 'USERGROUP';
        lcSQL_ID     := sc_UserGroup;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_VATGroup:
      begin
        lcFormClass  := TfVATGroup;
        srTableName  := 'VATGROUP';
        lcSQL_ID     := sc_VATGroup;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Warranty:
      begin
        lcFormClass  := TfWarranty;
        srTableName  := 'WARRANTY';
        lcSQL_ID     := sc_Warranty;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_RepairCard:
      begin
        lcFormClass  := TfRepairCard;
        srTableName  := 'REPAIRCARD';
        lcSQL_ID     := sc_RepairCard;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Make:
      begin
        lcFormClass  := TfMake;
        srTableName  := 'MAKE';
        lcSQL_ID     := sc_Make;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ClientTypeReduction:
      begin
        lcFormClass  := TfClientTypeReduction;
        srTableName  := 'CLIENTTYPEREDUCTION';
        lcSQL_ID     := sc_ClientTypeReduction;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Protocol:
      begin
        lcFormClass  := TfProtocoli;
        srTableName  := 'PROTOCOL';
        lcSQL_ID     := sc_Protocol;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Invoice:
      begin
        lcFormClass  := TfInvoice;
        srTableName  := 'INVOICE';
        lcSQL_ID     := sc_Invoice;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_CompoundArticles:
      begin
        lcFormClass  := TfCompoundArticles;
        srTableName  := 'CompoundArticles';
        lcSQL_ID     := sc_CompoundArticle;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ArticleGroupReduction:
      begin
        lcFormClass  := TfArticleGroupReduction;
        srTableName  := 'ArticleGroupReduction';
        lcSQL_ID     := sc_ArticleGroupReduction;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Request:
      begin
        lcFormClass  := TfRequest;
        srTableName  := 'Request';
        lcSQL_ID     := sc_Request;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_BlockStoreQuantity:
      begin
        lcFormClass  := TfBlockStoreQuantity;
        srTableName  := 'BlockStoreQuantity';
        lcSQL_ID     := sc_BlockStoreQuantity;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ClientReduction:
      begin
        lcFormClass  := TfClientReduction;
        srTableName  := 'ClientReduction';
        lcSQL_ID     := sc_ClientReduction;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Payment:
      begin
        lcFormClass  := TfPayment;
        srTableName  := 'Payment';
        lcSQL_ID     := sc_Payment;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_CashDesk:
      begin
        lcFormClass  := TfCashDesk;
        srTableName  := 'CashDesk';
        lcSQL_ID     := sc_CashDesk;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Expense:
      begin
        lcFormClass  := TfExpense;
        srTableName  := 'Expense';
        lcSQL_ID     := sc_Expense;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_GLPayment:
      begin
        lcFormClass  := TfGLPayment;
        srTableName  := 'GLPayment';
        lcSQL_ID     := sc_GLPayment;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_PreBlockStoreQuantity:
      begin
        lcFormClass  := TfPreBlockStoreQuantity;
        srTableName  := 'PreBlockStoreQuantity';
        lcSQL_ID     := sc_PreBlockStoreQuantity;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_Credits:
      begin
        lcFormClass  := TfCredits;
        srTableName  := 'Credits';
        lcSQL_ID     := sc_Credits;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_CreditsNew:
      begin
        lcFormClass  := TfCreditsNew;
        srTableName  := 'Credits';
        lcSQL_ID     := sc_Credits;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ReusableArticle:
      begin
        lcFormClass  := TfReusableArticle;
        srTableName  := 'ReusableArticle';
        lcSQL_ID     := sc_ReusableArticle;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ClientPrice:
      begin
        lcFormClass  := TfClientPrice;
        srTableName  := 'ClientPrice';
        lcSQL_ID     := sc_ClientPrice;
        lcExactMatch := False;
        Result       := 0;
      end;

    fc_ArticlegroupBySupplier:
      begin
        lcFormClass  := TfArticlegroupBySupplier;
        srTableName  := 'ArticlegroupBySupplier';
        lcSQL_ID     := sc_ArticlegroupBySupplier;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_PriceGroup:
      begin
        lcFormClass  := TfPriceGroup;
        srTableName  := 'PRICEGROUP';
        lcSQL_ID     := sc_PriceGroup;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_MitaList:
      begin
        lcFormClass  := TfMitaList;
        srTableName  := 'MITALIST';
        lcSQL_ID     := sc_MitaList;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_Duties:
      begin
        lcFormClass  := TfDuties;
        srTableName  := 'DUTIES';
        lcSQL_ID     := sc_Duties;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_ClientActivities:
      begin
        lcFormClass  := TfClientActivities;
        srTableName  := 'CLIENT_ACTIVITIES';
        lcSQL_ID     := sc_ClientActivities;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_City:
      begin
        lcFormClass  := TfCity;
        srTableName  := 'CITY';
        lcSQL_ID     := sc_City;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_ClientPriceGroup:
      begin
        lcFormClass  := TfClientPriceGroup;
        srTableName  := 'CLIENTPRICEGROUP';
        lcSQL_ID     := sc_ClientPriceGroup;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_Producer:
      begin
        lcFormClass  := TfProducer;
        srTableName  := 'PRODUCER';
        lcSQL_ID     := sc_Producer;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_Deport:
      begin
        lcFormClass  := TfDeport;
        srTableName  := 'DEPORT';
        lcSQL_ID     := sc_Deport;
        lcExactMatch := False;
        Result       := 0;
      end;
    fc_BonusBay:
      begin
        lcFormClass  := TfBonusBay;
        srTableName  := 'BONUSBAY';
        lcSQL_ID     := sc_BonusBay;
        lcExactMatch := False;
        Result       := 0;
      end;
    else Result := -1;
  end;//case*)
end;

procedure BuildAdvFilter(lcFormConstant: integer;lcFilterOption: TFilterOption;
          var lcFieldList: String; var lcFieldValues: OleVariant; IsDetail: Boolean);
begin
  (*TODO DRAGO
  case lcFormConstant of
    fc_ArticlesSelect :
      begin
        if fo_PresentLotsOnly in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';STORE.AVAILABLE';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 1;
        end;
        if fo_BGPresentOnly in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';STORE.BUSINESSGROUP_ID';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := DM.ServerData.AppServer.GetDefaultBG;
        end;
        if fo_NoCompoundArticles in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';ARTICLE.COMPOUND';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 0;
        end;
      end;

    fc_Article:
      begin
        if fo_CompoundArticlesOnly in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';' + 'ARTICLE.COMPOUND';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 1;
        end;
        if fo_NoCompoundArticles in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';ARTICLE.COMPOUND';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 0;
        end;
      end;

    fc_ArticlesSelectTot :
      begin
        if fo_PresentLotsOnly in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';' + 'STORE.AVAILABLE';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 1;
        end;
        if fo_NoCompoundArticles in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';ARTICLE.COMPOUND';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 0;
        end;
      end;

    fc_ArticlesSelectFromArticle :
      begin
        if fo_ReusableArticles in lcFilterOption
        then begin

        end;
        if fo_CompoundArticlesOnly in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';' + 'ARTICLE.COMPOUND';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 1;
        end;
        if fo_NoCompoundArticles in lcFilterOption then
        begin
          lcFieldList := lcFieldList + ';ARTICLE.COMPOUND';
          VarArrayRedim(lcFieldValues, VarArrayHighBound(lcFieldValues, 1) + 1);
          lcFieldValues[VarArrayHighBound(lcFieldValues, 1)] := 0;
        end;
      end;

    fc_RepGroupSelect :
      begin
        if fo_SelectNone in lcFilterOption
        then begin
          lcFieldList := lcFieldList + ';1';
          VarArrayRedim( lcFieldValues, VarArrayHighBound( lcFieldValues, 1 ) + 1 );
          lcFieldValues[VarArrayHighBound( lcFieldValues, 1 )] := 2;
        end;
      end;
    fc_Request:
      begin
        if IsDetail then
        begin
          lcFieldList := 'REQUEST_ID';
        end;
      end;
  end; //case*)
end;

function GetPrintTemlatePath(lcFormConstant: Integer): String;
begin
  (*TODO DrAGO
  case lcFormConstant of
    fc_BusinessGroup            : Result := 'BusinessGroup\';
    fc_CurrencyRate             : Result := 'CurrencyRate\';
    fc_User                     : Result := 'User\';
    fc_Article                  : Result := 'Article\';
    fc_ArticleGroup             : Result := 'ArticleGroup\';
    fc_CompoundArticles         : Result := 'CompoundArticle\';
    fc_Client                   : Result := 'Client\';
    fc_ClientAgent              : Result := 'ClientAgent\';
    fc_Supplier                 : Result := 'Supplier\';
    fc_ArticleGroupReduction    : Result := 'ArticleGroupReduction\';
    fc_Department               : Result := 'Department\';
    fc_PriceList                : Result := 'PriceList\';
    fc_Order                    : Result := 'Order\';
    fc_Request                  : Result := 'Request\';
    fc_Delivery                 : Result := 'Delivery\';
    fc_Sale                     : Result := 'Sale\';
    fc_Protocol                 : Result := 'Protocol\';
    fc_Warranty                 : Result := 'Warranty\';
    fc_SysBusinessGroup         : Result := 'SysBusinessGroup\';
    fc_BlockStoreQuantity       : Result := 'BlockStoreQuantity\';
    fc_Currency                 : Result := 'Currency\';
    fc_Dimension                : Result := 'Dimension\';
    fc_Country                  : Result := 'Country\';
    fc_UserGroup                : Result := 'UserGroup\';
    fc_StoreInfo                : Result := 'StoreInfo\';
    fc_ClientType               : Result := 'ClientType\';
    fc_ClientReduction          : Result := 'ClientReduction\';
    fc_ExpenseType              : Result := 'ExpenseType\';
    fc_Payment                  : Result := 'Payment\';
    fc_Invoice                  : Result := 'Invoice\';
    fc_CashDesk                 : Result := 'CashDesk\';
    fc_Revision                 : Result := 'Revision\';
    fc_Expense                  : Result := 'Expense\';
    fc_CashDeskType             : Result := 'CashDeskType\';
    fc_GLPayment                : Result := 'GLPayment\';
    fc_PreBlockStoreQuantity    : Result := 'PreBlockStoreQuantity\';
    fc_Credits                  : Result := 'Credits\';
    fc_StyledText               : Result := 'StyledText\';
    fc_LeasingPlans             : Result := 'LeasingPlans\';
    fc_CompoundGroup            : Result := 'CompoundGroup\';
    fc_ArticlegroupBySupplier   : Result := 'ArticleGroupBySupplier\';
    fc_RepairCard               : Result := 'RepairCard\';
    fc_PriceGroup               : Result := 'PriceGroup\';
    fc_MitaList                 : Result := 'MitaList\';
    fc_Duties                   : Result := 'Duties\';
    fc_ClientActivities         : Result := 'ClientActivities\';
    fc_City                     : Result := 'City\';
    fc_ClientPriceGroup         : Result := 'ClientPriceGroup\';
    fc_CustomsDocument          : Result := 'CustomsDocument\';
    fc_Producer                 : Result := 'Producer\';
    fc_Deport                   : Result := 'Deport\';
    fc_BonusBay                 : Result := 'BonusBay\';
    else Result := '';
  end;//case*)
end;

function GetPrintTemlatePathFull(lcFormConstant: Integer): String;
begin
  Result := GetPrintTemlatePath(lcFormConstant);
  if Result <> '' then
    Result := ExtractFilePath(Application.ExeName)+'PrintForms\'+Result;
end;

function GetFormSqlStatement(lcFormConstant: Integer): Integer;
begin
  case lcFormConstant of
    fc_Article: Result := sc_ArticlesSelect;
    fc_Client: Result := sc_Client;
    fc_UserName: Result := sc_UserName;
    fc_Mashine: Result := sc_Mashine;
    fc_Offers: Result := sc_Offers;
    fc_MashineSerial: Result := sc_MashineSerial;
    else Result := -1;
  end;//case
end;

function  CanAddRestrictFilter(intFormConstant: Integer): Boolean;
begin
  Result := False;
  (*TODO DRAGO
  case intFormConstant of
    sc_Sale,
    sc_Request,
    sc_Order,
    sc_Transfer,
    sc_Delivery,
    sc_Protocol,
    sc_Payment,
    sc_Invoice,
    sc_CashDesk,
    sc_Warranty,
    sc_Revision,
    sc_Expense,
    sc_BlockStoreQuantity,
    sc_ClientAccounts,
    sc_GLPayment,
    sc_PreBlockStoreQuantity,
    sc_Credits,
    sc_Tasks,
    sc_TransactionLog,
    sc_ClientPrice,
    sc_RepairCard,
    sc_Make :
      Result := True;
    else
      Result := False;
  end;*)
end;

end.

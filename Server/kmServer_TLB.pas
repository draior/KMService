unit kmServer_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 41960 $
// File generated on 02.02.2014 17:25:18 from Type Library described below.

// ************************************************************************  //
// Type Lib: T:\KMService\Server\kmServer (1)
// LIBID: {B9DDAC28-AC87-4D42-BA75-28D66B4BB451}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v1.0 Midas, (midas.dll)
//   (3) v4.0 StdVCL, (STDVCL40.DLL)
// Errors:
//   Hint: TypeInfo 'kmServer' changed to 'kmServer_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, ActiveX, Classes, Graphics, Midas, OleServer, StdVCL, Variants;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  kmServerMajorVersion = 1;
  kmServerMinorVersion = 0;

  LIBID_kmServer: TGUID = '{B9DDAC28-AC87-4D42-BA75-28D66B4BB451}';

  IID_IkmServer: TGUID = '{CAAA5579-0DD8-4589-8A29-41CC40B3F5D2}';
  CLASS_kmServer_: TGUID = '{F0BBD428-77AA-4940-9B09-76499C399BD4}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IkmServer = interface;
  IkmServerDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  kmServer_ = IkmServer;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}
  PWideString1 = ^WideString; {*}


// *********************************************************************//
// Interface: IkmServer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CAAA5579-0DD8-4589-8A29-41CC40B3F5D2}
// *********************************************************************//
  IkmServer = interface(IAppServer)
    ['{CAAA5579-0DD8-4589-8A29-41CC40B3F5D2}']
    function LoginInterface(IClient: OleVariant): Integer; safecall;
    function LogIn(const UName: WideString; const Pass: WideString; out Params: OleVariant): Integer; safecall;
    procedure BeginTrans; safecall;
    procedure CommitTrans; safecall;
    procedure RollbackTrans; safecall;
    function AddToTransLog(Date: OleVariant; const Operation: WideString;
                           const OperationResult: WideString; const Description: WideString): Integer; safecall;
    function CloseAllQueries: Integer; safecall;
    function CanEnterEditMode(const TblName: WideString; const TblID: WideString): Integer; safecall;
    function GetFilter(const ProviderName: WideString): WideString; safecall;
    procedure RequestDoc(const TblName: WideString; const Cond: WideString; const Ord: WideString;
                         Actv: Shortint); safecall;
    procedure CloseQuery(const TblName: WideString); safecall;
    function LastGenID(const ProvName: WideString): WideString; safecall;
    procedure DeleteRecord(const TblName: WideString; const ID: WideString); safecall;
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
  end;

// *********************************************************************//
// DispIntf:  IkmServerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {CAAA5579-0DD8-4589-8A29-41CC40B3F5D2}
// *********************************************************************//
  IkmServerDisp = dispinterface
    ['{CAAA5579-0DD8-4589-8A29-41CC40B3F5D2}']
    function LoginInterface(IClient: OleVariant): Integer; dispid 301;
    function LogIn(const UName: WideString; const Pass: WideString; out Params: OleVariant): Integer; dispid 302;
    procedure BeginTrans; dispid 303;
    procedure CommitTrans; dispid 304;
    procedure RollbackTrans; dispid 305;
    function AddToTransLog(Date: OleVariant; const Operation: WideString;
                           const OperationResult: WideString; const Description: WideString): Integer; dispid 306;
    function CloseAllQueries: Integer; dispid 307;
    function CanEnterEditMode(const TblName: WideString; const TblID: WideString): Integer; dispid 308;
    function GetFilter(const ProviderName: WideString): WideString; dispid 309;
    procedure RequestDoc(const TblName: WideString; const Cond: WideString; const Ord: WideString;
                         Actv: Shortint); dispid 310;
    procedure CloseQuery(const TblName: WideString); dispid 311;
    function LastGenID(const ProvName: WideString): WideString; dispid 312;
    procedure DeleteRecord(const TblName: WideString; const ID: WideString); dispid 313;
    function GetValueEx(SqlID: Integer; const SearchFields: WideString; SearchValues: OleVariant;
                        const ReturnFields: WideString; out ReturnValues: OleVariant;
                        ExactMatch: WordBool): Integer; dispid 314;
    function GetSQLStatement(SqlID: Integer): WideString; dispid 315;
    function RequestDocEx(const TblName: WideString; SqlID: Integer; const SqlStr: OleVariant;
                          Actv: WordBool): Integer; dispid 316;
    function GetNextID(const TblName: WideString): OleVariant; dispid 317;
    function MakeOffer(MashSerialID: Integer; OHour: Integer; out ID: Integer): Integer; dispid 318;
    function FilterDocuments(const TblName: WideString; SqlID: Integer; const SqlStr: OleVariant;
                             var OutSql: WideString): Integer; dispid 319;
    function GetValue(const TblName: WideString; const SearchField: WideString;
                      const SearchValue: WideString; const ResultField: WideString): OleVariant; dispid 320;
    function CheckMashineSerial(MashID: Integer; const SerNo: WideString; out Range: WideString): Integer; dispid 321;
    function SetFieldValue(const TblName: WideString; const TblID: WideString;
                           const FldName: WideString; const FldValue: WideString; IsQuoted: Integer): Integer; dispid 322;
    function SetNextDocNo(TblID: Integer; const TblField: WideString; const TblName: WideString;
                          Digits: Integer): Integer; dispid 323;
    function AS_ApplyUpdates(const ProviderName: WideString; Delta: OleVariant; MaxErrors: Integer;
                             out ErrorCount: Integer; var OwnerData: OleVariant): OleVariant; dispid 20000000;
    function AS_GetRecords(const ProviderName: WideString; Count: Integer; out RecsOut: Integer;
                           Options: Integer; const CommandText: WideString; var Params: OleVariant;
                           var OwnerData: OleVariant): OleVariant; dispid 20000001;
    function AS_DataRequest(const ProviderName: WideString; Data: OleVariant): OleVariant; dispid 20000002;
    function AS_GetProviderNames: OleVariant; dispid 20000003;
    function AS_GetParams(const ProviderName: WideString; var OwnerData: OleVariant): OleVariant; dispid 20000004;
    function AS_RowRequest(const ProviderName: WideString; Row: OleVariant; RequestType: Integer;
                           var OwnerData: OleVariant): OleVariant; dispid 20000005;
    procedure AS_Execute(const ProviderName: WideString; const CommandText: WideString;
                         var Params: OleVariant; var OwnerData: OleVariant); dispid 20000006;
  end;

// *********************************************************************//
// The Class CokmServer_ provides a Create and CreateRemote method to
// create instances of the default interface IkmServer exposed by
// the CoClass kmServer_. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CokmServer_ = class
    class function Create: IkmServer;
    class function CreateRemote(const MachineName: string): IkmServer;
  end;

implementation

uses ComObj;

class function CokmServer_.Create: IkmServer;
begin
  Result := CreateComObject(CLASS_kmServer_) as IkmServer;
end;

class function CokmServer_.CreateRemote(const MachineName: string): IkmServer;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_kmServer_) as IkmServer;
end;

end.


unit kmClient_TLB;

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
// File generated on 23.09.2013 21:45:01 from Type Library described below.

// ************************************************************************  //
// Type Lib: T:\KMService\Client\kmClient (1)
// LIBID: {A92A05AA-4A57-4BD4-9328-9332306ADE8B}
// LCID: 0
// Helpfile:
// HelpString: Client Library
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
//   (2) v4.0 StdVCL, (STDVCL40.DLL)
// Errors:
//   Hint: TypeInfo 'kmClient' changed to 'kmClient_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  kmClientMajorVersion = 1;
  kmClientMinorVersion = 0;

  LIBID_kmClient: TGUID = '{A92A05AA-4A57-4BD4-9328-9332306ADE8B}';

  IID_IkmClient: TGUID = '{61FA096F-999E-4963-AAC7-3D7E798ED12B}';
  CLASS_kmClient_: TGUID = '{A4CD62F4-BE3C-4F17-8AFF-086D1C98B0EA}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IkmClient = interface;
  IkmClientDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  kmClient_ = IkmClient;


// *********************************************************************//
// Interface: IkmClient
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {61FA096F-999E-4963-AAC7-3D7E798ED12B}
// *********************************************************************//
  IkmClient = interface(IDispatch)
    ['{61FA096F-999E-4963-AAC7-3D7E798ED12B}']
    procedure NotifyClient(const Title: WideString; const Msg: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IkmClientDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {61FA096F-999E-4963-AAC7-3D7E798ED12B}
// *********************************************************************//
  IkmClientDisp = dispinterface
    ['{61FA096F-999E-4963-AAC7-3D7E798ED12B}']
    procedure NotifyClient(const Title: WideString; const Msg: WideString); dispid 201;
  end;

// *********************************************************************//
// The Class CokmClient_ provides a Create and CreateRemote method to
// create instances of the default interface IkmClient exposed by
// the CoClass kmClient_. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CokmClient_ = class
    class function Create: IkmClient;
    class function CreateRemote(const MachineName: string): IkmClient;
  end;

implementation

uses ComObj;

class function CokmClient_.Create: IkmClient;
begin
  Result := CreateComObject(CLASS_kmClient_) as IkmClient;
end;

class function CokmClient_.CreateRemote(const MachineName: string): IkmClient;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_kmClient_) as IkmClient;
end;

end.


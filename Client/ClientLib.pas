unit ClientLib;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, kmClient_TLB, NotifyClient, Progress,
  Windows, SysUtils;

type
  TkmClient = class(TAutoObject, IkmClient)
  protected
    FProgressForm: TfProgress;
    procedure NotifyClient(const Title, Msg: WideString); safecall;
  end;

implementation

uses ComServ, ULogUtils;

{ TkmClient }

procedure TkmClient.NotifyClient(const Title, Msg: WideString);
begin
  try
    fNotifyClient.Title := Title;
    fNotifyClient.Msg := Msg;
    fNotifyClient.CallParam := 0; //0 - simple message
    fNotifyClient.mMessage.Lines.Add(Msg);

    PostMessage(fNotifyClient.Handle, WM_BENotify, 0, 0);
  except
    on E: Exception do
      WriteToLog(E.Message, 'kmClient.NotifyClient', '', '');
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TkmClient, Class_kmClient_,
    ciInternal, tmSingle);
end.

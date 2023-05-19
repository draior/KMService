unit NotifyClient;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Variants, XPMenu;

const WM_BENotify     = WM_APP + $100;

type
  TfNotifyClient = class(TForm)
    Panel1: TPanel;
    mMessage: TMemo;
    Panel2: TPanel;
    btnOk: TBitBtn;
    pDocumentName: TPanel;
    btnClear: TBitBtn;
    btnSave: TBitBtn;
    SaveDlg: TSaveDialog;
    XPMenu: TXPMenu;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure WMBENotify(var Message: TMessage); message WM_BENotify;
  public
    Title : string;
    Msg : string;
    MsgEx : OleVariant;
    CallParam : integer;
  end;

var
  fNotifyClient: TfNotifyClient;

implementation

uses ULogUtils;

{$R *.DFM}

procedure TfNotifyClient.btnOkClick(Sender: TObject);
begin
  try
    Close;
  except
    on E: Exception do WriteToLog(E.Message, 'NotifyClient.btnOkClick', '', '');
  end;
end;

procedure TfNotifyClient.WMBENotify(var Message: TMessage);
begin
  try
    case CallParam of
      1 : begin
            mMessage.Lines.Add(VarToStr(MsgEx[0]));
            mMessage.Lines.Add(VarToStr(MsgEx[1]));
            mMessage.Lines.Add(VarToStr(MsgEx[2]));
            mMessage.Lines.Add(VarToStr(MsgEx[3]));
          end;
      else ;//mMessage.Lines.Add(Msg);
    end;
    pDocumentName.Caption := ' ' + Title;
    if not Visible then ShowModal;
  except
    on E: Exception do WriteToLog(E.Message, 'NotifyClient.WMBENotify', '', '');
  end;
end;

procedure TfNotifyClient.FormShow(Sender: TObject);
begin
  try
    BtnOK.SetFocus;
  except
    on E: Exception do WriteToLog(E.Message, 'NotifyClient.FormShow', '', '');
  end;
end;

procedure TfNotifyClient.btnClearClick(Sender: TObject);
begin
  try
    mMessage.Lines.Clear;
  except
    on E: Exception do WriteToLog(E.Message, 'NotifyClient.btnClearClick', '', '');
  end;
end;

procedure TfNotifyClient.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    mMessage.Lines.Clear;
  except
    on E: Exception do WriteToLog(E.Message, 'NotifyClient.FormClose', '', '');
  end;
end;

procedure TfNotifyClient.btnSaveClick(Sender: TObject);
begin
  try
    if SaveDlg.Execute then
      mMessage.Lines.SaveToFile(SaveDlg.FileName);
  except
    on E: Exception do WriteToLog(E.Message, 'NotifyClient.btnSaveClick', '', '');
  end;
end;

procedure TfNotifyClient.FormCreate(Sender: TObject);
begin
  //TODO DRAGO Self.Caption := sys_ClientVersion;
end;

end.

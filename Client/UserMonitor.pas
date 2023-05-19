unit UserMonitor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Buttons, ExtCtrls, ActnList, Variants, XPMenu;

type
  TfUserMonitor = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    lvUsers: TListView;
    BitBtn2: TBitBtn;
    alUserMonitor: TActionList;
    acNotifyClient: TAction;
    BitBtn3: TBitBtn;
    acRefreshList: TAction;
    XPMenu: TXPMenu;
    procedure BitBtn2Click(Sender: TObject);
    procedure acNotifyClientUpdate(Sender: TObject);
    procedure acNotifyClientExecute(Sender: TObject);
    procedure acRefreshListExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    UserList: OleVariant;
    procedure ShowUserMonitor;
    procedure LoadUserList;
  end;

var
  fUserMonitor: TfUserMonitor;

implementation

uses DataModule, ULogUtils, Mess;

{$R *.DFM}

{ TfUserMonitor }

procedure TfUserMonitor.ShowUserMonitor;
begin
  try
    LoadUserList;
    ShowModal;
  except
    on E: Exception do WriteToLog(E.Message, 'UserMonitor.ShowUserMonitor', '', '');
  end;
end;

procedure TfUserMonitor.BitBtn2Click(Sender: TObject);
begin
  try
    Close;
  except
    on E: Exception do WriteToLog(E.Message, 'UserMonitor.BitBtn2Click', '', '');
  end;
end;

procedure TfUserMonitor.acNotifyClientUpdate(Sender: TObject);
begin
  try
    acNotifyClient.Enabled := lvUsers.SelCount > 0;
  except
    on E: Exception do WriteToLog(E.Message, 'UserMonitor.acNotifyClientUpdate', '', '');
  end;
end;

procedure TfUserMonitor.acNotifyClientExecute(Sender: TObject);
var lc_Msg: string;
begin
  try
    if InputQuery('Изпращане на съобщение', 'Въведете кратък текст:', lc_Msg) then
      DM.ServerData.AppServer.NotifyRemoteClient(StrToInt(lvUsers.Selected.Caption), DM.CurrentUserName, lc_Msg);
  except
    on E: Exception do WriteToLog(E.Message, 'UserMonitor.acNotifyClientExecute', '', '');
  end;
end;

procedure TfUserMonitor.LoadUserList;
var i: integer;
    li: TListItem;
begin
  try
    UserList := DM.ServerData.AppServer.ListUsers;
    lvUsers.Items.Clear;
    for i := 0 to VarArrayHighBound(UserList, 1) do
    begin
      li := lvUsers.Items.Add;
      li.Caption := UserList[i][0];
      li.SubItems.Add(UserList[i][1]);
      li.SubItems.Add(UserList[i][2]);
    end;
  except
    on E: Exception do WriteToLog(E.Message, 'UserMonitor.LoadUserList', '', '');
  end;
end;

procedure TfUserMonitor.acRefreshListExecute(Sender: TObject);
begin
  try
    LoadUserList;
  except
    on E: Exception do WriteToLog(E.Message, 'UserMonitor.acRefreshListExecute', '', '');
  end;
end;

procedure TfUserMonitor.FormCreate(Sender: TObject);
begin
  //TODO DAGO Caption := sys_ClientVersion;
end;

end.

unit UserMonitor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, Buttons, ActnList, Variants;

type
  TfUserMonitor = class(TForm)
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Panel1: TPanel;
    lvUsers: TListView;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    alUserMonitor: TActionList;
    acNotifyClient: TAction;
    acClientDisconnect: TAction;
    procedure FormCreate(Sender: TObject);
    procedure acNotifyClientExecute(Sender: TObject);
    procedure acClientDisconnectExecute(Sender: TObject);
    procedure acNotifyClientUpdate(Sender: TObject);
  private
    FID: Integer;
    prUserCount: Integer;
    prCanLogOn: Boolean;
  public
    prIntfArray: array of OleVariant;
    procedure AddUser(UserName: string;
       LoginDateTime: TDateTime; ID: Integer);
    procedure RemoveUser(ID: integer);
    procedure RemoveAllUsers;
    procedure RemoveFromIntfArray(var ID: Integer);
    procedure DenyLogOn;
    procedure AllowLogOn;
    procedure NotifyAllUsers(Msg: String);
    function AddToIntfArray(FCallBack: OleVariant): Integer;
    function GetUserCount: Integer;
    function CanLogOn: Boolean;
  end;

var fUserMonitor: TfUserMonitor;

implementation

{$R *.DFM}

{ TfUserMonitor }

procedure TfUserMonitor.AddUser(UserName: string;
  LoginDateTime: TDateTime; ID: Integer);
var
  li: TListItem;
begin
  li := lvUsers.Items.Add;
  li.Caption := IntToStr(ID);
  li.SubItems.Add(UserName);
  li.SubItems.Add(DateTimeToStr(LoginDateTime));
  lvUsers.Refresh;
//  SetLength(prIntfArray, FID + 1);
//  prIntfArray[FID] := FCallBack;
//  Result := AddToIntfArray( FCallBack );//FID;
//  inc(FID);
end;

function TfUserMonitor.AddToIntfArray(FCallBack: OleVariant): Integer;
begin
  Inc(prUserCount);
  SetLength(prIntfArray, FID + 1);
  prIntfArray[FID] := FCallBack;
  Result := FID;
  inc(FID);
end;

procedure TfUserMonitor.RemoveFromIntfArray(var ID: Integer);
begin
  prIntfArray[ID] := null;
  Dec(prUserCount);
  ID := -1;
end;

procedure TfUserMonitor.RemoveUser(ID: integer);
var
  i, dID: integer;
begin
  if Assigned(lvUsers) then begin
    dID := -1;
    for i := 0 to lvUsers.Items.Count - 1 do
      if StrToInt(lvUsers.Items[i].Caption) = ID then dID := i;

    if dID > -1 then lvUsers.Items[dID].Delete;

    RemoveFromIntfArray( ID );
  end;
end;

procedure TfUserMonitor.FormCreate(Sender: TObject);
begin
  //TODO DRAGO Self.Caption := sys_ServerVersion;
  FID := 0;
  SetLength(prIntfArray, 0);
  prCanLogOn := True;
  prUserCount := 0;
end;

procedure TfUserMonitor.acNotifyClientExecute(Sender: TObject);
var lcMsg: string;
begin
  if InputQuery('Изпращане на съобщение', 'Въведете съобщение:', lcMsg) then
    prIntfArray[StrToInt(lvUsers.Selected.Caption)].NotifyClient('KM Server', lcMsg);
end;

procedure TfUserMonitor.acClientDisconnectExecute(Sender: TObject);
begin
  prIntfArray[StrToInt(lvUsers.Selected.Caption)].Disconnect;
end;

procedure TfUserMonitor.acNotifyClientUpdate(Sender: TObject);
begin
  acNotifyClient.Enabled := lvUsers.SelCount > 0;
  acClientDisconnect.Enabled := lvUsers.SelCount > 0;
end;

procedure TfUserMonitor.RemoveAllUsers;
var
  i: Integer;
  lcReady: Boolean;
begin
  //***************** Disconnecting all connected users ********************//
  if High( prIntfArray ) > -1 then
    for i := 0 to High( prIntfArray ) do
      if not VarIsNull( prIntfArray[i] ) then prIntfArray[i].Disconnect;

  //********* Waiting while all connected users are disconnected ***********//
  lcReady := FALSE;

  if High( prIntfArray ) > -1 then
    while not lcReady do begin
      lcReady := TRUE;
      for i := 0 to High( prIntfArray ) do
        if not VarIsNull( prIntfArray[i] ) then lcReady := FALSE;
      Application.ProcessMessages;
    end;
end;

function TfUserMonitor.GetUserCount: Integer;
begin
  Result := prUserCount;
end;

function TfUserMonitor.CanLogOn: Boolean;
begin
  Result := prCanLogOn;
end;

procedure TfUserMonitor.DenyLogOn;
begin
  prCanLogOn := FALSE;
end;

procedure TfUserMonitor.AllowLogOn;
begin
  prCanLogOn := TRUE;
end;

procedure TfUserMonitor.NotifyAllUsers(Msg: String);
var
  i: integer;
begin
  if High( prIntfArray ) > -1 then
    for i := 0 to High( prIntfArray ) do
      if not VarIsNull( prIntfArray[i] ) then
        prIntfArray[i].NotifyClient('KAMI SL Server', Msg);
end;

end.




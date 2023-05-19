unit PasswordEnter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Db, Variants, XPMenu;

type
  TfPasswordEnter = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Panel1: TPanel;
    btnConnection: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    cbUser: TComboBox;
    Label2: TLabel;
    ePassword: TEdit;
    lblComputer: TLabel;
    edtComputer: TEdit;
    XPMenu: TXPMenu;
    procedure FormCreate(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
  private
    prv_bExpanded: Boolean;
  public
    { Public declarations }
  end;

var
  fPasswordEnter: TfPasswordEnter;

implementation

uses
  DataModule, kmClient_TLB, ClientLib, ULogUtils, Mess;

{$R *.DFM}

procedure TfPasswordEnter.FormCreate(Sender: TObject);
begin
  //Caption := sys_ClientVersion;
  prv_bExpanded := False;
  Height := 188;
  if DM.ServerData.Connected then
  try
    //TODO DRAGO prv_strComputer := VarToStr(GetOptionState(c_APP_ClientOptions, c_APP_DComComputerName, varString));
    //TODO DRAGO edtComputer.Text := prv_strComputer;

    //Popylvane na User combobox-a sys stoinosti
    DM.SetCommandText( DM.cdsMiscQuery, 'SELECT DISTINCT NAME FROM USERNAME WHERE USED = 1' );
    DM.cdsMiscQuery.First;
    while not DM.cdsMiscQuery.Eof do begin
      cbUser.Items.Add(DM.cdsMiscQuery.Fields[0].AsString);
      DM.cdsMiscQuery.Next;
    end;
    if cbUser.Items.Count > 0 then cbUser.ItemIndex := 0;

    if DM.cdsMiscQuery.Active then DM.cdsMiscQuery.Close;

    //TODO DRAGO if Trim(lcLastUser) <> '' then cbUser.Text := lcLastUser;
    //btnConnectionClick(nil)
  except
    on E: Exception do
      WriteToLog(E.Message, 'PasswordEnter.FormCreate', '', '');
  end;
end;

procedure TfPasswordEnter.btnConnectionClick(Sender: TObject);
begin
  if prv_bExpanded then begin
    btnConnection.Caption := 'Сървър >>';
    Height := 180;
  end
  else begin
    btnConnection.Caption := 'Скрий <<';
    Height := 200;
  end;

  lblComputer.Visible := not prv_bExpanded;
  edtComputer.Visible := not prv_bExpanded;
  edtComputer.ReadOnly := prv_bExpanded;

  prv_bExpanded := not prv_bExpanded;
end;

end.

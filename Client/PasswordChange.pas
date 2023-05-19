unit PasswordChange;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, DBCtrls, ExtCtrls;

type
  TfPasswordChange = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    pList: TPanel;
    pnlMain: TPanel;
    Label4: TLabel;
    edtUser: TEdit;
    Label2: TLabel;
    eOldPassword: TEdit;
    Label1: TLabel;
    eNewPassword: TEdit;
    Label3: TLabel;
    eNewPasswordCheck: TEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPasswordChange: TfPasswordChange;

implementation

uses Dialogs, DataModule, ULogUtils, Mess;

{$R *.DFM}

procedure TfPasswordChange.FormCreate(Sender: TObject);
begin
  //Caption := sys_ClientVersion;
end;

procedure TfPasswordChange.FormKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if Key = #13 then begin
      Key := #0;
      SelectNext(ActiveControl, True, True);
    end;
  except
    on E: Exception do WriteToLog(E.Message, 'PasswordChange.FormKeyPress', '', '');
  end;
end;

procedure TfPasswordChange.btnOkClick(Sender: TObject);
begin
  try
    if DM.cdsUserName.FieldByName('Pass').AsString = eOldPassword.Text then
      if eNewPassword.Text = eNewPasswordCheck.Text then begin
        DM.cdsUserName.FieldByName('Pass').Value := eNewPassword.Text;
        ModalResult := mrOk;
      end
      else
        MessageDlg('Новата парола не е въведена правилно !', mtError, [mbOk], 0)
    else
      MessageDlg('Невалидна стара парола !', mtError, [mbOk], 0);
  except
    on E: Exception do
      WriteToLog(E.Message, 'PasswordChange.btnOKClick', '', '');
  end;
end;

end.


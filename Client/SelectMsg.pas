unit SelectMsg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, dbClient, Db, DBCtrls, ExtCtrls;

type
  TTableSelectRecord = record
    tsrLinked: Boolean;
    tsrDataCDS: TClientDataSet;
    tsrDataField: String;
    tsrListCDS: TClientDataSet;
    tsrListField: String;
    tsrKeyField: String;
  end;

  TfSelectMsg = class(TForm)
    bSelect: TBitBtn;
    bCancel: TBitBtn;
    pnlList: TPanel;
    cbSelect: TComboBox;
    pnlCaption: TPanel;
    lSelect: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function SelectForm(Items: TStrings; FormCaption, LabelText: String): String;

implementation

uses DataModule, ULogUtils, Mess;

{$R *.DFM}

function SelectForm(Items: TStrings; FormCaption, LabelText: String): String;
begin
  SelectForm := '';

  if Items = nil then
    MessageDlg('Не са въведени стойности за списъка!', mtInformation, [mbOk], 0);

  if ( FormCaption = '' ) or ( LabelText = '' ) then
    MessageDlg('Не са въведени Заглавие на формата и/или текст!', mtInformation, [mbOk], 0);

  with TfSelectMsg.Create(Application) do
    try
      pnlCaption.Caption := ' ' + FormCaption;
      lSelect.Caption := LabelText;

      cbSelect.Items.Assign( Items );

      if cbSelect.Items.Count > 0 then cbSelect.ItemIndex := 0;

      if ShowModal = mrOK then SelectForm := cbSelect.Text;
    finally
      Free;
    end;
end;

end.

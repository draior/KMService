unit ClientAndSerial;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, StdCtrls, Mask, DBCtrls,
  Grids, DBGrids, ExtCtrls, Buttons, DBClient, ActnList, XPMenu,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.ActnMan, Vcl.ScreenTips, Vcl.ActnCtrls,
  Vcl.Ribbon;


type
  TfClientSerial = class(TfBaseEntity)
    eMashineName: TDBEdit;
    lSerialNo: TLabel;
    eSerial: TDBEdit;
    sbMashine: TSpeedButton;
    acMashine: TAction;
    eEngine: TDBEdit;
    lEngine: TLabel;
    lClient: TLabel;
    eClient: TDBEdit;
    sbClient: TSpeedButton;
    acClient: TAction;
    XPMenu: TXPMenu;
    ScreenTipsManager: TScreenTipsManager;
    ActionManager: TActionManager;
    Ribbon: TRibbon;
    rpFilter: TRibbonPage;
    rgOffers: TRibbonGroup;
    rpOperation: TRibbonPage;
    rgFiles: TRibbonGroup;
    procedure acMashineExecute(Sender: TObject);
    procedure acClientExecute(Sender: TObject);
    procedure tbButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetChangeFields; override;
  end;

var
  fClientSerial: TfClientSerial;

implementation

uses
   DataModule, ULogUtils, Utilities, SelectorUtilities, FormConstants, Variants;

{$R *.DFM}

procedure TfClientSerial.acClientExecute(Sender: TObject);
begin
  try
    AllowChange := False;
    InsertItemEx(fc_Client,
      'ID;NAME;',

      'CLIENT.NAME', VarArrayOf([dsList.DataSet.FieldByName('L_CLIENT_NAME').AsString]), dsList.DataSet,

      'CLIENT_ID;L_CLIENT_NAME',
      [],
      ShowSelector,
      so_SelectSingle);

    AllowChange := true;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'TfClientSerial.acClientSelectExecute');
    end;
  end;
end;

procedure TfClientSerial.acMashineExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TfClientSerial.SetChangeFields;
begin
  try
    SetLength(ChangeFieldsArray, 1);

    ChangeFieldsArray[0].Field := dbgList.DataSource.DataSet.FieldByName('L_CLIENT_NAME');
    ChangeFieldsArray[0].OldProc := dbgList.DataSource.DataSet.FieldByName('L_CLIENT_NAME').OnChange;
    ChangeFieldsArray[0].ExecAction := acClient;
    dbgList.DataSource.DataSet.FieldByName('L_CLIENT_NAME').OnChange := FieldOnChange;

  except
    on E: Exception do WritetoLog(E.Message, 'TfMashine.SetChangeFields', '', '');
  end;
end;

procedure TfClientSerial.tbButtonClick(Sender: TObject);
var
  Range: String;
begin
  if TToolButton(Sender).Tag = 16 then begin
    if Trim(eSerial.Text) <> '' then begin
      if DM.ServerData.AppServer.CheckMashineSerial(DM.cdsMashineSerial.FieldByName('MASHINE_ID').AsInteger,
              eSerial.Text, Range) <> 0 then begin
        MessageDlg('Зададен е невалиден сериен номер. Диапазона за номера е: '+Range, mtError, [mbOk], 0);
        Exit;
      end;
    end;
  end;

  inherited;

  try
    if TToolButton(Sender).Tag in [14, 16] then begin
      DM.ServerData.AppServer.RequestDoc('MashineSerial', 'MASHINESERIAL.MASHINE_ID = ' + IntToStr(DM.MashineID), '', 0);
      DM.ReOpen(CDS[0]);
    end;
  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], HelpContext);
      WriteToLog(E.Message, 'TfClientSerial.tbButtonClick');
    end;
  end;
end;

end.

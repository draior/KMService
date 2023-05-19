unit User;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BASEENTITY, Menus, ImgList, Db, ComCtrls, ToolWin, StdCtrls, Mask, DBCtrls,
  Grids, DBGrids, ExtCtrls, Buttons, DBClient, ActnList, XPMenu,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.ActnMan, Vcl.ScreenTips, Vcl.ActnCtrls,
  Vcl.Ribbon;


type
  TfUser = class(TfBaseEntity)
    eName: TDBEdit;
    tsRigths: TTabSheet;
    Label19: TLabel;
    dbcbUsed: TDBCheckBox;
    cbArticle: TComboBox;
    lArticle: TLabel;
    lUser: TLabel;
    cbUsers: TComboBox;
    lMashines: TLabel;
    sbMashine: TComboBox;
    lOffers: TLabel;
    cbOffers: TComboBox;
    XPMenu: TXPMenu;
    ScreenTipsManager: TScreenTipsManager;
    ActionManager: TActionManager;
    Ribbon: TRibbon;
    rpFilter: TRibbonPage;
    rgOffers: TRibbonGroup;
    rpOperation: TRibbonPage;
    rgFiles: TRibbonGroup;
    acPasswordChange: TAction;
    lEMail: TLabel;
    eEMail: TDBEdit;
    lMobile: TLabel;
    eMobile: TDBEdit;
    ePhone: TDBEdit;
    lPhone: TLabel;
    eFax: TDBEdit;
    lFax: TLabel;
    procedure SetEditMode; override;
    procedure SetListMode; override;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbApplyFilterClick(Sender: TObject);
    procedure tbResetFilterClick(Sender: TObject);
    procedure dsListDataChange(Sender: TObject; Field: TField);
    procedure cbChange(Sender: TObject);
    procedure acPasswordChangeExecute(Sender: TObject);
  private
    { Private declarations }
    procedure FillRights;
  public
    { Public declarations }
  end;

var
  fUser: TfUser;

implementation

uses
   DataModule, PasswordChange, ULogUtils, Utilities;

{$R *.DFM}

(*procedure TfUser.FillRadioGroups;
var
  Cntr1, Cntr2: Integer;
begin
  try
    if dsList.DataSet.RecordCount > 0 then
      for Cntr1 := 0 to pcList.PageCount - 1 do
        for Cntr2 := 0 to pcList.Pages[Cntr1].ControlCount - 1 do
          if pcList.Pages[Cntr1].Controls[Cntr2] is TRadioGroup then
            if TRadioGroup(pcList.Pages[Cntr1].Controls[Cntr2]).Tag > 0 then
              TRadioGroup(pcList.Pages[Cntr1].Controls[Cntr2]).ItemIndex := DecodeUserRight(TRadioGroup(pcList.Pages[Cntr1].Controls[Cntr2]).Tag, dsList.DataSet.FieldByName('Rights').AsString);
  except
    on E: Exception do WriteToLog(E.Message, 'User.FillRadioGroups', '', '');
  end;
end;*)

procedure TfUser.SetEditMode;
begin
  inherited;
  acPasswordChange.Enabled := True;
end;

procedure TfUser.SetListMode;
begin
  inherited;
  acPasswordChange.Enabled := False;
end;

procedure TfUser.FormDestroy(Sender: TObject);
begin
  try
    DM.UserOpen := False;
    inherited;
    if DM.ServerData.AppServer.GetFilter(TClientDataSet(dsList.DataSet).ProviderName) <> '' then
      tbResetFilterClick(Sender);
    DM.cdsUserName.Filtered := False;
  except
    on E: Exception do WriteToLog(E.Message, 'User.FormDestroy', '', '');
  end;
end;

procedure TfUser.acPasswordChangeExecute(Sender: TObject);
var
  fPasswordChange: TfPasswordChange;
begin
  fPasswordChange := TfPasswordChange.Create(Self);
  try
    with fPasswordChange do begin
      edtUser.Text := eName.Text;
      ShowModal;
    end;
  except
    on E: Exception do WriteToLog(E.Message, 'User.tbPasswordChangeClick', '', '');
  end;
  FreeAndNil(fPasswordChange);
end;

procedure TfUser.cbChange(Sender: TObject);
begin
  try
    with dsList.DataSet do
      if State in [dsEdit, dsInsert] then
         FieldByName('Rights').AsString := EncodeUserRight(FieldByName('RIGHTS').Size, TComboBox(Sender).Tag, TComboBox(Sender).ItemIndex, FieldByName('Rights').AsString);
  except
    on E: Exception do WriteToLog(E.Message, 'User.RadiGroupClick', '', '');
  end;
end;

procedure TfUser.dsListDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if dsList.State in [dsBrowse] then
    FillRights;
end;

procedure TfUser.FillRights;
var
  Cntr2, R: Integer;
begin
  try
    for Cntr2 := 0 to tsRigths.ControlCount - 1 do
      if tsRigths.Controls[Cntr2] is TComboBox then
        if TComboBox(tsRigths.Controls[Cntr2]).Tag > 0 then begin
          R := DecodeUserRight(TComboBox(tsRigths.Controls[Cntr2]).Tag, dsList.DataSet.FieldByName('Rights').AsString);
          if R >= TComboBox(tsRigths.Controls[Cntr2]).Items.Count then
            R := TComboBox(tsRigths.Controls[Cntr2]).Items.Count-1;
          TComboBox(tsRigths.Controls[Cntr2]).ItemIndex := R;
        end;
  except
    on E: Exception do WriteToLog(E.Message, 'User.FillRadioGroups', '', '');
  end;
end;

procedure TfUser.FormCreate(Sender: TObject);
begin
  try
    DM.UserOpen := True;
    inherited;

    //tbRefreshClick(tbRefresh);
    DM.cdsUserName.Filtered := True;
  except
    on E: Exception do WriteToLog(E.Message, 'User.FormCreate');
  end;
end;

procedure TfUser.tbApplyFilterClick(Sender: TObject);
begin
  inherited;
  DM.cdsUserName.Filtered := False;
end;

procedure TfUser.tbResetFilterClick(Sender: TObject);
begin
  inherited;
  DM.cdsUserName.Filtered := True;
end;

end.

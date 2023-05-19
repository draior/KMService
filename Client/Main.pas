unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.ComCtrls, Vcl.Menus, Vcl.StdCtrls, Dialogs,
  Vcl.RibbonLunaStyleActnCtrls, Vcl.Ribbon, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ImgList, Vcl.ExtCtrls, Vcl.ScreenTips, XPMenu;

type
  TfMain = class(TForm)
    sb: TStatusBar;
    ActionList: TActionList;
    acArticles: TAction;
    acUsers: TAction;
    acMashines: TAction;
    acOffers: TAction;
    bbArticle: TButton;
    bbUsers: TButton;
    bbMashine: TButton;
    bbOffers: TButton;
    bbClient: TButton;
    acClient: TAction;
    bbMakeOffers: TButton;
    acMakeOffers: TAction;
    Ribbon: TRibbon;
    ActionManager: TActionManager;
    ImageList: TImageList;
    rpFields: TRibbonPage;
    rgFiles: TRibbonGroup;
    aArticle: TAction;
    aMashines: TAction;
    aClient: TAction;
    aUsers: TAction;
    rpOffers: TRibbonPage;
    rgOffers: TRibbonGroup;
    aOffers: TAction;
    aMakeOffers: TAction;
    GridPanel1: TGridPanel;
    ScreenTipsManager: TScreenTipsManager;
    XPMenu: TXPMenu;
    procedure acArticlesExecute(Sender: TObject);
    procedure acUsersExecute(Sender: TObject);
    procedure acMashinesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acOffersExecute(Sender: TObject);
    procedure acClientExecute(Sender: TObject);
    procedure acMakeOffersExecute(Sender: TObject);
  private
    { Private declarations }
    procedure CreateShowForm(FormConstant: Integer; AForm: TFormClass);
    procedure SetUpActions;
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses DataModule, BASEENTITY, FormConstants, Article, ULogUtils, User, Mashine,
  SelectMsg, Offers, Client, MakeOffers;

procedure TfMain.acArticlesExecute(Sender: TObject);
begin
  CreateShowForm(fc_Article, TfArticle);
end;

procedure TfMain.acClientExecute(Sender: TObject);
begin
  CreateShowForm(fc_Client, TfClient);
end;

procedure TfMain.acMakeOffersExecute(Sender: TObject);
begin
  CreateShowForm(fc_MakeOffers, TfMakeOffers);
end;

procedure TfMain.acMashinesExecute(Sender: TObject);
//var
  //lcItems: TStringList;
  //lcResult: String;
begin
  CreateShowForm(fc_Mashine, TfMashine);

  {lcItems := TStringList.Create;
  try
    DM.SetCommandText(DM.cdsMiscQuery, 'SELECT DISTINCT MTYPE FROM MASHINE ORDER BY MTYPE');
    while not DM.cdsMiscQuery.Eof do begin
      lcItems.Add(DM.cdsMiscQuery.FieldByName('MTYPE').AsString);
      DM.cdsMiscQuery.Next;
    end;
    if lcItems.Count > 0 then begin
      lcResult := SelectForm(lcItems, 'Тип машина', 'Тип');
      if lcResult <> '' then
        DM.ServerData.AppServer.RequestDoc('Mashine', 'MASHINE.MTYPE = ' + QuotedStr(lcResult), '', 0);
    end;

  except
    on E: Exception do begin
      MessageDlg(E.Message, mtError, [mbOk], 0);
      WritetoLog(E.Message, 'TfMain.acMashinesExecute');
    end;
  end;}
end;

procedure TfMain.acOffersExecute(Sender: TObject);
begin
  CreateShowForm(fc_Offers, TfOffers);
end;

procedure TfMain.acUsersExecute(Sender: TObject);
begin
  CreateShowForm(fc_UserName, TfUser);
end;

procedure TfMain.CreateShowForm(FormConstant: Integer; AForm: TFormClass);
var
  F: TForm;
begin
  F := AForm.Create(Self);
  try
    //F.Caption := sys_ClientVersion;
    F.Position  := poScreenCenter;
    if (AForm.ClassParent = TfBaseEntity) then begin
      with (F as TfBaseEntity) do begin
        pcList.ActivePageIndex := 0;
        pblFormID := FormConstant;
      end //if TfBaseEntity
    end;

    F.ShowModal;
  except
    on E: Exception do
      WriteToLog(E.Message, 'Main.CreateShowForm');
  end;
  FreeAndNil(F);
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  sb.Panels[1].Text := DM.CurrentUserName;
  SetUpActions;
end;

procedure TfMain.SetUpActions;
var
  i: Integer;
  A: TAction;
begin
  try
    for i := 0 to ActionList.ActionCount - 1 do begin
      A := TAction(ActionList.Actions[i]);
      if A.Tag <> 0 then begin
        A.Visible := DM.CurrentUserRights[A.Tag] > '0';
        A.Enabled := A.Visible;
      end;
    end;
    for i := 0 to ActionManager.ActionCount - 1 do begin
      A := TAction(ActionManager.Actions[i]);
      if A.Tag <> 0 then
        A.Enabled := DM.CurrentUserRights[A.Tag] > '0';
    end;
  except
    on E: Exception do WriteToLog(E.Message, 'TfMain.SetUpActions');
  end;
end;

end.


unit HTMLViewerUnit;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB, DBTables,
     OleCtrls, ImgList, ToolWin, ComCtrls, ExtCtrls, ActnList, SHDocVw;

type
  TTimerMess = (tmStart, tmStop, tmClose);
  TToolBtnClick = procedure(TmMess: TTimerMess) of object;

type
  THTMLViewerForm = class(TForm)
    ToolBar: TToolBar;
    tbPreview: TToolButton;
    tbPrint: TToolButton;
    tbExit: TToolButton;
    ImageList: TImageList;
    tbSetup: TToolButton;
    PrintTimer: TTimer;
    WB: TWebBrowser;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ActionList: TActionList;
    acClose: TAction;
    acPrint: TAction;
    tbOk: TToolButton;
    ToolButton5: TToolButton;
    acBack: TAction;
    procedure acBackExecute(Sender: TObject);
    procedure tbExitClick(Sender: TObject);
    procedure tbPreviewClick(Sender: TObject);
    procedure tbPrintClick(Sender: TObject);
    procedure tbSetupClick(Sender: TObject);
    procedure PrintTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acPrintExecute(Sender: TObject);
    procedure tbOkClick(Sender: TObject);
  private
    { Private declarations }
    PrintOnly: Boolean;
  public
    { Public declarations }
    ToolBtnClick: TToolBtnClick;
  end;

function ShowHTML(const FileName: TFileName; Preview: Boolean=False;
  const ConfirmCaption: String=''; const ConfirmHint: String='';
  Modal: Boolean=True): TModalResult;
 { Shows "FileName" on in IExplorer window.}
function FillHtmlParams(DataSet: TDataSet; Params: TStringList=nil): TStringList;
 { Adds the values from the current record in DataSet to the Params in form:
   <FieldName>=<Value>
   Returns Params as Result. If Params=NIL, it will be created and returned as result.
   NOTE: A value is only added if Params does not contain such <FieldName>, i.e. the values
     in Params has higher precedence over the values from DataSet. }


var
  HTMLViewerForm: THTMLViewerForm = nil;
  HTMLConfirmQuetion: Boolean = False;
  HTMLPrinted: Boolean = False;

const
  ENABLE_PRINTING: Boolean = True;

implementation

uses Registry;

{$R *.DFM}

function ShowHTML(const FileName: TFileName; Preview: Boolean=False;
  const ConfirmCaption: String=''; const ConfirmHint: String='';
  Modal: Boolean=True): TModalResult;

  procedure CheckPrinterSetup;
  var
    Reg: TRegistry;
    Header, Footer, Margin_Left, Margin_Right, Margin_Top, Margin_Bottom: string;
  begin
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      Reg.OpenKey('\Software\Microsoft\Internet Explorer\PageSetup', true);
      Margin_Left :=   Reg.ReadString('margin_left');
      Margin_Right :=  Reg.ReadString('margin_right');
      Margin_Top :=    Reg.ReadString('margin_top');
      Margin_Bottom := Reg.ReadString('margin_bottom');
      Header :=        Reg.ReadString('header');
      Footer :=        Reg.ReadString('footer');

      if Header <> '' then
        Reg.WriteString('header', '');
      if Footer <> '' then
        Reg.WriteString('footer', '');
      if Margin_Left <> '0.59055' then //in inch = 15mm
        Reg.WriteString('margin_left', '0.59055');
      if Margin_Right <> '0.27559' then //in inch = 7mm
        Reg.WriteString('margin_right', '0.27559');
      if Margin_Top <> '0.27559' then
        Reg.WriteString('margin_top', '0.27559');
      if Margin_Bottom <> '0.27559' then
        Reg.WriteString('margin_bottom', '0.27559');
    except
    end;
    Reg.Free;
  end;

begin
  Result := mrNone;
  if not HTMLViewerUnit.ENABLE_PRINTING and not Preview then
    Exit;
  if not Assigned(HTMLViewerForm) then begin
    CheckPrinterSetup;
    HTMLViewerForm := THTMLViewerForm.Create(Application.MainForm);
    if not Modal then begin
      with HTMLViewerForm do begin
        if Application.MainForm.FormStyle = fsMDIForm then
          FormStyle := fsMDIChild
        else
          FormStyle := fsNormal;
        //ToolBar.Visible := False;
        PrintOnly := False; // True ???
        WindowState := wsMaximized;
        Show;
      end;
    end;
  end;

  with HTMLViewerForm do begin
    WB.Navigate(WideString(FileName));
    if not Modal then
      Exit;
    if Preview then begin
      Caption := ExtractFileName(FileName);
      PrintOnly := False;
      WindowState := wsMaximized;
      if ConfirmCaption <> '' then begin
        tbOk.Caption := ' ' + ConfirmCaption + ' ';
        tbOk.Hint := ConfirmHint;
        tbOk.Visible := True;
      end
      else
        tbOk.Visible := False;
      Result := ShowModal;
    end
    else begin
      PrintOnly := True;
      WindowState := wsMinimized;
      Result := ShowModal;
    end;
  end;
end;

procedure THTMLViewerForm.tbExitClick(Sender: TObject);
begin
  if Assigned(ToolBtnClick) then
    ToolBtnClick(tmClose);
  if FormStyle <> fsMDIChild then
    Hide;
  ModalResult := mrCancel;
end;

procedure THTMLViewerForm.tbOkClick(Sender: TObject);
begin
  if Assigned(ToolBtnClick) then
    ToolBtnClick(tmStop);
  ModalResult := mrOk;
end;

procedure THTMLViewerForm.tbPreviewClick(Sender: TObject);
begin
  if Assigned(ToolBtnClick) then
    ToolBtnClick(tmStop);
  WB.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT);
  //WB.Preview;
end;

procedure THTMLViewerForm.tbPrintClick(Sender: TObject);
begin
  if Assigned(ToolBtnClick) then
    ToolBtnClick(tmStop);
  if HTMLConfirmQuetion then begin
    if MessageDlg('След отпечатване на офертата тя няма да може да се редактира повече.'#13'Желаете ли да продължите с отпечатването?', mtConfirmation, [mbOK, mbCancel], 0) <> mrOk then
      Exit;

    HTMLPrinted := True;
  end;
  WB.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER);
  //WB.PrintDocument(True);
end;

procedure THTMLViewerForm.tbSetupClick(Sender: TObject);
begin
  if Assigned(ToolBtnClick) then
    ToolBtnClick(tmStop);
  WB.ExecWB(OLECMDID_PAGESETUP, OLECMDEXECOPT_DODEFAULT);
  //WB.PrinterSetup;
end;

procedure THTMLViewerForm.PrintTimerTimer(Sender: TObject);
begin
  PrintTimer.Enabled := False;
  Hide;
  if HTMLViewerUnit.ENABLE_PRINTING then begin
    while WB.ReadyState <> READYSTATE_COMPLETE do begin
      Sleep(50);
      Application.ProcessMessages;
    end;
    WB.ExecWB(OLECMDID_PRINT, OLECMDEXECOPT_DONTPROMPTUSER);
    //WB.PrintDocument(True);
  end;
  Close;
end;

procedure THTMLViewerForm.FormShow(Sender: TObject);
begin
  tbPreview.Enabled := HTMLViewerUnit.ENABLE_PRINTING;
  tbPrint.Enabled := HTMLViewerUnit.ENABLE_PRINTING;
  WB.SetFocus;
  if PrintOnly then
    PrintTimer.Enabled := True;
end;

procedure THTMLViewerForm.FormDestroy(Sender: TObject);
begin
  HTMLViewerForm := nil;
end;

procedure THTMLViewerForm.acBackExecute(Sender: TObject);
begin
  try
    WB.GoBack;
  except
  end;
end;

procedure THTMLViewerForm.acCloseExecute(Sender: TObject);
begin
  tbExitClick(nil);
end;

procedure THTMLViewerForm.acPrintExecute(Sender: TObject);
begin
  tbPrintClick(nil);
end;

function FillHtmlParams(DataSet: TDataSet; Params: TStringList=nil): TStringList;
var i: Integer;
    V: String;
begin
  Result := Params;
  if Result = nil then
    Result := TStringList.Create;
  for i := 0 to DataSet.FieldCount-1 do begin
    V := DataSet.Fields[i].AsString;
    //if DataSet.Fields[i].DataType in [ftString, ftMemo, ftDate, ftTime, ftDateTime] then
    //  V := SqlQuotedStr(V);
    //if V <> '' then
    Result.Values[DataSet.Fields[i].FieldName] := V;
    if V = '' then
      Result.Add(DataSet.Fields[i].FieldName+'=');
  end;
end;


initialization

finalization
  FreeAndNil(HTMLViewerForm);
end.


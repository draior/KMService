unit Progress;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TfProgress = class(TForm)
    Panel2: TPanel;
    pbBGSend: TProgressBar;
    Label1: TLabel;
    pbTables: TProgressBar;
    Label2: TLabel;
    mReport: TMemo;
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure ProgressBGSendInit(lcBGSendCount: Integer);
    procedure ProgressTableInit(lcTableCount: Integer);
    procedure ProgressStep(lcBGSendPos, lcTablePos: integer);
    procedure SetLabelsCaption(Caption, MasterLabel, DetailLabel: String);
  end;

implementation

uses ULogUtils;

{$R *.DFM}

procedure TfProgress.ProgressStep(lcBGSendPos, lcTablePos: integer);
begin
  try
    if lcBGSendPos <> 0 then pbBGSend.Position := lcBGSendPos;
    if lcTablePos  <> 0 then pbTables.Position := lcTablePos;

    pbTables.Refresh;
    pbBGSend.Refresh;

    Application.ProcessMessages;
  except
    on E: Exception do WriteToLog(E.Message, 'Progress.ProgressStep', '', '');
  end;
end;

procedure TfProgress.ProgressBGSendInit(lcBGSendCount: Integer);
begin
  try
    pbBGSend.Max := lcBGSendCount;
    pbBGSend.Position := 0;
    Application.ProcessMessages;
  except
    on E: Exception do WriteToLog(E.Message, 'Progress.ProgressBGSendInit', '', '');
  end;
end;

procedure TfProgress.ProgressTableInit(lcTableCount: Integer);
begin
  try
    pbTables.Max := lcTableCount;
    pbTables.Position := 0;
    Application.ProcessMessages;
  except
    on E: Exception do WriteToLog(E.Message, 'Progress.ProgressTableInit', '', '');
  end;
end;

procedure TfProgress.SetLabelsCaption(Caption, MasterLabel,
  DetailLabel: String);
begin
  Panel2.Caption := ' ' + Caption;
  Label1.Caption := MasterLabel;
  Label2.Caption := DetailLabel;

  Application.ProcessMessages;
end;

procedure TfProgress.FormCreate(Sender: TObject);
begin
  //TODO DRAGO Caption := sys_ClientVersion;
end;

end.

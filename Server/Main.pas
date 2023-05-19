unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.AppEvnts,
  Vcl.ExtCtrls, DBTables;

type
  TfMain = class(TForm)
    bbUsers: TButton;
    pmTrayIcon: TPopupMenu;
    miRestore: TMenuItem;
    miExit: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    TrayIcon: TTrayIcon;
    ApplicationEvents: TApplicationEvents;
    Timer: TTimer;
    bbPrint: TButton;
    bbImport: TButton;
    procedure bbUsersClick(Sender: TObject);
    procedure miRestoreClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses UserMonitor, SysUnit, RemoteDM;

procedure ImportKMExcel(FName: String; qr: TQuery; T: TTable);
  external 'ImportExcelLib.DLL';
procedure ImportKMExcel2;
  external 'ImportExcelLib.DLL';


procedure TfMain.ApplicationEventsMinimize(Sender: TObject);
begin
  { Hide the window and set its state variable to wsMinimized. }
  Hide();
  WindowState := wsMinimized;

  { Show the animated tray icon and also a hint balloon. }
  TrayIcon.Visible := True;
  TrayIcon.Animate := True;
  TrayIcon.ShowBalloonHint;
end;

procedure TfMain.bbImportClick(Sender: TObject);
begin
  ImportKMExcel2;
end;

procedure TfMain.bbUsersClick(Sender: TObject);
begin
  fUserMonitor.Show;
end;

procedure TfMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.miRestoreClick(Sender: TObject);
begin
  TrayIconDblClick(nil);
end;

procedure TfMain.N2Click(Sender: TObject);
begin
  fUserMonitor.Show;
end;

procedure TfMain.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  ApplicationEventsMinimize(nil);
end;

procedure TfMain.TrayIconDblClick(Sender: TObject);
begin
  { Hide the tray icon and show the window,
  setting its state property to wsNormal. }
  TrayIcon.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.

program kmService;

uses
  Vcl.Forms,
  Main in 'Main.pas' {fMain},
  kmServer_TLB in 'kmServer_TLB.pas',
  RemoteDM in 'RemoteDM.pas' {kmServer: TRemoteDataModule} {kmServer: CoClass},
  UserMonitor in 'UserMonitor.pas' {fUserMonitor};

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfUserMonitor, fUserMonitor);
  Application.Run;
end.

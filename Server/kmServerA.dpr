program kmServerA;

uses
  Vcl.Forms,
  kmServer_TLB in 'kmServer_TLB.pas',
  UserMonitor in 'UserMonitor.pas' {fUserMonitor},
  Main in 'Main.pas' {fMain},
  RemoteDM in 'RemoteDM.pas' {kmServer: TRemoteDataModule};

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Kirov mashine server';
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfUserMonitor, fUserMonitor);
  Application.Run;
end.

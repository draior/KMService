program kmClient;

uses
  Vcl.Forms,
  Dialogs,
  SysUtils,
  UlogUtils,
  Main in 'Main.pas' {fMain},
  kmClient_TLB in 'kmClient_TLB.pas',
  ClientLib in 'ClientLib.pas' {kmClient: CoClass},
  NotifyClient in 'NotifyClient.pas' {fNotifyClient},
  PasswordEnter in 'PasswordEnter.pas' {fPasswordEnter},
  UserMonitor in 'UserMonitor.pas' {fUserMonitor},
  BASEENTITY in 'BASEENTITY.pas' {fBaseEntity},
  Article in 'Article.pas' {fArticle},
  Client in 'Client.pas' {fClient},
  DataModule in 'DataModule.pas' {DM: TDataModule},
  User in 'User.pas' {fUser},
  Offers in 'Offers.pas' {fOffers},
  Mashine in 'Mashine.pas' {fMashine},
  ClientAndSerial in 'ClientAndSerial.pas' {fClientSerial},
  MakeOffers in 'MakeOffers.pas' {fMakeOffers};

{$R *.TLB}

{$R *.res}

var
  ErrorFlag: Boolean;

begin
  ErrorFlag := True;
  FormatSettings.DecimalSeparator := '.';
  FormatSettings.DateSeparator := '.';
  FormatSettings.ShortDateFormat := 'dd.m.yyyy';

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  try
    Application.CreateForm(TfMain, fMain);
    Application.CreateForm(TfNotifyClient, fNotifyClient);
    Application.CreateForm(TDM, DM);
    if not Application.Terminated then begin
      //fSplash.pbLoad.Position := 4;
      Application.CreateForm(TfUserMonitor, fUserMonitor);
      //fSplash.pbLoad.Position := 5;

      case DM.LogIn of
       -4: MessageDlg('Въведената парола е невалидна!', mtError, [mbOk], 0);
       -3: MessageDlg('Потребителят е блокиран!', mtError, [mbOk], 0);
       -1, -2: MessageDlg('Потребителят не е регистриран за този обект [склад]!', mtError, [mbOk], 0);
        0: ErrorFlag := False;
        1: ;//buton otkaz
      else
        MessageDlg('Достъпът до сървъра отказан!', mtError, [mbOk], 0); //Greshna parola ili potebitelsko ime
      end;//case

      {TODO DRAGO
      if not ErrorFlag then begin
        fMessageForm := TfMessageForm.Create(Application);
        fMessageForm.Show;
        fMessageForm.Update;
        fMessageForm.ActivateDataModule;
        fMessageForm.Release;
      end;}
    end;

  except
    on E: Exception do begin
      MessageDlg('Не може да се установи връзка със сървъра!', mtError, [mbOk], 0);
      WriteToLog(E.Message, 'Client.dpr');
    end;
  end;
  Application.ProcessMessages;
  if ErrorFlag then begin
    if Assigned(DM) then FreeAndNil(DM);
    Application.Terminate;
  end
  else
    Application.Run;
end.

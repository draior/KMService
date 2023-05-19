unit MsgFormUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, RxMemDS, Menus;

type
  TfMsgForm = class(TForm)
    ds: TDataSource;
    dbg: TDBGrid;
    PopupMenu: TPopupMenu;
    pmExport: TMenuItem;
    SaveDialog: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pmExportClick(Sender: TObject);
  private
    { Private declarations }
    tbl: TRxMemoryData;
  public
    { Public declarations }
    procedure ShowQR(qr: TQuery);
  end;


implementation

{$R *.DFM}

uses
  XlsUtilsUnit;

{ TfMsgForm }

procedure TfMsgForm.ShowQR(qr: TQuery);
begin
  tbl.LoadFromDataSet(qr, 0, lmCopy);
  ds.DataSet := tbl;
  Self.Show;
end;

procedure TfMsgForm.FormCreate(Sender: TObject);
begin
  tbl := TRxMemoryData.Create(Self);
end;

procedure TfMsgForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(tbl);
end;

procedure TfMsgForm.pmExportClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    ExportDataToText(tbl, nil, nil, '', SaveDialog.FileName, nil, 0, Self);
end;

end.

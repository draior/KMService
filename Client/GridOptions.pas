unit GridOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, Mess, DBGrids, System.UITypes;

const
  c_strLeftJustify  = 'Ляво подравнено';
  c_strCenter       = 'Центрирано';
  c_strRightJustify = 'Дясно подравнено';
  c_strYes = 'Да';
  c_strNo  = 'Не';

type
  TfGridOptions = class(TForm)
    pMain: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    edtCaption: TEdit;
    edtSize: TEdit;
    edtFormat: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbVisible: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    cbAlignment: TComboBox;
    sgFields: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure cbColorCloseUp(Sender: TObject);
    procedure sgFieldsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgFieldsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtCaptionChange(Sender: TObject);
    procedure edtSizeChange(Sender: TObject);
    procedure edtFormatChange(Sender: TObject);
    procedure cbAlignmentChange(Sender: TObject);
    procedure cbVisibleChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    prv_intRow : Integer;
    procedure SetParams(intRow: Integer);
  public
    { Public declarations }
    pbl_lstFields: TStringList;
  end;

  procedure ShowGridOptions(DbGrid: TDbGrid);

//var
  //fGridOptions: TfGridOptions;

implementation

uses
  db, ULogUtils;

{$R *.DFM}

procedure ShowGridOptions(DbGrid: TDbGrid);
var
  i: Integer;
  lc_frmOpt: TfGridOptions;
  lc_intInd: Integer;
begin
  lc_frmOpt := TfGridOptions.Create(nil);
  try
    lc_frmOpt.sgFields.RowCount := 1;
    for i := 0 to DbGrid.Columns.Count - 1 do begin
      if ( DbGrid.Columns[i].Field.Tag and 0 ) = 0 then begin
        lc_frmOpt.pbl_lstFields.Add( DbGrid.Columns[i].FieldName );

        lc_frmOpt.sgFields.RowCount := lc_frmOpt.sgFields.RowCount + 1;
        //CAPTION
        lc_frmOpt.sgFields.Cells[0, lc_frmOpt.sgFields.RowCount - 1] := DbGrid.Columns[i].Title.Caption;

        //WIDTH
        lc_frmOpt.sgFields.Cells[1, lc_frmOpt.sgFields.RowCount - 1] := IntToStr( DbGrid.Columns[i].Width );

        //FORMAT
        if ( DbGrid.Columns[i].Field is TNumericField) then
          lc_frmOpt.sgFields.Cells[2, lc_frmOpt.sgFields.RowCount - 1] := TNumericField( DbGrid.Columns[i].Field ).DisplayFormat;

        if ( DbGrid.Columns[i].Field is TDateTimeField ) then
          lc_frmOpt.sgFields.Cells[2, lc_frmOpt.sgFields.RowCount - 1] := TDateTimeField( DbGrid.Columns[i].Field ).DisplayFormat;

        //COLOR
        lc_frmOpt.sgFields.Cells[3, lc_frmOpt.sgFields.RowCount - 1] := IntToStr( DbGrid.Columns[i].Color );

        //ALIGNMENT
        case DbGrid.Columns[i].Alignment of
          taRightJustify:
            lc_frmOpt.sgFields.Cells[4, lc_frmOpt.sgFields.RowCount - 1] := c_strRightJustify;
          taCenter:
            lc_frmOpt.sgFields.Cells[4, lc_frmOpt.sgFields.RowCount - 1] := c_strCenter;
          else
            lc_frmOpt.sgFields.Cells[4, lc_frmOpt.sgFields.RowCount - 1] := c_strLeftJustify;
        end;

        //VISIBLE
        if DbGrid.Columns[i].Visible then
          lc_frmOpt.sgFields.Cells[5, lc_frmOpt.sgFields.RowCount - 1] := c_strYes
        else
          lc_frmOpt.sgFields.Cells[5, lc_frmOpt.sgFields.RowCount - 1] := c_strNo;
      end;
    end;

    if lc_frmOpt.sgFields.RowCount = 1 then
      lc_frmOpt.sgFields.RowCount := 2;

    lc_frmOpt.sgFields.FixedRows := 1;

    //Modified by Velichko 28.01.2003
    if lc_frmOpt.ShowModal = mrOK then begin
      for i := 0 to DbGrid.Columns.Count - 1 do begin
        lc_intInd := lc_frmOpt.pbl_lstFields.IndexOf(DbGrid.Columns[i].FieldName);
        if (lc_intInd > -1) then begin
          if (lc_frmOpt.sgFields.Cells[5, lc_intInd + 1] = c_strYes) then
            DbGrid.Columns[i].Visible := True
          else
            DbGrid.Columns[i].Visible := False;

          DbGrid.Columns[i].Title.Caption := lc_frmOpt.sgFields.Cells[0, lc_intInd + 1];
          DbGrid.Columns[i].Width := StrToInt(lc_frmOpt.sgFields.Cells[1, lc_intInd + 1]);
          DbGrid.Columns[i].Color := StringToColor(lc_frmOpt.sgFields.Cells[3, lc_intInd + 1]);

          if (lc_frmOpt.sgFields.Cells[4, lc_intInd + 1] = c_strLeftJustify) then
            DbGrid.Columns[i].Alignment := taLeftJustify
          else if (lc_frmOpt.sgFields.Cells[4, lc_intInd + 1] = c_strRightJustify) then
            DbGrid.Columns[i].Alignment := taRightJustify
          else
            DbGrid.Columns[i].Alignment := taCenter;
        end;
      end;
    end;
    //End Modified by Velichko 28.01.2003
  except
    on E: Exception do
      WriteToLog(E.Message, 'ShowGridOptions', 'Grid: ' + DbGrid.Name, '');
  end;
  FreeAndNil(lc_frmOpt);
end;

procedure TfGridOptions.FormCreate(Sender: TObject);
begin
  Caption := sys_ClientVersion;
  prv_intRow := 0;

  pbl_lstFields := TStringList.Create;
  sgFields.Cells[0, 0] := 'Наименование';
  sgFields.Cells[1, 0] := 'Размер';
  sgFields.Cells[2, 0] := 'Формат';
  sgFields.Cells[3, 0] := 'Цвят';
  sgFields.Cells[4, 0] := 'Подравняване';
  sgFields.Cells[5, 0] := 'Видимо';
end;

procedure TfGridOptions.cbColorCloseUp(Sender: TObject);
begin
  //TODO DRAGO sgFields.Cells[3, prv_intRow] := ColorToString( cbColor.SelectedColor );
end;

procedure TfGridOptions.sgFieldsDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ACol = 3) and (ARow > 0) then begin
    sgFields.Canvas.Brush.Color := StringToColor( sgFields.Cells[3, ARow] );
    sgFields.Canvas.Pen.Color := sgFields.Canvas.Brush.Color;
    sgFields.Canvas.FillRect( Rect );
  end;
end;

procedure TfGridOptions.sgFieldsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if ARow <> prv_intRow then SetParams( ARow );
end;

procedure TfGridOptions.FormShow(Sender: TObject);
begin
  if sgFields.RowCount > 1 then
    SetParams(1);
end;

procedure TfGridOptions.SetParams(intRow: Integer);
begin
  edtCaption.Text := sgFields.Cells[0, intRow];
  edtSize.Text    := sgFields.Cells[1, intRow];
  edtFormat.Text  := sgFields.Cells[2, intRow];
  //tODO DRAGO cbColor.SelectedColor := StringToColor( sgFields.Cells[3, intRow] );

  if sgFields.Cells[4, intRow] = c_strRightJustify then
    cbAlignment.ItemIndex := 2
  else
    if sgFields.Cells[4, intRow] = c_strCenter then
      cbAlignment.ItemIndex := 1
    else
      cbAlignment.ItemIndex := 0;

  if sgFields.Cells[5, intRow] = c_strYes then
    cbVisible.ItemIndex := 0
  else
    cbVisible.ItemIndex := 1;

  prv_intRow := intRow;
end;

procedure TfGridOptions.edtCaptionChange(Sender: TObject);
begin
  if edtCaption.Focused then
    sgFields.Cells[0, prv_intRow] := edtCaption.Text;
end;

procedure TfGridOptions.edtSizeChange(Sender: TObject);
begin
  if edtSize.Focused then
    sgFields.Cells[1, prv_intRow] := edtSize.Text;
end;

procedure TfGridOptions.edtFormatChange(Sender: TObject);
begin
  if edtFormat.Focused then
    sgFields.Cells[2, prv_intRow] := edtFormat.Text;
end;

procedure TfGridOptions.cbAlignmentChange(Sender: TObject);
begin
  case cbAlignment.ItemIndex of
    1: sgFields.Cells[4, prv_intRow] := c_strCenter;
    2: sgFields.Cells[4, prv_intRow] := c_strRightJustify;
    else
       sgFields.Cells[4, prv_intRow] := c_strLeftJustify;
  end;//case
end;

procedure TfGridOptions.cbVisibleChange(Sender: TObject);
begin
  if cbVisible.ItemIndex = 0 then
    sgFields.Cells[5, prv_intRow] := c_strYes
  else
    sgFields.Cells[5, prv_intRow] := c_strNo;
end;

procedure TfGridOptions.FormDestroy(Sender: TObject);
begin
  FreeAndNil(pbl_lstFields);
end;

end.




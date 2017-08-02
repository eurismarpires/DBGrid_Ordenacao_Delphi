unit UnOrdenacaoDBGrid;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Grids, DBGrids, ImgList, StdCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ImageList1: TImageList;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    ordemTituloClicadoDescendente:Boolean;
    colunaOrdem:String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  bmp:TBitmap;
begin
  // pintar o icone conforme a ordem
  bmp := TBitmap.Create;
  if Column.FieldName = colunaOrdem then
  Begin
    Column.Title.Font.Color := clBlue;
    if Rect.Top < 30 then
    begin
      if ordemTituloClicadoDescendente then
        ImageList1.Draw(DBGrid1.Canvas, Rect.Right-18, Rect.Top-18, 0)
      else
        ImageList1.Draw(DBGrid1.Canvas, Rect.Right-18, Rect.Top-18, 1);
    end;  
  end
  else
    Column.Title.Font.Color := clWindowText;
  bmp.Free;
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
var i:integer;
begin
  inherited;
  //ordenar conforme a coluna clicada
  ClientDataSet1.IndexDefs.Clear;
  if ordemTituloClicadoDescendente = true then
  begin
    ClientDataSet1.IndexFieldNames :=  Column.FieldName;
    ordemTituloClicadoDescendente := False;
  end
  else
  begin
    ClientDataSet1.IndexDefs.Add(Column.FieldName,Column.FieldName,[ixDescending]);
    ClientDataSet1.IndexName := Column.FieldName;
    ordemTituloClicadoDescendente := True;
  end;
  //mudar a cor do texto
  for i := 0 to Column.Grid.FieldCount - 1 do
  begin
    DBGrid1.columns.Items[i].Title.font.Color := clBlack;
    DBGrid1.columns.Items[i].Title.font.Style := [];
    DBGrid1.columns.Items[i].Title.Color := clBtnFace;
    Column.Title.Color := clSilver;
    Column.Title.font.Style := [fsbold];
  end;
  colunaOrdem := Column.FieldName;
end;

end.

program DBGrid_Ordenacao;

uses
  Forms,
  UnOrdenacaoDBGrid in 'UnOrdenacaoDBGrid.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

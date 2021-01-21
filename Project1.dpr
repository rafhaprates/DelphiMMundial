program Project1;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {Form1},
  UnitAlterar in 'UnitAlterar.pas' {frmAlterar},
  Unitincluir in 'Unitincluir.pas' {frmInserir};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmAlterar, frmAlterar);
  Application.CreateForm(TfrmInserir, frmInserir);
  Application.Run;
end.

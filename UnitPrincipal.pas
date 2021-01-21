unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    dbRegistros: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    Image1: TImage;
    btn_incluir: TButton;
    btn_alterar: TButton;
    btn_deletar: TButton;
    txt_teste: TLabel;
    ADOQuery1Nome: TStringField;
    ADOQuery1C�digo: TAutoIncField;
    ADOQuery1Endere�o: TStringField;
    ADOQuery1Cidade: TStringField;
    btn_imprimir: TButton;
    rel_cadastro: TfrxReport;
    frx_cadastro: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    procedure btn_deletarClick(Sender: TObject);
    procedure btn_alterarClick(Sender: TObject);
    procedure btn_incluirClick(Sender: TObject);
    procedure btn_imprimirClick(Sender: TObject);
    procedure dbRegistrosTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  SqlConsultaPadrao: TStrings;

implementation

{$R *.dfm}

uses UnitAlterar, Unitincluir;

procedure TForm1.btn_deletarClick(Sender: TObject);
 {
    Autor: Rafhael Prates 
    Email: rafhael@rafhaprates.dev
    Data: 16/01/2021
    Fun��o: Essa Procedure tem como o objetivo de excluir um registro selecionado no DBGrid
    Observa��es: Ela faz 2 valida��es, a primeira veirficar se tem algum registro no DBGrid, se tiver ele vai para a outra
    valida��o se o usuario deseja alterar, por Padr�o o sistema n�o exclui o registro de fato, para que possa ser recuperado
    posteriormente, apenas fazer o update no campo D_E_L_E_T = '*' assim n�o sendo exibido no DBGrid
  }
var
  listaCodigoRegistro: string;

begin
  if dbRegistros.DataSource.DataSet.RecordCount = 0 then
  Begin
    Application.MessageBox('N�o tem registros para apagar!', 'Aten��o!', MB_OK);
  end
  else
  Begin
    if MessageDlg('Tem certeza que deseja excluir a Informa��o?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      listaCodigoRegistro := dbRegistros.Columns[0].Field.Value;

      with ADOQuery1 do
      Begin
        Close();
        SQL.Clear;
        SQL.Add('UPDATE clientes');
        SQL.Add('       SET D_E_L_E_T = ''*''    ');
        SQL.Add('WHERE clientesCodigo = ' + listaCodigoRegistro);
        ExecSQL;
        Close();
        SQL.Add('select clientesCodigo as ''C�digo'', clienteNome as ''Nome'' , clienteEndereco as ''Endere�o'' , clienteCidade  as ''Cidade'' from clientes where D_E_L_E_T = ''''');
        Open();
        Application.MessageBox('Registro apagado com sucesso!',
          'Aten��o!', MB_OK);
      End;

    End;
  End;

End;

procedure TForm1.btn_imprimirClick(Sender: TObject);
  {
    Autor: Rafhael Prates
    Email: rafhael@rafhaprates.dev
    Data:  18/01/2020
    Fun��o: Essa procedure chama o FastReports 6
    Observa��o: o Fast reports imprime todos os dados contidos no DBGrid
  }
begin
  rel_cadastro.ShowReport();
end;

procedure TForm1.btn_incluirClick(Sender: TObject);
  {
    Autor:  Rafhael Prates
    Email:  rafhael@rafhaprates.dev
    Data:   17/01/2020
    Fun��o:  Essa prociedure chama o formulario frmInserir 
    Observa��o: Inclus�o de novos registros no DBGrid.
  }
begin
  frmInserir.ShowModal;
end;

procedure TForm1.btn_alterarClick(Sender: TObject);
  {
    Autor: Rafhael Prates 
    Email: rafhael@rafhaprates.dev
    Data: 17/01/2021
    Fun��o: Essa Procedure tem como o objetivo de chamar a UnitAlterar para Altera��o do registros no DB
    Observa��es: Ela faz 2 valida��es, a primeira veirficar se tem algum registro no DBGrid, se tiver ele vai para a outra
    valida��o que no caso � perguntar ao usuario se ele deseja realmente alterar aquele registro.
    As demais opera��es est�o no form frmAlterar
  }
begin
  if dbRegistros.DataSource.DataSet.RecordCount = 0 then
  Begin
    Application.MessageBox('N�o tem registros para serem alterados!',
      'Aten��o!', MB_OK);
  end
  else
  Begin
    if MessageDlg('Tem certeza que deseja alterar a Informa��o?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      frmAlterar.edt_nomeAlterar.Text := dbRegistros.Fields[1].Value;
      frmAlterar.edt_enderecoAlterar.Text := dbRegistros.Fields[2].Value;
      frmAlterar.edt_cidadeAlterar.Text := dbRegistros.Fields[3].Value;
      ADOQuery1.Edit;
      frmAlterar.ShowModal;
    end;

  End;
end;

procedure TForm1.dbRegistrosTitleClick(Column: TColumn);
  {
    Autor: Rafhael Prates 
    Email: rafhael@rafhaprates.dev
    Data: 18/01/2021
    Fun��o: Essa Procedure tem como o objetivo ordenar o DBGrid pelas suas respectivas colunas.
    Observa��es: 
    Nesse caso n�o podemos usar o Switch Case por que ele n�o permite comparar String, somente char e int 
    Ent�o nesse caso a melhor solu��o foi usar o If 
  }
var
  i: Integer;
  instrucaoSQL:string;
begin
  for i := 0 to dbRegistros.Columns.Count - 1 do
    dbRegistros.Columns[i].Title.Font.Style := [];
    
  if Column.FieldName = 'Nome' then
     Begin
         with ADOQuery1 do
              Begin
                Close();
                SQL.Clear;
                SQL.Add('select clientesCodigo as ''C�digo'',');
                SQL.Add('       clienteNome as ''Nome'' ,');
                SQL.Add('     clienteEndereco as ''Endere�o'' , ');
                SQL.Add('   clienteCidade  as ''Cidade'' from clientes ');
                SQL.Add('                 where D_E_L_E_T = '' '' ');
                SQL.Add('                 Order by clienteNome  ');

              Open;
              End;

      Column.Title.Font.Style := [fsBold];
     End
     Else if Column.FieldName = 'C�digo'  then
     Begin
         with ADOQuery1 do
              Begin
                Close();
                SQL.Clear;
                SQL.Add('select clientesCodigo as ''C�digo'',');
                SQL.Add('       clienteNome as ''Nome'' ,');
                SQL.Add('     clienteEndereco as ''Endere�o'' , ');
                SQL.Add('   clienteCidade  as ''Cidade'' from clientes ');
                SQL.Add('                 where D_E_L_E_T = '' '' ');
                SQL.Add('                 Order by clientesCodigo  ');

              Open;
              End;

      Column.Title.Font.Style := [fsBold];
     End   
        Else if Column.FieldName = 'Endere�o'  then
     Begin
         with ADOQuery1 do
              Begin
                Close();
                SQL.Clear;
                SQL.Add('select clientesCodigo as ''C�digo'',');
                SQL.Add('       clienteNome as ''Nome'' ,');
                SQL.Add('     clienteEndereco as ''Endere�o'' , ');
                SQL.Add('   clienteCidade  as ''Cidade'' from clientes ');
                SQL.Add('                 where D_E_L_E_T = '' '' ');
                SQL.Add('                 Order by clienteEndereco  ');

              Open;
              End;

      Column.Title.Font.Style := [fsBold];
     End   
         Else if Column.FieldName = 'Cidade'  then
     Begin
         with ADOQuery1 do
              Begin
                Close();
                SQL.Clear;
                SQL.Add('select clientesCodigo as ''C�digo'',');
                SQL.Add('       clienteNome as ''Nome'' ,');
                SQL.Add('     clienteEndereco as ''Endere�o'' , ');
                SQL.Add('   clienteCidade  as ''Cidade'' from clientes ');
                SQL.Add('                 where D_E_L_E_T = '' '' ');
                SQL.Add('                 Order by clienteCidade  ');

              Open;
              End;

      Column.Title.Font.Style := [fsBold];
     End   
end;

end.

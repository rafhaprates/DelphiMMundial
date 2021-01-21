unit Unitincluir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmInserir = class(TForm)
    edt_nomeInserir: TEdit;
    edt_enderecoInserir: TEdit;
    edt_cidadeInserir: TEdit;
    lbl_cidadeInserir: TLabel;
    lbl_nomeInserir: TLabel;
    lbl_enderecoInserir: TLabel;
    btn_gravar: TButton;
    btn_sair: TButton;
    procedure btn_sairClick(Sender: TObject);
    procedure btn_gravarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInserir: TfrmInserir;

implementation

{$R *.dfm}

uses UnitAlterar, UnitPrincipal;

procedure TfrmInserir.btn_gravarClick(Sender: TObject);
 {
    Autor: Rafhael Prates
    Email: rafhael@rafhaprates.dev
    Data: 17/01/2021
    Função: Essa Procedure tem como o objetivo incluir novas informações ao DB
    Observações: Ele faz a validação dos campos em Branco, e posteriormente grava,
    ele não faz nehuma validação para saber se tem campos repetidos, pois o unico campo que não se repete é o 'Código'
    o 'Código' ele é chave primaria e auto incremental realizado pelo MSSQL

  }
begin
  if (edt_nomeInserir.Text = '') or (edt_enderecoInserir.Text = '') or (edt_cidadeInserir.Text = '')  then

   Begin
       Application.MessageBox('Os campos não podem ficar em branco!', 'Atenção!', MB_OK);
  End
  else
  begin
  with Form1.ADOQuery1 do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('insert into clientes ( clienteNome, clienteEndereco, clienteCidade, D_E_L_E_T) values (:Cliente, :Endereco, :Cidade, :Delete)' );
      Parameters.ParamByName('Cliente').Value := edt_nomeInserir.Text;
      Parameters.ParamByName('Endereco').Value := edt_enderecoInserir.Text;
      Parameters.ParamByName('Cidade').Value := edt_cidadeInserir.Text;
      Parameters.ParamByName('Delete').Value := '';
      ExecSQL;
        Close;
        SQL.Clear;
        SQL.Add('select clientesCodigo as ''Código'', clienteNome as ''Nome'' , clienteEndereco as ''Endereço'' , clienteCidade  as ''Cidade'' from clientes where D_E_L_E_T = ''''');
        Open();
      Application.MessageBox('Registro inserido com Sucesso com sucesso!', 'Atenção!', MB_OK);

      edt_nomeInserir.Clear;
      edt_enderecoInserir.Clear;
      edt_cidadeInserir.Clear;
    End;
  end;
end;

procedure TfrmInserir.btn_sairClick(Sender: TObject);
 {
    Autor: Rafhael Prates
    Email: rafhael@rafhaprates.dev
    Data: 17/01/2021
    Função: Essa Procedure tem como o objetivo de sair do form
    Observações:
  }
begin
      frmInserir.Close;
end;

end.

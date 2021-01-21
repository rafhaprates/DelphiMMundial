unit UnitAlterar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Win.ADODB, Vcl.StdCtrls, db,
  Vcl.Mask, Vcl.DBCtrls;

type
  TfrmAlterar = class(TForm)
    edt_nomeAlterar: TEdit;
    edt_cidadeAlterar: TEdit;
    edt_enderecoAlterar: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
  frmAlterar: TfrmAlterar;

implementation

{$R *.dfm}

uses UnitPrincipal;

procedure TfrmAlterar.btn_gravarClick(Sender: TObject);
 {
    Autor: Rafhael Prates
    Email: rafhael@rafhaprates.dev
    Data: 17/01/2021
    Função: Essa Procedure tem como o objetivo de gravar as informações do TEdit no banco
    Observações: Ela faz uma validação para verificar se houve modificações no registro,
    Caso não teve modificações ela da uma mensagem dizendo que não é necessario gravar
    E verifica se o campos estão em branco

  }
var
   listaCodigoRegistro:string;
begin
      if (Form1.ADOQuery1Nome.Value = edt_nomeAlterar.Text) and (Form1.ADOQuery1Endereço.Value = edt_enderecoAlterar.Text) and (Form1.ADOQuery1Cidade.Value = edt_cidadeAlterar.Text)  then
        Begin
              Application.MessageBox('Não é necessario salvar! Não tem registros modificados', 'Atenção!', MB_OK);
        End
        Else
        Begin
           if (edt_nomeAlterar.Text = '') or (edt_enderecoAlterar.Text = '') or (edt_cidadeAlterar.Text = '')  then
            Begin
               Application.MessageBox('Os campos não podem ficar em branco!', 'Atenção!', MB_OK);
            End
            Else
            Begin
              with Form1.ADOQuery1 do
            Begin
              Form1.ADOQuery1Nome.Value:= edt_nomeAlterar.Text;
              Form1.ADOQuery1Endereço.Value:= edt_enderecoAlterar.Text;
              Form1.ADOQuery1Cidade.Value:= edt_cidadeAlterar.Text;
              Form1.ADOQuery1.Post;
              Form1.ADOQuery1.Refresh;
              Application.MessageBox('Registro alterado com sucesso!', 'Atenção!', MB_OK);
            End;
              frmAlterar.Close;
            End;
        End;
end;

procedure TfrmAlterar.btn_sairClick(Sender: TObject);
 {
    Autor: Rafhael Prates
    Email: rafhael@rafhaprates.dev
    Data: 17/01/2021
    Função: Essa Procedure tem como o objetivo de sair do form
    Observações:
  }
begin
          frmAlterar.Close;
end;

end.

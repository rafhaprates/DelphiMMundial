object frmAlterar: TfrmAlterar
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSizeToolWin
  Caption = 'Alterar'
  ClientHeight = 242
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 29
    Width = 34
    Height = 13
    Caption = 'Nome :'
  end
  object Label2: TLabel
    Left = 56
    Top = 75
    Width = 52
    Height = 13
    Caption = 'Endere'#231'o :'
  end
  object Label3: TLabel
    Left = 56
    Top = 125
    Width = 40
    Height = 13
    Caption = 'Cidade :'
  end
  object edt_nomeAlterar: TEdit
    Left = 56
    Top = 48
    Width = 305
    Height = 21
    TabOrder = 0
  end
  object edt_cidadeAlterar: TEdit
    Left = 56
    Top = 144
    Width = 305
    Height = 21
    TabOrder = 1
  end
  object edt_enderecoAlterar: TEdit
    Left = 56
    Top = 94
    Width = 305
    Height = 21
    TabOrder = 2
  end
  object btn_gravar: TButton
    Left = 424
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = btn_gravarClick
  end
  object btn_sair: TButton
    Left = 343
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 4
    OnClick = btn_sairClick
  end
end

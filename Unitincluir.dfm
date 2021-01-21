object frmInserir: TfrmInserir
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSizeToolWin
  Caption = 'Inserir '
  ClientHeight = 272
  ClientWidth = 481
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
  object lbl_cidadeInserir: TLabel
    Left = 56
    Top = 125
    Width = 40
    Height = 13
    Caption = 'Cidade :'
  end
  object lbl_nomeInserir: TLabel
    Left = 56
    Top = 29
    Width = 34
    Height = 13
    Caption = 'Nome :'
  end
  object lbl_enderecoInserir: TLabel
    Left = 56
    Top = 75
    Width = 52
    Height = 13
    Caption = 'Endere'#231'o :'
  end
  object edt_nomeInserir: TEdit
    Left = 56
    Top = 48
    Width = 281
    Height = 21
    TabOrder = 0
  end
  object edt_enderecoInserir: TEdit
    Left = 56
    Top = 98
    Width = 281
    Height = 21
    TabOrder = 1
  end
  object edt_cidadeInserir: TEdit
    Left = 56
    Top = 144
    Width = 281
    Height = 21
    TabOrder = 2
  end
  object btn_gravar: TButton
    Left = 384
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 3
    OnClick = btn_gravarClick
  end
  object btn_sair: TButton
    Left = 288
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Sair'
    TabOrder = 4
    OnClick = btn_sairClick
  end
end

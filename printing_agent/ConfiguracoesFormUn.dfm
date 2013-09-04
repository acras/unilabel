object ConfiguracoesForm: TConfiguracoesForm
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 103
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 19
    Caption = 'Modelo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 41
    Width = 86
    Height = 19
    Caption = 'Impressora:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 248
    Top = 84
    Width = 12
    Height = 13
    Caption = 'ou'
  end
  object cboModelo: TComboBox
    Left = 100
    Top = 8
    Width = 239
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'cboModelo'
    Items.Strings = (
      'Argox OS 214 (PPLA)'
      'Zebra TLP-2844')
  end
  object cboPrinters: TComboBox
    Left = 100
    Top = 41
    Width = 239
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'cboModelo'
    Items.Strings = (
      'Argox OS 214 (PPLA)'
      'Zebra TLP-2844')
  end
  object btnSalvar: TButton
    Left = 264
    Top = 74
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object LinkLabel1: TLinkLabel
    Left = 204
    Top = 84
    Width = 46
    Height = 17
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = LinkLabel1Click
  end
end

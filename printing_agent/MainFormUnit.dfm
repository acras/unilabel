object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Impress'#227'o de Etiquetas'
  ClientHeight = 92
  ClientWidth = 266
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
    Top = 71
    Width = 16
    Height = 13
    Caption = '4.1'
  end
  object btnImprimir: TButton
    Left = 6
    Top = 8
    Width = 252
    Height = 49
    Caption = 'Imprimir Arquivo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnImprimirClick
  end
  object btnConfiguracoes: TBitBtn
    Left = 152
    Top = 63
    Width = 106
    Height = 25
    Caption = 'Configura'#231#245'es...'
    TabOrder = 1
    OnClick = btnConfiguracoesClick
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'unilabel'
    Filter = 
      'Arquivos Compat'#237'veis Unilabel|*.unilabel;*.xml|Todos os Arquivos' +
      '|*.*'
    Left = 280
    Top = 8
  end
end

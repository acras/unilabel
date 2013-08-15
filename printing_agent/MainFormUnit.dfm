object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Impress'#227'o de Etiquetas'
  ClientHeight = 64
  ClientWidth = 191
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
  object btnImprimir: TButton
    Left = 6
    Top = 8
    Width = 177
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
  object OpenDialog: TOpenDialog
    DefaultExt = 'unilabel'
    Filter = 
      'Arquivos Compat'#237'veis Unilabel|*.unilabel;*.xml|Todos os Arquivos' +
      '|*.*'
    Left = 280
    Top = 8
  end
end

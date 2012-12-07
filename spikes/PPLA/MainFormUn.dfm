object Form1: TForm1
  Left = 389
  Top = 82
  Width = 563
  Height = 312
  Caption = 'PPLA Lib Example'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 70
    Top = 35
    Width = 160
    Height = 40
    Caption = 'Print Label'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Memo1: TMemo
    Left = 184
    Top = 104
    Width = 313
    Height = 153
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
    WordWrap = False
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 415
    Top = 267
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 401
    Height = 284
    Lines.Strings = (
      '<xml>'
      '  <configuration>'
      '    <columns>3</columns>'
      '    <label-dimension>'
      '      <height>60</height> '
      '      <width>101</width>'
      '    </label-dimension>'
      '    <margin>'
      '      <left>2</left>'
      '      <right>2</right>'
      '      <horizontal-gap>3</horizontal-gap>'
      '    </margin>'
      '  </configuration>'
      '  <labels>'
      '    <label copies="1">'
      '    <element type='#39'text'#39' '
      '            value='#39'Estopim - Blusa'#39
      #9'    x='#39'2'#39' y='#39'30'#39
      #9'    font-name='#39'Verdana'#39' '
      '            font-size='#39'28'#39'/>'
      '    <element type='#39'text'#39' '
      '            value='#39'09542'#39
      #9'    x='#39'2'#39' y='#39'27'#39
      #9'    font-name='#39'Verdana'#39' '
      '            font-size='#39'28'#39'/>'
      '    <element type='#39'barcode'#39' '
      '            value='#39'09542'#39
      #9'    x='#39'2'#39' y='#39'21'#39' />'
      '    <element type='#39'text'#39' '
      '            value='#39'Estopim - Blusa'#39
      #9'    x='#39'2'#39' y='#39'15'#39
      #9'    font-name='#39'Verdana'#39' '
      '            font-size='#39'28'#39'/>'
      '    <element type='#39'text'#39' '
      '            value='#39'09542'#39
      #9'    x='#39'2'#39' y='#39'12'#39
      #9'    font-name='#39'Verdana'#39' '
      '            font-size='#39'28'#39'/>'
      '    <element type='#39'barcode'#39' '
      '            value='#39'09542'#39
      #9'    x='#39'2'#39' y='#39'6'#39' />'
      '    <element type='#39'text'#39' '
      '            value='#39'R$98,90'#39
      #9'    x='#39'2'#39' y='#39'0'#39
      #9'    font-name='#39'Verdana'#39' '
      '            font-size='#39'45'#39'/>'
      '    </label>'
      '  </labels>'
      '</xml>')
    TabOrder = 1
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 512
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    442
    512)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 364
    Top = 479
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
    ExplicitLeft = 552
    ExplicitTop = 267
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 345
    Height = 496
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '<xml>'
      '  <configuration>'
      '    <columns>3</columns>'
      '    <label-dimension>'
      '      <height>63</height> '
      '      <width>34</width>'
      '    </label-dimension>'
      '    <margin>'
      '      <left>2</left>'
      '      <right>2</right>'
      '      <bottom>2</bottom>'
      '      <horizontal-gap>0</horizontal-gap>'
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
    ScrollBars = ssVertical
    TabOrder = 1
  end
end

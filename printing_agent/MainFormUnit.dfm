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
      #9'<configuration>'
      #9'  <columns>3</columns>'
      #9'  <label-dimension>'
      #9'    <height>60</height> '
      #9'    <width>35</width>'
      #9'  </label-dimension>'
      #9'  <margin>'
      #9'    <left>5</left>'
      #9'    <right>5</right>'
      #9'    <horizontal-gap>2</horizontal-gap>'
      #9'  </margin>'
      #9'</configuration>'
      #9'<labels>'
      #9'  <label copies="7">'
      #9'    <elements>'
      #9'      <element type='#39'text'#39' value='#39'Le Lis Blanc'#39'>'
      #9'        <position x='#39'10'#39' y='#39'20'#39' />'
      
        #9'        <font name='#39'Verdana'#39' size='#39'23'#39' bold='#39'true'#39' italic='#39'true' +
        #39' />'
      #9'      </element>'
      #9'    </elements>'
      #9'  </label>'
      #9'  <label>'
      #9'    <elements>'
      #9'      <element type='#39'text'#39' value='#39'Le Lis Blanc'#39'>'
      #9'        <position x='#39'10'#39' y='#39'20'#39' />'
      
        #9'        <font name='#39'Verdana'#39' size='#39'23'#39' bold='#39'true'#39' italic='#39'true' +
        #39' />'
      #9'      </element>'
      #9'    </elements>'
      #9'  </label>'
      #9'</labels>'
      '</xml>')
    TabOrder = 1
  end
end

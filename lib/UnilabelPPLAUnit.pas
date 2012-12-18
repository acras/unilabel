unit UnilabelPPLAUnit;

interface

uses UnilabelInterfaceUnit, vcl.Graphics, System.IOUtils, System.SysUtils;

type

  TUnilabelPPLA = class(TInterfacedObject, IUnilabel)

  public
    constructor create;
    procedure printText(data: string; x: Integer; y: Integer; fontName: string;
      fontStyles: TFontStyles; fontSize: Integer);
    procedure printOrientedText(data: string; x: Integer; y: Integer;
      orientation: Integer; fontName: string; fontStyles: TFontStyles;
      fontSize: Integer);
    procedure printBarcode(data: string; x: Integer; y: Integer;
      barcodeType: TUnilabelBarcodeFormats; height: Integer;
      narrowWidth: Integer; wideWidth: Integer; showNumeric: Boolean);
    procedure printOrientedBarcode(data: string; x: Integer; y: Integer;
      orientation: Integer; barcodeType: TUnilabelBarcodeFormats;
      height: Integer; narrowWidth: Integer; wideWidth: Integer;
      showNumeric: Boolean);
    function initializePrinter: boolean;
    procedure printOut;
    procedure closePrinter;
  protected
    var currentInternalVarIndex: integer;
    function nextInternalVarName: string;
  end;

implementation

{ TUnilabelPPLA }

uses PPLADLLWrapper;

var dpCrLf: AnsiString = chr(13)+chr(10);
var szSavePath: String = 'C:\users\acras\desktop\Argox';
var szSaveFile: AnsiString = 'C:\users\acras\desktop\Argox\PPLA_Example.Prn';
var sznop1: AnsiString = 'nop_front' + Chr(13) + chr(10);
var sznop2: AnsiString = 'nop_middle' + Chr(13) + chr(10);


procedure TUnilabelPPLA.closePrinter;
begin
  A_ClosePrn();
end;

constructor TUnilabelPPLA.create;
begin
  currentInternalVarIndex := 0;
end;

function TUnilabelPPLA.initializePrinter: boolean;
var
  nLen, len1, len2: integer;
  ret,sw : integer;
  pbuf : array[0..127] of AnsiChar;
  buf1,buf2 : AnsiString;
begin
  nLen := A_GetUSBBufferLen() + 1;
  If nLen > 1 then
  begin
    len1 := 128;
    len2 := 128;
    SetLength(buf1,len1);
    SetLength(buf2,len2);
    A_EnumUSB(pbuf);
    A_GetUSBDeviceInfo(1, PAnsiChar(buf1), @len1, PAnsiChar(buf2), @len2);
    sw := 1;
    if 0 < sw then
      ret := A_CreatePrn(12, PAnsiChar(buf2)) // open usb.
    else
      ret := A_CreateUSBPort(1); // must call A_GetUSBBufferLen() function fisrt.
    if 0 > ret then
    begin
      SetLength(buf1,len1);
      SetLength(buf2,len2);
    end;
  end
  else
  begin
    TDirectory.CreateDirectory(szSavePath);
    ret := A_CreatePrn(0, szSaveFile);
  end;

  result := ret <= 0;

  if result then
  begin
    A_Set_Unit('m');
    A_Set_Syssetting(1, 0, 0, 0, 0);
    A_Del_Graphic(1, '*');
    A_Clear_Memory();
  end;
end;

function TUnilabelPPLA.nextInternalVarName: string;
begin
  result := FormatFloat('00', currentInternalVarIndex);
  inc(currentInternalVarIndex);
end;

procedure TUnilabelPPLA.printBarcode(data: string; x, y: Integer;
  barcodeType: TUnilabelBarcodeFormats; height, narrowWidth, wideWidth: Integer;
  showNumeric: Boolean);
begin

end;

procedure TUnilabelPPLA.printOrientedBarcode(data: string; x, y, orientation: Integer;
  barcodeType: TUnilabelBarcodeFormats; height, narrowWidth, wideWidth: Integer;
  showNumeric: Boolean);
begin

end;

procedure TUnilabelPPLA.printOrientedText(data: string; x, y, orientation: Integer;
  fontName: string; fontStyles: TFontStyles; fontSize: Integer);
begin
end;

procedure TUnilabelPPLA.printOut;
begin
  A_Print_Out(1, 1, 1, 1);
end;

procedure TUnilabelPPLA.printText(data: string; x, y: Integer; fontName: string;
  fontStyles: TFontStyles; fontSize: Integer);
var
  iBold, iItalic, iUnderline, iStrikeOut: integer;
begin
  if fsBold in fontStyles then iBold := 400 else iBold := 0;
  if fsItalic in fontStyles then iItalic := 1 else iItalic := 0;
  if fsUnderline in fontStyles then iUnderline := 1 else iUnderline := 0;
  if fsStrikeOut in fontStyles then iStrikeOut := 1 else iStrikeOut := 0;
  A_Prn_Text_TrueType(x, y, fontSize, AnsiString(fontName), 1, iBold,
    iItalic, iUnderline, iStrikeOut, nextInternalVarName, Ansistring(data), 1);

end;

end.

unit UnilabelPPLAUnit;

interface

uses UnilabelInterfaceUnit, vcl.Graphics, System.IOUtils, System.SysUtils,
  Windows, UnilabelTypesUnit, Vcl.Dialogs, Winapi.shellAPI, Forms;

type

  TArgoxCommunicationMode = (tacmUndefined, tacmUSB, tacmDriver);
  TUnilabelPPLA = class(TInterfacedObject, IUnilabel)
  private
    communicationMode: TArgoxCommunicationMode;
    printerConfiguration: TPrinterConfiguration;
    function parseCommunicationMode(value: String): TArgoxCommunicationMode;
    function initializeDriver: boolean;
    function initializeUSB: boolean;
    function getPrintingTempFileName: string;
    procedure sendPrintFileToDriver;
public
    constructor create;
    procedure setConfiguration(configuration: TLabelConfiguration);
    procedure setSpecificConfiguration(name, value: String);
    procedure setPrinterConfigurations(configuration: TPrinterConfiguration);
    procedure printText(data: string; x: double; y: double; fontName: string;
      fontStyles: TFontStyles; fontSize: double; spin: integer = 1);
    procedure printBarcode(data: string; x: double; y: double;
      barcodeType: TUnilabelBarcodeFormats; height: double;
      narrowWidth: double; wideWidth: double; showReadable: Boolean;
      spin: integer = 1);
    procedure printImage(path: string; x,y: double);
    procedure printBox(x,y,width,height,topThickness,sideThickness: double);
    function initializePrinter: boolean;
    procedure printOut;
    procedure closePrinter;
    procedure startJob;
    procedure finishJob;
  protected
    labelConfiguration: TLabelConfiguration;
    tempFileName: String;
    var currentInternalVarIndex: integer;
    function nextInternalVarName: string;
    procedure validateBarcodeParameters(narrowWidth, wideWidth: double);
  end;

implementation

{ TUnilabelPPLA }

uses PPLADLLWrapper, acSysUtils;

var dpCrLf: AnsiString = chr(13)+chr(10);
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

procedure TUnilabelPPLA.finishJob;
begin
  //nothing to do as it sends page by page
  if communicationMode = tacmDriver then
    sendPrintFileToDriver;
end;

procedure TUnilabelPPLA.sendPrintFileToDriver;
begin
  shellexecute(application.Handle, 'open', 'ssdal',
    PWideChar('/p "' + printerConfiguration.name  + '" send ' + tempFileName),
    nil, SW_HIDE);
end;

procedure TUnilabelPPLA.setConfiguration(configuration: TLabelConfiguration);
begin
  labelConfiguration := configuration;
end;

procedure TUnilabelPPLA.setPrinterConfigurations(
  configuration: TPrinterConfiguration);
begin
  printerConfiguration := configuration;
end;

procedure TUnilabelPPLA.setSpecificConfiguration(name, value: String);
begin
  if UpperCase(name) = 'COMMUNICATION' then
    communicationMode := parseCommunicationMode(value);
end;

function TUnilabelPPLA.parseCommunicationMode(
  value: String): TArgoxCommunicationMode;
begin
  result := tacmUndefined;
  if UpperCase(value) = 'USB' then
    result := tacmUSB;
  if UpperCase(value) = 'DRIVER' then
    result := tacmDriver;
end;

procedure TUnilabelPPLA.startJob;
begin
  //nothing to do as it sends page by page
end;

function TUnilabelPPLA.initializePrinter: boolean;
begin
  result := false;
  if communicationMode = tacmUSB then
    result := initializeUSB
  else if communicationMode = tacmDriver then
    result := initializeDriver
  else
    raise Exception.Create('Nenhum método de comunicação definido para Argox');
  if result then
  begin
    A_Set_Unit('m');
    A_Set_Syssetting(1, 0, 0, 0, 0);
    A_Del_Graphic(1, '*');
    A_Clear_Memory();
    A_Set_Darkness(12);
  end;
end;

function TUnilabelPPLA.initializeDriver: boolean;
begin
  tempFileName := getPrintingTempFileName;
  result := A_CreatePrn(0, tempFileName) = 0;
end;

function TUnilabelPPLA.initializeUSB: boolean;
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
      ret := A_CreatePrn(12, PAnsiChar(buf2))
    else
      ret := A_CreateUSBPort(1);
    if 0 > ret then
    begin
      SetLength(buf1,len1);
      SetLength(buf2,len2);
    end;
  end
  else
  begin
    raise Exception.Create(
      'Não foi possível localizar a impressora.' + #13#10 +
      'Certifique-se de que ela está conectada ao computador,' + #13#10 +
      'ligada e com os dois leds frontais acesos.');
  end;

  result := ret <= 0;
end;

function TUnilabelPPLA.nextInternalVarName: string;
begin
  result := FormatFloat('00', currentInternalVarIndex);
  inc(currentInternalVarIndex);
end;

procedure TUnilabelPPLA.printBarcode(data: string; x, y: double;
  barcodeType: TUnilabelBarcodeFormats; height: double;
  narrowWidth, wideWidth: double;
  showReadable: Boolean; spin: integer = 1);
var
  pType: char;
  px, py: integer;
begin
  validateBarcodeParameters(narrowWidth, wideWidth);
  pType := 'a';
  px := Trunc(x * 10);
  py := Trunc(y * 10);
  if barcodeType = bcfCode128 then
    pType := 'e';
  if barcodeType = bcfCode3of9 then
    pType := 'a';
  if barcodeType = bcfEAN13 then
  begin
    pType := 'f';
    if Length(data) = 13 then
      data := copy(data, 1, 12);
  end;
  if showReadable then
    pType := UpCase(pType);

  A_Prn_Barcode(pX, pY, spin, pType, trunc(narrowWidth), trunc(wideWidth),
    trunc(height*10), 'N', 0, ansiString(data));
end;

procedure TUnilabelPPLA.printBox(x, y, width, height, topThickness,
  sideThickness: double);
begin
  A_Draw_Box('A',trunc(x*10),trunc(y*10),trunc(width*10),trunc(height*10),
    trunc(topThickness*10),trunc(sideThickness*10));
end;

procedure TUnilabelPPLA.printImage(path: string; x, y: double);
var
  himage : HBITMAP;
begin
  A_Get_Graphic_ColorBMP(trunc(x*10), trunc(y*10), 1, 'B', AnsiString(path));
  himage := LoadImage(0,PChar(path),IMAGE_BITMAP,0,0,LR_LOADFROMFILE);
  If 0 <> himage then
    DeleteObject(himage);
end;

procedure TUnilabelPPLA.printOut;
begin
  A_Print_Out(1, 1, 1, 1);
end;

procedure TUnilabelPPLA.printText(data: string; x, y: double; fontName: string;
  fontStyles: TFontStyles; fontSize: double; spin: integer = 1);
var
  iBold, iItalic, iUnderline, iStrikeOut: integer;
begin
  if fsBold in fontStyles then iBold := 700 else iBold := 0;
  if fsItalic in fontStyles then iItalic := 1 else iItalic := 0;
  if fsUnderline in fontStyles then iUnderline := 1 else iUnderline := 0;
  if fsStrikeOut in fontStyles then iStrikeOut := 1 else iStrikeOut := 0;
  A_Prn_Text_TrueType(trunc(x*10), trunc(y*10),
    trunc(fontSize), AnsiString(fontName), spin, iBold,
    iItalic, iUnderline, iStrikeOut, ansiString(nextInternalVarName),
    Utf8ToAnsi(data), 1);

end;

procedure TUnilabelPPLA.validateBarcodeParameters(narrowWidth,
  wideWidth: double);
begin
  if (narrowWidth > 24) or (narrowWidth < 0) then
    raise Exception.Create('Invalid narrow width value. Must be between 0 and 24');
  if (wideWidth > 24) or (wideWidth < 0) then
    raise Exception.Create('Invalid narrow width value. Must be between 0 and 24');

end;

function TUnilabelPPLA.getPrintingTempFileName: string;
begin
  result := getWindowsTempFileName('argoxPrint') + '.prn';
end;

end.

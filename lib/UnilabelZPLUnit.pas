unit UnilabelZPLUnit;

interface
uses UnilabelInterfaceUnit, vcl.Graphics, System.IOUtils, System.SysUtils, Windows,
  Vcl.StdCtrls, Vcl.Printers, classes, UnilabelTypesUnit,
  Winapi.winSpool, Vcl.Dialogs, vcl.clipbrd;
type
  TUnilabelZPL = class(TInterfacedObject, IUnilabel)
  private
    function translatePositionParameter(p: double): string;
    function translateYParameter(y, heightInDots: double): string;
    procedure addConfigurationCommands;
  public
    constructor create;
    procedure setSpecificConfiguration(name, value: String);
    procedure setConfiguration(configuration: TLabelConfiguration);
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
    commands: TStringList;
    widthParam: string;
    labelConfiguration: TLabelConfiguration;
    printerConfiguration: TPrinterConfiguration;
    function translateOrientation(orientation: integer): integer;
  end;

implementation

{ TUnilabelZPL }

uses DLog;

procedure TUnilabelZPL.setConfiguration(configuration: TLabelConfiguration);
begin
  labelConfiguration := configuration;
end;

procedure TUnilabelZPL.setPrinterConfigurations(
  configuration: TPrinterConfiguration);
begin
  printerConfiguration := configuration;
end;

procedure TUnilabelZPL.setSpecificConfiguration(name, value: String);
begin
  //nones
end;

procedure TUnilabelZPL.addConfigurationCommands;
var
  widthInDots: integer;
begin
  commands.Add('');
  commands.Add('N');
  commands.Add('S2');
  widthInDots :=
    (labelConfiguration.width * labelConfiguration.columns + (labelConfiguration.horizontalGap * (labelConfiguration.columns-1))) * 8;
  commands.Add('q' + intToStr(widthInDots));
end;


procedure TUnilabelZPL.closePrinter;
begin

end;

constructor TUnilabelZPL.create;
begin
  commands := TStringList.Create;
end;

function TUnilabelZPL.initializePrinter: boolean;
begin
end;

procedure TUnilabelZPL.printBarcode(data: string; x, y: double;
  barcodeType: TUnilabelBarcodeFormats; height: double; narrowWidth,
  wideWidth: double; showReadable: Boolean; spin: integer);
var
  com: AnsiString;
  bcType, showReadableParam: AnsiString;
begin
  bcType := '1A';
  if showReadable then
    showReadableParam := 'B'
  else
    showReadableParam := 'N';
  com := 'B' + translatePositionParameter(x) + ',' +
    translateYParameter(y, height*8) + ',' +
    IntToStr(translateOrientation(spin)) + ',' + bcType + ',' + IntToStr(trunc(narrowWidth)) +
    ',' + IntToStr(trunc(wideWidth)) + ',' +
    translatePositionParameter(height) + ',' + showReadableParam + ',' +
    '"' + data + '"';
  commands.Add(com);
end;

procedure TUnilabelZPL.printBox(x, y, width, height, topThickness,
  sideThickness: double);
begin

end;

procedure TUnilabelZPL.printImage(path: string; x, y: double);
begin

end;

procedure TUnilabelZPL.startJob;
begin
  commands.Clear;
  addConfigurationCommands;
end;

procedure TUnilabelZPL.printOut;
begin
  commands.Add('P');
  commands.Add('');
  commands.Add('N');
end;

procedure TUnilabelZPL.finishJob;
var
  cmm, printerName: AnsiString;
  i: integer;
  deviceMode: NativeUint;
begin
  printerName := printerConfiguration.name;
  if printerName <> '' then
    Printer.PrinterIndex := Printer.Printers.IndexOf(printerName);
  Printer.BeginDoc;
  cmm := '00'; // reserve space for the initial `word`
  for i := 0 to commands.Count-1 do
    cmm := cmm + commands[i] + #10;
  pword(cmm)^ := length(cmm)-2; // store the length
  showMessage(String(cmm));
  if ExtEscape(Printer.Canvas.Handle, PASSTHROUGH, Length(cmm), pointer(cmm), 0, nil)<0 then
    raise Exception.Create('Error at printing to printer');
  commands.SaveToFile('lastCommands.txt');
  Printer.EndDoc;
end;

procedure TUnilabelZPL.printText(data: string; x, y: double; fontName: string;
  fontStyles: TFontStyles; fontSize: double; spin: integer);
var
  com: AnsiString;
  sizeParam: AnsiString;
  heightInDots: double;
begin
  data := Utf8ToAnsi(data);
  { Ax,y,rotation,font_selection,hor_mult,vert_mult,reversion,data  }
  sizeParam := intToStr(trunc(fontSize / 8));
  heightInDots := 16;
  com := 'A' + translatePositionParameter(x) + ',' +
    translateYParameter(y, heightInDots) + ',' +
    IntToStr(translateOrientation(spin)) + ',' + sizeParam + ',1,1,N' + ',' +
    '"' + data + '"';
  commands.Add(com);
end;

function TUnilabelZPL.translatePositionParameter(p: double): string;
begin
  //8 dots per milimeter
  result := formatFloat('0', p*8);
end;

function TUnilabelZPL.translateOrientation(orientation: integer): integer;
begin
  result := orientation - 1;
end;

function TUnilabelZPL.translateYParameter(y, heightInDots: double): string;
var
  totalHeightInDots, yInDots, position: integer;
begin
  totalHeightInDots := labelConfiguration.height * 8;
  yInDots := Trunc(y * 8);
  position := totalHeightInDots - yInDots - trunc(heightInDots);
  result := IntToStr(position);
end;



end.

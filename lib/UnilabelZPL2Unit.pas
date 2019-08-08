unit UnilabelZPL2Unit;

interface
uses UnilabelInterfaceUnit, vcl.Graphics, System.IOUtils, System.SysUtils, Windows,
  Vcl.StdCtrls, Vcl.Printers, classes, UnilabelTypesUnit,
  Winapi.winSpool, Vcl.Dialogs, vcl.clipbrd;
type
  TUnilabelZPL2 = class(TInterfacedObject, IUnilabel)
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
    function lineIncreaseFactor: integer;
  protected
    fsUSA: TFormatSettings;
    commands: TStringList;
    widthParam: string;
    labelConfiguration: TLabelConfiguration;
    printerConfiguration: TPrinterConfiguration;
    function translateOrientation(orientation: integer): string;
    function getFieldOriginParam(x,y: integer): string;
  end;

implementation

{ TUnilabelZPL2 }

uses DLog;

procedure TUnilabelZPL2.setConfiguration(configuration: TLabelConfiguration);
begin
  labelConfiguration := configuration;
end;

procedure TUnilabelZPL2.setPrinterConfigurations(
  configuration: TPrinterConfiguration);
begin
  printerConfiguration := configuration;
end;

procedure TUnilabelZPL2.setSpecificConfiguration(name, value: String);
begin
  //nones
end;

procedure TUnilabelZPL2.addConfigurationCommands;
var
  widthInMm: integer;
begin
  commands.Add('^XA');
  commands.Add('^CI28^FS');
  widthInMm :=
    (labelConfiguration.width * labelConfiguration.columns + (labelConfiguration.horizontalGap * (labelConfiguration.columns-1)));
  commands.Add('^MUm^PW' + intToStr(widthInMm) + '^FS');
end;


procedure TUnilabelZPL2.closePrinter;
begin

end;

constructor TUnilabelZPL2.create;
begin
  fsUSA.DecimalSeparator := '.';
  fsUSA.ThousandSeparator := #0;
  commands := TStringList.Create;
end;

function TUnilabelZPL2.initializePrinter: boolean;
begin
end;

function TUnilabelZPL2.lineIncreaseFactor: integer;
begin
  result := -1;
end;

procedure TUnilabelZPL2.printBarcode(data: string; x, y: double;
  barcodeType: TUnilabelBarcodeFormats; height: double; narrowWidth,
  wideWidth: double; showReadable: Boolean; spin: integer);
var
  com, barSizeCom: String;
  bcType, showReadableParam: String;
begin
  if showReadable then
    showReadableParam := 'Y'
  else
    showReadableParam := 'N';
  barSizeCom := '^BY' + formatFloat('0.00',narrowWidth, fsUSA) + ',' +
                        FormatFloat('0.0', wideWidth, fsUSA);

  com := getFieldOriginParam(Trunc(x),trunc(y)) + barSizeCom;

  if barCodeType = bcfCode128 then
  begin
    com := com + '^BC' +
      translateOrientation(spin) + ',' +
      translatePositionParameter(height) + ',' +
      showReadableParam + ',N,N';
  end;
  if barcodeType = bcfCode3of9 then
  begin
    com := com + '^B3' +
          translateOrientation(spin) + ',N' +
          translatePositionParameter(height) + ',' +
          showReadableParam + ',N';
  end;
  if barcodeType = bcfEAN13 then
  begin
    com := com + '^BE' +
      translateOrientation(spin) + ',' +
      translatePositionParameter(height) + ',' +
      showReadableParam + ',N';
  end;
  com := com + '^FD' + data + '^FS';
  commands.Add(com);
end;

procedure TUnilabelZPL2.printBox(x, y, width, height, topThickness,
  sideThickness: double);
begin

end;

procedure TUnilabelZPL2.printImage(path: string; x, y: double);
var
  com, imgContent: string;
  content: TStringList;
begin
  content := TStringList.Create;
  try
    content.LoadFromFile(path);
  finally
    imgContent := content.GetText;
    FreeAndNil(content);
  end;

  com := getFieldOriginParam(trunc(x),trunc(y));
  com := com + '^GF' + imgContent + '^FS';
  commands.add(com);
end;

procedure TUnilabelZPL2.startJob;
begin
  commands.Clear;
  addConfigurationCommands;
end;

procedure TUnilabelZPL2.printOut;
begin
  commands.Add('^XZ');
  commands.Add('^XA');
end;

procedure TUnilabelZPL2.finishJob;
var
  printerName: AnsiString;
  m: integer;
  deviceMode: NativeUint;
  docInfo: TDocInfo1W;
  memStream: TMemoryStream;
  buff : array [1..128] of char;
  N: DWord;
  handle: THandle;
  MyPrinter, MyDriver, MyPort: array[0..100] of Char;
begin
  //Preparar um doc para impressao
  docInfo.pDocName    := 'Etiquetas Unilabel';
  docInfo.pOutputFile := nil;
  docinfo.pDatatype   := 'RAW';
  //Obter e abrir a comunicaçao com a impressora
  printerName := printerConfiguration.name;
  if printerName <> '' then
    Printer.PrinterIndex := Printer.Printers.IndexOf(printerName);
  Printer.GetPrinter(MyPrinter, MyDriver, MyPort, handle);
  if not OpenPrinter(myPrinter, handle, nil) then
    MessageDlg('Erro ao abrir a impressora. ' + intToStr(getLastError), mtError, [mbOK], 0);
  //Iniciar o documento
  if StartDocPrinter(handle,1,@docInfo) = 0 then
    MessageDlg('Erro ao iniciar doc na impressora. Código: ' + intToStr(getLastError), mtError, [mbOK], 0);
  if not StartPagePrinter(handle) then
    MessageDlg('Erro ao iniciar página. Código: ' + intToStr(getLastError), mtError, [mbOK], 0);

  memStream := TMemoryStream.Create;
  try
    commands.SaveToStream(memStream);
    memStream.Position := 0;
    repeat
      m := memStream.Read(buff,sizeof(buff));
      if m = 0 then break;
      if not WritePrinter(handle,@buff[1],m,N) then
      begin
        showMessage('erro: ' + IntToStr(GetLastError));
      end;
    until m <> N;
    if not endPagePrinter(handle) then
      MessageDlg('Erro ao finalizar página. Código: ' + intToStr(getLastError), mtError, [mbOK], 0);
    if not endDocPrinter(handle) then
      MessageDlg('Erro ao finalizar doc na impressora. ' + intToStr(getLastError), mtError, [mbOK], 0);
  finally
    memStream.Free;
  end;
end;

function TUnilabelZPL2.getFieldOriginParam(x, y: integer): string;
begin
  //inicio todo comando com ^MUm para que tudo seja em mm
  result := '^MUm^FOa' + intToStr(x) + ',' + IntToStr(y);
end;

procedure TUnilabelZPL2.printText(data: string; x, y: double; fontName: string;
  fontStyles: TFontStyles; fontSize: double; spin: integer);
var
  com: String;
  sizeParam: String;
begin
  //data := Utf8ToAnsi(data);
  //^FO0,20^A0N,30,30^FDTeste de fonte zero uma linha bem grande para ver até onde vai essa coisa^FS
  sizeParam := intToStr(trunc(fontSize));
  com := getFieldOriginParam(trunc(x), trunc(y)) +
    '^A0' + translateOrientation(spin) + ',' + sizeParam + ',' + sizeParam +
    '^FD' + data + '^FS';
  commands.Add(com);
end;

function TUnilabelZPL2.translatePositionParameter(p: double): string;
begin
  //pure mm
  result := formatFloat('0', p, fsUSA);
end;

function TUnilabelZPL2.translateOrientation(orientation: integer): string;
begin
  result := 'N'; //TODO: prever outras orientações
end;

function TUnilabelZPL2.translateYParameter(y, heightInDots: double): string;
begin
  result := IntToStr(trunc(y));
end;



end.

unit UnilabelXMLEngineUnit;

interface

uses UnilabelInterfaceUnit, Xml.XMLDoc, Xml.Xmldom, Xml.Xmlintf,Vcl.Dialogs, MSXML2_TLB,
  ComObj, System.SysUtils, Vcl.Graphics;

type

TLabelConfiguration = record
  width: integer;
  height: integer;
  leftMargin: integer;
  rightMargin: integer;
  bottomMargin: integer;
  horizontalGap: integer;
  columns: integer;
end;

TUnilabelXMLEngine = class
public
  constructor Create(pPrintingObject: IUnilabel);
  destructor Destroy; override;
  procedure print(contents: string);
private
  printingObject: IUnilabel;
  labelConfiguration: TLabelConfiguration;
  currentColumn: integer;
  labelLayout: IXMLDOMNode;
  fsUSA: TFormatSettings;
  procedure parseConfigurations(xml: IXMLDomDocument2);
  function parseIntegerProperty(xml: IXMLDomDocument2;
    path: string; defaultValue: integer = 1): integer;
  procedure printLabels(xml: IXMLDomDocument2);
  function getCopiesFromLabelNode(node: IXMLDomNode): integer;
  procedure generateColumn(node: IXMLDomNode); overload;
  procedure generateColumns(node: IXMLDomNode; n: integer = 1); overload;
  procedure printOutLine(n: integer);
  procedure addParsedTextElement(p: IUnilabel;
    layoutNode, dataNode: IXMLDOMNode);
  procedure addParsedBarcodeElement(p: IUnilabel;
    layoutNode, dataNode: IXMLDOMNode);
  function getXOffset: integer;
  function getYOffset: integer;
  function parseBarcodeType(value: string): TUnilabelBarcodeFormats;
  property xOffset: integer read getXOffset;
  property yOffset: integer read getYOffset;
end;

implementation

{ TUnilabelXMLEngine }

constructor TUnilabelXMLEngine.Create(pPrintingObject: IUnilabel);
begin
  printingObject := pPrintingObject;
  printingObject.initializePrinter;
  fsUSA.DecimalSeparator := '.';
  fsUSA.ThousandSeparator := #0;
end;

destructor TUnilabelXMLEngine.Destroy;
begin
  printingObject.closePrinter;
end;

procedure TUnilabelXMLEngine.print(contents: string);
var
  xml: IXMLDomDocument2;
begin
  inherited;
  xml := CoDOMDocument60.Create;
  xml.loadXML(contents);
  parseConfigurations(xml);
  printLabels(xml);
end;

procedure TUnilabelXMLEngine.printLabels(xml: IXMLDomDocument2);
var
  nodes: IXMLDOMNodeList;
  i, j, n, numLinhas: integer;
begin
  nodes := xml.selectNodes('//record');
  labelLayout := xml.selectSingleNode('//configuration//layout');
  currentColumn := 1;
  nodes.reset;
  for i := 0 to nodes.length -1 do
  begin
    n := getCopiesFromLabelNode(nodes[i]);
    while (n > 0) and (currentColumn > 1) do
    begin
      generateColumns(nodes[i]);
      Dec(n);
    end;

    if n > 0 then
    begin
      if n > labelConfiguration.columns then
      begin
        numLinhas := (n div labelConfiguration.columns);
        for j := 1 to numLinhas do
          generateColumns(nodes[i], labelConfiguration.columns);
        if (n mod labelConfiguration.columns) > 0 then
          generateColumns(nodes[i], n mod labelConfiguration.columns);
      end
      else
      begin
        generateColumns(nodes[i], n);
      end;
    end;

  end;
  if currentColumn > 1 then
    printOutLine(1);
end;

procedure TUnilabelXMLEngine.printOutLine(n: integer);
begin
  printingObject.printOut;
end;

procedure TUnilabelXMLEngine.generateColumn(node: IXMLDomNode);
var
  elements: IXMLDomnodeList;
  i: integer;
  elType: string;
begin
  elements := labelLayout.selectNodes('element');
  for i := 0 to elements.length-1 do
  begin
    elType := elements.item[i].attributes.getNamedItem('type').nodeValue;
    if UpperCase(elType) = 'TEXT' then
      addParsedTextElement(printingObject, elements.item[i], node);
    if UpperCase(elType) = 'BARCODE' then
      addParsedBarcodeElement(printingObject, elements.item[i], node);
  end;
end;

procedure TUnilabelXMLEngine.addParsedBarcodeElement(p: IUnilabel;
  layoutNode, dataNode: IXMLDOMNode);
var
  fieldName, value: string;
  x, y, height: Double;
  narrow, wide: integer;
  barcodeType: TUnilabelBarcodeFormats;
begin
  fieldName := layoutNode.attributes.getNamedItem('field').nodeValue;
  value := dataNode.attributes.getNamedItem(fieldName).nodeValue;
  height := 6;
  narrow := 2;
  wide := 6;
  barcodeType := bcfCode128;
  if layoutNode.attributes.getNamedItem('barcode-type') <> nil then
    barcodeType := parseBarcodeType(layoutNode.attributes.getNamedItem('barcode-type').nodeValue);
  if layoutNode.attributes.getNamedItem('height') <> nil then
    height := StrToFloat(layoutNode.attributes.getNamedItem('height').nodeValue, fsUSA);
  if layoutNode.attributes.getNamedItem('narrow') <> nil then
    narrow := StrToInt(layoutNode.attributes.getNamedItem('narrow').nodeValue);
  if layoutNode.attributes.getNamedItem('wide') <> nil then
    wide := StrToInt(layoutNode.attributes.getNamedItem('wide').nodeValue);
  x := StrToFloat(layoutNode.attributes.getNamedItem('x').nodeValue, fsUSA) + xOffset;
  y := StrToFloat(layoutNode.attributes.getNamedItem('y').nodeValue, fsUSA) + yOffset;
  if barcodeType = bcfCode3of9 then
    value := UpperCase(value);
  printingObject.printBarcode(value,x,y,barcodeType,height,narrow,wide,false);
end;

function TUnilabelXMLEngine.parseBarcodeType(value: string): TUnilabelBarcodeFormats;
begin
  result := bcfCode128;
  if UpperCase(value) = 'CODE128' then
    result := bcfCode128; //redundant for the sake of readability
  if UpperCase(value) = 'CODE3OF9' then
    result := bcfCode3of9;
end;

procedure TUnilabelXMLEngine.addParsedTextElement(p: IUnilabel;
  layoutNode, dataNode: IXMLDOMNode);
var
  fs: TFontStyles;
  fieldName, fontName, value: string;
  x,y,fontSize: double;
begin
  fontName := 'Verdana';
  fontSize := 23;
  if layoutNode.attributes.getNamedItem('font-name') <> nil then
    fontName := layoutNode.attributes.getNamedItem('font-name').nodeValue;
  if layoutNode.attributes.getNamedItem('font-size') <> nil then
    fontSize := StrToFloat(layoutNode.attributes.getNamedItem('font-size').nodeValue, fsUSA);
  fieldName := layoutNode.attributes.getNamedItem('field').nodeValue;
  value := dataNode.attributes.getNamedItem(fieldName).nodeValue;
  x := StrToFloat(layoutNode.attributes.getNamedItem('x').nodeValue, fsUSA) + xOffset;
  y := StrToFloat(layoutNode.attributes.getNamedItem('y').nodeValue, fsUSA) + yOffset;
  printingObject.printText(value,x,y,fontName,fs,fontSize);
end;



procedure TUnilabelXMLEngine.generateColumns(node: IXMLDomNode; n: integer = 1);
var
  i: integer;
begin
  for i := 1 to n do
  begin
    generateColumn(node);
    inc(currentColumn);
    if currentColumn > labelConfiguration.columns then
    begin
      printOutLine(1);
      currentColumn := 1;
    end;
  end;
end;

function TUnilabelXMLEngine.getCopiesFromLabelNode(node: IXMLDomNode): integer;
var
  att: IXMLDomNode;
begin
  result := 1;
  att := node.attributes.getNamedItem('copies');
  if att <> nil then
  begin
    try
      result := StrToInt(att.text)
    except
      result := 1;
    end;
  end;
end;

function TUnilabelXMLEngine.getXOffset: integer;
begin
  result :=
    labelConfiguration.leftMargin +
    (currentColumn-1) * labelConfiguration.width +
    (currentColumn-1) * labelConfiguration.horizontalGap;
end;

function TUnilabelXMLEngine.getYOffset: integer;
begin
  result := labelConfiguration.bottomMargin;
end;

procedure TUnilabelXMLEngine.parseConfigurations(xml: IXMLDomDocument2);
begin
  labelConfiguration.width := parseIntegerProperty(xml,
    '//configuration//label-dimension//width');
  labelConfiguration.height := parseIntegerProperty(xml,
    '//configuration//label-dimension//height');
  labelConfiguration.leftMargin := parseIntegerProperty(xml,
    '//configuration//margin//left', 0);
  labelConfiguration.rightMargin := parseIntegerProperty(xml,
    '//configuration//margin//right', 0);
  labelConfiguration.bottomMargin := parseIntegerProperty(xml,
    '//configuration//margin//bottom', 0);
  labelConfiguration.horizontalGap := parseIntegerProperty(xml,
    '//configuration//margin//horizontal-gap', 0);
  labelConfiguration.columns := parseIntegerProperty(xml,
    '//configuration//columns', 1);
end;

function TUnilabelXMLEngine.parseIntegerProperty(xml: IXMLDomDocument2;
  path: string; defaultValue: integer = 1): integer;
var
  node: IXMLDOMNode;
begin
  result := defaultValue;
  node := xml.selectSingleNode(path);
  try
    if node <> nil then
      result := StrToInt(node.text);
  except
    result := defaultValue;
  end;
end;



end.

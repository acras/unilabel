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
  procedure parseConfigurations(xml: IXMLDomDocument2);
  function parseIntegerProperty(xml: IXMLDomDocument2;
    path: string; defaultValue: integer = 1): integer;
  procedure printLabels(xml: IXMLDomDocument2);
  function getCopiesFromLabelNode(node: IXMLDomNode): integer;
  procedure generateColumn(node: IXMLDomNode); overload;
  procedure generateColumns(node: IXMLDomNode; n: integer = 1); overload;
  procedure printOutLine(n: integer);
  procedure addParsedTextElement(p: IUnilabel; n: IXMLDOMNode);
  procedure addParsedBarcodeElement(p: IUnilabel; n: IXMLDOMNode);
  function getXOffset: integer;
  function getYOffset: integer;
  property xOffset: integer read getXOffset;
  property yOffset: integer read getYOffset;
end;

implementation

{ TUnilabelXMLEngine }

constructor TUnilabelXMLEngine.Create(pPrintingObject: IUnilabel);
begin
  printingObject := pPrintingObject;
  printingObject.initializePrinter;
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
  {printingObject.printText('Estopim - Blusa',2,30,'Verdana',[],28);
  printingObject.printText('09542',2,27,'Verdana',[],28);
  printingObject.printBarcode('09542',100,21,bcfCode128,6,2,6,false);
  //tag
  printingObject.printText('Estopim - Blusa',2,15,'Verdana',[],28);
  printingObject.printText('09542',2,12,'Verdana',[],28);
  printingObject.printBarcode('09542',2,6,bcfCode128,6,2,6,false);
  printingObject.printText('R$ 98,90',2,0,'Verdana',[],45);
  printingObject.printOut;
  exit;}
  nodes := xml.selectNodes('//labels//label');
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
  elements := node.selectNodes('element');
  for i := 0 to elements.length-1 do
  begin
    elType := elements.item[i].attributes.getNamedItem('type').nodeValue;
    if UpperCase(elType) = 'TEXT' then
      addParsedTextElement(printingObject, elements.item[i]);
    if UpperCase(elType) = 'BARCODE' then
      addParsedBarcodeElement(printingObject, elements.item[i]);
  end;
end;

procedure TUnilabelXMLEngine.addParsedBarcodeElement(p: IUnilabel;
  n: IXMLDOMNode);
var
  value: string;
  x, y, height, narrow, wide: integer;
begin
  value := n.attributes.getNamedItem('value').nodeValue;
  height := 6;
  narrow := 2;
  wide := 6;
  if n.attributes.getNamedItem('height') <> nil then
    height := strToInt(n.attributes.getNamedItem('height').nodeValue);
  if n.attributes.getNamedItem('narrow') <> nil then
    narrow := strToInt(n.attributes.getNamedItem('narrow').nodeValue);
  if n.attributes.getNamedItem('wide') <> nil then
    wide := strToInt(n.attributes.getNamedItem('wide').nodeValue);
  x := strToInt(n.attributes.getNamedItem('x').nodeValue) + xOffset;
  y := strToInt(n.attributes.getNamedItem('y').nodeValue) + yOffset;
  printingObject.printBarcode(value,x,y,bcfCode128,height,narrow,wide,false);
end;

procedure TUnilabelXMLEngine.addParsedTextElement(p: IUnilabel; n: IXMLDOMNode);
var
  fs: TFontStyles;
  fontName, value: string;
  x,y,fontSize: integer;
begin
  fontName := 'Verdana';
  fontSize := 23;
  if n.attributes.getNamedItem('font-name') <> nil then
    fontName := n.attributes.getNamedItem('font-name').nodeValue;
  if n.attributes.getNamedItem('font-size') <> nil then
    fontSize := strToInt(n.attributes.getNamedItem('font-size').nodeValue);
  value := n.attributes.getNamedItem('value').nodeValue;
  x := strToInt(n.attributes.getNamedItem('x').nodeValue) + xOffset;
  y := strToInt(n.attributes.getNamedItem('y').nodeValue) + yOffset;
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

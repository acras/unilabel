unit UnilabelXMLEngineUnit;

interface

uses UnilabelInterfaceUnit, Xml.XMLDoc, Xml.Xmldom, Vcl.Dialogs, MSXML2_TLB,
  ComObj, System.SysUtils;

type

TLabelConfiguration = record
  width: integer;
  height: integer;
  leftMargin: integer;
  rightMargin: integer;
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
    procedure generateColumn(node: IXMLDomNode; n: integer); overload;
    procedure printOutLine(n: integer);
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
  i, n: integer;
begin
  nodes := xml.selectNodes('//labels//label');
  currentColumn := 1;
  nodes.reset;
  for i := 0 to nodes.length -1 do
  begin
    n := getCopiesFromLabelNode(nodes[i]);
    while (n > 0) and (currentColumn > 1) do
    begin
      generateColumn(nodes[i]);
      Dec(n);
    end;
    if n > labelConfiguration.columns then
    begin
      generateColumn(nodes[i], labelConfiguration.columns);
      printOutLine(n div labelConfiguration.columns);
      if (n mod labelConfiguration.columns) > 0 then
        generateColumn(nodes[i], n mod labelConfiguration.columns);
    end
    else
    begin
      generateColumn(nodes[i], n);
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
begin
  printingObject.printText('oi teste', 10,10,'Verdana',[], 30);
end;

procedure TUnilabelXMLEngine.generateColumn(node: IXMLDomNode; n: integer);
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

procedure TUnilabelXMLEngine.parseConfigurations(xml: IXMLDomDocument2);
begin
  labelConfiguration.width := parseIntegerProperty(xml,
    '//configuration//label-dimension//width');
  labelConfiguration.height := parseIntegerProperty(xml,
    '//configuration//label-dimension//height');
  labelConfiguration.leftMargin := parseIntegerProperty(xml,
    '//configuration//margin//left-margin', 0);
  labelConfiguration.rightMargin := parseIntegerProperty(xml,
    '//configuration//margin//right-margin', 0);
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

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
  procedure parseConfigurations(xml: IXMLDomDocument2);
  function parseIntegerProperty(xml: IXMLDomDocument2;
    path: string; defaultValue: integer = 1): integer;
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

unit TestUnilabelXMLEngineUnit;

interface

uses
  TestFramework, System.SysUtils, Xml.Xmldom, UnilabelInterfaceUnit, Xml.XMLDoc,
  MSXML2_TLB, Vcl.Dialogs, ComObj, UnilabelXMLEngineUnit;

type
  // Test methods for class TUnilabelXMLEngine

  TestTUnilabelXMLEngine = class(TTestCase)
  strict private
    FUnilabelXMLEngine: TUnilabelXMLEngine;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Testprint;
  end;

implementation

procedure TestTUnilabelXMLEngine.SetUp;
begin
  //FUnilabelXMLEngine := TUnilabelXMLEngine.Create();
end;

procedure TestTUnilabelXMLEngine.TearDown;
begin
//  FUnilabelXMLEngine.Free;
//  FUnilabelXMLEngine := nil;
end;

procedure TestTUnilabelXMLEngine.Testprint;
var
  contents: string;
begin
  //FUnilabelXMLEngine.print(contents);
end;

initialization
  RegisterTest(TestTUnilabelXMLEngine.Suite);
end.


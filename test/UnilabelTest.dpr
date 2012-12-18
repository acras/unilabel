program UnilabelTest;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestUnilabelXMLEngineUnit in 'TestUnilabelXMLEngineUnit.pas',
  UnilabelXMLEngineUnit in '..\lib\UnilabelXMLEngineUnit.pas',
  UnilabelInterfaceUnit in '..\lib\UnilabelInterfaceUnit.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.


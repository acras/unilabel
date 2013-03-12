program UnilabelPrintingAgent;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {Form1},
  UnilabelInterfaceUnit in '..\lib\UnilabelInterfaceUnit.pas',
  UnilabelPPLAUnit in '..\lib\UnilabelPPLAUnit.pas',
  PPLADLLWrapper in '..\lib\libWrappers\PPLADLLWrapper.pas',
  UnilabelXMLEngineUnit in '..\lib\UnilabelXMLEngineUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Impressão de Etiquetas';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

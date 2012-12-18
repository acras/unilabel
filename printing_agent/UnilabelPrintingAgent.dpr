program UnilabelPrintingAgent;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {Form1},
  UnilabelInterfaceUnit in '..\lib\UnilabelInterfaceUnit.pas',
  UnilabelPPLAUnit in '..\lib\UnilabelPPLAUnit.pas',
  PPLADLLWrapper in '..\lib\libWrappers\PPLADLLWrapper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

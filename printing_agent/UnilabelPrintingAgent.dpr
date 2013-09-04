program UnilabelPrintingAgent;

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {Form1},
  UnilabelInterfaceUnit in '..\lib\UnilabelInterfaceUnit.pas',
  UnilabelPPLAUnit in '..\lib\UnilabelPPLAUnit.pas',
  PPLADLLWrapper in '..\lib\libWrappers\PPLADLLWrapper.pas',
  UnilabelXMLEngineUnit in '..\lib\UnilabelXMLEngineUnit.pas',
  UnilabelZPLUnit in '..\lib\UnilabelZPLUnit.pas',
  UnilabelTypesUnit in '..\lib\UnilabelTypesUnit.pas',
  DLog in 'F:\repositorio\DLog.pas' {DataLog: TDataModule},
  acStrUtils in 'F:\repositorio\acStrUtils.pas',
  acSysUtils in 'F:\repositorio\acSysUtils.pas',
  ConfiguracoesFormUn in 'ConfiguracoesFormUn.pas' {ConfiguracoesForm},
  unilabelConstantsUnit in 'unilabelConstantsUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Impressão de Etiquetas';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataLog, DataLog);
  Application.CreateForm(TConfiguracoesForm, ConfiguracoesForm);
  Application.Run;
end.

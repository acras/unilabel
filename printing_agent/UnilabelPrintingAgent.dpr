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
  DLog in 'E:\repositorio\DLog.pas' {DataLog: TDataModule},
  acStrUtils in 'E:\repositorio\acStrUtils.pas',
  acSysUtils in 'E:\repositorio\acSysUtils.pas',
  ConfiguracoesFormUn in 'ConfiguracoesFormUn.pas' {ConfiguracoesForm},
  unilabelConstantsUnit in 'unilabelConstantsUnit.pas',
  ISincronizacaoNotifierUnit in 'E:\hibrido_client\lib\ISincronizacaoNotifierUnit.pas',
  UnilabelZPL2Unit in '..\lib\UnilabelZPL2Unit.pas';

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

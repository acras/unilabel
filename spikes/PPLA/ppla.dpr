program ppla;

uses
  Forms,
  MainFormUn in 'MainFormUn.pas' {Form1},
  acStrUtils in '..\..\..\repositorio\acStrUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

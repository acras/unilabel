unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnImprimir: TButton;
    OpenDialog: TOpenDialog;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure printFile(fn: string);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UnilabelPPLAUnit, UnilabelInterfaceUnit, UnilabelXMLEngineUnit;

procedure TForm1.printFile(fn: string);
var
  ppla: TUnilabelPPLA;
  engine: TUnilabelXMLEngine;
  contents: TStringList;
begin
  ppla := TUnilabelPPLA.create;
  engine := TUnilabelXMLEngine.Create(ppla);
  contents := TStringList.Create;
  try
    contents.LoadFromFile(fn);
    engine.print(contents.GetText);
  finally
    FreeAndNil(engine);
    FreeAndNil(contents);
  end;
end;

procedure TForm1.btnImprimirClick(Sender: TObject);
begin
  with OpenDialog do
    if execute then
      printFile(FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if ParamStr(1) <> '' then
  begin
    printFile(ParamStr(1));
    application.Terminate;
  end;
end;

end.

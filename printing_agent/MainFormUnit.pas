unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Win.Registry,
  shellapi, ShlObj;

type
  TForm1 = class(TForm)
    btnImprimir: TButton;
    OpenDialog: TOpenDialog;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure printFile(fn: string);
    procedure associateFileType;
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
  associateFileType;
end;

procedure TForm1.associateFileType;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    if OpenKey('\Software\Classes\.unilabel', true) then
      WriteString('', 'UnilabelAppDoc');
    if OpenKey('\Software\Classes\UnilabelAppDoc', true) then
      WriteString('', 'Etiquetas Unilabel');
    if OpenKey('\Software\Classes\UnilabelAppDoc\shell\open\command', true) then
      WriteString('', application.ExeName + ' "%1"');
    SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, 0, 0);
  finally
    Free;
  end;
end;

end.

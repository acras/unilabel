unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses UnilabelPPLAUnit, UnilabelInterfaceUnit, UnilabelXMLEngineUnit;

procedure TForm1.Button1Click(Sender: TObject);
var
  ppla: TUnilabelPPLA;
  engine: TUnilabelXMLEngine;
begin
  ppla := TUnilabelPPLA.create;
  engine := TUnilabelXMLEngine.Create(ppla);
  engine.print(Memo1.Lines.GetText);
end;

end.

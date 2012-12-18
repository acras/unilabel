unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
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

uses UnilabelPPLAUnit;

procedure TForm1.Button1Click(Sender: TObject);
var
  ppla: TUnilabelPPLA;
begin
  ppla := TUnilabelPPLA.create;
  ppla.initializePrinter;
  ppla.printText('Ricardo Acras', 10, 10, 'Verdana', [fsBold], 40);
  ppla.printText('Ricardo Acras', 10, 50, 'Verdana', [fsItalic], 40);
  ppla.printText('Ricardo Acras', 10, 90, 'Verdana', [fsStrikeOut], 40);
  ppla.printOut;
end;

end.

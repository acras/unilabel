unit ConfiguracoesFormUn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Printers,
  System.IniFiles;

type
  TConfiguracoesForm = class(TForm)
    cboModelo: TComboBox;
    Label1: TLabel;
    cboPrinters: TComboBox;
    Label2: TLabel;
    btnSalvar: TButton;
    LinkLabel1: TLinkLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    Edit2: TEdit;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LinkLabel1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FIniFile: TIniFile;
    procedure setIniFile(const Value: TIniFile);
    procedure handleVisual;
  public
    property iniFile: TIniFile write setIniFile;
  end;


var
  ConfiguracoesForm: TConfiguracoesForm;

implementation

{$R *.dfm}

uses unilabelConstantsUnit;

procedure TConfiguracoesForm.btnSalvarClick(Sender: TObject);
begin
  FIniFile.WriteInteger('Printer', 'Model', cboModelo.ItemIndex);
  FIniFile.WriteString('Printer', 'Name', cboPrinters.Text);
  close;
end;

procedure TConfiguracoesForm.Button1Click(Sender: TObject);
var
  commands: TStringList;
  cmm, printerName: AnsiString;
  i: integer;
  //deviceMode: NativeUint;
begin
  commands := TStringList.create();
  commands.loadFromFile(edit1.Text);
  printerName := cboPrinters.Text;
  if printerName <> '' then
    Printer.PrinterIndex := Printer.Printers.IndexOf(printerName);
  Printer.BeginDoc;
  cmm := '00'; // reserve space for the initial `word`
  for i := 0 to commands.Count-1 do
    cmm := cmm + commands[i] + #10;
  if ExtEscape(Printer.Canvas.Handle, PASSTHROUGH, Length(cmm), pointer(cmm), 0, nil)<0 then
    raise Exception.Create('Error ao enviar comandos para a impressora');
  Printer.EndDoc;
end;

procedure TConfiguracoesForm.Button2Click(Sender: TObject);
var
  commands: TStringList;
  cmm, printerName: AnsiString;
  i: integer;
  deviceMode: NativeUint;
  prnfile,port:System.Text;
  buffer:String;
begin
  printerName := cboPrinters.Text;
  if printerName <> '' then
    Printer.PrinterIndex := Printer.Printers.IndexOf(printerName);
  try
    AssignFile(prnfile, Edit1.Text);
    Reset(prnfile);
    AssignPrn(port);
    Rewrite(port);
    while not eof(prnfile) do
      begin
        Readln(prnfile, buffer);
        showMessage(buffer);
        Writeln(port, buffer);
      end;
   finally
     CloseFile(port);
     CloseFile(prnfile);
   end;
end;



{tentativa por porta
procedure TConfiguracoesForm.Button2Click(Sender: TObject);
 var prnfile,port:System.Text;
 var buffer:String;
begin
  try
    AssignFile(prnfile, Edit1.Text);
    Reset(prnfile);
    AssignFile(port, edit2.text);
    Rewrite(port);

    while not eof(prnfile) do
      begin
        Readln(prnfile, buffer);
        Writeln(port, buffer);
      end;

   finally
     CloseFile(port);
     CloseFile(prnfile);
   end;
end;
}

procedure TConfiguracoesForm.FormCreate(Sender: TObject);
begin
  cboPrinters.Text := '';
  cboPrinters.Items.Assign(Printer.Printers);
end;

procedure TConfiguracoesForm.handleVisual;
begin
  cboPrinters.Enabled := cboModelo.ItemIndex in [1,2];
end;

procedure TConfiguracoesForm.LinkLabel1Click(Sender: TObject);
begin
  Close;
end;

procedure TConfiguracoesForm.setIniFile(const Value: TIniFile);
var
  nomeImpressora: string;
begin
  FIniFile := Value;
  cboModelo.ItemIndex := FIniFile.ReadInteger('Printer', 'Model', 0);
  nomeImpressora := FIniFile.ReadString('Printer', 'Name', '');
  cboPrinters.ItemIndex := cboPrinters.Items.IndexOf(nomeImpressora);
end;

end.

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
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LinkLabel1Click(Sender: TObject);
  private
    FIniFile: TIniFile;
    procedure setIniFile(const Value: TIniFile);
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

procedure TConfiguracoesForm.FormCreate(Sender: TObject);
begin
  cboPrinters.Text := '';
  cboPrinters.Items.Assign(Printer.Printers);
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

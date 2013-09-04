unit ConfiguracoesFormUn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.IniFiles;

type
  TConfiguracoesForm = class(TForm)
    cboModelo: TComboBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    btnSalvar: TButton;
    LinkLabel1: TLinkLabel;
    procedure btnSalvarClick(Sender: TObject);
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
  FIniFile.WriteInteger('Impressora', 'Modelo', cboModelo.ItemIndex);
end;

procedure TConfiguracoesForm.setIniFile(const Value: TIniFile);
begin
  FIniFile := Value;
  cboModelo.ItemIndex := FIniFile.ReadInteger('Impressora', 'Modelo', 0);
end;

end.

unit MainFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function inicializaImpressora(verbose: boolean = false): boolean;
  public
  end;

var
  Form1: TForm1;

implementation

uses acStrUtils;

{$R *.dfm}

    var dpCrLf : AnsiString = chr(13)+chr(10);
    var szSavePath : String = 'C:\users\acras\desktop\Argox';
    var szSaveFile : AnsiString = 'C:\users\acras\desktop\Argox\PPLA_Example.Prn';
    var sznop1     : AnsiString = 'nop_front' + Chr(13) + chr(10);
    var sznop2     : AnsiString = 'nop_middle' + Chr(13) + chr(10);
    function  A_Bar2d_Maxi(x:integer; y:integer; primary:integer; secondary:integer; country:integer;
              service:integer; mode:char; numeric:integer; data:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Bar2d_Maxi_Ori(x:integer; y:integer; ori:integer; primary:integer; secondary:integer;
              country:integer; service:integer; mode:char; numeric:integer; data:AnsiString):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Bar2d_PDF417(x:integer; y:integer; narrow:integer; width:integer; normal:char;
              security:integer; aspect:integer; row:integer; column:integer; mode:char;
              numeric:integer; data:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Bar2d_PDF417_Ori(x:integer; y:integer; ori:integer; narrow:integer; width:integer;
              normal:char; security:integer; aspect:integer; row:integer; column:integer; mode:char;
              numeric:integer; data:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Bar2d_DataMatrix(x:integer; y:integer; rotation:integer; hor_mul:integer;
              ver_mul:integer; ECC:integer; data_format:integer; num_rows:integer; num_col:integer;
              mode:char; numeric:integer; data:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    Procedure A_Clear_Memory();stdcall;external 'WINPPLA.DLL';
    Procedure A_ClosePrn();stdcall;external 'WINPPLA.DLL';
    function  A_CreatePrn(selection:integer; filename:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Del_Graphic(mem_mode:integer; graphic:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Draw_Box(mode:char; x:integer; y:integer; width:integer; height:integer; top:integer;
              side:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Draw_Line(mode:char; x:integer; y:integer; width:integer; height:integer):integer;
              stdcall;external 'WINPPLA.DLL';
    Procedure A_Feed_Label();stdcall;external 'WINPPLA.DLL';
    function  A_Get_DLL_Version(nShowMessage:integer):PAnsiChar;stdcall;external 'WINPPLA.DLL';
    function  A_Get_DLL_VersionA(nShowMessage:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Get_Graphic(x:integer; y:integer; mem_mode:integer; format:char; filename:AnsiString):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Get_Graphic_ColorBMP(x:integer; y:integer; mem_mode:integer; format:char;
              filename:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Get_Graphic_ColorBMPEx(x:integer; y:integer; nWidth:integer; nHeight:integer;
              rotate:integer; mem_mode:integer; format:char; id_name:AnsiString; filename:AnsiString):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Get_Graphic_ColorBMP_HBitmap(x:integer; y:integer; nWidth:integer; nHeight:integer;
              rotate:integer; mem_mode:integer; format:char; id_name:AnsiString; hbm:HBITMAP):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Initial_Setting(Type_Renamed:integer; Source:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_WriteData(IsImmediate:integer; pbuf:AnsiString; length:integer):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_ReadData(pbuf:PAnsiChar; length:integer; dwTimeoutms:integer):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Load_Graphic(x:integer; y:integer; graphic_name:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Open_ChineseFont(path:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Print_Form(width:integer; height:integer; copies:integer; amount:integer;
              form_name:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Print_Out(width:integer; height:integer; copies:integer; amount:integer):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Barcode(x:integer; y:integer; ori:integer; type_Renamed:char; narrow:integer;
              width:integer; height:integer; mode:char; numeric:integer; data:AnsiString):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Text(x:integer; y:integer; ori:integer; font:integer; type_Renamed:integer;
              hor_factor:integer; ver_factor:integer; mode:char; numeric:integer; data:AnsiString):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Text_Chinese(x:integer; y:integer; fonttype:integer; id_name:AnsiString; data:AnsiString;
              mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Text_TrueType(x:integer; y:integer; FSize:integer; FType:AnsiString; Fspin:integer;
              FWeight:integer; FItalic:integer; FUnline:integer; FStrikeOut:integer; id_name:AnsiString;
              data:AnsiString; mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Text_TrueType_W(x:integer; y:integer; FHeight:integer; FWidth:integer;
              FType:AnsiString; Fspin:integer; FWeight:integer; FItalic:integer; FUnline:integer;
              FStrikeOut:integer; id_name:AnsiString; data:AnsiString; mem_mode:integer):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Set_Backfeed(back:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_BMPSave(nSave:integer; pstrBMPFName:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Set_Cutting(cutting:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Darkness(heat:UINT):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_DebugDialog(nEnable:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Feed(rate:char):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Form(formfile:AnsiString; form_name:AnsiString; mem_mode:integer):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Set_Margin(position:integer; margin:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Prncomport(baud:integer; parity:integer; data:integer; stop:integer):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Set_Prncomport_PC(nBaudRate:integer; nByteSize:integer; nParity:integer;
              nStopBits:integer; nDsr:integer; nCts:integer; nXonXoff:integer):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Set_Sensor_Mode(type_Renamed:char; continuous:integer):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Set_Speed(speed:char):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Syssetting(transfer:integer; cut_peel:integer; length:integer; zero:integer;
              pause:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Unit(unit_Renamed:char):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Gap(gap:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_Logic(logic:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_ProcessDlg(nShow:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_LabelVer(centiInch:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_GetUSBBufferLen():integer;stdcall;external 'WINPPLA.DLL';
    function  A_EnumUSB(buf:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
    function  A_CreateUSBPort(nPort:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_CreatePort(nPortType:integer; nPort:integer; filename:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Clear_MemoryEx(nMode:integer):integer;stdcall;external 'WINPPLA.DLL';
    Procedure A_Set_Mirror();stdcall;external 'WINPPLA.DLL';
    function  A_Bar2d_RSS(x:integer; y:integer; ori:integer; ratio:integer; height:integer;
              rtype:char; mult:integer; seg:integer; data1:AnsiString; data2:AnsiString):integer;stdcall;
              external 'WINPPLA.DLL';
    function  A_Bar2d_QR_M(x:integer; y:integer; ori:integer; mult:char; value:integer; model:integer;
              error:char; mask:integer; dinput:char; mode:char; numeric:integer; data:AnsiString):integer;
              stdcall;external 'WINPPLA.DLL';
    function  A_Bar2d_QR_A(x:integer; y:integer; ori:integer; mult:char; value:integer; mode:char;
              numeric:integer; data:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_GetNetPrinterBufferLen():integer;stdcall;external 'WINPPLA.DLL';
    function  A_EnumNetPrinter(buf:PAnsiChar):integer;stdcall;external 'WINPPLA.DLL';
    function  A_CreateNetPort(nPort:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Text_TrueType_Uni(x:integer; y:integer; FSize:integer; FType:AnsiString; Fspin:integer;
              FWeight:integer; FItalic:integer; FUnline:integer; FStrikeOut:integer; id_name:AnsiString;
              data:PWideChar; format:integer; mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Prn_Text_TrueType_UniB(x:integer; y:integer; FSize:integer; FType:AnsiString; Fspin:integer;
              FWeight:integer; FItalic:integer; FUnline:integer; FStrikeOut:integer; id_name:AnsiString;
              data:PWideChar; format:integer ; mem_mode:integer):integer;stdcall;external 'WINPPLA.DLL';
    function  A_GetUSBDeviceInfo(nPort:integer; pDeviceName:PAnsiChar; pDeviceNameLen:PInteger;
              pDevicePath:PAnsiChar; pDevicePathLen:PInteger):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Set_EncryptionKey(encryptionKey:AnsiString):integer;stdcall;external 'WINPPLA.DLL';
    function  A_Check_EncryptionKey(decodeKey:AnsiString; encryptionKey:AnsiString;
              dwTimeoutms:integer):integer;stdcall;external 'WINPPLA.DLL';


function TForm1.inicializaImpressora(verbose: boolean = false): boolean;
var
  nLen, len1, len2: integer;
  strmsg: string;
  ret,sw : integer;
  pbuf : array[0..127] of AnsiChar;
  ver : PAnsiChar;
  buf1,buf2 : AnsiString;
begin
  nLen := A_GetUSBBufferLen() + 1;
  If nLen > 1 then
  begin
    len1 := 128;
    len2 := 128;
    SetLength(buf1,len1);
    SetLength(buf2,len2);
    A_EnumUSB(pbuf);
    A_GetUSBDeviceInfo(1, PAnsiChar(buf1), @len1, PAnsiChar(buf2), @len2);
    sw := 1;
    if 0 < sw then
      ret := A_CreatePrn(12, PAnsiChar(buf2)) // open usb.
    else
      ret := A_CreateUSBPort(1); // must call A_GetUSBBufferLen() function fisrt.
    if 0 < ret then
      strmsg := 'Open USB fail!'
    else
    begin
      SetLength(buf1,len1);
      SetLength(buf2,len2);
      strmsg := 'Open USB:' + dpCrLf+ 'Device name: ';
      strmsg := strmsg + buf1;
      strmsg := strmsg + dpCrLf+ 'Device path: ';
      strmsg := strmsg + buf2;
      //sw := 2;
      if 2 = sw then
      begin
        //get printer status.
        pbuf[0] := #$01;
        pbuf[1] := #$46;
        pbuf[2] := #$0D;
        pbuf[3] := #$0A;
        A_WriteData(1, pbuf, 4);   //<SOH>F
        ret := A_ReadData(pbuf, 2, 1000);
      end;
    end;
  end
  else
  begin
    CreateDirectory(PChar(szSavePath), nil);
    ret := A_CreatePrn(0, szSaveFile);   // open file.
    strmsg := 'Open ' + szSaveFile;
    if 0 < ret then
      strmsg := strmsg + ' file fail!'
    else
      strmsg := strmsg + ' file succeed!';
  end;
  result := ret <= 0;
  if verbose and not result then
    MessageDlg('Impressora não localizada.', mtError, [mbOK], 0);
end;



procedure TForm1.Button1Click(Sender: TObject);
var
  buff1 : array[0..127] of WideChar;
  himage : HBITMAP;
  i: integer;
  linha, nome, rua, numero, compl, cidade, bairro, cep: string;
begin
  if not inicializaImpressora(true) then exit;

  A_Set_DebugDialog(1);
  A_Set_Unit('m');
  A_Set_Syssetting(1, 0, 0, 0, 0);
  A_Del_Graphic(1, '*');
  A_Clear_Memory();

  for i := 0 to Memo1.Lines.Count-1 do
  begin
    linha := Memo1.Lines[i];
    nome := getStrField2(linha, ';', 2);
    rua := getStrField2(linha, ';', 3);
    numero := getStrField2(linha, ';', 4);
    compl := getStrField2(linha, ';', 5);
    rua := rua + ', ' + numero;
    bairro := getStrField2(linha, ';', 6);
    cep := 'CEP: ' + getStrField2(linha, ';', 7);
    cidade := getStrField2(linha, ';', 8);
    bairro := bairro + ' - ' + cidade + ' - PR';

//    A_Prn_Text_TrueType(25, 190, 25, 'Verdana', 1, 400, 0, 0, 0, 'AZ', 'REMETENTE:', 1);
    A_Prn_Text_TrueType(25, 190, 25, 'Verdana', 1, 400, 0, 0, 0, 'AA', nome, 1);
    A_Prn_Text_TrueType(25, 150, 25, 'Verdana', 1, 400, 0, 0, 0, 'AB', rua, 1);
    if compl <> '' then
      A_Prn_Text_TrueType(25, 110, 25, 'Verdana', 1, 400, 0, 0, 0, 'AC', compl, 1);
    A_Prn_Text_TrueType(25, 70, 25, 'Verdana', 1, 400, 0, 0, 0, 'AD', bairro, 1);
    A_Prn_Text_TrueType(400, 2, 25, 'Verdana', 1, 400, 0, 0, 0, 'AE', cep, 1);

    A_Print_Out(1, 1, 1, 1);
  end;
{  A_Prn_Barcode(2, 250, 1, 'e', 2, 5, 60, 'B', 1, 'OL0127');
  A_Prn_Barcode(2, 80, 1, 'e', 2, 5, 60, 'B', 1, 'OL0127');

  A_Get_Graphic_ColorBMP(170, 530, 1, 'B', 'bb.bmp');
  himage := LoadImage(0,'bb.bmp',IMAGE_BITMAP,0,0,LR_LOADFROMFILE);
  If 0 <> himage then
    DeleteObject(himage);}


  A_ClosePrn();
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  //button1.click;
  //close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  inicializaImpressora(true);
  A_ClosePrn();
end;

end.

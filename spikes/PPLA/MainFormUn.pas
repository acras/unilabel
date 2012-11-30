unit MainFormUn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    function inicializaImpressora: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

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


function TForm1.inicializaImpressora: boolean;
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
end;



procedure TForm1.Button1Click(Sender: TObject);
var
  buff1 : array[0..127] of WideChar;
  himage : HBITMAP;
begin
  if not inicializaImpressora then exit;
     // sample setting.
     A_Set_DebugDialog(1);
     A_Set_Unit('n');
     A_Set_Syssetting(1, 0, 0, 0, 0);
     A_Set_Darkness(10);
     A_Del_Graphic(1, '*');   // delete all picture.
     A_Clear_Memory();   // clear memory.
     A_WriteData(0, sznop2, StrLen(PAnsiChar(sznop2)));
     A_WriteData(1, sznop1, StrLen(PAnsiChar(sznop1)));

     // draw box.
     A_Draw_Box('A', 10, 10, 380, 280, 4, 4);
     A_Draw_Line('A', 200, 10, 4, 280);

     // print text, true type text.
     A_Prn_Text(20, 30, 1, 2, 0, 1, 1, 'N', 2, 'PPLA Lib Example');
     A_Prn_Text_TrueType(20, 60, 30, 'Arial', 1, 400, 0, 0, 0, 'AA', 'TrueType Font', 1);   // save in ram.
     A_Prn_Text_TrueType_W(20, 90, 20, 20, 'Times New Roman', 1, 400, 0, 0, 0, 'AB', 'TT_W: 多字元測試', 1);

     StringToWideChar('TT_Uni: 多字元測試', buff1, 128);  // Converts double-byte characters to UNICODE(wide characters).
     buff1[13] := #$0000;   // null.
     A_Prn_Text_TrueType_Uni(20, 120, 30, 'Times New Roman', 1, 400, 0, 0, 0, 'AC', buff1, 1, 1);   // UTF-16

     buff1[0] := #$FEFF;   // UTF-16.
     StringToWideChar('TT_UniB: 多字元測試', buff1+1, 128);  // Converts double-byte characters to UNICODE(wide characters).
     buff1[15] := #$0000;   // null.
     A_Prn_Text_TrueType_UniB(20, 150, 30, 'Times New Roman', 1, 400, 0, 0, 0, 'AD', buff1, 0, 1);   // Byte Order Mark.

     // barcode.
     A_Prn_Barcode(220, 60, 1, 'A', 0, 0, 20, 'B', 1, '1234');
     A_Bar2d_QR_A(220, 100, 1, '3', 10, 'N', 0, 'QR CODE');

     // picture.
     A_Get_Graphic_ColorBMP(220, 150, 1, 'B', 'bb.bmp');   // Color bmp file to ram.
//     A_Get_Graphic_ColorBMPEx(220, 170, 200, 150, 2, 1, 'B', 'bb1', 'bb.bmp');//180 angle.
//     himage := LoadImage(0,'bb.bmp',IMAGE_BITMAP,0,0,LR_LOADFROMFILE);
//     A_Get_Graphic_ColorBMP_HBitmap(300, 150, 250, 80, 1, 1, 'B', 'bb2', himage);//90 angle.
     If 0 <> himage then
         DeleteObject(himage);

     // output.
     A_Print_Out(1, 1, 1, 1);   // copy 2.

     // close port.
     A_ClosePrn();
end;

end.

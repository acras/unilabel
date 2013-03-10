unit UnilabelInterfaceUnit;

interface

uses
  Vcl.graphics;

type
  TUnilabelBarcodeFormats = (bcfCode128, bcfCode3of9);
  IUnilabel = Interface
    //Text Elements
    procedure printText(data: string; x,y: double; fontName: string;
      fontStyles: TFontStyles; fontSize: double);
    procedure printOrientedText(data: string; x,y: double; orientation: Integer;
      fontName: string; fontStyles: TFontStyles; fontSize: double);
    procedure printBarcode(data: string; x,y: double;
      barcodeType: TUnilabelBarcodeFormats;
      height: double; narrowWidth, wideWidth: integer;
      showReadable: boolean);
    procedure printOrientedBarcode(data: string; x,y: double; orientation: Integer;
      barcodeType: TUnilabelBarcodeFormats;
      height: double; narrowWidth, wideWidth: integer;
      showReadable: boolean);
    procedure printImage(path: string; x,y: double);
    procedure printBox(x,y,width,height,topThickness,sideThickness: double);


    //Flow Control
    function initializePrinter: boolean;
    procedure printOut;
    procedure closePrinter;
  End;

implementation

end.

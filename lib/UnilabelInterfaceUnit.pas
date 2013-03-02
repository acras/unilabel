unit UnilabelInterfaceUnit;

interface

uses
  Vcl.graphics;

type
  TUnilabelBarcodeFormats = (bcfCode128);
  IUnilabel = Interface
    //Text Elements
    procedure printText(data: string; x,y: Integer; fontName: string;
      fontStyles: TFontStyles; fontSize: Integer);
    procedure printOrientedText(data: string; x,y: Integer; orientation: Integer;
      fontName: string; fontStyles: TFontStyles; fontSize: Integer);
    procedure printBarcode(data: string; x,y: Integer;
      barcodeType: TUnilabelBarcodeFormats;
      height, narrowWidth, wideWidth: Integer;
      showReadable: boolean);
    procedure printOrientedBarcode(data: string; x,y: Integer; orientation: Integer;
      barcodeType: TUnilabelBarcodeFormats;
      height, narrowWidth, wideWidth: Integer;
      showReadable: boolean);
    procedure printImage(path: string; x,y: Integer);
    procedure printBox(x,y,width,height,topThickness,sideThickness: integer);


    //Flow Control
    function initializePrinter: boolean;
    procedure printOut;
    procedure closePrinter;
  End;

implementation

end.

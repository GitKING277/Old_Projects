unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, bass, XPMan, StdCtrls, ExtCtrls, jpeg, ComCtrls, Spin, Buttons,
  ImgList, FileCtrl;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    PB1: TPaintBox;
    PB2: TPaintBox;
    Tmr1: TTimer;
    XPManifest1: TXPManifest;
    pb3: TPaintBox;
    pb4: TPaintBox;
    pb5: TPaintBox;
    pb6: TPaintBox;
    pb7: TPaintBox;
    pb8: TPaintBox;
    pb9: TPaintBox;
    pb10: TPaintBox;
    label1: TLabel;
    VolumeBar: TTrackBar;
    SpinButton1: TSpinButton;
    ScrollBar1: TScrollBar;
    Panel1: TPanel;
    Panel2: TPanel;
    Memo2: TMemo;
    Memo1: TMemo;
    Timer1: TTimer;
    button3: TBitBtn;
    button2: TBitBtn;
    Button4: TBitBtn;
    Button1: TBitBtn;
    button5: TBitBtn;
    GreenButton: TBitBtn;
    BlueButton: TBitBtn;
    OrangeButton: TBitBtn;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    compact: TBitBtn;
    full: TBitBtn;
    pb11: TPaintBox;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Tmr1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure VolumeBarChange(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure GreenButtonClick(Sender: TObject);
    procedure BlueButtonClick(Sender: TObject);
    procedure OrangeButtonClick(Sender: TObject);
    procedure CompactClick(Sender: TObject);
    procedure FullClick(Sender: TObject);
//    procedure ScrollBar1KeyUp(Sender: TObject; var Key: Word;
   //   Shift: TShiftState);
  //  procedure scrollbar1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;     Channel: Hstream;     pcompact, track:boolean;  volume:extended;
  viscolor:integer;


implementation

{$R *.dfm}


procedure PlayerPlayFile (const FileName: String);

  var
   FFileName: PChar;


   begin


   If not FileExists(FileName) then exit; // proverka sushestvovaniya faila

   FFileName:=PChar(FileName);
   Bass_ChannelStop(Channel);


   If Channel <> 0 then begin
   Bass_ChannelStop(Channel);
   Bass_StreamFree(Channel);
   Channel:=0;

   


   end;

   Channel:=Bass_StreamCreateFile(False,FFileName,0,0,0);
   If Channel = 0 then begin
    MessageBox (0,'File loading ERROR',0, MB_OK or MB_IconStop);
    exit;
   end;

   If not (Bass_ChannelPlay(Channel,False)) then
    MessageBox (0,'File playing ERROR',0, MB_OK or MB_IconStop);


   end;





procedure TForm1.FormCreate(Sender: TObject);
begin
volumebar.Position:=100;
viscolor:=1;
form1.Height:=494; form1.width:=545; form1.Left:=414; form1.Top:=135;



if not bass_init(-1,44100,0,handle,nil) then
halt;    //Inicializacia modulya
end;

procedure TForm1.Button1Click(Sender: TObject);

begin

button2.Visible:=true;
button3.Visible:=false;
IF OpenDialog1.Execute then begin
  PlayerPlayFile(OpenDialog1.FileName);
  tmr1.Enabled:=true;
  ScrollBar1.Position:=0;
  ScrollBar1.Max:=BASS_ChannelGetLength(channel,0);
 BASS_ChannelSetAttribute(channel, BASS_ATTRIB_VOL, volume);
 button2.Enabled:=true; button4.enabled:=true;  button5.Enabled:=true;
label1.caption:='File name: '+extractFileName(OpenDialog1.FileName);
Image1.Visible:=false;
  end;


end;

procedure TForm1.Tmr1Timer(Sender: TObject);

var
L,L1,R,R1:integer;
Level: DWORD;

begin





if Bass_ChannelIsActive(Channel) <> Bass_Active_Playing then exit;



Level:=Bass_ChannelGetLevel(Channel);
L:=HiWord(Level);
R:=LoWord(Level);

pb1.Canvas.Brush.Color:=ClWhite;
pb1.Canvas.FillRect(pb1.Canvas.ClipRect);
pb2.Canvas.Brush.Color:=ClWhite;
pb2.Canvas.FillRect(pb2.Canvas.ClipRect);
pb3.Canvas.Brush.Color:=ClWhite;
pb3.Canvas.FillRect(pb3.Canvas.ClipRect);
pb4.Canvas.Brush.Color:=ClWhite;
pb4.Canvas.FillRect(pb4.Canvas.ClipRect);
pb5.Canvas.Brush.Color:=ClWhite;
pb5.Canvas.FillRect(pb5.Canvas.ClipRect);
pb6.Canvas.Brush.Color:=ClWhite;
pb6.Canvas.FillRect(pb6.Canvas.ClipRect);
pb7.Canvas.Brush.Color:=ClWhite;
pb7.Canvas.FillRect(pb7.Canvas.ClipRect);
pb8.Canvas.Brush.Color:=ClWhite;
pb8.Canvas.FillRect(pb8.Canvas.ClipRect);
pb9.Canvas.Brush.Color:=ClWhite;
pb9.Canvas.FillRect(pb7.Canvas.ClipRect);
pb10.Canvas.Brush.Color:=ClWhite;
pb10.Canvas.FillRect(pb8.Canvas.ClipRect);
pb11.Canvas.Brush.Color:=ClWhite;
pb11.Canvas.FillRect(pb8.Canvas.ClipRect);

L1:=Round(L/(32768/pb1.Height));
R1:=Round(R/(32768/pb2.Height));

if viscolor=1 then begin
pb1.Canvas.Brush.Color:=ClGreen;
pb2.Canvas.Brush.Color:=ClGreen;
pb3.Canvas.Brush.Color:=ClGreen;
pb4.Canvas.Brush.Color:=ClGreen;
pb5.Canvas.Brush.Color:=ClGreen;
pb6.Canvas.Brush.Color:=ClGreen;
pb7.Canvas.Brush.Color:=ClGreen;
pb8.Canvas.Brush.Color:=ClGreen;
pb9.Canvas.Brush.Color:=ClGreen;
pb10.Canvas.Brush.Color:=ClGreen;
pb11.Canvas.Brush.Color:=ClGreen;
end;

if viscolor=2 then begin
pb1.Canvas.Brush.Color:=Claqua;
pb2.Canvas.Brush.Color:=Claqua;
pb3.Canvas.Brush.Color:=Claqua;
pb4.Canvas.Brush.Color:=Claqua;
pb5.Canvas.Brush.Color:=Claqua;
pb6.Canvas.Brush.Color:=Claqua;
pb7.Canvas.Brush.Color:=Claqua;
pb8.Canvas.Brush.Color:=Claqua;
pb9.Canvas.Brush.Color:=Claqua;
pb10.Canvas.Brush.Color:=Claqua;
pb11.Canvas.Brush.Color:=Claqua;
end;

if viscolor=3 then begin
pb1.Canvas.Brush.Color:=Clyellow;
pb2.Canvas.Brush.Color:=Clyellow;
pb3.Canvas.Brush.Color:=Clyellow;
pb4.Canvas.Brush.Color:=Clyellow;
pb5.Canvas.Brush.Color:=Clyellow;
pb6.Canvas.Brush.Color:=Clyellow;
pb7.Canvas.Brush.Color:=Clyellow;
pb8.Canvas.Brush.Color:=Clyellow;
pb9.Canvas.Brush.Color:=Clyellow;
pb10.Canvas.Brush.Color:=Clyellow;
pb11.Canvas.Brush.Color:=Clyellow;
end;





pb1.Canvas.Rectangle(0,pb1.Height - L1,pb1.Width,pb1.Height);
pb2.Canvas.Rectangle(0,pb2.Height - R1,pb1.Width,pb2.Height);
pb3.Canvas.Rectangle(0,pb1.Height - L1,pb1.Width,pb1.Height);
pb4.Canvas.Rectangle(0,pb2.Height - R1,pb1.Width,pb2.Height);
pb5.Canvas.Rectangle(0,pb1.Height - L1,pb1.Width,pb1.Height);
pb6.Canvas.Rectangle(0,pb2.Height - R1,pb1.Width,pb2.Height);
pb7.Canvas.Rectangle(0,pb1.Height - L1,pb1.Width,pb1.Height);
pb8.Canvas.Rectangle(0,pb2.Height - R1,pb1.Width,pb2.Height);
pb9.Canvas.Rectangle(0,pb1.Height - L1,pb1.Width,pb1.Height);
pb10.Canvas.Rectangle(0,pb2.Height - R1,pb1.Width,pb2.Height);
pb11.Canvas.Rectangle(0,pb2.Height - L1,pb1.Width,pb2.Height);
           
//if track=true then
//ScrollBar1.Position:=BASS_ChannelgetPosition(channel, 0);





end;



procedure TForm1.Button2Click(Sender: TObject);
begin
BASS_ChannelPause(channel);
button2.Visible:=false;
button3.Visible:=true;



tmr1.Enabled:=false;


end;

procedure TForm1.Button3Click(Sender: TObject);
begin
tmr1.Enabled:=true;
BASS_ChannelPlay(channel,false);
button3.Visible:=false;
button2.Enabled:=true;
button2.Visible:=true;





end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//if Bass_ChannelIsActive(Channel) <> Bass_Active_Playing then exit;
if channel=0 then exit;



BASS_ChannelStop(channel);  //  Bass_StreamFree(Channel);


BASS_ChannelSetPosition(channel,0,0);

ScrollBar1.Position:=0;



button2.Visible:=false;
button3.Visible:=true;
 if channel=0 then exit;

tmr1.Enabled:=false;




pb1.Canvas.Brush.Color:=ClWhite;
pb1.Canvas.FillRect(pb1.Canvas.ClipRect);
pb2.Canvas.Brush.Color:=ClWhite;
pb2.Canvas.FillRect(pb2.Canvas.ClipRect);
pb3.Canvas.Brush.Color:=ClWhite;
pb3.Canvas.FillRect(pb1.Canvas.ClipRect);
pb4.Canvas.Brush.Color:=ClWhite;
pb4.Canvas.FillRect(pb2.Canvas.ClipRect);
pb5.Canvas.Brush.Color:=ClWhite;
pb5.Canvas.FillRect(pb1.Canvas.ClipRect);
pb6.Canvas.Brush.Color:=ClWhite;
pb6.Canvas.FillRect(pb2.Canvas.ClipRect);
pb7.Canvas.Brush.Color:=ClWhite;
pb7.Canvas.FillRect(pb1.Canvas.ClipRect);
pb8.Canvas.Brush.Color:=ClWhite;
pb8.Canvas.FillRect(pb2.Canvas.ClipRect);
pb9.Canvas.Brush.Color:=ClWhite;
pb9.Canvas.FillRect(pb1.Canvas.ClipRect);
pb10.Canvas.Brush.Color:=ClWhite;
pb10.Canvas.FillRect(pb2.Canvas.ClipRect);
pb11.Canvas.Brush.Color:=ClWhite;
pb11.Canvas.FillRect(pb2.Canvas.ClipRect);


pb1.Canvas.Rectangle(0,pb1.Height - 1,pb1.Width,pb1.Height);
pb2.Canvas.Rectangle(0,pb2.Height - 1,pb1.Width,pb2.Height);
pb3.Canvas.Rectangle(0,pb1.Height - 1,pb1.Width,pb3.Height);
pb4.Canvas.Rectangle(0,pb2.Height - 1,pb1.Width,pb4.Height);
pb5.Canvas.Rectangle(0,pb1.Height - 1,pb1.Width,pb5.Height);
pb6.Canvas.Rectangle(0,pb2.Height - 1,pb1.Width,pb6.Height);
pb7.Canvas.Rectangle(0,pb1.Height - 1,pb1.Width,pb7.Height);
pb8.Canvas.Rectangle(0,pb2.Height - 1,pb1.Width,pb8.Height);
pb9.Canvas.Rectangle(0,pb1.Height - 1,pb1.Width,pb9.Height);
pb10.Canvas.Rectangle(0,pb2.Height - 1,pb1.Width,pb10.Height);
pb11.Canvas.Rectangle(0,pb2.Height - 1,pb1.Width,pb10.Height);
if pcompact=false then else form1.Refresh;

end;

procedure TForm1.Button5Click(Sender: TObject);
var
filename:string;
begin
filename:=opendialog1.FileName;
showmessage(filename);
end;

procedure TForm1.ScrollBar1Scroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
if ScrollCode=scEndScroll then  begin
track:=false;
BASS_ChannelSetPosition(channel, ScrollBar1.Position, 0) end else track:=true;







end;







procedure TForm1.VolumeBarChange(Sender: TObject);

begin
//BASS_ChannelSetAttribute(channel, BASS_ATTRIB_VOL, 100);

 volume:= ((VolumeBar.Min + VolumeBar.Position) / 100);
 BASS_ChannelSetAttribute(channel, BASS_ATTRIB_VOL, volume);

end;

procedure TForm1.SpinButton1DownClick(Sender: TObject);
begin
volumebar.Position:=volumebar.Position-10;
end;

procedure TForm1.SpinButton1UpClick(Sender: TObject);
begin
volumebar.Position:=volumebar.Position+10;
end;








procedure TForm1.Timer1Timer(Sender: TObject);
begin


memo2.Text:=('Volume '+FloatToStr((Volume)*100)+'%');
ScrollBar1.Position:=BASS_ChannelgetPosition(channel, 0);

if pcompact=true then begin
image1.Visible:=false;
form1.Refresh;
button2.Refresh;
button3.Refresh;
Full.Refresh;
button4.Refresh;
tmr1.Enabled:=false;
form1.Refresh;
pb1.Visible:=false;
pb2.Visible:=false;
pb3.Visible:=false;pb4.Visible:=false;
pb5.Visible:=false;pb6.Visible:=false;pb7.Visible:=false;pb8.Visible:=false;
pb9.Visible:=false;pb10.Visible:=false end;
end;

procedure TForm1.GreenButtonClick(Sender: TObject);
begin
viscolor:=1;
button1.Glyph.Assign(nil);
ImageList1.GetBitmap(5, button1.Glyph);
button5.Glyph.Assign(nil);
ImageList1.GetBitmap(0, button5.Glyph);
Full.Glyph.Assign(nil);
ImageList3.GetBitmap(3, Full.Glyph);
Compact.Glyph.Assign(nil);
Imagelist3.GetBitmap(5, Compact.Glyph);
button2.Glyph.Assign(nil);
ImageList2.GetBitmap(8, button2.Glyph);
button3.Glyph.Assign(nil);
ImageList2.GetBitmap(1, button3.Glyph);
button4.Glyph.Assign(nil);
ImageList2.GetBitmap(0, Button4.Glyph);

memo1.Font.Color:=cllime;
memo2.Font.color:=cllime;
label1.Font.Color:=cllime;
end;

procedure TForm1.BlueButtonClick(Sender: TObject);
begin
viscolor:=2;
button1.Glyph.Assign(nil);
ImageList1.GetBitmap(1, button1.Glyph);
button5.Glyph.Assign(nil);
ImageList1.GetBitmap(2, button5.Glyph);
Full.Glyph.Assign(nil);
ImageList3.GetBitmap(2, Full.Glyph);
Compact.Glyph.Assign(nil);
Imagelist3.GetBitmap(1, Compact.Glyph);
button2.Glyph.Assign(nil);
ImageList2.GetBitmap(4, button2.Glyph);
button3.Glyph.Assign(nil);
ImageList2.GetBitmap(2, button3.Glyph);
button4.Glyph.Assign(nil);
ImageList2.GetBitmap(3, Button4.Glyph);

memo1.Font.Color:=claqua;
memo2.Font.color:=claqua;
label1.Font.Color:=claqua;
end;

procedure TForm1.OrangeButtonClick(Sender: TObject);
begin
viscolor:=3;
button1.Glyph.Assign(nil);
ImageList1.GetBitmap(3, button1.Glyph);
button5.Glyph.Assign(nil);
ImageList1.GetBitmap(4, button5.Glyph);
Full.Glyph.Assign(nil);
ImageList3.GetBitmap(0, Full.Glyph);
Compact.Glyph.Assign(nil);
Imagelist3.GetBitmap(4, Compact.Glyph);
button2.Glyph.Assign(nil);
ImageList2.GetBitmap(7, button2.Glyph);
button3.Glyph.Assign(nil);
ImageList2.GetBitmap(6, button3.Glyph);
button4.Glyph.Assign(nil);
ImageList2.GetBitmap(5, Button4.Glyph);

memo1.Font.Color:=clyellow;
memo2.Font.color:=clyellow;
label1.Font.Color:=clyellow;


//(pb1.Canvas.Brush.Color:=Clyellow;)
end;

procedure TForm1.CompactClick(Sender: TObject);
begin
pcompact:=true;


//tmr1.Enabled:=true;
tmr1.Enabled:=false;
 pb1.Visible:=false;
pb2.Visible:=false;
pb3.Visible:=false;pb4.Visible:=false;
pb5.Visible:=false;pb6.Visible:=false;pb7.Visible:=false;pb8.Visible:=false;
pb9.Visible:=false;pb10.Visible:=false;
form1.Refresh;

button1.Left:=8;button1.Top:=21;
button2.Left:=184;button2.Top:=21;button2.Height:=73;
button3.Left:=184;button3.Top:=21;button3.Height:=73;
button4.Left:=272;button4.Top:=21;button4.Height:=73;
full.Left:=360;full.Top:=21;
panel1.Visible:=false;scrollbar1.Visible:=false;memo1.Visible:=false;
panel2.Visible:=false;volumebar.Visible:=false;memo2.Visible:=false;
greenbutton.Visible:=false;bluebutton.Visible:=false;orangebutton.Visible:=false;
spinbutton1.Left:=536;spinbutton1.Top:=21;spinbutton1.Height:=73;spinbutton1.Width:=25;
compact.Visible:=false;full.Visible:=true;
button5.Visible:=false;

form1.Height:=125; form1.width:=575; form1.Left:=414; form1.Top:=135;



end;

procedure TForm1.FullClick(Sender: TObject);

begin
pcompact:=false;

tmr1.Enabled:=true;



button1.Left:=8;button1.Top:=296;
button2.Left:=8;button2.Top:=160;button2.Height:=129;
button3.Left:=8;button3.Top:=160;button3.Height:=129;
button4.Left:=448;button4.Top:=160;button4.Height:=129;
button5.Visible:=true;
panel1.Visible:=true;scrollbar1.Visible:=true;memo1.Visible:=true;
panel2.Visible:=true;volumebar.Visible:=true;memo2.Visible:=true;
greenbutton.Visible:=true;bluebutton.Visible:=true;orangebutton.Visible:=true;
spinbutton1.Left:=400;spinbutton1.Top:=232;spinbutton1.Height:=49;spinbutton1.Width:=33;
full.Visible:=false;compact.Visible:=true;
full.Left:=536;full.Top:=464;

form1.Height:=494; form1.width:=545; form1.Left:=414; form1.Top:=135;

if channel <> 0 then EXIT;
image1.Visible:=true;


end;

end.


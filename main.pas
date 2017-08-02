unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, EditBtn, LCLIntf, process, LCLTranslator, DefaultTranslator;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnContactUs: TBitBtn;
    btnClose: TBitBtn;
    btnUserGuide: TBitBtn;
    btnForums: TBitBtn;
    btnChatRoom: TBitBtn;
    btnCode: TBitBtn;
    btnDonate: TBitBtn;
    cbShowOnStartup: TCheckBox;
    imgLogo: TImage;
    imgBackground: TImage;
    imgTile: TImage;
    imgFacebook: TImage;
    imgTwitter: TImage;
    imgGithub: TImage;
    lblContactUs: TLabel;
    lblUserGuide: TLabel;
    lblForums: TLabel;
    lblChatRoom: TLabel;
    lblCode: TLabel;
    lblDonate: TLabel;
    lblTitle: TLabel;
    lblDescription: TLabel;
    PanelContent: TPanel;
    procedure btnChatRoomClick(Sender: TObject);
    procedure btnCodeClick(Sender: TObject);
    procedure btnContactUsClick(Sender: TObject);
    procedure btnDonateClick(Sender: TObject);
    procedure btnForumsClick(Sender: TObject);
    procedure btnUserGuideClick(Sender: TObject);
    procedure cbShowOnStartupChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgFacebookClick(Sender: TObject);
    procedure imgGithubClick(Sender: TObject);
    procedure imgTwitterClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses BidiUtils;

{$R *.lfm}

procedure TfrmMain.FormResize(Sender: TObject);
begin
  imgBackground.Picture.Clear;
  //TileImage(imgTile, imgBackground);
  imgBackground.Canvas.Brush.Bitmap := imgTile.Picture.Bitmap;
  imgBackground.Canvas.FillRect(imgBackground.BoundsRect);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin

  if FileExists(GetUserDir + '/.config/autostart/marhaba.desktop') then
    cbShowOnStartup.Checked := True
  else
    cbShowOnStartup.Checked := False;

  BiDiMode := GetBiDiMode;

  if BiDiMode = bdRightToLeft then
  begin
    FlipForm(Self);
    doFlipChildren;
    FlipPanelChilds(PanelContent);
    Self.Font.Name := 'Noto Kufi Arabic';
    lblTitle.Font.Name := 'Noto Kufi Arabic';
  end;

end;

procedure TfrmMain.btnUserGuideClick(Sender: TObject);
begin
  OpenURL('https://wahaproject.org/linux/documentation');
end;

procedure TfrmMain.cbShowOnStartupChange(Sender: TObject);
begin
  if cbShowOnStartup.Checked then
  begin
    if FileExists('/usr/share/applications/marhaba.desktop') then
      CopyFile('/usr/share/applications/marhaba.desktop', GetUserDir +
        '/.config/autostart/marhaba.desktop');
  end
  else
  begin
    if FileExists(GetUserDir + '/.config/autostart/marhaba.desktop') then
      DeleteFile(GetUserDir + '/.config/autostart/marhaba.desktop');
  end;
end;

procedure TfrmMain.btnContactUsClick(Sender: TObject);
begin
  OpenURL('https://wahaproject.org/linux/contact-us');
end;

procedure TfrmMain.btnDonateClick(Sender: TObject);
begin
  OpenURL('https://wahaproject.org/donate');
end;

procedure TfrmMain.btnChatRoomClick(Sender: TObject);
var
  aProcess: TProcess;
begin
  aProcess := TProcess.Create(nil);
  aProcess.Executable := 'xdg-open';
  aProcess.Parameters.Append('irc://chat.freenode.net/waha');
  aProcess.Execute;
  aProcess.Free;
end;

procedure TfrmMain.btnCodeClick(Sender: TObject);
begin
  OpenURL('https://github.com/wahaproject');
end;

procedure TfrmMain.btnForumsClick(Sender: TObject);
begin
  OpenURL('https://forums.wahaproject.org/');
end;

procedure TfrmMain.imgFacebookClick(Sender: TObject);
begin
  OpenURL('https://www.facebook.com/wahaproject');
end;

procedure TfrmMain.imgTwitterClick(Sender: TObject);
begin
  OpenURL('https://twitter.com/wahaproject');
end;

procedure TfrmMain.imgGithubClick(Sender: TObject);
begin
  OpenURL('https://github.com/wahaproject');
end;

end.

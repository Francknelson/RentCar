unit Atualizacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.MultiView, FMX.Layouts, FMX.Controls.Presentation,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TForm7 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    LayoutAtt: TLayout;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    RoundRect1: TRoundRect;
    Label3: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RoundRect1Click(Sender: TObject);
  private
    { Private declarations }
    versao_app, versao_server: string;
    procedure OnFinishUpdate(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}

uses UOpenURL;

procedure TForm7.FormCreate(Sender: TObject);
begin
  versao_app := '1.0';
  versao_server := '0.0';
end;

procedure TForm7.FormShow(Sender: TObject);
var
    t: TThread;
begin
  t := TThread.CreateAnonymousThread(
  procedure
  var
    JsonObj: TJSONObject;
    begin
    sleep(2000);
    try
      RESTRequest1.Execute;
    except
      on ex: Exception do
      begin
        raise Exception.Create('Erro ao acessar do servidor' + ex.Message);
        exit
      end;
    end;
    try
      JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes
      (RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

      versao_server :=TJSONObject(JsonObj).GetValue('versao').Value;
    finally
      JsonObj.disposeof;
    end;
  end);
  t.OnTerminate := OnFinishUpdate;
  t.Start;

end;

procedure TForm7.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    showmessage(Exception(TThread(Sender).FatalException).Message);
    exit;
  end;

  if versao_app < versao_server then
  begin
    LayoutAtt.Visible := True;
  end;
end;

procedure TForm7.RoundRect1Click(Sender: TObject);
var
  url: string;
begin
{$IFDEF ANDROID}
  url := 'https://drive.google.com/drive/folders/1qC125UzAHDJc7IFwul0jywMPscOSlfOx?usp=share_link';
{$ELSE}
  url := 'https://drive.google.com/drive/folders/1qC125UzAHDJc7IFwul0jywMPscOSlfOx?usp=share_link';
{$ENDIF}
  OpenURL(url, False);
  Application.Terminate;
end;

end.

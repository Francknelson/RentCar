unit Viagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.MultiView, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  REST.Types, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON,
  System.Sensors, System.Sensors.Components, FMX.Maps, System.Permissions;

type
  TForm4 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Button1: TButton;
    Image1: TImage;
    Layout3: TLayout;
    MultiView1: TMultiView;
    StyleBook1: TStyleBook;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image2: TImage;
    Layout4: TLayout;
    Layout5: TLayout;
    Label5: TLabel;
    campo_origem: TEdit;
    Label6: TLabel;
    campo_destino: TEdit;
    RoundRect1: TRoundRect;
    Label7: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    label_distancia: TLabel;
    label_duracao: TLabel;
    LocationSensor1: TLocationSensor;
    Mapa: TMapView;
    Switch1: TSwitch;
    Label8: TLabel;
    a: TLabel;
    b: TLabel;
    procedure RoundRect1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure Switch1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses database
{$IFDEF ANDROID}
  , Androidapi.Helpers, Androidapi.JNI.JavaTypes, Androidapi.JNI.Os
{$ENDIF}
    ;
{$R *.fmx}

procedure TForm4.FormCreate(Sender: TObject);
begin
  Mapa.MapType := TMapType.Normal;
end;

procedure TForm4.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);

var
  MyMarker: TMapMarkerDescriptor;
  posicao: TMapCoordinate;

begin
  Mapa.Location := TMapCoordinate.Create(NewLocation.Latitude, NewLocation.Longitude);

  posicao.Latitude := NewLocation.Latitude;
  posicao.Longitude := NewLocation.Longitude;
  MyMarker :=  TMapMarkerDescriptor.Create(posicao, 'Estou aqui!');
  MyMarker.Draggable := true;
  MyMarker.Visible := true;
  MyMarker.Snippet := 'EU';
  Mapa.AddMarker(MyMarker);

  a.Text := NewLocation.Latitude.ToString.Replace(',', '.');
  b.Text := NewLocation.Longitude.ToString.Replace(',', '.');
end;

procedure TForm4.RoundRect1Click(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource := 'json?origins={origem}&destinations={destino}&mode=driving&language=pt-BR&key=AIzaSyCF3asSuxAcmXmQckP_M8ERqvlT9zzXGqY';
  RESTRequest1.Params.AddUrlSegment('origem', campo_origem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', campo_destino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    ShowMessage('Ocorreu um erro ao calcular a viagem.');
    exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JsonValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  label_distancia.Text := 'Distância: ' + distancia_str;
  label_duracao.Text := 'Duração: ' + duracao_str;

end;

procedure TForm4.Switch1Click(Sender: TObject);
{$IFDEF ANDROID}
  var
    APermissaoGPS: string;
{$ENDIF}
begin
  {$IFDEF ANDROID}
    APermissaoGPS := JStringToString(TJManifest_permission.JavaClass.ACCESS_FINE_LOCATION);
    PermissionsService.RequestPermissions([APermissaoGPS],

      procedure(const APermissions: TArray<string>; const AGrantResults: TArray<TPermissionStatus>)
      begin
        if (Length(AGrantResults) = 1 ) and (AGrantResults[0] = TPermissionStatus.Granted) then
          LocationSensor1.Active := True
        else
          LocationSensor1.Active := False
      end);
  {$ENDIF}
end;

end.

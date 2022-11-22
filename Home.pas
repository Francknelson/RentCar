unit Home;

interface

uses
   System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Layouts, FMX.MultiView,IOUtils,
  FMX.TabControl;

type
  TForm3 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    ListaVeiculos: TVertScrollBox;
    Image1: TImage;
    MultiView1: TMultiView;
    Layout3: TLayout;
    Button1: TButton;
    StyleBook1: TStyleBook;
    Image2: TImage;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Rectangle2: TRectangle;
    Label2: TLabel;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Rectangle4: TRectangle;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetVeiculo;
    procedure CarregarListaVeiculos(id: integer; marca, modelo, placa,
                                    combustivel: string;
                                    tanque: integer);
    procedure AddViagem(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}

uses database, Viagem, Cadastro_ful, Login, Atualizacao;

{ TForm3 }

procedure TForm3.AddViagem;
begin
   if not Assigned(Form4) then
      Application.CreateForm(TForm4, Form4);
    Form4.Show;
end;

procedure TForm3.CarregarListaVeiculos(id: integer; marca, modelo,
  placa, combustivel: string; tanque: integer);
var
  rect, rect_barra: TRectangle;
  rect_icone: TCircle;
  lbl: TLabel;
  img: TImage;
  i, valorEstrela: integer;
  btn: TButton;
begin

  // fundo
  rect := TRectangle.Create(ListaVeiculos);
  with rect do
  begin
    Align := TAlignLayout.Top;
    Height := 150;
    Fill.Color := $FF000000;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFFFFFFF;
    Margins.Top := 10;
    Margins.Left := 10;
    Margins.Right := 10;
    XRadius := 8;
    YRadius := 8;
  end;

  // Barra inferior...
  rect_barra := TRectangle.Create(rect);
  with rect_barra do
  begin
    Align := TAlignLayout.Bottom;
    Height := 45;
    Fill.Color := $FFF4F4F4;
    Stroke.Kind := TBrushKind.Solid;
    Stroke.Color := $FFD4D5D7;
    Sides := [TSide.Left, TSide.Bottom, TSide.Right];
    XRadius := 8;
    YRadius := 8;
    Corners := [TCorner.BottomLeft, TCorner.BottomRight];
    HitTest := False;
    rect.AddObject(rect_barra);
  end;

   //Botao add item
  btn := TButton.Create(rect_barra);
  with btn do
  begin
    Name := 'btnViagem' + IntToStr(id);
    StyleLookup := 'buttonstyle';
    Text := 'Calcular viagem';
    Fill.Color := $FF000000;
    Position.x := 70;
    Position.y := 110;
    Height := 35;
    Width := 250;
    TagString := IntToStr(id);
    OnClick := AddViagem;
    rect.AddObject(btn);
  end;

  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFFFFFFF;
    Text := marca + '' + modelo;
    font.Size := 20;
    font.Style := [TFontStyle.fsBold];
    Position.x := 210;
    Position.Y := 10;
    Width := 200;
    rect.AddObject(lbl);
  end;

  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
      TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFFFFFFF;
    Text := 'Placa: ' + placa ;
    font.Size := 20;
    font.Style := [TFontStyle.fsBold];
    Position.x := 210;
    Position.Y := 30;
    Width := 200;
    rect.AddObject(lbl);
  end;

  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
    TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFFFFFFF;
    Text := 'Comb.: ' + combustivel;
    font.Size := 20;
    font.Style := [TFontStyle.fsBold];
    Position.x := 210;
    Position.Y := 50;
    Width := 200;
    rect.AddObject(lbl);
  end;

  lbl := TLabel.Create(rect);
  with lbl do
  begin
    StyledSettings := StyledSettings - [TStyledSetting.Size,
    TStyledSetting.FontColor, TStyledSetting.Style];
    TextSettings.FontColor := $FFFFFFFF;
    Text := 'Tanque: ' + IntToStr(tanque)+ ' Litros';
    font.Size := 20;
    font.Style := [TFontStyle.fsBold];
    Position.x := 210;
    Position.Y := 70;
    Width := 250;
    rect.AddObject(lbl);
  end;

  ListaVeiculos.AddObject(rect);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  GetVeiculo;
end;

procedure TForm3.GetVeiculo;
begin
  DM.FDQueryVeiculo.Close;
  DM.FDQueryVeiculo.Open();
  while not DM.FDQueryVeiculo.Eof do
  begin
    CarregarListaVeiculos(DM.FDQueryVeiculoid.AsInteger,
                          DM.FDQueryVeiculomarca.AsString,
                          DM.FDQueryVeiculomodelo.AsString,
                          DM.FDQueryVeiculoplaca.AsString,
                          DM.FDQueryVeiculocombustivel.AsString,
                          DM.FDQueryVeiculotanque.AsInteger
                          );
    DM.FDQueryVeiculo.Next;
  end;

end;

procedure TForm3.Rectangle1Click(Sender: TObject);
begin
  if not Assigned(Form6) then
      Application.CreateForm(TForm6, Form6);
    Form6.Show;
end;

procedure TForm3.Rectangle3Click(Sender: TObject);
begin
  if not Assigned(Form7) then
      Application.CreateForm(TForm7, Form7);
    Form7.Show;
end;

procedure TForm3.Rectangle4Click(Sender: TObject);
begin
 Form1.Show();
 Form1.campo_email.Text := EmptyStr;
 Form1.campo_senha.Text := EmptyStr;
end;

end.

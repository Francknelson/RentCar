program RentCar;

uses
  System.StartUpCopy,
  FMX.Forms,
  Login in 'Login.pas' {Form1},
  database in 'database.pas' {DM: TDataModule},
  Cadastro in 'Cadastro.pas' {Form2},
  Home in 'Home.pas' {Form3},
  Viagem in 'Viagem.pas' {Form4},
  Perfil in 'Perfil.pas' {Form5},
  Cadastro_ful in 'Cadastro_ful.pas' {Form6},
  Atualizacao in 'Atualizacao.pas' {Form7},
  UOpenURL in 'UOpenURL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.

unit Login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, idHashSHA;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    Image1: TImage;
    Layout3: TLayout;
    Email: TLabel;
    campo_email: TEdit;
    Senha: TLabel;
    campo_senha: TEdit;
    RoundRect1: TRoundRect;
    Entrar: TLabel;
    Label1: TLabel;
    procedure RoundRect1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function SHA1FromString(const AString: string): string;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses database, Cadastro, Home;

procedure TForm1.Label1Click(Sender: TObject);
begin
  if not Assigned(Form2) then
      Application.CreateForm(TForm2, Form2);
    Form2.Show;
end;

procedure TForm1.RoundRect1Click(Sender: TObject);
var
  senha: string;
begin
  senha := SHA1FromString(campo_senha.Text);

  DM.FDQueryPessoa.Close;
  DM.FDQueryPessoa.ParamByName('pemail').AsString := campo_email.Text;
  DM.FDQueryPessoa.Open();

  if not (DM.FDQueryPessoa.IsEmpty) and (senha = DM.FDQueryPessoasenha.AsString) then
  begin
    if not Assigned(Form3) then
      Application.CreateForm(TForm3, Form3);
    Form3.Show;
  end
  else
  begin
    ShowMessage('Login ou senha não confere');
  end;
end;

function TForm1.SHA1FromString(const AString: string): string;
var
  SHA1: TIdHashSHA1;
begin
  SHA1 := TIdHashSHA1.Create;
  try
    Result := SHA1.HashStringAsHex(AString);
  finally
    SHA1.Free;
  end;

end;

end.

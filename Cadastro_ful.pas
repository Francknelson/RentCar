unit Cadastro_ful;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TForm6 = class(TForm)
    Layout1: TLayout;
    Layout3: TLayout;
    Email: TLabel;
    campo_email: TEdit;
    Senha: TLabel;
    campo_senha: TEdit;
    RoundRect1: TRoundRect;
    Salvar: TLabel;
    Label1: TLabel;
    campo_sobrenome: TEdit;
    Label2: TLabel;
    campo_nome: TEdit;
    Layout2: TLayout;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure RoundRect1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetUsuario;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.fmx}

uses database, Login;

procedure TForm6.FormCreate(Sender: TObject);
begin
  GetUsuario;
end;

procedure TForm6.GetUsuario;
begin
  ShowMessage( Login.Form1.campo_email.Text);
  DM.FDQueryPessoa.Locate('email', Login.Form1.campo_email.Text, []);
  campo_nome.Text := DM.FDQueryPessoanome.AsString;
  campo_sobrenome.Text := DM.FDQueryPessoasobrenome.AsString;
  campo_email.Text :=  DM.FDQueryPessoaemail.AsString;
  campo_senha.Text := DM.FDQueryPessoasenha.AsString;
end;

procedure TForm6.RoundRect1Click(Sender: TObject);
begin
  DM.FDQueryPessoa.Edit;
  DM.FDQueryPessoanome.AsString := campo_nome.Text;
  DM.FDQueryPessoasobrenome.AsString := campo_sobrenome.Text;
  DM.FDQueryPessoaemail.AsString := campo_email.Text;
  DM.FDQueryPessoasenha.AsString := campo_senha.Text;
  DM.FDQueryPessoa.Post;
  Form6.Close;
end;

end.

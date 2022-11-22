unit Cadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Layout3: TLayout;
    Email: TLabel;
    campo_email: TEdit;
    Senha: TLabel;
    campo_senha: TEdit;
    RoundRect1: TRoundRect;
    Entrar: TLabel;
    Layout2: TLayout;
    Image1: TImage;
    Label1: TLabel;
    campo_sobrenome: TEdit;
    Label2: TLabel;
    campo_nome: TEdit;
    procedure RoundRect1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses database, Login;

procedure TForm2.RoundRect1Click(Sender: TObject);
begin
  DM.FDQueryPessoa.Close;
  DM.FDQueryPessoa.ParamByName('pemail').AsString := campo_email.Text;
  DM.FDQueryPessoa.Open();

  if(campo_nome.Text = EmptyStr) or (campo_sobrenome.Text = EmptyStr)
  or (campo_email.Text = EmptyStr) or (campo_senha.Text = EmptyStr) then
  Abort;

  if not (DM.FDQueryPessoa.IsEmpty) then
  begin
    ShowMessage('E-mail já cadastrado!');
  end
  else
  begin

  DM.FDQueryPessoa.Append;
  DM.FDQueryPessoanome.AsString := campo_nome.Text;
  DM.FDQueryPessoasobrenome.AsString := campo_sobrenome.Text;
  DM.FDQueryPessoaemail.AsString := campo_email.Text;
  DM.FDQueryPessoasenha.AsString := Form1.SHA1FromString(campo_senha.Text);
  DM.FDQueryPessoa.Post;
  DM.FDConnection1.CommitRetaining;

  Form1.Show();
  end;
end;

end.

unit database;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, IOUtils;

type
  TDM = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQueryPessoa: TFDQuery;
    FDQueryPessoaid: TFDAutoIncField;
    FDQueryPessoanome: TStringField;
    FDQueryPessoasobrenome: TStringField;
    FDQueryPessoacpf: TStringField;
    FDQueryPessoacelular: TStringField;
    FDQueryPessoacep: TStringField;
    FDQueryPessoaendereco: TStringField;
    FDQueryPessoacidade: TStringField;
    FDQueryPessoauf: TStringField;
    FDQueryPessoabairro: TStringField;
    FDQueryPessoaemail: TStringField;
    FDQueryPessoasenha: TStringField;
    FDQueryPessoaimg_usuario: TBlobField;
    FDQueryVeiculo: TFDQuery;
    FDQueryVeiculoid: TFDAutoIncField;
    FDQueryVeiculomarca: TStringField;
    FDQueryVeiculomodelo: TStringField;
    FDQueryVeiculoplaca: TStringField;
    FDQueryVeiculotanque: TIntegerField;
    FDQueryVeiculocombustivel: TStringField;
    FDQueryVeiculoimg_veiculo: TBlobField;
    FDQueryViagem: TFDQuery;
    FDQueryViagemid: TFDAutoIncField;
    FDQueryViagemorigem: TStringField;
    FDQueryViagemdestino: TStringField;
    FDQueryViagemorigem_latitude: TStringField;
    FDQueryViagemorigem_longitude: TStringField;
    FDQueryViagemdestino_latitude: TStringField;
    FDQueryViagemdestino_longitude: TStringField;
    FDQueryViagemvalor: TFloatField;
    FDQueryViagemveiculo_id: TIntegerField;
    procedure FDConnection1AfterConnect(Sender: TObject);
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDM.FDConnection1AfterConnect(Sender: TObject);
var
  strSQL: string;
begin
    strSQL := 'create table IF NOT EXISTS pessoa( 		      ' + //
            'id integer not null primary key autoincrement, ' + //
            'nome varchar(40),                              ' + //
            'sobrenome varchar(40),                         ' + //
            'cpf varchar(11),                               ' + //
            'celular varchar(13),                           ' + //
            'cep varchar(10),                               ' + //
            'endereco varchar(60),                          ' + //
            'cidade varchar(60),                            ' + //
            'uf char(2),                                    ' + //
            'bairro varchar(60),                            ' + //
            'email varchar(60),                             ' + //
            'senha varchar(40),                             ' + //
            'img_usuario blob)';
  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := ' create table IF NOT EXISTS veiculo(             ' + //
            ' id integer not null primary key autoincrement,  ' + //
            ' marca varchar(40),                              ' + //
            ' modelo varchar(40),                             ' + //
            ' placa varchar(10),                              ' + //
            ' tanque integer,                                 ' + //
            ' combustivel varchar(20),                        ' + //
            ' img_veiculo blob) ';

  FDConnection1.ExecSQL(strSQL);

  strSQL := EmptyStr;
  strSQL := ' create table IF NOT EXISTS viagem(              ' + //
            ' id integer not null primary key autoincrement,  ' + //
            ' origem varchar(200),                            ' + //
            ' destino varchar(200),                           ' + //
            ' origem_latitude varchar(100),                   ' + //
            ' origem_longitude varchar(100),                  ' + //
            ' destino_latitude varchar(100),                  ' + //
            ' destino_longitude varchar(100),                 ' + //
            ' valor float,                                    ' + //
            ' veiculo_id integer,                             ' + //
            ' foreign key (veiculo_id) references veiculo(id) ) ';

  FDConnection1.ExecSQL(strSQL);

  FDQueryPessoa.Active := true;
  FDQueryVeiculo.Active := true;
  FDQueryViagem.Active := true;

end;

procedure TDM.FDConnection1BeforeConnect(Sender: TObject);
var
  strPath: string;
begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
  strPath := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath,
  'rc_db.db');
{$ENDIF}
{$IFDEF MSWINDOWS}
  strPath := System.IOUtils.TPath.Combine('C:\Users\franc\OneDrive\Documentos\Embarcadero\Studio\Projects', 'rc_db.db');
{$ENDIF}
  FDConnection1.Params.Values['UseUnicode'] := 'False';
  FDConnection1.Params.Values['DATABASE'] := strPath;

end;

end.

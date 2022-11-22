object DM: TDM
  OldCreateOrder = False
  Height = 452
  Width = 516
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\franc\OneDrive\Documentos\Embarcadero\Studio\P' +
        'rojects\rc_db.db'
      'DriverID=SQLite')
    Connected = True
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 24
    Top = 16
  end
  object FDQueryPessoa: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM pessoa'
      'WHERE email = :pemail')
    Left = 104
    Top = 16
    ParamData = <
      item
        Name = 'PEMAIL'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryPessoaid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryPessoanome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 40
    end
    object FDQueryPessoasobrenome: TStringField
      FieldName = 'sobrenome'
      Origin = 'sobrenome'
      Size = 40
    end
    object FDQueryPessoacpf: TStringField
      FieldName = 'cpf'
      Origin = 'cpf'
      Size = 11
    end
    object FDQueryPessoacelular: TStringField
      FieldName = 'celular'
      Origin = 'celular'
      Size = 13
    end
    object FDQueryPessoacep: TStringField
      FieldName = 'cep'
      Origin = 'cep'
      Size = 10
    end
    object FDQueryPessoaendereco: TStringField
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 60
    end
    object FDQueryPessoacidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Size = 60
    end
    object FDQueryPessoauf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      FixedChar = True
      Size = 2
    end
    object FDQueryPessoabairro: TStringField
      FieldName = 'bairro'
      Origin = 'bairro'
      Size = 60
    end
    object FDQueryPessoaemail: TStringField
      FieldName = 'email'
      Origin = 'email'
      Size = 60
    end
    object FDQueryPessoasenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 40
    end
    object FDQueryPessoaimg_usuario: TBlobField
      FieldName = 'img_usuario'
      Origin = 'img_usuario'
    end
  end
  object FDQueryVeiculo: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM veiculo')
    Left = 184
    Top = 16
    object FDQueryVeiculoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryVeiculomarca: TStringField
      FieldName = 'marca'
      Origin = 'marca'
      Size = 40
    end
    object FDQueryVeiculomodelo: TStringField
      FieldName = 'modelo'
      Origin = 'modelo'
      Size = 40
    end
    object FDQueryVeiculoplaca: TStringField
      FieldName = 'placa'
      Origin = 'placa'
      Size = 10
    end
    object FDQueryVeiculotanque: TIntegerField
      FieldName = 'tanque'
      Origin = 'tanque'
    end
    object FDQueryVeiculocombustivel: TStringField
      FieldName = 'combustivel'
      Origin = 'combustivel'
    end
    object FDQueryVeiculoimg_veiculo: TBlobField
      FieldName = 'img_veiculo'
      Origin = 'img_veiculo'
    end
  end
  object FDQueryViagem: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM viagem')
    Left = 264
    Top = 16
    object FDQueryViagemid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object FDQueryViagemorigem: TStringField
      FieldName = 'origem'
      Origin = 'origem'
      Size = 200
    end
    object FDQueryViagemdestino: TStringField
      FieldName = 'destino'
      Origin = 'destino'
      Size = 200
    end
    object FDQueryViagemorigem_latitude: TStringField
      FieldName = 'origem_latitude'
      Origin = 'origem_latitude'
      Size = 100
    end
    object FDQueryViagemorigem_longitude: TStringField
      FieldName = 'origem_longitude'
      Origin = 'origem_longitude'
      Size = 100
    end
    object FDQueryViagemdestino_latitude: TStringField
      FieldName = 'destino_latitude'
      Origin = 'destino_latitude'
      Size = 100
    end
    object FDQueryViagemdestino_longitude: TStringField
      FieldName = 'destino_longitude'
      Origin = 'destino_longitude'
      Size = 100
    end
    object FDQueryViagemvalor: TFloatField
      FieldName = 'valor'
      Origin = 'valor'
    end
    object FDQueryViagemveiculo_id: TIntegerField
      FieldName = 'veiculo_id'
      Origin = 'veiculo_id'
    end
  end
end

object dmGerenciador: TdmGerenciador
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 224
  Width = 374
  object fdConnection: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\noteLucas\Documents\Embarcadero\Studio\Project' +
        's\Win32\Debug\GerenciadorDB.db'
      'DriverID=SQLite')
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale, fvDataSnapCompatibility]
    FormatOptions.MaxBcdPrecision = 22
    FormatOptions.MaxBcdScale = 22
    FormatOptions.DataSnapCompatibility = True
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object fdqProximoCodigo: TFDQuery
    Connection = fdConnection
    SQL.Strings = (
      'SELECT'
      '  COALESCE('
      '    (SELECT'
      '      MAX(CODIGO) + 1 '
      '    FROM'
      '      LOGDOWNLOAD)'
      '    , 1) AS CODIGO')
    Left = 200
    Top = 88
    object fdqProximoCodigoCODIGO: TLargeintField
      FieldName = 'CODIGO'
    end
  end
  object fdqLogDownload: TFDQuery
    CachedUpdates = True
    Connection = fdConnection
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereAll
    UpdateOptions.KeyFields = 'CODIGO'
    SQL.Strings = (
      'SELECT'
      '  CODIGO,'
      '  URL,'
      '  DATAINICIO,'
      '  DATAFIM'
      'FROM'
      '  LOGDOWNLOAD'
      'WHERE'
      '  CODIGO = :CODIGO')
    Left = 32
    Top = 88
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqLogDownloadCODIGO: TFMTBCDField
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object fdqLogDownloadURL: TStringField
      FieldName = 'URL'
      Origin = 'URL'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 600
    end
    object fdqLogDownloadDATAINICIO: TDateField
      FieldName = 'DATAINICIO'
      Origin = 'DATAINICIO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object fdqLogDownloadDATAFIM: TDateField
      FieldName = 'DATAFIM'
      Origin = 'DATAFIM'
      ProviderFlags = [pfInUpdate]
    end
  end
  object fdqHistorico: TFDQuery
    CachedUpdates = True
    Connection = fdConnection
    SQL.Strings = (
      'SELECT'
      '  CODIGO,'
      '  URL,'
      '  DATAINICIO,'
      '  DATAFIM'
      'FROM'
      '  LOGDOWNLOAD'
      'ORDER BY'
      '  CODIGO DESC')
    Left = 112
    Top = 88
    object FMTBCDField1: TFMTBCDField
      FieldName = 'CODIGO'
    end
    object StringField1: TStringField
      FieldName = 'URL'
      Origin = 'URL'
      Required = True
      Size = 600
    end
    object DateField1: TDateField
      FieldName = 'DATAINICIO'
      Origin = 'DATAINICIO'
      Required = True
    end
    object DateField2: TDateField
      FieldName = 'DATAFIM'
      Origin = 'DATAFIM'
    end
  end
  object dsHistorico: TDataSource
    DataSet = fdqHistorico
    Left = 112
    Top = 144
  end
  object fdqCriaTabela: TFDQuery
    Connection = fdConnection
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS LOGDOWNLOAD('
      '  CODIGO NUMBER(22,0) NOT NULL,'
      '  URL VARCHAR2(600) NOT NULL,'
      '  DATAINICIO DATE NOT NULL,'
      '  DATAFIM DATE,'
      '  CONSTRAINT PK_LOGDOWNLOAD PRIMARY KEY (CODIGO)'
      ')')
    Left = 296
    Top = 88
  end
end

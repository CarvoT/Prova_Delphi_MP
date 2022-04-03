unit dmdGerenciador;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DbxSqlite, Data.DB,
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdmGerenciador = class(TDataModule)
    fdConnection: TFDConnection;
    fdqProximoCodigo: TFDQuery;
    fdqProximoCodigoCODIGO: TLargeintField;
    fdqLogDownload: TFDQuery;
    fdqLogDownloadURL: TStringField;
    fdqLogDownloadDATAINICIO: TDateField;
    fdqLogDownloadDATAFIM: TDateField;
    fdqLogDownloadCODIGO: TFMTBCDField;
    fdqHistorico: TFDQuery;
    FMTBCDField1: TFMTBCDField;
    StringField1: TStringField;
    DateField1: TDateField;
    DateField2: TDateField;
    dsHistorico: TDataSource;
    fdqCriaTabela: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function ProximoCodigoLogDownload: integer;
    procedure CriarTabelaLog;
  public
    { Public declarations }
    function GravarLogInicio(sUrl: string): Integer;
    procedure GravarLogFim(iCodigo: Integer);
    procedure AbrirLogs;
    procedure AbrirHistorico;
  end;

var
  dmGerenciador: TdmGerenciador;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmGerenciador.AbrirHistorico;
begin
  fdqHistorico.Close;
  fdqHistorico.Open;
end;

procedure TdmGerenciador.AbrirLogs;
begin
  fdqLogDownload.Close;
  fdqLogDownload.MacroByName('WHERE').AsString := EmptyStr;
  fdqLogDownload.Open;
end;

procedure TdmGerenciador.CriarTabelaLog;
begin
  fdqCriaTabela.ExecSQL;
end;

procedure TdmGerenciador.DataModuleCreate(Sender: TObject);
begin
  FDConnection.Params.Database := 'GerenciadorDB.db';
  FDConnection.Open;

  CriarTabelaLog;
end;

procedure TdmGerenciador.GravarLogFim(iCodigo: Integer);
begin
  fdqLogDownload.Close;
  fdqLogDownload.ParamByName('CODIGO').AsInteger := iCodigo;
  fdqLogDownload.Open;

  if fdqLogDownload.IsEmpty then
    raise Exception.Create('Erro ao atualizar log de download. Registro informado não localizado.');

  fdqLogDownload.Edit;
  fdqLogDownloadDATAFIM.AsDateTime := Date;
  fdqLogDownload.Post;
  fdqLogDownload.ApplyUpdates(0);
end;

function TdmGerenciador.GravarLogInicio(sUrl: string): Integer;
var
  iCodigo: integer;
begin
  iCodigo := ProximoCodigoLogDownload;

  fdqLogDownload.Close;
  fdqLogDownload.ParamByName('CODIGO').AsInteger := iCodigo;
  fdqLogDownload.Open;

  fdqLogDownload.Insert;
  fdqLogDownloadCODIGO.AsInteger := iCodigo;
  fdqLogDownloadURL.AsString := sUrl;
  fdqLogDownloadDATAINICIO.AsDateTime := Date;
  fdqLogDownload.Post;

  fdqLogDownload.ApplyUpdates(0);

  Result := iCodigo;
end;

function TdmGerenciador.ProximoCodigoLogDownload: integer;
begin
  Result := 1;

  fdqProximoCodigo.Close;
  fdqProximoCodigo.Open;
  if not fdqProximoCodigo.IsEmpty then
    Result := fdqProximoCodigoCODIGO.AsInteger;
end;



end.

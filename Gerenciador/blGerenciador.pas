unit blGerenciador;

interface

uses
  IdHTTP, System.Classes, IdSSLOpenSSL, dmdGerenciador, IdComponent,
  System.Threading, System.Types, System.Generics.Collections, System.SysUtils;

type
  TProgresso = record
    Posicao: integer;
    Maximo: integer;
    Concluido: boolean;
    Excecao: string;
  end;

  IObserver = interface
    procedure Atualizar(Progresso: TProgresso);
  end;

  TpEstadoAtualizar = (tpAguardando = 0, tpAtualizando = 1, tpRemovendo = 2);

  TDownload = class(TThread)
  private
    http: TIdHTTP;
    FurlDownload: string;
    FnomeArquivo: string;
    FCodigoDownload: Integer;
    FGerenciadorDM: TdmGerenciador;

    FCancelar: boolean;

    FListaObservers: TList<IObserver>;
    FrProgresso: TProgresso;

    procedure InicializarRecordProgresso;
    procedure ConfigurarComponenteHttp;

    procedure InicioDownload(ASender: TObject; AWorkMode: TWorkMode;AWorkCountMax: Int64);
    procedure Progresso(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);

    procedure IniciarDownload;
  protected
    procedure Atualizar;
  public
    constructor Create;
    property urlDownload: string read FurlDownload write FurlDownload;
    property nomeArquivo: string read FnomeArquivo write FnomeArquivo;

    procedure CancelarDownload;

    procedure AdicionarObserver(oObserver: IObserver);
    procedure RemoverObserver(oObserver: IObserver);

    destructor Destroy; override;

    procedure Execute; override;

  end;

implementation

{ TDownload }

procedure TDownload.AdicionarObserver(oObserver: IObserver);
begin
  if FListaObservers.IndexOf(oObserver) = -1 then
    FListaObservers.Add(oObserver);
end;

procedure TDownload.Atualizar;
var
  Observer: IObserver;
begin
  for Observer in FListaObservers do
    if Assigned(Observer) then
      Observer.Atualizar(FrProgresso);
end;

procedure TDownload.RemoverObserver(oObserver: IObserver);
begin
  FListaObservers.Remove(oObserver);
end;

procedure TDownload.CancelarDownload;
begin
  FCancelar := true;
end;

procedure TDownload.ConfigurarComponenteHttp;
var
  handler: TIdSSLIOHandlerSocketOpenSSL;
begin
  http := TIdHTTP.Create;
  handler := TIdSSLIOHandlerSocketOpenSSL.Create;
  handler.SSLOptions.Method := sslvSSLv23;
  handler.SSLOptions.Mode := sslmClient;
  handler.SSLOptions.SSLVersions := [sslvTLSv1_2, sslvTLSv1_1, sslvTLSv1];

  http.OnWorkBegin := InicioDownload;
  http.OnWork := Progresso;

  http.IOHandler := handler;
  http.HandleRedirects := true;
  http.RedirectMaximum := 35;
end;

constructor TDownload.Create;
begin
  inherited Create(True);

  FListaObservers := TList<IObserver>.Create;
  ConfigurarComponenteHttp;
  FGerenciadorDM := dmGerenciador;
  InicializarRecordProgresso;
end;

destructor TDownload.destroy;
begin
  http.Free;
  inherited;
end;

procedure TDownload.Execute;
begin
  inherited;
  IniciarDownload;
end;

procedure TDownload.InicializarRecordProgresso;
begin
  FrProgresso.Posicao := 0;
  FrProgresso.Maximo := 100;
  FrProgresso.Concluido := False;
  FrProgresso.Excecao := '';
end;

procedure TDownload.IniciarDownload;
var
  stream: TMemoryStream;
begin
  FrProgresso.Concluido := False;
  FCancelar := False;
  FCodigoDownload := FGerenciadorDM.GravarLogInicio(FurlDownload);

  stream := TMemoryStream.Create;

  try
    try
      http.Get(FurlDownload, stream);
      stream.SaveToFile(FnomeArquivo);

      FGerenciadorDM.GravarLogFim(FCodigoDownload)
    except
      on e:Exception do
      begin
        if not FCancelar then
        begin
          if Pos('UNKNOWN PROTOCOL', UpperCase(e.message)) > 0 then
            FrProgresso.Excecao := 'Url inválida'
          else if http.ResponseCode = 404 then
            FrProgresso.Excecao := 'Arquivo não encontrado.'
          else
            FrProgresso.Excecao := e.Message;
        end;
      end;
    end;
  finally
    stream.Free;
  end;

  FrProgresso.Concluido := True;
  Atualizar;
end;

procedure TDownload.InicioDownload(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  FrProgresso.Maximo := AWorkCountMax;
  Atualizar;
end;

procedure TDownload.Progresso(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  FrProgresso.Posicao:= AWorkCount;

  if FCancelar then
    http.Disconnect;

  Atualizar;
end;



end.


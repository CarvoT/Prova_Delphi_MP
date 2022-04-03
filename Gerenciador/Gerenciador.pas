unit Gerenciador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, blGerenciador,
  Vcl.ComCtrls, Vcl.ExtCtrls, dlgHistorico;

type
  tpEstado = (eAguardando = 0, eBaixando = 1);

  TfrmGerenciadorDownload = class(TForm, IObserver)
    sdArquivo: TSaveDialog;
    pnlPrincipal: TPanel;
    edtUrlDownload: TEdit;
    btnExibirHistorico: TButton;
    btnExibirMensagem: TButton;
    btnDownload: TButton;
    pbDownload: TProgressBar;
    lblUrl: TLabel;
    procedure btnDownloadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnExibirHistoricoClick(Sender: TObject);
    procedure btnExibirMensagemClick(Sender: TObject);
  private
    { Private declarations }
    FEstado: tpEstado;
    FoDownload: TDownload;
    procedure ConfiguraComponentes;
    procedure ConfiguraSaveDialog;
    procedure setEstado(eEstado: tpEstado);
    procedure IniciarDownload;
    procedure PararDownload;
    procedure ExibirInformacoes;
    procedure ExibirHistorico;
    procedure ValidarCampos;

    function ExtrairNomeArquivo: string;
    function ExtrairExtensao: string;

    procedure Atualizar(Progresso: TProgresso);

  public
    { Public declarations }
  end;

var
  frmGerenciadorDownload: TfrmGerenciadorDownload;

implementation

{$R *.dfm}

procedure TfrmGerenciadorDownload.Atualizar(Progresso: TProgresso);
begin
  pbDownload.Max := Progresso.Maximo;
  pbDownload.Position := Progresso.Posicao;

  if Progresso.Concluido then
    setEstado(eAguardando);

  if Progresso.Excecao <> EmptyStr then
    Application.MessageBox(Pchar('Ocorreu um erro ao realizar o download.' + #13#10 +
      'Mensagem original: ' + Progresso.Excecao), 'Erro', MB_OK + MB_ICONERROR);
end;

procedure TfrmGerenciadorDownload.btnDownloadClick(Sender: TObject);
begin
  if FEstado = eAguardando then
  begin
    ValidarCampos;
    ConfiguraSaveDialog;
    IniciarDownload;
  end
  else
  begin
    setEstado(eAguardando);
    PararDownload;
  end;
end;

procedure TfrmGerenciadorDownload.btnExibirHistoricoClick(Sender: TObject);
begin
  ExibirHistorico;
end;

procedure TfrmGerenciadorDownload.btnExibirMensagemClick(Sender: TObject);
begin
  ExibirInformacoes;
end;

procedure TfrmGerenciadorDownload.ConfiguraComponentes;
begin
  if FEstado = eAguardando then
  begin
    btnDownload.Caption := 'Iniciar Download';
    edtUrlDownload.ReadOnly := False;
    btnExibirMensagem.Enabled := False;
    pbDownload.Position := 0;
  end
  else
  begin
    btnDownload.Caption := 'Parar Download';
    edtUrlDownload.ReadOnly := True;
    btnExibirMensagem.Enabled := True;
  end;
end;

procedure TfrmGerenciadorDownload.ConfiguraSaveDialog;
var
  sExtensao: string;
begin
  sdArquivo.FileName := ExtrairNomeArquivo;
  sExtensao := ExtrairExtensao;
  sdArquivo.Filter := sExtensao + ' (*.' + sExtensao+ ')|*.' + sExtensao;
  sdArquivo.FilterIndex := 1;
end;

procedure TfrmGerenciadorDownload.ExibirHistorico;
var
  dlgHistorico: TfrmHistorico;
begin
  dlgHistorico := TfrmHistorico.Create(self);
  try
    FoDownload.AdicionarObserver(dlgHistorico);
    dlgHistorico.ShowModal;
  finally
    FoDownload.RemoverObserver(dlgHistorico);
    dlgHistorico.Free;
  end;
end;

procedure TfrmGerenciadorDownload.ExibirInformacoes;
begin
  Application.MessageBox(Pchar(FloatToStrf((pbDownload.Position / pbDownload.Max) * 100, ffGeneral, 3, 2) + '%'),'Progresso', MB_OK);
end;

function TfrmGerenciadorDownload.ExtrairExtensao: string;
var
  iPos: Integer;
  sNome: string;
begin
  Result := EmptyStr;

  sNome := ExtrairNomeArquivo;

  repeat
    iPos := Pos('.', sNome);
    sNome := Copy(sNome, ipos + 1, length(sNome) - iPos);
  until iPos = 0;

  Result := sNome;
end;

function TfrmGerenciadorDownload.ExtrairNomeArquivo: string;
var
  iPos: Integer;
  sNome: string;
begin
  Result := EmptyStr;

  sNome := edtUrlDownload.text;

  repeat
    iPos := Pos('/', sNome);
    sNome := Copy(sNome, ipos + 1, length(sNome) - iPos);
  until iPos = 0;

  Result := sNome;
end;

procedure TfrmGerenciadorDownload.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if FEstado = eBaixando then
  begin
    if Application.MessageBox('Existe um download em andamento, deseja interrompe-lo?', 'Confirme', MB_ICONQUESTION + MB_YESNO) = mrNo then
      CanClose := False
    else
      PararDownload;
  end;

  if CanClose and Assigned(FoDownload) then
    FoDownload.Free;
end;

procedure TfrmGerenciadorDownload.FormCreate(Sender: TObject);
begin
  FoDownload := TDownload.Create;
  setEstado(eAguardando);
end;

procedure TfrmGerenciadorDownload.IniciarDownload;
begin
  if sdArquivo.Execute then
  begin
    setEstado(eBaixando);
    if Assigned(FoDownload) then
    begin
      FoDownload.Free;
    end;

    FoDownload := TDownload.create;
    FoDownload.AdicionarObserver(self);
    FoDownload.urlDownload := edtUrlDownload.Text;
    FoDownload.nomeArquivo := sdArquivo.FileName;
    FoDownload.Start;
  end;
end;

procedure TfrmGerenciadorDownload.PararDownload;
begin
  FoDownload.CancelarDownload;
  FoDownload.WaitFor();
end;

procedure TfrmGerenciadorDownload.setEstado(eEstado: tpEstado);
begin
  FEstado := eEstado;
  ConfiguraComponentes;
end;

procedure TfrmGerenciadorDownload.ValidarCampos;
begin
  if Trim(edtUrlDownload.Text) = EmptyStr then
    raise Exception.Create('Campo obrigatório: url.');
end;

end.

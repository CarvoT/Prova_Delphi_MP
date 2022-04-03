unit dlgHistorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, dmdGerenciador, blGerenciador;

type
  TfrmHistorico = class(TForm, IObserver)
    pnlHitorico: TPanel;
    dbgHistorico: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    procedure Atualizar(Progresso: TProgresso);
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

{$R *.dfm}

procedure TfrmHistorico.Atualizar(Progresso: TProgresso);
begin
  if Progresso.Concluido then
    dmGerenciador.AbrirHistorico;

end;

procedure TfrmHistorico.FormShow(Sender: TObject);
begin
  dmGerenciador.AbrirHistorico;
end;

end.

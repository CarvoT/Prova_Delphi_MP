program GerenciadorDownload;

uses
  Vcl.Forms,
  Gerenciador in 'Gerenciador.pas' {frmGerenciadorDownload},
  blGerenciador in 'blGerenciador.pas',
  dmdGerenciador in 'dmdGerenciador.pas' {dmGerenciador: TDataModule},
  dlgHistorico in 'dlgHistorico.pas' {frmHistorico};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGerenciadorDownload, frmGerenciadorDownload);
  Application.CreateForm(TdmGerenciador, dmGerenciador);
  Application.Run;
end.

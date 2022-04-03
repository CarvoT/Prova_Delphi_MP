object frmGerenciadorDownload: TfrmGerenciadorDownload
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Gerenciador de downloads'
  ClientHeight = 131
  ClientWidth = 460
  Color = clBtnFace
  Constraints.MaxHeight = 170
  Constraints.MaxWidth = 476
  Constraints.MinHeight = 170
  Constraints.MinWidth = 476
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 460
    Height = 131
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 0
    object lblUrl: TLabel
      Left = 8
      Top = 5
      Width = 71
      Height = 13
      Caption = 'Url do arquivo:'
    end
    object edtUrlDownload: TEdit
      Left = 8
      Top = 24
      Width = 444
      Height = 21
      TabOrder = 0
    end
    object btnExibirHistorico: TButton
      Left = 8
      Top = 57
      Width = 180
      Height = 25
      Caption = 'Exibir hist'#243'rico de downloads'
      TabOrder = 1
      OnClick = btnExibirHistoricoClick
    end
    object btnExibirMensagem: TButton
      Left = 200
      Top = 57
      Width = 120
      Height = 25
      Caption = 'Exibir mensagem'
      TabOrder = 2
      OnClick = btnExibirMensagemClick
    end
    object btnDownload: TButton
      Left = 332
      Top = 57
      Width = 120
      Height = 25
      Caption = 'Iniciar Download'
      TabOrder = 3
      OnClick = btnDownloadClick
    end
    object pbDownload: TProgressBar
      Left = 8
      Top = 98
      Width = 444
      Height = 17
      TabOrder = 4
    end
  end
  object sdArquivo: TSaveDialog
    Left = 416
    Top = 8
  end
end

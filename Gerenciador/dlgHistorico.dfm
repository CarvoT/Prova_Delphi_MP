object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  Caption = 'Hist'#243'rico de downloads'
  ClientHeight = 299
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlHitorico: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 299
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 0
    ExplicitLeft = 376
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbgHistorico: TDBGrid
      Left = 8
      Top = 8
      Width = 578
      Height = 283
      Align = alClient
      DataSource = dmGerenciador.dsHistorico
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'URL'
          Title.Caption = 'Url'
          Width = 400
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAINICIO'
          Title.Caption = 'Data in'#237'cio'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATAFIM'
          Title.Caption = 'Data fim'
          Visible = True
        end>
    end
  end
end

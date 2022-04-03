
# Prova_Delphi_MP
 Desenvolvido por Lucas Carvalho Goulart

## Como Utilizar:
Abrir o exexcutável localizado em Gerenciador > Win32 > Release > GerenciadorDownload.exe

> Alguns computadores podem apresentar falhas de comunicação http, assegure das dlls libeay32.dll e ssleay32.dll estarem na pasta do executável

A seguinte tela será aberta:

![image](https://user-images.githubusercontent.com/73369063/161441506-b5382856-2d6f-4ea1-95c3-7c78f2c6fb9e.png)

O campo de texto espera uma url que se refere ao link de download do arquivo, por exemplo:

1. https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363eb56d2835f9903a/VSCodeUserSetup-x64-1.43.0.exe
2. http://mirror.mrjester.net/ubuntu/release/18.04.4/ubuntu-18.04.4-desktop-amd64.iso (link com erro 404)

Utilizando o link 1. e clicando no botão "Iniciar download", será abera uma tela de seleção do local para gravar o arquivo.

![image](https://user-images.githubusercontent.com/73369063/161441704-e806873b-70cb-42ff-9224-3cdd4791d442.png)

O campo de nome do arquivo virá preenchido com o último trecho da url, mas pode ser alterado.
Clicando em salvar o download será iniciado e a tela anterior passará a ter a seguinte aparência:

![image](https://user-images.githubusercontent.com/73369063/161441794-4c844565-c3da-449d-a695-fa4751fc7329.png)

Durante o progresso do download o botão "Parar Download" é exibido e ao clicar nele o download é interrompido e o sistema volta ao estado anterior aguarando um novo inicio de download. O botão exibir progresso estará habilitado, clicando nele, é exibida uma mensagem com o percentual atual de download:

![image](https://user-images.githubusercontent.com/73369063/161441802-006ea586-1c26-49e3-bfab-6e99144ce7f3.png)

O botão "Exibir histórico de downloads" está sempre habilitado, ao clicar nele é exibida a seguinte tela:

![image](https://user-images.githubusercontent.com/73369063/161441916-3b71c901-bca6-47b0-b897-c0ddd2f5f658.png)

> Caso um download seja concluído com essa tela aberta, ela será atualizada com a data de conclusão do download.

Se durante um download é clicado em fechar a tela principal, o sistema apresenta a seguinte mensagem, encerrando o programa somente após a confirmação.

![image](https://user-images.githubusercontent.com/73369063/161442042-aec2d066-8eb6-424b-8661-c4376ff9cb1b.png)


## User Stories:

DADO que acesso o sistema
E informo o link para download,
QUANDO clico no botão “Iniciar Download”,
ENTÃO o sistema inicia o download
E consigo visualizar seu progresso até sua finalização.

DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico no botão “Exibir mensagem”,
ENTÃO o sistema exibe uma mensagem com a % atual de download.

DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico no botão “Parar download”,
ENTÃO o sistema interrompe o download do arquivo.

DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico para fechar o sistema,
ENTÃO o sistema exibe a mensagem “Existe um download em andamento, deseja interrompe-lo? [Sim, Não]”.

DADO que acesso o sistema
QUANDO clico no botão “Exibir histórico de downloads”,
ENTÃO o sistema abre uma nova tela
E exibe o histórico de downloads realizados, com suas URL’s e suas respectivas datas de início e fim.

## Pré-Condições Técnicas
- Utilizar orientação a objetos
- Utilizar SOLID
-  Utilizar Clean Code
- Utilizar boas práticas de tratamento de exceção
- Utilizar processamento multithread (System.Threading)
-- Para a atualização do progresso na main thread, pode ser utilizado o padrão de projetos Observer
- O sistema deve realizar o download via HTTP request
- Os dados de downloads devem ser armazenados em um banco SQLite contendo a seguinte estrutura:
![image](https://user-images.githubusercontent.com/73369063/161441261-ff86eb5b-8a86-4c56-9728-6e06523916ff.png)


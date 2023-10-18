# Verzel Test Frontend

Esse é um teste para vaga de Dev Fullstack na Verzel
Desenvolver o Frontend em Flutter Web

## Pré-requisitos

[Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
Navegador da web (como o Google Chrome) para executar o aplicativo web.

## Configuração

Clone este repositório:

```bash
git clone https://github.com/danielbarrosdeoliveira/verzel-test.git
```

Navegue até o diretório do projeto:

```bash
cd frontend
```

Instale os pacotes

```bash
fvm flutter packages get
```

## Executando o Aplicativo

Para verificar se o Flutter está configurado corretamente para a web, execute o seguinte comando:

```bash
fvm flutter devices
Você deve ver uma lista de dispositivos, incluindo um dispositivo da web.
```

Inicie o aplicativo Flutter para a web:

```bash
fvm flutter run -d web
```

Isso compila o aplicativo e o inicia em seu navegador da web padrão.
O aplicativo estará disponível em http://localhost:5000 ou em outro endereço, dependendo da configuração.

Abra o navegador da web e acesse o endereço onde o aplicativo está sendo executado.

## Parando a Execução

Para parar a execução do aplicativo, basta interromper o comando no terminal pressionando Ctrl+C.

## Personalizando o Aplicativo

Você pode personalizar o aplicativo fazendo alterações nos arquivos do projeto. Os arquivos do aplicativo em Flutter estão no diretório lib.

## Problemas Comuns

Se você encontrar problemas ao executar o aplicativo, verifique se o Flutter e o ambiente de desenvolvimento estão configurados corretamente.
Certifique-se de ter as dependências do projeto instaladas, conforme especificado no arquivo pubspec.yaml.
Limpe a pasta build e reconstrua o aplicativo usando flutter clean e flutter build web se encontrar problemas persistentes.

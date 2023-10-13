# Backend

## Tecnologias

- Node.js
- Adonis.js
  - Lucid
- Docker
- PostgreSQL

## Como Executar?

Certifique-se de ter a versão 14 ou superior do Node, para isso use o comando: `node -v`

Precisa ter uma saída como essa: `v16.20.0`, caso não tenha resultados ou a versão seja menor que a 14, por favor providencie a instalação ou atualização do Node.

### Instalação dos Pacotes

Faça a instalação dos pacotes, com o comando: `npm -i ou yarn`

### Imagem Docker

Você deve ter percebido que existe um arquivo chamado `docker-compose.yml`, isso quer dizer que o nosso projeto está contemplando dockerização, e que vamos rodar é o banco de dados PostgreSQL.

Por isso é necessário atenção, se você já tiver o Postgres configurado, provavelmente não irá conseguir usar a porta padrão 5432, troque a porta no arquivo `docker-compose.yml`, onde está PORT, para uma porta disponível em seu sistema operacional, não esqueça de fazer as trocas também nos arquivos .env

Para fazer a configuração da imagem, rode o comando: `docker-compose up -d`

Para testar se o banco de dados está funcionando, você precisará de um software comumente chamado de ferramenta de Banco de Dados, ou Inteface para Manipulação de Banco de Dados.

Durante meus testes usei o [DBeaver Community](https://dbeaver.io/), mas fique a vontade para usar o que preferir.

### Executando o Servidor

Finalizado a instalação dos pacotes e configuração do Docker, para executar o servidor, rode o comando: `node ace serve --watch`, se não apresentar nenhum erro, e houver uma saída como essa:

`Server address: http://127.0.0.1:3333
Watching filesystem for changes: YES`

É porque o backend já está rodando, bastar usar um software de teste de API, eu usei o [Insomnia](https://insomnia.rest/download), mas fique a vontade para usar o que preferir.

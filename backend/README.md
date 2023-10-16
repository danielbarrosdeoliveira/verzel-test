# Backend

## Tecnologias

- Node.js
- Adonis.js
  - Lucid
  - Auth
  - Argon2
- Docker
- PostgreSQL

## Como Executar?

Certifique-se de ter a versão 14 ou superior do Node, para isso use o comando: `node -v`

Precisa ter uma saída como essa: `v16.20.0`, caso não tenha resultados ou a versão seja menor que a 14, por favor providencie a instalação ou atualização do Node.

### Instalação dos Pacotes

Faça a instalação dos pacotes, com o comando: `npm -i ou yarn`

### Imagem Docker

Você deve ter percebido que existe um arquivo chamado `docker-compose.yml`, isso quer dizer que o nosso projeto está contemplando dockerização, e que vamos rodar é o banco de dados PostgreSQL.

Se você tiver o Docker instalado, siga as instruções abaixo.
Se não tiver o Docker e quiser instalar, faça a instalação do Docker, volte e siga o passo a passo abaixo.

Nesse passo é necessário atenção, se você já tiver o **PostgreSQL** como instância instalado e configurado, provavelmente não irá conseguir usar a porta padrão **5432** do Postrgres, então troque a porta no arquivo `docker-compose.yml` que está na raiz do projeto, exemplo:

```yml
version: '3.1'

services:
  postgres:
    image: postgres
    environment:
      POSTGRES_USER: 'vertel'
      POSTGRES_PASSWORD: 'vertel'
    ports:
      - '5430:5430'
```

Onde está **ports**, eu troquei para uma porta disponível em meu sistema operacional, faça o mesmo, e não esqueça de realizar a troca também nos arquivos .env, lá a variável é `PORT`

Para fazer subir configuração da imagem e já executar o banco de dados, rode o comando: `docker-compose up -d`

Se não quiser instalar o Docker, e já tem uma instância do PotsgreSQL, crie um banco de dados chamado vertel.
Se não tem a instância do Postgres, e não quer instalar o Docker, faça a instalação do PosgreSQL, crie um banco de dados chamado vertel, volte e siga o passo a passo.

Agora basta ajustar o arquivo .env, abaixo exemplo.

```
DB_CONNECTION=pg

PG_HOST=IP DA INSTÂNCIA, se for LOCALHOST, pode por ip de loopback 127.0.0.1 ou localhost
PG_PORT=PORTA CONFIGURADA NA INSTÂNCIA ou a PADRÃO se for o caso 5432
PG_USER=INFORME o usuário da sua INSTÂNCIA
PG_PASSWORD=INFORME a senha da sua INSTÂNCIA
PG_DB_NAME=vertel
```

Feito isso, agora é testar se está conseguindo acessar o Banco de Dados.

### Banco de Dados

Para testar se o banco de dados está funcionando, você precisará de um software comumente chamado de Ferramenta de Banco de Dados ou Inteface para Manipulação de Banco de Dados.

Durante meus testes usei o [DBeaver Community](https://dbeaver.io/), mas fique a vontade para usar o que preferir.

```
Host: localhost
Porta: A que você colocou ou a padrão se for seu caso.
Usuário e Senha: vertel
```

![image](https://github.com/danielbarrosdeoliveira/vertel-test/assets/28925159/09df2b89-393a-4128-962e-888f6fd01b32)


#### Criar as tabelas no Banco de Dados

Como estamos usando Lucid, um ORM do próprio Adonis, preciamos executar o comando: `node ace migration:run`, dessa forma ele irá criar todas a tabelas que iremos usar no projeto, mas ainda não podemos executar o servidor, pois resta o último passo abaixo.

#### Populando o Banco de Dados

Precisamos inserir alguns dados no Banco de Dados, para que aplicação funcione corretamente, conhecido como seeders (semente), vamos usar esse processo para já deixar o usuário admin cadastrado, ele realizará o acesso de cadastro de veículos no nosso sistema.

Execute o comando: `node ace db:seed`

Agora temos o usuário padrão cadastrado:

```
usuário: vertel
senha: vertel
```

### Executando o Servidor

Finalizado a instalação dos pacotes, configuração do Docker e iniciado o seeder, rode o comando: `node ace serve --watch`, ou `npm run dev` ou `yarn dev`, se não apresentar nenhum erro, e houver uma saída como essa:

```
Server address: http://127.0.0.1:3333
Watching filesystem for changes: YES
```

É porque o backend já está rodando, basta usar um software de teste de API, eu usei o [Insomnia](https://insomnia.rest/download), mas fique a vontade para usar o que preferir, vou deixar um arquivo com as rotas configuradas

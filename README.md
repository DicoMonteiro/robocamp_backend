# NinjaPixel Setup

Bem-vindo ao guia de preparação de Ambiente do NinjaPixel

## Crie uma Rede Docker

`bash
docker network create --driver bridge skynet
`

## Banco de Dados

### Download das Imagens
`bash
docker pull postgres
docker pull dpage/pgadmin4
`

### Servidor do Banco de Dados ###
`bash
docker run --name pgdb --network=skynet -e "POSTGRES_PASSWORD=qaninja" -p 5432:5432 -v var/lib/postgresql/data -d postgres
`


* Crie uma entrada DNS local no Hosts no Mac ou Linux:

Abre o terminal (iterm/hyper term) e digita:

sudo vim /etc/hosts

Adiciona a senha de administrador e digitar a opçao "i" para inclusão no arquivo:


`
127.0.0.1       pgdb
`

Após inserir o código no arquivo, clicar em "ESC", seguido de ":wq!", para ele sair e salvar a edição.

Para visualizar a edição se foi feita com sucesso:

cat /etc/hosts


* Crie uma entrada DNS local no Hosts no Windows:

Abre o terminal (prompt) e digita o notepad hosts e adiciona na ultima parte do arquivo: 

127.0.0.1       pgdb

> 127.0.0.1 para Docker normal ou 192.168.99.100 para Docker Toolbox

### Administrador do Banco de dados

`bash
docker run --name pgadmin --network=skynet -p 15432:80 -e "PGADMIN_DEFAULT_EMAIL=root@qaninja.io" -e "PGADMIN_DEFAULT_PASSWORD=qaninja" -d dpage/pgadmin4
`

* Adicione uma nova entrada DNS local no Hosts :

`
127.0.0.1       pgadmin
`

> 127.0.0.1 para Docker normal ou 192.168.99.100 para Docker Toolbox


### Criação da Base de Dados

* Logue no PGADMIN [http://pgadmin:15432]
user: root@qaninja.io
pass: qaninja
* Crie uma conexão com o servidor pgdb
* Crie uma base de dados com o nome ninjapixel


## Publicando o Backend

### Download das Imagens

```bash
docker pull qaninja/pixel-api
```

### Colocando a API no Ar

`bash
docker run --name pixel-api --network=skynet -e "DATABASE=pgdb" -p 3333:3333 -d qaninja/pixel-api
`

* Adicione uma nova entrada DNS local no Hosts :

`
127.0.0.1       pixel-api
`

> 127.0.0.1 para Docker normal ou 192.168.99.100 para Docker Toolbox


* Veja se a API está online [http://pixel-api:3333]


## Publicando o Frontend

### Download das Imagens

```bash
docker pull qaninja/pixel-web
```

### Colocando a WebApp no Ar

```bash
docker run --name pixel-web --network=skynet -p 3000:3000 -d qaninja/pixel-web
```

* Adicione uma nova entrada DNS local no Hosts :

`
127.0.0.1       pixel-web
`

> 127.0.0.1 para Docker normal ou 192.168.99.100 para Docker Toolbox

* Veja se a WebApp está online [http://pixel-web:3000]

## Criando o usuário Admin

* Instale o Insomnia [https://insomnia.rest/download/]
* Acesse a Documentação da API [http://pixel-api:3333/apidoc]
* Crie um novo usuário enviando um POST na rota /users da API
* Acesse a WebApp [http://pixel-web:3000]
* Faça login

## Subindo os containers

```bash
docker start pgdb
docker start pgadmin
docker start pixel-api
docker start pixel-web
```

## Parando os containers

```bash
docker stop pgdb
docker stop pgadmin
docker stop pixel-api
docker stop pixel-web
```

## Comandos Docker

```bash
# removendo um network
docker network rm nome_da_network

# removendo um container
docker rm nome_ou_id_do_container

# removendo na marra
docker rm nome_ou_id_do_container -f

# listando containers
docker ps

# listando container parados
docker ps -a

# listando imagens
docker images

# removendo uma imagem
docker rmi nome_ou_id_da_imagem

# removendo uma imagem com ignorância
docker rmi nome_ou_id_da_imagem -f
```

Enjoy

# desafios_robocamp


## Projeto voltado para aplicar os desafios do curso de Robocamp
 
- Automação de testes da aplicação NinjaPixel usando o framework Robot.


## Tecnologias utilizadas

- robot framework;
- seleniumLibrary;
- Python;
- Docker;
- API;


## Estrutura do projeto

Ex:

Ninjapixel
  - log
  - resources
    -fixtures
      -images
      dk.json
      mario.json
      ...
    -libs
    -pages
      BasePage.robot
      LoginPage.robot
      ...
    acitons.robot
  - tests
    cadastro.robot
    login.robot
    remove.robot
    
    
## Relatório






### Repositório do Projeto


https://github.com/sejaninja/robocamp4-api
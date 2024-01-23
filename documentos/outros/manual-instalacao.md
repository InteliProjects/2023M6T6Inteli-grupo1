# Manual de Instalação

Esse documento tem por objetivo auxiliar a instalação e mostrar como executar as APIs e demais tecnologias necessárias para fazer o projeto funcionar como um todo.

## Tecnologias Utilizadas
As seguintes tecnologias foram utilizadas para o desenvolvimento do projeto, em conjunto com seus links de download:

- [Visual Studio Code](https://code.visualstudio.com/)
- [git](https://git-scm.com/downl)
- [Node.js](https://nodejs.org/en)
- [Python](https://www.python.org/downloads)
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Android Studio](https://developer.android.com/studio?hl=pt-br)
- [Docker](https://www.docker.com/get-started/)

## Backend
O backend do sistema SED pode ser visto como um conjunto de APIs sendo elas: **API de backend**, uma API com as principais regras de negócio do sistema e a única que os frontend conseguem se comunicar; **API de Autenticação**, uma API que por intermédio de conexão com o firebase, consegue desacoplar a lógica de autenticação e fica responsável pela criação e validação de tokens JWT dos usuários SEDUC e Escola; **API de Recomendação**, faz o uso da análise de dados e retorna recomendação de usuários.

A seguir, um manual de como executar localmente as três APIs do conjunto do projeto, lembrando que para tal, esse repositório como um todo deve estar clonado em seu computador:

### API de Autenticação

Para executar a API de autenticação contida no diretório **/src/api-auth**, é necessário criar uma conta no firebase e dois projetos: um autenticador e um app. Em seguida, deve-se criar dois arquivos dentro de sua pasta api-auth:

**.env**

Esse arquivo é responsável por definir as variáveis de ambiente do projeto da API de autenticação e portanto, não vai ser salvo no github por motivos de segurança. Nele, as variáveis contidas no arquivo **.env.example** devem ser criadas e definidas, conforme o exemplo:

```
PORT=3001
PRIV_KEY="sua-priv-key"
FIREBASE_API_KEY="sua-api-key"
FIREBASE_AUTH_DOMAIN="seu-auth-domain"
FIREBASE_PROJECT_ID="seu-project-id"
FIREBASE_STORAGE_BUCKET="seu-storage-bucket"
FIREBASE_MESSAGING_SENDER_ID="seu-messaging-sender-id"
FIREBASE_APP_ID="seu-app-id"
```
As variáveis referentes ao firebase, dizem respeito ao escopo da utilização do firebase enquanto client, portanto, para acessá-las, vá até as configurações do projeto do app criado em sua conta firebase e lá, terá acesso a esses dados.

**firebase.json**

Esse arquivo é referente as credenciais de administrador do firebase e é gerado a partir do painel console do firebase no meu **Configurações do projeto > Contas de Serviço > SDK Admin do Firebase > Botão Gerar nova chave privada**. Em seguida renomeie o arquivo para **firebase.json** e mova-o para a pasta api-auth

Com esses arquivos corretamente configurados, pode-se executar a API através do **node.js** diretamente ou através do **docker**:

**Execução com Node.js**
```
npm install
npm run dev
```

**Execução com Docker**
```
docker-compose up --build -d
```

Lembrando que tanto pelo exemplo de .env quanto pelo Docker, a porta de execução da API é **3001**.

### API de Recomendação

A API de recomendação presente na pasta **src/api-recomendation** não precisa de arquivos referentes a variáveis de ambiente, mas, as recomendações são baseadas em um arquivo .pkl contendo uma matriz de melhor fornecedor para cada escola, portanto, caso precise atualizar o modelo de recomendação, pode-se atualizar o código nos notebooks desse repositório e gerar uma nova matriz, substituindo a atual no arquivo **supplier_matrix.pkl**

Sendo assim, para executar o projeto, pode-se utilizar a execução diretamente pelo **python** ou através do docker:

**Execução com Python**:
```
pip install --no-cache-dir -r requirements.txt
uvicorn src.main:app --host 0.0.0.0 --port 8000 --reload
```

**Execução com Docker**
```
docker-compose up --build -d
```

Lembrando que a porta de execução está configurada para ser a **3002** utilizando o docker ou **8000** utilizando o python diretamente.


### API de backend

Para executar a API de backend contida no diretório **/src/backend**, é necessário configurar a conexão com as outras APIs e um banco de dados Mysql, através da configuração das variáveis de ambiente por intermédio do arquivo **.env**

**.env**

Esse arquivo é responsável por definir as variáveis de ambiente do projeto da API de backend  e portanto, não vai ser salvo no github por motivos de segurança. Nele, as variáveis contidas no arquivo **.env.example** devem ser criadas e definidas, conforme o exemplo:

```
PORT="3000"
DB_HOST=""
DB_USER=""
DB_PASSWORD=""
DB_DATABASE=""
SEDUC_AUTH_API_BASE_URL="http://localhost:3001/seduc"
SCHOOL_AUTH_API_BASE_URL="http://localhost:3001/school"
SUPPLIER_RECOMMENDATION_API_BASE_URL="http://localhost:3002"
```

As variáveis referentes ao banco de dados podem ser utilizadas com credenciais de um banco de dados local ou em nuvem, mas obrigatoriamente precisa ser um banco de dados **MYSQL**. Já as variáveis **SEDUC_AUTH_API_BASE_URL**, **SCHOOL_AUTH_API_BASE_URL** e **SUPPLIER_RECOMMENDATION_API_BASE_URL** são referentes aos domínios onde estão contidos as APIs de autenticação e de recomendação.

**Atenção**: Caso utilizar o docker, os domínios podem ser diferentes de localhost.

Com o .env corretamente configurado, pode-se executar a API através do **node.js** diretamente ou através do **docker**:

**Execução com Node.js**
```
npm install
npm run dev
```

**Execução com Docker**
```
docker-compose up --build -d
```

Lembrando que tanto pelo exemplo de .env quanto pelo Docker, a porta de execução da API é **3000**.


Dessa forma, com as três APIs em execução, o backend está configurado e pronto para receber as requisições do frontend.

## Frontend

O frontend do projeto foi construído em 4 fluxos diferentes em projetos diferentes, mas todos escritos utilizando **flutter**. Portanto, a execução dos 4 projetos é a mesma:

**Emulador**
Execute:

```
flutter run
```

Caso tenha configurado a SDK do android e queira executar com o emulador, digite 1. Uma outra alternativa é executar diretamente com o chrome. Para isso, digite 2.

**Builds finais**

Para gerar um SDK executável em celular, é necessário ter a SDK do android configurado. Uma outra opção é rodar pelo emulador do IOS, mas nesse tutorial, iremos focar no android. Caso precise, após o tutorial do frontend, há um tutorial de como instalar a SDK do android com o android studio.

Com a SDK do android configurada, execute o comando:

```
flutter build apk --split-per-abi
```

Dessa maneira, dentro da pasta **build/app/outputs/apk/release** serão gerados 3 arquivos .apk para diferentes arquiteturas de android. Selecione a que desejar e instale em seu celular.


Esses comandos podem ser executados para a execução nos 4 fluxos desenvolvidos, contidos nas pastas: **sed_seduc**, **sed_school**, **sed_supplier** e **sed_shipping**.


## Extra: Instalação do Android SDK pelo Android Studio

Como base para esse tutorial, foi seguida a própria documentação do [flutter](https://docs.flutter.dev/get-started/install/windows#android-setup).

Para a instalação do android SDK necessário para gerar os APKs, precisa-se instalar o Android Studio. Para isso, acesse o [site do android studio](https://developer.android.com/studio?hl=pt-br) e faça o download da última versão.

Depois que tiver pronto, clique no arquivo baixado e dê next em tudo. Em algum momento vai aparecer para seleção se quer importar configurações de alguma pasta do seu computador (caso já tiver instalado anteriormente). Selecione que não, caso for sua primeira vez.

Em seguida, irá aparecer outra tela para instalar os pacotes adicionais, que é realmente o necessário para gerar o APK. Selecione a instalação das coisas que eles denominam padrão, e aceite todos os termos de uso. Depois disso, vai liberar o botão de finish e ao clicar, a instalação dos pacotes vai começar. Vai demorar um pouco, mas vai dar certo.

Depois que finalizar, vá até algum projeto flutter e execute:
```
flutter doctor
```

Esse comando vai mostrar o que está instalado no seu computador. Veja se o Android Studio está marcado com sucesso. Se estiver, está pronto.

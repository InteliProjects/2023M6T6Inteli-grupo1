<Table>
  <tr>
    <td><a href= "https://www.educacao.sp.gov.br/"><img src="/imagens/logo-SEDUC.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0"></td>
    <td>
      <a href= "https://www.inteli.edu.br/"><img src="/imagens/inteli-logo.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0"></a>
    </td>
  </tr>
</table>

# Nome do Projeto: SED

## Nome do Grupo: Seis é demais

## Integrantes:

- <a href="https://www.linkedin.com/in/brunomleao/">Bruno Leão</a>
- <a href="https://www.linkedin.com/in/eduarda-gonzaga-009794219/">Eduarda Gonzaga</a>
- <a href="https://www.linkedin.com/in/joao-victor-montagna-4bb3a4247/">João Victor Montagna</a>
- <a href="https://www.linkedin.com/in/marcelo-saadi-pessini-003212209/">Marcelo Saadi Pessini</a>
- <a href="https://www.linkedin.com/in/rafael-techio/">Rafael Mateus Zimmer Techio</a>
- <a href="https://www.linkedin.com/in/renan-ribeiro-31a205247/">Renan Ribeiro</a>


## Professores:
### Orientador(a) 
- <a href="https://www.linkedin.com/in/vanunes/">Vanessa Nunes</a>
### Instrutores
- <a href="https://www.linkedin.com/in/victorbarq/">Programação - André Braga</a>
- <a href="https://www.linkedin.com/in/victorbarq/">Programação - Jefferson de Oliveira</a>
- <a href="https://www.linkedin.com/in/victorbarq/">Matemática e Física - Ricardo Missori</a>
- <a href="https://www.linkedin.com/in/victorbarq/">Negócios - Rafael Jacomossi</a>
- <a href="https://www.linkedin.com/in/victorbarq/">Design - Guilherme Cestari</a> 
- <a href="https://www.linkedin.com/in/victorbarq/">Liderança - Filipe Gonçalves</a>

## 📝 Descrição

O desafio enfrentado pelo parceiro refere-se à gestão dos dados provenientes do processo de entrega de equipamentos escolares pela SEDUC. Dentre as diversas dificuldades identificadas, destaca-se o acompanhamento do progresso das entregas. O objetivo do projeto é estabelecer governança de dados no referido processo, mediante a implementação de aplicativos e APIs.
A proposta visa otimizar a governança de dados na entrega de equipamentos às escolas pela SEDUC. A solução consiste em disponibilizar um aplicativo mobile às personas identificadas, abrangendo todos os procedimentos necessários para concluir o ciclo de entrega. Estes aplicativos interagirão com uma API em nuvem responsável por registrar os dados em um banco de dados, além de trocar informações com o modelo de recomendação e potenciais APIs governamentais.
Assim, almeja-se a redução de custos na aquisição de novos equipamentos, permitindo a implementação de iniciativas voltadas à melhoria da qualidade da educação pública no estado de São Paulo. A solução proposta busca garantir a governança de dados no processo de entrega, oferecendo uma abordagem integrada e eficiente para acompanhar e aprimorar o fluxo de entrega de equipamentos educacionais.

## 📝 LINKS

Clique <a href="/notebooks/arquivo_csv_modelo_preditivo">AQUI</a> para acessar a plataforma de consolidação dos dados.

<a href="/documentos/outros/manual-instalacao.md">Link para o Manual de Instruções</a> que explica como montar, conectar e utilizar o protótipo.

<a href="/documentos/index.md">Link para a documentação geral</a> do projeto.

## 📁 Estrutura de pastas

|--> documentos<br>
  &emsp;| --> outros <br>
  &emsp;| T6_G1_V5_document.pdf<br>
  &emsp;| T6_G1_V5_document.docx<br>
|--> imagens<br>
|--> notebooks<br>
  &emsp;| --> arquivo_csv_modelo_preditivo <br>
        &emsp;| --> banco_de_dados <br>
  &emsp;| --> modelo_preditivo <br>
        &emsp;| --> Web Modelo Preditivo <br>
|--> src<br>
  &emsp;|--> api-auth<br>
  &emsp;|--> api-recomendation<br>
  &emsp;|--> backend<br>
  &emsp;|--> sed_school<br>
  &emsp;|--> sed_shipping<br>
  &emsp;|--> sed_supplier<br>
| readme.md<br>


Dentre os arquivos presentes na raiz do projeto, definem-se:

- <b>readme.md</b>: arquivo que serve como guia e explicação geral sobre o projeto (o mesmo que você está lendo agora).

- <b>documentos</b>: aqui estarão todos os documentos do projeto. Há também uma pasta denominada <b>outros</b> onde podem estar presentes documentos complementares à documentação principal.

- <b>imagens</b>: imagens relacionadas ao projeto como um todo (por exemplo imagens do sistema, do grupo, logotipos e afins).

- <b>src</b>: nesta pasta encontra-se todo o código fonte do sistema (circuito e eventuais sistemas complementares).

## 💻 Configuração para desenvolvimento

Para configurar o desenvolvimento da aplicação, [instale o git](https://git-scm.com/downloads) e clone esse repositório em seu computador através do comando:

```
git clone https://github.com/2023M6T6Inteli/grupo1.git
```
Em seguida siga as instruções presentes em nosso <a href="/documentos/outros/manual-instalacao.md">manual de instalação</a>.

## 🗃 Histórico de lançamentos

* 0.1.0 - 27/10/2023
    * Entendimento do negócio
    * Documento de Arquitetura do Sistema
    * Wireframe Mobile
    * Base de Dados para Modelo de Recomendação
* 0.2.0 - 10/11/2023
    * Documentação da API
    * Mockup Navegável com Abordagem Mobile First
    * Definição e construção da API
    * Modelo de Recomendação Baseado em Filtragem Colaborativa
* 0.3.0 - 24/11/2023
    * Teste de Usabilidade para Mockup
    * Front-end Mobile
    * Testes de API Externa utilizando SOA
* 0.4.0 - 08/12/2023
    * Documentação da Integração das APIs, SOA, Mobile e Banco de Dados
    * Integração das APIs, SOA, Mobile e Banco de Dados
    * Análise de Usabilidade no Front-End
    * Testes de Integração entre Modelo de Recomendação baseado em Filtragem Colaborativa
    * Testes de Integração do sistema
* 0.5.0 - 20/12/2023
    * Versão Final da Arquitetura
    * Refinamento do Código

## 📋 Licença/License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/2023M6T6Inteli/grupo1">SED</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://github.com/2023M6T6Inteli/grupo1">INTELI, Bruno Moitinho Leão, Eduarda Gonzaga de Oliveira, João Victor Cavalcante Montagna, Marcelo Saadi Pessini, Rafael Mateus Zimmer Techio, Renan Ribeiro da Silva</a> is licensed under <a href="http://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution 4.0 International<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"></a></p>

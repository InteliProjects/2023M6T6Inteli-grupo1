A partir dos dados fornecidos e uma modelagem aplicada, permitindo a ánalise a seguir:

Escolas que mais votaram:<br>
<img src="../../../imagens/escola_mais_votaram.jpg">

<br>
Fornecedores mais votados:<br>
<img src="../../../imagens/forn_mais_votados.jpg"><br><br>


Como podemos analisar, vemos que existe uma grande disparidade entre os dados, impactanto negativamente na qualidade do nosso dataset. Podemos observar isso considerando que as escolas que mais avaliam possuem mais de 2500 avaliações, mas existem várias escolas que possuem menos de 10 avaliações. O mesmo se aplica aos fornecedores, enquanto existem fornecedores que apareceram milhares de vezes, existem alguns que apareceram menos de 10 vezes, como evidenciado no Jupyter:

Descrição do DataSet:<br>
"cie" : A coluna "cie" sera usada como identificador de escola<br>
"fornecedor" : Essa coluna sera usada como identificador de forncedores, sera convertida por meio de label encoding.<br>
"nota" : Essa coluna sera ultilizada como metrica de ranking, determinando a eficacia de cada fornecedor para cada escola.<br>
"Material": Essa coluna é referente ao material que o item é feito<br>
"Classe do material": É a muito similar ao material, mas uma versão mais ampla<br>
Vale colocar que optamos por não utilizar a classe "Item" pois existiriam muitas poucas amostras de cada item, e também entendemos que não existem grande diferenças para itens diferentes do mesmo material.
O DataSet tera 5 colunas(conforme acima) e 467696 linhas de dados. <br>


Descrição dos Jupyters:<br>
Temos dois jupyters no projeto:<br>

Visualizacoes_Estatistica: Nesse jupyter o objetivo foi contextualizar o básico na visualização de dados, mostrnado quais escolas avaliam mais e quais fornecedores mais entregaram. <br>
Na parte de estatística descritiva, optamos por encontrar a média de entregas por fornecedor e a média de vezes que as escolas avaliaram.<br>

Matriz_de_notas: Aqui nosso objetivo foi encontrar a avaliação média de cada fornecedor por escola, então no eixo y temos o CIE das escolas e no eixo X os fornecedores, plotamos um heatmap apenas para checar se o código estava funcional e posteriormente foi gerado o arquivo matriz_de_notas.xlsx com esses dados

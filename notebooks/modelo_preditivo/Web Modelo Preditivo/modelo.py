
import pandas as pd


# # Importação do banco de dados e tratamento de nulos

# essa primeira linha de código é importante para, além de importar o dataframe, entedermos as colunas que definimos como importantes e a quantidade total de linhas no nosso dataframe:

# In[2]:


df_certinho = pd.read_csv('C:\Users\jvcmo\OneDrive\Documentos\GitHub\Modulo6 App\grupo1\notebooks\modelo_preditivo\bd.csv', sep=';')



# Nessa célula de código, estamos checando a quantidade de nulos no nosso dataframe, em que separamos duas possibilidades:
# 1. O banco de dados possuí uma grande quantidade de nulos e não podemos simplesmente deletar todos, a abordagem nesse caso é de tratar os nulos inferindo eles dentro de uma normal padrão.
# 2. O banco de dados possuí uma quantidade pequena de nulos, nesse caso é plausível excluir eles sem grandes problemas.

# In[3]:



null_count = df_certinho.isnull().sum()




# Podemos observar que a hipótese 2 foi a mais adequada, relevando que os dados nulos representam menos de 3% da quantidade total de dados. Portanto, nessa situação é ideal deletar as linhas que possuem algum dado faltante.

# In[4]:


df_certinho_sem_nulos = df_certinho.dropna()
teste = df_certinho_sem_nulos.isnull().sum()



# In[5]:


df_certinho_sem_nulos


# # Exploração, entendimento e limpeza do banco

# Nessa primeira célula de código, foi utilizado o método unique(),  esse método nos permite visualizar os valores únicos do dataframe em uma coluna, primeiramente foi utilizado na coluna "Classe do material" para identificarmos todos os materiais que estão presentes nas 454 mil linhas do dataframe.

# In[6]:


# print(df_certinho_sem_nulos['Classe do Material'].unique())


# In[7]:


# print(df_certinho_sem_nulos['CNPJ'].unique())


# Como podemos observar, não existe uma quantidade gigante de instâncias na tabela 'classe de materiais', o que é extremamente positivo para identificarmos o que o fornecedor entrega de forma mais competente cada material, mas mesmo assim é possível observar que exsite itens que contém descrições dispensáveis, como e exemplo de  'Equipamentos de Tecnologia da Informação"TCI - TECNOLOGIA'. O fato de ser da TCI tecnologia é dispensável para nós, então precisamos substituir essas instâncias que são dispensáveis para âmbitos mais gerais:

# In[8]:



df_certinho_sem_nulos['Classe do Material'] = df_certinho_sem_nulos['Classe do Material'].replace(
    {'Equipamentos para Informática': 'Equipamentos para Informatica',
     'EQUIPAMENTO DE INFORMÁTICA -': 'Equipamentos para Informatica'})

df_certinho_sem_nulos['Classe do Material'] = df_certinho_sem_nulos['Classe do Material'].replace(
    {'Outros Equipamentos e Material Permanente': 'Outros Equipamentos e Material Permanente',
     'Outros Equipamentos e Material Permanente"MEGA DADOS COM. DE SUPR. EM INFOR.': 'Outros Equipamentos e Material Permanente'})

df_certinho_sem_nulos['Classe do Material'] = df_certinho_sem_nulos['Classe do Material'].replace(
    {'Outros Materiais de Consumo"EBN COMERCIO': 'Outros Materiais de Consumo',
     'Outros Materiais de Consumo': 'Outros Materiais de Consumo'})

df_certinho_sem_nulos['Classe do Material'] = df_certinho_sem_nulos['Classe do Material'].replace(
    {'"Material Educativo Esportivo e Cultural"': 'Material Educativo Esportivo e Cultural',
     '"Material Esportivo Educativo e Cultural"': 'Material Educativo Esportivo e Cultural',
     'MATERIAL ESPORTIVO': 'Material Educativo Esportivo e Cultural'})

df_certinho_sem_nulos['Classe do Material'] = df_certinho_sem_nulos['Classe do Material'].replace(
    {'VENTILADOR DE PAREDE': 'Ventilador De Parede',
     'VENTILADOR DE PAREDE - VN-': 'Ventilador De Parede'})

df_certinho_sem_nulos['Classe do Material'] = df_certinho_sem_nulos['Classe do Material'].replace(
    {'Outros serviços de terceiros"TCI - TECNOLOGIA': 'Outros serviços de terceiros',
     'Outros serviços de terceiros': 'Outros serviços de terceiros'})


# In[9]:


# print(df_certinho_sem_nulos['Classe do Material'].unique())


# Também precisamos solucionar as instâncias que possuem ND na coluna CNPJ:

# In[10]:


df_certinho_sem_nulos = df_certinho_sem_nulos[df_certinho_sem_nulos['CNPJ'] != '#N/D']


# In[11]:


# print(df_certinho_sem_nulos['CNPJ'].unique())


# In[12]:


tipo_de_dados_cnpj = df_certinho_sem_nulos['CNPJ'].dtypes
# print(tipo_de_dados_cnpj)
tipo_de_dados_CIE = df_certinho_sem_nulos['CIE'].dtypes
# print(tipo_de_dados_CIE)
tipo_de_dados_nota = df_certinho_sem_nulos['nota'].dtypes
# print(tipo_de_dados_nota)


# In[13]:


grouped_df = df_certinho_sem_nulos.groupby(by=['CIE', 'CNPJ']).mean()


# In[41]:


# grouped_df.head(30)


# In[15]:


tipo_de_dados_CIE = df_certinho_sem_nulos['CIE'].dtypes


# In[16]:


user_item_matrix = grouped_df['nota'].unstack(fill_value=0)


# In[17]:


user_item_matrix


# In[18]:


valores_cie = user_item_matrix.index.unique()
# print(valores_cie)


# # Aplicação do modelo:

# In[19]:


#get_ipython().system('pip install scikit-surprise')


# In[20]:


from surprise import Dataset, Reader

reader = Reader(rating_scale=(0, 5))  # Defina a escala de classificação de acordo com seus dados
data = Dataset.load_from_df(user_item_matrix.stack().reset_index(), reader)


# In[21]:


from surprise.model_selection import train_test_split

trainset, testset = train_test_split(data, test_size=0.2)


# In[22]:


from surprise import SVD  # Substitua pelo algoritmo de sua escolha

model = SVD()  # Crie uma instância do modelo
model.fit(trainset)


# In[23]:


from surprise import accuracy

predictions = model.test(testset)

rmse = accuracy.rmse(predictions)  # Calcule a raiz do erro quadrático médio
mae = accuracy.mae(predictions)    # Calcule o erro absoluto médio

# print(f'RMSE: {rmse:.2f}')
# print(f'MAE: {mae:.2f}')


# In[24]:


def get_top_n(predictions, n=10):
    top_n = {}
    for uid, iid, true_r, est, _ in predictions:
        if uid not in top_n:
            top_n[uid] = []
        top_n[uid].append((iid, est))

    for uid, user_ratings in top_n.items():
        user_ratings.sort(key=lambda x: x[1], reverse=True)
        top_n[uid] = user_ratings[:n]

    return top_n

top_n_recommendations = get_top_n(predictions)


# In[36]:


from collections import defaultdict

# Crie um dicionário para armazenar as médias de notas para cada escola e fornecedor
media_notas = defaultdict(dict)

# Itere por todas as entregas no DataFrame (supondo que seu DataFrame seja chamado 'user_item_matrix')
for cie, row in user_item_matrix.iterrows():
    for cnpj, nota in row.items():
        if nota > 0:  # Certifique-se de que a nota seja maior que zero
            if cie not in media_notas:
                media_notas[cie] = {}
            if cnpj not in media_notas[cie]:
                media_notas[cie][cnpj] = []

            media_notas[cie][cnpj].append(nota)

# Encontre o melhor fornecedor para cada escola (o fornecedor com a nota média mais alta)
melhores_fornecedores = {}
for cie, fornecedores in media_notas.items():
    melhor_fornecedor = max(fornecedores, key=lambda c: sum(fornecedores[c]) / len(fornecedores[c]))
    melhores_fornecedores[cie] = melhor_fornecedor

# print(melhores_fornecedores)


# In[40]:


# Função para encontrar o melhor fornecedor com base no CIE inserido pelo usuário
async def encontrar_melhor_fornecedor(cie_inserido):
    cie_inserido_float = float(cie_inserido)  # Converte a entrada para float
    if cie_inserido_float in melhores_fornecedores:
        melhor_fornecedor = melhores_fornecedores[cie_inserido_float]
        return f"O melhor fornecedor para a escola com CIE {cie_inserido_float} é o CNPJ {melhor_fornecedor}."
    else:
        return f"O CIE {cie_inserido_float} não foi encontrado no conjunto de dados."

# Solicite ao usuário inserir o CIE
# cie_inserido = input("Insira o CIE da escola: ")

# Chame a função para encontrar o melhor fornecedor
# resultado = encontrar_melhor_fornecedor(cie_inserido)
# print(resultado)


# In[ ]:


#get_ipython().system('pip install flask')


# In[ ]:



import os
from dotenv import load_dotenv
import psycopg2 as postgresql

# Carrega variáveis de ambiente do arquivo .env
load_dotenv(dotenv_path=".env")

# Função para estabelecer conexão com o banco de dados do primeiro ano
def conexao_1ano():
    try:
        conn = postgresql.connect(os.getenv("LINK_1ANO_POSTGRESQL"))	
        if conn:
            return conn
        return None
    except Exception as e:
        print("conexao 1ano: ", e)

# Função para estabelecer conexão com o banco de dados do segundo ano
def conexao_2ano():
    try:
        conn = postgresql.connect(os.getenv("LINK_2ANO_POSTGRESQL"))	
        if conn:
            return conn
        return None
    except Exception as e:
        print("conexao 2ano: ", e)
# Função genérica para inserir dados em uma tabela
def insert(tabela, *valores):
    place_holders = "?," * len(valores)[:-1]  # Define os placeholders para os valores
    valores = tuple([tabela] + [i for i in valores])  # Agrupa tabela e valores

    try:
        conn = conexao_2ano()
        cursor = conn.cursor()
        
        # Executa o comando de inserção na tabela
        cursor.execute(f"INSERT INTO ? VALUES ({place_holders})", valores)
        conn.commit()
    except Exception as e:
        print("Insert: ", e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

# Função para atualizar registros de uma tabela
def update(tabela, campo_atualizar, valor_atualizar, campo_id, valor_id):
    try:
        conn = conexao_2ano()
        cursor = conn.cursor()
        
        # Executa o comando de atualização do registro
        cursor.execute("UPDATE ? SET ? = ? WHERE ?=?", (tabela, campo_atualizar, valor_atualizar, campo_id, valor_id))
        conn.commit()
    except Exception as e:
        print("Update: ", e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

# Função para apagar registros "suavemente" (soft delete)
def soft_delete(tabela, campo_id, *valores_id):
    place_holders = "?," * len(valores_id)[:-1]  # Define placeholders
    valores = tuple([tabela, campo_id] + [i for i in valores_id])  # Agrupa valores de exclusão

    try:
        conn = conexao_2ano()
        cursor = conn.cursor()
        
        # Executa o comando de exclusão com condição
        cursor.execute(f"""DELETE FROM ? 
                           WHERE ? IN ({place_holders})""", valores)
        conn.commit()
    except Exception as e:
        print("Soft delete: ", e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

# Função para apagar registros "fortemente" (hard delete)
def hard_delete(tabela, campo_id, *valores_id):
    place_holders = "?," * len(valores_id)[:-1]  # Define placeholders
    valores = tuple([tabela, campo_id] + [i for i in valores_id])  # Agrupa valores de exclusão

    try:
        conn = conexao_2ano()
        cursor = conn.cursor()
        
        # Marca o registro como desativado em vez de excluir
        cursor.execute(f"""UPDATE ? 
                           SET DT_DESATIVACAO = NOW()
                           WHERE ? IN ({place_holders})""", valores)
        conn.commit()
    except Exception as e:
        print("hard delete: ", e)
        conn.rollback()
    finally:
        cursor.close()
        conn.close()

# Função para contar registros entre duas tabelas e comparar
def count(tabela_1, tabela_2):
    try:
        conn_1ano = conexao_1ano()
        cursor_1ano = conn_1ano.cursor()
        
        conn_2ano = conexao_2ano()
        cursor_2ano = conn_2ano.cursor()
                 
        # Conta o número de registros em cada tabela
        quant_dados_1ano = cursor_1ano.execute(f"SELECT COUNT(*) FROM {tabela_1}").fetchone()[0]
        quant_dados_2ano = cursor_2ano.execute(f"SELECT COUNT(*) FROM {tabela_2}").fetchone()[0]
        
        return quant_dados_1ano, quant_dados_2ano
        
    except Exception as e:
        print("count: ", e)
    finally:
        conn_1ano.close()
        cursor_1ano.close()
        conn_2ano.close()
        cursor_2ano.close()

# Função para buscar e sincronizar dados entre duas tabelas
def buscar(tabela_1, tabela_2=None, query_1=None):
    try:
        if tabela_2 is None:
            tabela_2 = tabela_1  # Define tabela_2 como tabela_1 se não especificado
        
        conn_1ano = conexao_1ano()
        cursor_1ano = conn_1ano.cursor()
        
        conn_2ano = conexao_2ano()
        cursor_2ano = conn_2ano.cursor()
        
        dados_1ano_count, dados_2ano_count = count(tabela_1, tabela_2)  # Conta registros
        
        # INSERÇÃO E ATUALIZAÇÃO
        if dados_1ano_count >= dados_2ano_count:
            if query_1 is None:
                query_1 = """SELECT * FROM ?
                             WHERE EXTRACT(EPOCH FROM (NOW() - DT_ATUALIZACAO)) / 60 < 30
                             ORDER BY 0;"""
            
            dados_1ano = cursor_1ano.execute(query_1, (tabela_1,)).fetchall()
            ids_1ano = set([i[0] for i in dados_1ano])
            campo_id = [desc[0] for desc in cursor_2ano.description][0]
            placeholders = ', '.join(['?'] * len(ids_1ano))
            valores = tuple([tabela_2, campo_id] + [i for i in ids_1ano])

            dados_2ano = cursor_2ano.execute(f"""SELECT * FROM ? 
                                                 WHERE ? IN ({placeholders})
                                                 ORDER BY 0;""", valores)
            
            # Inserção de novos registros
            if dados_1ano > dados_2ano:
                inicio = dados_1ano.rowcount - dados_2ano.rowcount
                for i in dados_1ano[inicio:]:
                    insert(tabela_2, i)
            else:
                # Atualiza registros com diferenças
                for linha_1, linha_2 in zip(dados_1ano, dados_2ano):
                    for ind, coluna_1, coluna_2 in zip(enumerate(linha_1), linha_2):
                        if coluna_1 != coluna_2:
                            coluna = [desc[0] for desc in cursor_2ano.description][ind]
                            coluna_id = [desc[0] for desc in cursor_2ano.description][0]
                            update(tabela_2, coluna, coluna_1, coluna_id, linha_2[0])
        
        # EXCLUSÃO (DELETE)
        else:
            if query_1 is None:
                query_1 = cursor_2ano.execute(f"""SELECT * FROM ? 
                                                  ORDER BY 0;""", valores)
            
            dados_1ano = cursor_1ano.execute(query_1, (tabela_1,)).fetchall()
            dados_2ano = cursor_2ano.execute(f"""SELECT * FROM ? 
                                                 ORDER BY 0;""", valores)
            
            ids_1ano = set([i[0] for i in dados_1ano])
            ids_2ano = set([i[0] for i in dados_2ano])
            ids_delete = [i for i in dados_2ano if i[0] in (ids_2ano - ids_1ano)]
            campo_id = [desc[0] for desc in cursor_2ano.description][0]
           
            # Chama hard_delete ou soft_delete conforme tabela_1
            if tabela_1 == "frase_sustetavel":
                hard_delete(tabela_2, campo_id, ids_delete)
            else:
                soft_delete(tabela_2, campo_id, ids_delete)

    except Exception as e:
        print("buscar: ", e)
    finally:
        conn_1ano.close()
        cursor_1ano.close()
        conn_2ano.close()
        cursor_2ano.close()

# Exemplos de consultas personalizadas
query_produto = """SELECT p.id_produto, p.estoque, p.nome, p.ds_produto, p.preco, p.categoria, i.url_imagem
                   FROM produto p
                   JOIN imagem i ON p.id_produto = i.id_produto
                   WHERE EXTRACT(EPOCH FROM (NOW() - DT_ATUALIZACAO)) / 60 < 30
                   ORDER BY 0;"""
                      
query_avatar = """SELECT p.id_produto, p.estoque, p.nome, p.ds_produto, p.preco, p.categoria, a.url_avatar
                   FROM produto p
                   JOIN avatar a ON p.id_produto = a.id_avatar
                   WHERE EXTRACT(EPOCH FROM (NOW() - DT_ATUALIZACAO)) / 60 < 30
                   ORDER BY 0;"""
                   
query_tag = """SELECT t.id_tag, t.nome, t.descricao, t.dt_atualizacao
               FROM tag t
               WHERE EXTRACT(EPOCH FROM (NOW() - DT_ATUALIZACAO)) / 60 < 30"""
                   
# Exemplos de chamada da função buscar
buscar(tabela_1="frase_sustentavel")
buscar(tabela_1="tag")
buscar(tabela_1="evento_local", tabela_2="local")
buscar(tabela_1="produto", query_1=query_produto)
buscar(tabela_1="avatar", tabela_2="produto", query_1=query_produto)
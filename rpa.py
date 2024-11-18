import os
from dotenv import load_dotenv
import psycopg2 as postgresql
from collections.abc import Iterable
from datetime import datetime

# Carrega variáveis de ambiente do arquivo .env
load_dotenv(dotenv_path=".env")

# Função para estabelecer conexão com o banco de dados do primeiro ano
def conexao_1ano() -> postgresql:
	try:
		conn = postgresql.connect(os.getenv("LINK_1ANO_POSTGRESQL"))	
		if conn:
			print("Conexão 1 realizada com sucesso!")
			return conn
		return None
	except Exception as e:
		print("conexao 1ano: ", e)


# Função para estabelecer conexão com o banco de dados do segundo ano
def conexao_2ano() -> postgresql:
	try:
		conn = postgresql.connect(os.getenv("LINK_2ANO_POSTGRESQL"))	
		if conn:
			print("Conexão 2 realizada com sucesso!")
			return conn
		return None
	except Exception as e:
		print("conexao 2ano: ", e)

		
# Função genérica para inserir dados em uma tabela


def insert(tabela: str, valores: Iterable) -> None:
	try:
		conn = conexao_2ano()
		cursor = conn.cursor()
		
		valores = list(valores[:-1])+ [datetime.now()]
		valores = [
			valor.strftime("%Y-%m-%d %H:%M:%S") if isinstance(valor, datetime) else valor 
			for valor in valores
		]
		placeholders = ', '.join(['%s'] * len(valores))

		# Executa o comando de inserção na tabela com placeholders
		cursor.execute(f"""INSERT INTO {tabela} VALUES ({placeholders});""", valores)
		conn.commit()
		print("insert executado")
		
	except Exception as e:
		print("insert: ", e)
		conn.rollback()
	finally:
		cursor.close()
		conn.close()


# Função para atualizar registros de uma tabela
def update(tabela:str, campo_atualizar:str, valor_atualizar:str, campo_id:str, valor_id:str) -> None:
	try:
		conn = conexao_2ano()
		cursor = conn.cursor()
		
		# Executa o comando de atualização do registro
		cursor.execute(f"""
					   UPDATE {tabela} SET 
        				{campo_atualizar} = %s,
						dt_atualizacao = NOW()
					   WHERE {campo_id}= %s;""",(valor_atualizar,valor_id))
		conn.commit()
		print("update executado")
	except Exception as e:
		print("update: ", e)
		conn.rollback()
	finally:
		cursor.close()
		conn.close()					
		
		
# Função para apagar registros "suavemente" (soft delete)
def soft_delete(tabela:str, campo_id:str, valores_id:Iterable) -> None:
	valores = tuple(valores_id) 

	try:
		conn = conexao_2ano()
		cursor = conn.cursor()
		
		placeholders = ', '.join(['%s'] * len(valores))
		# Marca o registro como desativado em vez de excluir
		cursor.execute(f"""UPDATE {tabela}
						   SET DT_DESATIVACAO = NOW()
						   WHERE {campo_id} IN ({placeholders});""", tuple(valores_id))
		conn.commit()
		print("soft delete executado")
	except Exception as e:
		print("soft delete: ", e)
		conn.rollback()
	finally:
		cursor.close()
		conn.close()


# Função para apagar registros permanentemente (hard delete)
def hard_delete(tabela:str, campo_id:str, valores_id:Iterable) -> None:
	valores = tuple(valores_id)  

	try:
		conn = conexao_2ano()
		cursor = conn.cursor()
		
		# Executa o comando de exclusão com condição
		placeholders = ', '.join(['%s'] * len(valores))
		cursor.execute(f"""DELETE FROM {tabela}
						   WHERE {campo_id} IN ({placeholders});""",(valores_id))
		conn.commit()
		print("hard delete executado")
	except Exception as e:
		print("hard delete: ", e)
		conn.rollback()
	finally:
		cursor.close()
		conn.close()


# Função para contar registros entre duas tabelas e comparar
def count(tabela_1:str, tabela_2:str) -> tuple[int, int]:
	try:
		conn_1ano = conexao_1ano()
		cursor_1ano = conn_1ano.cursor()
		
		conn_2ano = conexao_2ano()
		cursor_2ano = conn_2ano.cursor()
				 
		# Conta o número de registros em cada tabela
		quant_dados_1ano = cursor_1ano.execute(f"SELECT COUNT(*) FROM {tabela_1}")
		quant_dados_1ano = cursor_1ano.fetchone()[0]
		quant_dados_2ano = cursor_2ano.execute(f"SELECT COUNT(*) FROM {tabela_2}")
		quant_dados_2ano = cursor_2ano.fetchone()[0]
		
		print("count realizado: 1ano: ", quant_dados_1ano, " 2ano: ", quant_dados_2ano)
		return quant_dados_1ano, quant_dados_2ano
		
	except Exception as e:
		print("count: ", e)
	finally:
		conn_1ano.close()
		cursor_1ano.close()
		conn_2ano.close()
		cursor_2ano.close()

# Função para buscar e sincronizar dados entre duas tabelas
def buscar(tabela_1:str, query_1:str, tabela_2:str=None,p_hard_delete:bool=False) -> None:
	try:
		if tabela_2 is None:
			tabela_2 = tabela_1  
		
		conn_1ano = conexao_1ano()
		cursor_1ano = conn_1ano.cursor()
		
		conn_2ano = conexao_2ano()
		cursor_2ano = conn_2ano.cursor()
		
		dados_1ano_count, dados_2ano_count = count(tabela_1, tabela_2) 
		
		# INSERÇÃO E ATUALIZAÇÃO
		if dados_1ano_count >= dados_2ano_count:
      
			dados_1ano = cursor_1ano.execute(query_1)
			dados_1ano = cursor_1ano.fetchall()

			ids_1ano = tuple([i[0] for i in dados_1ano])
			print(ids_1ano)
			placeholders = ', '.join(['%s'] * len(ids_1ano))
			print(f"({placeholders})")

			dados_2ano = cursor_2ano.execute(f"""SELECT * FROM {tabela_2} 
												 WHERE id_{tabela_2} IN ({placeholders})
												 ORDER BY 1;""",ids_1ano)
			dados_2ano = cursor_2ano.fetchall()
			
			# Inserção de novos registros
			if dados_1ano_count > dados_2ano_count:
				
				for i in dados_1ano[dados_2ano_count:]:
					print(i)
					insert(tabela=tabela_2,valores=i)
			else:
				# Atualiza registros com diferenças
				for linha_1, linha_2 in zip(dados_1ano, dados_2ano):
					linha_2 = linha_2[:-1] if hard_delete else linha_2[:-2]
					for ind, (coluna_1, coluna_2) in enumerate(zip(linha_1[:-1], linha_2)):
						coluna = [desc[0] for desc in cursor_2ano.description][ind]
						if coluna_1 != coluna_2:
							print(f"{coluna}: {coluna_1} -> {coluna_2}")
							coluna_id = [desc[0] for desc in cursor_2ano.description][0]
							print(f"{tabela_2} ({linha_2[0]}) -> {coluna} = {coluna_1} ")
							update(tabela_2, coluna, coluna_1, coluna_id, linha_2[0])
		
		# EXCLUSÃO (DELETE)
		else:
      
			dados_1ano = cursor_1ano.execute(f"""SELECT * FROM {tabela_1}
                                    			 ORDER BY 1;""")
			dados_1ano = cursor_1ano.fetchall()
		   			
			dados_2ano = cursor_2ano.execute(f"""SELECT * FROM {tabela_2}	 
												 ORDER BY 1;""")
			dados_2ano = cursor_2ano.fetchall()
			
			ids_1ano = set([i[0] for i in dados_1ano])
			ids_2ano = set([i[0] for i in dados_2ano])
			print(ids_1ano,ids_2ano)
			ids_delete = tuple([i[0] for i in dados_2ano if i[0] in (ids_2ano - ids_1ano)])
			campo_id = [desc[0] for desc in cursor_2ano.description][0]
		   
			# Chama hard_delete ou soft_delete conforme tabela_1
			if p_hard_delete:
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
query_frase_sustentavel = """SELECT f.id_frase_sustentavel, f.ds_frase, f.dt_frase, f.dt_atualizacao
							 FROM frase_sustentavel f
        					 WHERE EXTRACT(EPOCH FROM (NOW() - f.dt_atualizacao)) / 60 < 30
              				 ORDER BY 1;"""

query_tag = """SELECT t.id_tag, t.nome, t.descricao, t.dt_atualizacao
			   FROM tag t
			   WHERE EXTRACT(EPOCH FROM (NOW() - t.dt_atualizacao)) / 60 < 30	
			   ORDER BY 1;"""
      
query_local = """SELECT et.id_evento_local, et.nome, et.lat, et.lon, et.dt_func_ini, et.dt_func_fim, et.dt_atualizacao
			   FROM evento_local et
			   WHERE EXTRACT(EPOCH FROM (NOW() - et.dt_atualizacao)) / 60 < 30	
			   ORDER BY 1;"""
			   
query_produto = """SELECT p.id_produto, p.estoque, p.nome, p.ds_produto, p.preco, p.categoria, i.url_imagem, p.dt_atualizacao
				   FROM produto p
				   JOIN imagens i ON p.id_produto = i.id_produto
				   WHERE EXTRACT(EPOCH FROM (NOW() - p.dt_atualizacao)) / 60 < 30
				   ORDER BY 1;"""
					  
query_avatar = """SELECT p.id_produto, p.estoque, p.nome, p.ds_produto, p.preco, p.categoria, a.url_avatar, p_dt_atualizacao
				   FROM produto p
				   JOIN avatar a ON p.id_produto = a.id_avatar,
				   WHERE EXTRACT(EPOCH FROM (NOW() - p.dt_atualizacao)) / 60 < 30
				   ORDER BY 1;"""
				   
				   
# Exemplos de chamada da função buscar
buscar(tabela_1="frase_sustentavel",query_1=query_frase_sustentavel,p_hard_delete=True)
buscar(tabela_1="tag", query_1=query_tag)
buscar(tabela_1="evento_local", query_1=query_local,tabela_2="local")
buscar(tabela_1="produto", query_1=query_produto)
buscar(tabela_1="avatar", tabela_2="produto", query_1=query_produto)
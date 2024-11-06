import pymongo as mongo
from dotenv import load_dotenv
import os
from datetime import datetime

load_dotenv(dotenv_path=".env")

print(os.getenv("LINK_MONGO"))
conexao =  mongo.MongoClient(os.getenv("LINK_MONGO"))

collectionAvaliacao = conexao["dbPraceando"]["avaliacao"]
collectionRecorrencia = conexao["dbPraceando"]["recorrencia"]
collectionConquista = conexao["dbPraceando"]["conquista"]
collectionConquistaUsusario = conexao["dbPraceando"]["conquista_usuario"]


# Inserindo avaliações com comentários variados
print("Avaliações: \n")
collectionAvaliacao.insert_many([
    {
        "id_avaliacao": 1,
        "cd_evento": 1,
        "cd_usuario": 1,
        "nota": 5,
        "comentario": "Evento incrível! Superou minhas expectativas.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 2,
        "cd_evento": 1,
        "cd_usuario": 3,
        "nota": 4,
        "comentario": "Gostei do evento, mas poderia ter mais opções de alimentação.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 3,
        "cd_evento": 1,
        "cd_usuario": 5,
        "nota": 3,
        "comentario": "Achei que o evento foi mediano, precisa de mais atrações.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 4,
        "cd_evento": 1,
        "cd_usuario": 7,
        "nota": 5,
        "comentario": "Excelente organização, com certeza participarei novamente.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 5,
        "cd_evento": 1,
        "cd_usuario": 9,
        "nota": 4,
        "comentario": "Muito bom, mas faltaram algumas atividades para crianças.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 6,
        "cd_evento": 2,
        "cd_usuario": 2,
        "nota": 5,
        "comentario": "Adorei o evento, foi muito divertido!",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 7,
        "cd_evento": 2,
        "cd_usuario": 4,
        "nota": 4,
        "comentario": "O evento foi bem organizado, mas estava muito cheio.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 8,
        "cd_evento": 2,
        "cd_usuario": 6,
        "nota": 3,
        "comentario": "O evento estava ok, mas esperava mais atrações culturais.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 9,
        "cd_evento": 2,
        "cd_usuario": 8,
        "nota": 5,
        "comentario": "Tudo muito bem organizado, amei!",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 10,
        "cd_evento": 2,
        "cd_usuario": 10,
        "nota": 4,
        "comentario": "Gostei do evento, só poderia ser em um local maior.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 11,
        "cd_evento": 3,
        "cd_usuario": 3,
        "nota": 5,
        "comentario": "Evento muito bom para quem gosta de artesanato!",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 12,
        "cd_evento": 3,
        "cd_usuario": 5,
        "nota": 3,
        "comentario": "Os produtos artesanais eram bonitos, mas um pouco caros.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 13,
        "cd_evento": 3,
        "cd_usuario": 7,
        "nota": 4,
        "comentario": "Um bom evento para a família, muito tranquilo.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 14,
        "cd_evento": 3,
        "cd_usuario": 9,
        "nota": 5,
        "comentario": "Maravilhoso! Vários produtos artesanais de qualidade.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 15,
        "cd_evento": 3,
        "cd_usuario": 11,
        "nota": 4,
        "comentario": "Evento organizado e ambiente muito agradável.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 16,
        "cd_evento": 4,
        "cd_usuario": 1,
        "nota": 4,
        "comentario": "A música estava ótima, ambiente agradável e seguro.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 17,
        "cd_evento": 4,
        "cd_usuario": 6,
        "nota": 5,
        "comentario": "Excelente banda, valeu muito a pena.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 18,
        "cd_evento": 4,
        "cd_usuario": 8,
        "nota": 3,
        "comentario": "Evento bom, mas o espaço estava muito lotado.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 19,
        "cd_evento": 4,
        "cd_usuario": 10,
        "nota": 4,
        "comentario": "Ambiente seguro e confortável, recomendo.",
        "data_atualizacao": datetime.now().isoformat()
    },
    {
        "id_avaliacao": 20,
        "cd_evento": 4,
        "cd_usuario": 12,
        "nota": 5,
        "comentario": "Ambiente familiar, muito seguro e divertido.",
        "data_atualizacao": datetime.now().isoformat()
    }
])

import pymongo as mongo
from dotenv import load_dotenv
import os
from datetime import datetime

# Carregando variáveis de ambiente
load_dotenv(dotenv_path=".env")

# Conectando ao MongoDB
conexao = mongo.MongoClient(os.getenv("LINK_MONGO"))

# Definindo a coleção de recorrência
collectionRecorrencia = conexao["dbPraceando"]["recorrencia"]

# Inserindo recorrências diárias para os eventos
print("Recorrências: \n")
collectionRecorrencia.insert_many([
    {
        "id_recorrencia": 1,
        "id_evento": 1,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 2,
        "id_evento": 2,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 3,
        "id_evento": 3,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 4,
        "id_evento": 4,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 5,
        "id_evento": 5,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 6,
        "id_evento": 6,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 7,
        "id_evento": 7,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    },
    {
        "id_recorrencia": 8,
        "id_evento": 8,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now().isoformat()
    }
])



print("Conquistas: \n")
collectionConquista.insert_many([
    {
        "id_conquista": 1,
        "nm_conquista": "Aventurante do Parque",
        "ds_conquista": "Participe de 5 eventos realizados em parques diferentes.",
        "vl_meta": 5,
        "nm_tipo": "Consumidor",
        "nm_categoria": "evento",
        "qt_polen": 50,
    },
    {
        "id_conquista": 2,
        "nm_conquista": "Explorador Cultural",
        "ds_conquista": "Participe de 10 eventos culturais e ganhe um avatar exclusivo.",
        "vl_meta": 10,
        "nm_tipo": "Consumidor",
        "nm_categoria": "evento",
        "id_avatar": 1,
    },
    {
        "id_conquista": 3,
        "nm_conquista": "Amante dos Pets",
        "ds_conquista": "Leve seu pet a 3 eventos pet-friendly e ganhe um avatar exclusivo.",
        "vl_meta": 3,
        "nm_tipo": "Consumidor",
        "nm_categoria": "evento",
        "id_avatar": 2,
    },
    {
        "id_conquista": 4,
        "nm_conquista": "Organizador de Ouro",
        "ds_conquista": "Crie 5 eventos com pelo menos 50 participantes cada.",
        "vl_meta": 5,
        "nm_tipo": "Anunciante",
        "nm_categoria": "evento",
        "qt_polen": 100,
    },
    {
        "id_conquista": 5,
        "nm_conquista": "Parceiro da Comunidade",
        "ds_conquista": "Faça parceria com outros anunciantes e organize 3 eventos colaborativos.",
        "vl_meta": 3,
        "nm_tipo": "Anunciante",
        "nm_categoria": "evento",
        "qt_polen": 40,
    },
    {
        "id_conquista": 6,
        "nm_conquista": "Gourmet de Praça",
        "ds_conquista": "Avalie 3 eventos gastronômicos diferentes.",
        "vl_meta": 3,
        "nm_tipo": "Consumidor",
        "nm_categoria": "avaliacao",
        "qt_polen": 30,
    },
    {
        "id_conquista": 7,
        "nm_conquista": "Estrela da Feira",
        "ds_conquista": "Organize uma feira que receba avaliações positivas de pelo menos 30 participantes.",
        "vl_meta": 30,
        "nm_tipo": "Anunciante",
        "nm_categoria": "avaliacao",
        "qt_polen": 70,
    },
    {
        "id_conquista": 8,
        "nm_conquista": "Influenciador Local",
        "ds_conquista": "Faça um evento que tenha mais de 50 interessados.",
        "vl_meta": 50,
        "nm_tipo": "Anunciante",
        "nm_categoria": "interesse",
        "qt_polen": 100
    },
    {
        "id_conquista": 9,
        "nm_conquista": "Colecionador de Faces",
        "ds_conquista": "Compre 5 avatares e ganhe um outro personagem premium de graça.",
        "vl_meta": 5,
        "nm_tipo": "Anunciante",
        "nm_categoria": "compra",
        "id_avatar": 4,
    },
    {
        "id_conquista": 10,
        "nm_conquista": "Frequentador Assíduo",
        "ds_conquista": "Participe de eventos todos os finais de semana durante um mês.",
        "vl_meta": 4, 
        "nm_tipo": "Consumidor",
        "nm_categoria": "compra",
        "qt_polen": 60,
    },
    {
        "id_conquista": 11,
        "nm_conquista": "Campeão do Bem-Estar",
        "ds_conquista": "Participe de 3 eventos fitness em parques e praças.",
        "vl_meta": 3,
        "nm_tipo": "Consumidor",
        "nm_categoria": "evento",
        "qt_polen": 35,
    },
    {
        "id_conquista": 12,
        "nm_conquista": "Embaixador do Verde",
        "ds_conquista": "Participe de um evento ecológico em busca do reflorestamento.",
        "vl_meta": 1,
        "nm_tipo": "Anunciante",
        "nm_categoria": "evento",
        "qt_polen": 90,
    },
    {
        "id_conquista": 13,
        "nm_conquista": "Desbravador Tecnológico",
        "ds_conquista": "Se interesse por 5 eventos relacionados à tecnologia.",
        "vl_meta": 5,
        "nm_tipo": "Consumidor",
        "nm_categoria": "evento",
        "qt_polen": 20,
    },
    {
        "id_conquista": 14,
        "nm_conquista": "Guardião Cultural",
        "ds_conquista": "Organize um evento que promova a cultura local.",
        "vl_meta": 1,
        "nm_tipo": "Anunciante",
        "nm_categoria": "evento",
        "id_avatar": 5,
    }
])

print("Conquistas Usuário: \n")
collectionConquistaUsusario.insert_many([
    {"id_conquista_user": 1, "cd_usuario": 1, "cd_conquista": 1, "vl_atingido": 3},
    {"id_conquista_user": 2, "cd_usuario": 1, "cd_conquista": 10, "vl_atingido": 2},
    {"id_conquista_user": 3, "cd_usuario": 2, "cd_conquista": 2, "vl_atingido": 2},
    {"id_conquista_user": 4, "cd_usuario": 2, "cd_conquista": 12, "vl_atingido": 5},
    {"id_conquista_user": 5, "cd_usuario": 3, "cd_conquista": 1, "vl_atingido": 5},
    {"id_conquista_user": 6, "cd_usuario": 3, "cd_conquista": 14, "vl_atingido": 3},
    {"id_conquista_user": 7, "cd_usuario": 4, "cd_conquista": 4, "vl_atingido": 3},
    {"id_conquista_user": 8, "cd_usuario": 5, "cd_conquista": 3, "vl_atingido": 2},
    {"id_conquista_user": 9, "cd_usuario": 5, "cd_conquista": 12, "vl_atingido": 1},
    {"id_conquista_user": 10, "cd_usuario": 6, "cd_conquista": 10, "vl_atingido": 4},
    {"id_conquista_user": 11, "cd_usuario": 7, "cd_conquista": 1, "vl_atingido": 2},
    {"id_conquista_user": 12, "cd_usuario": 8, "cd_conquista": 14, "vl_atingido": 1},
    {"id_conquista_user": 13, "cd_usuario": 9, "cd_conquista": 2, "vl_atingido": 3},
    {"id_conquista_user": 14, "cd_usuario": 10, "cd_conquista": 12, "vl_atingido": 5},
    {"id_conquista_user": 15, "cd_usuario": 11, "cd_conquista": 3, "vl_atingido": 4},
    {"id_conquista_user": 16, "cd_usuario": 12, "cd_conquista": 4, "vl_atingido": 3},
    {"id_conquista_user": 17, "cd_usuario": 12, "cd_conquista": 14, "vl_atingido": 2},
    {"id_conquista_user": 18, "cd_usuario": 13, "cd_conquista": 5, "vl_atingido": 5},
    {"id_conquista_user": 19, "cd_usuario": 13, "cd_conquista": 7, "vl_atingido": 30},
    {"id_conquista_user": 20, "cd_usuario": 14, "cd_conquista": 6, "vl_atingido": 1},
    {"id_conquista_user": 21, "cd_usuario": 14, "cd_conquista": 9, "vl_atingido": 8},
    {"id_conquista_user": 22, "cd_usuario": 15, "cd_conquista": 8, "vl_atingido": 3},
    {"id_conquista_user": 23, "cd_usuario": 16, "cd_conquista": 13, "vl_atingido": 1},
    {"id_conquista_user": 24, "cd_usuario": 17, "cd_conquista": 7, "vl_atingido": 10},
    {"id_conquista_user": 25, "cd_usuario": 17, "cd_conquista": 15, "vl_atingido": 1},
    {"id_conquista_user": 26, "cd_usuario": 18, "cd_conquista": 6, "vl_atingido": 3},
    {"id_conquista_user": 27, "cd_usuario": 18, "cd_conquista": 11, "vl_atingido": 50},
    {"id_conquista_user": 28, "cd_usuario": 19, "cd_conquista": 5, "vl_atingido": 4},
    {"id_conquista_user": 29, "cd_usuario": 20, "cd_conquista": 13, "vl_atingido": 1},
    {"id_conquista_user": 30, "cd_usuario": 20, "cd_conquista": 15, "vl_atingido": 2}
])

conexao.close()

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

collectionConquista
    
# inserindo avaliações
print("Avaliações: \n")
collectionAvaliacao.insert_many([
    {
        "id_avaliacao": 1,
        "cd_evento": 1,
        "cd_usuario": 1,
        "nota": 5,
        "comentario": "Evento incrível! Superou minhas expectativas.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 2,
        "cd_evento": 1,
        "cd_usuario": 3,
        "nota": 4,
        "comentario": "Gostei do evento, mas poderia ter mais opções de alimentação.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 3,
        "cd_evento": 1,
        "cd_usuario": 5,
        "nota": 3,
        "comentario": "Achei que o evento foi mediano, precisa de mais atrações.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 4,
        "cd_evento": 1,
        "cd_usuario": 7,
        "nota": 5,
        "comentario": "Excelente organização, com certeza participarei novamente.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 5,
        "cd_evento": 1,
        "cd_usuario": 9,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 6,
        "cd_evento": 2,
        "cd_usuario": 2,
        "nota": 5,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 7,
        "cd_evento": 2,
        "cd_usuario": 4,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 8,
        "cd_evento": 2,
        "cd_usuario": 6,
        "nota": 3,
        "comentario": "O evento estava ok, mas esperava mais atrações culturais.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 9,
        "cd_evento": 2,
        "cd_usuario": 8,
        "nota": 5,
        "comentario": "Tudo muito bem organizado, amei!",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 10,
        "cd_evento": 2,
        "cd_usuario": 10,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 11,
        "cd_evento": 3,
        "cd_usuario": 3,
        "nota": 5,
        "comentario": "Evento muito bom para quem gosta de artesanato!",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 12,
        "cd_evento": 3,
        "cd_usuario": 5,
        "nota": 3,
        "comentario": "Os produtos artesanais eram bonitos, mas um pouco caros.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 13,
        "cd_evento": 3,
        "cd_usuario": 7,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 14,
        "cd_evento": 3,
        "cd_usuario": 9,
        "nota": 5,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 15,
        "cd_evento": 3,
        "cd_usuario": 11,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 16,
        "cd_evento": 4,
        "cd_usuario": 1,
        "nota": 4,
        "comentario": "A música estava ótima, ambiente agradável e seguro.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 17,
        "cd_evento": 4,
        "cd_usuario": 6,
        "nota": 5,
        "comentario": "Excelente banda, valeu muito a pena.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 18,
        "cd_evento": 4,
        "cd_usuario": 8,
        "nota": 3,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 19,
        "cd_evento": 4,
        "cd_usuario": 10,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 20,
        "cd_evento": 4,
        "cd_usuario": 12,
        "nota": 5,
        "comentario": "Ambiente familiar, muito seguro e divertido.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 21,
        "cd_evento": 5,
        "cd_usuario": 2,
        "nota": 5,
        "comentario": "Corrida bem organizada, ótimo para praticar esporte com a família.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 22,
        "cd_evento": 5,
        "cd_usuario": 4,
        "nota": 4,
        "comentario": "Gostei bastante, principalmente do apoio ao longo do percurso.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 23,
        "cd_evento": 5,
        "cd_usuario": 6,
        "nota": 4,
        "comentario": "Uma experiência ótima para quem gosta de correr.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 24,
        "cd_evento": 5,
        "cd_usuario": 9,
        "nota": 5,
        "comentario": "Parabéns aos organizadores! Evento incrível.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 25,
        "cd_evento": 6,
        "cd_usuario": 3,
        "nota": 5,
        "comentario": "Muito relaxante, as aulas de yoga foram incríveis.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 26,
        "cd_evento": 6,
        "cd_usuario": 5,
        "nota": 4,
        "comentario": "A meditação guiada foi ótima, me senti muito bem.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 27,
        "cd_evento": 6,
        "cd_usuario": 7,
        "nota": 3,
        "comentario": "Acho que poderia ter mais instrutores para atender a todos.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 28,
        "cd_evento": 6,
        "cd_usuario": 11,
        "nota": 5,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 29,
        "cd_evento": 6,
        "cd_usuario": 12,
        "nota": 4,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 30,
        "cd_evento": 7,
        "cd_usuario": 1,
        "nota": 5,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 31,
        "cd_evento": 7,
        "cd_usuario": 4,
        "nota": 4,
        "comentario": "Ambiente ótimo para os pets, bem organizado.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 32,
        "cd_evento": 7,
        "cd_usuario": 6,
        "nota": 3,
        "comentario": "Gostei, mas o espaço estava um pouco pequeno para a quantidade de pets.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 33,
        "cd_evento": 7,
        "cd_usuario": 9,
        "nota": 5,
        "comentario": "Meu cachorro amou, farei questão de voltar!",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 34,
        "cd_evento": 8,
        "cd_usuario": 2,
        "nota": 5,
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 35,
        "cd_evento": 8,
        "cd_usuario": 5,
        "nota": 4,
        "comentario": "Muito educativo, aprendi bastante sobre adestramento.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 36,
        "cd_evento": 8,
        "cd_usuario": 8,
        "nota": 5,
        "comentario": "Instrutores bem qualificados e prestativos.",
        "data_atualizacao": datetime.now()
    },
    {
        "id_avaliacao": 37,
        "cd_evento": 8,
        "cd_usuario": 11,
        "nota": 4,
        "data_atualizacao": datetime.now()
    }
])


# Inserir as recorrências
print("Recorrencias: \n")
collectionRecorrencia.insert_many([
    {
        "id_recorrencia": 1,
        "id_evento": 1,
        "nm_tipo": "Diária",
        "dt_atualizacao": datetime.now(),
    },
    {
        "id_recorrencia": 2,
        "id_evento": 2,
        "nm_tipo": "Semanal",
        "dt_atualizacao": datetime.now(),
        "ds_dias_semana": ["sábado","domingo"],
    },
    {
        "id_recorrencia": 3,
        "id_evento": 3,
        "nm_tipo": "Mensal",
        "dt_atualizacao": datetime.now(),
        "nr_dia_mes": 15
    }
])

print("conquistas: \n")
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
        "ds_conquista": "Faça um evento que que tenha mais de 50 interessados.",
        "vl_meta": 50,
        "nm_tipo": "Anunciante",
        "nm_categoria": "interesse",
        "qt_polen": 100
    },
    {
        "id_conquista": 9,
        "nm_conquista": "Colecionador de faces",
        "ds_conquista": "Compre 5 avatares e ganhe um outro personagem premium de graça ",
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
        "nm_categoria": "local",
        "qt_polen": 35,
    },
    {
        "id_conquista": 12,
        "nm_conquista": "Embaixador do Verde",
        "ds_conquista": "Participe de um evento ecológico em busca do reflorestamento.",
        "vl_meta": 1,
        "qt_atividade": 20,
        "nm_tipo": "Anunciante",
        "nm_categoria": "local",
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


print("Conquistsas usuário: \n")
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
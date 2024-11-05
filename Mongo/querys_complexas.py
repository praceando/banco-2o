# Querypara eventos populares
eventos_populares = [
    {"$lookup": {
        "from": "evento",
        "localField": "cd_evento",
        "foreignField": "cd_evento",
        "as": "evento"
    }},
    {"$unwind": "$evento"},
    {"$match": {"evento.cd_anunciante": 15}},
    {"$group": {
        "_id": "$cd_evento",
        "total_avaliacoes": {"$sum": 1},
        "nome_evento": {"$first": "$evento.nm_evento"},
        "media_nota": {"$avg": "$nota"}
    }},
    {"$sort": {"total_avaliacoes": -1}},
    {"$limit": 5}
]

# Querys para média da nota total
media_nota_total = [
    {"$lookup": {
        "from": "evento",
        "localField": "cd_evento",
        "foreignField": "cd_evento",
        "as": "evento"
    }},
    {"$unwind": "$evento"},
    {"$match": {"evento.cd_anunciante": 15}},
    {"$group": {"_id": None, "media_nota": {"$avg": "$nota"}}}
]

# Query para média das notas por evento
media_notas_evento = [
    {"$lookup": {
        "from": "evento",
        "localField": "cd_evento",
        "foreignField": "cd_evento",
        "as": "evento"
    }},
    {"$unwind": "$evento"},
    {"$match": {"evento.cd_anunciante": 15}},
    {"$group": {"_id": "$cd_evento", "media_nota": {"$avg": "$nota"}}},
    {"$sort": {"media_nota": -1}}
]

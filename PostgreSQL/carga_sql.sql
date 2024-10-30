INSERT INTO frase_sustentavel (id_frase_sustentavel, ds_frase_sustentavel, dt_frase_sustentavel) VALUES 
(1, 'Preserve os parques e deixe um legado para as futuras gerações.', '2024-01-15'),
(2, 'Em cada caminhada pelo parque, uma chance de se conectar com a natureza.', '2024-02-18'),
(3, 'Respeite a natureza: os parques são o coração verde das cidades.', '2024-03-10'),
(4, 'Vamos fazer dos parques um lugar livre de lixo. A natureza agradece.', '2024-04-22'),
(5, 'A sustentabilidade começa com pequenas atitudes, como cuidar dos nossos parques.', '2024-05-08'),
(6, 'Desfrute dos parques e proteja o meio ambiente ao mesmo tempo.', '2024-06-12'),
(7, 'Cada árvore plantada é um passo em direção a um futuro melhor.', '2024-07-07'),
(8, 'Deixe apenas pegadas, leve apenas memórias. Preserve os parques.', '2024-08-14'),
(9, 'A saúde da natureza reflete na nossa saúde. Cuide dos parques.', '2024-09-05'),
(10, 'Os parques são espaços de paz e bem-estar, vamos preservá-los juntos.', '2024-10-01'),
(11, 'Valorize o verde da sua cidade, visite e cuide dos parques locais.', '2024-11-11'),
(12, 'Cuidar dos parques é cuidar da nossa qualidade de vida.', '2024-12-25'),
(13, 'O respeito ao meio ambiente é o maior presente que podemos dar ao planeta.', '2024-06-18'),
(14, 'Pratique a sustentabilidade: reduza, reutilize e recicle nos parques.', '2024-03-23'),
(15, 'Vamos juntos transformar os parques em lugares melhores para todos.', '2024-05-13'),
(16, 'Um parque limpo depende de cada um de nós. Faça sua parte.', '2024-04-29'),
(17, 'Eduque seus filhos a respeitar a natureza desde cedo.', '2024-02-10'),
(18, 'Nosso futuro é verde: cuide das árvores dos parques.', '2024-09-12'),
(19, 'O meio ambiente precisa de nós, e os parques são um bom começo.', '2024-08-30'),
(20, 'Mais árvores, mais vida. Plante e cuide dos parques.', '2024-07-19');


INSERT INTO genero (id_genero,ds_genero) 
VALUES 
    (1,'Feminino'),
    (2,'Masculino'),
    (3,'Prefiro não informar'),
    (4,'Outro');


INSERT INTO acesso (id_acesso, nm_acesso) 
VALUES 
    (1,'CONSUMIDOR'),
    (2,'ANUNCIANTE'),
    (5,'DESLOGADO');


INSERT INTO usuario (cd_acesso, cd_inventario_avatar, cd_genero, nm_usuario, ds_email, ds_senha, is_premium, ds_usuario)
VALUES 
    (1, NULL, 1, 'João Silva', 'joao.silva@example.com', 'senha123', TRUE, 'Entusiasta de eventos culturais'),
    (2, NULL, 1, 'Maria Souza', 'maria.souza@example.com', 'senha456', FALSE, 'Apreciadora de gastronomia'),
    (1, NULL, 1, 'Carlos Oliveira', 'carlos.oliveira@example.com', 'senha789', TRUE, 'Amante de esportes ao ar livre'),
    (2, NULL, 1, 'Ana Lima', 'ana.lima@example.com', 'senha321', FALSE, 'Interessada em sustentabilidade'),
    (1, NULL, 1, 'Rafael Abravanel', 'rafael.costa@example.com', 'senha654', TRUE, 'Explorador de eventos tecnológicos'),
    (2, NULL, 1, 'Fernanda Alves', 'fernanda.alves@example.com', 'senha987', FALSE, 'Curiosa sobre culturas locais'),
    (1, NULL, 1, 'Gabriel Martins', 'gabriel.martins@example.com', 'senha852', TRUE, 'Participante assíduo de eventos musicais'),
    (2, NULL, 1, 'Juliana Rodrigues', 'juliana.rodrigues@example.com', 'senha741', FALSE, 'Gosta de atividades de lazer com a família'),
    (1, NULL, 1, 'Rodrigo Pereira', 'rodrigo.pereira@example.com', 'senha963', TRUE, 'Interessado em feiras de artesanato'),
    (2, NULL, 1, 'Patrícia Oliveira', 'patricia.oliveira@example.com', 'senha159', FALSE, 'Apreciadora de atividades culturais'),
    (1, NULL, 1, 'Lucas Santos', 'lucas.santos@example.com', 'senha753', TRUE, 'Focado em eventos de saúde e bem-estar'),
    (2, NULL, 1, 'Beatriz Fernandes', 'beatriz.fernandes@example.com', 'senha258', FALSE, 'Exploradora de atividades ao ar livre'),
    (1, NULL, 2, 'Felipe Andrade', 'felipe.andrade@example.com', 'senha963', TRUE, 'Organizador de eventos gastronômicos'),
    (2, NULL, 2, 'Sofia Barbosa', 'sofia.barbosa@example.com', 'senha753', FALSE, 'Especialista em eventos culturais'),
    (1, NULL, 2, 'Miguel Ferreira', 'miguel.ferreira@example.com', 'senha159', TRUE, 'Promotor de eventos esportivos'),
    (2, NULL, 2, 'Laura Moraes', 'laura.moraes@example.com', 'senha852', FALSE, 'Responsável por eventos de lazer e pets'),
    (1, NULL, 2, 'Thiago Oliveira', 'thiago.oliveira@example.com', 'senha147', TRUE, 'Organizador de eventos de dança e música'),
    (2, NULL, 2, 'Camila Silva', 'camila.silva@example.com', 'senha369', FALSE, 'Produtora de eventos familiares'),
    (1, NULL, 2, 'André Almeida', 'andre.almeida@example.com', 'senha951', TRUE, 'Focado em feiras ecológicas'),
    (2, NULL, 2, 'Bruna Batista', 'bruna.batista@example.com', 'senha753', FALSE, 'Eventos de tecnologia e educação');

INSERT INTO consumidor (id_consumidor, dt_nascimento, nm_nickname, nr_polen, is_possivel_anunciar)
VALUES 
    (1, '1990-05-12', 'joaosilva90', 0, FALSE),
    (2, '1985-08-22', 'mariasouza85', 0, FALSE),
    (3, '1992-11-10', 'carlosoliveira', 0, FALSE),
    (4, '1998-03-15', 'analima98', 0, FALSE),
    (5, '2000-06-18', 'rafaelcosta', 0, FALSE),
    (6, '1994-09-25', 'fernandaalves', 0, FALSE),
    (7, '1996-12-05', 'gabrielmartins', 0, FALSE),
    (8, '1993-01-20', 'julianarodrigues', 0, FALSE),
    (9, '1987-02-17', 'rodrigopereira', 0, FALSE),
    (10, '1991-07-09', 'patriciaoliveira', 0, FALSE),
    (11, '1989-10-13', 'lucassantos', 0, FALSE),
    (12, '2001-04-02', 'beatrizfernandes', 0, FALSE);


INSERT INTO anunciante (id_anunciante, dt_nascimento, nm_empresa, nr_cnpj)
VALUES 
    (13, '1980-08-30', 'Sabores da Praça', '12345678000101'),
    (14, '1986-02-14', 'Cultura em Movimento', '12345678000102'),
    (15, '1990-06-21', 'Vida Ativa', '12345678000103'),
    (16, '1995-03-11', 'PetFun', '12345678000104'),
    (17, '1988-12-23', 'Dance Fest', '12345678000105'),
    (18, '1987-05-19', 'Família & Diversão', '12345678000106'),
    (19, '1992-04-07', 'EcoFeira', '12345678000107'),
    (20, '1993-11-29', 'TechEdu', '12345678000108');


INSERT INTO local (id_local,nm_local, nr_lat, nr_long,hr_abertura, hr_fechamento) VALUES 
(1,'Parque Cidade de Toronto',-23.5072, -46.6249, '06:00:00','18:00:00'),
(2,'Parque Anhanguera',-23.4699, -46.6301,'06:00:00','18:00:00'),
(3,'Parque Sena',-23.4672, -46.6111,'06:00:00','18:00:00'),
(4,'Parque da Juventude',-23.5011, -46.7404,'06:00:00','19:00:00'),
(5,'Parque Heróis da FEB',-23.4948, -46.5763,'00:00:00','23:59:59'),
(6,'Parque Vista Verde',-23.5143, -46.6042,'00:00:00','23:59:59');

INSERT INTO tag (id_tag, nm_tag, ds_categoria) VALUES 
(1,'Alimentação', 'Eventos e atividades relacionados a comidas, bebidas, e experiências gastronômicas.'),
(2,'Artesanato', 'Feiras e eventos de artesanato, produtos manuais e artesanais, e oficinas criativas.'),
(3,'Música', 'Apresentações musicais ao vivo, shows, festivais de música e atividades relacionadas a bandas e cantores.'),
(4,'Dança', 'Eventos e workshops de dança, apresentações de grupos de dança e festivais culturais relacionados.'),
(5,'Esportes', 'Competições, treinos ao ar livre, e eventos de prática esportiva como corridas, ciclismo e atividades físicas.'),
(6,'Lazer', 'Atividades recreativas para todas as idades, incluindo jogos ao ar livre, piqueniques e diversão em grupo.'),
(7,'Pets', 'Eventos pet-friendly, incluindo encontros de animais de estimação, adestramento e atividades para pets.'),
(8,'Cultura', 'Feiras culturais, exposições, eventos tradicionais e atividades que promovem o patrimônio cultural.'),
(9,'Fitness', 'Aulas de ginástica, ioga, atividades de bem-estar físico e eventos relacionados ao estilo de vida saudável.'),
(10,'Saúde', 'Eventos voltados à saúde e bem-estar, incluindo consultas, feiras de saúde e atividades educativas.'),
(11,'Educação', 'Workshops, cursos, feiras de livros e atividades voltadas ao aprendizado e capacitação.'),
(12,'Tecnologia', 'Feiras de tecnologia, eventos sobre inovação, startups, palestras e demonstrações tecnológicas.'),
(13,'Ecologia', 'Atividades e eventos que promovem a conscientização ambiental e práticas sustentáveis, como plantio de árvores.'),
(14,'Sustentabilidade', 'Feiras e encontros que discutem práticas sustentáveis, produtos ecológicos e conscientização sobre o meio ambiente.'),
(15,'Família', 'Atividades e eventos voltados para a interação familiar, como brincadeiras, feiras e atividades para pais e filhos.');


CALL PRC_INSERIR_USUARIO_TAG(1, NULL, ARRAY['Alimentação', 'Artesanato', 'Lazer']);
CALL PRC_INSERIR_USUARIO_TAG(2, NULL, ARRAY['Alimentação', 'Saúde', 'Cultura']);
CALL PRC_INSERIR_USUARIO_TAG(3, NULL, ARRAY['Artesanato', 'Cultura', 'Saúde']);
CALL PRC_INSERIR_USUARIO_TAG(4, NULL, ARRAY['Lazer', 'Música', 'Dança']);
CALL PRC_INSERIR_USUARIO_TAG(5, NULL, ARRAY['Esportes', 'Fitness', 'Saúde']);
CALL PRC_INSERIR_USUARIO_TAG(6, NULL, ARRAY['Pets', 'Sustentabilidade', 'Lazer']);
CALL PRC_INSERIR_USUARIO_TAG(7, NULL, ARRAY['Música', 'Esportes', 'Dança']);
CALL PRC_INSERIR_USUARIO_TAG(8, NULL, ARRAY['Lazer', 'Cultura', 'Pets']);
CALL PRC_INSERIR_USUARIO_TAG(9, NULL, ARRAY['Artesanato', 'Cultura', 'Lazer']);
CALL PRC_INSERIR_USUARIO_TAG(10, NULL, ARRAY['Saúde', 'Fitness', 'Alimentação']);
CALL PRC_INSERIR_USUARIO_TAG(11, NULL, ARRAY['Cultura', 'Esportes', 'Saúde']);
CALL PRC_INSERIR_USUARIO_TAG(12, NULL, ARRAY['Lazer', 'Artesanato', 'Pets']);


CALL PRC_INSERIR_EVENTO_TAG('Festival de Comida Artesanal','Um evento que reúne os melhores produtores de comida artesanal da região, com demonstrações ao vivo e degustações.','2024-10-15','10:00:00','2024-10-16','18:00:00','http://saborespraca.com/festival',1,13,ARRAY['Alimentação', 'Artesanato', 'Lazer']);
CALL PRC_INSERIR_EVENTO_TAG('Feira Gastronômica na Praça','Uma feira ao ar livre com opções de comidas típicas e artesanais, promovendo pequenos empreendedores locais.','2024-11-10','09:00:00','2024-11-10','17:00:00','http://saborespraca.com/feira',3,14,ARRAY['Alimentação', 'Lazer']);
CALL PRC_INSERIR_EVENTO_TAG('Encontro Cultural de Artesanato','Um evento para valorizar a cultura local e o artesanato, com produtos feitos por artesãos da cidade.','2024-12-05','10:00:00','2024-12-05','20:00:00','http://culturaemmovimento.com/artesanato',2,15,ARRAY['Artesanato', 'Cultura', 'Lazer']);
CALL PRC_INSERIR_EVENTO_TAG('Mostra de Música Popular','Apresentação de bandas e grupos locais, trazendo o melhor da música popular em um ambiente familiar.','2024-12-20','18:00:00','2024-12-20','22:00:00','http://culturaemmovimento.com/musica',4,16,ARRAY['Música', 'Dança']);
CALL PRC_INSERIR_EVENTO_TAG('Corrida de Rua São Paulo Ativa','Uma corrida para todas as idades, promovendo a saúde e o bem-estar na região.','2024-10-21','07:00:00','2024-10-21','11:00:00','http://vidaativa.com/corrida',1,17,ARRAY['Esportes', 'Saúde', 'Fitness']);
CALL PRC_INSERIR_EVENTO_TAG('Festival de Yoga e Meditação','Um festival dedicado ao bem-estar com aulas de yoga, meditação guiada e palestras sobre saúde.','2024-11-30','08:00:00','2024-11-30','17:00:00','http://vidaativa.com/yoga',5,18,ARRAY['Fitness', 'Saúde']);
CALL PRC_INSERIR_EVENTO_TAG('Pet Day no Parque','Encontro para donos e pets, com diversas atividades, palestras sobre cuidados e um espaço para adoção.','2024-10-12','09:00:00','2024-10-12','15:00:00','http://petfun.com/petday',6,19,ARRAY['Pets', 'Lazer', 'Sustentabilidade']);
CALL PRC_INSERIR_EVENTO_TAG('Aula Aberta de Adestramento','Aulas gratuitas de adestramento para donos de pets, com dicas de treinamento básico.','2024-11-25','10:00:00','2024-11-25','13:00:00','http://petfun.com/adestramento',2,20,ARRAY['Pets', 'Saúde']);

-- Exemplo de chamadas para registrar interesses específicos de consumidores nos eventos
CALL PRC_INSERIR_USUARIO_TAG(1, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(2, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(3, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(4, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(5, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(6, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(7, 1, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(8, 1, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(2, 2, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(3, 2, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(5, 2, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(7, 2, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(1, 2, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(4, 2, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(8, 3, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(9, 3, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(10, 3, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(11, 3, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(12, 3, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(2, 4, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(3, 4, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(5, 4, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(7, 4, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(9, 4, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(10, 5, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(11, 5, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(12, 5, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(1, 5, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(2, 5, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(3, 6, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(4, 6, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(5, 6, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(7, 6, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(9, 6, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(1, 7, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(4, 7, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(5, 7, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(8, 7, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(9, 7, NULL); 

CALL PRC_INSERIR_USUARIO_TAG(11, 8, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(12, 8, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(1, 8, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(3, 8, NULL); 
CALL PRC_INSERIR_USUARIO_TAG(6, 8, NULL); 


INSERT INTO produto (id_produto,qt_estoque, nm_produto, ds_produto, vl_preco, nm_categoria) VALUES 
(1,100, 'Camiseta Ecológica', 'Camiseta produzida com algodão orgânico e tintas naturais, ideal para quem quer vestir sustentabilidade.', 59.90, 'Vestuário'),
(2,150, 'Caneca de Bambu Reutilizável', 'Caneca feita de bambu sustentável, perfeita para substituir copos descartáveis e reduzir o impacto ambiental.', 34.90, 'Utilidades Domésticas'),
(3,200, 'Ecobag Sustentável', 'Bolsa reutilizável feita com fibras de garrafas PET recicladas, resistente e estilosa para usar no dia a dia.', 24.90, 'Acessórios');

-- Compras de eventos usando PRC_REALIZAR_COMPRA
CALL PRC_REALIZAR_COMPRA(13, NULL, 1, 24.90);
CALL PRC_REALIZAR_COMPRA(14, NULL, 2, 15.90);
CALL PRC_REALIZAR_COMPRA(15, NULL, 3, 15.90);
CALL PRC_REALIZAR_COMPRA(16, NULL, 4, 15.90);
CALL PRC_REALIZAR_COMPRA(17, NULL, 5, 15.90);
CALL PRC_REALIZAR_COMPRA(18, NULL, 6, 15.90);
CALL PRC_REALIZAR_COMPRA(19, NULL, 7, 15.90);
CALL PRC_REALIZAR_COMPRA(20, NULL, 8, 15.90);


-- Compras de produtos usando PRC_REALIZAR_COMPRA
CALL PRC_REALIZAR_COMPRA(1, 1, NULL, 59.90);
CALL PRC_REALIZAR_COMPRA(2, 2, NULL, 34.90);
CALL PRC_REALIZAR_COMPRA(5, 2, NULL, 34.90);
CALL PRC_REALIZAR_COMPRA(7, 1, NULL, 59.90);
CALL PRC_REALIZAR_COMPRA(9, 3, NULL, 24.90);
CALL PRC_REALIZAR_COMPRA(11, 1, NULL, 59.90);
CALL PRC_REALIZAR_COMPRA(15, 2, NULL, 34.90);
CALL PRC_REALIZAR_COMPRA(20, 2, NULL, 34.90);


-- Pagamentos realizados para as compras concluídas
CALL PRC_ATUALIZAR_STATUS_COMPRA(1);
CALL PRC_ATUALIZAR_STATUS_COMPRA(3);
CALL PRC_ATUALIZAR_STATUS_COMPRA(4);
CALL PRC_ATUALIZAR_STATUS_COMPRA(6);
CALL PRC_ATUALIZAR_STATUS_COMPRA(7);
CALL PRC_ATUALIZAR_STATUS_COMPRA(8);
CALL PRC_ATUALIZAR_STATUS_COMPRA(9);
CALL PRC_ATUALIZAR_STATUS_COMPRA(10);
CALL PRC_ATUALIZAR_STATUS_COMPRA(11);
CALL PRC_ATUALIZAR_STATUS_COMPRA(12);
CALL PRC_ATUALIZAR_STATUS_COMPRA(13);
CALL PRC_ATUALIZAR_STATUS_COMPRA(15);

SELECT * FROM log_usuario;
SELECT * FROM log_local;
SELECT * FROM log_tag;
SELECT * FROM log_evento;
SELECT * FROM log_frase_sustentavel;
SELECT * FROM log_produto;
SELECT * FROM log_compra;
SELECT * FROM log_pagamento;
SELECT * FROM usuario;
SELECT * FROM consumidor;
SELECT * FROM anunciante;
SELECT * FROM usuario_tag;
SELECT * FROM genero;
SELECT * FROM acesso;
SELECT * FROM local;
SELECT * FROM tag;
SELECT * FROM evento;
SELECT * FROM evento_tag;
SELECT * FROM interesse;
SELECT * FROM frase_sustentavel;
SELECT * FROM produto;
SELECT * FROM compra;
SELECT * FROM pagamento;

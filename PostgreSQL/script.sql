-- SCRIPT BANCO DE DADOS NORMALIZADO POSTGRESQL

/*
================================================
         PADRONIZAÇÃO DE VARIÁVEIS                   
================================================

nr - número
qt - quantidade
vl - valor
dt - data
nm - nome
ds - descrição 
id - PK
cd - FK
*/

/*
================================================
                    USUÁRIO                   
================================================
*/

CREATE TABLE genero (
    id_genero SERIAL PRIMARY KEY,
    ds_genero VARCHAR(255),
    dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE acesso (
    id_acesso SERIAL PRIMARY KEY,
    nm_acesso VARCHAR(255) NOT NULL UNIQUE,
    dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
	cd_acesso INTEGER,
    cd_inventario_avatar INTEGER,
    cd_genero INTEGER,
    nm_usuario VARCHAR(255),
    ds_email VARCHAR(255),
    ds_senha VARCHAR(255),
    is_premium BOOLEAN,
    ds_usuario TEXT,
    dt_criacao TIMESTAMP DEFAULT NOW(),
    dt_desativacao TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (cd_genero) REFERENCES genero(id_genero),
    FOREIGN KEY (cd_acesso) REFERENCES acesso(id_acesso)
);


CREATE TABLE consumidor (
    id_consumidor INTEGER PRIMARY KEY,
    dt_nascimento DATE CHECK (dt_nascimento < CURRENT_DATE),
    nm_nickname VARCHAR(255) UNIQUE,
    nr_polen INTEGER DEFAULT 0,
    is_possivel_anunciar BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (id_consumidor) REFERENCES usuario(id_usuario)
);

CREATE TABLE anunciante (
    id_anunciante INTEGER PRIMARY KEY,
    dt_nascimento DATE CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, dt_nascimento)) >= 16),
    nm_empresa VARCHAR(255),
    nr_cnpj VARCHAR(14) UNIQUE,
    FOREIGN KEY (id_anunciante) REFERENCES usuario(id_usuario)
);


/*
================================================
*                  EVENTO                      *
================================================
*/

CREATE TABLE local (
    id_local SERIAL PRIMARY KEY,
    nm_local VARCHAR(255),
    nr_lat DECIMAL(10, 6),   
    nr_long DECIMAL(10, 6),
    hr_abertura TIME,
    hr_fechamento TIME,
    dt_desativacao TIMESTAMP,
    dt_atualizacao TIMESTAMP DEFAULT NOW()
    
);


CREATE TABLE tag (
    id_tag SERIAL PRIMARY KEY,
    nm_tag VARCHAR(255),
    ds_categoria VARCHAR(255),
    dt_desativacao TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE usuario_tag(
    id_usuario_tag SERIAL PRIMARY KEY,
    cd_consumidor INTEGER,
    cd_tag INTEGER,
    FOREIGN KEY (cd_consumidor) REFERENCES consumidor(id_consumidor),
    FOREIGN KEY (cd_tag) REFERENCES tag(id_tag)
);


CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    cd_local INTEGER,
    cd_anunciante INTEGER,
    qt_interesse INTEGER DEFAULT 0,
    nm_evento VARCHAR(255),
    ds_evento TEXT,
    dt_inicio DATE,
    hr_inicio TIME,
    dt_fim DATE,
    hr_fim TIME,
    url_documentacao TEXT,
    dt_desativacao TIMESTAMP,
    dt_atualizacao TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (cd_local) REFERENCES local(id_local),
    FOREIGN KEY (cd_anunciante) REFERENCES anunciante(id_anunciante)
);


CREATE TABLE evento_tag (
    id_evento_tag SERIAL PRIMARY KEY,
    cd_tag INTEGER,
    cd_evento INTEGER,
    dt_atualizao TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (cd_tag) REFERENCES tag(id_tag),
    FOREIGN KEY (cd_evento) REFERENCES evento(id_evento)
);


CREATE TABLE interesse (
    id_interesse SERIAL PRIMARY KEY,
    cd_consumidor INTEGER,
    cd_evento INTEGER,
    dt_atualizacao TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (cd_consumidor) REFERENCES usuario(id_usuario),
    FOREIGN KEY (cd_evento) REFERENCES evento(id_evento)
);


/*
================================================
                    APP                   
================================================
*/

CREATE TABLE frase_sustentavel (
    id_frase_sustentavel SERIAL PRIMARY KEY,
	ds_frase_sustentavel TEXT,
	dt_frase_sustentavel TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW()
);

CREATE TABLE produto (
    id_produto SERIAL PRIMARY KEY,
    qt_estoque INTEGER DEFAULT 0 CHECK (qt_estoque >= 0),
    nm_produto VARCHAR(255),
    ds_produto TEXT,
    vl_preco DECIMAL,
    nm_categoria VARCHAR(255),
    url_imagem TEXT,
    dt_desativacao TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE compra (
    id_compra SERIAL PRIMARY KEY,
    cd_usuario INTEGER,
    cd_produto INTEGER,
	cd_evento INTEGER,
    dt_compra TIMESTAMP DEFAULT NOW(),
    vl_total DECIMAL(10, 2),
    ds_status VARCHAR(255) DEFAULT 'Pendente',
    dt_atualizacao TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (cd_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (cd_produto) REFERENCES produto(id_produto),
	FOREIGN KEY (cd_evento) REFERENCES evento(id_evento)
);


CREATE TABLE pagamento (
	id_pagamento SERIAL PRIMARY KEY,
	cd_compra INTEGER,
	dt_pagamento TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW(),
	FOREIGN KEY (cd_compra) REFERENCES compra(id_compra)
);


TRUNCATE TABLE log_usuario RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_local RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_tag RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_evento RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_frase_sustentavel RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_produto RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_compra RESTART IDENTITY CASCADE;
TRUNCATE TABLE log_pagamento RESTART IDENTITY CASCADE;
TRUNCATE TABLE usuario RESTART IDENTITY CASCADE;
TRUNCATE TABLE consumidor RESTART IDENTITY CASCADE;
TRUNCATE TABLE anunciante RESTART IDENTITY CASCADE;
TRUNCATE TABLE genero RESTART IDENTITY CASCADE;
TRUNCATE TABLE acesso RESTART IDENTITY CASCADE;
TRUNCATE TABLE local RESTART IDENTITY CASCADE;
TRUNCATE TABLE tag RESTART IDENTITY CASCADE;
TRUNCATE TABLE evento RESTART IDENTITY CASCADE;
TRUNCATE TABLE evento_tag RESTART IDENTITY CASCADE;
TRUNCATE TABLE interesse RESTART IDENTITY CASCADE;
TRUNCATE TABLE frase_sustentavel RESTART IDENTITY CASCADE;
TRUNCATE TABLE produto RESTART IDENTITY CASCADE;
TRUNCATE TABLE compra RESTART IDENTITY CASCADE;
TRUNCATE TABLE pagamento RESTART IDENTITY CASCADE;


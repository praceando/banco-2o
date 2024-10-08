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
    nm_acesso VARCHAR(255) NOT NULL UNIQUE
    dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    cd_inventario_avatar INT,
    cd_genero INT,
    nm_usuario VARCHAR(255),
    ds_email VARCHAR(255),
    ds_senha VARCHAR(255),
    is_premium BOOLEAN,
    ds_usuario TEXT,
    dt_criacao TIMESTAMP DEFAULT NOW(),
    dt_desativacao TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW(),
    cd_acesso INT,
	
    FOREIGN KEY (cd_genero) REFERENCES genero(id_genero),
    FOREIGN KEY (cd_acesso) REFERENCES acesso(id_acesso)
);


CREATE TABLE consumidor (
	dt_nascimento DATE CHECK (dt_nascimento < CURRENT_DATE),
    nm_nickname VARCHAR(255) UNIQUE,
    nr_polen INT DEFAULT 0)
	INHERITS (usuario);

CREATE TABLE anunciante (
	dt_nascimento DATE CHECK (EXTRACT(YEAR FROM AGE(CURRENT_DATE, dt_nascimento)) >= 16),
    nm_empresa VARCHAR(255),
    nr_cnpj VARCHAR(14) UNIQUE,
    nr_telefone VARCHAR(14) UNIQUE)
	INHERITS (usuario);

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
    dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE tag (
    id_tag SERIAL PRIMARY KEY,
    nm_tag VARCHAR(255),
    ds_categoria VARCHAR(255),
	dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    cd_local INT,
    cd_anunciante INT,
    qt_interesse INT DEFAULT 0,
    nm_evento VARCHAR(255),
    ds_evento TEXT,
    dt_inicio DATE,
    hr_inicio TIME,
    dt_fim DATE,
    hr_fim TIME,
    url_documentacao TEXT,
    dt_atualizacao TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (cd_local) REFERENCES local(id_local),
    FOREIGN KEY (cd_anunciante) REFERENCES usuario(id_usuario)
);


CREATE TABLE evento_tag (
    id_evento_tag SERIAL PRIMARY KEY,
    cd_tag INT,
    cd_evento INT,
    dt_atualizao TIMESTAMP DEFAULT NOW(),

    FOREIGN KEY (cd_tag) REFERENCES tag(id_tag),
    FOREIGN KEY (cd_evento) REFERENCES evento(id_evento)
);


CREATE TABLE interesse (
    id_interesse SERIAL PRIMARY KEY,
    cd_consumidor INT,
    cd_evento INT,
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
    id_frase SERIAL PRIMARY KEY,
	ds_frase TEXT,
	dt_frase TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE produto (
    id_produto SERIAL PRIMARY KEY,
    qt_estoque INT DEFAULT 0 CHECK (qt_estoque >= 0),
    nm_produto VARCHAR(255),
    ds_produto TEXT,
    vl_preco DECIMAL,
    url_imagem TEXT,
    nm_categoria VARCHAR(255),
    dt_desativacao TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW()
);


CREATE TABLE compra (
    id_compra SERIAL PRIMARY KEY,
    cd_usuario INT,
    cd_produto INT,
	cd_evento INT,
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
	cd_compra INT,
	dt_pagamento TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (cd_compra) REFERENCES compra(id_compra)
);
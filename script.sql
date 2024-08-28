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
                    APP                   
================================================
*/

CREATE TABLE frase_sustentavel (
    id_frase SERIAL PRIMARY KEY,
	ds_frase TEXT,
	dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE
);


CREATE TABLE produto (
    id_produto SERIAL PRIMARY KEY,
    nr_estoque INT DEFAULT 0 CHECK (estoque >= 0),
    nm_produto VARCHAR(255),
    ds_produto TEXT,
    vl_preco DECIMAL CHECK (preco >= 1),
    url_imagem TEXT,
    nm_categoria VARCHAR(255),
    dt_desativacao TIMESTAMP,
	 dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE
);


CREATE TABLE compra (
    id_compra SERIAL PRIMARY KEY,
    cd_usuario INT,
    cd_produto INT,
	cd_evento INT,
    dt_compra TIMESTAMP DEFAULT CURRENT_DATE,
    vl_total DECIMAL(10, 2),
    ds_status VARCHAR(255),
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE,

    FOREIGN KEY (cod_usuario) REFERENCES consumidor(id_usuario),
    FOREIGN KEY (cod_produto) REFERENCES produto(id_produto)
	FOREIGN KEY (cod_evento) REFERENCES produto(id_evento)
);


CREATE TABLE pagamento (
	id_pagamento SERIAL PRIMARY KEY,
	cd_compra INT,
	dt_pagamento TIMESTAMP,
	dt_atualizacao TIMESTAMP
	
	FOREIGN KEY (cod_compra) REFERENCES compra(id_compra)
);


/*
================================================
                    USUÁRIO                   
================================================
*/

CREATE TABLE genero (
    id_genero SERIAL PRIMARY KEY,
    ds_genero VARCHAR(255),
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE
);


CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    cd_inventario_avatar INT,
    cd_genero INT,
    nm_usuario VARCHAR(255),
    ds_email VARCHAR(255),
    is_premium BOOLEAN,
    ds_usuario TEXT,
    dt_nascimento DATE CHECK (dt_nascimento < CURRENT_DATE),
    dt_criacao TIMESTAMP DEFAULT CURRENT_DATE,
    dt_desativacao TIMESTAMP,
	dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE,
	
    FOREIGN KEY (cd_genero) REFERENCES genero(id_genero)
);


CREATE TABLE consumidor (
    nm_nickname VARCHAR(255),
    nr_polen INT DEFAULT 0,
) INHERITS (usuario);

CREATE TABLE anunciante (
    nm_empresa VARCHAR(255),
    nr_cnpj VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(14) UNIQUE,
) INHERITS (usuario);


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
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE
);


CREATE TABLE tag (
    id_tag SERIAL PRIMARY KEY,
    nm_tag VARCHAR(255),
    ds_categoria VARCHAR(255),
	dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE,
);


CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    cd_local INT,
    cd_anunciante INT,
    qt_interesse INT,
    nm_evento VARCHAR(255) NOT NULL,
    ds_evento TEXT,
    dt_inicio TIMESTAMP,
    dt_fim TIMESTAMP,
    url_documentacao TEXT,
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE,

    FOREIGN KEY (cd_local) REFERENCES local(id_local),
    FOREIGN KEY (cd_anunciante) REFERENCES anunciante(id_usuario)
);


CREATE TABLE evento_tag (
    id_evento_tag SERIAL PRIMARY KEY,
    cd_tag INT,
    cd_evento INT,
    dt_atualizao TIMESTAMP DEFAULT CURRENT_DATE,

    FOREIGN KEY (cd_tag) REFERENCES tag(id_tag),
    FOREIGN KEY (cd_evento) REFERENCES evento(id_evento)
);


CREATE TABLE interesse (
    id_interesse SERIAL PRIMARY KEY,
    cd_consumidor INT,
    cd_evento INT,
    dt_atualizacao TIMESTAMP DEFAULT CURRENT_DATE,

    FOREIGN KEY (cd_consumidor) REFERENCES consumidor(id_usuario),
    FOREIGN KEY (cd_evento) REFERENCES evento(id_evento)
);


    dt_atualizacao TIMESTAMP DEFAULT current_date,

    FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    FOREIGN KEY (id_consumidor) REFERENCES consumidor(id_consumidor)
);
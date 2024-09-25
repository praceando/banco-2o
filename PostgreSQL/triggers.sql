-- SCRIPT TRIGGERS

/*
================================================
         DESATIVAÇÃO USUÁRIO                 
================================================
*/

CREATE OR REPLACE FUNCTION fnc_desativar_usuario() RETURNS TRIGGER AS $$
BEGIN 
	UPDATE usuario SET dt_desativacao75=CURRENT_DATE 
	WHERE usuario.id_usuario = OLD.id_usuario;

	IF (SELECT OLD.nr_cnpj IS NOT NULL) THEN
		UPDATE evento SET dt_desativacao=CURRENT_DATE
		WHERE evento.cd_anunciante=OLD.id_usuario;
	END IF;
	
	RETURN OLD;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER trg_desativar_usuario
	BEFORE UPDATE OF dt_desativacao ON usuario
	FOR EACH ROW EXECUTE FUNCTION fnc_desativar_usuario();


/*
================================================
         QUANTIDADE DE INTERESSE             
================================================
*/
CREATE OR REPLACE FUNCTION fnc_atualiza_qt_interesse()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE evento
    SET qt_interesse = qt_interesse + 1
    WHERE id_evento = NEW.cd_evento;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trg_atualiza_qt_interesse
AFTER INSERT ON interesse
FOR EACH ROW
EXECUTE FUNCTION atualiza_qt_interesse();


/*
================================================
         LOG USUÁRIO                
================================================
*/

CREATE TABLE log_usuario(
	id_log SERIAL PRIMARY KEY,
	cd_usuario INT,
	us_operacao VARCHAR(255),
	nm_operacao VARCHAR(10),
	dt_operacao DATE,

	FOREIGN KEY (cd_usuario) REFERENCES usuario(id_usuario)
);

CREATE OR REPLACE FUNCTION fnc_log_usuario() RETURNS TRIGGER AS $$
DECLARE
	v_us_operacao VARCHAR(80);
	v_cd_tabela INT;
BEGIN 

	SELECT USENAME FROM PG_USER INTO v_us_operacao ;

	IF (SELECT TG_OP IS NOT 'DELETE') THEN
		SELECT OLD.id_usuario into v_cd_tabela;
	ELSE
		SELECT NEW.id_usuario into v_cd_tabela;
	END IF;
	
	INSERT INTO log_usuario(cd_tabela,us_operacao,nm_operacao,dt_operacao)
	VALUES(v_cd_tabela,v_us_operacao,TG_OP,CURRENT_DATE);
	
	RETURN OLD;
END;
$$ LANGUAGE 'pgplsql';

CREATE OR REPLACE TRIGGER trg_log_usuario
	AFTER INSERT OR UPDATE OR DELETE ON usuario
	FOR EACH ROW EXECUTE FUNCTION fnc_log_usuario()


/*
================================================
         LOG PRODUTO                
================================================
*/

CREATE TABLE log_produto(
	id_log SERIAL PRIMARY KEY,
	cd_produto INT,
	us_operacao VARCHAR(255),
	nm_operacao VARCHAR(10),
	dt_operacao DATE,

	FOREIGN KEY (cd_produto) REFERENCES produto(id_produto)
);

CREATE OR REPLACE FUNCTION fnc_log_produto() RETURNS TRIGGER AS $$
DECLARE
	v_us_operacao VARCHAR(80);
	v_cd_tabela INT;
BEGIN 

	SELECT USENAME FROM PG_USER INTO v_us_operacao;

	IF (SELECT TG_OP IS NOT 'DELETE') THEN
		SELECT OLD.id_produto into v_cd_tabela;
	ELSE
		SELECT NEW.id_produto into v_cd_tabela;
	END IF;
	
	INSERT INTO log_produto(cd_tabela,us_operacao,nm_operacao,dt_operacao)
	VALUES(v_cd_tabela,v_us_operacao,TG_OP,CURRENT_DATE);

	RETURN OLD;
END;
$$ LANGUAGE 'pgplsql';

CREATE OR REPLACE TRIGGER trg_log_produto
	AFTER INSERT OR UPDATE OR DELETE ON produto
	FOR EACH ROW EXECUTE FUNCTION fnc_log_produto()


/*
================================================
         LOG COMPRA                
================================================
*/

CREATE TABLE log_compra(
	id_log SERIAL PRIMARY KEY,
	cd_compra INT,
	us_operacao VARCHAR(255),
	nm_operacao VARCHAR(10),
	dt_operacao DATE,

	FOREIGN KEY (cd_usuario) REFERENCES compra(id_compra)
);

CREATE OR REPLACE FUNCTION fnc_log_compra() RETURNS TRIGGER AS $$
DECLARE
	v_us_operacao VARCHAR(80);
	v_cd_tabela INT;
BEGIN 

	SELECT USENAME FROM PG_USER INTO v_us_operacao;

	IF (SELECT TG_OP IS NOT 'DELETE') THEN
		SELECT OLD.id_compra into v_cd_tabela;
	ELSE
		SELECT NEW.id_comprainto v_cd_tabela;
	END IF;
	
	INSERT INTO log_compra(cd_tabela,us_operacao,nm_operacao,dt_operacao)
	VALUES(v_cd_tabela,v_us_operacao,TG_OP,CURRENT_DATE);

	RETURN OLD;
END;
$$ LANGUAGE 'pgplsql';

CREATE OR REPLACE TRIGGER trg_log_compra
	AFTER INSERT OR UPDATE OR DELETE ON compra
	FOR EACH ROW EXECUTE FUNCTION fnc_log_compra()


/*
================================================
         LOG PAGAMENTO                
================================================
*/

CREATE TABLE log_pagamento(
	id_log SERIAL PRIMARY KEY,
	cd_pagamento INT,
	us_operacao VARCHAR(255),
	nm_operacao VARCHAR(10),
	dt_operacao DATE,

	FOREIGN KEY (cd_pagamento) REFERENCES pagamento(id_pagamento)
);

CREATE OR REPLACE FUNCTION fnc_log_pagamento() RETURNS TRIGGER AS $$
DECLARE
	v_us_operacao VARCHAR(80);
	v_cd_tabela INT;
BEGIN 

	SELECT USENAME FROM PG_USER INTO v_us_operacao;

	IF (SELECT TG_OP IS NOT 'DELETE') THEN
		SELECT OLD.id_pagamento into v_cd_tabela;
	ELSE
		SELECT NEW.id_pagamento into v_cd_tabela;
	END IF;
	
	INSERT INTO log_pagamento(cd_tabela,us_operacao,nm_operacao,dt_operacao)
	VALUES(v_cd_tabela,v_us_operacao,TG_OP,CURRENT_DATE);

	RETURN OLD;
END;
$$ LANGUAGE 'pgplsql';

CREATE OR REPLACE TRIGGER trg_log_pagamento
	AFTER INSERT OR UPDATE OR DELETE ON pagamento
	FOR EACH ROW EXECUTE FUNCTION fnc_log_pagamento()



/*
================================================
         LOG DE EVENTO           
================================================
*/

CREATE TABLE log_evento (
	id_log SERIAL PRIMARY KEY,
	cd_pagamento INT,
	us_operacao VARCHAR(255),
	nm_operacao VARCHAR(10),
	dt_operacao DATE,
);


CREATE OR REPLACE FUNCTION fnc_log_evento() RETURNS TRIGGER AS $$
DECLARE
	v_us_operacao VARCHAR(80);
	v_cd_tabela INT;
BEGIN 

	SELECT USENAME FROM PG_USER INTO v_us_operacao;

	IF (SELECT TG_OP IS NOT 'DELETE') THEN
		SELECT OLD.id_pagamento into v_cd_tabela;
	ELSE
		SELECT NEW.id_pagamento into v_cd_tabela;
	END IF;
	
	INSERT INTO log_pagamento(cd_tabela,us_operacao,nm_operacao,dt_operacao)
	VALUES(v_cd_tabela,v_us_operacao,TG_OP,CURRENT_DATE);
	
	RETURN OLD;
END;
$$ LANGUAGE 'pgplsql';

CREATE TRIGGER trg_log_evento
AFTER INSERT OR UPDATE OR DELETE ON evento
FOR EACH ROW
EXECUTE FUNCTION fnc_log_evento();


/*
================================================
         LOG DE TAG           
================================================
*/

CREATE TABLE log_tag (
	id_log SERIAL PRIMARY KEY,
	cd_pagamento INT,
	us_operacao VARCHAR(255),
	nm_operacao VARCHAR(10),
	dt_operacao DATE,
);

CREATE OR REPLACE FUNCTION fnc_log_tag() RETURNS TRIGGER AS $$
DECLARE
	v_us_operacao VARCHAR(80);
	v_cd_tabela INT;
BEGIN 

	SELECT USENAME FROM PG_USER INTO v_us_operacao;

	IF (SELECT TG_OP IS NOT 'DELETE') THEN
		SELECT OLD.id_pagamento into v_cd_tabela;
	ELSE
		SELECT NEW.id_pagamento into v_cd_tabela;
	END IF;

	INSERT INTO log_pagamento(cd_tabela,us_operacao,nm_operacao,dt_operacao)
	VALUES(v_cd_tabela,v_us_operacao,TG_OP,CURRENT_DATE);

	RETURN OLD;
END;
$$ LANGUAGE 'pgplsql';


CREATE TRIGGER trg_log_tag
AFTER INSERT OR UPDATE OR DELETE ON tag
FOR EACH ROW
EXECUTE FUNCTION fnc_log_tag();

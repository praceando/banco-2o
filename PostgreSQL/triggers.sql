-- SCRIPT TRIGGERS

/*
================================================
         DESATIVAÇÃO USUÁRIO                 
================================================
*/

CREATE OR REPLACE FUNCTION fnc_desativar_usuario() RETURNS TRIGGER AS $$
BEGIN 
    IF OLD.dt_desativacao IS NULL THEN 
        UPDATE evento 
        SET dt_desativacao = NOW()
        WHERE cd_anunciante = OLD.id_usuario; 
    END IF;
    
    RETURN NEW; 
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE TRIGGER trg_desativar_usuario
    BEFORE UPDATE OF dt_desativacao ON usuario
    FOR EACH ROW EXECUTE FUNCTION fnc_desativar_usuario();


/*
================================================
         DESATIVAÇÃO LOCAL                 
================================================
*/

CREATE OR REPLACE FUNCTION func_desativar_local()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.dt_desativacao IS NOT NULL THEN
        UPDATE evento SET dt_desativacao = NEW.dt_desativacao
        WHERE cd_local = NEW.id_local AND dt_desativacao IS NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_desativar_local
AFTER UPDATE OF dt_desativacao ON local
FOR EACH ROW
WHEN (OLD.dt_desativacao IS NULL AND NEW.dt_desativacao IS NOT NULL)
EXECUTE FUNCTION func_desativar_local();



/*

================================================
         QUANTIDADE DE INTERESSE             
================================================
*/
CREATE OR REPLACE FUNCTION fnc_atualizar_qt_interesse()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE evento SET 
	    qt_interesse = qt_interesse + 1,
		dt_atualizacao = NOW()
    WHERE id_evento = NEW.cd_evento;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_atualiza_qt_interesse
AFTER INSERT ON interesse
FOR EACH ROW
EXECUTE FUNCTION fnc_atualiza_qt_interesse();

/*
================================================
        ASSINATURA PREMIUM                 
================================================
*/
CREATE OR REPLACE FUNCTION func_tornar_usuario_premium()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cd_produto = 4 THEN  
        UPDATE usuario
        SET is_premium = TRUE
        WHERE id_usuario = NEW.cd_usuario;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_comprar_premium
AFTER INSERT ON compra
FOR EACH ROW
EXECUTE FUNCTION func_tornar_usuario_premium();


/*
================================================
    FUNÇÃO DE LOG       
================================================
*/
CREATE EXTENSION IF NOT EXISTS hstore;

CREATE OR REPLACE FUNCTION fnc_log_geral() RETURNS TRIGGER AS $$
DECLARE
    v_nm_usuario VARCHAR(80);
    v_cd_tabela INTEGER;
	v_nm_pk VARCHAR(80);
    v_nm_fk VARCHAR(80);
    v_diferencas hstore;
    v_campo VARCHAR(255);
    v_vl_campo_old VARCHAR(255);
    v_vl_campo_new VARCHAR(255);
    v_nm_tabela_log VARCHAR(255);  -- Variável para o nome da tabela de log
BEGIN
    -- Pegando o nome do usuário da sessão atual
    SELECT USENAME FROM PG_USER INTO v_nm_usuario;

    -- Gerar o nome da tabela de log dinamicamente
    SELECT 'log_' || TG_TABLE_NAME INTO v_nm_tabela_log;

	-- Gerar o nome da coluna dinamicamente
	SELECT 'id_' || TG_TABLE_NAME INTO v_nm_pk;

		-- Gerar o nome da coluna dinamicamente
	SELECT 'cd_' || TG_TABLE_NAME INTO v_nm_fk;

    -- Ação INSERT
    IF (TG_OP = 'INSERT') THEN
        -- Query dinâmica para pegar o valor da primeira coluna
        EXECUTE 'SELECT ($1).' || quote_ident(v_nm_pk) USING NEW INTO v_cd_tabela;
        
        -- Inserir os dados no log (agora com o nome da tabela de log dinâmico)
        EXECUTE 'INSERT INTO ' || quote_ident(v_nm_tabela_log) || '(' || quote_ident(v_nm_fk) ||',nm_usuario, nm_operacao, dt_operacao) 
                 VALUES ($1, $2, $3, NOW())'
        USING v_cd_tabela, v_nm_usuario, TG_OP;

        RETURN NEW;

    -- Ação UPDATE
    ELSIF (TG_OP = 'UPDATE') THEN
        EXECUTE 'SELECT ($1).' || quote_ident(v_nm_pk) USING NEW INTO v_cd_tabela;

        -- Comparando diferenças entre NEW e OLD com hstore
        v_diferencas := hstore(NEW) - hstore(OLD);

        -- Iterando pelos campos modificados
        FOR v_campo IN SELECT key FROM each(v_diferencas) LOOP

			EXECUTE 'SELECT CAST(($1).' || quote_ident(v_campo) || ' AS VARCHAR(255))' INTO v_vl_campo_new USING NEW;
            EXECUTE 'SELECT CAST(($1).' || quote_ident(v_campo) || ' AS VARCHAR(255))' INTO v_vl_campo_old USING OLD;

            -- Inserir os dados das diferenças no log
            EXECUTE 'INSERT INTO ' || quote_ident(v_nm_tabela_log) || '(' || quote_ident(v_nm_fk) || ',nm_campo, vl_campo_old, vl_campo_new, nm_usuario, nm_operacao, dt_operacao)
                     VALUES ($1, $2, $3, $4, $5, $6, NOW())'
            USING v_cd_tabela, v_campo, v_vl_campo_old, v_vl_campo_new, v_nm_usuario, TG_OP;
        END LOOP;

        RETURN NEW;

    -- Ação DELETE
    ELSE
        EXECUTE 'SELECT ($1).' || quote_ident(v_nm_pk) USING OLD INTO v_cd_tabela;

        -- Inserir os dados no log após DELETE
        EXECUTE 'INSERT INTO ' || quote_ident(v_nm_tabela_log) || '(' || quote_ident(v_nm_fk) ||',nm_usuario, nm_operacao, dt_operacao) 
                 VALUES ($1, $2, $3, NOW())'
        USING v_cd_tabela, v_nm_usuario, TG_OP;

        RETURN OLD;
    END IF;

END;
$$ LANGUAGE plpgsql;


/*
================================================
         LOG USUÁRIO                
================================================
*/

CREATE TABLE log_usuario(
	id_log SERIAL PRIMARY KEY,
	cd_usuario INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_usuario
	AFTER INSERT OR UPDATE OR DELETE ON usuario
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG LOCAL                
================================================
*/

CREATE TABLE log_local(
	id_log SERIAL PRIMARY KEY,
	cd_local INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_local
	AFTER INSERT OR UPDATE OR DELETE ON local
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG TAG                
================================================
*/

CREATE TABLE log_tag(
	id_log SERIAL PRIMARY KEY,
	cd_tag INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_tag
	AFTER INSERT OR UPDATE OR DELETE ON tag
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG EVENTO                
================================================
*/

CREATE TABLE log_evento(
	id_log SERIAL PRIMARY KEY,
	cd_evento INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_evento
	AFTER INSERT OR UPDATE OR DELETE ON evento
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG FRASE SUSTENTÁVEL                
================================================
*/

CREATE TABLE log_frase_sustentavel(
	id_log SERIAL PRIMARY KEY,
	cd_frase_sustentavel INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP
);

CREATE OR REPLACE TRIGGER trg_log_frase_sustentavel
	AFTER INSERT OR UPDATE OR DELETE ON frase_sustentavel
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG PRODUTO                
================================================
*/

CREATE TABLE log_produto(
	id_log SERIAL PRIMARY KEY,
	cd_produto INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_produto
	AFTER INSERT OR UPDATE OR DELETE ON produto
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG COMPRA           
================================================
*/

CREATE TABLE log_compra(
	id_log SERIAL PRIMARY KEY,
	cd_compra INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_compra
	AFTER INSERT OR UPDATE OR DELETE ON compra
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

/*
================================================
         LOG PAGAMENTO       
================================================
*/

CREATE TABLE log_pagamento(
	id_log SERIAL PRIMARY KEY,
	cd_pagamento INTEGER,
	nm_campo VARCHAR(255),
	vl_campo_old VARCHAR(255),
	vl_campo_new VARCHAR(255),
	nm_usuario VARCHAR(255),
	nm_operacao VARCHAR(255),
	dt_operacao TIMESTAMP,
);

CREATE OR REPLACE TRIGGER trg_log_pagamento
	AFTER INSERT OR UPDATE OR DELETE ON pagamento
	FOR EACH ROW EXECUTE FUNCTION fnc_log_geral();

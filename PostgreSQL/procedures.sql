/*
================================================
         PROCEDURE DE CONSUMIDOR   
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_INSERIR_CONSUMIDOR(
    p_cd_genero INTEGER,
    p_cd_acesso INTEGER,
    p_nm_usuario VARCHAR,
    p_ds_email VARCHAR,
    p_ds_senha VARCHAR,
    p_is_premium BOOLEAN,
    p_ds_usuario TEXT,
    p_dt_nascimento DATE,
    p_nm_nickname VARCHAR
)
LANGUAGE 'plpgsql' AS $$	
DECLARE
    v_id_usuario INTEGER;
BEGIN

    INSERT INTO usuario(cd_genero, cd_acesso, nm_usuario, ds_email, ds_senha, is_premium, ds_usuario)
    VALUES(p_cd_genero, p_cd_acesso,p_nm_usuario, p_ds_email, p_ds_senha, p_is_premium, p_ds_usuario)
    RETURNING id_usuario INTO v_id_usuario;

    INSERT INTO consumidor(id_consumidor, dt_nascimento, nm_nickname)
    VALUES(v_id_usuario, p_dt_nascimento, p_nm_nickname);
    
COMMIT;
END; $$;


/*
================================================
         PROCEDURE DE ANUNCIANTE   
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_INSERIR_ANUNCIANTE(
    p_cd_genero INTEGER,
	p_cd_acesso INTEGER,
    p_nm_usuario VARCHAR,
    p_ds_email VARCHAR,
    p_ds_senha VARCHAR,
    p_is_premium BOOLEAN,
    p_ds_usuario TEXT,
    p_dt_nascimento DATE,
    p_nm_empresa VARCHAR,
    p_nr_cnpj VARCHAR,
    p_nr_telefone VARCHAR
)
LANGUAGE 'plpgsql' AS $$	
DECLARE
    v_id_usuario INTEGER;
BEGIN

    INSERT INTO usuario(cd_genero, cd_acesso, nm_usuario, ds_email, ds_senha, is_premium, ds_usuario)
    VALUES(p_cd_genero, p_cd_acesso, p_nm_usuario, p_ds_email, p_ds_senha, p_is_premium, p_ds_usuario)
    RETURNING id_usuario INTO v_id_usuario;

    INSERT INTO anunciante(id_anunciante, dt_nascimento, nm_empresa, nr_cnpj, nr_telefone)
    VALUES(v_id_usuario, p_dt_nascimento, p_nm_empresa, p_nr_cnpj, p_nr_telefone);
    
COMMIT;
END; $$;


/*
================================================
         PROCEDURE DE EVENTO + TAG           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_INSERIR_EVENTO_TAGS(
    p_nm_evento VARCHAR,
    p_ds_evento TEXT,
    p_dt_inicio DATE,
    p_hr_inicio TIME,
    p_dt_fim DATE,
    p_hr_fim TIME,
    p_url_documentacao TEXT,
    p_cd_local INTEGER,
    p_cd_anunciante INTEGER,
    p_tags VARCHAR[] 
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_evento INTEGER;
    v_id_tag INTEGER;
    v_tag VARCHAR;  -- Declare a variable to hold each tag from p_tags
BEGIN
    -- Insert the event
    INSERT INTO evento (nm_evento, ds_evento, dt_inicio,hr_inicio, dt_fim,hr_fim, url_documentacao, cd_local, cd_anunciante)
    VALUES (p_nm_evento, p_ds_evento, p_dt_inicio,p_hr_inicio, p_dt_fim,p_hr_fim, p_url_documentacao, p_cd_local, p_cd_anunciante)
    RETURNING id_evento INTO v_id_evento;

    FOREACH v_tag IN ARRAY p_tags LOOP

        SELECT id_tag INTO v_id_tag 
        FROM tag 
        WHERE UPPER(nm_tag) = UPPER(v_tag);

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Tag % não encontrada', v_tag;
        END IF;

        INSERT INTO evento_tag (cd_evento, cd_tag) 
        VALUES (v_id_evento, v_id_tag);

    END LOOP;

END;
$$;



/*
================================================
        PROCEDURE DE PAGAMENTO + COMPRA           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_ATUALIZAR_STATUS_COMPRA(
    p_cd_compra INTEGER 
)
LANGUAGE 'plpgsql' AS $$	
DECLARE
    v_dt_pagamento TIMESTAMP;
BEGIN

    SELECT NOW() INTO v_dt_pagamento;

    INSERT INTO pagamento(cd_compra, dt_pagamento)
    VALUES(p_cd_compra, v_dt_pagamento);

    UPDATE compra SET ds_status='Concluída'
    WHERE id_compra=p_cd_compra;
    
COMMIT;
END; $$;
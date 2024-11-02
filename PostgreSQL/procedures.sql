/*
================================================
         PROCEDURE DE EVENTO + TAG           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_INSERIR_EVENTO_TAG(
    p_nm_evento VARCHAR,
    p_ds_evento TEXT,
    p_dt_inicio DATE,
    p_hr_inicio TIME,
    p_dt_fim DATE,
    p_hr_fim TIME,
    p_url_documentacao TEXT,
    p_cd_local INTEGER,
    p_cd_anunciante INTEGER,
    p_tags VARCHAR[],
    OUT p_id_evento INTEGER  -- Parâmetro OUT para o ID do evento
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_tag INTEGER;
    v_tag VARCHAR;  
BEGIN
    -- Insere o evento e captura o ID do novo evento
    INSERT INTO evento (nm_evento, ds_evento, dt_inicio, hr_inicio, dt_fim, hr_fim, url_documentacao, cd_local, cd_anunciante)
    VALUES (p_nm_evento, p_ds_evento, p_dt_inicio, p_hr_inicio, p_dt_fim, p_hr_fim, p_url_documentacao, p_cd_local, p_cd_anunciante)
    RETURNING id_evento INTO p_id_evento;

    -- Loop pelas tags e associa ao evento recém-criado
    FOREACH v_tag IN ARRAY p_tags LOOP
        SELECT id_tag INTO v_id_tag 
        FROM tag 
        WHERE UPPER(nm_tag) = UPPER(v_tag);

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Tag % não encontrada', v_tag;
        END IF;

        INSERT INTO evento_tag (cd_evento, cd_tag) 
        VALUES (p_id_evento, v_id_tag);
    END LOOP;
END;
$$;




/*
================================================
         PROCEDURE DE INTERESSE + USUARIO_TAG           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_INSERIR_USUARIO_TAG(
    p_cd_consumidor INTEGER,
    p_cd_evento INTEGER,
    p_tags VARCHAR[] 
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_tag INTEGER;
    v_tag VARCHAR; 
BEGIN

    IF p_cd_evento IS NOT NULL THEN

        INSERT INTO interesse (cd_consumidor, cd_evento)
        VALUES (p_cd_consumidor, p_cd_evento);

        SELECT ARRAY_AGG(t.nm_tag) FROM interesse i
        JOIN evento_tag et ON i.cd_evento = et.cd_evento
        JOIN tag t ON et.cd_tag = t.id_tag
        INTO p_tags;

    END IF;

    FOREACH v_tag IN ARRAY p_tags LOOP

        SELECT id_tag INTO v_id_tag 
        FROM tag 
        WHERE UPPER(nm_tag) = UPPER(v_tag);

        IF v_id_tag IS NULL THEN
            RAISE EXCEPTION 'Tag % não encontrada', v_tag;
        END IF;

        INSERT INTO usuario_tag (cd_consumidor,cd_tag) 
        VALUES (p_cd_consumidor, v_id_tag);

    END LOOP;

END;
$$;


/*
================================================
        PROCEDURE DE PRODUTO + COMPRA           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_REALIZAR_COMPRA(
    p_cd_usuario INTEGER,
    p_cd_produto INTEGER,
    p_cd_evento INTEGER,
    p_vl_total DECIMAL,
    OUT p_id_compra INTEGER 
)
LANGUAGE plpgsql AS $$	
DECLARE
    v_dt_compra TIMESTAMP;
BEGIN
    -- Obtém a data e hora atual
    SELECT NOW() INTO v_dt_compra;

    -- Insere a compra e captura o ID da nova compra
    INSERT INTO compra(cd_usuario, cd_produto, cd_evento, dt_compra, vl_total)
    VALUES(p_cd_usuario, p_cd_produto, p_cd_evento, v_dt_compra, p_vl_total)
    RETURNING id_compra INTO p_id_compra;

    -- Atualiza o estoque do produto se o código do evento for nulo
    IF p_cd_evento IS NULL THEN
        UPDATE produto 
        SET qt_estoque = qt_estoque - 1
        WHERE id_produto = p_cd_produto;
    END IF;
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

END; $$;
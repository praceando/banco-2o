/*
================================================
         PROCEDURE DE EVENTO + TAG           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_INSERIR_EVENTO_TAGS(
    p_nm_evento VARCHAR,
    p_ds_evento TEXT,
    p_dt_inicio DATE,
    p_hr_inicio TIME
    p_dt_fim DATE,
    p_hr_fim TIME,
    p_url_documentacao TEXT,
    p_cd_local INT,
    p_cd_anunciante INT,
    p_tags VARCHAR[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_evento INT;
    v_id_tag INT;
BEGIN
    -- Insere o evento
    INSERT INTO evento (nm_evento, ds_evento, dt_inicio, dt_fim, url_documentacao, cd_local, cd_anunciante)
    VALUES (p_nm_evento, p_ds_evento, p_dt_inicio, p_dt_fim, p_url_documentacao, p_cd_local, p_cd_anunciante)
    RETURNING id_evento INTO v_id_evento;


    FOREACH p_tag IN ARRAY p_tags LOOP

        SELECT id_tag FROM tag WHERE nm_tag=p_tag
        INTO v_id_tag;

        INSERT INTO evento_tag (v_id_evento, v_id_tag);
    END LOOP;

END;
$$;


/*
================================================
        PROCEDURE DE PAGAMENTO + COMPRA           
================================================
*/

CREATE OR REPLACE PROCEDURE PRC_ATUALIZAR_STATUS_COMPRA(
    p_cd_compra INT 
)
LANGUAGE 'plpgsql' AS $$	
DECLARE
    v_dt_pagamento TIMESTAMP
BEGIN

    SELECT NOW() INTO v_dt_pagamento

    INSERT INTO pagamento(cd_compra, dt_pagamento)
    VALUES(p_cd_compra, v_dt_pagamento);

    UPDATE compra SET ds_status='Concluída'
    WHERE id_compra=p_cd_compra;
    
COMMIT;
END; $$
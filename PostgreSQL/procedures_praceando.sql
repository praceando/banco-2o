--procedure de inserir evento e suas tags
CREATE OR REPLACE PROCEDURE PRC_INSERIR_EVENTO_TAGS(
    p_nm_evento VARCHAR,
    p_ds_evento TEXT,
    p_dt_inicio TIMESTAMP,
    p_dt_fim TIMESTAMP,
    p_url_documentacao TEXT,
    p_cd_local INT,
    p_cd_anunciante INT,
    p_tags VARCHAR[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_evento INT;
BEGIN
    -- Insere o evento
    INSERT INTO evento (nm_evento, ds_evento, dt_inicio, dt_fim, url_documentacao, cd_local, cd_anunciante)
    VALUES (p_nm_evento, p_ds_evento, p_dt_inicio, p_dt_fim, p_url_documentacao, p_cd_local, p_cd_anunciante)
    RETURNING id_evento INTO v_id_evento;

    -- Insere as tags associadas ao evento utilizando UNNEST
    INSERT INTO evento_tag (cd_evento, cd_tag)
    SELECT v_id_evento, id_tag
    FROM tag
    WHERE nm_tag = ANY(p_tags);

END;
$$;


-- functions para calcular idade do usuario
CREATE OR REPLACE FUNCTION FNC_CALCULAR_IDADE (dt_nascimento DATE)
RETURNS INTEGER AS
$$
DECLARE
    idade INTEGER;
BEGIN
    idade := EXTRACT(YEAR FROM AGE(CURRENT_DATE, dt_nascimento));
    RETURN idade;
END;
$$
LANGUAGE plpgsql;


-- function de inserir do id_avatar
CREATE OR REPLACE FUNCTION FNC_INSERIR_ID_AVATAR(
    p_id_usuario INT,
    p_id_avatar INT
)
RETURNS VOID AS
$$
BEGIN
    UPDATE usuario
    SET cd_inventario_avatar = p_id_avatar,
        dt_atualizacao = CURRENT_DATE
    WHERE id_usuario = p_id_usuario;
END;
$$
LANGUAGE plpgsql;

-- Crição de índice na tabela usuario para a coluna cd_usuario
CREATE INDEX idx_usuario ON usuario (id_usuario);

-- Criação de índice na tabela evento para a coluna id_evento
CREATE INDEX idx_evento ON evento (id_evento);

-- Criação de índice na tabela compra para a coluna id_compra
CREATE INDEX idx_compra ON compra (id_compra);
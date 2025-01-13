-- 99% gerado com chatgpt

-- Criação da tabela "cidadao"
CREATE TABLE cidadao (
    id INTEGER NOT NULL, -- Identificador definido no momento do insert
    nome VARCHAR(100) NOT NULL,
    nome_social VARCHAR(100),
    cpf CHAR(11) NOT NULL UNIQUE,
    numero_telefone CHAR(11) NOT NULL,
    telefone_verificado BOOLEAN NOT NULL DEFAULT FALSE,
    senha VARCHAR(64) NOT NULL; -- SHA-256 gera hashes de 64 caracteres hexadecimais
    PRIMARY KEY (id) -- Definindo a chave primária
);

-- Inserção de 5 cidadãos com IDs definidos manualmente
-- 64163ee6cacc5318ccffde879bb112383c70dc7881ccae0c9cbd5bee96cca685 = senhaSegura
INSERT INTO cidadao (id, nome, nome_social, cpf, numero_telefone, telefone_verificado, senha) VALUES
(1, 'João Silva', 'João', '47032741088', '11987654321', FALSE, '64163ee6cacc5318ccffde879bb112383c70dc7881ccae0c9cbd5bee96cca685'),
(2, 'Maria Oliveira', 'Maria', '21185358056', '21987654321', TRUE, '64163ee6cacc5318ccffde879bb112383c70dc7881ccae0c9cbd5bee96cca685'),
(3, 'Carlos Pereira', 'Carlos', '61499541023', '31987654321', FALSE, '64163ee6cacc5318ccffde879bb112383c70dc7881ccae0c9cbd5bee96cca685'),
(4, 'Ana Souza', 'Ana', '87802954010', '41987654321', TRUE, '64163ee6cacc5318ccffde879bb112383c70dc7881ccae0c9cbd5bee96cca685'),
(5, 'Lucas Santos', NULL, '27720715020', '51987654321', FALSE, '64163ee6cacc5318ccffde879bb112383c70dc7881ccae0c9cbd5bee96cca685');

-- Criação da tabela "categorias_cidadao"
CREATE TABLE categorias_cidadao (
    id INTEGER PRIMARY KEY, -- Identificador da categoria
    categoria VARCHAR(50) NOT NULL, -- Nome da categoria
    data_atualizacao TIMESTAMP NOT NULL -- Data e hora da última atualização
);

-- Inserção dos dados para gerar o JSON
INSERT INTO categorias_cidadao (id, categoria, data_atualizacao) VALUES
(1, 'Bronze', '2025-01-01 12:00:00'),
(2, 'Prata', '2025-01-02 13:30:00'),
(3, 'Ouro', '2025-01-03 14:45:00');

-- Criação da tabela "confiabilidade_cidadao"
CREATE TABLE confiabilidade_cidadao (
    id INTEGER PRIMARY KEY, -- Identificador único da confiabilidade
    descricao VARCHAR(100) NOT NULL, -- Descrição da confiabilidade
    data_atualizacao TIMESTAMP NOT NULL -- Data e hora da última atualização
);

-- Inserção dos dados
INSERT INTO confiabilidade_cidadao (id, descricao, data_atualizacao) VALUES
(101, 'kba_previdencia', '2025-01-01 12:00:00'),
(201, 'cadastro_basico', '2025-01-01 12:30:00'),
(301, 'servidor_publico', '2025-01-01 13:00:00'),
(401, 'biovalid_facial', '2025-01-01 13:30:00'),
(501, 'balcao_sat_previdencia', '2025-01-01 14:00:00'),
(502, 'balcao_denatran', '2025-01-01 14:30:00'),
(503, 'balcao_correios', '2025-01-01 15:00:00'),
(504, 'balcao_cadastro_presencial_govbr', '2025-01-01 15:30:00'),
(601, 'balcao_nai_previdencia', '2025-01-01 16:00:00'),
(609, 'agi_bank_internet_banking', '2025-01-01 16:30:00'),
(602, 'bb_internet_banking', '2025-01-01 17:00:00'),
(603, 'banrisul_internet_banking', '2025-01-01 17:30:00'),
(604, 'bradesco_internet_banking', '2025-01-01 18:00:00'),
(605, 'caixa_internet_banking', '2025-01-01 18:30:00'),
(606, 'brb_internet_banking', '2025-01-01 19:00:00'),
(610, 'itau_internet_banking', '2025-01-01 19:30:00'),
(607, 'sicoob_internet_banking', '2025-01-01 20:00:00'),
(624, 'sicred_internet_banking', '2025-01-01 20:30:00'),
(608, 'santander_internet_banking', '2025-01-01 21:00:00'),
(626, 'nubank_internet_banking', '2025-01-01 21:30:00'),
(627, 'btg_internet_banking', '2025-01-01 22:00:00'),
(701, 'tse_facial', '2025-01-01 22:30:00'),
(901, 'cin_facial', '2025-01-01 23:00:00'),
(801, 'certificado_digital', '2025-01-01 23:30:00');

-- Alterar a tabela "cidadao" para incluir a relação com "categorias_cidadao"
ALTER TABLE cidadao 
ADD COLUMN categoria_id INTEGER,
ADD CONSTRAINT fk_categoria_cidadao FOREIGN KEY (categoria_id) REFERENCES categorias_cidadao(id);

-- Criação da tabela intermediária para a relação "cidadao" e "confiabilidade_cidadao"
CREATE TABLE cidadao_confiabilidade (
    cidadao_id INTEGER NOT NULL,
    confiabilidade_id INTEGER NOT NULL,
    data_associacao TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (cidadao_id, confiabilidade_id),
    CONSTRAINT fk_cidadao FOREIGN KEY (cidadao_id) REFERENCES cidadao(id),
    CONSTRAINT fk_confiabilidade FOREIGN KEY (confiabilidade_id) REFERENCES confiabilidade_cidadao(id)
);

-- Inserir dados de exemplo para os vínculos
-- Exemplo: Associar cidadãos a categorias
UPDATE cidadao SET categoria_id = 1 WHERE id = 1; -- João Silva (categoria 1 - Bronze)
UPDATE cidadao SET categoria_id = 2 WHERE id = 2; -- Maria Oliveira (categoria 2 - Prata)
UPDATE cidadao SET categoria_id = 3 WHERE id = 3; -- Carlos Pereira (categoria 3 - Ouro)

-- Exemplo: Associar cidadãos a confiabilidades
INSERT INTO cidadao_confiabilidade (cidadao_id, confiabilidade_id) VALUES
(1, 101), -- João Silva -> kba_previdencia
(1, 201), -- João Silva -> cadastro_basico
(2, 301), -- Maria Oliveira -> servidor_publico
(3, 401), -- Carlos Pereira -> biovalid_facial
(3, 501); -- Carlos Pereira -> balcao_sat_previdencia

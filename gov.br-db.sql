-- Criação da tabela "cidadao"
CREATE TABLE cidadao (
    id INTEGER NOT NULL, -- Identificador definido no momento do insert
    nome VARCHAR(100) NOT NULL,
    nome_social VARCHAR(100),
    cpf CHAR(11) NOT NULL UNIQUE,
    numero_telefone CHAR(11) NOT NULL,
    telefone_verificado BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id) -- Definindo a chave primária
);

-- Inserção de 5 cidadãos com IDs definidos manualmente
INSERT INTO cidadao (id, nome, nome_social, cpf, numero_telefone, telefone_verificado) VALUES
(1, 'João Silva', 'João', '47032741088', '11987654321', FALSE),
(2, 'Maria Oliveira', 'Maria', '21185358056', '21987654321', TRUE),
(3, 'Carlos Pereira', 'Carlos', '61499541023', '31987654321', FALSE),
(4, 'Ana Souza', 'Ana', '87802954010', '41987654321', TRUE),
(5, 'Lucas Santos', NULL, '27720715020', '51987654321', FALSE);


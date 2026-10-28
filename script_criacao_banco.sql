-- ============================================================================
-- Script de Criação do Banco de Dados SQLite - Clínica Veterinária (UnaTopPet)
-- Baseado no Diagrama Entidade-Relacionamento (DER CLINICA VETERINARIA .json)
-- Finalidade: Suporte às operações de Consulta (SELECT), Inclusão (INSERT)
--             e Alteração (UPDATE), garantindo integridade referencial.
-- ============================================================================

PRAGMA foreign_keys = ON;

-- ----------------------------------------------------------------------------
-- 1. Tabela: Cliente
-- Representa os tutores/clientes cadastrados na clínica veterinária.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
    ID_Cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(100) NOT NULL,
    Endereco VARCHAR(150),
    Telefone VARCHAR(20) NOT NULL,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Email VARCHAR(100),
    Data_Cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------------------------------------------------------
-- 2. Tabela: Profissional
-- Representa os médicos veterinários e profissionais da clínica.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Profissional (
    ID_Profissional INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CRMV VARCHAR(20) NOT NULL UNIQUE,
    Especialidade VARCHAR(50),
    Telefone VARCHAR(20)
);

-- ----------------------------------------------------------------------------
-- 3. Tabela: Servico
-- Representa o catálogo de serviços oferecidos pela clínica.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Servico (
    Id_servico INTEGER PRIMARY KEY AUTOINCREMENT,
    Nome_Servico VARCHAR(100) NOT NULL UNIQUE,
    Descricao TEXT(100),
    Categoria VARCHAR(15),
    duracao_min INT,
    Preco DECIMAL(10,2) NOT NULL
);

-- ----------------------------------------------------------------------------
-- 4. Tabela: Animal
-- Representa os pets/animais vinculados a um Cliente (1:N).
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Animal (
    ID_animal INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_cliente INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    especie VARCHAR(30) NOT NULL,
    raca VARCHAR(50) NOT NULL,
    data_nascimento DATE,
    sexo CHAR(1),
    porte VARCHAR(20),
    FOREIGN KEY (ID_cliente) REFERENCES Cliente(ID_Cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- 5. Tabela: Agendamento
-- Representa os agendamentos de serviços para um animal com um profissional.
-- Relacionamentos: Animal (1:N), Servico (1:N), Profissional (1:N).
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Agendamento (
    ID_Agendamento INTEGER PRIMARY KEY AUTOINCREMENT,
    Data_Hora DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Agendado',
    ID_Servico INT NOT NULL,
    ID_Animal INT NOT NULL,
    ID_Profissional INT NOT NULL,
    FOREIGN KEY (ID_Servico) REFERENCES Servico(Id_servico)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Animal) REFERENCES Animal(ID_animal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- 6. Tabela: Historico_saude
-- Representa o histórico clínico/prontuário e atendimentos realizados no animal.
-- Relacionamentos: Animal (1:N), Profissional (1:N).
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Historico_saude (
    ID_historico INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_animal INT NOT NULL,
    ID_Profissional INT NOT NULL,
    data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_registro VARCHAR(30),
    descricao TEXT NOT NULL,
    FOREIGN KEY (ID_animal) REFERENCES Animal(ID_animal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- 7. Tabela: Anexo_midia
-- Armazena referências (URLs/caminhos) de arquivos de mídia anexados a um
-- registro de histórico de saúde e/ou agendamento.
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Anexo_midia (
    Id_anexo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_historico INT,
    id_agendamento INT,
    url_midia VARCHAR(255) NOT NULL,
    tipo_midia VARCHAR(10),
    FOREIGN KEY (id_historico) REFERENCES Historico_saude(ID_historico)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_agendamento) REFERENCES Agendamento(ID_Agendamento)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- Índices para otimização de consultas (SELECT) por chaves estrangeiras e datas
-- ----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_animal_cliente ON Animal(ID_cliente);
CREATE INDEX IF NOT EXISTS idx_agendamento_data ON Agendamento(Data_Hora);
CREATE INDEX IF NOT EXISTS idx_agendamento_profissional ON Agendamento(ID_Profissional);
CREATE INDEX IF NOT EXISTS idx_agendamento_animal ON Agendamento(ID_Animal);
CREATE INDEX IF NOT EXISTS idx_historico_animal ON Historico_saude(ID_animal);

-- ----------------------------------------------------------------------------
-- Triggers de Proteção: Garantir que o banco opere apenas para
-- Consulta (SELECT), Inclusão (INSERT) e Alteração (UPDATE), bloqueando DELETE.
-- ----------------------------------------------------------------------------
CREATE TRIGGER IF NOT EXISTS trg_block_delete_cliente
BEFORE DELETE ON Cliente
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Cliente. Utilize apenas consulta, inclusao e alteracao.');
END;

CREATE TRIGGER IF NOT EXISTS trg_block_delete_profissional
BEFORE DELETE ON Profissional
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Profissional. Utilize apenas consulta, inclusao e alteracao.');
END;

CREATE TRIGGER IF NOT EXISTS trg_block_delete_servico
BEFORE DELETE ON Servico
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Servico. Utilize apenas consulta, inclusao e alteracao.');
END;

CREATE TRIGGER IF NOT EXISTS trg_block_delete_animal
BEFORE DELETE ON Animal
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Animal. Utilize apenas consulta, inclusao e alteracao.');
END;

CREATE TRIGGER IF NOT EXISTS trg_block_delete_agendamento
BEFORE DELETE ON Agendamento
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Agendamento. Utilize apenas consulta, inclusao e alteracao.');
END;

CREATE TRIGGER IF NOT EXISTS trg_block_delete_historico_saude
BEFORE DELETE ON Historico_saude
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Historico_saude. Utilize apenas consulta, inclusao e alteracao.');
END;

CREATE TRIGGER IF NOT EXISTS trg_block_delete_anexo_midia
BEFORE DELETE ON Anexo_midia
BEGIN
    SELECT RAISE(ABORT, 'Operacao DELETE nao permitida na tabela Anexo_midia. Utilize apenas consulta, inclusao e alteracao.');
END;

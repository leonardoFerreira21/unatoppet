-- ============================================================================
-- Script de Migração v2 - Clínica Veterinária (UnaTopPet)
-- Aplica sobre um banco criado com a versão 1 do script_criacao_banco.sql.
--
-- Alterações:
--   1. Agendamento: novo vínculo direto com Cliente (ID_Cliente NOT NULL),
--      com FK composta (ID_Animal, ID_Cliente) -> Animal(ID_animal, ID_cliente)
--      garantindo que o cliente do agendamento seja o tutor do animal.
--   2. Historico_saude: mantém Animal 1:N Historico_saude e passa a ter vínculo
--      opcional com o Agendamento que originou o registro (ID_Agendamento), com
--      FK composta garantindo que o animal do histórico seja o do agendamento.
--   3. Anexo_midia: passa a pertencer exclusivamente a um Historico_saude
--      (id_historico NOT NULL). A coluna id_agendamento foi removida por ser
--      redundante (o agendamento é obtido via Historico_saude.ID_Agendamento)
--      e por permitir anexos órfãos (ambas FKs nulas) ou inconsistentes.
--   4. Agendamento/Servico/Profissional: FKs obrigatórias mantidas, novos
--      índices nas FKs e bloqueio de dupla marcação do profissional no mesmo
--      horário (exceto agendamentos cancelados).
--
-- Segue o procedimento oficial do SQLite para alteração de tabelas
-- (criar nova tabela -> copiar dados -> remover antiga -> renomear).
-- ============================================================================

PRAGMA foreign_keys = OFF;

BEGIN TRANSACTION;

-- ----------------------------------------------------------------------------
-- 0. Validações prévias: aborta a migração se algum anexo atual estiver em
--    situação que impeça a nova modelagem (sem histórico, ou com agendamento
--    de outro animal). Nenhum dado é perdido: a transação é desfeita.
-- ----------------------------------------------------------------------------
CREATE TEMP TABLE _validacao (
    regra TEXT,
    qtd INTEGER CHECK (qtd = 0)
);

INSERT INTO _validacao
SELECT 'Anexo sem historico', COUNT(*) FROM Anexo_midia WHERE id_historico IS NULL;

INSERT INTO _validacao
SELECT 'Anexo com agendamento de outro animal', COUNT(*)
FROM Anexo_midia am
JOIN Historico_saude h ON h.ID_historico = am.id_historico
JOIN Agendamento a     ON a.ID_Agendamento = am.id_agendamento
WHERE a.ID_Animal <> h.ID_animal;

-- ----------------------------------------------------------------------------
-- 1. Animal: chave candidata (ID_animal, ID_cliente) para a FK composta
-- ----------------------------------------------------------------------------
CREATE UNIQUE INDEX IF NOT EXISTS uq_animal_cliente ON Animal(ID_animal, ID_cliente);

-- ----------------------------------------------------------------------------
-- 2. Agendamento: inclusão de ID_Cliente
-- ----------------------------------------------------------------------------
CREATE TABLE Agendamento_new (
    ID_Agendamento INTEGER PRIMARY KEY AUTOINCREMENT,
    Data_Hora DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Agendado',
    ID_Servico INT NOT NULL,
    ID_Cliente INT NOT NULL,
    ID_Animal INT NOT NULL,
    ID_Profissional INT NOT NULL,
    FOREIGN KEY (ID_Servico) REFERENCES Servico(Id_servico)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Animal) REFERENCES Animal(ID_animal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Animal, ID_Cliente) REFERENCES Animal(ID_animal, ID_cliente)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO Agendamento_new (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Cliente, ID_Animal, ID_Profissional)
SELECT ag.ID_Agendamento, ag.Data_Hora, ag.status, ag.ID_Servico, an.ID_cliente, ag.ID_Animal, ag.ID_Profissional
FROM Agendamento ag
JOIN Animal an ON an.ID_animal = ag.ID_Animal;

INSERT INTO _validacao
SELECT 'Agendamento sem animal valido',
       (SELECT COUNT(*) FROM Agendamento) - (SELECT COUNT(*) FROM Agendamento_new);

-- ----------------------------------------------------------------------------
-- 3. Historico_saude: inclusão de ID_Agendamento (opcional)
-- ----------------------------------------------------------------------------
CREATE TABLE Historico_saude_new (
    ID_historico INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_animal INT NOT NULL,
    ID_Profissional INT NOT NULL,
    ID_Agendamento INT,
    data_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_registro VARCHAR(30),
    descricao TEXT NOT NULL,
    FOREIGN KEY (ID_animal) REFERENCES Animal(ID_animal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (ID_Agendamento, ID_animal) REFERENCES Agendamento(ID_Agendamento, ID_Animal)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Vincula cada histórico ao agendamento de origem:
--   1º) pelo agendamento informado no anexo de mídia (vínculo explícito);
--   2º) pelo agendamento do mesmo animal, no mesmo dia, iniciado antes do registro.
INSERT INTO Historico_saude_new (ID_historico, ID_animal, ID_Profissional, ID_Agendamento, data_registro, tipo_registro, descricao)
SELECT h.ID_historico, h.ID_animal, h.ID_Profissional,
       COALESCE(
           (SELECT MIN(am.id_agendamento) FROM Anexo_midia am
             WHERE am.id_historico = h.ID_historico AND am.id_agendamento IS NOT NULL),
           (SELECT a.ID_Agendamento FROM Agendamento a
             WHERE a.ID_Animal = h.ID_animal
               AND date(a.Data_Hora) = date(h.data_registro)
               AND a.Data_Hora <= h.data_registro
             ORDER BY a.Data_Hora DESC LIMIT 1)
       ),
       h.data_registro, h.tipo_registro, h.descricao
FROM Historico_saude h;

-- ----------------------------------------------------------------------------
-- 4. Anexo_midia: pertence exclusivamente a um Historico_saude
-- ----------------------------------------------------------------------------
CREATE TABLE Anexo_midia_new (
    Id_anexo INTEGER PRIMARY KEY AUTOINCREMENT,
    id_historico INT NOT NULL,
    url_midia VARCHAR(255) NOT NULL,
    tipo_midia VARCHAR(10),
    FOREIGN KEY (id_historico) REFERENCES Historico_saude(ID_historico)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

INSERT INTO Anexo_midia_new (Id_anexo, id_historico, url_midia, tipo_midia)
SELECT Id_anexo, id_historico, url_midia, tipo_midia FROM Anexo_midia;

-- O agendamento informado no anexo deve coincidir com o do histórico
INSERT INTO _validacao
SELECT 'Anexo com agendamento divergente do historico', COUNT(*)
FROM Anexo_midia am
JOIN Historico_saude_new h ON h.ID_historico = am.id_historico
WHERE am.id_agendamento IS NOT NULL
  AND (h.ID_Agendamento IS NULL OR h.ID_Agendamento <> am.id_agendamento);

-- ----------------------------------------------------------------------------
-- 5. Substituição das tabelas antigas
-- ----------------------------------------------------------------------------
DROP TABLE Anexo_midia;
DROP TABLE Historico_saude;
DROP TABLE Agendamento;

ALTER TABLE Agendamento_new     RENAME TO Agendamento;
ALTER TABLE Historico_saude_new RENAME TO Historico_saude;
ALTER TABLE Anexo_midia_new     RENAME TO Anexo_midia;

-- ----------------------------------------------------------------------------
-- 6. Índices
-- ----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_agendamento_data         ON Agendamento(Data_Hora);
CREATE INDEX IF NOT EXISTS idx_agendamento_cliente      ON Agendamento(ID_Cliente);
CREATE INDEX IF NOT EXISTS idx_agendamento_animal       ON Agendamento(ID_Animal, ID_Cliente);
CREATE INDEX IF NOT EXISTS idx_agendamento_servico      ON Agendamento(ID_Servico);
CREATE INDEX IF NOT EXISTS idx_agendamento_profissional ON Agendamento(ID_Profissional);
CREATE UNIQUE INDEX IF NOT EXISTS uq_agendamento_animal ON Agendamento(ID_Agendamento, ID_Animal);
-- Um profissional não pode ter dois agendamentos ativos no mesmo horário
CREATE UNIQUE INDEX IF NOT EXISTS uq_agendamento_profissional_horario
    ON Agendamento(ID_Profissional, Data_Hora) WHERE status <> 'Cancelado';

CREATE INDEX IF NOT EXISTS idx_historico_animal         ON Historico_saude(ID_animal);
CREATE INDEX IF NOT EXISTS idx_historico_profissional   ON Historico_saude(ID_Profissional);
CREATE INDEX IF NOT EXISTS idx_historico_agendamento    ON Historico_saude(ID_Agendamento, ID_animal);

CREATE INDEX IF NOT EXISTS idx_anexo_historico          ON Anexo_midia(id_historico);

-- ----------------------------------------------------------------------------
-- 7. Triggers de bloqueio de DELETE (removidos junto com as tabelas antigas)
-- ----------------------------------------------------------------------------
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

DROP TABLE _validacao;

COMMIT;

PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

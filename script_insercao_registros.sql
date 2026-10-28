-- ============================================================================
-- Script de Inserção de 20 Registros - Clínica Veterinária (UnaTopPet)
-- Cada comando INSERT abaixo corresponde à inclusão de 1 registro no banco,
-- respeitando a ordem de integridade referencial (Chaves Estrangeiras).
-- ============================================================================

PRAGMA foreign_keys = ON;

-- ----------------------------------------------------------------------------
-- Tabela: Cliente (Registros 1 a 4)
-- ----------------------------------------------------------------------------

-- Registro 01
INSERT INTO Cliente (ID_Cliente, Nome, Endereco, Telefone, CPF, Email, Data_Cadastro)
VALUES (1, 'Ana Carolina Mendes', 'Rua das Flores, 120 - Centro', '(31) 99123-4567', '123.456.789-01', 'ana.mendes@email.com', '2026-10-01 09:15:00');

-- Registro 02
INSERT INTO Cliente (ID_Cliente, Nome, Endereco, Telefone, CPF, Email, Data_Cadastro)
VALUES (2, 'Carlos Eduardo Souza', 'Av. Brasil, 1450 - Savassi', '(31) 98234-5678', '234.567.890-12', 'carlos.souza@email.com', '2026-10-02 10:30:00');

-- Registro 03
INSERT INTO Cliente (ID_Cliente, Nome, Endereco, Telefone, CPF, Email, Data_Cadastro)
VALUES (3, 'Mariana Costa Oliveira', 'Rua Minas Gerais, 85 - Funcionários', '(31) 97345-6789', '345.678.901-23', 'mariana.oliveira@email.com', '2026-10-05 14:20:00');

-- Registro 04
INSERT INTO Cliente (ID_Cliente, Nome, Endereco, Telefone, CPF, Email, Data_Cadastro)
VALUES (4, 'Roberto Almeida Santos', 'Rua da Bahia, 2100 - Lourdes', '(31) 96456-7890', '456.789.012-34', 'roberto.santos@email.com', '2026-10-10 16:00:00');

-- ----------------------------------------------------------------------------
-- Tabela: Profissional (Registros 5 a 7)
-- ----------------------------------------------------------------------------

-- Registro 05
INSERT INTO Profissional (ID_Profissional, Nome, CRMV, Especialidade, Telefone)
VALUES (1, 'Dr. Lucas Ferreira Lima', 'CRMV-MG 10234', 'Clínica Geral', '(31) 99811-2233');

-- Registro 06
INSERT INTO Profissional (ID_Profissional, Nome, CRMV, Especialidade, Telefone)
VALUES (2, 'Dra. Fernanda Ribeiro', 'CRMV-MG 15432', 'Cirurgia e Ortopedia', '(31) 99722-3344');

-- Registro 07
INSERT INTO Profissional (ID_Profissional, Nome, CRMV, Especialidade, Telefone)
VALUES (3, 'Dr. Gabriel Martins', 'CRMV-MG 18765', 'Dermatologia Veterinária', '(31) 99633-4455');

-- ----------------------------------------------------------------------------
-- Tabela: Servico (Registros 8 a 10)
-- ----------------------------------------------------------------------------

-- Registro 08
INSERT INTO Servico (Id_servico, Nome_Servico, Descricao, Categoria, duracao_min, Preco)
VALUES (1, 'Consulta Clínica Geral', 'Avaliação clínica completa do animal', 'Consulta', 45, 150.00);

-- Registro 09
INSERT INTO Servico (Id_servico, Nome_Servico, Descricao, Categoria, duracao_min, Preco)
VALUES (2, 'Vacinação Polivalente V10', 'Aplicação de vacina importada V10 para cães', 'Vacina', 20, 110.00);

-- Registro 10
INSERT INTO Servico (Id_servico, Nome_Servico, Descricao, Categoria, duracao_min, Preco)
VALUES (3, 'Consulta Dermatológica', 'Avaliação especializada de pele e pelagem', 'Especialidade', 60, 220.00);

-- ----------------------------------------------------------------------------
-- Tabela: Animal (Registros 11 a 14)
-- ----------------------------------------------------------------------------

-- Registro 11
INSERT INTO Animal (ID_animal, ID_cliente, nome, especie, raca, data_nascimento, sexo, porte)
VALUES (1, 1, 'Thor', 'Canina', 'Golden Retriever', '2022-04-15', 'M', 'Grande');

-- Registro 12
INSERT INTO Animal (ID_animal, ID_cliente, nome, especie, raca, data_nascimento, sexo, porte)
VALUES (2, 2, 'Luna', 'Felina', 'Siamês', '2023-08-20', 'F', 'Pequeno');

-- Registro 13
INSERT INTO Animal (ID_animal, ID_cliente, nome, especie, raca, data_nascimento, sexo, porte)
VALUES (3, 3, 'Max', 'Canina', 'Bulldog Francês', '2021-11-10', 'M', 'Médio');

-- Registro 14
INSERT INTO Animal (ID_animal, ID_cliente, nome, especie, raca, data_nascimento, sexo, porte)
VALUES (4, 4, 'Mel', 'Canina', 'Shih Tzu', '2024-01-05', 'F', 'Pequeno');

-- ----------------------------------------------------------------------------
-- Tabela: Agendamento (Registros 15 a 17)
-- ----------------------------------------------------------------------------

-- Registro 15
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Animal, ID_Profissional)
VALUES (1, '2026-10-15 10:00:00', 'Concluído', 1, 1, 1);

-- Registro 16
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Animal, ID_Profissional)
VALUES (2, '2026-10-18 14:30:00', 'Concluído', 3, 3, 3);

-- Registro 17
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Animal, ID_Profissional)
VALUES (3, '2026-10-30 09:00:00', 'Agendado', 2, 4, 1);

-- ----------------------------------------------------------------------------
-- Tabela: Historico_saude (Registros 18 e 19)
-- ----------------------------------------------------------------------------

-- Registro 18
INSERT INTO Historico_saude (ID_historico, ID_animal, ID_Profissional, data_registro, tipo_registro, descricao)
VALUES (1, 1, 1, '2026-10-15 10:45:00', 'Atendimento Clínico', 'Animal apresentou bom estado geral, peso 32kg, parâmetros vitais normais.');

-- Registro 19
INSERT INTO Historico_saude (ID_historico, ID_animal, ID_Profissional, data_registro, tipo_registro, descricao)
VALUES (2, 3, 3, '2026-10-18 15:25:00', 'Consulta Especializada', 'Presença de dermatite alérgica leve nas patas. Prescrito shampoo terapêutico.');

-- ----------------------------------------------------------------------------
-- Tabela: Anexo_midia (Registro 20)
-- ----------------------------------------------------------------------------

-- Registro 20
INSERT INTO Anexo_midia (Id_anexo, id_historico, id_agendamento, url_midia, tipo_midia)
VALUES (1, 2, 2, 'https://storage.unatoppet.com.br/exames/dermatite_max_20261018.jpg', 'imagem');

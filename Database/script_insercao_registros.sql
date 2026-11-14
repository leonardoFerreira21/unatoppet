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
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Cliente, ID_Animal, ID_Profissional)
VALUES (1, '2026-10-15 10:00:00', 'Concluído', 1, 1, 1, 1);

-- Registro 16
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Cliente, ID_Animal, ID_Profissional)
VALUES (2, '2026-10-18 14:30:00', 'Concluído', 3, 3, 3, 3);

-- Registro 17
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Cliente, ID_Animal, ID_Profissional)
VALUES (3, '2026-10-30 09:00:00', 'Agendado', 2, 4, 4, 1);

-- ----------------------------------------------------------------------------
-- Tabela: Historico_saude (Registros 18 e 19)
-- ----------------------------------------------------------------------------

-- Registro 18
INSERT INTO Historico_saude (ID_historico, ID_animal, ID_Profissional, ID_Agendamento, data_registro, tipo_registro, descricao)
VALUES (1, 1, 1, 1, '2026-10-15 10:45:00', 'Atendimento Clínico', 'Animal apresentou bom estado geral, peso 32kg, parâmetros vitais normais.');

-- Registro 19
INSERT INTO Historico_saude (ID_historico, ID_animal, ID_Profissional, ID_Agendamento, data_registro, tipo_registro, descricao)
VALUES (2, 3, 3, 2, '2026-10-18 15:25:00', 'Consulta Especializada', 'Presença de dermatite alérgica leve nas patas. Prescrito shampoo terapêutico.');

-- ----------------------------------------------------------------------------
-- Tabela: Anexo_midia (Registro 20)
-- ----------------------------------------------------------------------------

-- Registro 20
INSERT INTO Anexo_midia (Id_anexo, id_historico, url_midia, tipo_midia)
VALUES (1, 2, 'https://storage.unatoppet.com.br/exames/dermatite_max_20261018.jpg', 'imagem');
-- ----------------------------------------------------------------------------
-- 1. CLIENTES (Cadastros em Outubro e Novembro de 2026)
-- ----------------------------------------------------------------------------
INSERT INTO Cliente (ID_Cliente, Nome, Endereco, Telefone, CPF, Email, Data_Cadastro)
VALUES 
(1, 'Ana Carolina Mendes', 'Rua das Flores, 120 - Centro', '(31) 99123-4567', '123.456.789-01', 'ana.mendes@email.com', '2026-10-01 09:15:00'), -- 01/10/2026
(2, 'Carlos Eduardo Souza', 'Av. Brasil, 1450 - Savassi', '(31) 98234-5678', '234.567.890-12', 'carlos.souza@email.com', '2026-10-02 10:30:00'), -- 02/10/2026
(3, 'Mariana Costa Oliveira', 'Rua Minas Gerais, 85 - Funcionários', '(31) 97345-6789', '345.678.901-23', 'mariana.oliveira@email.com', '2026-10-05 14:20:00'), -- 05/10/2026
(4, 'Roberto Almeida Santos', 'Rua da Bahia, 2100 - Lourdes', '(31) 96456-7890', '456.789.012-34', 'roberto.santos@email.com', '2026-10-10 16:00:00'), -- 10/10/2026
(5, 'Juliana Xavier de Paula', 'Rua Alagoas, 500 - Funcionários', '(31) 98877-1122', '567.890.123-45', 'juliana.paula@email.com', '2026-08-14 08:30:00'), -- 14/08/2026
(6, 'Marcos Vinicius da Silva', 'Av. Afonso Pena, 3800 - Serra', '(31) 97766-2233', '678.901.234-56', 'marcos.silva@email.com', '2026-09-02 11:10:00'), -- 02/09/2026
(7, 'Camila Rocha Antunes', 'Rua Sergipe, 1200 - Savassi', '(31) 96655-3344', '789.012.345-67', 'camila.antunes@email.com', '2026-09-20 14:45:00'), -- 20/09/2026
(8, 'Bruno Henrique Morais', 'Av. Contorno, 6500 - Lourdes', '(31) 95544-4455', '890.123.456-78', 'bruno.morais@email.com', '2026-10-05 16:20:00'), -- 05/10/2026
(9, 'Larissa Mendonça Freitas', 'Rua Pernambuco, 430 - Funcionários', '(31) 94433-5566', '901.234.567-89', 'larissa.freitas@email.com', '2026-11-12 09:00:00'), -- 12/11/2026
(10, 'Patrícia Guimarães Aguiar', 'Rua Piauí, 750 - Santa Efigênia', '(31) 93322-6677', '012.345.678-90', 'patricia.aguiar@email.com', '2026-11-15 10:20:00'), -- 15/11/2026
(11, 'Eduardo Henrique Fonseca', 'Av. Carandaí, 450 - Centro', '(31) 92211-7788', '123.987.654-32', 'eduardo.fonseca@email.com', '2026-11-18 14:00:00'); -- 18/11/2026

-- ----------------------------------------------------------------------------
-- 2. PROFISSIONAIS (Tabela: Profissional)
-- ----------------------------------------------------------------------------
INSERT INTO Profissional (ID_Profissional, Nome, CRMV, Especialidade, Telefone)
VALUES 
(1, 'Dr. Lucas Ferreira Lima', 'CRMV-MG 10234', 'Clínica Geral', '(31) 99811-2233'),
(2, 'Dra. Fernanda Ribeiro', 'CRMV-MG 15432', 'Cirurgia e Ortopedia', '(31) 99722-3344'),
(3, 'Dr. Gabriel Martins', 'CRMV-MG 18765', 'Dermatologia Veterinária', '(31) 99633-4455'),
(4, 'Dra. Beatriz Cardoso', 'CRMV-MG 21450', 'Oftalmologia Veterinária', '(31) 99511-7788'),
(5, 'Dr. Rafael Nogueira', 'CRMV-MG 23891', 'Cardiologia Veterinária', '(31) 99422-8899'),
(6, 'Dra. Camila Duarte', 'CRMV-MG 25102', 'Fisioterapia e Reabilitação', '(31) 99344-5566');

-- ----------------------------------------------------------------------------
-- 3. SERVIÇOS (Tabela: Servico)
-- ----------------------------------------------------------------------------
INSERT INTO Servico (Id_servico, Nome_Servico, Descricao, Categoria, duracao_min, Preco)
VALUES 
(1, 'Consulta Clínica Geral', 'Avaliação clínica completa do animal', 'Consulta', 45, 150.00),
(2, 'Vacinação Polivalente V10', 'Aplicação de vacina importada V10 para cães', 'Vacina', 20, 110.00),
(3, 'Consulta Dermatológica', 'Avaliação especializada de pele e pelagem', 'Especialidade', 60, 220.00),
(4, 'Banho e Tosa Completa', 'Banho com produtos específicos, tosa higiênica e corte de unhas', 'Estética', 60, 95.00),
(5, 'Consulta Oftalmológica', 'Exame detalhado da visão e pressão ocular do pet', 'Especialidade', 45, 250.00),
(6, 'Ecocardiograma Veterinário', 'Exame de imagem cardiológico completo', 'Exame', 40, 300.00),
(7, 'Vacina Antirrábica', 'Imunização obrigatória contra a raiva', 'Vacina', 15, 80.00),
(8, 'Sessão de Fisioterapia', 'Reabilitação motora e alívio de dores articulares', 'Fisioterapia', 50, 180.00),
(9, 'Limpeza de Tártaro (Profilaxia)', 'Remoção de placa bacteriana com ultrassom sob sedação leve', 'Odontologia', 60, 280.00);
-- ----------------------------------------------------------------------------
-- 4. ANIMAIS (Nascimentos formatados para DD/MM/AAAA nos comentários)
-- ----------------------------------------------------------------------------
INSERT INTO Animal (ID_animal, ID_cliente, nome, especie, raca, data_nascimento, sexo, porte)
VALUES 
(1, 1, 'Thor', 'Canina', 'Golden Retriever', '2022-04-15', 'M', 'Grande'),   
(2, 2, 'Luna', 'Felina', 'Siamês', '2023-08-20', 'F', 'Pequeno'),         
(3, 3, 'Max', 'Canina', 'Bulldog Francês', '2021-11-10', 'M', 'Medium'),   
(4, 4, 'Mel', 'Canina', 'Shih Tzu', '2024-01-05', 'F', 'Pequeno'),         
(5, 5, 'Pandora', 'Felina', 'Persa', '2023-02-10', 'F', 'Pequeno'),        
(6, 6, 'Zeus', 'Canina', 'Pastor Alemão', '2020-05-18', 'M', 'Grande'),     
(7, 7, 'Pipoca', 'Canina', 'Poodle', '2022-12-01', 'F', 'Pequeno'),         
(8, 8, 'Paçoca', 'Canina', 'Beagle', '2023-07-14', 'M', 'Médio'),            
(9, 9, 'Fred', 'Felina', 'Maine Coon', '2024-03-22', 'M', 'Grande'),      
(10, 10, 'Bob', 'Canina', 'Border Collie', '2022-09-10', 'M', 'Médio'),     
(11, 11, 'Lola', 'Felina', 'Angorá', '2023-05-14', 'F', 'Pequeno');        
-- ----------------------------------------------------------------------------
-- 5. AGENDAMENTOS (Passados e Futuros)
-- ----------------------------------------------------------------------------
INSERT INTO Agendamento (ID_Agendamento, Data_Hora, status, ID_Servico, ID_Cliente, ID_Animal, ID_Profissional)
VALUES 
(1, '2026-10-15 10:00:00', 'Concluído', 1, 1, 1, 1),   
(2, '2026-10-18 14:30:00', 'Concluído', 3, 3, 3, 3),   
(3, '2026-10-30 09:00:00', 'Agendado', 2, 4, 4, 1),    
(4, '2026-10-05 11:00:00', 'Concluído', 4, 5, 5, 1),   
(5, '2026-10-12 15:00:00', 'Concluído', 5, 6, 6, 4),   
(6, '2026-10-22 09:30:00', 'Concluído', 6, 6, 6, 5),   
(7, '2026-11-03 14:00:00', 'Concluído', 7, 7, 7, 1),   
(8, '2026-11-10 10:30:00', 'Concluído', 4, 8, 8, 2),   
(9, '2026-11-18 13:30:00', 'Agendado', 1, 5, 5, 1),    
(10, '2026-11-20 16:00:00', 'Confirmado', 3, 7, 7, 3), 
(11, '2026-11-25 10:00:00', 'Agendado', 5, 9, 9, 4),   
(12, '2026-12-02 11:30:00', 'Agendado', 2, 8, 8, 1),   
(13, '2026-12-10 15:00:00', 'Agendado', 6, 6, 6, 5),   
(14, '2026-11-19 11:00:00', 'Concluído', 8, 10, 10, 6), 
(15, '2026-11-21 14:00:00', 'Concluído', 9, 2, 2, 1),  
(16, '2026-12-05 09:30:00', 'Agendado', 1, 10, 10, 1),  
(17, '2026-12-08 15:30:00', 'Confirmado', 4, 11, 11, 2),
(18, '2026-12-12 10:00:00', 'Agendado', 8, 3, 3, 6),   
(19, '2026-12-15 14:30:00', 'Agendado', 3, 11, 11, 3);  
-- ----------------------------------------------------------------------------
-- 6. HISTÓRICO DE SAÚDE (Registros médicos)
-- ----------------------------------------------------------------------------
INSERT INTO Historico_saude (ID_historico, ID_animal, ID_Profissional, ID_Agendamento, data_registro, tipo_registro, descricao)
VALUES 
(1, 1, 1, 1, '2026-10-15 10:45:00', 'Atendimento Clínico', 'Animal apresentou bom estado geral, peso 32kg, parâmetros vitais normais.'), 
(2, 3, 3, 2, '2026-10-18 15:25:00', 'Consulta Especializada', 'Presença de dermatite alérgica leve nas patas. Prescrito shampoo terapêutico.'), 
(3, 5, 1, 4, '2026-10-05 11:45:00', 'Atendimento Clínico', 'Gata levemente estressada no banho, mas sem alterações clínicas. Peso: 3.8kg.'), 
(4, 6, 4, 5, '2026-10-12 15:50:00', 'Consulta Oftalmológica', 'Constatada leve irritação conjuntival em ambos os olhos. Indicado colírio lubrificante por 7 dias.'), 
(5, 6, 5, 6, '2026-10-22 10:15:00', 'Exame Cardiológico', 'Ecocardiograma sem alterações estruturais significativas. Função miocárdica preservada.'), 
(6, 7, 1, 7, '2026-11-03 14:25:00', 'Vacinação', 'Aplicação de vacina antirrábica anual. Animal sem reações imediatas.'), 
(7, 8, 2, 8, '2026-11-10 11:15:00', 'Atendimento Estético', 'Realizado banho e tosa completa. Pelagem higienizada e sem parasitas.'), 
(8, 10, 6, 14, '2026-11-19 11:55:00', 'Sessão de Fisioterapia', 'Paciente apresentou melhora na mobilidade do membro posterior direito após leve entorse.'), 
(9, 2, 1, 15, '2026-11-21 15:00:00', 'Procedimento Odontológico', 'Realizada profilaxia dentária. Removido tártaro moderado nos molares. Gengiva saudável.'); 

-- ----------------------------------------------------------------------------
-- 7. ANEXOS DE MÍDIA (Tabela: Anexo_midia)
-- ----------------------------------------------------------------------------
INSERT INTO Anexo_midia (Id_anexo, id_historico, url_midia, tipo_midia)
VALUES 
(1, 2, 'https://storage.unatoppet.com.br/exames/dermatite_max_20261018.jpg', 'imagem'),
(2, 4, 'https://storage.unatoppet.com.br/exames/olho_zeus_20261012.jpg', 'imagem'),
(3, 5, 'https://storage.unatoppet.com.br/laudos/ecocardio_zeus_20261022.pdf', 'pdf'),
(4, 7, 'https://storage.unatoppet.com.br/fotos/balao_pos_banho_20261110.jpg', 'imagem'),
(5, 9, 'https://storage.unatoppet.com.br/exames/odonto_luna_pos_20261121.jpg', 'imagem');

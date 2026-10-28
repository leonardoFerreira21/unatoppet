# Requisitos do Sistema

## 7.1 Requisitos Funcionais

O sistema deve:

| Código | Descrição |
|--------|-----------|
| **RF01** | Permitir cadastrar, pesquisar, atualizar e inativar clientes, com nome, CPF e telefone obrigatórios. |
| **RF02** | Permitir cadastrar, pesquisar, atualizar e inativar animais, vinculados a um cliente, com nome, espécie e raça obrigatórios. |
| **RF03** | Permitir cadastrar e atualizar profissionais, com registro profissional (CRM-V ou equivalente), e definir os serviços que cada um está habilitado a realizar. |
| **RF04** | Permitir cadastrar e atualizar serviços, com nome único e valor definido. |
| **RF05** | Permitir criar agendamentos informando cliente, animal, profissional, serviço, data e horário. |
| **RF06** | Verificar, no momento do agendamento, se o profissional está disponível no horário escolhido, se o horário está dentro do funcionamento da clínica e se o serviço faz parte das especialidades do profissional. |
| **RF07** | Permitir consultar, reagendar e cancelar agendamentos, com consulta por data, profissional ou cliente. |
| **RF08** | Permitir registrar atendimentos a partir de um agendamento prévio, com data, hora, profissional responsável e descrição. |
| **RF09** | Marcar automaticamente o agendamento como concluído após o registro do atendimento. |
| **RF10** | Permitir consultar o histórico de atendimentos de cada animal. |
| **RF11** | Registrar data e usuário responsável em toda alteração feita nos cadastros. |
| **RF12** | Validar os campos obrigatórios antes de salvar qualquer informação. |

## 7.2 Requisitos Não Funcionais

O sistema deve:

| Código | Descrição |
|--------|-----------|
| **RNF01** | Utilizar o SQLite como banco de dados relacional, com tabelas relacionadas por chaves primárias e estrangeiras. |
| **RNF02** | Garantir a integridade dos dados por meio de restrições no banco (chaves, campos únicos e obrigatórios), impedindo a exclusão de registros que possuam dependentes. |
| **RNF03** | Ter interface simples e de fácil utilização pelos funcionários. |
| **RNF04** | Responder às consultas de cadastros, agenda e histórico em poucos segundos. |
| **RNF05** | Permitir a realização de cópias de segurança (backup) do banco de dados. |
| **RNF06** | Manter o código organizado e documentado, para facilitar manutenções futuras. |

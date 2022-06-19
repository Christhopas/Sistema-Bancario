/* =========================================================================== */
/* Implementação do projeto lógico do projeto conceitual                       */
/* cujo tema era Sistema Bancário.                                             */
/* =========================================================================== */



/* --------------------------------------------------------------------------- */
/* LIMPEZA GERAL:                                                              */
/* --------------------------------------------------------------------------- */
/* Esta seção do script faz uma "limpeza geral" no banco de dados, removendo o */
/* banco de dados "sistema_bancario", se ele existir, e o usuário "bancoadmin" */
/* , se ele existir. Obviamente você só deve remover os comentários das linhas */
/* abaixo se você REALMENTE quiser apagar o banco de dados e o usuário.        */
/* --------------------------------------------------------------------------- */

-- Remove o banco de dados "sistema_bancario", se existir:
\echo
\echo Removendo o banco de dados "sistema_bancario":
DROP DATABASE IF EXISTS sistema_bancario;

-- Remove o usuário "bancoadmin", se existir:
\echo
\echo Removendo o usuário "bancoadmin":
DROP USER IF EXISTS bancoadmin;



/* --------------------------------------------------------------------------- */
/* CRIA USUÁRIO E BANCO DE DADOS:                                              */
/* --------------------------------------------------------------------------- */
/* Primeiramente precisamos criar o  usuário "bancoadmin"                      */
/*  e o banco de dados "sistema_bancario".                                     */
/* --------------------------------------------------------------------------- */

-- Cria o usuário "bancoadmin", que será o dono do banco de dados "sistema_bancario". Por
-- segurança esse usuário não será um super-usuário. E, claro, como este é um
-- script de demonstração, usaremos a super-senha "123456".
\echo
\echo Criando o usuário "bancoadmin":
CREATE USER bancoadmin WITH
  NOSUPERUSER
  CREATEDB
  CREATEROLE
  LOGIN
  ENCRYPTED PASSWORD '123456'
;

-- Agora que o usuário já está criado, vamos criar o banco de dados "sistema_bancario" e
-- colocar o usuário "bancoadmin" como o dono desse banco de dados. Além disso
-- configuraremos algumas opções de linguagem para o português do Brasil.
\echo
\echo Criando o banco de dados "sistema_bancario":
CREATE DATABASE sistema_bancario WITH
  owner      = bancoadmin
  template   = template0
  encoding   = 'UTF-8'
  lc_collate = 'pt_BR.UTF-8'
  lc_ctype   = 'pt_BR.UTF-8'
;

COMMENT ON DATABASE sistema_bancario IS 'Banco de dados do Sistema Bancario';



/* ------------------------------------------------------------------------------ */
/* CONEXÃO AO BANCO SISTEMA_BANCARIO E CRIAÇÃO DO SCHEMA BANCO:                   */
/* ------------------------------------------------------------------------------ */
/* Com o usuário e o banco prontos, faremos a conexão ao banco "sistema_bancario" */
/* com o usuário "bancoadmin" e criaremos o schema "banco". Também ajustaremos    */
/* o SEARCH_PATH do usuário para manter o scheme "banco" como o padrão.           */
/* ------------------------------------------------------------------------------ */

-- Conexão ao banco "sistema_bancario" como usuário "bancoadmin", passando a senha via string
-- de conexão. Obviamente isso só está sendo feito porque é um script de
-- demonstração, não se deve passar senhas em scripts em formato texto puro
-- (existem exceções, claro, mas considere que essa regra é válida na maioria
-- das vezes).
\echo
\echo Conectando ao novo banco de dados:
\c "dbname=sistema_bancario user=bancoadmin password=123456"

-- Criação do schema "banco".
\echo
\echo Criando e configurando o schema "banco":
CREATE SCHEMA banco AUTHORIZATION bancoadmin;
COMMENT ON SCHEMA banco IS 'Schema para o db Sistema Bancario.';

-- Configura o SEARCH_PATH do usuário bancoadmin.
ALTER USER bancoadmin SET SEARCH_PATH TO banco, "$user", public;

-- Ajusta o SEARCH_PATH da conexão atual ao banco de dados.
SET SEARCH_PATH TO banco, "$user", public;



/* --------------------------------------------------------------------------- */
/* SERVIÇOS:                                                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "servicos" e dos demais objetos     */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

--Cria a sequência "servicos_seq".
CREATE SEQUENCE IF NOT EXISTS servicos_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "servicos".
\echo
\echo Criando a tabela "servicos" e objetos relacionados:
CREATE TABLE servicos (
                cod_servico INTEGER NOT NULL DEFAULT nextval('servicos_seq'),
                nome_servico VARCHAR(100) NOT NULL,
                descricao VARCHAR(100) NOT NULL,
                valor_min NUMERIC(10,2),
                inicio_vigencia DATE,
                fim_vigencia DATE,
                CONSTRAINT pk_servicos PRIMARY KEY (cod_servico),
                CONSTRAINT chk_servicos CHECK (valor_min > 0 AND fim_vigencia >= inicio_vigencia)
);

-- Comentários da tabela "servicos".
COMMENT ON TABLE servicos                  IS 'Tabela que armazena os serviços das agências';
COMMENT ON COLUMN servicos.cod_servico     IS 'PK da tabela. Código de referencia do serviço.';
COMMENT ON COLUMN servicos.nome_servico    IS 'Nome do serviço.';
COMMENT ON COLUMN servicos.descricao       IS 'Descrição do serviço.';
COMMENT ON COLUMN servicos.valor_min       IS 'Valor mínimo do serviço.';
COMMENT ON COLUMN servicos.inicio_vigencia IS 'Data do início da vigência do serviço.';
COMMENT ON COLUMN servicos.fim_vigencia    IS 'Data do fim da vigência do serviço.';



/* --------------------------------------------------------------------------- */
/* CONTRATOS:                                                                  */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "contratos" e dos demais objetos    */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

--Cria a sequência "contratos_seq".
CREATE SEQUENCE IF NOT EXISTS contratos_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "contratos".
\echo
\echo Criando a tabela "contratos" e objetos relacionados:
CREATE TABLE contratos (
                numero_contrato INTEGER NOT NULL DEFAULT nextval('contratos_seq'),
                data_assinatura DATE NOT NULL,
                resp_contratante VARCHAR(100) NOT NULL,
                resp_contratada VARCHAR(100) NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_contratos PRIMARY KEY (numero_contrato)
);

-- Comentários da tabela "contratos".
COMMENT ON TABLE contratos                   IS 'Tabela que armazena as informações dos contratos.';
COMMENT ON COLUMN contratos.numero_contrato  IS 'PK da tabela. Número do contrato.';
COMMENT ON COLUMN contratos.data_assinatura  IS 'Data em que cada assinatura foi feita.';
COMMENT ON COLUMN contratos.resp_contratante IS 'Descrição das responsabilidades do contratante.';
COMMENT ON COLUMN contratos.resp_contratada  IS 'Descrição das responsabilidades do contratado.';
COMMENT ON COLUMN contratos.cod_servico      IS 'FK da tabela servicos. Código de referencia do serviço.';



/* --------------------------------------------------------------------------- */
/* CARGO:                                                                      */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "cargo" e dos demais objetos        */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

--Cria a sequência "cargo_seq".
CREATE SEQUENCE IF NOT EXISTS cargo_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "cargo".
\echo
\echo Criando a tabela "cargo" e objetos relacionados:
CREATE TABLE cargo (
                cod_cargo INTEGER NOT NULL DEFAULT nextval('cargo_seq'),
                nome_cargo VARCHAR NOT NULL,
                CONSTRAINT pk_cargo PRIMARY KEY (cod_cargo)
);

-- Comentários da tabela "cargo".
COMMENT ON COLUMN cargo.cod_cargo  IS 'PK da tabela. Código identificador de cada cargo.';
COMMENT ON COLUMN cargo.nome_cargo IS 'Nome do cargo correspondente ao código do cargo.';



/* --------------------------------------------------------------------------- */
/* UF:                                                                         */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "uf" e dos demais objetos           */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "uf".
\echo
\echo Criando a tabela "uf" e objetos relacionados:
CREATE TABLE uf (
                uf CHAR(2) NOT NULL,
                nome_uf VARCHAR(100) NOT NULL,
                CONSTRAINT pk_uf PRIMARY KEY (uf)
);

-- Comentários da tabela "uf".
COMMENT ON TABLE uf          IS 'Tabela que armazena as Unidades Federativas do Brasil.';
COMMENT ON COLUMN uf.uf      IS 'PK da tabela. Sigla da UF.';
COMMENT ON COLUMN uf.nome_uf IS 'Nome por extenso da UF.';



/* --------------------------------------------------------------------------- */
/* BAIRRO:                                                                     */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "bairro" e dos demais objetos       */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

--Cria a sequência "bairro_seq".
CREATE SEQUENCE IF NOT EXISTS bairro_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "bairro".
\echo
\echo Criando a tabela "bairro" e objetos relacionados:
CREATE TABLE bairro (
                cod_bairro INTEGER NOT NULL DEFAULT nextval('bairro_seq'),
                nome_bairro VARCHAR(100) NOT NULL,
                CONSTRAINT pk_bairro PRIMARY KEY (cod_bairro)
);

-- Comentários da tabela "bairro".
COMMENT ON TABLE bairro              IS 'Tabela que armazena os bairros.';
COMMENT ON COLUMN bairro.cod_bairro  IS 'PK da tabela. Código identificador do bairro.';
COMMENT ON COLUMN bairro.nome_bairro IS 'Nome dos bairros cadastrados.';



/* --------------------------------------------------------------------------- */
/* CEP:                                                                        */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "cep" e dos demais objetos          */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "cep".
\echo
\echo Criando a tabela "cep" e objetos relacionados:
CREATE TABLE cep (
                cep CHAR(8) NOT NULL,
                CONSTRAINT pk_cep PRIMARY KEY (cep)
);

-- Comentários da tabela "cep".
COMMENT ON TABLE cep      IS 'Tabela que armazena os CEPs.';
COMMENT ON COLUMN cep.cep IS 'PK da tabela. CEP do endereço.';



/* --------------------------------------------------------------------------- */
/* CIDADE:                                                                     */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "cidade" e dos demais objetos       */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

--Cria a sequência "cidade_seq".
CREATE SEQUENCE IF NOT EXISTS cidade_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "cidade".
\echo
\echo Criando a tabela "cidade" e objetos relacionados:
CREATE TABLE cidade (
                cod_cidade INTEGER NOT NULL DEFAULT nextval('cidade_seq'),
                nome_cidade VARCHAR(100) NOT NULL,
                CONSTRAINT pk_cidade PRIMARY KEY (cod_cidade)
);

-- Comentários da tabela "cidade".
COMMENT ON TABLE cidade              IS 'Tabela que armazena as cidades.';
COMMENT ON COLUMN cidade.cod_cidade  IS 'PK da tabela. Código identificador da cidade.';
COMMENT ON COLUMN cidade.nome_cidade IS 'Nome das cidade cadastradas.';



/* --------------------------------------------------------------------------- */
/* CLIENTE:                                                                    */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "cliente" e dos demais objetos      */
/* relacionados (constraints, chaves, checks, etc.).                           */
/* --------------------------------------------------------------------------- */

--Cria a sequência "cliente_seq".
CREATE SEQUENCE IF NOT EXISTS cliente_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "cliente".
\echo
\echo Criando a tabela "cliente" e objetos relacionados:
CREATE TABLE cliente (
                cod_cliente INTEGER NOT NULL DEFAULT nextval('cliente_seq'),
                primeiro_nome VARCHAR(100) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(100) NOT NULL,
                data_nascimento DATE NOT NULL,
                sexo CHAR(1) NOT NULL,
                estado_civil VARCHAR(100) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_cliente CHAR(8) NOT NULL,
                cod_bairro INTEGER NOT NULL,
                cod_cidade INTEGER NOT NULL,
                uf CHAR(2) NOT NULL,
                CONSTRAINT pk_cliente PRIMARY KEY (cod_cliente),
                CONSTRAINT chk_cliente CHECK (sexo IN ('M', 'F'))
);

-- Comentários da tabela "cliente".
COMMENT ON TABLE cliente                  IS 'Tabela que contém os registros dos clientes.';
COMMENT ON COLUMN cliente.cod_cliente     IS 'PK da tabela. Código identificador do cliente.';
COMMENT ON COLUMN cliente.primeiro_nome   IS 'Primeiro nome do cliente.';
COMMENT ON COLUMN cliente.nome_meio       IS 'Inicial do nome do meio do cliente.';
COMMENT ON COLUMN cliente.ultimo_nome     IS 'Último nome do cliente.';
COMMENT ON COLUMN cliente.data_nascimento IS 'Data de nascimento do cliente.';
COMMENT ON COLUMN cliente.sexo            IS 'Sexo do cliente.';
COMMENT ON COLUMN cliente.estado_civil    IS 'Estado civil do cliente.';
COMMENT ON COLUMN cliente.logradouro      IS 'Logradouro do cliente.';
COMMENT ON COLUMN cliente.numero_log      IS 'Número do logradouro.';
COMMENT ON COLUMN cliente.complemento_end IS 'Complemento do endereço.';
COMMENT ON COLUMN cliente.cep_cliente     IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN cliente.cod_bairro      IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN cliente.cod_cidade      IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN cliente.uf              IS 'FK da tabela uf. Sigla da UF.';



/* --------------------------------------------------------------------------- */
/* CLIENTE SERVIÇOS:                                                           */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "cliente_serviços" e dos demais     */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "cliente_servicos".
\echo
\echo Criando a tabela "cliente_servicos" e objetos relacionados:
CREATE TABLE cliente_servicos (
                cod_cliente INTEGER NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_cliente_servicos PRIMARY KEY (cod_cliente, cod_servico)
);

-- Comentários da tabela "cliente_servicos".
COMMENT ON TABLE cliente_servicos              IS 'Tabela intermediária entre clientes e serviços.';
COMMENT ON COLUMN cliente_servicos.cod_cliente IS 'PFK da tabela cliente. Código identificador do cliente.';
COMMENT ON COLUMN cliente_servicos.cod_servico IS 'PFK da tabela servicos. Código de referencia do serviço.';



/* --------------------------------------------------------------------------- */
/* CONTAS:                                                                     */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "contas" e dos demais               */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

--Cria a sequência "contas_seq".
CREATE SEQUENCE IF NOT EXISTS contas_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "contas".
\echo
\echo Criando a tabela "contas" e objetos relacionados:
CREATE TABLE contas (
                numero_conta INTEGER NOT NULL DEFAULT nextval('contas_seq'),
                senha VARCHAR NOT NULL,
                data_abertura DATE NOT NULL,
                saldo INTEGER NOT NULL,
                limite_credito INTEGER NOT NULL,
                cod_cliente INTEGER NOT NULL,
                CONSTRAINT pk_contas PRIMARY KEY (numero_conta),
                CONSTRAINT chk_contas CHECK (limite_credito > 0)
);

-- Comentários da tabela "contas".
COMMENT ON TABLE contas                  IS 'Armazenará as contas de cada cliente.';
COMMENT ON COLUMN contas.numero_conta    IS 'PK da tabela. Número exclusivos de cada conta.';
COMMENT ON COLUMN contas.senha           IS 'Senha da conta do cliente.';
COMMENT ON COLUMN contas.data_abertura   IS 'Data da abertura da conta do cliente.';
COMMENT ON COLUMN contas.saldo           IS 'Saldo da conta do cliente.';
COMMENT ON COLUMN contas.limite_credito  IS 'Limite de credito da conta do cliente.';
COMMENT ON COLUMN contas.cod_cliente     IS 'FK da tabela cliente. Código identificador do cliente.';



/* --------------------------------------------------------------------------- */
/* HISTORICO:                                                                  */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "historico" e dos demais            */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "historico".
\echo
\echo Criando a tabela "historico" e objetos relacionados:
CREATE TABLE historico (
                numero_conta INTEGER NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_historico PRIMARY KEY (numero_conta, cod_servico)
);

-- Comentários da tabela "historico".
COMMENT ON TABLE historico               IS 'Tabela intermediária entre contas e serviços, para mostrar os histórico dos serviços de cada conta.';
COMMENT ON COLUMN historico.numero_conta IS 'PFK da tabela. Número exclusivos de cada conta.';
COMMENT ON COLUMN historico.cod_servico  IS 'PFK da tabela servicos. Código de referencia do serviço.';



/* --------------------------------------------------------------------------- */
/* EMPRESTIMO:                                                                 */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "emprestimo" e dos demais           */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

--Cria a sequência "emprestimo_seq".
CREATE SEQUENCE IF NOT EXISTS emprestimo_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "emprestimo".
\echo
\echo Criando a tabela "emprestimo" e objetos relacionados:
CREATE TABLE emprestimo (
                cod_emprestimo INTEGER NOT NULL DEFAULT nextval('emprestimo_seq'),
                data_aquisicao DATE NOT NULL,
                valor NUMERIC(10,2) NOT NULL,
                cod_cliente INTEGER NOT NULL,
                CONSTRAINT emprestimo_pk PRIMARY KEY (cod_emprestimo),
                CONSTRAINT chk_emprestimo CHECK (valor > 0)
);

-- Comentários da tabela "emprestimo".
COMMENT ON TABLE emprestimo                 IS 'Tabela que armazena os empréstimos dos clientes.';
COMMENT ON COLUMN emprestimo.cod_emprestimo IS 'PK da tabela. Código identificador do empréstimo.';
COMMENT ON COLUMN emprestimo.data_aquisicao IS 'Data de aquisição do empréstimo.';
COMMENT ON COLUMN emprestimo.valor          IS 'Valor do empréstimo.';
COMMENT ON COLUMN emprestimo.cod_cliente    IS 'FK da tabela. Código identificador do cliente.';



/* --------------------------------------------------------------------------- */
/* PARCELA:                                                                    */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "parcela" e dos demais              */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

--Cria a sequência "parcela_seq".
CREATE SEQUENCE IF NOT EXISTS parcela_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "parcela".
\echo
\echo Criando a tabela "parcela" e objetos relacionados:
CREATE TABLE parcela (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL DEFAULT nextval('parcela_seq'),
                valor NUMERIC(10,2) NOT NULL,
                data_vencimento DATE NOT NULL,
                CONSTRAINT parcela_pk PRIMARY KEY (cod_emprestimo, numero_parcela),
                CONSTRAINT chk_parcela CHECK (valor > 0)
);

-- Comentários da tabela "parcela".
COMMENT ON TABLE parcela                 IS 'Tabela que armazena as informações sobre as parcelas dos empréstimos.';
COMMENT ON COLUMN parcela.cod_emprestimo IS 'PFK da tabela emprestimo. Código identificador do empréstimo.';
COMMENT ON COLUMN parcela.numero_parcela IS 'PK da tabela. Número da parcela.';



/* --------------------------------------------------------------------------- */
/* MULTA:                                                                      */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "multa" e dos demais                */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "multa".
\echo
\echo Criando a tabela "multa" e objetos relacionados:
CREATE TABLE multa (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL,
                valor_multa NUMERIC(10,2) NOT NULL,
                CONSTRAINT multa_pk PRIMARY KEY (cod_emprestimo, numero_parcela),
                CONSTRAINT chk_multa CHECK (valor_multa > 0)
);

-- Comentários da tabela "multa".
COMMENT ON TABLE multa                 IS 'Tabela que armazena dados sobre as multas.';
COMMENT ON COLUMN multa.cod_emprestimo IS 'PFK da tabela parcela. Código identificador do empréstimo.';
COMMENT ON COLUMN multa.numero_parcela IS 'PFK da tabela parcela. Número da parcela.';
COMMENT ON COLUMN multa.valor_multa    IS 'Valor da multa.';



/* --------------------------------------------------------------------------- */
/* JUROS:                                                                      */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "juros" e dos demais                */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "juros".
\echo
\echo Criando a tabela "juros" e objetos relacionados:
CREATE TABLE juros (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL,
                valor_juros NUMERIC(10,2) NOT NULL,
                CONSTRAINT juros_pk PRIMARY KEY (cod_emprestimo, numero_parcela),
                CONSTRAINT chk_juros CHECK (valor_juros > 0)
);

-- Comentários da tabela "juros".
COMMENT ON TABLE juros                 IS 'Tabela que armazena dados sobre os juros.';
COMMENT ON COLUMN juros.cod_emprestimo IS 'PFK da tabela parcela. Código identificador do empréstimo.';
COMMENT ON COLUMN juros.numero_parcela IS 'PFK da tabela parcela. Número da parcela.';
COMMENT ON COLUMN juros.valor_juros    IS 'Valor dos juros.';



/* --------------------------------------------------------------------------- */
/* PAGAMENTO:                                                                  */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "pagamento" e dos demais            */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "pagamento".
\echo
\echo Criando a tabela "pagamento" e objetos relacionados:
CREATE TABLE pagamento (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL,
                data_vencimento DATE NOT NULL,
                data_pagamento DATE NOT NULL,
                CONSTRAINT pagamento_pk PRIMARY KEY (cod_emprestimo, numero_parcela),
                CONSTRAINT chk_pagamento CHECK (data_vencimento >= data_pagamento)
);

-- Comentários da tabela "pagamento".
COMMENT ON TABLE pagamento                  IS 'Tabela que armazena dados sobre as parcelas.';
COMMENT ON COLUMN pagamento.cod_emprestimo  IS 'PFK da tabela parcela. Código identificador do empréstimo.';
COMMENT ON COLUMN pagamento.numero_parcela  IS 'PFK da tabela. Número da parcela.';
COMMENT ON COLUMN pagamento.data_vencimento IS 'Data de vencimento do pagamento do empréstimo.';
COMMENT ON COLUMN pagamento.data_pagamento  IS 'Data de pagamento do empréstimo.';



/* --------------------------------------------------------------------------- */
/* EMPREGADOS:                                                                 */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "empregados" e dos demais           */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

--Cria a sequência "empregados_seq".
CREATE SEQUENCE IF NOT EXISTS empregados_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "empregados".
\echo
\echo Criando a tabela "empregados" e objetos relacionados:
CREATE TABLE empregados (
                matricula INTEGER NOT NULL DEFAULT nextval('empregados_seq'),
                primeiro_nome VARCHAR(100) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(100) NOT NULL,
                salario NUMERIC(9,2) NOT NULL,
                cod_cargo INTEGER NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_empregado CHAR(8) NOT NULL,
                cod_bairro INTEGER NOT NULL,
                cod_cidade INTEGER NOT NULL,
                uf CHAR(2) NOT NULL,
                matricula_gerente INTEGER,
                CONSTRAINT empregados_pk PRIMARY KEY (matricula),
                CONSTRAINT chk_empregados CHECK (salario > 0)
);

-- Comentários da tabela "empregados".
COMMENT ON TABLE empregados                    IS 'Tabela que contém os registros dos empregados.';
COMMENT ON COLUMN empregados.matricula         IS 'PK da tabela. Números únicos correspondes a matricula de cada empregado.';
COMMENT ON COLUMN empregados.primeiro_nome     IS 'Primeiro nome do empregado.';
COMMENT ON COLUMN empregados.nome_meio         IS 'Inicial do nome do meio do empregado.';
COMMENT ON COLUMN empregados.ultimo_nome       IS 'Último nome do empregado.';
COMMENT ON COLUMN empregados.salario           IS 'Salário de cada empregado.';
COMMENT ON COLUMN empregados.cod_cargo         IS 'FK da tabela cargo. Código identificador de cada cargo.';
COMMENT ON COLUMN empregados.logradouro        IS 'Logradouro do empregado.';
COMMENT ON COLUMN empregados.numero_log        IS 'Número do logradouro.';
COMMENT ON COLUMN empregados.complemento_end   IS 'Complemento do endereço.';
COMMENT ON COLUMN empregados.cep_empregado     IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN empregados.cod_bairro        IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN empregados.cod_cidade        IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN empregados.uf                IS 'FK da tabela uf. Sigla da UF.';
COMMENT ON COLUMN empregados.matricula_gerente IS 'FK da tabela empregados (relação interna). Número único correspondes a matricula do gerente de cada empregado.';



/* --------------------------------------------------------------------------- */
/* BANCO:                                                                      */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "banco" e dos demais                */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "banco".
\echo
\echo Criando a tabela "banco" e objetos relacionados:
CREATE TABLE banco (
                num_banco CHAR(3) NOT NULL,
                cnpj CHAR(14) NOT NULL,
                razao_social VARCHAR(100) NOT NULL,
                site_banco VARCHAR(200) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_banco CHAR(8) NOT NULL,
                cod_bairro INTEGER NOT NULL,
                cod_cidade INTEGER NOT NULL,
                uf CHAR(2) NOT NULL,
                CONSTRAINT pk_banco PRIMARY KEY (num_banco, cnpj)
);

-- Comentários da tabela "banco".
COMMENT ON TABLE banco                  IS 'Tabela que armazena os dados das sedes dos bancos .';
COMMENT ON COLUMN banco.num_banco       IS 'PK da tabela. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN banco.cnpj            IS 'PK da tabela. CNPJ do banco.';
COMMENT ON COLUMN banco.razao_social    IS 'Razão social (nome) do banco.';
COMMENT ON COLUMN banco.site_banco      IS 'Site do banco.';
COMMENT ON COLUMN banco.logradouro      IS 'Logradouro do banco.';
COMMENT ON COLUMN banco.numero_log      IS 'Número do logradouro.';
COMMENT ON COLUMN banco.complemento_end IS 'Complemento do endereço.';
COMMENT ON COLUMN banco.cep_banco       IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN banco.cod_bairro      IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN banco.cod_cidade      IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN banco.uf              IS 'FK da tabela uf. Sigla da UF.';



/* --------------------------------------------------------------------------- */
/* AGENCIAS:                                                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "agencias" e dos demais             */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

--Cria a sequência "agencias_seq".
CREATE SEQUENCE IF NOT EXISTS agencias_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 999999999999
	START 1
	CACHE 1;

-- Cria a tabela "agencias".
\echo
\echo Criando a tabela "agencias" e objetos relacionados:
CREATE TABLE agencias (
                numero_agencia INTEGER NOT NULL DEFAULT nextval('agencias_seq'),
                num_banco CHAR(3) NOT NULL,
                nome_agencia VARCHAR(100) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_agencia CHAR(8) NOT NULL,
                cod_bairro INTEGER NOT NULL,
                cod_cidade INTEGER NOT NULL,
                uf CHAR(2) NOT NULL,
                cnpj_sede CHAR(14) NOT NULL,
                CONSTRAINT pk_agencias PRIMARY KEY (numero_agencia, num_banco)
);

-- Comentários da tabela "agencias".
COMMENT ON TABLE agencias                   IS 'Tabela que armazena os dados das agências bancárias.';
COMMENT ON COLUMN agencias.numero_agencia   IS 'PK da tabela. Número da agência.';
COMMENT ON COLUMN agencias.num_banco        IS 'PFK da tabela banco. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN agencias.nome_agencia     IS 'Nome da agência';
COMMENT ON COLUMN agencias.logradouro       IS 'Logradouro da agência.';
COMMENT ON COLUMN agencias.numero_log       IS 'Número do logradouro.';
COMMENT ON COLUMN agencias.complemento_end  IS 'Complemento do endereço.';
COMMENT ON COLUMN agencias.cep_agencia      IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN agencias.cod_bairro       IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN agencias.cod_cidade       IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN agencias.uf               IS 'FK da tabela uf. Sigla da UF.';
COMMENT ON COLUMN agencias.cnpj_sede        IS 'FK da tabela banco. CNPJ da sede do banco.';



/* --------------------------------------------------------------------------- */
/* AGENCIAS_SERVIÇOS:                                                          */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "agencias_servicos" e dos demais    */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "agencias_servicos".
\echo
\echo Criando a tabela "agencias_servicos" e objetos relacionados:
CREATE TABLE agencias_servico (
                numero_agencia INTEGER NOT NULL,
                num_banco CHAR(3) NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_agencia_servico PRIMARY KEY (numero_agencia, num_banco, cod_servico)
);

-- Comentários da tabela "agencias_servicos".
COMMENT ON TABLE agencias_servico                 IS 'Tabela intermediária entre agências e serviços.';
COMMENT ON COLUMN agencias_servico.numero_agencia IS 'PFK da tabela agencia. Número da agência.';
COMMENT ON COLUMN agencias_servico.num_banco      IS 'PFK da tabela agencia. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN agencias_servico.cod_servico    IS 'PFK da tabela. Código de referencia do serviço.';



/* --------------------------------------------------------------------------- */
/* LOTAÇÕES:                                                                   */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "lotacoes" e dos demais             */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "lotacoes".
\echo
\echo Criando a tabela "lotacoes" e objetos relacionados:
CREATE TABLE lotacoes (
                matricula INTEGER NOT NULL,
                numero_agencia INTEGER NOT NULL,
                num_banco CHAR(3) NOT NULL,
                funcao_desempenhada VARCHAR(100) NOT NULL,
                dias_trabalho INTEGER NOT NULL,
                horas_trabalho INTEGER NOT NULL,
                CONSTRAINT pk_lotacoes PRIMARY KEY (matricula, numero_agencia, num_banco),
                CONSTRAINT chk_lotacoes CHECK (dias_trabalho > 0 AND dias_trabalho < 6 AND horas_trabalho > 0 AND horas_trabalho > 7 AND horas_trabalho < 45)
);

-- Comentários da tabela "lotacoes".
COMMENT ON TABLE lotacoes                      IS 'Tabela N:N que irá armazenar a função desempenhada, dias de trabalho e os horários de trabalho.';
COMMENT ON COLUMN lotacoes.matricula           IS 'FK da tabela empregados. Por se tratar de uma tabela N:N essa FK serve para ligar a tabela empregados com a tabela agências.';
COMMENT ON COLUMN lotacoes.numero_agencia      IS 'PFK da tabela agencias. Número da agência.';
COMMENT ON COLUMN lotacoes.num_banco           IS 'PFK da tabela agencias. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN lotacoes.funcao_desempenhada IS 'Função que o empregado irá desempenhar dentro do banco.';
COMMENT ON COLUMN lotacoes.dias_trabalho       IS 'Dias trabalhados por cada empregado.';
COMMENT ON COLUMN lotacoes.horas_trabalho      IS 'Quantidade de horas trabalhadas por cada empregado.';



/* --------------------------------------------------------------------------- */
/* TELEFONE AGÊNCIA:                                                           */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "telefone_agencia" e dos demais     */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "telefone_agencia".
\echo
\echo Criando a tabela "telefone_agencia" e objetos relacionados:
CREATE TABLE telefone_agencia (
                tel_agencia VARCHAR(11) NOT NULL,
                numero_agencia INTEGER NOT NULL,
                num_banco CHAR NOT NULL,
                CONSTRAINT pk_telefone_agencia PRIMARY KEY (tel_agencia, numero_agencia, num_banco)
);

-- Comentários da tabela "telefone_agencia".
COMMENT ON TABLE telefone_agencia                 IS 'Tabela que armazena o telefone das agências.';
COMMENT ON COLUMN telefone_agencia.tel_agencia    IS 'PK da tabela. DDD + Número de telefone da agência.';
COMMENT ON COLUMN telefone_agencia.numero_agencia IS 'PFK da tabela agencia. Número da agência.';
COMMENT ON COLUMN telefone_agencia.num_banco      IS 'PFK da tabela agencia. Número identificador do banco, composto por 3 dígitos numéricos.';



/* --------------------------------------------------------------------------- */
/* TELEFONE BANCO:                                                             */
/* --------------------------------------------------------------------------- */
/* Nesta seção faremos a criação da tabela "telefone_banco" e dos demais       */
/* objetos relacionados (constraints, chaves, checks, etc.).                   */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "telefone_banco".
\echo
\echo Criando a tabela "telefone_banco" e objetos relacionados:
CREATE TABLE telefone_banco (
                numero_tel CHAR(11) NOT NULL,
                num_banco CHAR(3) NOT NULL,
                cnpj CHAR(14) NOT NULL,
                CONSTRAINT pk_telefone_banco PRIMARY KEY (numero_tel, num_banco, cnpj)
);

-- Comentários da tabela "telefone_banco".
COMMENT ON TABLE telefone_banco              IS 'Tabela que armazena os telefones dos bancos.';
COMMENT ON COLUMN telefone_banco.numero_tel  IS 'PK da tabela. DDD + Número de telefone do banco.';
COMMENT ON COLUMN telefone_banco.num_banco   IS 'PFK da tabela banco. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN telefone_banco.cnpj        IS 'PFK da tabela banco. CNPJ do banco.';


ALTER TABLE contratos ADD CONSTRAINT servicos_contratos_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico ADD CONSTRAINT servicos_historico_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias_servico ADD CONSTRAINT servicos_agencia_servico_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente_servicos ADD CONSTRAINT servicos_cliente_servicos_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT cargo_empregados_fk
FOREIGN KEY (cod_cargo)
REFERENCES cargo (cod_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco ADD CONSTRAINT uf_banco_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT uf_empregados_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente ADD CONSTRAINT uf_cliente_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias ADD CONSTRAINT uf_agencias_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco ADD CONSTRAINT bairro_banco_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias ADD CONSTRAINT bairro_agencias_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT bairro_empregados_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente ADD CONSTRAINT bairro_cliente_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco ADD CONSTRAINT endereco_banco_fk
FOREIGN KEY (cep_banco)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias ADD CONSTRAINT cep_agencias_fk
FOREIGN KEY (cep_agencia)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT cep_empregados_fk
FOREIGN KEY (cep_empregado)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente ADD CONSTRAINT cep_cliente_fk
FOREIGN KEY (cep_cliente)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco ADD CONSTRAINT cidade_banco_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias ADD CONSTRAINT cidade_agencias_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT cidade_empregados_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente ADD CONSTRAINT cidade_cliente_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE emprestimo ADD CONSTRAINT cliente_emprestimo_fk
FOREIGN KEY (cod_cliente)
REFERENCES cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE contas ADD CONSTRAINT cliente_contas_fk
FOREIGN KEY (cod_cliente)
REFERENCES cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE cliente_servicos ADD CONSTRAINT cliente_cliente_servicos_fk
FOREIGN KEY (cod_cliente)
REFERENCES cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico ADD CONSTRAINT contas_historico_fk
FOREIGN KEY (numero_conta)
REFERENCES contas (numero_conta)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE parcela ADD CONSTRAINT emprestimo_parcela_fk
FOREIGN KEY (cod_emprestimo)
REFERENCES emprestimo (cod_emprestimo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pagamento ADD CONSTRAINT parcela_pagamento_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE juros ADD CONSTRAINT parcela_juros_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE multa ADD CONSTRAINT parcela_multa_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lotacoes ADD CONSTRAINT empregados_lotacoes_fk
FOREIGN KEY (matricula)
REFERENCES empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (matricula_gerente)
REFERENCES empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE telefone_banco ADD CONSTRAINT banco_telefone_banco_fk
FOREIGN KEY (num_banco, cnpj)
REFERENCES banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias ADD CONSTRAINT banco_agencias_fk
FOREIGN KEY (num_banco, cnpj_sede)
REFERENCES banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE telefone_agencia ADD CONSTRAINT agencias_telefone_agencia_fk
FOREIGN KEY (num_banco, numero_agencia)
REFERENCES agencias (num_banco, numero_agencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lotacoes ADD CONSTRAINT agencias_lotacoes_fk
FOREIGN KEY (num_banco, numero_agencia)
REFERENCES agencias (num_banco, numero_agencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE agencias_servico ADD CONSTRAINT agencias_agencia_servico_fk
FOREIGN KEY (numero_agencia, num_banco)
REFERENCES agencias (numero_agencia, num_banco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

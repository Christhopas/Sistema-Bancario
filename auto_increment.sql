
CREATE SEQUENCE banco.servicos_cod_servico_seq;

CREATE TABLE banco.servicos (
                cod_servico INTEGER NOT NULL DEFAULT nextval('banco.servicos_cod_servico_seq'),
                nome_servico VARCHAR(100) NOT NULL,
                descricao VARCHAR(100) NOT NULL,
                valor_min NUMERIC(10,2),
                inicio_vigencia DATE,
                fim_vigencia DATE,
                CONSTRAINT pk_servicos PRIMARY KEY (cod_servico)
);
COMMENT ON TABLE banco.servicos IS 'Tabela que armazena os serviços das agências';
COMMENT ON COLUMN banco.servicos.cod_servico IS 'PK da tabela. Código de referencia do serviço.';
COMMENT ON COLUMN banco.servicos.nome_servico IS 'Nome do serviço.';
COMMENT ON COLUMN banco.servicos.descricao IS 'Descrição do serviço.';
COMMENT ON COLUMN banco.servicos.valor_min IS 'Valor mínimo do serviço.';
COMMENT ON COLUMN banco.servicos.inicio_vigencia IS 'Data do início da vigência do serviço.';
COMMENT ON COLUMN banco.servicos.fim_vigencia IS 'Data do fim da vigência do serviço.';


ALTER SEQUENCE banco.servicos_cod_servico_seq OWNED BY banco.servicos.cod_servico;

CREATE SEQUENCE banco.contratos_numero_contrato_seq;

CREATE TABLE banco.contratos (
                numero_contrato INTEGER NOT NULL DEFAULT nextval('banco.contratos_numero_contrato_seq'),
                data_assinatura DATE NOT NULL,
                resp_contratante VARCHAR(100) NOT NULL,
                resp_contratada VARCHAR(100) NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_contratos PRIMARY KEY (numero_contrato)
);
COMMENT ON TABLE banco.contratos IS 'Tabela que armazena as informações dos contratos.';
COMMENT ON COLUMN banco.contratos.numero_contrato IS 'PK da tabela. Número do contrato.';
COMMENT ON COLUMN banco.contratos.data_assinatura IS 'Data em que cada assinatura foi feita.';
COMMENT ON COLUMN banco.contratos.resp_contratante IS 'Descrição das responsabilidades do contratante.';
COMMENT ON COLUMN banco.contratos.resp_contratada IS 'Descrição das responsabilidades do contratado.';
COMMENT ON COLUMN banco.contratos.cod_servico IS 'FK da tabela servicos. Código de referencia do serviço.';


ALTER SEQUENCE banco.contratos_numero_contrato_seq OWNED BY banco.contratos.numero_contrato;

CREATE SEQUENCE banco.cargo_cod_cargo_seq;

CREATE TABLE banco.cargo (
                cod_cargo INTEGER NOT NULL DEFAULT nextval('banco.cargo_cod_cargo_seq'),
                nome_cargo VARCHAR NOT NULL,
                CONSTRAINT pk_cargo PRIMARY KEY (cod_cargo)
);
COMMENT ON COLUMN banco.cargo.cod_cargo IS 'PK da tabela. Código identificador de cada cargo.';
COMMENT ON COLUMN banco.cargo.nome_cargo IS 'Nome do cargo correspondente ao código do cargo.';


ALTER SEQUENCE banco.cargo_cod_cargo_seq OWNED BY banco.cargo.cod_cargo;

CREATE TABLE banco.uf (
                uf CHAR(2) NOT NULL,
                nome_uf VARCHAR(100) NOT NULL,
                CONSTRAINT pk_uf PRIMARY KEY (uf)
);
COMMENT ON TABLE banco.uf IS 'Tabela que armazena as Unidades Federativas do Brasil.';
COMMENT ON COLUMN banco.uf.uf IS 'PK da tabela. Sigla da UF.';
COMMENT ON COLUMN banco.uf.nome_uf IS 'Nome por extenso da UF.';


CREATE SEQUENCE banco.bairro_cod_bairro_seq;

CREATE TABLE banco.bairro (
                cod_bairro INTEGER NOT NULL DEFAULT nextval('banco.bairro_cod_bairro_seq'),
                nome_bairro VARCHAR(100) NOT NULL,
                CONSTRAINT pk_bairro PRIMARY KEY (cod_bairro)
);
COMMENT ON TABLE banco.bairro IS 'Tabela que armazena os bairros.';
COMMENT ON COLUMN banco.bairro.cod_bairro IS 'PK da tabela. Código identificador do bairro.';
COMMENT ON COLUMN banco.bairro.nome_bairro IS 'Nome dos bairros cadastrados.';


ALTER SEQUENCE banco.bairro_cod_bairro_seq OWNED BY banco.bairro.cod_bairro;

CREATE TABLE banco.cep (
                cep CHAR(8) NOT NULL,
                CONSTRAINT pk_cep PRIMARY KEY (cep)
);
COMMENT ON TABLE banco.cep IS 'Tabela que armazena os CEPs.';
COMMENT ON COLUMN banco.cep.cep IS 'PK da tabela. CEP do endereço.';


CREATE SEQUENCE banco.cidade_cod_cidade_seq;

CREATE TABLE banco.cidade (
                cod_cidade INTEGER NOT NULL DEFAULT nextval('banco.cidade_cod_cidade_seq'),
                nome_cidade VARCHAR(100) NOT NULL,
                CONSTRAINT pk_cidade PRIMARY KEY (cod_cidade)
);
COMMENT ON TABLE banco.cidade IS 'Tabela que armazena as cidades.';
COMMENT ON COLUMN banco.cidade.cod_cidade IS 'PK da tabela. Código identificador da cidade.';
COMMENT ON COLUMN banco.cidade.nome_cidade IS 'Nome das cidade cadastradas.';


ALTER SEQUENCE banco.cidade_cod_cidade_seq OWNED BY banco.cidade.cod_cidade;

CREATE SEQUENCE banco.cliente_cod_cliente_seq;

CREATE TABLE banco.cliente (
                cod_cliente INTEGER NOT NULL DEFAULT nextval('banco.cliente_cod_cliente_seq'),
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
                CONSTRAINT pk_cliente PRIMARY KEY (cod_cliente)
);
COMMENT ON TABLE banco.cliente IS 'Tabela que contém os registros dos clientes.';
COMMENT ON COLUMN banco.cliente.cod_cliente IS 'PK da tabela. Código identificador do cliente.';
COMMENT ON COLUMN banco.cliente.primeiro_nome IS 'Primeiro nome do cliente.';
COMMENT ON COLUMN banco.cliente.nome_meio IS 'Inicial do nome do meio do cliente.';
COMMENT ON COLUMN banco.cliente.ultimo_nome IS 'Último nome do cliente.';
COMMENT ON COLUMN banco.cliente.data_nascimento IS 'Data de nascimento do cliente.';
COMMENT ON COLUMN banco.cliente.sexo IS 'Sexo do cliente.';
COMMENT ON COLUMN banco.cliente.estado_civil IS 'Estado civil do cliente.';
COMMENT ON COLUMN banco.cliente.logradouro IS 'Logradouro do cliente.';
COMMENT ON COLUMN banco.cliente.numero_log IS 'Número do logradouro.';
COMMENT ON COLUMN banco.cliente.complemento_end IS 'Complemento do endereço.';
COMMENT ON COLUMN banco.cliente.cep_cliente IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN banco.cliente.cod_bairro IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN banco.cliente.cod_cidade IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN banco.cliente.uf IS 'FK da tabela uf. Sigla da UF.';


ALTER SEQUENCE banco.cliente_cod_cliente_seq OWNED BY banco.cliente.cod_cliente;

CREATE TABLE banco.cliente_servicos (
                cod_cliente INTEGER NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_cliente_servicos PRIMARY KEY (cod_cliente, cod_servico)
);
COMMENT ON TABLE banco.cliente_servicos IS 'Tabela intermediária entre clientes e serviços.';
COMMENT ON COLUMN banco.cliente_servicos.cod_cliente IS 'PFK da tabela cliente. Código identificador do cliente.';
COMMENT ON COLUMN banco.cliente_servicos.cod_servico IS 'PFK da tabela servicos. Código de referencia do serviço.';


CREATE SEQUENCE banco.contas_numero_conta_seq;

CREATE TABLE banco.contas (
                numero_conta INTEGER NOT NULL DEFAULT nextval('banco.contas_numero_conta_seq'),
                senha VARCHAR NOT NULL,
                data_abertura DATE NOT NULL,
                saldo INTEGER NOT NULL,
                limite_credito INTEGER NOT NULL,
                cod_cliente INTEGER NOT NULL,
                CONSTRAINT pk_contas PRIMARY KEY (numero_conta)
);
COMMENT ON TABLE banco.contas IS 'Armazenará as contas de cada cliente.';
COMMENT ON COLUMN banco.contas.numero_conta IS 'PK da tabela. Número exclusivos de cada conta.';
COMMENT ON COLUMN banco.contas.senha IS 'Senha da conta do cliente.';
COMMENT ON COLUMN banco.contas.data_abertura IS 'Data da abertura da conta do cliente.';
COMMENT ON COLUMN banco.contas.saldo IS 'Saldo da conta do cliente.';
COMMENT ON COLUMN banco.contas.limite_credito IS 'Limite de credito da conta do cliente.';
COMMENT ON COLUMN banco.contas.cod_cliente IS 'FK da tabela cliente. Código identificador do cliente.';


ALTER SEQUENCE banco.contas_numero_conta_seq OWNED BY banco.contas.numero_conta;

CREATE TABLE banco.historico (
                numero_conta INTEGER NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_historico PRIMARY KEY (numero_conta, cod_servico)
);
COMMENT ON TABLE banco.historico IS 'Tabela intermediária entre contas e serviços, para mostrar os histórico dos serviços de cada conta.';
COMMENT ON COLUMN banco.historico.numero_conta IS 'PFK da tabela. Número exclusivos de cada conta.';
COMMENT ON COLUMN banco.historico.cod_servico IS 'PFK da tabela servicos. Código de referencia do serviço.';


CREATE SEQUENCE banco.emprestimo_cod_emprestimo_seq;

CREATE TABLE banco.emprestimo (
                cod_emprestimo INTEGER NOT NULL DEFAULT nextval('banco.emprestimo_cod_emprestimo_seq'),
                data_aquisicao DATE NOT NULL,
                valor NUMERIC(10,2) NOT NULL,
                cod_cliente INTEGER NOT NULL,
                CONSTRAINT emprestimo_pk PRIMARY KEY (cod_emprestimo)
);
COMMENT ON TABLE banco.emprestimo IS 'Tabela que armazena os empréstimos dos clientes.';
COMMENT ON COLUMN banco.emprestimo.cod_emprestimo IS 'PK da tabela. Código identificador do empréstimo.';
COMMENT ON COLUMN banco.emprestimo.data_aquisicao IS 'Data de aquisição do empréstimo.';
COMMENT ON COLUMN banco.emprestimo.valor IS 'Valor do empréstimo.';
COMMENT ON COLUMN banco.emprestimo.cod_cliente IS 'FK da tabela. Código identificador do cliente.';


ALTER SEQUENCE banco.emprestimo_cod_emprestimo_seq OWNED BY banco.emprestimo.cod_emprestimo;

CREATE SEQUENCE banco.parcela_numero_parcela_seq;

CREATE TABLE banco.parcela (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL DEFAULT nextval('banco.parcela_numero_parcela_seq'),
                valor NUMERIC(10,2) NOT NULL,
                data_vencimento DATE NOT NULL,
                CONSTRAINT parcela_pk PRIMARY KEY (cod_emprestimo, numero_parcela)
);
COMMENT ON TABLE banco.parcela IS 'Tabela que armazena as informações sobre as parcelas dos empréstimos.';
COMMENT ON COLUMN banco.parcela.cod_emprestimo IS 'PFK da tabela emprestimo. Código identificador do empréstimo.';
COMMENT ON COLUMN banco.parcela.numero_parcela IS 'PK da tabela. Número da parcela.';


ALTER SEQUENCE banco.parcela_numero_parcela_seq OWNED BY banco.parcela.numero_parcela;

CREATE TABLE banco.multa (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL,
                valor_multa NUMERIC(10,2) NOT NULL,
                CONSTRAINT multa_pk PRIMARY KEY (cod_emprestimo, numero_parcela)
);
COMMENT ON TABLE banco.multa IS 'Tabela que armazena dados sobre as multas.';
COMMENT ON COLUMN banco.multa.cod_emprestimo IS 'PFK da tabela parcela. Código identificador do empréstimo.';
COMMENT ON COLUMN banco.multa.numero_parcela IS 'PFK da tabela parcela. Número da parcela.';
COMMENT ON COLUMN banco.multa.valor_multa IS 'Valor da multa.';


CREATE TABLE banco.juros (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL,
                valor_juros NUMERIC(10,2) NOT NULL,
                CONSTRAINT juros_pk PRIMARY KEY (cod_emprestimo, numero_parcela)
);
COMMENT ON TABLE banco.juros IS 'Tabela que armazena dados sobre os juros.';
COMMENT ON COLUMN banco.juros.cod_emprestimo IS 'PFK da tabela parcela. Código identificador do empréstimo.';
COMMENT ON COLUMN banco.juros.numero_parcela IS 'PFK da tabela parcela. Número da parcela.';
COMMENT ON COLUMN banco.juros.valor_juros IS 'Valor dos juros.';


CREATE TABLE banco.pagamento (
                cod_emprestimo INTEGER NOT NULL,
                numero_parcela INTEGER NOT NULL,
                data_vencimento DATE NOT NULL,
                data_pagamento DATE NOT NULL,
                CONSTRAINT pagamento_pk PRIMARY KEY (cod_emprestimo, numero_parcela)
);
COMMENT ON TABLE banco.pagamento IS 'Tabela que armazena dados sobre as parcelas.';
COMMENT ON COLUMN banco.pagamento.cod_emprestimo IS 'PFK da tabela parcela. Código identificador do empréstimo.';
COMMENT ON COLUMN banco.pagamento.numero_parcela IS 'PFK da tabela. Número da parcela.';
COMMENT ON COLUMN banco.pagamento.data_vencimento IS 'Data de vencimento do pagamento do empréstimo.';
COMMENT ON COLUMN banco.pagamento.data_pagamento IS 'Data de pagamento do empréstimo.';


CREATE SEQUENCE banco.empregados_matricula_seq;

CREATE TABLE banco.empregados (
                matricula INTEGER NOT NULL DEFAULT nextval('banco.empregados_matricula_seq'),
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
                CONSTRAINT empregados_pk PRIMARY KEY (matricula)
);
COMMENT ON TABLE banco.empregados IS 'Tabela que contém os registros dos empregados.';
COMMENT ON COLUMN banco.empregados.matricula IS 'PK da tabela. Números únicos correspondes a matricula de cada empregado.';
COMMENT ON COLUMN banco.empregados.primeiro_nome IS 'Primeiro nome do empregado.';
COMMENT ON COLUMN banco.empregados.nome_meio IS 'Inicial do nome do meio do empregado.';
COMMENT ON COLUMN banco.empregados.ultimo_nome IS 'Último nome do empregado.';
COMMENT ON COLUMN banco.empregados.salario IS 'Salário de cada empregado.';
COMMENT ON COLUMN banco.empregados.cod_cargo IS 'FK da tabela cargo. Código identificador de cada cargo.';
COMMENT ON COLUMN banco.empregados.logradouro IS 'Logradouro do empregado.';
COMMENT ON COLUMN banco.empregados.numero_log IS 'Número do logradouro.';
COMMENT ON COLUMN banco.empregados.complemento_end IS 'Complemento do endereço.';
COMMENT ON COLUMN banco.empregados.cep_empregado IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN banco.empregados.cod_bairro IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN banco.empregados.cod_cidade IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN banco.empregados.uf IS 'FK da tabela uf. Sigla da UF.';
COMMENT ON COLUMN banco.empregados.matricula_gerente IS 'FK da tabela empregados (relação interna). Número único correspondes a matricula do gerente de cada empregado.';


ALTER SEQUENCE banco.empregados_matricula_seq OWNED BY banco.empregados.matricula;

CREATE TABLE banco.banco (
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
COMMENT ON TABLE banco.banco IS 'Tabela que armazena os dados das sedes dos bancos .';
COMMENT ON COLUMN banco.banco.num_banco IS 'PK da tabela. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN banco.banco.cnpj IS 'PK da tabela. CNPJ do banco.';
COMMENT ON COLUMN banco.banco.razao_social IS 'Razão social (nome) do banco.';
COMMENT ON COLUMN banco.banco.site_banco IS 'Site do banco.';
COMMENT ON COLUMN banco.banco.logradouro IS 'Logradouro do banco.';
COMMENT ON COLUMN banco.banco.numero_log IS 'Número do logradouro.';
COMMENT ON COLUMN banco.banco.complemento_end IS 'Complemento do endereço.';
COMMENT ON COLUMN banco.banco.cep_banco IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN banco.banco.cod_bairro IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN banco.banco.cod_cidade IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN banco.banco.uf IS 'FK da tabela uf. Sigla da UF.';


CREATE TABLE banco.agencias (
                numero_agencia INTEGER NOT NULL,
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
COMMENT ON TABLE banco.agencias IS 'Tabela que armazena os dados das agências bancárias.';
COMMENT ON COLUMN banco.agencias.numero_agencia IS 'PK da tabela. Número da agência.';
COMMENT ON COLUMN banco.agencias.num_banco IS 'PFK da tabela banco. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN banco.agencias.nome_agencia IS 'Nome da agência';
COMMENT ON COLUMN banco.agencias.logradouro IS 'Logradouro da agência.';
COMMENT ON COLUMN banco.agencias.numero_log IS 'Número do logradouro.';
COMMENT ON COLUMN banco.agencias.complemento_end IS 'Complemento do endereço.';
COMMENT ON COLUMN banco.agencias.cep_agencia IS 'FK da tabela cep. CEP do endereço.';
COMMENT ON COLUMN banco.agencias.cod_bairro IS 'FK da tabela bairro. Código identificador do bairro.';
COMMENT ON COLUMN banco.agencias.cod_cidade IS 'FK da tabela cidade. Código identificador da cidade.';
COMMENT ON COLUMN banco.agencias.uf IS 'FK da tabela uf. Sigla da UF.';
COMMENT ON COLUMN banco.agencias.cnpj_sede IS 'FK da tabela banco. CNPJ da sede do banco.';


CREATE TABLE banco.agencias_servico (
                numero_agencia INTEGER NOT NULL,
                num_banco CHAR(3) NOT NULL,
                cod_servico INTEGER NOT NULL,
                CONSTRAINT pk_agencia_servico PRIMARY KEY (numero_agencia, num_banco, cod_servico)
);
COMMENT ON TABLE banco.agencias_servico IS 'Tabela intermediária entre agências e serviços.';
COMMENT ON COLUMN banco.agencias_servico.numero_agencia IS 'PFK da tabela agencia. Número da agência.';
COMMENT ON COLUMN banco.agencias_servico.num_banco IS 'PFK da tabela agencia. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN banco.agencias_servico.cod_servico IS 'PFK da tabela. Código de referencia do serviço.';


CREATE TABLE banco.lotacoes (
                matricula INTEGER NOT NULL,
                numero_agencia INTEGER NOT NULL,
                num_banco CHAR(3) NOT NULL,
                funcao_desempenhada VARCHAR(100) NOT NULL,
                dias_trabalho INTEGER NOT NULL,
                horas_trabalho INTEGER NOT NULL,
                CONSTRAINT pk_lotacoes PRIMARY KEY (matricula, numero_agencia, num_banco)
);
COMMENT ON TABLE banco.lotacoes IS 'Tabela N:N que irá armazenar a função desempenhada, dias de trabalho e os horários de trabalho.';
COMMENT ON COLUMN banco.lotacoes.matricula IS 'FK da tabela empregados. Por se tratar de uma tabela N:N essa FK serve para ligar a tabela empregados com a tabela agências.';
COMMENT ON COLUMN banco.lotacoes.numero_agencia IS 'PFK da tabela agencias. Número da agência.';
COMMENT ON COLUMN banco.lotacoes.num_banco IS 'PFK da tabela agencias. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN banco.lotacoes.funcao_desempenhada IS 'Função que o empregado irá desempenhar dentro do banco.';
COMMENT ON COLUMN banco.lotacoes.dias_trabalho IS 'Número de dias na semana trabalhados por cada empregado.';
COMMENT ON COLUMN banco.lotacoes.horas_trabalho IS 'Quantidade de horas  na semana trabalhadas por cada empregado.';


CREATE TABLE banco.telefone_agencia (
                tel_agencia VARCHAR(11) NOT NULL,
                numero_agencia INTEGER NOT NULL,
                num_banco CHAR NOT NULL,
                CONSTRAINT pk_telefone_agencia PRIMARY KEY (tel_agencia, numero_agencia, num_banco)
);
COMMENT ON TABLE banco.telefone_agencia IS 'Tabela que armazena o telefone das agências.';
COMMENT ON COLUMN banco.telefone_agencia.tel_agencia IS 'PK da tabela. DDD + Número de telefone da agência.';
COMMENT ON COLUMN banco.telefone_agencia.numero_agencia IS 'PFK da tabela agencia. Número da agência.';
COMMENT ON COLUMN banco.telefone_agencia.num_banco IS 'PFK da tabela agencia. Número identificador do banco, composto por 3 dígitos numéricos.';


CREATE TABLE banco.telefone_banco (
                numero_tel CHAR(11) NOT NULL,
                num_banco CHAR(3) NOT NULL,
                cnpj CHAR(14) NOT NULL,
                CONSTRAINT pk_telefone_banco PRIMARY KEY (numero_tel, num_banco, cnpj)
);
COMMENT ON TABLE banco.telefone_banco IS 'Tabela que armazena os telefones dos bancos.';
COMMENT ON COLUMN banco.telefone_banco.numero_tel IS 'PK da tabela. DDD + Número de telefone do banco.';
COMMENT ON COLUMN banco.telefone_banco.num_banco IS 'PFK da tabela banco. Número identificador do banco, composto por 3 dígitos numéricos.';
COMMENT ON COLUMN banco.telefone_banco.cnpj IS 'PFK da tabela banco. CNPJ do banco.';


ALTER TABLE banco.contratos ADD CONSTRAINT servicos_contratos_fk
FOREIGN KEY (cod_servico)
REFERENCES banco.servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.historico ADD CONSTRAINT servicos_historico_fk
FOREIGN KEY (cod_servico)
REFERENCES banco.servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias_servico ADD CONSTRAINT servicos_agencia_servico_fk
FOREIGN KEY (cod_servico)
REFERENCES banco.servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.cliente_servicos ADD CONSTRAINT servicos_cliente_servicos_fk
FOREIGN KEY (cod_servico)
REFERENCES banco.servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.empregados ADD CONSTRAINT cargo_empregados_fk
FOREIGN KEY (cod_cargo)
REFERENCES banco.cargo (cod_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.banco ADD CONSTRAINT uf_banco_fk
FOREIGN KEY (uf)
REFERENCES banco.uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.empregados ADD CONSTRAINT uf_empregados_fk
FOREIGN KEY (uf)
REFERENCES banco.uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.cliente ADD CONSTRAINT uf_cliente_fk
FOREIGN KEY (uf)
REFERENCES banco.uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias ADD CONSTRAINT uf_agencias_fk
FOREIGN KEY (uf)
REFERENCES banco.uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.banco ADD CONSTRAINT bairro_banco_fk
FOREIGN KEY (cod_bairro)
REFERENCES banco.bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias ADD CONSTRAINT bairro_agencias_fk
FOREIGN KEY (cod_bairro)
REFERENCES banco.bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.empregados ADD CONSTRAINT bairro_empregados_fk
FOREIGN KEY (cod_bairro)
REFERENCES banco.bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.cliente ADD CONSTRAINT bairro_cliente_fk
FOREIGN KEY (cod_bairro)
REFERENCES banco.bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.banco ADD CONSTRAINT endereco_banco_fk
FOREIGN KEY (cep_banco)
REFERENCES banco.cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias ADD CONSTRAINT cep_agencias_fk
FOREIGN KEY (cep_agencia)
REFERENCES banco.cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.empregados ADD CONSTRAINT cep_empregados_fk
FOREIGN KEY (cep_empregado)
REFERENCES banco.cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.cliente ADD CONSTRAINT cep_cliente_fk
FOREIGN KEY (cep_cliente)
REFERENCES banco.cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.banco ADD CONSTRAINT cidade_banco_fk
FOREIGN KEY (cod_cidade)
REFERENCES banco.cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias ADD CONSTRAINT cidade_agencias_fk
FOREIGN KEY (cod_cidade)
REFERENCES banco.cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.empregados ADD CONSTRAINT cidade_empregados_fk
FOREIGN KEY (cod_cidade)
REFERENCES banco.cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.cliente ADD CONSTRAINT cidade_cliente_fk
FOREIGN KEY (cod_cidade)
REFERENCES banco.cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.emprestimo ADD CONSTRAINT cliente_emprestimo_fk
FOREIGN KEY (cod_cliente)
REFERENCES banco.cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.contas ADD CONSTRAINT cliente_contas_fk
FOREIGN KEY (cod_cliente)
REFERENCES banco.cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.cliente_servicos ADD CONSTRAINT cliente_cliente_servicos_fk
FOREIGN KEY (cod_cliente)
REFERENCES banco.cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.historico ADD CONSTRAINT contas_historico_fk
FOREIGN KEY (numero_conta)
REFERENCES banco.contas (numero_conta)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.parcela ADD CONSTRAINT emprestimo_parcela_fk
FOREIGN KEY (cod_emprestimo)
REFERENCES banco.emprestimo (cod_emprestimo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.pagamento ADD CONSTRAINT parcela_pagamento_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES banco.parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.juros ADD CONSTRAINT parcela_juros_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES banco.parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.multa ADD CONSTRAINT parcela_multa_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES banco.parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.lotacoes ADD CONSTRAINT empregados_lotacoes_fk
FOREIGN KEY (matricula)
REFERENCES banco.empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (matricula_gerente)
REFERENCES banco.empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.telefone_banco ADD CONSTRAINT banco_telefone_banco_fk
FOREIGN KEY (num_banco, cnpj)
REFERENCES banco.banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias ADD CONSTRAINT banco_agencias_fk
FOREIGN KEY (num_banco, cnpj_sede)
REFERENCES banco.banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.telefone_agencia ADD CONSTRAINT agencias_telefone_agencia_fk
FOREIGN KEY (num_banco, numero_agencia)
REFERENCES banco.agencias (num_banco, numero_agencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.lotacoes ADD CONSTRAINT agencias_lotacoes_fk
FOREIGN KEY (num_banco, numero_agencia)
REFERENCES banco.agencias (num_banco, numero_agencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE banco.agencias_servico ADD CONSTRAINT agencias_agencia_servico_fk
FOREIGN KEY (numero_agencia, num_banco)
REFERENCES banco.agencias (numero_agencia, num_banco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

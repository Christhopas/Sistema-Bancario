
CREATE TABLE servicos (
                cod_servico INT NOT NULL,
                nome_servico VARCHAR(100) NOT NULL,
                descricao VARCHAR(100) NOT NULL,
                valor_min DECIMAL(10,2),
                inicio_vigencia DATE,
                fim_vigencia DATE,
                PRIMARY KEY (cod_servico)
);

ALTER TABLE servicos COMMENT 'Tabela que armazena os serviços das agências';

ALTER TABLE servicos MODIFY COLUMN cod_servico INTEGER COMMENT 'PK da tabela. Código de referencia do serviço.';

ALTER TABLE servicos MODIFY COLUMN nome_servico VARCHAR(100) COMMENT 'Nome do serviço.';

ALTER TABLE servicos MODIFY COLUMN descricao VARCHAR(100) COMMENT 'Descrição do serviço.';

ALTER TABLE servicos MODIFY COLUMN valor_min DECIMAL(10, 2) COMMENT 'Valor mínimo do serviço.';

ALTER TABLE servicos MODIFY COLUMN inicio_vigencia DATE COMMENT 'Data do início da vigência do serviço.';

ALTER TABLE servicos MODIFY COLUMN fim_vigencia DATE COMMENT 'Data do fim da vigência do serviço.';


CREATE TABLE contratos (
                numero_contrato INT NOT NULL,
                data_assinatura DATE NOT NULL,
                resp_contratante VARCHAR(100) NOT NULL,
                resp_contratada VARCHAR(100) NOT NULL,
                cod_servico INT NOT NULL,
                PRIMARY KEY (numero_contrato)
);

ALTER TABLE contratos COMMENT 'Tabela que armazena as informações dos contratos.';

ALTER TABLE contratos MODIFY COLUMN numero_contrato INTEGER COMMENT 'PK da tabela. Número do contrato.';

ALTER TABLE contratos MODIFY COLUMN data_assinatura DATE COMMENT 'Data em que cada assinatura foi feita.';

ALTER TABLE contratos MODIFY COLUMN resp_contratante VARCHAR(100) COMMENT 'Descrição das responsabilidades do contratante.';

ALTER TABLE contratos MODIFY COLUMN resp_contratada VARCHAR(100) COMMENT 'Descrição das responsabilidades do contratado.';

ALTER TABLE contratos MODIFY COLUMN cod_servico INTEGER COMMENT 'FK da tabela servicos. Código de referencia do serviço.';


CREATE TABLE cargo (
                cod_cargo INT NOT NULL,
                nome_cargo VARCHAR NOT NULL,
                PRIMARY KEY (cod_cargo)
);

ALTER TABLE cargo MODIFY COLUMN cod_cargo INTEGER COMMENT 'PK da tabela. Código identificador de cada cargo.';

ALTER TABLE cargo MODIFY COLUMN nome_cargo VARCHAR COMMENT 'Nome do cargo correspondente ao código do cargo.';


CREATE TABLE uf (
                uf CHAR(2) NOT NULL,
                nome_uf VARCHAR(100) NOT NULL,
                PRIMARY KEY (uf)
);

ALTER TABLE uf COMMENT 'Tabela que armazena as Unidades Federativas do Brasil.';

ALTER TABLE uf MODIFY COLUMN uf CHAR(2) COMMENT 'PK da tabela. Sigla da UF.';

ALTER TABLE uf MODIFY COLUMN nome_uf VARCHAR(100) COMMENT 'Nome por extenso da UF.';


CREATE TABLE bairro (
                cod_bairro INT NOT NULL,
                nome_bairro VARCHAR(100) NOT NULL,
                PRIMARY KEY (cod_bairro)
);

ALTER TABLE bairro COMMENT 'Tabela que armazena os bairros.';

ALTER TABLE bairro MODIFY COLUMN cod_bairro INTEGER COMMENT 'PK da tabela. Código identificador do bairro.';

ALTER TABLE bairro MODIFY COLUMN nome_bairro VARCHAR(100) COMMENT 'Nome dos bairros cadastrados.';


CREATE TABLE cep (
                cep CHAR(8) NOT NULL,
                PRIMARY KEY (cep)
);

ALTER TABLE cep COMMENT 'Tabela que armazena os CEPs.';

ALTER TABLE cep MODIFY COLUMN cep CHAR(8) COMMENT 'PK da tabela. CEP do endereço.';


CREATE TABLE cidade (
                cod_cidade INT NOT NULL,
                nome_cidade VARCHAR(100) NOT NULL,
                PRIMARY KEY (cod_cidade)
);

ALTER TABLE cidade COMMENT 'Tabela que armazena as cidades.';

ALTER TABLE cidade MODIFY COLUMN cod_cidade INTEGER COMMENT 'PK da tabela. Código identificador da cidade.';

ALTER TABLE cidade MODIFY COLUMN nome_cidade VARCHAR(100) COMMENT 'Nome das cidade cadastradas.';


CREATE TABLE cliente (
                cod_cliente INT NOT NULL,
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
                cod_bairro INT NOT NULL,
                cod_cidade INT NOT NULL,
                uf CHAR(2) NOT NULL,
                PRIMARY KEY (cod_cliente)
);

ALTER TABLE cliente COMMENT 'Tabela que contém os registros dos clientes.';

ALTER TABLE cliente MODIFY COLUMN cod_cliente INTEGER COMMENT 'PK da tabela. Código identificador do cliente.';

ALTER TABLE cliente MODIFY COLUMN primeiro_nome VARCHAR(100) COMMENT 'Primeiro nome do cliente.';

ALTER TABLE cliente MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio do cliente.';

ALTER TABLE cliente MODIFY COLUMN ultimo_nome VARCHAR(100) COMMENT 'Último nome do cliente.';

ALTER TABLE cliente MODIFY COLUMN data_nascimento DATE COMMENT 'Data de nascimento do cliente.';

ALTER TABLE cliente MODIFY COLUMN sexo CHAR(1) COMMENT 'Sexo do cliente.';

ALTER TABLE cliente MODIFY COLUMN estado_civil VARCHAR(100) COMMENT 'Estado civil do cliente.';

ALTER TABLE cliente MODIFY COLUMN logradouro VARCHAR(150) COMMENT 'Logradouro do cliente.';

ALTER TABLE cliente MODIFY COLUMN numero_log VARCHAR(10) COMMENT 'Número do logradouro.';

ALTER TABLE cliente MODIFY COLUMN complemento_end VARCHAR(150) COMMENT 'Complemento do endereço.';

ALTER TABLE cliente MODIFY COLUMN cep_cliente CHAR(8) COMMENT 'FK da tabela cep. CEP do endereço.';

ALTER TABLE cliente MODIFY COLUMN cod_bairro INTEGER COMMENT 'FK da tabela bairro. Código identificador do bairro.';

ALTER TABLE cliente MODIFY COLUMN cod_cidade INTEGER COMMENT 'FK da tabela cidade. Código identificador da cidade.';

ALTER TABLE cliente MODIFY COLUMN uf CHAR(2) COMMENT 'FK da tabela uf. Sigla da UF.';


CREATE TABLE cliente_servicos (
                cod_cliente INT NOT NULL,
                cod_servico INT NOT NULL,
                PRIMARY KEY (cod_cliente, cod_servico)
);

ALTER TABLE cliente_servicos COMMENT 'Tabela intermediária entre clientes e serviços.';

ALTER TABLE cliente_servicos MODIFY COLUMN cod_cliente INTEGER COMMENT 'PFK da tabela cliente. Código identificador do cliente.';

ALTER TABLE cliente_servicos MODIFY COLUMN cod_servico INTEGER COMMENT 'PFK da tabela servicos. Código de referencia do serviço.';


CREATE TABLE contas (
                numero_conta INT NOT NULL,
                senha VARCHAR NOT NULL,
                data_abertura DATE NOT NULL,
                saldo INT NOT NULL,
                limite_credito INT NOT NULL,
                cod_cliente INT NOT NULL,
                PRIMARY KEY (numero_conta)
);

ALTER TABLE contas COMMENT 'Armazenará as contas de cada cliente.';

ALTER TABLE contas MODIFY COLUMN numero_conta INTEGER COMMENT 'PK da tabela. Número exclusivos de cada conta.';

ALTER TABLE contas MODIFY COLUMN senha VARCHAR COMMENT 'Senha da conta do cliente.';

ALTER TABLE contas MODIFY COLUMN data_abertura DATE COMMENT 'Data da abertura da conta do cliente.';

ALTER TABLE contas MODIFY COLUMN saldo INTEGER COMMENT 'Saldo da conta do cliente.';

ALTER TABLE contas MODIFY COLUMN limite_credito INTEGER COMMENT 'Limite de credito da conta do cliente.';

ALTER TABLE contas MODIFY COLUMN cod_cliente INTEGER COMMENT 'FK da tabela cliente. Código identificador do cliente.';


CREATE TABLE historico (
                numero_conta INT NOT NULL,
                cod_servico INT NOT NULL,
                PRIMARY KEY (numero_conta, cod_servico)
);

ALTER TABLE historico COMMENT 'Tabela intermediária entre contas e serviços, para mostrar os histórico dos serviços de cada conta.';

ALTER TABLE historico MODIFY COLUMN numero_conta INTEGER COMMENT 'PFK da tabela. Número exclusivos de cada conta.';

ALTER TABLE historico MODIFY COLUMN cod_servico INTEGER COMMENT 'PFK da tabela servicos. Código de referencia do serviço.';


CREATE TABLE emprestimo (
                cod_emprestimo INT NOT NULL,
                data_aquisicao DATE NOT NULL,
                valor DECIMAL(10,2) NOT NULL,
                cod_cliente INT NOT NULL,
                PRIMARY KEY (cod_emprestimo)
);

ALTER TABLE emprestimo COMMENT 'Tabela que armazena os empréstimos dos clientes.';

ALTER TABLE emprestimo MODIFY COLUMN cod_emprestimo INTEGER COMMENT 'PK da tabela. Código identificador do empréstimo.';

ALTER TABLE emprestimo MODIFY COLUMN data_aquisicao DATE COMMENT 'Data de aquisição do empréstimo.';

ALTER TABLE emprestimo MODIFY COLUMN valor DECIMAL(10, 2) COMMENT 'Valor do empréstimo.';

ALTER TABLE emprestimo MODIFY COLUMN cod_cliente INTEGER COMMENT 'FK da tabela. Código identificador do cliente.';


CREATE TABLE parcela (
                cod_emprestimo INT NOT NULL,
                numero_parcela INT NOT NULL,
                valor DECIMAL(10,2) NOT NULL,
                data_vencimento DATE NOT NULL,
                PRIMARY KEY (cod_emprestimo, numero_parcela)
);

ALTER TABLE parcela COMMENT 'Tabela que armazena as informações sobre as parcelas dos empréstimos.';

ALTER TABLE parcela MODIFY COLUMN cod_emprestimo INTEGER COMMENT 'PFK da tabela emprestimo. Código identificador do empréstimo.';

ALTER TABLE parcela MODIFY COLUMN numero_parcela INTEGER COMMENT 'PK da tabela. Número da parcela.';


CREATE TABLE multa (
                cod_emprestimo INT NOT NULL,
                numero_parcela INT NOT NULL,
                valor_multa DECIMAL(10,2) NOT NULL,
                PRIMARY KEY (cod_emprestimo, numero_parcela)
);

ALTER TABLE multa COMMENT 'Tabela que armazena dados sobre as multas.';

ALTER TABLE multa MODIFY COLUMN cod_emprestimo INTEGER COMMENT 'PFK da tabela parcela. Código identificador do empréstimo.';

ALTER TABLE multa MODIFY COLUMN numero_parcela INTEGER COMMENT 'PFK da tabela parcela. Número da parcela.';

ALTER TABLE multa MODIFY COLUMN valor_multa DECIMAL(10, 2) COMMENT 'Valor da multa.';


CREATE TABLE juros (
                cod_emprestimo INT NOT NULL,
                numero_parcela INT NOT NULL,
                valor_juros DECIMAL(10,2) NOT NULL,
                PRIMARY KEY (cod_emprestimo, numero_parcela)
);

ALTER TABLE juros COMMENT 'Tabela que armazena dados sobre os juros.';

ALTER TABLE juros MODIFY COLUMN cod_emprestimo INTEGER COMMENT 'PFK da tabela parcela. Código identificador do empréstimo.';

ALTER TABLE juros MODIFY COLUMN numero_parcela INTEGER COMMENT 'PFK da tabela parcela. Número da parcela.';

ALTER TABLE juros MODIFY COLUMN valor_juros DECIMAL(10, 2) COMMENT 'Valor dos juros.';


CREATE TABLE pagamento (
                cod_emprestimo INT NOT NULL,
                numero_parcela INT NOT NULL,
                data_vencimento DATE NOT NULL,
                data_pagamento DATE NOT NULL,
                PRIMARY KEY (cod_emprestimo, numero_parcela)
);

ALTER TABLE pagamento COMMENT 'Tabela que armazena dados sobre as parcelas.';

ALTER TABLE pagamento MODIFY COLUMN cod_emprestimo INTEGER COMMENT 'PFK da tabela parcela. Código identificador do empréstimo.';

ALTER TABLE pagamento MODIFY COLUMN numero_parcela INTEGER COMMENT 'PFK da tabela. Número da parcela.';

ALTER TABLE pagamento MODIFY COLUMN data_vencimento DATE COMMENT 'Data de vencimento do pagamento do empréstimo.';

ALTER TABLE pagamento MODIFY COLUMN data_pagamento DATE COMMENT 'Data de pagamento do empréstimo.';


CREATE TABLE empregados (
                matricula INT NOT NULL,
                primeiro_nome VARCHAR(100) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(100) NOT NULL,
                salario DECIMAL(9,2) NOT NULL,
                cod_cargo INT NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_empregado CHAR(8) NOT NULL,
                cod_bairro INT NOT NULL,
                cod_cidade INT NOT NULL,
                uf CHAR(2) NOT NULL,
                matricula_gerente INT,
                PRIMARY KEY (matricula)
);

ALTER TABLE empregados COMMENT 'Tabela que contém os registros dos empregados.';

ALTER TABLE empregados MODIFY COLUMN matricula INTEGER COMMENT 'PK da tabela. Números únicos correspondes a matricula de cada empregado.';

ALTER TABLE empregados MODIFY COLUMN primeiro_nome VARCHAR(100) COMMENT 'Primeiro nome do empregado.';

ALTER TABLE empregados MODIFY COLUMN nome_meio CHAR(1) COMMENT 'Inicial do nome do meio do empregado.';

ALTER TABLE empregados MODIFY COLUMN ultimo_nome VARCHAR(100) COMMENT 'Último nome do empregado.';

ALTER TABLE empregados MODIFY COLUMN salario DECIMAL(9, 2) COMMENT 'Salário de cada empregado.';

ALTER TABLE empregados MODIFY COLUMN cod_cargo INTEGER COMMENT 'FK da tabela cargo. Código identificador de cada cargo.';

ALTER TABLE empregados MODIFY COLUMN logradouro VARCHAR(150) COMMENT 'Logradouro do empregado.';

ALTER TABLE empregados MODIFY COLUMN numero_log VARCHAR(10) COMMENT 'Número do logradouro.';

ALTER TABLE empregados MODIFY COLUMN complemento_end VARCHAR(150) COMMENT 'Complemento do endereço.';

ALTER TABLE empregados MODIFY COLUMN cep_empregado CHAR(8) COMMENT 'FK da tabela cep. CEP do endereço.';

ALTER TABLE empregados MODIFY COLUMN cod_bairro INTEGER COMMENT 'FK da tabela bairro. Código identificador do bairro.';

ALTER TABLE empregados MODIFY COLUMN cod_cidade INTEGER COMMENT 'FK da tabela cidade. Código identificador da cidade.';

ALTER TABLE empregados MODIFY COLUMN uf CHAR(2) COMMENT 'FK da tabela uf. Sigla da UF.';

ALTER TABLE empregados MODIFY COLUMN matricula_gerente INTEGER COMMENT 'FK da tabela empregados (relação interna). Número único correspondes a matricula do gerente de cada empregado.';


CREATE TABLE banco (
                num_banco CHAR(3) NOT NULL,
                cnpj CHAR(14) NOT NULL,
                razao_social VARCHAR(100) NOT NULL,
                site_banco VARCHAR(200) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_banco CHAR(8) NOT NULL,
                cod_bairro INT NOT NULL,
                cod_cidade INT NOT NULL,
                uf CHAR(2) NOT NULL,
                PRIMARY KEY (num_banco, cnpj)
);

ALTER TABLE banco COMMENT 'Tabela que armazena os dados das sedes dos bancos .';

ALTER TABLE banco MODIFY COLUMN num_banco CHAR(3) COMMENT 'PK da tabela. Número identificador do banco, composto por 3 dígitos numéricos.';

ALTER TABLE banco MODIFY COLUMN cnpj CHAR(14) COMMENT 'PK da tabela. CNPJ do banco.';

ALTER TABLE banco MODIFY COLUMN razao_social VARCHAR(100) COMMENT 'Razão social (nome) do banco.';

ALTER TABLE banco MODIFY COLUMN site_banco VARCHAR(200) COMMENT 'Site do banco.';

ALTER TABLE banco MODIFY COLUMN logradouro VARCHAR(150) COMMENT 'Logradouro do banco.';

ALTER TABLE banco MODIFY COLUMN numero_log VARCHAR(10) COMMENT 'Número do logradouro.';

ALTER TABLE banco MODIFY COLUMN complemento_end VARCHAR(150) COMMENT 'Complemento do endereço.';

ALTER TABLE banco MODIFY COLUMN cep_banco CHAR(8) COMMENT 'FK da tabela cep. CEP do endereço.';

ALTER TABLE banco MODIFY COLUMN cod_bairro INTEGER COMMENT 'FK da tabela bairro. Código identificador do bairro.';

ALTER TABLE banco MODIFY COLUMN cod_cidade INTEGER COMMENT 'FK da tabela cidade. Código identificador da cidade.';

ALTER TABLE banco MODIFY COLUMN uf CHAR(2) COMMENT 'FK da tabela uf. Sigla da UF.';


CREATE TABLE agencias (
                numero_agencia INT NOT NULL,
                num_banco CHAR(3) NOT NULL,
                nome_agencia VARCHAR(100) NOT NULL,
                logradouro VARCHAR(150) NOT NULL,
                numero_log VARCHAR(10) NOT NULL,
                complemento_end VARCHAR(150),
                cep_agencia CHAR(8) NOT NULL,
                cod_bairro INT NOT NULL,
                cod_cidade INT NOT NULL,
                uf CHAR(2) NOT NULL,
                cnpj_sede CHAR(14) NOT NULL,
                PRIMARY KEY (numero_agencia, num_banco)
);

ALTER TABLE agencias COMMENT 'Tabela que armazena os dados das agências bancárias.';

ALTER TABLE agencias MODIFY COLUMN numero_agencia INTEGER COMMENT 'PK da tabela. Número da agência.';

ALTER TABLE agencias MODIFY COLUMN num_banco CHAR(3) COMMENT 'PFK da tabela banco. Número identificador do banco, composto por 3 dígitos numéricos.';

ALTER TABLE agencias MODIFY COLUMN nome_agencia VARCHAR(100) COMMENT 'Nome da agência';

ALTER TABLE agencias MODIFY COLUMN logradouro VARCHAR(150) COMMENT 'Logradouro da agência.';

ALTER TABLE agencias MODIFY COLUMN numero_log VARCHAR(10) COMMENT 'Número do logradouro.';

ALTER TABLE agencias MODIFY COLUMN complemento_end VARCHAR(150) COMMENT 'Complemento do endereço.';

ALTER TABLE agencias MODIFY COLUMN cep_agencia CHAR(8) COMMENT 'FK da tabela cep. CEP do endereço.';

ALTER TABLE agencias MODIFY COLUMN cod_bairro INTEGER COMMENT 'FK da tabela bairro. Código identificador do bairro.';

ALTER TABLE agencias MODIFY COLUMN cod_cidade INTEGER COMMENT 'FK da tabela cidade. Código identificador da cidade.';

ALTER TABLE agencias MODIFY COLUMN uf CHAR(2) COMMENT 'FK da tabela uf. Sigla da UF.';

ALTER TABLE agencias MODIFY COLUMN cnpj_sede CHAR(14) COMMENT 'FK da tabela banco. CNPJ da sede do banco.';


CREATE TABLE agencias_servico (
                numero_agencia INT NOT NULL,
                num_banco CHAR(3) NOT NULL,
                cod_servico INT NOT NULL,
                PRIMARY KEY (numero_agencia, num_banco, cod_servico)
);

ALTER TABLE agencias_servico COMMENT 'Tabela intermediária entre agências e serviços.';

ALTER TABLE agencias_servico MODIFY COLUMN numero_agencia INTEGER COMMENT 'PFK da tabela agencia. Número da agência.';

ALTER TABLE agencias_servico MODIFY COLUMN num_banco CHAR(3) COMMENT 'PFK da tabela agencia. Número identificador do banco, composto por 3 dígitos numéricos.';

ALTER TABLE agencias_servico MODIFY COLUMN cod_servico INTEGER COMMENT 'PFK da tabela. Código de referencia do serviço.';


CREATE TABLE lotacoes (
                matricula INT NOT NULL,
                numero_agencia INT NOT NULL,
                num_banco CHAR(3) NOT NULL,
                funcao_desempenhada VARCHAR(100) NOT NULL,
                dias_tralhados DATE NOT NULL,
                horas_trabalhadas VARCHAR NOT NULL,
                PRIMARY KEY (matricula, numero_agencia, num_banco)
);

ALTER TABLE lotacoes COMMENT 'Tabela N:N que irá armazenar a função desempenhada, dias de trabalho e os horários de trabalho.';

ALTER TABLE lotacoes MODIFY COLUMN matricula INTEGER COMMENT 'FK da tabela empregados. Por se tratar de uma tabela N:N essa FK serve para ligar a tabela empregados com a tabela agências.';

ALTER TABLE lotacoes MODIFY COLUMN numero_agencia INTEGER COMMENT 'PFK da tabela agencias. Número da agência.';

ALTER TABLE lotacoes MODIFY COLUMN num_banco CHAR(3) COMMENT 'PFK da tabela agencias. Número identificador do banco, composto por 3 dígitos numéricos.';

ALTER TABLE lotacoes MODIFY COLUMN funcao_desempenhada VARCHAR(100) COMMENT 'Função que o empregado irá desempenhar dentro do banco.';

ALTER TABLE lotacoes MODIFY COLUMN dias_tralhados DATE COMMENT 'Dias trabalhados por cada empregado.';

ALTER TABLE lotacoes MODIFY COLUMN horas_trabalhadas VARCHAR COMMENT 'Quantidade de horas trabalhadas por cada empregado.';


CREATE TABLE telefone_agencia (
                tel_agencia VARCHAR(11) NOT NULL,
                numero_agencia INT NOT NULL,
                num_banco CHAR NOT NULL,
                PRIMARY KEY (tel_agencia, numero_agencia, num_banco)
);

ALTER TABLE telefone_agencia COMMENT 'Tabela que armazena o telefone das agências.';

ALTER TABLE telefone_agencia MODIFY COLUMN tel_agencia VARCHAR(11) COMMENT 'PK da tabela. DDD + Número de telefone da agência.';

ALTER TABLE telefone_agencia MODIFY COLUMN numero_agencia INTEGER COMMENT 'PFK da tabela agencia. Número da agência.';

ALTER TABLE telefone_agencia MODIFY COLUMN num_banco CHAR COMMENT 'PFK da tabela agencia. Número identificador do banco, composto por 3 dígitos numéricos.';


CREATE TABLE telefone_banco (
                numero_tel CHAR(11) NOT NULL,
                num_banco CHAR(3) NOT NULL,
                cnpj CHAR(14) NOT NULL,
                PRIMARY KEY (numero_tel, num_banco, cnpj)
);

ALTER TABLE telefone_banco COMMENT 'Tabela que armazena os telefones dos bancos.';

ALTER TABLE telefone_banco MODIFY COLUMN numero_tel CHAR(11) COMMENT 'PK da tabela. DDD + Número de telefone do banco.';

ALTER TABLE telefone_banco MODIFY COLUMN num_banco CHAR(3) COMMENT 'PFK da tabela banco. Número identificador do banco, composto por 3 dígitos numéricos.';

ALTER TABLE telefone_banco MODIFY COLUMN cnpj CHAR(14) COMMENT 'PFK da tabela banco. CNPJ do banco.';


ALTER TABLE contratos ADD CONSTRAINT servicos_contratos_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico ADD CONSTRAINT servicos_historico_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias_servico ADD CONSTRAINT servicos_agencia_servico_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cliente_servicos ADD CONSTRAINT servicos_cliente_servicos_fk
FOREIGN KEY (cod_servico)
REFERENCES servicos (cod_servico)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cargo_empregados_fk
FOREIGN KEY (cod_cargo)
REFERENCES cargo (cod_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE banco ADD CONSTRAINT uf_banco_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT uf_empregados_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cliente ADD CONSTRAINT uf_cliente_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias ADD CONSTRAINT uf_agencias_fk
FOREIGN KEY (uf)
REFERENCES uf (uf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE banco ADD CONSTRAINT bairro_banco_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias ADD CONSTRAINT bairro_agencias_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT bairro_empregados_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cliente ADD CONSTRAINT bairro_cliente_fk
FOREIGN KEY (cod_bairro)
REFERENCES bairro (cod_bairro)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE banco ADD CONSTRAINT endereco_banco_fk
FOREIGN KEY (cep_banco)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias ADD CONSTRAINT cep_agencias_fk
FOREIGN KEY (cep_agencia)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cep_empregados_fk
FOREIGN KEY (cep_empregado)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cliente ADD CONSTRAINT cep_cliente_fk
FOREIGN KEY (cep_cliente)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE banco ADD CONSTRAINT cidade_banco_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias ADD CONSTRAINT cidade_agencias_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT cidade_empregados_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cliente ADD CONSTRAINT cidade_cliente_fk
FOREIGN KEY (cod_cidade)
REFERENCES cidade (cod_cidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE emprestimo ADD CONSTRAINT cliente_emprestimo_fk
FOREIGN KEY (cod_cliente)
REFERENCES cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE contas ADD CONSTRAINT cliente_contas_fk
FOREIGN KEY (cod_cliente)
REFERENCES cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cliente_servicos ADD CONSTRAINT cliente_cliente_servicos_fk
FOREIGN KEY (cod_cliente)
REFERENCES cliente (cod_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE historico ADD CONSTRAINT contas_historico_fk
FOREIGN KEY (numero_conta)
REFERENCES contas (numero_conta)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE parcela ADD CONSTRAINT emprestimo_parcela_fk
FOREIGN KEY (cod_emprestimo)
REFERENCES emprestimo (cod_emprestimo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pagamento ADD CONSTRAINT parcela_pagamento_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE juros ADD CONSTRAINT parcela_juros_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE multa ADD CONSTRAINT parcela_multa_fk
FOREIGN KEY (cod_emprestimo, numero_parcela)
REFERENCES parcela (cod_emprestimo, numero_parcela)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE lotacoes ADD CONSTRAINT empregados_lotacoes_fk
FOREIGN KEY (matricula)
REFERENCES empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE empregados ADD CONSTRAINT empregados_empregados_fk
FOREIGN KEY (matricula_gerente)
REFERENCES empregados (matricula)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE telefone_banco ADD CONSTRAINT banco_telefone_banco_fk
FOREIGN KEY (num_banco, cnpj)
REFERENCES banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias ADD CONSTRAINT banco_agencias_fk
FOREIGN KEY (num_banco, cnpj_sede)
REFERENCES banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE raz_soc_banco ADD CONSTRAINT banco_raz_soc_banco_fk
FOREIGN KEY (num_banco, cnpj)
REFERENCES banco (num_banco, cnpj)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE telefone_agencia ADD CONSTRAINT agencias_telefone_agencia_fk
FOREIGN KEY (num_banco, numero_agencia)
REFERENCES agencias (num_banco, numero_agencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE lotacoes ADD CONSTRAINT agencias_lotacoes_fk
FOREIGN KEY (num_banco, numero_agencia)
REFERENCES agencias (num_banco, numero_agencia)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE agencias_servico ADD CONSTRAINT agencias_agencia_servico_fk
FOREIGN KEY (numero_agencia, num_banco)
REFERENCES agencias (numero_agencia, num_banco)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

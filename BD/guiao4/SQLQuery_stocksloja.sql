CREATE SCHEMA stocks_loja;
GO


CREATE TABLE stocks_loja.tipo_fornecedor(
	codigo_interno INT NOT NULL PRIMARY KEY,
	designaçao VARCHAR(20)

);

CREATE TABLE stocks_loja.fornecedor(
	NIF INT NOT NULL PRIMARY KEY,
	nome VARCHAR(20),
	endereço VARCHAR(30),
	fax INT NOT NULL,
	codigo_tipo_fornecedor INT NOT NULL REFERENCES stocks_loja.tipo_fornecedor(codigo_interno)

);
CREATE TABLE stocks_loja.condicoes_pagamento(
	NIF INT NOT NULL REFERENCES stocks_loja.fornecedor(NIF),
	condicoes_pagament VARCHAR(20),
	PRIMARY KEY(NIF)

);

CREATE TABLE stocks_loja.encomenda(
	n_encomenda INT	  NOT NULL PRIMARY KEY,
	NIF_fornecedor INT NOT NULL REFERENCES stocks_loja.fornecedor(NIF),
	data_encomenda VARCHAR(30),
);

CREATE TABLE stocks_loja.produto(
	Nome	VARCHAR(30),
	Codigo  INT NOT NULL PRIMARY KEY,
	taxa_iva FLOAT,
	preço   FLOAT,
	quantidade INT NOT NULL,
	numero_enc INT NOT NULL REFERENCES stocks_loja.encomenda(n_encomenda),
);

CREATE TABLE stocks_loja.taxa(
	codigo_interno INT NOT NULL REFERENCES stocks_loja.produto(Codigo),
	taxa FLOAT NOT NULL,
	PRIMARY KEY(codigo_interno)
);

CREATE TABLE stocks_loja.contem(
	n_encomenda INT NOT NULL REFERENCES stocks_loja.encomenda(n_encomenda),
	codigo INT NOT NULL REFERENCES stocks_loja.produto(Codigo),
	PRIMARY KEY(n_encomenda,codigo)

);
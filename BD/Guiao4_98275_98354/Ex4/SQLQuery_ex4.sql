
CREATE SCHEMA PEM
GO


CREATE TABLE PEM.medico(
	ID				INT		PRIMARY KEY	NOT NULL CHECK (ID > 0),
	Nome			VARCHAR(30)	NOT NULL,
	Especialidade	VARCHAR(30) NOT NULL
);


CREATE TABLE PEM.farmacia(
	Nome				VARCHAR(10)	NOT NULL,
	NIF					INT			PRIMARY KEY		NOT NULL CHECK (NIF > 0 AND NIF < 999999999),
	Telefone			CHAR(9)		NOT NULL,
	Endereco			VARCHAR(30)	NOT NULL
);


CREATE TABLE PEM.paciente(
	N_utente	INT		PRIMARY KEY NOT NULL	CHECK (N_utente > 0 AND N_utente < 999999999),
	Nome		VARCHAR(30)		NOT NULL,
	Nascimento	DATE			NOT NULL,
	Endereco	VARCHAR(30)
);


CREATE TABLE PEM.prescricao(
	N_unico		INT		PRIMARY KEY		NOT NULL CHECK (N_unico > 0),
	Data1		DATE	NOT NULL,
	Num_utente	INT		REFERENCES PEM.paciente(N_utente) NOT NULL,
	Num_id		INT		REFERENCES PEM.medico(ID)	NOT NULL,
	NIF			INT		REFERENCES PEM.farmacia(NIF) NOT NULL
);

CREATE TABLE PEM.farmaceutica(
	Num_reg		INT		PRIMARY KEY	NOT NULL CHECK (Num_reg > 0),
	Nome		VARCHAR(30)	NOT NULL,	
	Telefone	CHAR(9) NOT NULL,
	Endereco	VARCHAR(35)
);


CREATE TABLE PEM.farmaco(
	Nome			VARCHAR(30)	PRIMARY KEY NOT NULL,
	Formula			VARCHAR(40) NOT NULL,
	Numero_registo	INT		REFERENCES PEM.farmaceutica(Num_reg) NOT NULL CHECK (Numero_registo > 0),
);

CREATE TABLE PEM.vendido(
	Nome_comercial	VARCHAR(30)		REFERENCES PEM.farmaco(Nome) NOT NULL,
	NIF				INT				REFERENCES PEM.farmacia(NIF) NOT NULL CHECK (NIF > 0 AND NIF < 999999999),
	PRIMARY KEY(Nome_comercial,NIF)
);

CREATE TABLE PEM.envolve(
	Num_unico		INT				REFERENCES PEM.prescricao(N_unico)		NOT NULL CHECK (Num_unico > 0),
	Nome_comercial	VARCHAR(30)		REFERENCES PEM.farmaco(Nome)	NOT NULL,
	PRIMARY KEY(Num_unico,Nome_comercial)
);

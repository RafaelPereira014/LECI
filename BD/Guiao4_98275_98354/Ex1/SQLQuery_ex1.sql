CREATE SCHEMA rentacar
GO

create table rentacar.balcao(
	Endereço		VARCHAR(30)	NOT NULL,
	Numero			INT			PRIMARY KEY		NOT NULL,
	Nome			VARCHAR(30)	NOT NULL
);

create table rentacar.cliente(
	Nome			VARCHAR(50) NOT NULL,
	Endereço		VARCHAR(50),
	Num_carta		INT			UNIQUE NOT NULL,
	NIF				INT			PRIMARY KEY		NOT NULL		
);


create table rentacar.tipo_veiculo(
	codigo		INT		PRIMARY KEY		NOT NULL,
	Designação	VARCHAR(20), 
	A_C			BIT
);

create table rentacar.veiculo(
	ano					CHAR(4),
	marca				VARCHAR(20) NOT NULL,
	matricula			CHAR(6)		PRIMARY KEY		NOT NULL,
	codigo_tipo_veiculo INT		REFERENCES	rentacar.tipo_veiculo(codigo)
);


create table rentacar.aluguer(
	data	DATE NOT NULL,
	numero	INT		PRIMARY KEY		NOT NULL,
	duracao	TIME NOT NULL,
	NIF_cliente			INT			REFERENCES rentacar.cliente(NIF) NOT NULL,
	numero_balcao		INT			REFERENCES rentacar.balcao(Numero),
	matricula_veiculo	CHAR(6)		REFERENCES rentacar.veiculo(matricula) NOT NULL
);

create table rentacar.ligeiro(
	numero_lugares			INT	NOT NULL,
	portas					INT NOT NULL,
	combustivel				VARCHAR(10),
	codigo_tipo_veiculo		INT		PRIMARY KEY		NOT NULL	REFERENCES rentacar.tipo_veiculo(codigo)
);

create table rentacar.pesado(
	peso			INT NOT NULL,
	passageiros		INT,
	codigo_tipo_veiculo		INT PRIMARY KEY			NOT NULL	REFERENCES rentacar.tipo_veiculo(Codigo)
);

create table rentacar.similaridade(
	codigo_1	INT		REFERENCES rentacar.tipo_veiculo(codigo)	NOT NULL,
	codigo_2	INT		REFERENCES rentacar.tipo_veiculo(codigo) NOT NULL,
	PRIMARY KEY(codigo_1,codigo_2)
);
